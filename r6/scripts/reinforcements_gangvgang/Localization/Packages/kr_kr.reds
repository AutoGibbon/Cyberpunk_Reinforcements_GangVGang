module Gibbon.GR.Localization.Packages
import Codeware.Localization.*

public class GR_kr_kr extends ModLocalizationPackage{

	protected func DefineTexts(){
        this.Text("GibbonGR-Title","Reinforcements Gang Vs Gang");
		this.Text("GibbonGR-Enabled-Name", "활성화");
        this.Text("GibbonGR-EnabledInCombat-Name", "플레이어가 전투 중일 때 활성화");
        this.Text("GibbonGR-EnabledWhenPlayerIsPassenger-Name", "플레이어가 승객일 때 활성화");
        this.Text("GibbonGR-GracePeriodMin-Name", "최소 유예 기간");
        this.Text("GibbonGR-GracePeriodMin-Description", "갱이 전투에서 처음으로 백업을 호출하기 전의 최소 시간");
        this.Text("GibbonGR-GracePeriodMax-Name", "최대 유예 기간");
        this.Text("GibbonGR-GracePeriodMax-Description", "갱이 전투에서 처음으로 백업을 호출하기 전의 최대 시간");
        this.Text("GibbonGR-CallSuccessCooldownMin-Name", "최소 호출 쿨다운");
        this.Text("GibbonGR-CallSuccessCooldownMin-Description", "갱이 같은 전투에서 다시 백업을 호출하기 전에 기다려야 하는 최소 시간");
        this.Text("GibbonGR-CallSuccessCooldownMax-Name", "최대 호출 쿨다운");
        this.Text("GibbonGR-CallSuccessCooldownMax-Description", "갱이 같은 전투에서 다시 백업을 호출하기 전에 기다려야 하는 최대 시간");
        this.Text("GibbonGR-HeatResetCooldown-Name", "제한 쿨다운");
        this.Text("GibbonGR-HeatResetCooldown-Description", "갱이 호출 한계에 도달한 후 다시 호출하기 전에 기다려야 하는 시간");
        this.Text("GibbonGR-InitialHeat-Name", "초기 히트");
        this.Text("GibbonGR-InitialHeat-Description", "첫 번째 백업 호출의 강도");
        this.Text("GibbonGR-HeatEscalation-Name", "히트 에스컬레이션");
        this.Text("GibbonGR-HeatEscalation-Description", "갱당 호출당 히트 증가량");
        this.Text("GibbonGR-CallsLimit-Name", "호출 한계");
        this.Text("GibbonGR-CallsLimit-Description", "갱이 제한 쿨다운을 기다리기 전에 할 수 있는 호출 수");
        this.Text("GibbonGR-StrongCallChance-Name", "강력한 호출 확률");
        this.Text("GibbonGR-StrongCallChance-Description", "다음 백업 호출이 현재 히트 레벨보다 강해질 확률");
        this.Text("GibbonGR-StrongCallHeatBonus-Name", "강력한 호출 히트 보너스");
        this.Text("GibbonGR-StrongCallHeatBonus-Description", "강력한 호출이 가질 추가 히트량");
        this.Text("GibbonGR-TurfHeatBonus-Name", "영역 히트 보너스");
        this.Text("GibbonGR-TurfHeatBonus-Description", "갱이 자신의 영역에서 호출할 때의 추가 초기 히트");
        this.Text("GibbonGR-GracePeriod-Category", "유예 기간");
        this.Text("GibbonGR-Cooldowns-Category", "쿨다운");
        this.Text("GibbonGR-Heat-Category", "히트");
	}
}
