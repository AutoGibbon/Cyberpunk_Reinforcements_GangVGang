module Gibbon.GR.GangHandlers

import Gibbon.GR.GangData.*
import Gibbon.GR.Settings.GRSettings


public class GRSixthStreetHandler extends GRGangHandler {
    private final func OnPlayerAttach(request: ref<PlayerAttachRequest>) -> Void { 
        let game = GetGameInstance();
        this.reinforcementData = new GRSixthStreetData();
        this.preventionSystem = GameInstance.GetScriptableSystemsContainer(game).Get(n"PreventionSystem") as PreventionSystem;
        this.delaySystem = GameInstance.GetDelaySystem(game);
        this.settings = GRSettings.GetInstance(game);
        this.affiliation = gamedataAffiliation.SixthStreet;
        this.waveCounterUniqueId = 1000;
    }

    public static func GetInstance(gameInstance: GameInstance) -> ref<GRSixthStreetHandler> {
        let system: ref<GRSixthStreetHandler> = GameInstance.GetScriptableSystemsContainer(gameInstance).Get(n"Gibbon.GR.GangHandlers.GRSixthStreetHandler") as GRSixthStreetHandler;
        return system;
    }

    public func OnHeatResetCooldownStart() -> Void {
        this.delaySystem.DelayCallback(SixthHeatResetCooldownEndCallback.Create(this), this.GetHeatResetCooldown(), true);
    }

    public func OnCallSuccessCooldownStart() -> Void {
        this.delaySystem.DelayCallback(SixthCallSuccessCooldownEndCallback.Create(this), this.GetCallSuccessCooldown(), true);
    }

    public func OnGraceStart() -> Void {
        this.delaySystem.DelayCallback(SixthGraceEndCallback.Create(this), this.GetGraceTime(), true);
    }

    public func GetTurfList() -> array<String> {
        return [
            "SantoDomingo"
        ];
    }
}

public class SixthGraceEndCallback extends DelayCallback {
    let handler: wref<GRSixthStreetHandler>;
    public static func Create(handler: ref<GRSixthStreetHandler>) -> ref<SixthGraceEndCallback> {
        let self: ref<SixthGraceEndCallback> = new SixthGraceEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnGraceEnd();
  }
}

public class SixthHeatResetCooldownEndCallback extends DelayCallback {
    let handler: wref<GRSixthStreetHandler>;
    public static func Create(handler: ref<GRSixthStreetHandler>) -> ref<SixthHeatResetCooldownEndCallback> {
        let self: ref<SixthHeatResetCooldownEndCallback> = new SixthHeatResetCooldownEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnHeatResetCooldownEnd();
  }
}

public class SixthCallSuccessCooldownEndCallback extends DelayCallback {
    let handler: wref<GRSixthStreetHandler>;
    public static func Create(handler: ref<GRSixthStreetHandler>) -> ref<SixthCallSuccessCooldownEndCallback> {
        let self: ref<SixthCallSuccessCooldownEndCallback> = new SixthCallSuccessCooldownEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnCallSuccessCooldownEnd();
  }
}