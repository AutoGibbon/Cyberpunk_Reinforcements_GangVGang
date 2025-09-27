module Gibbon.GR.GangHandlers

import Gibbon.GR.GangData.*
import Gibbon.GR.Settings.GRSettings


public class GRMaelStromHandler extends GRGangHandler {
    private final func OnPlayerAttach(request: ref<PlayerAttachRequest>) -> Void { 
        let game = GetGameInstance();
        this.reinforcementData = new GRMaelstormData();
        this.preventionSystem = GameInstance.GetScriptableSystemsContainer(game).Get(n"PreventionSystem") as PreventionSystem;
        this.delaySystem = GameInstance.GetDelaySystem(game);
        this.settings = GRSettings.GetInstance(game);
        this.affiliation = gamedataAffiliation.Maelstrom;
        this.waveCounterUniqueId = 5000;
    }

    public static func GetInstance(gameInstance: GameInstance) -> ref<GRMaelStromHandler> {
        let system: ref<GRMaelStromHandler> = GameInstance.GetScriptableSystemsContainer(gameInstance).Get(n"Gibbon.GR.GangHandlers.GRMaelStromHandler") as GRMaelStromHandler;
        return system;
    }

    public func GetTurfList() -> array<String> {
        return ["Watson"];
    }

    public func OnGraceStart() -> Void {
        this.delaySystem.DelayCallback(GRMaelstromGraceEndCallback.Create(this), this.GetGraceTime(), true);
    }

    public func OnHeatResetCooldownStart() -> Void {
        this.delaySystem.DelayCallback(GRMaelstromHeatResetCooldownEndCallback.Create(this), this.GetHeatResetCooldown(), true);
    }

    public func OnCallSuccessCooldownStart() -> Void {
        this.delaySystem.DelayCallback(GRMaelstromCallSuccessCooldownEndCallback.Create(this), this.GetCallSuccessCooldown(), true);
    }

	public func OnCallSuccessDelayArrival(isTurf: Bool) -> Void {
        let backupDelay = this.GetBackupDelay(isTurf);
        this.delaySystem.DelayCallback(GRMaelstromCallSuccessDelayArrivalCallback.Create(this), backupDelay, true);
    }
}

public class GRMaelstromGraceEndCallback extends DelayCallback {
    let handler: wref<GRMaelStromHandler>;
    public static func Create(handler: ref<GRMaelStromHandler>) -> ref<GRMaelstromGraceEndCallback> {
        let self: ref<GRMaelstromGraceEndCallback> = new GRMaelstromGraceEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnGraceEnd();
  }
}

public class GRMaelstromHeatResetCooldownEndCallback extends DelayCallback {
    let handler: wref<GRMaelStromHandler>;
    public static func Create(handler: ref<GRMaelStromHandler>) -> ref<GRMaelstromHeatResetCooldownEndCallback> {
        let self: ref<GRMaelstromHeatResetCooldownEndCallback> = new GRMaelstromHeatResetCooldownEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnHeatResetCooldownEnd();
  }
}

public class GRMaelstromCallSuccessCooldownEndCallback extends DelayCallback {
    let handler: wref<GRMaelStromHandler>;
    public static func Create(handler: ref<GRMaelStromHandler>) -> ref<GRMaelstromCallSuccessCooldownEndCallback> {
        let self: ref<GRMaelstromCallSuccessCooldownEndCallback> = new GRMaelstromCallSuccessCooldownEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnCallSuccessCooldownEnd();
  }
}

public class GRMaelstromCallSuccessDelayArrivalCallback extends DelayCallback {
    let handler: wref<GRMaelStromHandler>;
    public static func Create(handler: ref<GRMaelStromHandler>) -> ref<GRMaelstromCallSuccessDelayArrivalCallback> {
        let self: ref<GRMaelstromCallSuccessDelayArrivalCallback> = new GRMaelstromCallSuccessDelayArrivalCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
	this.handler.CompleteReinforcementCall();
  }
}
