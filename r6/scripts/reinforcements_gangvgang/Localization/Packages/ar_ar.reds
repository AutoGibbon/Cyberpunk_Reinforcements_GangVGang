module Gibbon.GR.Localization.Packages
import Codeware.Localization.*

public class GR_ar_ar extends ModLocalizationPackage{

	protected func DefineTexts(){
        this.Text("GibbonGR-Title","Reinforcements Gang Vs Gang");
		this.Text("GibbonGR-Enabled-Name", "مفعل");
        this.Text("GibbonGR-EnabledInCombat-Name", "مفعل عندما يكون اللاعب في قتال");
        this.Text("GibbonGR-EnabledWhenPlayerIsPassenger-Name", "مفعل عندما يكون اللاعب راكب");
        this.Text("GibbonGR-GracePeriodMin-Name", "فترة السماح الدنيا");
        this.Text("GibbonGR-GracePeriodMin-Description", "الحد الأدنى للوقت قبل أن تتمكن العصابة من طلب الدعم لأول مرة في قتال");
        this.Text("GibbonGR-GracePeriodMax-Name", "فترة السماح القصوى");
        this.Text("GibbonGR-GracePeriodMax-Description", "الحد الأقصى للوقت قبل أن تتمكن العصابة من طلب الدعم لأول مرة في قتال");
        this.Text("GibbonGR-CallSuccessCooldownMin-Name", "الحد الأدنى لوقت انتظار الاستدعاء");
        this.Text("GibbonGR-CallSuccessCooldownMin-Description", "الحد الأدنى للوقت الذي يجب أن تنتظره العصابة قبل طلب الدعم مرة أخرى في نفس القتال");
        this.Text("GibbonGR-CallSuccessCooldownMax-Name", "الحد الأقصى لوقت انتظار الاستدعاء");
        this.Text("GibbonGR-CallSuccessCooldownMax-Description", "الحد الأقصى للوقت الذي يجب أن تنتظره العصابة قبل طلب الدعم مرة أخرى في نفس القتال");
        this.Text("GibbonGR-HeatResetCooldown-Name", "وقت انتظار الحد");
        this.Text("GibbonGR-HeatResetCooldown-Description", "كم من الوقت يجب أن تنتظره العصابة قبل الاستدعاء مرة أخرى بعد الوصول إلى حد الاستدعاءات");
        this.Text("GibbonGR-InitialHeat-Name", "الحرارة الأولية");
        this.Text("GibbonGR-InitialHeat-Description", "مدى قوة استدعاء الدعم الأول");
        this.Text("GibbonGR-HeatEscalation-Name", "تصعيد الحرارة");
        this.Text("GibbonGR-HeatEscalation-Description", "مقدار زيادة الحرارة لكل عصابة لكل استدعاء");
        this.Text("GibbonGR-CallsLimit-Name", "حد الاستدعاءات");
        this.Text("GibbonGR-CallsLimit-Description", "عدد الاستدعاءات التي يمكن للعصابة القيام بها قبل أن تضطر لانتظار وقت انتظار الحد");
        this.Text("GibbonGR-StrongCallChance-Name", "فرصة الاستدعاء القوي");
        this.Text("GibbonGR-StrongCallChance-Description", "احتمالية أن يكون استدعاء الدعم التالي أقوى من مستوى الحرارة الحالي");
        this.Text("GibbonGR-StrongCallHeatBonus-Name", "مكافأة الحرارة للاستدعاء القوي");
        this.Text("GibbonGR-StrongCallHeatBonus-Description", "كم من الحرارة الإضافية ستحصل عليها الاستدعاءات القوية");
        this.Text("GibbonGR-TurfHeatBonus-Name", "مكافأة حرارة المنطقة");
        this.Text("GibbonGR-TurfHeatBonus-Description", "حرارة أولية إضافية عندما تستدعي العصابة في منطقتها الخاصة");
        this.Text("GibbonGR-GracePeriod-Category", "فترة السماح");
        this.Text("GibbonGR-Cooldowns-Category", "أوقات الانتظار");
        this.Text("GibbonGR-Heat-Category", "الحرارة");
	}
}
