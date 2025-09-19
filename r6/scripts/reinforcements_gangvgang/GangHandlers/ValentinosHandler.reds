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
        this.delaySystem.DelayCallback(ValentinosHeatResetCooldownEndCallback.Create(this), this.GetHeatResetCooldown(), true);
    }

    public func OnCallSuccessCooldownStart() -> Void {
        this.delaySystem.DelayCallback(ValentinosCallSuccessCooldownEndCallback.Create(this), this.GetCallSuccessCooldown(), true);
    }

    public func OnGraceStart() -> Void {
        this.delaySystem.DelayCallback(ValentinosGraceEndCallback.Create(this), this.GetGraceTime(), true);
    }

    public func GetTurfList() -> array<String> {
        return [
            "Heywood"
        ];
    }
}

public class ValentinosGraceEndCallback extends DelayCallback {
    let handler: wref<GRValentinosHandler>;
    public static func Create(handler: ref<GRValentinosHandler>) -> ref<ValentinosGraceEndCallback> {
        let self: ref<ValentinosGraceEndCallback> = new ValentinosGraceEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnGraceEnd();
  }
}

public class ValentinosHeatResetCooldownEndCallback extends DelayCallback {
    let handler: wref<GRValentinosHandler>;
    public static func Create(handler: ref<GRValentinosHandler>) -> ref<ValentinosHeatResetCooldownEndCallback> {
        let self: ref<ValentinosHeatResetCooldownEndCallback> = new ValentinosHeatResetCooldownEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnHeatResetCooldownEnd();
  }
}

public class ValentinosCallSuccessCooldownEndCallback extends DelayCallback {
    let handler: wref<GRValentinosHandler>;
    public static func Create(handler: ref<GRValentinosHandler>) -> ref<ValentinosCallSuccessCooldownEndCallback> {
        let self: ref<ValentinosCallSuccessCooldownEndCallback> = new ValentinosCallSuccessCooldownEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnCallSuccessCooldownEnd();
  }
}