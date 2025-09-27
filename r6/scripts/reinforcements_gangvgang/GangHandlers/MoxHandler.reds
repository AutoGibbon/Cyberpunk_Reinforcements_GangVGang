module Gibbon.GR.GangHandlers

import Gibbon.GR.GangData.*
import Gibbon.GR.Settings.GRSettings


public class GRMoxHandler extends GRGangHandler {
    private final func OnPlayerAttach(request: ref<PlayerAttachRequest>) -> Void { 
        let game = GetGameInstance();
        this.reinforcementData = new GRMoxData();
        this.preventionSystem = GameInstance.GetScriptableSystemsContainer(game).Get(n"PreventionSystem") as PreventionSystem;
        this.delaySystem = GameInstance.GetDelaySystem(game);
        this.settings = GRSettings.GetInstance(game);
        this.affiliation = gamedataAffiliation.TheMox;
        this.waveCounterUniqueId = 13000;
        
    }

    public static func GetInstance(gameInstance: GameInstance) -> ref<GRMoxHandler> {
        let system: ref<GRMoxHandler> = GameInstance.GetScriptableSystemsContainer(gameInstance).Get(n"Gibbon.GR.GangHandlers.GRMoxHandler") as GRMoxHandler;
        return system;
    }
 

    public func GetTurfList() -> array<String> {
        return ["Kabuki"];
    }
    
    public func OnGraceStart() -> Void {
        this.delaySystem.DelayCallback(GRMoxEndCallback.Create(this), this.GetGraceTime(), true);
    }

    public func OnHeatResetCooldownStart() -> Void {
        this.delaySystem.DelayCallback(GRMoxHeatResetCooldownEndCallback.Create(this), this.GetHeatResetCooldown(), true);
    }

    public func OnCallSuccessCooldownStart() -> Void {
        this.delaySystem.DelayCallback(GRMoxCallSuccessCooldownEndCallback.Create(this), this.GetCallSuccessCooldown(), true);
    }

	public func OnCallSuccessDelayArrival(isTurf: Bool) -> Void {
        let backupDelay = this.GetBackupDelay(isTurf);
        this.delaySystem.DelayCallback(GRMoxCallSuccessDelayArrivalCallback.Create(this), backupDelay, true);
    }
}

public class GRMoxEndCallback extends DelayCallback {
    let handler: wref<GRMoxHandler>;
    public static func Create(handler: ref<GRMoxHandler>) -> ref<GRMoxEndCallback> {
        let self: ref<GRMoxEndCallback> = new GRMoxEndCallback();
        
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnGraceEnd();
  }
}

public class GRMoxHeatResetCooldownEndCallback extends DelayCallback {
    let handler: wref<GRMoxHandler>;
    public static func Create(handler: ref<GRMoxHandler>) -> ref<GRMoxHeatResetCooldownEndCallback> {
        let self: ref<GRMoxHeatResetCooldownEndCallback> = new GRMoxHeatResetCooldownEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnHeatResetCooldownEnd();
  }
}

public class GRMoxCallSuccessCooldownEndCallback extends DelayCallback {
    let handler: wref<GRMoxHandler>;
    public static func Create(handler: ref<GRMoxHandler>) -> ref<GRMoxCallSuccessCooldownEndCallback> {
        let self: ref<GRMoxCallSuccessCooldownEndCallback> = new GRMoxCallSuccessCooldownEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnCallSuccessCooldownEnd();
  }
}

public class GRMoxCallSuccessDelayArrivalCallback extends DelayCallback {
    let handler: wref<GRMoxHandler>;
    public static func Create(handler: ref<GRMoxHandler>) -> ref<GRMoxCallSuccessDelayArrivalCallback> {
        let self: ref<GRMoxCallSuccessDelayArrivalCallback> = new GRMoxCallSuccessDelayArrivalCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
	this.handler.CompleteReinforcementCall();
  }
}