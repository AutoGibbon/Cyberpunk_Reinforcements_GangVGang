module Gibbon.GR.GangHandlers

import Gibbon.GR.GangData.*
import Gibbon.GR.Settings.GRSettings


public class GRArasakaHandler extends GRGangHandler {
    private final func OnPlayerAttach(request: ref<PlayerAttachRequest>) -> Void { 
        let game = GetGameInstance();
        this.reinforcementData = new GRArasakaData();
        this.preventionSystem = GameInstance.GetScriptableSystemsContainer(game).Get(n"PreventionSystem") as PreventionSystem;
        this.delaySystem = GameInstance.GetDelaySystem(game);
        this.settings = GRSettings.GetInstance(game);
        this.affiliation = gamedataAffiliation.Arasaka;
        this.waveCounterUniqueId = 3000;
    }

    public static func GetInstance(gameInstance: GameInstance) -> ref<GRArasakaHandler> {
        let system: ref<GRArasakaHandler> = GameInstance.GetScriptableSystemsContainer(gameInstance).Get(n"Gibbon.GR.GangHandlers.GRArasakaHandler") as GRArasakaHandler;
        return system;
    }

    public func OnHeatResetCooldownStart() -> Void {
        this.delaySystem.DelayCallback(ArasakaHeatResetCooldownEndCallback.Create(this), this.GetHeatResetCooldown(), true);
    }

    public func OnCallSuccessCooldownStart() -> Void {
        this.delaySystem.DelayCallback(ArasakaCallSuccessCooldownEndCallback.Create(this), this.GetCallSuccessCooldown(), true);
    }

    public func OnGraceStart() -> Void {
        this.delaySystem.DelayCallback(ArasakaGraceEndCallback.Create(this), this.GetGraceTime(), true);
    }

    public func GetTurfList() -> array<String> {
        return [];
    }
}

public class ArasakaGraceEndCallback extends DelayCallback {
    let handler: wref<GRArasakaHandler>;
    public static func Create(handler: ref<GRArasakaHandler>) -> ref<ArasakaGraceEndCallback> {
        let self: ref<ArasakaGraceEndCallback> = new ArasakaGraceEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnGraceEnd();
  }
}

public class ArasakaHeatResetCooldownEndCallback extends DelayCallback {
    let handler: wref<GRArasakaHandler>;
    public static func Create(handler: ref<GRArasakaHandler>) -> ref<ArasakaHeatResetCooldownEndCallback> {
        let self: ref<ArasakaHeatResetCooldownEndCallback> = new ArasakaHeatResetCooldownEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnHeatResetCooldownEnd();
  }
}

public class ArasakaCallSuccessCooldownEndCallback extends DelayCallback {
    let handler: wref<GRArasakaHandler>;
    public static func Create(handler: ref<GRArasakaHandler>) -> ref<ArasakaCallSuccessCooldownEndCallback> {
        let self: ref<ArasakaCallSuccessCooldownEndCallback> = new ArasakaCallSuccessCooldownEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnCallSuccessCooldownEnd();
  }
}