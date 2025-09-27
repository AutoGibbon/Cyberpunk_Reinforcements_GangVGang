module Gibbon.GR.GangHandlers

import Gibbon.GR.GangData.*
import Gibbon.GR.Settings.GRSettings


public class GRArasakaHandler extends GRGangHandler {
    private final func OnPlayerAttach(request: ref<PlayerAttachRequest>) -> Void { 
        let game = GetGameInstance();
        this.reinforcementData = new GRArasakaData();
        this.preventionSystem = GameInstance.GetScriptableSystemsContainer(game).Get(n"PreventionSystem") as PreventionSystem;
        this.delaySystem = GameInstance.GetDelaySystem(game);
        this.settings = GRSettings.GetInstance(game);
        this.affiliation = gamedataAffiliation.Arasaka;
        this.waveCounterUniqueId = 3000;
        
    }

    public static func GetInstance(gameInstance: GameInstance) -> ref<GRArasakaHandler> {
        let system: ref<GRArasakaHandler> = GameInstance.GetScriptableSystemsContainer(gameInstance).Get(n"Gibbon.GR.GangHandlers.GRArasakaHandler") as GRArasakaHandler;
        return system;
    }

    public func OnHeatResetCooldownStart() -> Void {
        this.delaySystem.DelayCallback(GRArasakaHeatResetCooldownEndCallback.Create(this), this.GetHeatResetCooldown(), true);
    }

    public func OnCallSuccessCooldownStart() -> Void {
        this.delaySystem.DelayCallback(GRArasakaCallSuccessCooldownEndCallback.Create(this), this.GetCallSuccessCooldown(), true);
    }

    public func OnGraceStart() -> Void {
        this.delaySystem.DelayCallback(GRArasakaGraceEndCallback.Create(this), this.GetGraceTime(), true);
    }

	public func OnCallSuccessDelayArrival(isTurf: Bool) -> Void {
        let backupDelay = this.GetBackupDelay(isTurf);
        this.delaySystem.DelayCallback(GRArasakaCallSuccessDelayArrivalCallback.Create(this), backupDelay, true);
    }

    public func GetTurfList() -> array<String> {
        return [];
    }

	public func IsConsideredTurf(district: ref<District>) -> Bool {
		return true;
	}
}

public class GRArasakaGraceEndCallback extends DelayCallback {
    let handler: wref<GRArasakaHandler>;
    public static func Create(handler: ref<GRArasakaHandler>) -> ref<GRArasakaGraceEndCallback> {
        let self: ref<GRArasakaGraceEndCallback> = new GRArasakaGraceEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnGraceEnd();
  }
}

public class GRArasakaHeatResetCooldownEndCallback extends DelayCallback {
    let handler: wref<GRArasakaHandler>;
    public static func Create(handler: ref<GRArasakaHandler>) -> ref<GRArasakaHeatResetCooldownEndCallback> {
        let self: ref<GRArasakaHeatResetCooldownEndCallback> = new GRArasakaHeatResetCooldownEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnHeatResetCooldownEnd();
  }
}

public class GRArasakaCallSuccessCooldownEndCallback extends DelayCallback {
    let handler: wref<GRArasakaHandler>;
    public static func Create(handler: ref<GRArasakaHandler>) -> ref<GRArasakaCallSuccessCooldownEndCallback> {
        let self: ref<GRArasakaCallSuccessCooldownEndCallback> = new GRArasakaCallSuccessCooldownEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnCallSuccessCooldownEnd();
  }
}

public class GRArasakaCallSuccessDelayArrivalCallback extends DelayCallback {
    let handler: wref<GRArasakaHandler>;
    public static func Create(handler: ref<GRArasakaHandler>) -> ref<GRArasakaCallSuccessDelayArrivalCallback> {
        let self: ref<GRArasakaCallSuccessDelayArrivalCallback> = new GRArasakaCallSuccessDelayArrivalCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
	this.handler.CompleteReinforcementCall();
  }
}