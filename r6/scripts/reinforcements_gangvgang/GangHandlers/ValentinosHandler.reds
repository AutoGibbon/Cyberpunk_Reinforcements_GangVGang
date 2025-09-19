module Gibbon.GR.GangHandlers

import Gibbon.GR.GangData.*
import Gibbon.GR.Settings.GRSettings


public class GRValentinosHandler extends GRGangHandler {
    private final func OnPlayerAttach(request: ref<PlayerAttachRequest>) -> Void { 
        let game = GetGameInstance();
        this.reinforcementData = new GRValentinoData();
        this.preventionSystem = GameInstance.GetScriptableSystemsContainer(game).Get(n"PreventionSystem") as PreventionSystem;
        this.delaySystem = GameInstance.GetDelaySystem(game);
        this.settings = GRSettings.GetInstance(game);
        this.affiliation = gamedataAffiliation.Valentinos;
        this.waveCounterUniqueId = 10000;
    }

    public static func GetInstance(gameInstance: GameInstance) -> ref<GRValentinosHandler> {
        let system: ref<GRValentinosHandler> = GameInstance.GetScriptableSystemsContainer(gameInstance).Get(n"Gibbon.GR.GangHandlers.GRValentinosHandler") as GRValentinosHandler;
        return system;
    }

    public func OnHeatResetCooldownStart() -> Void {
        this.delaySystem.DelayCallback(GRValentinosHeatResetCooldownEndCallback.Create(this), this.GetHeatResetCooldown(), true);
    }

    public func OnCallSuccessCooldownStart() -> Void {
        this.delaySystem.DelayCallback(GRValentinosCallSuccessCooldownEndCallback.Create(this), this.GetCallSuccessCooldown(), true);
    }

    public func OnGraceStart() -> Void {
        this.delaySystem.DelayCallback(GRValentinosGraceEndCallback.Create(this), this.GetGraceTime(), true);
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