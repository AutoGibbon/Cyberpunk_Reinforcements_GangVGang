module Gibbon.GR.GangHandlers

import Gibbon.GR.GangData.*
import Gibbon.GR.Settings.GRSettings


public class GRMilitechHandler extends GRGangHandler {
    private final func OnPlayerAttach(request: ref<PlayerAttachRequest>) -> Void { 
        let game = GetGameInstance();
        this.reinforcementData = new GRMilitechData();
        this.preventionSystem = GameInstance.GetScriptableSystemsContainer(game).Get(n"PreventionSystem") as PreventionSystem;
        this.delaySystem = GameInstance.GetDelaySystem(game);
        this.settings = GRSettings.GetInstance(game);
        this.affiliation = gamedataAffiliation.Militech;
        this.waveCounterUniqueId = 6000;
    }

    public static func GetInstance(gameInstance: GameInstance) -> ref<GRMilitechHandler> {
        let system: ref<GRMilitechHandler> = GameInstance.GetScriptableSystemsContainer(gameInstance).Get(n"Gibbon.GR.GangHandlers.GRMilitechHandler") as GRMilitechHandler;
        return system;
    }

 

    public func OnHeatResetCooldownStart() -> Void {
        this.delaySystem.DelayCallback(GRMilitechHeatResetCooldownEndCallback.Create(this), this.GetHeatResetCooldown(), true);
    }

    public func OnCallSuccessCooldownStart() -> Void {
        this.delaySystem.DelayCallback(GRMilitechCallSuccessCooldownEndCallback.Create(this), this.GetCallSuccessCooldown(), true);
    }

    public func OnGraceStart() -> Void {
        this.delaySystem.DelayCallback(GRMilitechGraceEndCallback.Create(this), this.GetGraceTime(), true);
    }

	public func OnCallSuccessDelayArrival(isTurf: Bool) -> Void {
        let backupDelay = this.GetBackupDelay(isTurf);
        this.delaySystem.DelayCallback(GRMilitechCallSuccessDelayArrivalCallback.Create(this), backupDelay, true);
    }

    public func GetTurfList() -> array<String> {
        return [
            "Badlands"
        ];
    }
}

public class GRMilitechGraceEndCallback extends DelayCallback {
    let handler: wref<GRMilitechHandler>;
    public static func Create(handler: ref<GRMilitechHandler>) -> ref<GRMilitechGraceEndCallback> {
        let self: ref<GRMilitechGraceEndCallback> = new GRMilitechGraceEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnGraceEnd();
  }
}

public class GRMilitechHeatResetCooldownEndCallback extends DelayCallback {
    let handler: wref<GRMilitechHandler>;
    public static func Create(handler: ref<GRMilitechHandler>) -> ref<GRMilitechHeatResetCooldownEndCallback> {
        let self: ref<GRMilitechHeatResetCooldownEndCallback> = new GRMilitechHeatResetCooldownEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnHeatResetCooldownEnd();
  }
}

public class GRMilitechCallSuccessCooldownEndCallback extends DelayCallback {
    let handler: wref<GRMilitechHandler>;
    public static func Create(handler: ref<GRMilitechHandler>) -> ref<GRMilitechCallSuccessCooldownEndCallback> {
        let self: ref<GRMilitechCallSuccessCooldownEndCallback> = new GRMilitechCallSuccessCooldownEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnCallSuccessCooldownEnd();
  }
}

public class GRMilitechCallSuccessDelayArrivalCallback extends DelayCallback {
    let handler: wref<GRMilitechHandler>;
    public static func Create(handler: ref<GRMilitechHandler>) -> ref<GRMilitechCallSuccessDelayArrivalCallback> {
        let self: ref<GRMilitechCallSuccessDelayArrivalCallback> = new GRMilitechCallSuccessDelayArrivalCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
	this.handler.CompleteReinforcementCall();
  }
}