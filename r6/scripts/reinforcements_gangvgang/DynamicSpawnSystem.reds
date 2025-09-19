module Gibbon.GR

import Gibbon.GR.ReinforcementSystem.*
import Gibbon.GR.GangHandlers.*
import Gibbon.GR.Logging.*

@wrapMethod(DynamicSpawnSystem)
protected final func SpawnRequestFinished(requestResult: DSSSpawnRequestResult) -> Void {
    let i: Int32;
    let spawnedObject: ref<GameObject>;
    let puppet: ref<ScriptedPuppet>;
    let reinSystem: ref<GRReinforcementSystem> = GRReinforcementSystem.GetInstance(GetGameInstance());
    let gangHandler: ref<GRGangHandler>;
    let target: ref<NPCPuppet>;
    let targetPosition: Vector4;
    let wheeledObject: ref<WheeledObject>;
    let wheeledObjects: array<ref<WheeledObject>> = [];
    let gotModTag: Bool = false;
    let aiVehicleChaseCommand: ref<AIVehicleChaseCommand>;
    let aiVehicleMovecommand: ref<AIVehicleDriveToPointAutonomousCommand>;
    let aiCommandEvent: ref<AICommandEvent>;

    if !requestResult.success {
        return;
    }

    i = 0;
    while i < ArraySize(requestResult.spawnedObjects) {
        spawnedObject = requestResult.spawnedObjects[i];
        if !spawnedObject.IsPuppet() && spawnedObject.IsVehicle() {
            ArrayPush(wheeledObjects, spawnedObject as WheeledObject);
        } else {
            if !gotModTag {
                puppet = spawnedObject as ScriptedPuppet;
                if NPCManager.HasTag(puppet.GetRecordID(), n"GRModPuppet") {
                    gotModTag = true;
                    gangHandler = reinSystem.GetFactionHandler(puppet);
                }
            }
        }
        //todo maybe inject threats, actually you can't because of how EntityReference works. Just have to hope the spawned cars get to the correct location and start fighting.
        // target = gangHandler.GetLastTarget();
        // aiInjectCombatThreatCommand = new AIInjectCombatThreatCommand();
        // aiInjectCombatThreatCommand.targetPuppetRef = CreateEntityReference("#player", nullArrayOfNames);
        // aiInjectCombatThreatCommand.duration = 120.00;
        // AIComponent.SendCommand(puppet, aiInjectCombatThreatCommand);

        i += 1;
    }

    if !gotModTag || !IsDefined(gangHandler) {
        wrappedMethod(requestResult);
        return;
    }

    // only inject car chase commands if there are pending chase requests and the gang had its last normal call answered
    let isCarChase = reinSystem.numberOfCarChaseRequests > 0 && gangHandler.lastCallAnswered;

    target = gangHandler.GetLastTarget();
    targetPosition = gangHandler.GetLastCallerPosition();
    i = 0;
    while i < ArraySize(wheeledObjects) {
        wheeledObject = wheeledObjects[i];

        if isCarChase {
            reinSystem.numberOfCarChaseRequests -= 1;
            GRLog(s"isCarChase=\(isCarChase) reinSystem.numberOfCarChaseRequests=\(reinSystem.numberOfCarChaseRequests)");
            let playerPosition = GetPlayer(GetGameInstance()).GetWorldPosition();
            aiVehicleMovecommand = new AIVehicleDriveToPointAutonomousCommand();
            aiVehicleMovecommand.driveDownTheRoadIndefinitely = true;
            aiVehicleMovecommand.clearTrafficOnPath = false;
            aiVehicleMovecommand.forcedStartSpeed = 10.0;
            aiVehicleMovecommand.minSpeed = 30.0;
            aiVehicleMovecommand.minimumDistanceToTarget = 30.0;
            aiVehicleMovecommand.targetPosition = Vector4.Vector4To3(playerPosition);
            aiCommandEvent = new AICommandEvent();
            aiCommandEvent.command = aiVehicleMovecommand;
            wheeledObject.SetPoliceStrategyDestination(playerPosition);
            wheeledObject.QueueEvent(aiCommandEvent);
            wheeledObject.GetAIComponent().SetInitCmd(aiVehicleMovecommand);
        } else if IsDefined(target) {
            aiVehicleChaseCommand = new AIVehicleChaseCommand();
            aiVehicleChaseCommand.target = target;
            aiVehicleChaseCommand.distanceMin = TweakDBInterface.GetFloat(t"DynamicSpawnSystem.dynamic_vehicles_chase_setup.distanceMin", 3.0);
            aiVehicleChaseCommand.distanceMax = TweakDBInterface.GetFloat(t"DynamicSpawnSystem.dynamic_vehicles_chase_setup.distanceMax", 10.0);
            aiVehicleChaseCommand.forcedStartSpeed = 10.0;
            aiVehicleChaseCommand.ignoreChaseVehiclesLimit = true;
            aiVehicleChaseCommand.boostDrivingStats = true;
            aiCommandEvent = new AICommandEvent();
            aiCommandEvent.command = aiVehicleChaseCommand;
            wheeledObject.SetPoliceStrategyDestination(target.GetWorldPosition());
            wheeledObject.QueueEvent(aiCommandEvent);
            wheeledObject.GetAIComponent().SetInitCmd(aiVehicleChaseCommand);
        } else if !Vector4.IsZero(targetPosition) {
            aiVehicleMovecommand = new AIVehicleDriveToPointAutonomousCommand();
            aiVehicleMovecommand.driveDownTheRoadIndefinitely = false;
            aiVehicleMovecommand.clearTrafficOnPath = false;
            aiVehicleMovecommand.forcedStartSpeed = 10.0;
            aiVehicleMovecommand.minSpeed = 30.0;
            aiVehicleMovecommand.minimumDistanceToTarget = 15.0;
            aiVehicleMovecommand.targetPosition = Vector4.Vector4To3(targetPosition);
            aiCommandEvent = new AICommandEvent();
            aiCommandEvent.command = aiVehicleMovecommand;
            wheeledObject.SetPoliceStrategyDestination(targetPosition);
            wheeledObject.QueueEvent(aiCommandEvent);
            wheeledObject.GetAIComponent().SetInitCmd(aiVehicleMovecommand);
        }

        if Equals(gangHandler.affiliation, gamedataAffiliation.NCPD) {
            wheeledObject.GetVehicleComponent().ToggleSiren(true, true);
        }
        i += 1;
    }
    //GRLog(s"\(gangHandler.affiliation), veh \(ArraySize(wheeledObjects)) ");
    gangHandler.lastCallAnswered = true;
    return;
}

@wrapMethod(DynamicSpawnSystem)
protected final func SpawnCallback(spawnedObject: ref<GameObject>) -> Void {
    let wheeledObject: ref<WheeledObject>;
    let puppet: ref<gamePuppetBase>;

    if !IsDefined(spawnedObject) {
        return;
    }
    if spawnedObject.IsPuppet() {
        puppet = spawnedObject as gamePuppetBase;
        if NPCManager.HasTag(puppet.GetRecordID(), n"GRModPuppet") {
            // exit to avoid the default behaviour that makes the new npc hostile with the player
            return;
        }
    } else {
        if spawnedObject.IsVehicle() {
            wheeledObject = spawnedObject as WheeledObject;
            let tags = TweakDBInterface.GetVehicleRecord(wheeledObject.GetRecordID()).Tags();
            if ArrayContains(tags, n"GRModVehicle") {
                // exit to avoid the default behaviour that gives the vehicle a command to chase the player
                // we will give the vehicle a correct chase command in the request finished wrapper above
                return;
            }
        }
    }

    // if the entity was not tagged with GRModVehicle or GRModPuppet, then call the original function.
    wrappedMethod(spawnedObject);
}

