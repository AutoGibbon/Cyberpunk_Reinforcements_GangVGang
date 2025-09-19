module Gibbon.GR.GangHandlers

import Gibbon.GR.GangData.*
import Gibbon.GR.Settings.GRSettings


public class GRNCPDHandler extends GRGangHandler {
    private final func OnPlayerAttach(request: ref<PlayerAttachRequest>) -> Void { 
        let game = GetGameInstance();
        this.reinforcementData = new GRNCPDData();
        this.preventionSystem = GameInstance.GetScriptableSystemsContainer(game).Get(n"PreventionSystem") as PreventionSystem;
        this.delaySystem = GameInstance.GetDelaySystem(game);
        this.settings = GRSettings.GetInstance(game);
        this.affiliation = gamedataAffiliation.NCPD;
        this.waveCounterUniqueId = 7000;
    }

    public static func GetInstance(gameInstance: GameInstance) -> ref<GRNCPDHandler> {
        let system: ref<GRNCPDHandler> = GameInstance.GetScriptableSystemsContainer(gameInstance).Get(n"Gibbon.GR.GangHandlers.GRNCPDHandler") as GRNCPDHandler;
        return system;
    }

    public func OnHeatResetCooldownStart() -> Void {
        this.delaySystem.DelayCallback(NCPDHeatResetCooldownEndCallback.Create(this), this.GetHeatResetCooldown(), true);
    }

    public func OnCallSuccessCooldownStart() -> Void {
        this.delaySystem.DelayCallback(NCPDCallSuccessCooldownEndCallback.Create(this), this.GetCallSuccessCooldown(), true);
    }

    public func OnGraceStart() -> Void {
        this.delaySystem.DelayCallback(NCPDGraceEndCallback.Create(this), this.GetGraceTime(), true);
    }

    public func GetTurfList() -> array<String> {
        return [];
    }
}

public class NCPDGraceEndCallback extends DelayCallback {
    let handler: wref<GRNCPDHandler>;
    public static func Create(handler: ref<GRNCPDHandler>) -> ref<NCPDGraceEndCallback> {
        let self: ref<NCPDGraceEndCallback> = new NCPDGraceEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnGraceEnd();
  }
}

public class NCPDHeatResetCooldownEndCallback extends DelayCallback {
    let handler: wref<GRNCPDHandler>;
    public static func Create(handler: ref<GRNCPDHandler>) -> ref<NCPDHeatResetCooldownEndCallback> {
        let self: ref<NCPDHeatResetCooldownEndCallback> = new NCPDHeatResetCooldownEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnHeatResetCooldownEnd();
  }
}

public class NCPDCallSuccessCooldownEndCallback extends DelayCallback {
    let handler: wref<GRNCPDHandler>;
    public static func Create(handler: ref<GRNCPDHandler>) -> ref<NCPDCallSuccessCooldownEndCallback> {
        let self: ref<NCPDCallSuccessCooldownEndCallback> = new NCPDCallSuccessCooldownEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnCallSuccessCooldownEnd();
  }
}