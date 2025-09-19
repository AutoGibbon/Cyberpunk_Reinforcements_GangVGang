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
        this.delaySystem.DelayCallback(WraithsHeatResetCooldownEndCallback.Create(this), this.GetHeatResetCooldown(), true);
    }

    public func OnCallSuccessCooldownStart() -> Void {
        this.delaySystem.DelayCallback(WraithsCallSuccessCooldownEndCallback.Create(this), this.GetCallSuccessCooldown(), true);
    }

    public func OnGraceStart() -> Void {
        this.delaySystem.DelayCallback(WraithsGraceEndCallback.Create(this), this.GetGraceTime(), true);
    }

    public func GetTurfList() -> array<String> {
        return [
            "Badlands"
        ];
    }
}

public class WraithsGraceEndCallback extends DelayCallback {
    let handler: wref<GRWraithsHandler>;
    public static func Create(handler: ref<GRWraithsHandler>) -> ref<WraithsGraceEndCallback> {
        let self: ref<WraithsGraceEndCallback> = new WraithsGraceEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnGraceEnd();
  }
}

public class WraithsHeatResetCooldownEndCallback extends DelayCallback {
    let handler: wref<GRWraithsHandler>;
    public static func Create(handler: ref<GRWraithsHandler>) -> ref<WraithsHeatResetCooldownEndCallback> {
        let self: ref<WraithsHeatResetCooldownEndCallback> = new WraithsHeatResetCooldownEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnHeatResetCooldownEnd();
  }
}

public class WraithsCallSuccessCooldownEndCallback extends DelayCallback {
    let handler: wref<GRWraithsHandler>;
    public static func Create(handler: ref<GRWraithsHandler>) -> ref<WraithsCallSuccessCooldownEndCallback> {
        let self: ref<WraithsCallSuccessCooldownEndCallback> = new WraithsCallSuccessCooldownEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnCallSuccessCooldownEnd();
  }
}