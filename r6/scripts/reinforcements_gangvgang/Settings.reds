module Gibbon.GR.Settings

import Gibbon.GR.Logging.*

enum SimpleSetting {
    Balanced = 0,
    RareDramatic = 1,
    Chaos = 2
}

public class GRSettings extends ScriptableSystem {

    private let showPublics: Bool = false;

    public static func GetInstance(gameInstance: GameInstance) -> ref<GRSettings> {
        let system: ref<GRSettings> = GameInstance.GetScriptableSystemsContainer(gameInstance).Get(n"Gibbon.GR.Settings.GRSettings") as GRSettings;
        return system;
    }

    public func OnAttach() -> Void {
        ModSettings.RegisterListenerToClass(this);
        ModSettings.RegisterListenerToModifications(this);
    }

    public func OnDetach() -> Void {
        ModSettings.UnregisterListenerToClass(this);
  	    ModSettings.UnregisterListenerToModifications(this);
    }

    public cb func OnModSettingsChange() -> Void { 
        this.ReconcileSettings();
    }

    public func ReconcileSettings() -> Void {
        //GRLog("Reconciling settings");
        if (this.useAdvancedSettings) {
            this.gracePeriodMin = MinF(this._gracePeriodMin, this.gracePeriodMax);
            this.gracePeriodMax = MaxF(this._gracePeriodMin, this.gracePeriodMax);
            this.callSuccessCooldownMin = MinF(this._callSuccessCooldownMin, this.callSuccessCooldownMax);
            this.callSuccessCooldownMax = MaxF(this._callSuccessCooldownMin, this.callSuccessCooldownMax);
            this.heatResetCooldown = this._heatResetCooldown;
            this.initialHeat = this._initialHeat;
            this.heatEscalation = this._heatEscalation;
            this.callsLimit = this._callsLimit;
            this.strongCallChance = this._strongCallChance;
            this.strongCallHeatBonus = this._strongCallHeatBonus;
            this.turfHeatBonus = this._turfHeatBonus;
        } else {
            if (Equals(this.simpleSetting, SimpleSetting.Balanced)) {
                this.gracePeriodMin = 5;
                this.gracePeriodMax = 15;
                this.callSuccessCooldownMin = 15;
                this.callSuccessCooldownMax = 60;
                this.heatResetCooldown = 300;
                this.initialHeat = 2;
                this.heatEscalation = 3;
                this.callsLimit = 3;
                this.strongCallChance = 15;
                this.strongCallHeatBonus = 6;
                this.turfHeatBonus = 4;
            } else if (Equals(this.simpleSetting, SimpleSetting.RareDramatic)) {
                this.gracePeriodMin = 20;
                this.gracePeriodMax = 40;
                this.callSuccessCooldownMin = 55;
                this.callSuccessCooldownMax = 60;
                this.heatResetCooldown = 500;
                this.initialHeat = 10;
                this.heatEscalation = 5;
                this.callsLimit = 1;
                this.strongCallChance = 35;
                this.strongCallHeatBonus = 5;
                this.turfHeatBonus = 5;
            } else if (Equals(this.simpleSetting, SimpleSetting.Chaos)) {
                this.gracePeriodMin = 1;
                this.gracePeriodMax = 5;
                this.callSuccessCooldownMin = 15;
                this.callSuccessCooldownMax = 30;
                this.heatResetCooldown = 60;
                this.initialHeat = 5;
                this.heatEscalation = 1;
                this.callsLimit = 10;
                this.strongCallChance = 5;
                this.strongCallHeatBonus = 3;
                this.turfHeatBonus = 3;
            }
        }

        // Log all settings line by line for debugging
        //GRLog(s"GRSettings: gracePeriodMin = \(this.gracePeriodMin)");
        //GRLog(s"GRSettings: gracePeriodMax = \(this.gracePeriodMax)");
        //GRLog(s"GRSettings: callSuccessCooldownMin = \(this.callSuccessCooldownMin)");
        //GRLog(s"GRSettings: callSuccessCooldownMax = \(this.callSuccessCooldownMax)");
        //GRLog(s"GRSettings: heatResetCooldown = \(this.heatResetCooldown)");
        //GRLog(s"GRSettings: initialHeat = \(this.initialHeat)");
        //GRLog(s"GRSettings: heatEscalation = \(this.heatEscalation)");
        //GRLog(s"GRSettings: callsLimit = \(this.callsLimit)");
        //GRLog(s"GRSettings: strongCallChance = \(this.strongCallChance)");
        //GRLog(s"GRSettings: strongCallHeatBonus = \(this.strongCallHeatBonus)");
        //GRLog(s"GRSettings: turfHeatBonus = \(this.turfHeatBonus)");
        //GRLog(s"GRSettings: enabled = \(this.enabled)");
        //GRLog(s"GRSettings: enabledWhenPlayerInCombat = \(this.enabledWhenPlayerInCombat)");
        //GRLog(s"GRSettings: enabledWhenPlayerIsPassenger = \(this.enabledWhenPlayerIsPassenger)");
        //GRLog(s"GRSettings: simpleSetting = \(ToString(this.simpleSetting))");
        //GRLog(s"GRSettings: useAdvancedSettings = \(this.useAdvancedSettings)");
    }

    @runtimeProperty("ModSettings.mod",         "GibbonGR-Title")
    @runtimeProperty("ModSettings.displayName", "GibbonGR-Enabled-Name")
    public let enabled: Bool = true;

    @runtimeProperty("ModSettings.mod",         "GibbonGR-Title")
    @runtimeProperty("ModSettings.displayName", "GibbonGR-EnabledInCombat-Name")
    @runtimeProperty("ModSettings.dependency",  "enabled")
    public let enabledWhenPlayerInCombat: Bool = true;

    @runtimeProperty("ModSettings.mod",         "GibbonGR-Title")
    @runtimeProperty("ModSettings.displayName", "GibbonGR-EnabledWhenPlayerIsPassenger-Name")
    @runtimeProperty("ModSettings.dependency",  "enabled")
    public let enabledWhenPlayerIsPassenger: Bool = true;


    @runtimeProperty("ModSettings.mod",                         "GibbonGR-Title")
    @runtimeProperty("ModSettings.displayName",                 "GibbonGR-SimpleSetting-Name")
    @runtimeProperty("ModSettings.description",                 "GibbonGR-SimpleSetting-Description")
    @runtimeProperty("ModSettings.displayValues.Balanced",      "GibbonGR-SimpleSetting-Balanced")
    @runtimeProperty("ModSettings.displayValues.RareDramatic",  "GibbonGR-SimpleSetting-RareDramatic")
    @runtimeProperty("ModSettings.displayValues.Chaos",         "GibbonGR-SimpleSetting-Chaos")
    @runtimeProperty("ModSettings.dependency",                  "enabled")
    public let simpleSetting: SimpleSetting = SimpleSetting.Balanced;

    
    @runtimeProperty("ModSettings.mod",         "GibbonGR-Title")
    @runtimeProperty("ModSettings.displayName", "GibbonGR-AdvancedMode-Name")
    @runtimeProperty("ModSettings.description", "GibbonGR-AdvancedMode-Description")
    @runtimeProperty("ModSettings.category",    "GibbonGR-Advanced-Category")
    @runtimeProperty("ModSettings.dependency",  "enabled")
    public let useAdvancedSettings: Bool = false;

    //---------------------------------------------------- GRACE PERIOD ---------------------------------------------------- //

    @runtimeProperty("ModSettings.mod",         "GibbonGR-Title")
    @runtimeProperty("ModSettings.displayName", "GibbonGR-GracePeriodMin-Name")
    @runtimeProperty("ModSettings.description", "GibbonGR-GracePeriodMin-Description")
    @runtimeProperty("ModSettings.category",    "GibbonGR-Advanced-Category")
    //@runtimeProperty("ModSettings.category", "GibbonGR-GracePeriod-Category")
	//@runtimeProperty("ModSettings.category.order", "1")
    @runtimeProperty("ModSettings.step",        "1")
    @runtimeProperty("ModSettings.min",         "1")
    @runtimeProperty("ModSettings.max",         "60")
    @runtimeProperty("ModSettings.dependency",  "enabled")
    @runtimeProperty("ModSettings.dependency",  "useAdvancedSettings")
    private let _gracePeriodMin: Float = 5;

    @runtimeProperty("ModSettings.mod",         "GibbonGR-Title")
    @runtimeProperty("ModSettings.displayName", "GibbonGR-GracePeriodMax-Name")
    @runtimeProperty("ModSettings.description", "GibbonGR-GracePeriodMax-Description")
    @runtimeProperty("ModSettings.category",    "GibbonGR-Advanced-Category")
    //@runtimeProperty("ModSettings.category", "GibbonGR-GracePeriod-Category")
	//@runtimeProperty("ModSettings.category.order", "1")
    @runtimeProperty("ModSettings.step",        "1")
    @runtimeProperty("ModSettings.min",         "1")
    @runtimeProperty("ModSettings.max",         "60")
    @runtimeProperty("ModSettings.dependency",  "enabled")
    @runtimeProperty("ModSettings.dependency",  "useAdvancedSettings")
    private let _gracePeriodMax: Float = 15;

    //---------------------------------------------------- COOLDOWNS ---------------------------------------------------- //

    @runtimeProperty("ModSettings.mod",         "GibbonGR-Title")
    @runtimeProperty("ModSettings.displayName", "GibbonGR-CallSuccessCooldownMin-Name")
    @runtimeProperty("ModSettings.description", "GibbonGR-CallSuccessCooldownMin-Description")
    @runtimeProperty("ModSettings.category",    "GibbonGR-Advanced-Category")
    //@runtimeProperty("ModSettings.category", "GibbonGR-Cooldowns-Category")
	//@runtimeProperty("ModSettings.category.order", "2")
    @runtimeProperty("ModSettings.step",        "1")
    @runtimeProperty("ModSettings.min",         "1")
    @runtimeProperty("ModSettings.max",         "60")
    @runtimeProperty("ModSettings.dependency",  "enabled")
    @runtimeProperty("ModSettings.dependency",  "useAdvancedSettings")
    private let _callSuccessCooldownMin: Float = 15;

    @runtimeProperty("ModSettings.mod",         "GibbonGR-Title")
    @runtimeProperty("ModSettings.displayName", "GibbonGR-CallSuccessCooldownMax-Name")
    @runtimeProperty("ModSettings.description", "GibbonGR-CallSuccessCooldownMax-Description")
    @runtimeProperty("ModSettings.category",    "GibbonGR-Advanced-Category")
   // @runtimeProperty("ModSettings.category", "GibbonGR-Cooldowns-Category")
	//@runtimeProperty("ModSettings.category.order", "2")
    @runtimeProperty("ModSettings.step",        "1")
    @runtimeProperty("ModSettings.min",         "1")
    @runtimeProperty("ModSettings.max",         "60")
    @runtimeProperty("ModSettings.dependency",  "enabled")
    @runtimeProperty("ModSettings.dependency",  "useAdvancedSettings")
    private let _callSuccessCooldownMax: Float = 60;

    @runtimeProperty("ModSettings.mod",         "GibbonGR-Title")
    @runtimeProperty("ModSettings.displayName", "GibbonGR-HeatResetCooldown-Name")
    @runtimeProperty("ModSettings.description", "GibbonGR-HeatResetCooldown-Description")
    @runtimeProperty("ModSettings.category",    "GibbonGR-Advanced-Category")
    //@runtimeProperty("ModSettings.category", "GibbonGR-Cooldowns-Category")
	//@runtimeProperty("ModSettings.category.order", "2")
    @runtimeProperty("ModSettings.step",        "30")
    @runtimeProperty("ModSettings.min",         "30")
    @runtimeProperty("ModSettings.max",         "600")
    @runtimeProperty("ModSettings.dependency",  "enabled")
    @runtimeProperty("ModSettings.dependency",  "useAdvancedSettings")
    private let _heatResetCooldown: Float = 300;

    //---------------------------------------------------- HEAT --------------------------------------------------------- //

    @runtimeProperty("ModSettings.mod",         "GibbonGR-Title")
    @runtimeProperty("ModSettings.displayName", "GibbonGR-InitialHeat-Name")
    @runtimeProperty("ModSettings.description", "GibbonGR-InitialHeat-Description")
    @runtimeProperty("ModSettings.category",    "GibbonGR-Advanced-Category")
    //@runtimeProperty("ModSettings.category", "GibbonGR-Heat-Category")
	//@runtimeProperty("ModSettings.category.order", "3")
    @runtimeProperty("ModSettings.step",        "1")
    @runtimeProperty("ModSettings.min",         "1")
    @runtimeProperty("ModSettings.max",         "20")
    @runtimeProperty("ModSettings.dependency",  "enabled")
    @runtimeProperty("ModSettings.dependency",  "useAdvancedSettings")
    private let _initialHeat: Int32 = 2;

    @runtimeProperty("ModSettings.mod",         "GibbonGR-Title")
    @runtimeProperty("ModSettings.displayName", "GibbonGR-HeatEscalation-Name")
    @runtimeProperty("ModSettings.description", "GibbonGR-HeatEscalation-Description")
    @runtimeProperty("ModSettings.category",    "GibbonGR-Advanced-Category")
    //@runtimeProperty("ModSettings.category", "GibbonGR-Heat-Category")
	//@runtimeProperty("ModSettings.category.order", "3")
    @runtimeProperty("ModSettings.step",        "1")
    @runtimeProperty("ModSettings.min",         "1")
    @runtimeProperty("ModSettings.max",         "4")
    @runtimeProperty("ModSettings.dependency",  "enabled")
    @runtimeProperty("ModSettings.dependency",  "useAdvancedSettings")
    private let _heatEscalation: Int32 = 3;

    @runtimeProperty("ModSettings.mod",         "GibbonGR-Title")
    @runtimeProperty("ModSettings.displayName", "GibbonGR-CallsLimit-Name")
    @runtimeProperty("ModSettings.description", "GibbonGR-CallsLimit-Description")
    @runtimeProperty("ModSettings.category",    "GibbonGR-Advanced-Category")
    //@runtimeProperty("ModSettings.category", "GibbonGR-Heat-Category")
	//@runtimeProperty("ModSettings.category.order", "3")
    @runtimeProperty("ModSettings.step",        "1")
    @runtimeProperty("ModSettings.min",         "1")
    @runtimeProperty("ModSettings.max",         "10")
    @runtimeProperty("ModSettings.dependency",  "enabled")
    @runtimeProperty("ModSettings.dependency",  "useAdvancedSettings")
    private let _callsLimit: Int32 = 3;

    @runtimeProperty("ModSettings.mod",         "GibbonGR-Title")
    @runtimeProperty("ModSettings.displayName", "GibbonGR-StrongCallChance-Name")
    @runtimeProperty("ModSettings.description", "GibbonGR-StrongCallChance-Description")
    @runtimeProperty("ModSettings.category",    "GibbonGR-Advanced-Category")
    //@runtimeProperty("ModSettings.category", "GibbonGR-Heat-Category")
	//@runtimeProperty("ModSettings.category.order", "3")
    @runtimeProperty("ModSettings.step",        "5")
    @runtimeProperty("ModSettings.min",         "0")
    @runtimeProperty("ModSettings.max",         "100")
    @runtimeProperty("ModSettings.dependency",  "enabled")
    @runtimeProperty("ModSettings.dependency",  "useAdvancedSettings")
    private let _strongCallChance: Int32 = 20;

    @runtimeProperty("ModSettings.mod",         "GibbonGR-Title")
    @runtimeProperty("ModSettings.displayName", "GibbonGR-StrongCallHeatBonus-Name")
    @runtimeProperty("ModSettings.description", "GibbonGR-StrongCallHeatBonus-Description")
    @runtimeProperty("ModSettings.category",    "GibbonGR-Advanced-Category")
    //@runtimeProperty("ModSettings.category", "GibbonGR-Heat-Category")
	//@runtimeProperty("ModSettings.category.order", "3")
    @runtimeProperty("ModSettings.step",        "1")
    @runtimeProperty("ModSettings.min",         "1")
    @runtimeProperty("ModSettings.max",         "10")
    @runtimeProperty("ModSettings.dependency",  "enabled")
    @runtimeProperty("ModSettings.dependency",  "useAdvancedSettings")
    private let _strongCallHeatBonus: Int32 = 8;

    @runtimeProperty("ModSettings.mod",         "GibbonGR-Title")
    @runtimeProperty("ModSettings.displayName", "GibbonGR-TurfHeatBonus-Name")
    @runtimeProperty("ModSettings.description", "GibbonGR-TurfHeatBonus-Description")
    @runtimeProperty("ModSettings.category",    "GibbonGR-Advanced-Category")
    //@runtimeProperty("ModSettings.category", "GibbonGR-Heat-Category")
	//@runtimeProperty("ModSettings.category.order", "3")
    @runtimeProperty("ModSettings.step",        "1")
    @runtimeProperty("ModSettings.min",         "1")
    @runtimeProperty("ModSettings.max",         "20")
    @runtimeProperty("ModSettings.dependency",  "enabled")
    @runtimeProperty("ModSettings.dependency",  "useAdvancedSettings")
    private let _turfHeatBonus: Int32 = 4;

    // Public versions of private members

    public let gracePeriodMin: Float = 5;
    public let gracePeriodMax: Float = 15;
    public let callSuccessCooldownMin: Float = 15;
    public let callSuccessCooldownMax: Float = 60;
    public let heatResetCooldown: Float = 300;
    public let initialHeat: Int32 = 2;
    public let heatEscalation: Int32 = 3;
    public let callsLimit: Int32 = 3;
    public let strongCallChance: Int32 = 20;
    public let strongCallHeatBonus: Int32 = 8;
    public let turfHeatBonus: Int32 = 4;
}