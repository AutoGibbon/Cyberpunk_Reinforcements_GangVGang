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
        this.delaySystem.DelayCallback(GRSixthHeatResetCooldownEndCallback.Create(this), this.GetHeatResetCooldown(), true);
    }

    public func OnCallSuccessCooldownStart() -> Void {
        this.delaySystem.DelayCallback(GRSixthCallSuccessCooldownEndCallback.Create(this), this.GetCallSuccessCooldown(), true);
    }

    public func OnGraceStart() -> Void {
        this.delaySystem.DelayCallback(GRSixthGraceEndCallback.Create(this), this.GetGraceTime(), true);
    }

    public func GetTurfList() -> array<String> {
        return [
            "SantoDomingo"
        ];
    }
}

public class GRSixthGraceEndCallback extends DelayCallback {
    let handler: wref<GRSixthStreetHandler>;
    public static func Create(handler: ref<GRSixthStreetHandler>) -> ref<GRSixthGraceEndCallback> {
        let self: ref<GRSixthGraceEndCallback> = new GRSixthGraceEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnGraceEnd();
  }
}

public class GRSixthHeatResetCooldownEndCallback extends DelayCallback {
    let handler: wref<GRSixthStreetHandler>;
    public static func Create(handler: ref<GRSixthStreetHandler>) -> ref<GRSixthHeatResetCooldownEndCallback> {
        let self: ref<GRSixthHeatResetCooldownEndCallback> = new GRSixthHeatResetCooldownEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnHeatResetCooldownEnd();
  }
}

public class GRSixthCallSuccessCooldownEndCallback extends DelayCallback {
    let handler: wref<GRSixthStreetHandler>;
    public static func Create(handler: ref<GRSixthStreetHandler>) -> ref<GRSixthCallSuccessCooldownEndCallback> {
        let self: ref<GRSixthCallSuccessCooldownEndCallback> = new GRSixthCallSuccessCooldownEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnCallSuccessCooldownEnd();
  }
}



