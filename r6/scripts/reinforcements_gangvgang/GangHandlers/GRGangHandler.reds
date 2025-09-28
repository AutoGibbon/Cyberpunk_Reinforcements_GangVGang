module Gibbon.GR.GangHandlers

import Gibbon.GR.GangData.*
import Gibbon.GR.Settings.*
import Gibbon.GR.Logging.*
import Gibbon.GR.ReinforcementSystem.*

public abstract class GRGangHandler extends ScriptableSystem {

  //locks
  private let m_trafficRequestLock: RWLock;
  private let m_lastCallAnsweredLock: RWLock;
  private let m_lastCallDataLock: RWLock;

  protected let m_hasTrafficRequest: Bool = false;
  protected let m_preventionSystem: ref<PreventionSystem>;
  protected let m_delaySystem: ref<DelaySystem>;
  protected let m_settings: ref<GRSettings>;
  protected let m_lastCaller: wref<NPCPuppet>;
  protected let m_lastTarget: wref<NPCPuppet>;
  protected let m_lastCallerPosition: Vector4;
  protected let m_reinforcementData: ref<GRGangData>;
  protected let m_heatLevel: Int32 = 0;
  protected let m_callsPerformed: Int32 = 0;
  protected let m_waveCounter: Int32 = 0;
  protected let m_waveCounterUniqueId: Int32 = 0;
  protected let m_heatResetCooldownActive: Bool = false;
  protected let m_callSuccessCooldownActive: Bool = false;
  protected let m_gracePeriodStarted: Bool = false;
  protected let m_gracePeriodEnded: Bool = false;
  protected let m_backupDelayActive: Bool = false;

  protected let m_isDisabled: Bool = false;
  protected let m_affiliation: gamedataAffiliation;
  protected let m_lastCallAnswered: Bool = true;

  public func GetCallSuccessCooldown() -> Float {
    return RandRangeF(this.m_settings.GetCallSuccessCooldownMin(), this.m_settings.GetCallSuccessCooldownMax());
  }

  public func GetHeatResetCooldown() -> Float {
    return this.m_settings.GetHeatResetCooldown();
  }

  // ABSTRACT METHODS
  public func OnHeatResetCooldownStart() -> Void;

  public func OnCallSuccessCooldownStart() -> Void;

  public func OnCallSuccessDelayArrival(isTurf: Bool) -> Void;

  public func OnGraceStart() -> Void;

  public func GetTurfList() -> array<String>;

  public func GetLastCaller() -> wref<NPCPuppet> {
    let result: wref<NPCPuppet>;
    RWLock.AcquireShared(this.m_lastCallDataLock);
    result = this.m_lastCaller;
    RWLock.ReleaseShared(this.m_lastCallDataLock);
    return result;
  }

  public func GetLastCallerPosition() -> Vector4 {
    let result: Vector4;
    RWLock.AcquireShared(this.m_lastCallDataLock);
    result = this.m_lastCallerPosition;
    RWLock.ReleaseShared(this.m_lastCallDataLock);
    return result;
  }

  public func GetLastTarget() -> wref<NPCPuppet> {
    let result: wref<NPCPuppet>;
    RWLock.AcquireShared(this.m_lastCallDataLock);
    result = this.m_lastTarget;
    RWLock.ReleaseShared(this.m_lastCallDataLock);
    return result;
  }
  
  public func GetHasTrafficRequest() -> Bool {
    let result: Bool;
    RWLock.AcquireShared(this.m_trafficRequestLock);
    result = this.m_hasTrafficRequest;
    RWLock.ReleaseShared(this.m_trafficRequestLock);
    return result;
  }

  public func SetHasTrafficRequest(hasTrafficRequest: Bool) -> Void {
    RWLock.Acquire(this.m_trafficRequestLock);
    this.m_hasTrafficRequest = hasTrafficRequest;
    RWLock.Release(this.m_trafficRequestLock);
  }

  public func GetLastCallAnswered() -> Bool {
    let result: Bool;
    RWLock.AcquireShared(this.m_lastCallAnsweredLock);
    result = this.m_lastCallAnswered;
    RWLock.ReleaseShared(this.m_lastCallAnsweredLock);
    return result;
  }

  public func SetLastCallAnswered(lastCallAnswered: Bool) -> Void {
    RWLock.Acquire(this.m_lastCallAnsweredLock);
    this.m_lastCallAnswered = lastCallAnswered;
    RWLock.Release(this.m_lastCallAnsweredLock);
  }

  public func GetAffiliation() -> gamedataAffiliation {
    return this.m_affiliation;
  }

  public func SetIsDisabled(isDisabled: Bool) -> Void {
    this.m_isDisabled = isDisabled;
  }

  public func OnHeatResetCooldownEnd() -> Void {
    this.m_heatResetCooldownActive = false;
    this.m_heatLevel = 0;
    this.m_callsPerformed = 0;
    this.m_waveCounter = 0;
    this.m_gracePeriodEnded = false;
    this.m_gracePeriodStarted = false;
    this.m_callSuccessCooldownActive = false;
    RWLock.Acquire(this.m_lastCallDataLock);
    this.m_lastCaller = null;
    this.m_lastTarget = null;
    RWLock.Release(this.m_lastCallDataLock);
	RWLock.Acquire(this.m_lastCallAnsweredLock);
	this.m_lastCallAnswered = true;
	RWLock.Release(this.m_lastCallAnsweredLock);
    Vector4.Zero(this.m_lastCallerPosition);
  }

  public func OnCallSuccessCooldownEnd() -> Void {
    this.m_callSuccessCooldownActive = false;
  }

  public func OnGraceEnd() -> Void {
    this.m_gracePeriodEnded = true;
    this.m_gracePeriodStarted = false;
  }

  public func GetGraceTime() -> Float {
    return RandRangeF(this.m_settings.GetGracePeriodMin(), this.m_settings.GetGracePeriodMax());
  }

  public func GetBackupDelay(isTurf: Bool) -> Float {
    let baseDelay = RandRangeF(this.m_settings.GetBackupDelayMin(), this.m_settings.GetBackupDelayMax());
	GRLog(s"Backup delay: \(baseDelay), Turf: \(isTurf), reduction: \(this.m_settings.GetTurfDelayReduction())");
    return isTurf ? MaxF(1.0, baseDelay - this.m_settings.GetTurfDelayReduction()) : baseDelay;
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
    if this.m_callSuccessCooldownActive {
      return;
    }
    let isTurf = this.IsConsideredTurf(this.m_preventionSystem.GetCurrentDistrict());

    if this.m_heatLevel == 0 {
      this.m_heatLevel = this.m_settings.GetInitialHeat();
    } else if this.GetLastCallAnswered() && !this.m_backupDelayActive{
      this.m_heatLevel += this.m_settings.GetHeatEscalation();
      if isTurf {
        this.m_heatLevel += this.m_settings.GetTurfHeatBonus();
      }
    }

    this.m_callSuccessCooldownActive = true;
    this.OnCallSuccessCooldownStart();

    RWLock.Acquire(this.m_lastCallDataLock);
    this.m_lastCaller = puppet;
    this.m_lastCallerPosition = puppet.GetWorldPosition();
    this.m_lastTarget = target;
    RWLock.Release(this.m_lastCallDataLock);

    if this.GetLastCallAnswered() {
      this.m_callsPerformed += 1;
	}
	if !this.m_backupDelayActive {
		this.m_backupDelayActive = true;
		GRLog(s"Backup call started: \(this.m_affiliation), \(this.m_heatLevel)");
		this.OnCallSuccessDelayArrival(isTurf);
	}
  }

  public func CompleteReinforcementCall() -> Void {
    let randomNumber = RandRange(0, 101);
    let reinforcementHeat = randomNumber <= this.m_settings.GetStrongCallChance() ? this.m_heatLevel + this.m_settings.GetStrongCallHeatBonus() : this.m_heatLevel;

    GRLog(s"Reinforcements arrive: \(this.m_affiliation), \(reinforcementHeat), Target: \(TDBID.ToStringDEBUG(GameObject.GetTDBID(this.m_lastTarget)))");
    this
      .SpawnVehicles(
        this
          .m_reinforcementData
          .GetReinforcementsClamped(Min(reinforcementHeat, 20), this.m_settings.GetMaxVehiclesPerCall())
      );

    if this.m_callsPerformed > this.m_settings.GetCallsLimit() {
      this.m_heatResetCooldownActive = true;
      this.OnHeatResetCooldownStart();
    }
	this.m_backupDelayActive = false;
  }

  public func TryCallingReinforcements(puppet: ref<ScriptedPuppet>) -> Bool {
    if this.m_isDisabled {
      return false;
    }

    if !this.m_gracePeriodEnded {
      if this.m_gracePeriodStarted {
        return false;
      } else {
        this.m_gracePeriodStarted = true;
        this.OnGraceStart();
        return false;
      }
    }

    if !this.m_heatResetCooldownActive && !this.m_callSuccessCooldownActive {
      return true;
    }

    return false;
  }

  public func SpawnVehicles(arr: array<TweakDBID>) -> Void {
    let node = new questDynamicSpawnSystemNodeDefinition();
    let nodeType = new questDynamicVehicleSpawn_NodeType();

    nodeType.distanceRange = Vector2(100, 100);

    if RandF() >= 0.5 {
      nodeType.spawnDirectionPreference = questSpawnDirectionPreference.InFront;
    } else {
      nodeType.spawnDirectionPreference = questSpawnDirectionPreference.Behind;
    }

    let tagStr: String = s"GR_\(this.m_affiliation)_\(this.m_waveCounter)";
    nodeType.waveTag = StringToName(tagStr);
    nodeType.VehicleData = arr;
    
    this.m_waveCounter += 1;
    node.id = Cast<Uint16>(this.m_waveCounterUniqueId + this.m_waveCounter);
    node.type = nodeType;

    GameInstance.GetQuestsSystem(GetGameInstance()).ExecuteNode(node);
	
    RWLock.Acquire(this.m_lastCallAnsweredLock);
    this.m_lastCallAnswered = false;
    RWLock.Release(this.m_lastCallAnsweredLock);
  }

  public func SpawnTrafficVehicles() -> Void {
	// only ask for traffic if the primary reinforcement logic is not currently "active" for the given gang
	// cause dynamic spawn system is a little bitch "no too many spawns waa waa waa"
	//GRLog(s"SpawnTrafficVehicles: \(this.m_affiliation), last call answered: \(this.m_lastCallAnswered), is turf: \(this.m_preventionSystem.GetCurrentDistrict().GetDistrictRecord().EnumName())");
	if(this.IsConsideredTurf(this.m_preventionSystem.GetCurrentDistrict())
	&& this.GetLastCallAnswered()
	&& !this.m_backupDelayActive
	&& !this.m_heatResetCooldownActive
	&& !this.m_callSuccessCooldownActive
	) {
		//GRLog(s"Requesting traffic spawns: \(this.m_affiliation)");
		RWLock.Acquire(this.m_trafficRequestLock);
		this.m_hasTrafficRequest = true;
		RWLock.Release(this.m_trafficRequestLock);
		GRReinforcementSystem.GetInstance(GetGameInstance()).RequestSpawnTraffic(this.m_reinforcementData.GetTrafficSpawns());
	}
  }
}

