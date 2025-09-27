module Gibbon.GR.GangHandlers

import Gibbon.GR.GangData.*
import Gibbon.GR.Settings.GRSettings


public class GRWraithsHandler extends GRGangHandler {
    private final func OnPlayerAttach(request: ref<PlayerAttachRequest>) -> Void { 
        let game = GetGameInstance();
        this.reinforcementData = new GRWraithsData();
        this.preventionSystem = GameInstance.GetScriptableSystemsContainer(game).Get(n"PreventionSystem") as PreventionSystem;
        this.delaySystem = GameInstance.GetDelaySystem(game);
        this.settings = GRSettings.GetInstance(game);
        this.affiliation = gamedataAffiliation.Wraiths;
        this.waveCounterUniqueId = 12000;
        
    }

    public static func GetInstance(gameInstance: GameInstance) -> ref<GRWraithsHandler> {
        let system: ref<GRWraithsHandler> = GameInstance.GetScriptableSystemsContainer(gameInstance).Get(n"Gibbon.GR.GangHandlers.GRWraithsHandler") as GRWraithsHandler;
        return system;
    }

    public func OnHeatResetCooldownStart() -> Void {
        this.delaySystem.DelayCallback(GRWraithsHeatResetCooldownEndCallback.Create(this), this.GetHeatResetCooldown(), true);
    }

    public func OnCallSuccessCooldownStart() -> Void {
        this.delaySystem.DelayCallback(GRWraithsCallSuccessCooldownEndCallback.Create(this), this.GetCallSuccessCooldown(), true);
    }

    public func OnGraceStart() -> Void {
        this.delaySystem.DelayCallback(GRWraithsGraceEndCallback.Create(this), this.GetGraceTime(), true);
    }

	public func OnCallSuccessDelayArrival(isTurf: Bool) -> Void {
        let backupDelay = this.GetBackupDelay(isTurf);
        this.delaySystem.DelayCallback(GRWraithsCallSuccessDelayArrivalCallback.Create(this), backupDelay, true);
    }

    public func GetTurfList() -> array<String> {
        return [
            "Badlands"
        ];
    }
}

public class GRWraithsGraceEndCallback extends DelayCallback {
    let handler: wref<GRWraithsHandler>;
    public static func Create(handler: ref<GRWraithsHandler>) -> ref<GRWraithsGraceEndCallback> {
        let self: ref<GRWraithsGraceEndCallback> = new GRWraithsGraceEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnGraceEnd();
  }
}

public class GRWraithsHeatResetCooldownEndCallback extends DelayCallback {
    let handler: wref<GRWraithsHandler>;
    public static func Create(handler: ref<GRWraithsHandler>) -> ref<GRWraithsHeatResetCooldownEndCallback> {
        let self: ref<GRWraithsHeatResetCooldownEndCallback> = new GRWraithsHeatResetCooldownEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnHeatResetCooldownEnd();
  }
}

public class GRWraithsCallSuccessCooldownEndCallback extends DelayCallback {
    let handler: wref<GRWraithsHandler>;
    public static func Create(handler: ref<GRWraithsHandler>) -> ref<GRWraithsCallSuccessCooldownEndCallback> {
        let self: ref<GRWraithsCallSuccessCooldownEndCallback> = new GRWraithsCallSuccessCooldownEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnCallSuccessCooldownEnd();
  }
}

public class GRWraithsCallSuccessDelayArrivalCallback extends DelayCallback {
    let handler: wref<GRWraithsHandler>;
    public static func Create(handler: ref<GRWraithsHandler>) -> ref<GRWraithsCallSuccessDelayArrivalCallback> {
        let self: ref<GRWraithsCallSuccessDelayArrivalCallback> = new GRWraithsCallSuccessDelayArrivalCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
	this.handler.CompleteReinforcementCall();
  }
}