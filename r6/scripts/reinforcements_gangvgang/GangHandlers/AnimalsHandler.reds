module Gibbon.GR.GangHandlers

import Gibbon.GR.GangData.*
import Gibbon.GR.Settings.GRSettings


public class GRAnimalsHandler extends GRGangHandler {
    private final func OnPlayerAttach(request: ref<PlayerAttachRequest>) -> Void { 
        let game = GetGameInstance();
        this.reinforcementData = new GRAnimalsData();
        this.preventionSystem = GameInstance.GetScriptableSystemsContainer(game).Get(n"PreventionSystem") as PreventionSystem;
        this.delaySystem = GameInstance.GetDelaySystem(game);
        this.settings = GRSettings.GetInstance(game);
        this.affiliation = gamedataAffiliation.Animals;
        this.waveCounterUniqueId = 2000;
    }

    public static func GetInstance(gameInstance: GameInstance) -> ref<GRAnimalsHandler> {
        let system: ref<GRAnimalsHandler> = GameInstance.GetScriptableSystemsContainer(gameInstance).Get(n"Gibbon.GR.GangHandlers.GRAnimalsHandler") as GRAnimalsHandler;
        return system;
    }

 

    public func OnHeatResetCooldownStart() -> Void {
        this.delaySystem.DelayCallback(AnimalsHeatResetCooldownEndCallback.Create(this), this.GetHeatResetCooldown(), true);
    }

    public func OnCallSuccessCooldownStart() -> Void {
        this.delaySystem.DelayCallback(AnimalsCallSuccessCooldownEndCallback.Create(this), this.GetCallSuccessCooldown(), true);
    }

    public func OnGraceStart() -> Void {
        this.delaySystem.DelayCallback(AnimalsGraceEndCallback.Create(this), this.GetGraceTime(), true);
    }

    public func GetTurfList() -> array<String> {
        return [
            "WestWindEstate",
            "Coastview"
        ];
    }
}

public class AnimalsGraceEndCallback extends DelayCallback {
    let handler: wref<GRAnimalsHandler>;
    public static func Create(handler: ref<GRAnimalsHandler>) -> ref<AnimalsGraceEndCallback> {
        let self: ref<AnimalsGraceEndCallback> = new AnimalsGraceEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnGraceEnd();
  }
}

public class AnimalsHeatResetCooldownEndCallback extends DelayCallback {
    let handler: wref<GRAnimalsHandler>;
    public static func Create(handler: ref<GRAnimalsHandler>) -> ref<AnimalsHeatResetCooldownEndCallback> {
        let self: ref<AnimalsHeatResetCooldownEndCallback> = new AnimalsHeatResetCooldownEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnHeatResetCooldownEnd();
  }
}

public class AnimalsCallSuccessCooldownEndCallback extends DelayCallback {
    let handler: wref<GRAnimalsHandler>;
    public static func Create(handler: ref<GRAnimalsHandler>) -> ref<AnimalsCallSuccessCooldownEndCallback> {
        let self: ref<AnimalsCallSuccessCooldownEndCallback> = new AnimalsCallSuccessCooldownEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnCallSuccessCooldownEnd();
  }
}