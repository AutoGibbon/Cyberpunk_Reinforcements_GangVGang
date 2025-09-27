module Gibbon.GR.GangHandlers

import Gibbon.GR.GangData.*
import Gibbon.GR.Settings.GRSettings


public class GRScavsHandler extends GRGangHandler {
    private final func OnPlayerAttach(request: ref<PlayerAttachRequest>) -> Void { 
        let game = GetGameInstance();
        this.reinforcementData = new GRScavData();
        this.preventionSystem = GameInstance.GetScriptableSystemsContainer(game).Get(n"PreventionSystem") as PreventionSystem;
        this.delaySystem = GameInstance.GetDelaySystem(game);
        this.settings = GRSettings.GetInstance(game);
        this.affiliation = gamedataAffiliation.Scavengers;
        this.waveCounterUniqueId = 8000;
    }

    public static func GetInstance(gameInstance: GameInstance) -> ref<GRScavsHandler> {
        let system: ref<GRScavsHandler> = GameInstance.GetScriptableSystemsContainer(gameInstance).Get(n"Gibbon.GR.GangHandlers.GRScavsHandler") as GRScavsHandler;
        return system;
    }

    public func GetTurfList() -> array<String> {
        return [];
    }

    public func OnGraceStart() -> Void {
        this.delaySystem.DelayCallback(GRScavGraceEndCallback.Create(this), this.GetGraceTime(), true);
    }

    public func OnHeatResetCooldownStart() -> Void {
        this.delaySystem.DelayCallback(GRScavHeatResetCooldownEndCallback.Create(this), this.GetHeatResetCooldown(), true);
    }

    public func OnCallSuccessCooldownStart() -> Void {
        this.delaySystem.DelayCallback(GRScavCallSuccessCooldownEndCallback.Create(this), this.GetCallSuccessCooldown(), true);
    }

	public func OnCallSuccessDelayArrival(isTurf: Bool) -> Void {
        let backupDelay = this.GetBackupDelay(isTurf);
        this.delaySystem.DelayCallback(GRScavCallSuccessDelayArrivalCallback.Create(this), backupDelay, true);
    }
}

public class GRScavGraceEndCallback extends DelayCallback {
    let handler: wref<GRScavsHandler>;
    public static func Create(handler: ref<GRScavsHandler>) -> ref<GRScavGraceEndCallback> {
        let self: ref<GRScavGraceEndCallback> = new GRScavGraceEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnGraceEnd();
  }
}

public class GRScavHeatResetCooldownEndCallback extends DelayCallback {
    let handler: wref<GRScavsHandler>;
    public static func Create(handler: ref<GRScavsHandler>) -> ref<GRScavHeatResetCooldownEndCallback> {
        let self: ref<GRScavHeatResetCooldownEndCallback> = new GRScavHeatResetCooldownEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnHeatResetCooldownEnd();
  }
}

public class GRScavCallSuccessCooldownEndCallback extends DelayCallback {
    let handler: wref<GRScavsHandler>;
    public static func Create(handler: ref<GRScavsHandler>) -> ref<GRScavCallSuccessCooldownEndCallback> {
        let self: ref<GRScavCallSuccessCooldownEndCallback> = new GRScavCallSuccessCooldownEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnCallSuccessCooldownEnd();
  }
}

public class GRScavCallSuccessDelayArrivalCallback extends DelayCallback {
    let handler: wref<GRScavsHandler>;
    public static func Create(handler: ref<GRScavsHandler>) -> ref<GRScavCallSuccessDelayArrivalCallback> {
        let self: ref<GRScavCallSuccessDelayArrivalCallback> = new GRScavCallSuccessDelayArrivalCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
	this.handler.CompleteReinforcementCall();
  }
}