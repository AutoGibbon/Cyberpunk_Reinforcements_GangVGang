module Gibbon.GR.GangHandlers

import Gibbon.GR.GangData.*
import Gibbon.GR.Settings.GRSettings


public class GRNCPDHandler extends GRGangHandler {
    private final func OnPlayerAttach(request: ref<PlayerAttachRequest>) -> Void { 
        let game = GetGameInstance();
        this.reinforcementData = new GRNCPDData();
        this.preventionSystem = GameInstance.GetScriptableSystemsContainer(game).Get(n"PreventionSystem") as PreventionSystem;
        this.delaySystem = GameInstance.GetDelaySystem(game);
        this.settings = GRSettings.GetInstance(game);
        this.affiliation = gamedataAffiliation.NCPD;
        this.waveCounterUniqueId = 7000;
        
    }

    public static func GetInstance(gameInstance: GameInstance) -> ref<GRNCPDHandler> {
        let system: ref<GRNCPDHandler> = GameInstance.GetScriptableSystemsContainer(gameInstance).Get(n"Gibbon.GR.GangHandlers.GRNCPDHandler") as GRNCPDHandler;
        return system;
    }

    public func OnHeatResetCooldownStart() -> Void {
        this.delaySystem.DelayCallback(GRNCPDHeatResetCooldownEndCallback.Create(this), this.GetHeatResetCooldown(), true);
    }

    public func OnCallSuccessCooldownStart() -> Void {
        this.delaySystem.DelayCallback(GRNCPDCallSuccessCooldownEndCallback.Create(this), this.GetCallSuccessCooldown(), true);
    }

    public func OnGraceStart() -> Void {
        this.delaySystem.DelayCallback(GRNCPDGraceEndCallback.Create(this), this.GetGraceTime(), true);
    }

	public func OnCallSuccessDelayArrival(isTurf: Bool) -> Void {
        let backupDelay = this.GetBackupDelay(isTurf);
        this.delaySystem.DelayCallback(GRNCPDCallSuccessDelayArrivalCallback.Create(this), backupDelay, true);
    }

	public func OnTrafficSpawnStart() -> Bool {
		return false;
	}

    public func GetTurfList() -> array<String> {
        return [];
    }
}

public class GRNCPDGraceEndCallback extends DelayCallback {
    let handler: wref<GRNCPDHandler>;
    public static func Create(handler: ref<GRNCPDHandler>) -> ref<GRNCPDGraceEndCallback> {
        let self: ref<GRNCPDGraceEndCallback> = new GRNCPDGraceEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnGraceEnd();
  }
}

public class GRNCPDHeatResetCooldownEndCallback extends DelayCallback {
    let handler: wref<GRNCPDHandler>;
    public static func Create(handler: ref<GRNCPDHandler>) -> ref<GRNCPDHeatResetCooldownEndCallback> {
        let self: ref<GRNCPDHeatResetCooldownEndCallback> = new GRNCPDHeatResetCooldownEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnHeatResetCooldownEnd();
  }
}

public class GRNCPDCallSuccessCooldownEndCallback extends DelayCallback {
    let handler: wref<GRNCPDHandler>;
    public static func Create(handler: ref<GRNCPDHandler>) -> ref<GRNCPDCallSuccessCooldownEndCallback> {
        let self: ref<GRNCPDCallSuccessCooldownEndCallback> = new GRNCPDCallSuccessCooldownEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnCallSuccessCooldownEnd();
  }
}

public class GRNCPDCallSuccessDelayArrivalCallback extends DelayCallback {
    let handler: wref<GRNCPDHandler>;
    public static func Create(handler: ref<GRNCPDHandler>) -> ref<GRNCPDCallSuccessDelayArrivalCallback> {
        let self: ref<GRNCPDCallSuccessDelayArrivalCallback> = new GRNCPDCallSuccessDelayArrivalCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
	this.handler.CompleteReinforcementCall();
  }
}