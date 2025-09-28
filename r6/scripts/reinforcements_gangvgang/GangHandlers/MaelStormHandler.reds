module Gibbon.GR.GangHandlers

import Gibbon.GR.GangData.*
import Gibbon.GR.Settings.GRSettings


public class GRMaelStromHandler extends GRGangHandler {
    private final func OnPlayerAttach(request: ref<PlayerAttachRequest>) -> Void { 
        let game = GetGameInstance();
        this.m_reinforcementData = new GRMaelstormData();
        this.m_preventionSystem = GameInstance.GetScriptableSystemsContainer(game).Get(n"PreventionSystem") as PreventionSystem;
        this.m_delaySystem = GameInstance.GetDelaySystem(game);
        this.m_settings = GRSettings.GetInstance(game);
        this.m_affiliation = gamedataAffiliation.Maelstrom;
        this.m_waveCounterUniqueId = 5000;
        
    }

    public static func GetInstance(gameInstance: GameInstance) -> ref<GRMaelStromHandler> {
        let system: ref<GRMaelStromHandler> = GameInstance.GetScriptableSystemsContainer(gameInstance).Get(n"Gibbon.GR.GangHandlers.GRMaelStromHandler") as GRMaelStromHandler;
        return system;
    }

    public func GetTurfList() -> array<String> {
        return ["Watson"];
    }

    public func OnGraceStart() -> Void {
        this.m_delaySystem.DelayCallback(GRMaelstromGraceEndCallback.Create(this), this.GetGraceTime(), true);
    }

    public func OnHeatResetCooldownStart() -> Void {
        this.m_delaySystem.DelayCallback(GRMaelstromHeatResetCooldownEndCallback.Create(this), this.GetHeatResetCooldown(), true);
    }

    public func OnCallSuccessCooldownStart() -> Void {
        this.m_delaySystem.DelayCallback(GRMaelstromCallSuccessCooldownEndCallback.Create(this), this.GetCallSuccessCooldown(), true);
    }

	public func OnCallSuccessDelayArrival(isTurf: Bool) -> Void {
        let backupDelay = this.GetBackupDelay(isTurf);
        this.m_delaySystem.DelayCallback(GRMaelstromCallSuccessDelayArrivalCallback.Create(this), backupDelay, true);
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