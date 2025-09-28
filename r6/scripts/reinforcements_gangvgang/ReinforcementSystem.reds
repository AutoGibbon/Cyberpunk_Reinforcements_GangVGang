module Gibbon.GR.ReinforcementSystem

import Gibbon.GR.GangHandlers.*
import Gibbon.GR.GangData.*
import Gibbon.GR.Settings.*
import Gibbon.GR.Logging.*

public class GRReinforcementSystem extends ScriptableSystem {
    private let m_tygerHandler: ref<GRTygersHandler>;
    private let m_scavHandler: ref<GRScavsHandler>;
    private let m_animalsHandler: ref<GRAnimalsHandler>;
    private let m_maelStormHandler: ref<GRMaelStromHandler>;
    private let m_arasakaHandler: ref<GRArasakaHandler>;
    private let m_voodooHandler: ref<GRVoodooHandler>;
    private let m_sixthHandler: ref<GRSixthStreetHandler>;
    private let m_militechHandler: ref<GRMilitechHandler>;
    private let m_valentinosHandler: ref<GRValentinosHandler>;
    private let m_barghestHandler: ref<GRBarghestHandler>;
    private let m_wraithsHandler: ref<GRWraithsHandler>;
    private let m_ncpdHandler: ref<GRNCPDHandler>;
    private let m_moxHandler: ref<GRMoxHandler>;
	private let m_gameAttachHandled: Bool = false;

    private let m_preventionSystem: ref<PreventionSystem>;
    private let m_questsSystem: ref<QuestsSystem>;
	private let m_delaySystem: ref<DelaySystem>;
	private let m_trafficSpawnDelayID: DelayID;
	private let m_trafficSpawnsStarted: Bool = false;

    public let m_settings: ref<GRSettings>;

	public func OnAttach() -> Void {
		this.m_gameAttachHandled = false;
	}

    public final func OnPlayerAttach(request: ref<PlayerAttachRequest>) -> Void {
        let theGame = GetGameInstance();
        this.m_preventionSystem = GameInstance.GetScriptableSystemsContainer(theGame).Get(n"PreventionSystem") as PreventionSystem;
        this.m_questsSystem = GameInstance.GetQuestsSystem(theGame);
		this.m_delaySystem = GameInstance.GetDelaySystem(theGame);

        this.m_settings = GRSettings.GetInstance(theGame);
        this.m_tygerHandler = GRTygersHandler.GetInstance(theGame);
        this.m_scavHandler = GRScavsHandler.GetInstance(theGame);
        this.m_animalsHandler = GRAnimalsHandler.GetInstance(theGame);
        this.m_maelStormHandler = GRMaelStromHandler.GetInstance(theGame);
        this.m_arasakaHandler = GRArasakaHandler.GetInstance(theGame);
        this.m_voodooHandler = GRVoodooHandler.GetInstance(theGame);
        this.m_sixthHandler = GRSixthStreetHandler.GetInstance(theGame);
        this.m_militechHandler = GRMilitechHandler.GetInstance(theGame);
        this.m_valentinosHandler = GRValentinosHandler.GetInstance(theGame);
        this.m_barghestHandler = GRBarghestHandler.GetInstance(theGame);
        this.m_wraithsHandler = GRWraithsHandler.GetInstance(theGame);
        this.m_ncpdHandler = GRNCPDHandler.GetInstance(theGame);
        this.m_moxHandler = GRMoxHandler.GetInstance(theGame);
        //debugging
        // this.tygerHandler.SetIsDisabled(true);
        // this.scavHandler.SetIsDisabled(true);
        // this.animalsHandler.SetIsDisabled(true);
        // this.maelstromHandler.SetIsDisabled(true);
        // this.arasakaHandler.SetIsDisabled(true);
        // this.voodooHandler.SetIsDisabled(true);
        // this.sixthHandler.SetIsDisabled(true);
        // this.militechHandler.SetIsDisabled(true);
        // this.valentinosHandler.SetIsDisabled(true);
        // this.barghestHandler.SetIsDisabled(true);
        // this.wraithsHandler.SetIsDisabled(true);
        // this.ncpdHandler.SetIsDisabled(true);

        // cause we're doing funky stuff with public and private bindings
        this.m_settings.ReconcileSettings();

		if !this.m_gameAttachHandled {
			this.HandleGameAttach();
		} else {
			this.ResetAllGangs();
			this.StartTrafficSpawns();
		}
    }

	public func OnRestored(saveVersion: Int32, gameVersion: Int32) {
		if !this.m_gameAttachHandled {
			this.HandleGameAttach();
		}
    }
  
	// player attached is the last thing to happen so don't do any work in here
	//just set the flag so we know game logic can be run in OnPlayerAttach
	public func HandleGameAttach() -> Void { 
		if GameInstance.GetSystemRequestsHandler().IsPreGame() {
			return;
		}
		this.m_gameAttachHandled = true;
	}

    public func ResetAllGangs() -> Void {
        this.m_tygerHandler.OnHeatResetCooldownEnd();
        this.m_scavHandler.OnHeatResetCooldownEnd();
        this.m_animalsHandler.OnHeatResetCooldownEnd();
        this.m_maelStormHandler.OnHeatResetCooldownEnd();
        this.m_arasakaHandler.OnHeatResetCooldownEnd();
        this.m_voodooHandler.OnHeatResetCooldownEnd();
        this.m_sixthHandler.OnHeatResetCooldownEnd();
        this.m_militechHandler.OnHeatResetCooldownEnd();
        this.m_valentinosHandler.OnHeatResetCooldownEnd();
        this.m_barghestHandler.OnHeatResetCooldownEnd();
        this.m_wraithsHandler.OnHeatResetCooldownEnd();
        this.m_ncpdHandler.OnHeatResetCooldownEnd();
        this.m_moxHandler.OnHeatResetCooldownEnd();
    }

    public static func GetInstance(gameInstance: GameInstance) -> ref<GRReinforcementSystem> {
        let system: ref<GRReinforcementSystem> = GameInstance.GetScriptableSystemsContainer(gameInstance).Get(n"Gibbon.GR.ReinforcementSystem.GRReinforcementSystem") as GRReinforcementSystem;
        return system;
    }

    public func ReinforcementsCalled(puppet: ref<ScriptedPuppet>, target: wref<GameObject>) -> Void {
        let distanceToPlayer = Vector4.Distance(puppet.GetWorldPosition(), GetPlayer(GetGameInstance()).GetWorldPosition());

        if distanceToPlayer > 50.0 {
            return;
        }

        let distanceToTarget = Vector4.Distance(puppet.GetWorldPosition(), target.GetWorldPosition());

        if distanceToTarget > 50.0 {
            return;
        }
        this.GetFactionHandler(puppet).HandleReinforcementCall(puppet as NPCPuppet, target as NPCPuppet);
    }

    private func ReinforcementsChecksCall(puppet: ref<ScriptedPuppet>, target: ref<GameObject>) -> Bool {
        let gi: GameInstance = puppet.GetGame();
        let player = GetPlayer(gi);

        if GameInstance
            .GetBlackboardSystem(gi)
            .GetLocalInstanced(player.GetEntityID(), GetAllBlackboardDefs().PlayerStateMachine)
            .GetInt(GetAllBlackboardDefs().PlayerStateMachine.SceneTier) > 1 {
            return false;
        }

        if !puppet.IsNPC() || !puppet.IsHuman() {
            return false;
        }

        if player.IsReplacer() || player.IsJohnnyReplacer() {
            return false;
        }

        //No aldecaldos
        if Equals(ToString((puppet as NPCPuppet).GetAffiliation()), "Aldecaldos") {
            return false;
        }

        //No vendors
        if puppet.IsVendor() {
            return false;
        }

        //No kids blackbeard
        if (puppet as NPCPuppet).GetRecord().IsChild() {
            return false;
        }

        if (puppet as NPCPuppet).GetRecord().TagsContains(n"Reinforcements.VoodooMerc") {
            return false;
        }

        if (puppet as NPCPuppet).GetRecord().TagsContains(n"NoReinforcements") {
            return false;
        }

        //Check if NPC is ragdolling
        if (puppet as NPCPuppet).m_isRagdolling {
            return false;
        }

        if !this.m_settings.GetEnabledWhenPlayerInCombat() && GetPlayer(puppet.GetGame()).IsInCombat() {
            return false;
        }

        if StatusEffectSystem.ObjectHasStatusEffect(GetPlayer(puppet.GetGame()), t"GameplayRestriction.FistFight") {
            return false;
        }

        let npcRarity = (puppet as NPCPuppet).GetNPCRarity();
        if Equals(npcRarity, gamedataNPCRarity.MaxTac) || Equals(npcRarity, gamedataNPCRarity.Boss) {
            return false;
        }

        let record = this.m_preventionSystem.GetCurrentDistrict().GetDistrictRecord();
        let nonoZones = [
            "LittleChina_Afterlife",
            "Dogtown_Akebono",
            "Northside_All_Foods",
            "CorpoPlaza_ArasakaTowerAtrium",
            "CorpoPlaza_ArasakaTowerCEOFloor",
            "CorpoPlaza_ArasakaTowerJenkins",
            "CorpoPlaza_ArasakaTowerJungle",
            "CorpoPlaza_ArasakaTowerLobby",
            "CorpoPlaza_ArasakaTowerNest",
            "CorpoPlaza_ArasakaTowerSaburoOffice",
            "CorpoPlaza_ArasakaTowerUnlistedFloors",
            "CorpoPlaza_ArasakaTowerUpperAtrium",
            "ArasakaWaterfront",
            "NorthOaks_Arasaka_Estate",
            "CharterHill_AuCabanon",
            "Coastview_BattysHotel",
            "Dogtown_Brooklyn",
            "Northside_CleanCut",
            "JapanTown_Clouds",
            "CorpoPlaza_Apartment",
            "Dogtown_Cynosure",
            "Vista_del_Rey_Delamain",
            "Dogtown_Expo",
            "JapanTown_FourthWallBdStudio",
            "RanchoCoronado_GunORama",
            "Dogtown_Hideout",
            "JapanTown_HiromisApartment",
            "NorthOaks_Kerry_Estate",
            "Kabuki_LizziesBar",
            "JapanTown_MegabuildingH8",
            "MorroRock",
            "Badlands_Spaceport",
            "MorroRock_NCX",
            "Northside_Apartment",
            "Kabuki_NoTellMotel",
            "LittleChina_Q101Cyberspace",
            "Northside_Totentaz",
            "LittleChina_VApartment",
            "Coastview_VDBChapel",
            "Coastview_VDBMaglev",
            "JapanTown_VR_Tutorial",
            "Northside_WNS"
        ];

        if ArrayContains(nonoZones, record.EnumName()) {
            return false;
        }

        if this.m_questsSystem.GetFact(n"q001_01_go_to_sleep_done") == 0 && this.m_questsSystem.GetFact(n"q005_johnny_chip_acquired") == 0 || this.m_questsSystem.GetFact(n"q115_point_of_no_return") == 1 {
            return false;
        }

        if GameInstance.GetRacingSystem(gi).IsRaceInProgress() {
            return false;
        }

        if !this.m_settings.GetEnabledWhenPlayerIsPassenger() && VehicleComponent.IsMountedToVehicle(player.GetGame(), player) {
            let vehicle = player.GetMountedVehicle();
            if vehicle.IsPlayerMounted() && !vehicle.IsPlayerDriver() {
                return false;
            }
        }

        //Check some cases
        if StatusEffectSystem.ObjectHasStatusEffectOfType(puppet, gamedataStatusEffectType.Stunned)
            || StatusEffectSystem.ObjectHasStatusEffectOfType(puppet, gamedataStatusEffectType.EMP)
            || StatusEffectSystem.ObjectHasStatusEffectOfType(puppet, gamedataStatusEffectType.Grapple)
            || StatusEffectSystem.ObjectHasStatusEffectOfType(puppet, gamedataStatusEffectType.Knockdown)
            || StatusEffectSystem.ObjectHasStatusEffectOfType(puppet, gamedataStatusEffectType.SuicideHack)
            || StatusEffectSystem.ObjectHasStatusEffectOfType(puppet, gamedataStatusEffectType.Madness)
            || StatusEffectSystem.ObjectHasStatusEffectOfType(puppet, gamedataStatusEffectType.SystemCollapse)
            || StatusEffectSystem.ObjectHasStatusEffectWithTag(puppet, n"CommsNoiseJam") {
            return false;
        }

        let distanceToTarget = Vector4.Distance(puppet.GetWorldPosition(), target.GetWorldPosition());
        if distanceToTarget > 30.0 {
            return false;
        }
        return true;
    }

    public func GetFactionHandler(puppet: ref<ScriptedPuppet>) -> ref<GRGangHandler> {
        let affiliation = TweakDBInterface
            .GetCharacterRecord(puppet.GetRecordID())
            .Affiliation()
            .Type();
        switch affiliation {
            case gamedataAffiliation.TygerClaws:
                return this.m_tygerHandler;
            case gamedataAffiliation.Scavengers:
                return this.m_scavHandler;
            case gamedataAffiliation.Animals:
                return this.m_animalsHandler;
            case gamedataAffiliation.Maelstrom:
                return this.m_maelStormHandler;
            case gamedataAffiliation.Arasaka:
                return this.m_arasakaHandler;
            case gamedataAffiliation.VoodooBoys:
                return this.m_voodooHandler;
            case gamedataAffiliation.SixthStreet:
                return this.m_sixthHandler;
            case gamedataAffiliation.Militech:
                return this.m_militechHandler;
            case gamedataAffiliation.Valentinos:
                return this.m_valentinosHandler;
            case gamedataAffiliation.Barghest:
                return this.m_barghestHandler;
            case gamedataAffiliation.Wraiths:
                return this.m_wraithsHandler;
            case gamedataAffiliation.NCPD:
                return this.m_ncpdHandler;
            case gamedataAffiliation.TheMox:
                return this.m_moxHandler;
            default:
                break;
        }
    }

    public func TryCallingReinforcements(puppet: ref<ScriptedPuppet>, target: wref<GameObject>) -> Void {
        if !this.ReinforcementsChecksCall(puppet, target) {
            return;
        }

        if RandF() <= 0.2 {
            return;
        }

        if !NPCPuppet.IsInCombatWithTarget(puppet, GetPlayer(GetGameInstance())) {
            if this.GetFactionHandler(puppet).TryCallingReinforcements(puppet) {
                this.ReinforcementsCalled(puppet, target);
            }
        }
    }

    public func RequestSpawnTraffic(vehicles: array<TweakDBID>) -> Void {
        let game = GetGameInstance();
        let questSystem = GameInstance.GetQuestsSystem(game);

        let arraySize = ArraySize(vehicles);
        let node = new questDynamicSpawnSystemNodeDefinition();
        let nodeType = new questDynamicVehicleSpawn_NodeType();

        nodeType.distanceRange = Vector2(50, 100);
		if RandF() >= 0.5 {
			nodeType.spawnDirectionPreference = questSpawnDirectionPreference.InFront;
		} else {
			nodeType.spawnDirectionPreference = questSpawnDirectionPreference.Behind;
		}
        let nodeid = RandRange(20000, 30000);
        nodeType.waveTag = StringToName(s"GR_TRAFFIC_\(nodeid)");
        nodeType.VehicleData = vehicles;

        node.id = Cast<Uint16>(nodeid);
        node.type = nodeType;

        questSystem.ExecuteNode(node);
    }

	public func OnDistrictAreaEntered() -> Void {
		if this.m_trafficSpawnsStarted && RandF() <= 0.2 {
			this.SpawnTrafficVehiclesCallback();
		}
	}

	public func StartTrafficSpawns() -> Void {
		if !this.m_trafficSpawnsStarted {
			this.m_trafficSpawnsStarted = true;
			this.SpawnTrafficVehiclesCallback();
			this.KeepAliveCallback();
		}
	}

	// basically abusing the delay system to keep other long-lived callbacks alive
	// 
    public func KeepAliveCallback() -> Void {
		this.m_delaySystem.DelayCallback(GRKeepAliveCallback.Create(this), 11, true);
		this.m_delaySystem.GetRemainingDelayTime(this.m_trafficSpawnDelayID);
    }

	public func SpawnTrafficVehiclesCallback() -> Void {
		//GRLog("SpawnTrafficVehiclesCallback");
		// Call SpawnTrafficVehicles for each gang handler, except NCPD, Arasaka, Scavs
		this.m_tygerHandler.SpawnTrafficVehicles();
		this.m_animalsHandler.SpawnTrafficVehicles();
		this.m_maelStormHandler.SpawnTrafficVehicles();
		this.m_voodooHandler.SpawnTrafficVehicles();
		this.m_sixthHandler.SpawnTrafficVehicles();
		this.m_militechHandler.SpawnTrafficVehicles();
		this.m_valentinosHandler.SpawnTrafficVehicles();
		this.m_wraithsHandler.SpawnTrafficVehicles();
		this.m_moxHandler.SpawnTrafficVehicles();
		
		// Schedule next traffic spawn callback
		let delay = RandRangeF(this.m_settings.GetTrafficSpawnDelayMin(), this.m_settings.GetTrafficSpawnDelayMax());
		this.m_trafficSpawnDelayID = this.m_delaySystem.DelayCallback(GRSpawnTrafficCallback.Create(this), delay, true);
	}
}

public class GRKeepAliveCallback extends DelayCallback {
    let handler: wref<GRReinforcementSystem>;
    
    public static func Create(handler: ref<GRReinforcementSystem>) -> ref<GRKeepAliveCallback> {
        let self: ref<GRKeepAliveCallback> = new GRKeepAliveCallback();
        self.handler = handler;
        return self;
    }

    public func Call() -> Void {
        this.handler.KeepAliveCallback();
    }
}

public class GRSpawnTrafficCallback extends DelayCallback {
    let handler: wref<GRReinforcementSystem>;

    public static func Create(handler: ref<GRReinforcementSystem>) -> ref<GRSpawnTrafficCallback> {
        let self: ref<GRSpawnTrafficCallback> = new GRSpawnTrafficCallback();
        self.handler = handler;
        return self;
    }

    public func Call() -> Void {
        this.handler.SpawnTrafficVehiclesCallback();
    }
}