import Gibbon.GR.ReinforcementSystem.*
import Gibbon.GR.Logging.*

/**
	@wrapMethod(PreventionSystem)
	private final func OnDistrictAreaEntered(request: ref<DistrictEnteredEvent>) -> Void {
	    wrappedMethod(request);
		GRLog(s"OnDistrictAreaEntered");
		if RandF() >= 0.5 {
			GRLog(s"Starting traffic spawns");
			GRReinforcementSystem.GetInstance(GetGameInstance()).StartTrafficSpawns();
		}
	}
*/