module Gibbon.GR.GangHandlers

import Gibbon.GR.GangData.*
import Gibbon.GR.Settings.GRSettings


public class GRTygersHandler extends GRGangHandler {
    private final func OnPlayerAttach(request: ref<PlayerAttachRequest>) -> Void { 
        let game = GetGameInstance();
        this.reinforcementData = new GRTygerData();
        this.preventionSystem = GameInstance.GetScriptableSystemsContainer(game).Get(n"PreventionSystem") as PreventionSystem;
        this.delaySystem = GameInstance.GetDelaySystem(game);
        this.settings = GRSettings.GetInstance(game);
        this.affiliation = gamedataAffiliation.TygerClaws;
        this.waveCounterUniqueId = 9000;
    }

    public static func GetInstance(gameInstance: GameInstance) -> ref<GRTygersHandler> {
        let system: ref<GRTygersHandler> = GameInstance.GetScriptableSystemsContainer(gameInstance).Get(n"Gibbon.GR.GangHandlers.GRTygersHandler") as GRTygersHandler;
        return system;
    }
 

    public func GetTurfList() -> array<String> {
        return ["Westbrook"];
    }
    
    public func OnGraceStart() -> Void {
        this.delaySystem.DelayCallback(TygerEndCallback.Create(this), this.GetGraceTime(), true);
    }

    public func OnHeatResetCooldownStart() -> Void {
        this.delaySystem.DelayCallback(TygerHeatResetCooldownEndCallback.Create(this), this.GetHeatResetCooldown(), true);
    }

    public func OnCallSuccessCooldownStart() -> Void {
        this.delaySystem.DelayCallback(TygerCallSuccessCooldownEndCallback.Create(this), this.GetCallSuccessCooldown(), true);
    }
}

public class TygerEndCallback extends DelayCallback {
    let handler: wref<GRTygersHandler>;
    public static func Create(handler: ref<GRTygersHandler>) -> ref<TygerEndCallback> {
        let self: ref<TygerEndCallback> = new TygerEndCallback();
        
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnGraceEnd();
  }
}

public class TygerHeatResetCooldownEndCallback extends DelayCallback {
    let handler: wref<GRTygersHandler>;
    public static func Create(handler: ref<GRTygersHandler>) -> ref<TygerHeatResetCooldownEndCallback> {
        let self: ref<TygerHeatResetCooldownEndCallback> = new TygerHeatResetCooldownEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnHeatResetCooldownEnd();
  }
}

public class TygerCallSuccessCooldownEndCallback extends DelayCallback {
    let handler: wref<GRTygersHandler>;
    public static func Create(handler: ref<GRTygersHandler>) -> ref<TygerCallSuccessCooldownEndCallback> {
        let self: ref<TygerCallSuccessCooldownEndCallback> = new TygerCallSuccessCooldownEndCallback();
        self.handler = handler;
        return self;
    }

  public func Call() -> Void {
    this.handler.OnCallSuccessCooldownEnd();
  }
}