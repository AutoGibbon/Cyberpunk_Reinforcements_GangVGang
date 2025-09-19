module Gibbon.GR.Localization.Packages
import Codeware.Localization.*

public class GR_hu_hu extends ModLocalizationPackage{

	protected func DefineTexts(){
        this.Text("GibbonGR-Title","Reinforcements Gang Vs Gang");
		this.Text("GibbonGR-Enabled-Name", "Engedélyezve");
        this.Text("GibbonGR-EnabledInCombat-Name", "Engedélyezve amikor a játékos harcban van");
        this.Text("GibbonGR-EnabledWhenPlayerIsPassenger-Name", "Engedélyezve amikor a játékos utas");
        this.Text("GibbonGR-GracePeriodMin-Name", "Minimális kegyelem időszak");
        this.Text("GibbonGR-GracePeriodMin-Description", "Minimális idő mielőtt egy csapat először hívhat erősítést egy harcban");
        this.Text("GibbonGR-GracePeriodMax-Name", "Maximális kegyelem időszak");
        this.Text("GibbonGR-GracePeriodMax-Description", "Maximális idő mielőtt egy csapat először hívhat erősítést egy harcban");
        this.Text("GibbonGR-CallSuccessCooldownMin-Name", "Minimális hívás cooldown");
        this.Text("GibbonGR-CallSuccessCooldownMin-Description", "Minimális idő amit egy csapat várnia kell mielőtt újra hívhat erősítést ugyanabban a harcban");
        this.Text("GibbonGR-CallSuccessCooldownMax-Name", "Maximális hívás cooldown");
        this.Text("GibbonGR-CallSuccessCooldownMax-Description", "Maximális idő amit egy csapat várnia kell mielőtt újra hívhat erősítést ugyanabban a harcban");
        this.Text("GibbonGR-HeatResetCooldown-Name", "Limit cooldown");
        this.Text("GibbonGR-HeatResetCooldown-Description", "Mennyi ideig kell várnia egy csapatnak mielőtt újra hívhat a hívás limit elérése után");
        this.Text("GibbonGR-InitialHeat-Name", "Kezdeti hő");
        this.Text("GibbonGR-InitialHeat-Description", "Milyen erős lesz az első erősítés hívás");
        this.Text("GibbonGR-HeatEscalation-Name", "Hő eszkaláció");
        this.Text("GibbonGR-HeatEscalation-Description", "Mennyivel nő a hő csapatonként hívásonként");
        this.Text("GibbonGR-CallsLimit-Name", "Hívás limit");
        this.Text("GibbonGR-CallsLimit-Description", "A hívások száma amit egy csapat megtehet mielőtt a limit cooldown-t kell várnia");
        this.Text("GibbonGR-StrongCallChance-Name", "Erős hívás esély");
        this.Text("GibbonGR-StrongCallChance-Description", "Esély hogy a következő erősítés hívás erősebb lesz mint a jelenlegi hő szint");
        this.Text("GibbonGR-StrongCallHeatBonus-Name", "Erős hívás hő bónusz");
        this.Text("GibbonGR-StrongCallHeatBonus-Description", "Mennyi extra hőt kap az erős hívás");
        this.Text("GibbonGR-TurfHeatBonus-Name", "Terület hő bónusz");
        this.Text("GibbonGR-TurfHeatBonus-Description", "Extra kezdeti hő amikor egy csapat a saját területén hív");
        this.Text("GibbonGR-GracePeriod-Category", "Kegyelem időszak");
        this.Text("GibbonGR-Cooldowns-Category", "Cooldown-ok");
        this.Text("GibbonGR-Heat-Category", "Hő");
	}
}
