module Gibbon.GR.GangHandlers

import Gibbon.GR.GangData.*
import Gibbon.GR.Settings.GRSettings


public class GRValentinosHandler extends GRGangHandler {
    private final func OnPlayerAttach(request: ref<PlayerAttachRequest>) -> Void { 
        let game = GetGameInstance();
        this.m_reinforcementData = new GRValentinoData();
        this.m_preventionSystem = GameInstance.GetScriptableSystemsContainer(game).Get(n"PreventionSystem") as PreventionSystem;
        this.m_delaySystem = GameInstance.GetDelaySystem(game);
        this.m_settings = GRSettings.GetInstance(game);
        this.m_affiliation = gamedataAffiliation.Valentinos;
        this.m_waveCounterUniqueId = 10000;
        this.m_attitudeGroup = n"valentinos_ow";
    }

    public static func GetInstance(gameInstance: GameInstance) -> ref<GRValentinosHandler> {
        let system: ref<GRValentinosHandler> = GameInstance.GetScriptableSystemsContainer(gameInstance).Get(n"Gibbon.GR.GangHandlers.GRValentinosHandler") as GRValentinosHandler;
        return system;
    }


    public func OnCallSuccessCooldownStart() -> Void {
        this.m_delaySystem.DelayCallback(GRValentinosCallSuccessCooldownEndCallback.Create(this), this.GetCallSuccessCooldown(), true);
    }

    public func OnGraceStart() -> Void {
        this.m_delaySystem.DelayCallback(GRValentinosGraceEndCallback.Create(this), this.GetGraceTime(), true);
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