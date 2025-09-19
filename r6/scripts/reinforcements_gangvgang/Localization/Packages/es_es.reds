module Gibbon.GR.Localization.Packages
import Codeware.Localization.*

public class GR_es_es extends ModLocalizationPackage{

	protected func DefineTexts(){
        this.Text("GibbonGR-Title","Reinforcements Gang Vs Gang");
		this.Text("GibbonGR-Enabled-Name", "Habilitado");
        this.Text("GibbonGR-EnabledInCombat-Name", "Habilitado cuando el jugador está en combate");
        this.Text("GibbonGR-EnabledWhenPlayerIsPassenger-Name", "Habilitado cuando el jugador es pasajero");
        this.Text("GibbonGR-GracePeriodMin-Name", "Período de gracia mínimo");
        this.Text("GibbonGR-GracePeriodMin-Description", "Tiempo mínimo antes de que una pandilla pueda llamar refuerzos por primera vez en una pelea");
        this.Text("GibbonGR-GracePeriodMax-Name", "Período de gracia máximo");
        this.Text("GibbonGR-GracePeriodMax-Description", "Tiempo máximo antes de que una pandilla pueda llamar refuerzos por primera vez en una pelea");
        this.Text("GibbonGR-CallSuccessCooldownMin-Name", "Cooldown de llamada mínimo");
        this.Text("GibbonGR-CallSuccessCooldownMin-Description", "Tiempo mínimo que una pandilla debe esperar antes de llamar refuerzos de nuevo en la misma pelea");
        this.Text("GibbonGR-CallSuccessCooldownMax-Name", "Cooldown de llamada máximo");
        this.Text("GibbonGR-CallSuccessCooldownMax-Description", "Tiempo máximo que una pandilla debe esperar antes de llamar refuerzos de nuevo en la misma pelea");
        this.Text("GibbonGR-HeatResetCooldown-Name", "Cooldown límite");
        this.Text("GibbonGR-HeatResetCooldown-Description", "Cuánto tiempo debe esperar una pandilla antes de llamar de nuevo después de alcanzar el límite de llamadas");
        this.Text("GibbonGR-InitialHeat-Name", "Calor inicial");
        this.Text("GibbonGR-InitialHeat-Description", "Qué tan fuerte será la primera llamada de refuerzos");
        this.Text("GibbonGR-HeatEscalation-Name", "Escalada de calor");
        this.Text("GibbonGR-HeatEscalation-Description", "Cuánto aumenta el calor por pandilla por llamada");
        this.Text("GibbonGR-CallsLimit-Name", "Límite de llamadas");
        this.Text("GibbonGR-CallsLimit-Description", "El número de llamadas que una pandilla puede hacer antes de tener que esperar el cooldown límite");
        this.Text("GibbonGR-StrongCallChance-Name", "Probabilidad de llamada fuerte");
        this.Text("GibbonGR-StrongCallChance-Description", "Probabilidad de que la próxima llamada de refuerzos sea más fuerte que el nivel actual de calor");
        this.Text("GibbonGR-StrongCallHeatBonus-Name", "Bonus de calor para llamada fuerte");
        this.Text("GibbonGR-StrongCallHeatBonus-Description", "Cuánto calor extra tendrá la llamada fuerte");
        this.Text("GibbonGR-TurfHeatBonus-Name", "Bonus de calor de territorio");
        this.Text("GibbonGR-TurfHeatBonus-Description", "Calor inicial extra cuando una pandilla llama en su propio territorio");
        this.Text("GibbonGR-GracePeriod-Category", "Período de gracia");
        this.Text("GibbonGR-Cooldowns-Category", "Cooldowns");
        this.Text("GibbonGR-Heat-Category", "Calor");

        // ==================== NEW SETTINGS LOCALIZATION ==================== //
        this.Text("GibbonGR-PresetMode-Name", "Modo Predefinido");
        this.Text("GibbonGR-PresetMode-Description", "Elige entre modos predefinidos para diferentes experiencias de juego");
        this.Text("GibbonGR-PresetMode-Limited", "Ligero");
        this.Text("GibbonGR-PresetMode-Balanced", "Equilibrado");
        this.Text("GibbonGR-PresetMode-RareBigFight", "Raro y Dramático");
        this.Text("GibbonGR-PresetMode-Chaos", "Caos");
        this.Text("GibbonGR-ShowAdvancedSettings-Name", "Mostrar Configuración Avanzada");
        this.Text("GibbonGR-ShowAdvancedSettings-Description", "Mostrar configuración avanzada para ajustar parámetros individuales. Anula el modo predefinido.");
        this.Text("GibbonGR-MaxVehiclesPerCall-Name", "Vehículos Máximos Por Llamada");
        this.Text("GibbonGR-MaxVehiclesPerCall-Description", "Número máximo de vehículos que pueden aparecer en una sola llamada de refuerzos");
	}
}
