module Gibbon.GR.GangHandlers

import Gibbon.GR.GangData.*
import Gibbon.GR.Settings.GRSettings


public class GRTygersHandler extends GRGangHandler {
    private final func OnPlayerAttach(request: ref<PlayerAttachRequest>) -> Void { 
        let game = GetGameInstance();
        this.m_reinforcementData = new GRTygerData();
        this.m_preventionSystem = GameInstance.GetScriptableSystemsContainer(game).Get(n"PreventionSystem") as PreventionSystem;
        this.m_delaySystem = GameInstance.GetDelaySystem(game);
        this.m_settings = GRSettings.GetInstance(game);
        this.m_affiliation = gamedataAffiliation.TygerClaws;
        this.m_waveCounterUniqueId = 9000;
        
    }

    public static func GetInstance(gameInstance: GameInstance) -> ref<GRTygersHandler> {
        let system: ref<GRTygersHandler> = GameInstance.GetScriptableSystemsContainer(gameInstance).Get(n"Gibbon.GR.GangHandlers.GRTygersHandler") as GRTygersHandler;
        return system;
    }
 

    public func GetTurfList() -> array<String> {
        return ["Westbrook"];
    }
    
    public func OnGraceStart() -> Void {
        this.m_delaySystem.DelayCallback(GRTygerEndCallback.Create(this), this.GetGraceTime(), true);
    }

    public func OnHeatResetCooldownStart() -> Void {
        this.m_delaySystem.DelayCallback(GRTygerHeatResetCooldownEndCallback.Create(this), this.GetHeatResetCooldown(), true);
    }

    public func OnCallSuccessCooldownStart() -> Void {
        this.m_delaySystem.DelayCallback(GRTygerCallSuccessCooldownEndCallback.Create(this), this.GetCallSuccessCooldown(), true);
    }

	public func OnCallSuccessDelayArrival(isTurf: Bool) -> Void {
        let backupDelay = this.GetBackupDelay(isTurf);
        this.m_delaySystem.DelayCallback(GRTygerCallSuccessDelayArrivalCallback.Create(this), backupDelay, true);
    }
}

public class GRTygerEndCallback extends DelayCallback {
    let handler: wref<GRTygersHandler>;
    public static func Create(handler: ref<GRTygersHandler>) -> ref<GRTygerEndCallback> {
        let self: ref<GRTygerEndCallback> = new GRTygerEndCallback();
        
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnGraceEnd();
  }
}

public class GRTygerHeatResetCooldownEndCallback extends DelayCallback {
    let handler: wref<GRTygersHandler>;
    public static func Create(handler: ref<GRTygersHandler>) -> ref<GRTygerHeatResetCooldownEndCallback> {
        let self: ref<GRTygerHeatResetCooldownEndCallback> = new GRTygerHeatResetCooldownEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnHeatResetCooldownEnd();
  }
}

public class GRTygerCallSuccessCooldownEndCallback extends DelayCallback {
    let handler: wref<GRTygersHandler>;
    public static func Create(handler: ref<GRTygersHandler>) -> ref<GRTygerCallSuccessCooldownEndCallback> {
        let self: ref<GRTygerCallSuccessCooldownEndCallback> = new GRTygerCallSuccessCooldownEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnCallSuccessCooldownEnd();
  }
}

public class GRTygerCallSuccessDelayArrivalCallback extends DelayCallback {
    let handler: wref<GRTygersHandler>;
    public static func Create(handler: ref<GRTygersHandler>) -> ref<GRTygerCallSuccessDelayArrivalCallback> {
        let self: ref<GRTygerCallSuccessDelayArrivalCallback> = new GRTygerCallSuccessDelayArrivalCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
	this.handler.CompleteReinforcementCall();
  }
}