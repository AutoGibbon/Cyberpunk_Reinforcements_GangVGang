module Gibbon.GR.Localization.Packages
import Codeware.Localization.*

public class GR_cz_cz extends ModLocalizationPackage{

	protected func DefineTexts(){
        this.Text("GibbonGR-Title","Reinforcements Gang Vs Gang");
		this.Text("GibbonGR-Enabled-Name", "Povoleno");
        this.Text("GibbonGR-EnabledInCombat-Name", "Povoleno když je hráč v boji");
        this.Text("GibbonGR-EnabledWhenPlayerIsPassenger-Name", "Povoleno když je hráč pasažér");
        this.Text("GibbonGR-GracePeriodMin-Name", "Minimální milostivé období");
        this.Text("GibbonGR-GracePeriodMin-Description", "Minimální čas předtím, než může gang poprvé zavolat posily v boji");
        this.Text("GibbonGR-GracePeriodMax-Name", "Maximální milostivé období");
        this.Text("GibbonGR-GracePeriodMax-Description", "Maximální čas předtím, než může gang poprvé zavolat posily v boji");
        this.Text("GibbonGR-CallSuccessCooldownMin-Name", "Minimální doba čekání volání");
        this.Text("GibbonGR-CallSuccessCooldownMin-Description", "Minimální čas, který musí gang počkat před dalším voláním posil ve stejném boji");
        this.Text("GibbonGR-CallSuccessCooldownMax-Name", "Maximální doba čekání volání");
        this.Text("GibbonGR-CallSuccessCooldownMax-Description", "Maximální čas, který musí gang počkat před dalším voláním posil ve stejném boji");
        this.Text("GibbonGR-HeatResetCooldown-Name", "Doba čekání limitu");
        this.Text("GibbonGR-HeatResetCooldown-Description", "Jak dlouho musí gang počkat před dalším voláním po dosažení limitu volání");
        this.Text("GibbonGR-InitialHeat-Name", "Počáteční heat");
        this.Text("GibbonGR-InitialHeat-Description", "Jak silné bude první volání posil");
        this.Text("GibbonGR-HeatEscalation-Name", "Eskalace heat");
        this.Text("GibbonGR-HeatEscalation-Description", "O kolik se heat zvýší pro každý gang při každém volání");
        this.Text("GibbonGR-CallsLimit-Name", "Limit volání");
        this.Text("GibbonGR-CallsLimit-Description", "Počet volání, které může gang udělat před tím, než musí počkat dobu čekání limitu");
        this.Text("GibbonGR-StrongCallChance-Name", "Šance na silné volání");
        this.Text("GibbonGR-StrongCallChance-Description", "Šance, že další volání posil bude silnější než současná úroveň heat");
        this.Text("GibbonGR-StrongCallHeatBonus-Name", "Heat bonus pro silné volání");
        this.Text("GibbonGR-StrongCallHeatBonus-Description", "Kolik extra heat bude mít silné volání");
        this.Text("GibbonGR-TurfHeatBonus-Name", "Heat bonus za teritorium");
        this.Text("GibbonGR-TurfHeatBonus-Description", "Extra počáteční heat když gang volá na svém vlastním teritoriu");
        this.Text("GibbonGR-GracePeriod-Category", "Milostivé období");
        this.Text("GibbonGR-Cooldowns-Category", "Doby čekání");
        this.Text("GibbonGR-Heat-Category", "Heat");
	}
}
