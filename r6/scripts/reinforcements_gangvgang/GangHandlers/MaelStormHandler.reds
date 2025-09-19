module Gibbon.GR.GangHandlers

import Gibbon.GR.GangData.*
import Gibbon.GR.Settings.GRSettings


public class GRMaelStromHandler extends GRGangHandler {
    private final func OnPlayerAttach(request: ref<PlayerAttachRequest>) -> Void { 
        let game = GetGameInstance();
        this.reinforcementData = new GRMaelstormData();
        this.preventionSystem = GameInstance.GetScriptableSystemsContainer(game).Get(n"PreventionSystem") as PreventionSystem;
        this.delaySystem = GameInstance.GetDelaySystem(game);
        this.settings = GRSettings.GetInstance(game);
        this.affiliation = gamedataAffiliation.Maelstrom;
        this.waveCounterUniqueId = 5000;
    }

    public static func GetInstance(gameInstance: GameInstance) -> ref<GRMaelStromHandler> {
        let system: ref<GRMaelStromHandler> = GameInstance.GetScriptableSystemsContainer(gameInstance).Get(n"Gibbon.GR.GangHandlers.GRMaelStromHandler") as GRMaelStromHandler;
        return system;
    }

    public func GetTurfList() -> array<String> {
        return ["Watson"];
    }

    public func OnGraceStart() -> Void {
        this.delaySystem.DelayCallback(MaelstromGraceEndCallback.Create(this), this.GetGraceTime(), true);
    }

    public func OnHeatResetCooldownStart() -> Void {
        this.delaySystem.DelayCallback(MaelstromHeatResetCooldownEndCallback.Create(this), this.GetHeatResetCooldown(), true);
    }

    public func OnCallSuccessCooldownStart() -> Void {
        this.delaySystem.DelayCallback(MaelstromCallSuccessCooldownEndCallback.Create(this), this.GetCallSuccessCooldown(), true);
    }
}

public class MaelstromGraceEndCallback extends DelayCallback {
    let handler: wref<GRMaelStromHandler>;
    public static func Create(handler: ref<GRMaelStromHandler>) -> ref<MaelstromGraceEndCallback> {
        let self: ref<MaelstromGraceEndCallback> = new MaelstromGraceEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnGraceEnd();
  }
}

public class MaelstromHeatResetCooldownEndCallback extends DelayCallback {
    let handler: wref<GRMaelStromHandler>;
    public static func Create(handler: ref<GRMaelStromHandler>) -> ref<MaelstromHeatResetCooldownEndCallback> {
        let self: ref<MaelstromHeatResetCooldownEndCallback> = new MaelstromHeatResetCooldownEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnHeatResetCooldownEnd();
  }
}

public class MaelstromCallSuccessCooldownEndCallback extends DelayCallback {
    let handler: wref<GRMaelStromHandler>;
    public static func Create(handler: ref<GRMaelStromHandler>) -> ref<MaelstromCallSuccessCooldownEndCallback> {
        let self: ref<MaelstromCallSuccessCooldownEndCallback> = new MaelstromCallSuccessCooldownEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnCallSuccessCooldownEnd();
  }
}
