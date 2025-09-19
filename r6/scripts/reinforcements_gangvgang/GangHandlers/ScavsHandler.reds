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
        this.delaySystem.DelayCallback(ScavGraceEndCallback.Create(this), this.GetGraceTime(), true);
    }

    public func OnHeatResetCooldownStart() -> Void {
        this.delaySystem.DelayCallback(ScavHeatResetCooldownEndCallback.Create(this), this.GetHeatResetCooldown(), true);
    }

    public func OnCallSuccessCooldownStart() -> Void {
        this.delaySystem.DelayCallback(ScavCallSuccessCooldownEndCallback.Create(this), this.GetCallSuccessCooldown(), true);
    }
}

public class ScavGraceEndCallback extends DelayCallback {
    let handler: wref<GRScavsHandler>;
    public static func Create(handler: ref<GRScavsHandler>) -> ref<ScavGraceEndCallback> {
        let self: ref<ScavGraceEndCallback> = new ScavGraceEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnGraceEnd();
  }
}

public class ScavHeatResetCooldownEndCallback extends DelayCallback {
    let handler: wref<GRScavsHandler>;
    public static func Create(handler: ref<GRScavsHandler>) -> ref<ScavHeatResetCooldownEndCallback> {
        let self: ref<ScavHeatResetCooldownEndCallback> = new ScavHeatResetCooldownEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnHeatResetCooldownEnd();
  }
}

public class ScavCallSuccessCooldownEndCallback extends DelayCallback {
    let handler: wref<GRScavsHandler>;
    public static func Create(handler: ref<GRScavsHandler>) -> ref<ScavCallSuccessCooldownEndCallback> {
        let self: ref<ScavCallSuccessCooldownEndCallback> = new ScavCallSuccessCooldownEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnCallSuccessCooldownEnd();
  }
}