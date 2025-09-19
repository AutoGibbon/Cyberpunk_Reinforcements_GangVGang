module Gibbon.GR.Localization.Packages
import Codeware.Localization.*
 
public class GR_jp_jp extends ModLocalizationPackage{
 
    protected func DefineTexts(){
        this.Text("GibbonGR-Title","Reinforcements Gang Vs Gang");
        this.Text("GibbonGR-Enabled-Name", "有効");
        this.Text("GibbonGR-EnabledInCombat-Name", "プレイヤーが戦闘中の場合に有効");
        this.Text("GibbonGR-EnabledWhenPlayerIsPassenger-Name", "プレイヤーが乗客の場合に有効");
        this.Text("GibbonGR-GracePeriodMin-Name", "最小猶予時間");
        this.Text("GibbonGR-GracePeriodMin-Description", "ギャングが戦闘で初回に増援を呼ぶまでの最小時間");
        this.Text("GibbonGR-GracePeriodMax-Name", "最大猶予時間");
        this.Text("GibbonGR-GracePeriodMax-Description", "ギャングが戦闘で初回に増援を呼ぶまでの最大時間");
        this.Text("GibbonGR-CallSuccessCooldownMin-Name", "増援要請 - 最小クールダウン");
        this.Text("GibbonGR-CallSuccessCooldownMin-Description", "ギャングが同じ戦闘で再度増援を呼ぶまでに待機する最小時間");
        this.Text("GibbonGR-CallSuccessCooldownMax-Name", "増援要請 - 最大クールダウン");
        this.Text("GibbonGR-CallSuccessCooldownMax-Description", "ギャングが同じ戦闘で再度増援を呼ぶまでに待機する最大時間");
        this.Text("GibbonGR-HeatResetCooldown-Name", "増援要請 - 制限クールダウン");
        this.Text("GibbonGR-HeatResetCooldown-Description", "ギャングが増援要請制限に達した後、再度呼ぶまでに待機する時間");
        this.Text("GibbonGR-InitialHeat-Name", "初期手配度");
        this.Text("GibbonGR-InitialHeat-Description", "最初の増援の強度");
        this.Text("GibbonGR-HeatEscalation-Name", "手配度上昇");
        this.Text("GibbonGR-HeatEscalation-Description", "ギャングごと、増援要請ごとの手配度増加量");
        this.Text("GibbonGR-CallsLimit-Name", "増援要請 - 制限");
        this.Text("GibbonGR-CallsLimit-Description", "ギャングが制限クールダウンを待つ前に可能な増援要請数");
        this.Text("GibbonGR-StrongCallChance-Name", "強化増援要請 - 確率");
        this.Text("GibbonGR-StrongCallChance-Description", "次の増援要請が現在の手配度より強くなる確率");
        this.Text("GibbonGR-StrongCallHeatBonus-Name", "強化増援要請 - 増加量");
        this.Text("GibbonGR-StrongCallHeatBonus-Description", "強化増援要請における追加手配度");
        this.Text("GibbonGR-TurfHeatBonus-Name", "初期手配度 - 支配圏ボーナス");
        this.Text("GibbonGR-TurfHeatBonus-Description", "ギャングが自分の支配圏で増援要請する際の追加初期手配度");
        this.Text("GibbonGR-GracePeriod-Category", "猶予時間");
        this.Text("GibbonGR-Cooldowns-Category", "クールダウン");
        this.Text("GibbonGR-Heat-Category", "手配度");
    }
}