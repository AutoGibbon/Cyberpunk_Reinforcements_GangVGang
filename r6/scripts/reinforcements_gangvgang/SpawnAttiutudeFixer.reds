import Gibbon.GR.ReinforcementSystem.*
import Gibbon.GR.GangHandlers.*

@wrapMethod(NPCPuppet)
protected cb func OnPostInitialize(evt: ref<entPostInitializeEvent>) -> Bool {
    let outcome = wrappedMethod(evt);


    if NPCManager.HasTag(this.GetRecordID(), n"GRModPuppet") {
        let reinSystem: wref<GRReinforcementSystem> = GRReinforcementSystem.GetInstance(GetGameInstance());
        let factionHandler = reinSystem.GetFactionHandler(this);

        // call the attitude fix from reinforcements mod
        this.GRAttitudeFix(factionHandler.GetLastCaller(), factionHandler.GetLastTarget());
    }
    
    return outcome;
} 

@addMethod(NPCPuppet)
protected final func GRAttitudeFix(caller: ref<GameObject>, target: ref<GameObject>) -> Bool {
	if (!IsDefined(this) || !IsDefined(caller) || !IsDefined(target)) {
        return false;
    };
    let currentSquadMate: wref<GameObject>;
    let i: Int32;
    let ownerAttitudeAgent: ref<AttitudeAgent>;
    let callerAttitudeAgent: ref<AttitudeAgent>;
    let targetAttitudeAgent: ref<AttitudeAgent>;
    let callerSquadMembers: array<wref<Entity>>;
    
    ownerAttitudeAgent = this.GetAttitudeAgent();
    callerAttitudeAgent = caller.GetAttitudeAgent();
    targetAttitudeAgent = target.GetAttitudeAgent();
    if !IsDefined(ownerAttitudeAgent) || !IsDefined(callerAttitudeAgent) {
        return false;
    };
    if AISquadHelper.GetSquadmates(caller as ScriptedPuppet, callerSquadMembers) {
        i = 0;
        while i < ArraySize(callerSquadMembers) {
        currentSquadMate = callerSquadMembers[i] as GameObject;
        if !IsDefined(currentSquadMate) || currentSquadMate == this {
        } else {
            ownerAttitudeAgent.SetAttitudeTowards(currentSquadMate.GetAttitudeAgent(), EAIAttitude.AIA_Friendly);
            currentSquadMate.GetAttitudeAgent().SetAttitudeTowards(ownerAttitudeAgent, EAIAttitude.AIA_Friendly);
            currentSquadMate.GetAttitudeAgent().SetAttitudeTowards(targetAttitudeAgent, EAIAttitude.AIA_Hostile);
        };
        i += 1;
        };
    };
    ownerAttitudeAgent.SetAttitudeGroup(callerAttitudeAgent.GetAttitudeGroup());
    ownerAttitudeAgent.SetAttitudeTowards(callerAttitudeAgent, EAIAttitude.AIA_Friendly);
    callerAttitudeAgent.SetAttitudeTowards(ownerAttitudeAgent, EAIAttitude.AIA_Friendly);
    return true;
}