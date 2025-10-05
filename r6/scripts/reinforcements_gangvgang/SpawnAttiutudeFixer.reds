import Gibbon.GR.ReinforcementSystem.*
import Gibbon.GR.GangHandlers.*
import Gibbon.GR.Logging.*

@wrapMethod(NPCPuppet)
protected cb func OnPostInitialize(evt: ref<entPostInitializeEvent>) -> Bool {
    let outcome = wrappedMethod(evt);


    if NPCManager.HasTag(this.GetRecordID(), n"GRModPuppet") {
        let reinSystem: wref<GRReinforcementSystem> = GRReinforcementSystem.GetInstance(GetGameInstance());
        let factionHandler = reinSystem.GetFactionHandler(this);

        this.GRAttitudeFix(factionHandler.GetLastCaller(), factionHandler.GetLastTarget(), factionHandler.GetAttitudeGroup());
    }
    
    return outcome;
} 

@addMethod(NPCPuppet)
protected final func GRAttitudeFix(caller: ref<GameObject>, target: ref<GameObject>, fallbackAttitudeGroup: CName) -> Bool {
    let squadMember: ref<GameObject>;
    let i: Int32;
    let attitudeOwner: ref<AttitudeAgent>;
    let attitudeCaller: ref<AttitudeAgent>;
    let attitudeTarget: ref<AttitudeAgent>;
    let callerSquadMembers: array<wref<Entity>>;
    if (IsDefined(this)) {
        attitudeOwner = this.GetAttitudeAgent();
    };
    if !IsDefined(attitudeOwner) {
        return false;
    };

	if (IsDefined(target)) {
        attitudeTarget = target.GetAttitudeAgent();
		if IsDefined(attitudeTarget) {
			attitudeOwner.SetAttitudeTowards(attitudeTarget, EAIAttitude.AIA_Hostile);
		};
    };
    
    // If caller is not defined but owner attitude agent is available, set attitude group to the fallback from the gang handler
    if (!IsDefined(caller)) {
        attitudeOwner.SetAttitudeGroup(fallbackAttitudeGroup);
        return true;
    };

    attitudeCaller = caller.GetAttitudeAgent();
    if !IsDefined(attitudeCaller) {
        return false;
    };

    attitudeOwner.SetAttitudeGroup(attitudeCaller.GetAttitudeGroup());
    attitudeOwner.SetAttitudeTowards(attitudeCaller, EAIAttitude.AIA_Friendly);
    attitudeCaller.SetAttitudeTowards(attitudeOwner, EAIAttitude.AIA_Friendly);
    
    if AISquadHelper.GetSquadmates(caller as ScriptedPuppet, callerSquadMembers) {
        i = 0;
        while i < ArraySize(callerSquadMembers) {
			squadMember = callerSquadMembers[i] as GameObject;
			if IsDefined(squadMember) && squadMember != this {
				let attitudeSquadMember = squadMember.GetAttitudeAgent();
				if IsDefined(attitudeSquadMember) {
					attitudeOwner.SetAttitudeTowards(attitudeSquadMember, EAIAttitude.AIA_Friendly);
					attitudeSquadMember.SetAttitudeTowards(attitudeOwner, EAIAttitude.AIA_Friendly);
				};
			};
			i += 1;
        };
    };
    return true;
}