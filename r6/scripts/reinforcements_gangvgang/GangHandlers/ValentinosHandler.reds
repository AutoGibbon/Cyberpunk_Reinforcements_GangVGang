module Gibbon.GR.GangHandlers

import Gibbon.GR.GangData.*
import Gibbon.GR.Settings.GRSettings


public class GRValentinosHandler extends GRGangHandler {
    private final func OnPlayerAttach(request: ref<PlayerAttachRequest>) -> Void { 
        let game = GetGameInstance();
        this.m_reinforcementData = new GRValentinoData();
        this.m_preventionSystem = GameInstance.GetScriptableSystemsContainer(game).Get(n"PreventionSystem") as PreventionSystem;
        this.m_delaySystem = GameInstance.GetDelaySystem(game);
        this.m_settings = GRSettings.GetInstance(game);
        this.m_affiliation = gamedataAffiliation.Valentinos;
        this.m_waveCounterUniqueId = 10000;
        
    }

    public static func GetInstance(gameInstance: GameInstance) -> ref<GRValentinosHandler> {
        let system: ref<GRValentinosHandler> = GameInstance.GetScriptableSystemsContainer(gameInstance).Get(n"Gibbon.GR.GangHandlers.GRValentinosHandler") as GRValentinosHandler;
        return system;
    }

    public func OnHeatResetCooldownStart() -> Void {
        this.m_delaySystem.DelayCallback(GRValentinosHeatResetCooldownEndCallback.Create(this), this.GetHeatResetCooldown(), true);
    }

    public func OnCallSuccessCooldownStart() -> Void {
        this.m_delaySystem.DelayCallback(GRValentinosCallSuccessCooldownEndCallback.Create(this), this.GetCallSuccessCooldown(), true);
    }

    public func OnGraceStart() -> Void {
        this.m_delaySystem.DelayCallback(GRValentinosGraceEndCallback.Create(this), this.GetGraceTime(), true);
    }

	public func OnCallSuccessDelayArrival(isTurf: Bool) -> Void {
        let backupDelay = this.GetBackupDelay(isTurf);
        this.m_delaySystem.DelayCallback(GRValentinosCallSuccessDelayArrivalCallback.Create(this), backupDelay, true);
    }

    public func GetTurfList() -> array<String> {
        return [
            "Heywood"
        ];
    }
}

public class GRValentinosGraceEndCallback extends DelayCallback {
    let handler: wref<GRValentinosHandler>;
    public static func Create(handler: ref<GRValentinosHandler>) -> ref<GRValentinosGraceEndCallback> {
        let self: ref<GRValentinosGraceEndCallback> = new GRValentinosGraceEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnGraceEnd();
  }
}

public class GRValentinosHeatResetCooldownEndCallback extends DelayCallback {
    let handler: wref<GRValentinosHandler>;
    public static func Create(handler: ref<GRValentinosHandler>) -> ref<GRValentinosHeatResetCooldownEndCallback> {
        let self: ref<GRValentinosHeatResetCooldownEndCallback> = new GRValentinosHeatResetCooldownEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnHeatResetCooldownEnd();
  }
}

public class GRValentinosCallSuccessCooldownEndCallback extends DelayCallback {
    let handler: wref<GRValentinosHandler>;
    public static func Create(handler: ref<GRValentinosHandler>) -> ref<GRValentinosCallSuccessCooldownEndCallback> {
        let self: ref<GRValentinosCallSuccessCooldownEndCallback> = new GRValentinosCallSuccessCooldownEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnCallSuccessCooldownEnd();
  }
}

public class GRValentinosCallSuccessDelayArrivalCallback extends DelayCallback {
    let handler: wref<GRValentinosHandler>;
    public static func Create(handler: ref<GRValentinosHandler>) -> ref<GRValentinosCallSuccessDelayArrivalCallback> {
        let self: ref<GRValentinosCallSuccessDelayArrivalCallback> = new GRValentinosCallSuccessDelayArrivalCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
	this.handler.CompleteReinforcementCall();
  }
}