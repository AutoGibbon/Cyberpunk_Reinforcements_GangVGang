module Gibbon.GR.Localization.Packages
import Codeware.Localization.*

public class GR_zh_cn extends ModLocalizationPackage{

	protected func DefineTexts(){
        this.Text("GibbonGR-Title","Reinforcements Gang Vs Gang");
		this.Text("GibbonGR-Enabled-Name", "启用");
        this.Text("GibbonGR-EnabledInCombat-Name", "玩家战斗时启用");
        this.Text("GibbonGR-EnabledWhenPlayerIsPassenger-Name", "玩家为乘客时启用");
        this.Text("GibbonGR-GracePeriodMin-Name", "最小宽限时间");
        this.Text("GibbonGR-GracePeriodMin-Description", "帮派在战斗中首次呼叫支援前的最短时间");
        this.Text("GibbonGR-GracePeriodMax-Name", "最大宽限时间");
        this.Text("GibbonGR-GracePeriodMax-Description", "帮派在战斗中首次呼叫支援前的最大时间");
        this.Text("GibbonGR-CallSuccessCooldownMin-Name", "最小呼叫冷却");
        this.Text("GibbonGR-CallSuccessCooldownMin-Description", "帮派在同一战斗中再次呼叫支援前必须等待的最短时间");
        this.Text("GibbonGR-CallSuccessCooldownMax-Name", "最大呼叫冷却");
        this.Text("GibbonGR-CallSuccessCooldownMax-Description", "帮派在同一战斗中再次呼叫支援前必须等待的最大时间");
        this.Text("GibbonGR-HeatResetCooldown-Name", "限制冷却");
        this.Text("GibbonGR-HeatResetCooldown-Description", "帮派在达到呼叫限制后再次呼叫前必须等待的时间");
        this.Text("GibbonGR-InitialHeat-Name", "初始热度");
        this.Text("GibbonGR-InitialHeat-Description", "第一次支援呼叫的强度");
        this.Text("GibbonGR-HeatEscalation-Name", "热度升级");
        this.Text("GibbonGR-HeatEscalation-Description", "每个帮派每次呼叫的热度增加量");
        this.Text("GibbonGR-CallsLimit-Name", "呼叫限制");
        this.Text("GibbonGR-CallsLimit-Description", "帮派在必须等待限制冷却前可以进行的呼叫次数");
        this.Text("GibbonGR-StrongCallChance-Name", "强力呼叫几率");
        this.Text("GibbonGR-StrongCallChance-Description", "下一次支援呼叫比当前热度等级更强的几率");
        this.Text("GibbonGR-StrongCallHeatBonus-Name", "强力呼叫热度奖励");
        this.Text("GibbonGR-StrongCallHeatBonus-Description", "强力呼叫将获得的额外热度");
        this.Text("GibbonGR-TurfHeatBonus-Name", "地盘热度奖励");
        this.Text("GibbonGR-TurfHeatBonus-Description", "帮派在自己地盘呼叫时的额外初始热度");
        this.Text("GibbonGR-GracePeriod-Category", "宽限时间");
        this.Text("GibbonGR-Cooldowns-Category", "冷却时间");
        this.Text("GibbonGR-Heat-Category", "热度");
	}
}
