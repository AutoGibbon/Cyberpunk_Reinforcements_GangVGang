module Gibbon.GR.Localization.Packages
import Codeware.Localization.*

public class GR_tr_tr extends ModLocalizationPackage{

	protected func DefineTexts(){
        this.Text("GibbonGR-Title","Reinforcements Gang Vs Gang");
		this.Text("GibbonGR-Enabled-Name", "Etkin");
        this.Text("GibbonGR-EnabledInCombat-Name", "Oyuncu savaştayken etkin");
        this.Text("GibbonGR-EnabledWhenPlayerIsPassenger-Name", "Oyuncu yolcu olduğunda etkin");
        this.Text("GibbonGR-GracePeriodMin-Name", "Minimum lütuf süresi");
        this.Text("GibbonGR-GracePeriodMin-Description", "Bir çetenin savaşta ilk kez takviye çağırabilmesi için geçmesi gereken minimum süre");
        this.Text("GibbonGR-GracePeriodMax-Name", "Maksimum lütuf süresi");
        this.Text("GibbonGR-GracePeriodMax-Description", "Bir çetenin savaşta ilk kez takviye çağırabilmesi için geçmesi gereken maksimum süre");
        this.Text("GibbonGR-CallSuccessCooldownMin-Name", "Minimum çağrı bekleme süresi");
        this.Text("GibbonGR-CallSuccessCooldownMin-Description", "Bir çetenin aynı savaşta tekrar takviye çağırmadan önce beklemesi gereken minimum süre");
        this.Text("GibbonGR-CallSuccessCooldownMax-Name", "Maksimum çağrı bekleme süresi");
        this.Text("GibbonGR-CallSuccessCooldownMax-Description", "Bir çetenin aynı savaşta tekrar takviye çağırmadan önce beklemesi gereken maksimum süre");
        this.Text("GibbonGR-HeatResetCooldown-Name", "Limit bekleme süresi");
        this.Text("GibbonGR-HeatResetCooldown-Description", "Bir çetenin çağrı limitine ulaştıktan sonra tekrar çağırmadan önce beklemesi gereken süre");
        this.Text("GibbonGR-InitialHeat-Name", "Başlangıç sıcaklığı");
        this.Text("GibbonGR-InitialHeat-Description", "İlk takviye çağrısının ne kadar güçlü olacağı");
        this.Text("GibbonGR-HeatEscalation-Name", "Sıcaklık artışı");
        this.Text("GibbonGR-HeatEscalation-Description", "Çete başına çağrı başına sıcaklığın ne kadar arttığı");
        this.Text("GibbonGR-CallsLimit-Name", "Çağrı limiti");
        this.Text("GibbonGR-CallsLimit-Description", "Bir çetenin limit bekleme süresini beklemeden önce yapabileceği çağrı sayısı");
        this.Text("GibbonGR-StrongCallChance-Name", "Güçlü çağrı şansı");
        this.Text("GibbonGR-StrongCallChance-Description", "Bir sonraki takviye çağrısının mevcut sıcaklık seviyesinden daha güçlü olma şansı");
        this.Text("GibbonGR-StrongCallHeatBonus-Name", "Güçlü çağrı sıcaklık bonusu");
        this.Text("GibbonGR-StrongCallHeatBonus-Description", "Güçlü çağrının ne kadar ekstra sıcaklığa sahip olacağı");
        this.Text("GibbonGR-TurfHeatBonus-Name", "Bölge sıcaklık bonusu");
        this.Text("GibbonGR-TurfHeatBonus-Description", "Bir çete kendi bölgesinde çağrı yaptığında ekstra başlangıç sıcaklığı");
        this.Text("GibbonGR-GracePeriod-Category", "Lütuf süresi");
        this.Text("GibbonGR-Cooldowns-Category", "Bekleme süreleri");
        this.Text("GibbonGR-Heat-Category", "Sıcaklık");
	}
}
