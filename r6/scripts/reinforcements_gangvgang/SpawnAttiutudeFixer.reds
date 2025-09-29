import Gibbon.GR.ReinforcementSystem.*
import Gibbon.GR.GangHandlers.*
import Gibbon.GR.Logging.*

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
protected final func GRAttitudeFix(caller: wref<GameObject>, target: wref<GameObject>) -> Bool {
    let currentSquadMate: wref<GameObject>;
    let i: Int32;
    let ownerAttitudeAgent: ref<AttitudeAgent>;
    let callerAttitudeAgent: ref<AttitudeAgent>;
    let targetAttitudeAgent: ref<AttitudeAgent>;
    let callerSquadMembers: array<wref<Entity>>;
    if (!IsDefined(this) || !IsDefined(caller) || !IsDefined(target)) {
        return false;
    };
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
            //GRLog(s"Attitude Fix: \(TDBID.ToStringDEBUG(GameObject.GetTDBID(this))) -> Friendly with \(TDBID.ToStringDEBUG(GameObject.GetTDBID(currentSquadMate)))");
            ownerAttitudeAgent.SetAttitudeTowards(currentSquadMate.GetAttitudeAgent(), EAIAttitude.AIA_Friendly);
            
            //GRLog(s"Attitude Fix: \(TDBID.ToStringDEBUG(GameObject.GetTDBID(currentSquadMate))) -> Friendly with \(TDBID.ToStringDEBUG(GameObject.GetTDBID(this)))");
            currentSquadMate.GetAttitudeAgent().SetAttitudeTowards(ownerAttitudeAgent, EAIAttitude.AIA_Friendly);
            
            //GRLog(s"Attitude Fix: \(TDBID.ToStringDEBUG(GameObject.GetTDBID(currentSquadMate))) -> Hostile with \(TDBID.ToStringDEBUG(GameObject.GetTDBID(target)))");
            currentSquadMate.GetAttitudeAgent().SetAttitudeTowards(targetAttitudeAgent, EAIAttitude.AIA_Hostile);
        };
        i += 1;
        };
    };
    //GRLog(s"Attitude Fix: \(TDBID.ToStringDEBUG(GameObject.GetTDBID(this))) -> Set attitude group to \(TDBID.ToStringDEBUG(GameObject.GetTDBID(caller)))");
    ownerAttitudeAgent.SetAttitudeGroup(callerAttitudeAgent.GetAttitudeGroup());
    
    //GRLog(s"Attitude Fix: \(TDBID.ToStringDEBUG(GameObject.GetTDBID(this))) -> Friendly with \(TDBID.ToStringDEBUG(GameObject.GetTDBID(caller)))");
    ownerAttitudeAgent.SetAttitudeTowards(callerAttitudeAgent, EAIAttitude.AIA_Friendly);
    
    //GRLog(s"Attitude Fix: \(TDBID.ToStringDEBUG(GameObject.GetTDBID(caller))) -> Friendly with \(TDBID.ToStringDEBUG(GameObject.GetTDBID(this)))");
    callerAttitudeAgent.SetAttitudeTowards(ownerAttitudeAgent, EAIAttitude.AIA_Friendly);
    return true;
}