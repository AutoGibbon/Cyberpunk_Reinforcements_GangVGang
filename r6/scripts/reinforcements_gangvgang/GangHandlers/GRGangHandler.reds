module Gibbon.GR.GangHandlers

import Gibbon.GR.GangData.*
import Gibbon.GR.Settings.*
import Gibbon.GR.Logging.*
import Gibbon.GR.ReinforcementSystem.*

public abstract class GRGangHandler extends ScriptableSystem {
  protected let preventionSystem: ref<PreventionSystem>;
  protected let delaySystem: ref<DelaySystem>;
  protected let settings: ref<GRSettings>;
  protected let lastCaller: wref<NPCPuppet>;
  protected let lastTarget: wref<NPCPuppet>;
  protected let lastCallerPosition: Vector4;
  protected let reinforcementData: ref<GRGangData>;
  protected let heatLevel: Int32 = 0;
  protected let callsPerformed: Int32 = 0;
  protected let waveCounter: Int32 = 0;
  protected let waveCounterUniqueId: Int32 = 0;
  protected let heatResetCooldownActive: Bool = false;
  protected let callSuccessCooldownActive: Bool = false;
  protected let gracePeriodStarted: Bool = false;
  protected let gracePeriodEnded: Bool = false;
  protected let trafficSpawnDelayID: DelayID;

  public let isDisabled: Bool = false;
  public let affiliation: gamedataAffiliation;
  public let lastCallAnswered: Bool = true;

  public func GetCallSuccessCooldown() -> Float {
    return RandRangeF(this.settings.callSuccessCooldownMin, this.settings.callSuccessCooldownMax);
  }

  public func GetHeatResetCooldown() -> Float {
    return this.settings.heatResetCooldown;
  }

  // TO IMPLEMENT
  public func OnHeatResetCooldownStart() -> Void;

  public func OnCallSuccessCooldownStart() -> Void;

  public func OnCallSuccessDelayArrival(isTurf: Bool) -> Void;

  public func OnGraceStart() -> Void;

  public func GetTurfList() -> array<String>;

  // TO IMPLEMENT 
  public func GetLastCaller() -> wref<NPCPuppet> {
    return this.lastCaller;
  }

  public func GetLastCallerPosition() -> Vector4 {
    return this.lastCallerPosition;
  }

  public func GetLastTarget() -> wref<NPCPuppet> {
    return this.lastTarget;
  }

  public func OnHeatResetCooldownEnd() -> Void {
    this.heatResetCooldownActive = false;
    this.heatLevel = 0;
    this.callsPerformed = 0;
    this.waveCounter = 0;
    this.gracePeriodEnded = false;
    this.gracePeriodStarted = false;
    this.callSuccessCooldownActive = false;
    this.lastCaller = null;
    this.lastTarget = null;
	this.lastCallAnswered = true;
    Vector4.Zero(this.lastCallerPosition);
  }

  public func OnCallSuccessCooldownEnd() -> Void {
    this.callSuccessCooldownActive = false;
  }

  public func OnGraceEnd() -> Void {
    this.gracePeriodEnded = true;
    this.gracePeriodStarted = false;
  }

  public func GetGraceTime() -> Float {
    //GRLog(s"\(this.affiliation), Grace min: \(this.settings.gracePeriodMin), max: \(this.settings.gracePeriodMax)");
    return RandRangeF(this.settings.gracePeriodMin, this.settings.gracePeriodMax);
  }

  public func GetBackupDelay(isTurf: Bool) -> Float {
    let baseDelay = RandRangeF(this.settings.backupDelayMin, this.settings.backupDelayMax);
    return isTurf ? MaxF(1.0, baseDelay - this.settings.turfDelayReduction) : baseDelay;
  }

  public func IsConsideredTurf(district: ref<District>) -> Bool {
    let record = district.GetDistrictRecord();
    let turfList = this.GetTurfList();

    while IsDefined(record.ParentDistrict()) {
      if ArrayContains(turfList, record.EnumName()) {
        return true;
      }
      record = record.ParentDistrict();
    }

    return ArrayContains(turfList, record.EnumName());
  }

  public func HandleReinforcementCall(puppet: ref<NPCPuppet>, target: ref<NPCPuppet>) {
    if this.callSuccessCooldownActive {
      return;
    }
    let isTurf = this.IsConsideredTurf(this.preventionSystem.GetCurrentDistrict());

    if this.heatLevel == 0 {
      this.heatLevel = this.settings.initialHeat;
    } else if this.lastCallAnswered {
      this.heatLevel += this.settings.heatEscalation;
      if isTurf {
        this.heatLevel += this.settings.turfHeatBonus;
      }
    }

    this.callSuccessCooldownActive = true;
    this.OnCallSuccessCooldownStart();

    this.lastCaller = puppet;
    this.lastCallerPosition = puppet.GetWorldPosition();
    this.lastTarget = target;

    if this.lastCallAnswered {
      this.callsPerformed += 1;
	  GRLog(s"Backup call started: \(this.affiliation), \(this.heatLevel)");
      this.OnCallSuccessDelayArrival(isTurf);
    }
  }

  public func CompleteReinforcementCall() -> Void {
    let randomNumber = RandRange(0, 101);
    let reinforcementHeat = randomNumber <= this.settings.strongCallChance ? this.heatLevel + this.settings.strongCallHeatBonus : this.heatLevel;

    GRLog(s"Reinforcements arrive: \(this.affiliation), \(reinforcementHeat), Target: \(TDBID.ToStringDEBUG(GameObject.GetTDBID(this.lastTarget)))");
    this
      .SpawnVehicles(
        this
          .reinforcementData
          .GetReinforcementsClamped(Min(reinforcementHeat, 20), this.settings.maxVehiclesPerCall)
      );

    if this.callsPerformed > this.settings.callsLimit {
      this.heatResetCooldownActive = true;
      this.OnHeatResetCooldownStart();
    }
  }

  public func TryCallingReinforcements(puppet: ref<ScriptedPuppet>) -> Bool {
    if this.isDisabled {
      return false;
    }

    if !this.gracePeriodEnded {
      if this.gracePeriodStarted {
        return false;
      } else {
        this.gracePeriodStarted = true;
        this.OnGraceStart();
        return false;
      }
    }

    if !this.heatResetCooldownActive && !this.callSuccessCooldownActive {
      return true;
    }

    return false;
  }

  public func SpawnVehicles(arr: array<TweakDBID>) -> Void {
    let node = new questDynamicSpawnSystemNodeDefinition();
    let nodeType = new questDynamicVehicleSpawn_NodeType();

    nodeType.distanceRange = new Vector2(100, 100);

    if RandF() >= 0.5 {
      nodeType.spawnDirectionPreference = questSpawnDirectionPreference.InFront;
    } else {
      nodeType.spawnDirectionPreference = questSpawnDirectionPreference.Behind;
    }

    let tagStr: String = s"GR_\(this.affiliation)_\(this.waveCounter)";
    nodeType.waveTag = StringToName(tagStr);
    nodeType.VehicleData = arr;

    this.waveCounter += 1;
    node.id = Cast<Uint16>(this.waveCounterUniqueId + this.waveCounter);
    node.type = nodeType;

    GameInstance.GetQuestsSystem(GetGameInstance()).ExecuteNode(node);
    this.lastCallAnswered = false;
  }

  public func SpawnTrafficVehicles() -> Void {
	// only ask for traffic if the primary reinforcement logic is not currently "active" for the given gang
	if(this.IsConsideredTurf(this.preventionSystem.GetCurrentDistrict())
	&& this.lastCallAnswered
	&& !this.callSuccessCooldownActive
	&& !this.gracePeriodStarted
	) {
		GRReinforcementSystem.GetInstance(GetGameInstance()).RequestSpawnTraffic(this.reinforcementData.GetTrafficSpawns());
	}
  }
}

