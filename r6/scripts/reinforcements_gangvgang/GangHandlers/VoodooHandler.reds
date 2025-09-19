module Gibbon.GR.GangHandlers

import Gibbon.GR.GangData.*
import Gibbon.GR.Settings.GRSettings


public class GRVoodooHandler extends GRGangHandler {
    private final func OnPlayerAttach(request: ref<PlayerAttachRequest>) -> Void { 
        let game = GetGameInstance();
        this.reinforcementData = new GRVoodooData();
        this.preventionSystem = GameInstance.GetScriptableSystemsContainer(game).Get(n"PreventionSystem") as PreventionSystem;
        this.delaySystem = GameInstance.GetDelaySystem(game);
        this.settings = GRSettings.GetInstance(game);
        this.affiliation = gamedataAffiliation.VoodooBoys;
        this.waveCounterUniqueId = 11000;
    }

    public static func GetInstance(gameInstance: GameInstance) -> ref<GRVoodooHandler> {
        let system: ref<GRVoodooHandler> = GameInstance.GetScriptableSystemsContainer(gameInstance).Get(n"Gibbon.GR.GangHandlers.GRVoodooHandler") as GRVoodooHandler;
        return system;
    }

    public func OnHeatResetCooldownStart() -> Void {
        this.delaySystem.DelayCallback(VoodooHeatResetCooldownEndCallback.Create(this), this.GetHeatResetCooldown(), true);
    }

    public func OnCallSuccessCooldownStart() -> Void {
        this.delaySystem.DelayCallback(VoodooCallSuccessCooldownEndCallback.Create(this), this.GetCallSuccessCooldown(), true);
    }

    public func OnGraceStart() -> Void {
        this.delaySystem.DelayCallback(VoodooGraceEndCallback.Create(this), this.GetGraceTime(), true);
    }

    public func GetTurfList() -> array<String> {
        return [
            "WestWindEstate",
            "Coastview"
        ];
    }
}

public class VoodooGraceEndCallback extends DelayCallback {
    let handler: wref<GRVoodooHandler>;
    public static func Create(handler: ref<GRVoodooHandler>) -> ref<VoodooGraceEndCallback> {
        let self: ref<VoodooGraceEndCallback> = new VoodooGraceEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnGraceEnd();
  }
}

public class VoodooHeatResetCooldownEndCallback extends DelayCallback {
    let handler: wref<GRVoodooHandler>;
    public static func Create(handler: ref<GRVoodooHandler>) -> ref<VoodooHeatResetCooldownEndCallback> {
        let self: ref<VoodooHeatResetCooldownEndCallback> = new VoodooHeatResetCooldownEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnHeatResetCooldownEnd();
  }
}

public class VoodooCallSuccessCooldownEndCallback extends DelayCallback {
    let handler: wref<GRVoodooHandler>;
    public static func Create(handler: ref<GRVoodooHandler>) -> ref<VoodooCallSuccessCooldownEndCallback> {
        let self: ref<VoodooCallSuccessCooldownEndCallback> = new VoodooCallSuccessCooldownEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnCallSuccessCooldownEnd();
  }
}