module Gibbon.GR.GangHandlers

import Gibbon.GR.GangData.*
import Gibbon.GR.Settings.GRSettings


public class GRMilitechHandler extends GRGangHandler {
    private final func OnPlayerAttach(request: ref<PlayerAttachRequest>) -> Void { 
        let game = GetGameInstance();
        this.reinforcementData = new GRMilitechData();
        this.preventionSystem = GameInstance.GetScriptableSystemsContainer(game).Get(n"PreventionSystem") as PreventionSystem;
        this.delaySystem = GameInstance.GetDelaySystem(game);
        this.settings = GRSettings.GetInstance(game);
        this.affiliation = gamedataAffiliation.Militech;
        this.waveCounterUniqueId = 6000;
    }

    public static func GetInstance(gameInstance: GameInstance) -> ref<GRMilitechHandler> {
        let system: ref<GRMilitechHandler> = GameInstance.GetScriptableSystemsContainer(gameInstance).Get(n"Gibbon.GR.GangHandlers.GRMilitechHandler") as GRMilitechHandler;
        return system;
    }

 

    public func OnHeatResetCooldownStart() -> Void {
        this.delaySystem.DelayCallback(MilitechHeatResetCooldownEndCallback.Create(this), this.GetHeatResetCooldown(), true);
    }

    public func OnCallSuccessCooldownStart() -> Void {
        this.delaySystem.DelayCallback(MilitechCallSuccessCooldownEndCallback.Create(this), this.GetCallSuccessCooldown(), true);
    }

    public func OnGraceStart() -> Void {
        this.delaySystem.DelayCallback(MilitechGraceEndCallback.Create(this), this.GetGraceTime(), true);
    }

    public func GetTurfList() -> array<String> {
        return [
            "Badlands"
        ];
    }
}

public class MilitechGraceEndCallback extends DelayCallback {
    let handler: wref<GRMilitechHandler>;
    public static func Create(handler: ref<GRMilitechHandler>) -> ref<MilitechGraceEndCallback> {
        let self: ref<MilitechGraceEndCallback> = new MilitechGraceEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnGraceEnd();
  }
}

public class MilitechHeatResetCooldownEndCallback extends DelayCallback {
    let handler: wref<GRMilitechHandler>;
    public static func Create(handler: ref<GRMilitechHandler>) -> ref<MilitechHeatResetCooldownEndCallback> {
        let self: ref<MilitechHeatResetCooldownEndCallback> = new MilitechHeatResetCooldownEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnHeatResetCooldownEnd();
  }
}

public class MilitechCallSuccessCooldownEndCallback extends DelayCallback {
    let handler: wref<GRMilitechHandler>;
    public static func Create(handler: ref<GRMilitechHandler>) -> ref<MilitechCallSuccessCooldownEndCallback> {
        let self: ref<MilitechCallSuccessCooldownEndCallback> = new MilitechCallSuccessCooldownEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnCallSuccessCooldownEnd();
  }
}