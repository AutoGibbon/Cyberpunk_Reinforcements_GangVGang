module Gibbon.GR.Localization.Packages
import Codeware.Localization.*

public class GR_en_us extends ModLocalizationPackage{

	protected func DefineTexts(){
		this.Text("GibbonGR-Title","Reinforcements Gang Vs Gang");
		this.Text("GibbonGR-Enabled-Name", "Enabled");
        this.Text("GibbonGR-EnabledInCombat-Name", "Enabled When Player in Combat");
        this.Text("GibbonGR-EnabledWhenPlayerIsPassenger-Name", "Enabled When Player is Passenger");
        this.Text("GibbonGR-GracePeriodMin-Name", "Minimum Grace Period");
        this.Text("GibbonGR-GracePeriodMin-Description", "Minimum time before a gang can call for backup the first time in a fight");
        this.Text("GibbonGR-GracePeriodMax-Name", "Maximum Grace Period");
        this.Text("GibbonGR-GracePeriodMax-Description", "Maximum time before a gang can call for backup the first time in a fight");
        this.Text("GibbonGR-CallSuccessCooldownMin-Name", "Minimum Call Cooldown");
        this.Text("GibbonGR-CallSuccessCooldownMin-Description", "Minimum time a gang must wait before calling for backup again in the same fight");
        this.Text("GibbonGR-CallSuccessCooldownMax-Name", "Maximum Call Cooldown");
        this.Text("GibbonGR-CallSuccessCooldownMax-Description", "Maximum time a gang must wait before calling for backup again in the same fight");
        this.Text("GibbonGR-HeatResetCooldown-Name", "Limit Cooldown");
        this.Text("GibbonGR-HeatResetCooldown-Description", "How long gang must wait before calling again after reaching the calls limit");
        this.Text("GibbonGR-InitialHeat-Name", "Initial Heat");
        this.Text("GibbonGR-InitialHeat-Description", "How strong the first backup call will be");
        this.Text("GibbonGR-HeatEscalation-Name", "Heat Escalation");
        this.Text("GibbonGR-HeatEscalation-Description", "Amount heat increases per gang per call");
        this.Text("GibbonGR-CallsLimit-Name", "Calls Limit");
        this.Text("GibbonGR-CallsLimit-Description", "The number of calls a gang can make before they must wait the limit cooldown");
        this.Text("GibbonGR-StrongCallChance-Name", "Stronger Call Chance");
        this.Text("GibbonGR-StrongCallChance-Description", "Chance the next backup call will be stronger than the current heat level");
        this.Text("GibbonGR-StrongCallHeatBonus-Name", "Stronger Call Heat Bonus");
        this.Text("GibbonGR-StrongCallHeatBonus-Description", "How much extra heat the strong call will have");
        this.Text("GibbonGR-TurfHeatBonus-Name", "Turf Heat Bonus");
        this.Text("GibbonGR-TurfHeatBonus-Description", "Extra initial heat when gang calls on their own turf");
        this.Text("GibbonGR-GracePeriod-Category", "Grace Period");
        this.Text("GibbonGR-Cooldowns-Category", "Cooldowns");
        this.Text("GibbonGR-Heat-Category", "Heat");
	}
}
