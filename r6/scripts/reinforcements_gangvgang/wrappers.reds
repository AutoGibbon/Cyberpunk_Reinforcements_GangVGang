import Gibbon.GR.ReinforcementSystem.*

@wrapMethod(PreventionSystem)
private final func OnDistrictAreaEntered(request: ref<DistrictEnteredEvent>) -> Void {
    wrappedMethod(request);
	GRReinforcementSystem.GetInstance(GetGameInstance()).StartTrafficSpawns();
}