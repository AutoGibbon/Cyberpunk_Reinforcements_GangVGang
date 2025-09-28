module Gibbon.GR.GangHandlers

import Gibbon.GR.GangData.*
import Gibbon.GR.Settings.GRSettings


public class GRNCPDHandler extends GRGangHandler {
    private final func OnPlayerAttach(request: ref<PlayerAttachRequest>) -> Void { 
        let game = GetGameInstance();
        this.m_reinforcementData = new GRNCPDData();
        this.m_preventionSystem = GameInstance.GetScriptableSystemsContainer(game).Get(n"PreventionSystem") as PreventionSystem;
        this.m_delaySystem = GameInstance.GetDelaySystem(game);
        this.m_settings = GRSettings.GetInstance(game);
        this.m_affiliation = gamedataAffiliation.NCPD;
        this.m_waveCounterUniqueId = 7000;
        
    }

    public static func GetInstance(gameInstance: GameInstance) -> ref<GRNCPDHandler> {
        let system: ref<GRNCPDHandler> = GameInstance.GetScriptableSystemsContainer(gameInstance).Get(n"Gibbon.GR.GangHandlers.GRNCPDHandler") as GRNCPDHandler;
        return system;
    }

    public func OnHeatResetCooldownStart() -> Void {
        this.m_delaySystem.DelayCallback(GRNCPDHeatResetCooldownEndCallback.Create(this), this.GetHeatResetCooldown(), true);
    }

    public func OnCallSuccessCooldownStart() -> Void {
        this.m_delaySystem.DelayCallback(GRNCPDCallSuccessCooldownEndCallback.Create(this), this.GetCallSuccessCooldown(), true);
    }

    public func OnGraceStart() -> Void {
        this.m_delaySystem.DelayCallback(GRNCPDGraceEndCallback.Create(this), this.GetGraceTime(), true);
    }

	public func OnCallSuccessDelayArrival(isTurf: Bool) -> Void {
        let backupDelay = this.GetBackupDelay(isTurf);
        this.m_delaySystem.DelayCallback(GRNCPDCallSuccessDelayArrivalCallback.Create(this), backupDelay, true);
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