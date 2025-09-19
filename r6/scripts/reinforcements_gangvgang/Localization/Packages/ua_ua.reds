module Gibbon.GR.Localization.Packages
import Codeware.Localization.*

public class GR_ua_ua extends ModLocalizationPackage{

	protected func DefineTexts(){
        this.Text("GibbonGR-Title","Reinforcements Gang Vs Gang");
		this.Text("GibbonGR-Enabled-Name", "Увімкнено");
        this.Text("GibbonGR-EnabledInCombat-Name", "Увімкнено коли гравець в бою");
        this.Text("GibbonGR-EnabledWhenPlayerIsPassenger-Name", "Увімкнено коли гравець пасажир");
        this.Text("GibbonGR-GracePeriodMin-Name", "Мінімальний період затишшя");
        this.Text("GibbonGR-GracePeriodMin-Description", "Мінімальний час перед тим як банда може вперше викликати підкріплення в бою");
        this.Text("GibbonGR-GracePeriodMax-Name", "Максимальний період затишшя");
        this.Text("GibbonGR-GracePeriodMax-Description", "Максимальний час перед тим як банда може вперше викликати підкріплення в бою");
        this.Text("GibbonGR-CallSuccessCooldownMin-Name", "Мінімальний кулдаун виклику");
        this.Text("GibbonGR-CallSuccessCooldownMin-Description", "Мінімальний час який банда повинна чекати перед повторним викликом підкріплення в тому ж бою");
        this.Text("GibbonGR-CallSuccessCooldownMax-Name", "Максимальний кулдаун виклику");
        this.Text("GibbonGR-CallSuccessCooldownMax-Description", "Максимальний час який банда повинна чекати перед повторним викликом підкріплення в тому ж бою");
        this.Text("GibbonGR-HeatResetCooldown-Name", "Ліміт кулдаун");
        this.Text("GibbonGR-HeatResetCooldown-Description", "Скільки часу банда повинна чекати перед повторним викликом після досягнення ліміту викликів");
        this.Text("GibbonGR-InitialHeat-Name", "Початкова напруга");
        this.Text("GibbonGR-InitialHeat-Description", "Наскільки сильним буде перший виклик підкріплення");
        this.Text("GibbonGR-HeatEscalation-Name", "Ескалація напруги");
        this.Text("GibbonGR-HeatEscalation-Description", "На скільки збільшується напруга на банду за виклик");
        this.Text("GibbonGR-CallsLimit-Name", "Ліміт викликів");
        this.Text("GibbonGR-CallsLimit-Description", "Кількість викликів яку банда може зробити перед тим як повинна чекати ліміт кулдаун");
        this.Text("GibbonGR-StrongCallChance-Name", "Шанс сильного виклику");
        this.Text("GibbonGR-StrongCallChance-Description", "Шанс що наступний виклик підкріплення буде сильнішим за поточний рівень напруги");
        this.Text("GibbonGR-StrongCallHeatBonus-Name", "Бонус напруги за сильний виклик");
        this.Text("GibbonGR-StrongCallHeatBonus-Description", "Скільки додаткової напруги буде у сильного виклику");
        this.Text("GibbonGR-TurfHeatBonus-Name", "Бонус напруги за територію");
        this.Text("GibbonGR-TurfHeatBonus-Description", "Додаткова початкова напруга коли банда викликає на своїй території");
        this.Text("GibbonGR-GracePeriod-Category", "Період затишшя");
        this.Text("GibbonGR-Cooldowns-Category", "Кулдауни");
        this.Text("GibbonGR-Heat-Category", "Напруга");
	}
}
