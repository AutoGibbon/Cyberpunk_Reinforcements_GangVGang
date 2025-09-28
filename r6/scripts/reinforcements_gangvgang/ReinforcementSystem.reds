module Gibbon.GR.ReinforcementSystem

import Gibbon.GR.GangHandlers.*
import Gibbon.GR.GangData.*
import Gibbon.GR.Settings.*
import Gibbon.GR.Logging.*

public class GRReinforcementSystem extends ScriptableSystem {
    private let tygerHandler: ref<GRTygersHandler>;
    private let scavHandler: ref<GRScavsHandler>;
    private let animalsHandler: ref<GRAnimalsHandler>;
    private let maelStormHandler: ref<GRMaelStromHandler>;
    private let arasakaHandler: ref<GRArasakaHandler>;
    private let voodooHandler: ref<GRVoodooHandler>;
    private let sixthHandler: ref<GRSixthStreetHandler>;
    private let militechHandler: ref<GRMilitechHandler>;
    private let valentinosHandler: ref<GRValentinosHandler>;
    private let barghestHandler: ref<GRBarghestHandler>;
    private let wraithsHandler: ref<GRWraithsHandler>;
    private let ncpdHandler: ref<GRNCPDHandler>;
    private let moxHandler: ref<GRMoxHandler>;
	private let gameAttachHandled: Bool = false;

    private let preventionSystem: ref<PreventionSystem>;
    private let QuestsSystem: ref<QuestsSystem>;
	private let delaySystem: ref<DelaySystem>;

    public let settings: ref<GRSettings>;

	public func OnAttach() -> Void {
		GRLog("ReinforcementSystem OnAttach");
		this.gameAttachHandled = false;
	}

    public final func OnPlayerAttach(request: ref<PlayerAttachRequest>) -> Void {
		GRLog("ReinforcementSystem OnPlayerAttach");
        let theGame = GetGameInstance();
        // I just lost it

        this.preventionSystem = GameInstance.GetScriptableSystemsContainer(theGame).Get(n"PreventionSystem") as PreventionSystem;
        this.QuestsSystem = GameInstance.GetQuestsSystem(theGame);
		this.delaySystem = GameInstance.GetDelaySystem(theGame);

        this.settings = GRSettings.GetInstance(theGame);
        this.tygerHandler = GRTygersHandler.GetInstance(theGame);
        this.scavHandler = GRScavsHandler.GetInstance(theGame);
        this.animalsHandler = GRAnimalsHandler.GetInstance(theGame);
        this.maelStormHandler = GRMaelStromHandler.GetInstance(theGame);
        this.arasakaHandler = GRArasakaHandler.GetInstance(theGame);
        this.voodooHandler = GRVoodooHandler.GetInstance(theGame);
        this.sixthHandler = GRSixthStreetHandler.GetInstance(theGame);
        this.militechHandler = GRMilitechHandler.GetInstance(theGame);
        this.valentinosHandler = GRValentinosHandler.GetInstance(theGame);
        this.barghestHandler = GRBarghestHandler.GetInstance(theGame);
        this.wraithsHandler = GRWraithsHandler.GetInstance(theGame);
        this.ncpdHandler = GRNCPDHandler.GetInstance(theGame);
        this.moxHandler = GRMoxHandler.GetInstance(theGame);
        //debugging
        // this.tygerHandler.isDisabled = true;
        // this.scavHandler.isDisabled = true;
        // this.animalsHandler.isDisabled = true;
        // this.maelstromHandler.isDisabled = true;
        // this.arasakaHandler.isDisabled = true;
        // this.voodooHandler.isDisabled = true;
        // this.sixthHandler.isDisabled = true;
        // this.militechHandler.isDisabled = true;
        // this.valentinosHandler.isDisabled = true;
        // this.barghestHandler.isDisabled = true;
        // this.wraithsHandler.isDisabled = true;
        // this.ncpdHandler.isDisabled = true;

        // cause we're doing funky stuff with public and private bindings
        this.settings.ReconcileSettings();

		if !this.gameAttachHandled {
			GRLog("ReinforcementSystem OnPlayerAttach->HandleGameAttach");
			this.HandleGameAttach();
		}
    }

	public func OnRestored(saveVersion: Int32, gameVersion: Int32) {
    	if !this.gameAttachHandled {
			GRLog("ReinforcementSystem OnRestored->HandleGameAttach");
			this.HandleGameAttach();
		}
    }
  
	public func HandleGameAttach() -> Void { 
		GRLog("ReinforcementSystem HandleGameAttach");
		if GameInstance.GetSystemRequestsHandler().IsPreGame() {
			GRLog("ReinforcementSystem HandleGameAttach->IsPreGame");
			return;
		}
		GRLog("ReinforcementSystem HandleGameAttach->DoLogic");

		this.gameAttachHandled = true;
		this.ResetAllGangs();
		this.StartTrafficSpawns();
	}

	public func StartTrafficSpawns() -> Void {
		this.SpawnTrafficVehiclesCallback();
		this.KeepAliveCallback();
	}

    public func ResetAllGangs() -> Void {
        this.tygerHandler.OnHeatResetCooldownEnd();
        this.scavHandler.OnHeatResetCooldownEnd();
        this.animalsHandler.OnHeatResetCooldownEnd();
        this.maelStormHandler.OnHeatResetCooldownEnd();
        this.arasakaHandler.OnHeatResetCooldownEnd();
        this.voodooHandler.OnHeatResetCooldownEnd();
        this.sixthHandler.OnHeatResetCooldownEnd();
        this.militechHandler.OnHeatResetCooldownEnd();
        this.valentinosHandler.OnHeatResetCooldownEnd();
        this.barghestHandler.OnHeatResetCooldownEnd();
        this.wraithsHandler.OnHeatResetCooldownEnd();
        this.ncpdHandler.OnHeatResetCooldownEnd();
        this.moxHandler.OnHeatResetCooldownEnd();
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

        if !this.settings.enabledWhenPlayerInCombat && GetPlayer(puppet.GetGame()).IsInCombat() {
            return false;
        }

        if StatusEffectSystem.ObjectHasStatusEffect(GetPlayer(puppet.GetGame()), t"GameplayRestriction.FistFight") {
            return false;
        }

        let npcRarity = (puppet as NPCPuppet).GetNPCRarity();
        if Equals(npcRarity, gamedataNPCRarity.MaxTac) || Equals(npcRarity, gamedataNPCRarity.Boss) {
            return false;
        }

        let record = this.preventionSystem.GetCurrentDistrict().GetDistrictRecord();
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

        if this.QuestsSystem.GetFact(n"q001_01_go_to_sleep_done") == 0 && this.QuestsSystem.GetFact(n"q005_johnny_chip_acquired") == 0 || this.QuestsSystem.GetFact(n"q115_point_of_no_return") == 1 {
            return false;
        }

        if GameInstance.GetRacingSystem(gi).IsRaceInProgress() {
            return false;
        }

        if !this.settings.enabledWhenPlayerIsPassenger && VehicleComponent.IsMountedToVehicle(player.GetGame(), player) {
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

        // todo change this after we figure out who the npc is fighting
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
                return this.tygerHandler;
            case gamedataAffiliation.Scavengers:
                return this.scavHandler;
            case gamedataAffiliation.Animals:
                return this.animalsHandler;
            case gamedataAffiliation.Maelstrom:
                return this.maelStormHandler;
            case gamedataAffiliation.Arasaka:
                return this.arasakaHandler;
            case gamedataAffiliation.VoodooBoys:
                return this.voodooHandler;
            case gamedataAffiliation.SixthStreet:
                return this.sixthHandler;
            case gamedataAffiliation.Militech:
                return this.militechHandler;
            case gamedataAffiliation.Valentinos:
                return this.valentinosHandler;
            case gamedataAffiliation.Barghest:
                return this.barghestHandler;
            case gamedataAffiliation.Wraiths:
                return this.wraithsHandler;
            case gamedataAffiliation.NCPD:
                return this.ncpdHandler;
            case gamedataAffiliation.TheMox:
                return this.moxHandler;
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
        } else {
			//GRLog(s"\(TDBID.ToStringDEBUG(puppet.GetRecordID())) not allowed to call reinforcements: in combat with player");
		}
    }


    public func RequestSpawnTraffic(vehicles: array<TweakDBID>) -> Void {
        let game = GetGameInstance();
        let questSystem = GameInstance.GetQuestsSystem(game);

        let arraySize = ArraySize(vehicles);
        let node = new questDynamicSpawnSystemNodeDefinition();
        let nodeType = new questDynamicVehicleSpawn_NodeType();

        nodeType.distanceRange = Vector2(200, 400);
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

	// basically abusing the delay system to keep other long-lived callbacks alive
	// 
    public func KeepAliveCallback() -> Void {
		this.delaySystem.DelayCallback(GRKeepAliveCallback.Create(this), 11, false);
    }

	public func SpawnTrafficVehiclesCallback() -> Void {
		// Call SpawnTrafficVehicles for each gang handler, except NCPD, Arasaka, Scavs
		this.tygerHandler.SpawnTrafficVehicles();
		this.animalsHandler.SpawnTrafficVehicles();
		this.maelStormHandler.SpawnTrafficVehicles();
		this.voodooHandler.SpawnTrafficVehicles();
		this.sixthHandler.SpawnTrafficVehicles();
		this.militechHandler.SpawnTrafficVehicles();
		this.valentinosHandler.SpawnTrafficVehicles();
		this.wraithsHandler.SpawnTrafficVehicles();
		this.moxHandler.SpawnTrafficVehicles();
		
		// Schedule next traffic spawn callback
		let delay = RandRangeF(this.settings.trafficSpawnDelayMin, this.settings.trafficSpawnDelayMax);
		this.delaySystem.DelayCallback(GRSpawnTrafficCallback.Create(this), delay, false);
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

