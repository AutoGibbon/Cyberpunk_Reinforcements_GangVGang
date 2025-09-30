import Gibbon.GR.ReinforcementSystem.*
import Gibbon.GR.Settings.*
import Gibbon.GR.GangHandlers.*
import Gibbon.GR.Logging.*

@wrapMethod(ReactionManagerComponent)
protected final func HandleStimEvent(stimData: ref<StimEventTaskData>) -> Void {
	wrappedMethod(stimData);

	//potential edge case
	//if(Equals(stimData.cachedEvt.stimType, gamedataStimType.Dying)) {
	//	return;
	//}

	let reinSystem: wref<GRReinforcementSystem> = GRReinforcementSystem.GetInstance(GetGameInstance());
	if (reinSystem.m_settings.enabled) {
    	let ownerPuppet: ref<ScriptedPuppet>;

		ownerPuppet = this.GetOwnerPuppet();

        if( NPCPuppet.IsInCombatWithTarget(ownerPuppet, GetPlayer(GetGameInstance()))
		|| !NPCPuppet.IsInCombatWithTarget(ownerPuppet, stimData.cachedEvt.sourceObject)) {
            return;
        }

		reinSystem.TryCallingReinforcements(ownerPuppet, stimData.cachedEvt.sourceObject);
	}
}