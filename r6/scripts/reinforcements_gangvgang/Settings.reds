module Gibbon.GR.Settings

public class GRSettings extends ScriptableSystem {

    public static func GetInstance(gameInstance: GameInstance) -> ref<GRSettings> {
        let system: ref<GRSettings> = GameInstance.GetScriptableSystemsContainer(gameInstance).Get(n"Gibbon.GR.Settings.GRSettings") as GRSettings;
        return system;
    }

    @runtimeProperty("ModSettings.mod", "GibbonGR-Title")
    @runtimeProperty("ModSettings.displayName", "GibbonGR-Enabled-Name")
    public let enabled: Bool = true;

    @runtimeProperty("ModSettings.mod", "GibbonGR-Title")
    @runtimeProperty("ModSettings.displayName", "GibbonGR-EnabledInCombat-Name")
    @runtimeProperty("ModSettings.dependency", "enabled")
    public let enabledWhenPlayerInCombat: Bool = true;

    @runtimeProperty("ModSettings.mod", "GibbonGR-Title")
    @runtimeProperty("ModSettings.displayName", "GibbonGR-EnabledWhenPlayerIsPassenger-Name")
    @runtimeProperty("ModSettings.dependency", "enabled")
    public let enabledWhenPlayerIsPassenger: Bool = true;

    //---------------------------------------------------- GRACE PERIOD ---------------------------------------------------- //

    @runtimeProperty("ModSettings.mod", "GibbonGR-Title")
    @runtimeProperty("ModSettings.displayName", "GibbonGR-GracePeriodMin-Name")
    @runtimeProperty("ModSettings.description", "GibbonGR-GracePeriodMin-Description")
    @runtimeProperty("ModSettings.category", "GibbonGR-GracePeriod-Category")
	@runtimeProperty("ModSettings.category.order", "1")
    @runtimeProperty("ModSettings.step", "1")
    @runtimeProperty("ModSettings.min", "1")
    @runtimeProperty("ModSettings.max", "60")
    @runtimeProperty("ModSettings.dependency", "enabled")
    public let gracePeriodMin: Float = 5;

    @runtimeProperty("ModSettings.mod", "GibbonGR-Title")
    @runtimeProperty("ModSettings.displayName", "GibbonGR-GracePeriodMax-Name")
    @runtimeProperty("ModSettings.description", "GibbonGR-GracePeriodMax-Description")
    @runtimeProperty("ModSettings.category", "GibbonGR-GracePeriod-Category")
	@runtimeProperty("ModSettings.category.order", "2")
    @runtimeProperty("ModSettings.step", "1")
    @runtimeProperty("ModSettings.min", "1")
    @runtimeProperty("ModSettings.max", "30")
    @runtimeProperty("ModSettings.dependency", "enabled")
    public let gracePeriodMax: Float = 15;

    //---------------------------------------------------- COOLDOWNS ---------------------------------------------------- //

    @runtimeProperty("ModSettings.mod", "GibbonGR-Title")
    @runtimeProperty("ModSettings.displayName", "GibbonGR-CallSuccessCooldownMin-Name")
    @runtimeProperty("ModSettings.description", "GibbonGR-CallSuccessCooldownMin-Description")
    @runtimeProperty("ModSettings.category", "GibbonGR-Cooldowns-Category")
	@runtimeProperty("ModSettings.category.order", "1")
    @runtimeProperty("ModSettings.step", "1")
    @runtimeProperty("ModSettings.min", "1")
    @runtimeProperty("ModSettings.max", "60")
    @runtimeProperty("ModSettings.dependency", "enabled")
    public let callSuccessCooldownMin: Float = 30;

    @runtimeProperty("ModSettings.mod", "GibbonGR-Title")
    @runtimeProperty("ModSettings.displayName", "GibbonGR-CallSuccessCooldownMax-Name")
    @runtimeProperty("ModSettings.description", "GibbonGR-CallSuccessCooldownMax-Description")
    @runtimeProperty("ModSettings.category", "GibbonGR-Cooldowns-Category")
	@runtimeProperty("ModSettings.category.order", "2")
    @runtimeProperty("ModSettings.step", "1")
    @runtimeProperty("ModSettings.min", "1")
    @runtimeProperty("ModSettings.max", "60")
    @runtimeProperty("ModSettings.dependency", "enabled")
    public let callSuccessCooldownMax: Float = 60;

    @runtimeProperty("ModSettings.mod", "GibbonGR-Title")
    @runtimeProperty("ModSettings.displayName", "GibbonGR-HeatResetCooldown-Name")
    @runtimeProperty("ModSettings.description", "GibbonGR-HeatResetCooldown-Description")
    @runtimeProperty("ModSettings.category", "GibbonGR-Cooldowns-Category")
	@runtimeProperty("ModSettings.category.order", "3")
    @runtimeProperty("ModSettings.step", "30")
    @runtimeProperty("ModSettings.min", "1")
    @runtimeProperty("ModSettings.max", "600")
    @runtimeProperty("ModSettings.dependency", "enabled")
    public let heatResetCooldown: Float = 300;

    //---------------------------------------------------- HEAT --------------------------------------------------------- //

    @runtimeProperty("ModSettings.mod", "GibbonGR-Title")
    @runtimeProperty("ModSettings.displayName", "GibbonGR-InitialHeat-Name")
    @runtimeProperty("ModSettings.description", "GibbonGR-InitialHeat-Description")
    @runtimeProperty("ModSettings.category", "GibbonGR-Heat-Category")
	@runtimeProperty("ModSettings.category.order", "1")
    @runtimeProperty("ModSettings.step", "1")
    @runtimeProperty("ModSettings.min", "1")
    @runtimeProperty("ModSettings.max", "20")
    @runtimeProperty("ModSettings.dependency", "enabled")
    public let initialHeat: Int32 = 1;

    @runtimeProperty("ModSettings.mod", "GibbonGR-Title")
    @runtimeProperty("ModSettings.displayName", "GibbonGR-HeatEscalation-Name")
    @runtimeProperty("ModSettings.description", "GibbonGR-HeatEscalation-Description")
    @runtimeProperty("ModSettings.category", "GibbonGR-Heat-Category")
	@runtimeProperty("ModSettings.category.order", "2")
    @runtimeProperty("ModSettings.step", "1")
    @runtimeProperty("ModSettings.min", "1")
    @runtimeProperty("ModSettings.max", "4")
    @runtimeProperty("ModSettings.dependency", "enabled")
    public let heatEscalation: Int32 = 1;

    @runtimeProperty("ModSettings.mod", "GibbonGR-Title")
    @runtimeProperty("ModSettings.displayName", "GibbonGR-CallsLimit-Name")
    @runtimeProperty("ModSettings.description", "GibbonGR-CallsLimit-Description")
    @runtimeProperty("ModSettings.category", "GibbonGR-Heat-Category")
	@runtimeProperty("ModSettings.category.order", "3")
    @runtimeProperty("ModSettings.step", "1")
    @runtimeProperty("ModSettings.min", "1")
    @runtimeProperty("ModSettings.max", "5")
    @runtimeProperty("ModSettings.dependency", "enabled")
    public let callsLimit: Int32 = 3;

    @runtimeProperty("ModSettings.mod", "GibbonGR-Title")
    @runtimeProperty("ModSettings.displayName", "GibbonGR-StrongCallChance-Name")
    @runtimeProperty("ModSettings.description", "GibbonGR-StrongCallChance-Description")
    @runtimeProperty("ModSettings.category", "GibbonGR-Heat-Category")
	@runtimeProperty("ModSettings.category.order", "4")
    @runtimeProperty("ModSettings.step", "5")
    @runtimeProperty("ModSettings.min", "1")
    @runtimeProperty("ModSettings.max", "100")
    @runtimeProperty("ModSettings.dependency", "enabled")
    public let strongCallChance: Int32 = 30;

    @runtimeProperty("ModSettings.mod", "GibbonGR-Title")
    @runtimeProperty("ModSettings.displayName", "GibbonGR-StrongCallHeatBonus-Name")
    @runtimeProperty("ModSettings.description", "GibbonGR-StrongCallHeatBonus-Description")
    @runtimeProperty("ModSettings.category", "GibbonGR-Heat-Category")
	@runtimeProperty("ModSettings.category.order", "4")
    @runtimeProperty("ModSettings.step", "1")
    @runtimeProperty("ModSettings.min", "1")
    @runtimeProperty("ModSettings.max", "10")
    @runtimeProperty("ModSettings.dependency", "enabled")
    public let strongCallHeatBonus: Int32 = 5;

    @runtimeProperty("ModSettings.mod", "GibbonGR-Title")
    @runtimeProperty("ModSettings.displayName", "GibbonGR-TurfHeatBonus-Name")
    @runtimeProperty("ModSettings.description", "GibbonGR-TurfHeatBonus-Description")
    @runtimeProperty("ModSettings.category", "GibbonGR-Heat-Category")
	@runtimeProperty("ModSettings.category.order", "5")
    @runtimeProperty("ModSettings.step", "1")
    @runtimeProperty("ModSettings.min", "1")
    @runtimeProperty("ModSettings.max", "20")
    @runtimeProperty("ModSettings.dependency", "enabled")
    public let turfHeatBonus: Int32 = 5;
}