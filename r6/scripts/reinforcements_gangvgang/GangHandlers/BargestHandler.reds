module Gibbon.GR.GangHandlers

import Gibbon.GR.GangData.*
import Gibbon.GR.Settings.GRSettings


public class GRBarghestHandler extends GRGangHandler {
    private final func OnPlayerAttach(request: ref<PlayerAttachRequest>) -> Void { 
        let game = GetGameInstance();
        this.reinforcementData = new GRBarghestData();
        this.preventionSystem = GameInstance.GetScriptableSystemsContainer(game).Get(n"PreventionSystem") as PreventionSystem;
        this.delaySystem = GameInstance.GetDelaySystem(game);
        this.settings = GRSettings.GetInstance(game);
        this.affiliation = gamedataAffiliation.Barghest;
        this.waveCounterUniqueId = 4000;
    }

    public static func GetInstance(gameInstance: GameInstance) -> ref<GRBarghestHandler> {
        let system: ref<GRBarghestHandler> = GameInstance.GetScriptableSystemsContainer(gameInstance).Get(n"Gibbon.GR.GangHandlers.GRBarghestHandler") as GRBarghestHandler;
        return system;
    }

    public func OnHeatResetCooldownStart() -> Void {
        this.delaySystem.DelayCallback(GRBarghestHeatResetCooldownEndCallback.Create(this), this.GetHeatResetCooldown(), true);
    }

    public func OnCallSuccessCooldownStart() -> Void {
        this.delaySystem.DelayCallback(GRBarghestCallSuccessCooldownEndCallback.Create(this), this.GetCallSuccessCooldown(), true);
    }

    public func OnGraceStart() -> Void {
        this.delaySystem.DelayCallback(GRBarghestGraceEndCallback.Create(this), this.GetGraceTime(), true);
    }

    public func GetTurfList() -> array<String> {
        return [
            "Dogtown"
        ];
    }
}

public class GRBarghestGraceEndCallback extends DelayCallback {
    let handler: wref<GRBarghestHandler>;
    public static func Create(handler: ref<GRBarghestHandler>) -> ref<GRBarghestGraceEndCallback> {
        let self: ref<GRBarghestGraceEndCallback> = new GRBarghestGraceEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnGraceEnd();
  }
}

public class GRBarghestHeatResetCooldownEndCallback extends DelayCallback {
    let handler: wref<GRBarghestHandler>;
    public static func Create(handler: ref<GRBarghestHandler>) -> ref<GRBarghestHeatResetCooldownEndCallback> {
        let self: ref<GRBarghestHeatResetCooldownEndCallback> = new GRBarghestHeatResetCooldownEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnHeatResetCooldownEnd();
  }
}

public class GRBarghestCallSuccessCooldownEndCallback extends DelayCallback {
    let handler: wref<GRBarghestHandler>;
    public static func Create(handler: ref<GRBarghestHandler>) -> ref<GRBarghestCallSuccessCooldownEndCallback> {
        let self: ref<GRBarghestCallSuccessCooldownEndCallback> = new GRBarghestCallSuccessCooldownEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnCallSuccessCooldownEnd();
  }
}