module Gibbon.GR.GangData


public class GRKangTaoData extends GRGangData {
	public func GetReinforcements(heat: Int32) -> array<TweakDBID> {
        switch (heat) {
            case 1: // 1 weak car
                let ww = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRKangTaoWW1",
                        t"DynamicSpawnSystem.GRKangTaoWW2",
                        t"DynamicSpawnSystem.GRKangTaoWW3"
                    ], 1);
                return ww;
            case 2: // 1 weak car
                let ww = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRKangTaoWW1",
                        t"DynamicSpawnSystem.GRKangTaoWW2",
                        t"DynamicSpawnSystem.GRKangTaoWW3"
                    ], 1);
                return ww;
            case 3: // 1 weak/normal car
                let nw = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRKangTaoNW1",
                        t"DynamicSpawnSystem.GRKangTaoNW2",
                        t"DynamicSpawnSystem.GRKangTaoNW3"
                    ], 1);
                return nw;
            case 4: // 2 weak cars
                let ww = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRKangTaoWW1",
                        t"DynamicSpawnSystem.GRKangTaoWW2",
                        t"DynamicSpawnSystem.GRKangTaoWW3"
                    ], 2);
                return ww;
            case 5: // 1 weak car, 1 weak/normal car
                let ww = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRKangTaoWW1",
                        t"DynamicSpawnSystem.GRKangTaoWW2",
                        t"DynamicSpawnSystem.GRKangTaoWW3"
                    ], 1);

                let nw = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRKangTaoNW1",
                        t"DynamicSpawnSystem.GRKangTaoNW2",
                        t"DynamicSpawnSystem.GRKangTaoNW3"
                    ], 1);

                return ArrayMerge(ww, nw);
            case 6: // 2 weak/normal cars
                let nw = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRKangTaoNW1",
                        t"DynamicSpawnSystem.GRKangTaoNW2",
                        t"DynamicSpawnSystem.GRKangTaoNW3"
                    ], 2);
                return nw;
            case 7: // 1 weak/normal car, 1 rare car
                let nw = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRKangTaoNW1",
                        t"DynamicSpawnSystem.GRKangTaoNW2",
                        t"DynamicSpawnSystem.GRKangTaoNW3"
                    ], 1);

                let rn = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRKangTaoRN1",
                        t"DynamicSpawnSystem.GRKangTaoRN2",
                        t"DynamicSpawnSystem.GRKangTaoRN3"
                    ], 1);

                return ArrayMerge(nw, rn);
            case 8: // 2 rare cars
                let rn = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRKangTaoRN1",
                        t"DynamicSpawnSystem.GRKangTaoRN2",
                        t"DynamicSpawnSystem.GRKangTaoRN3"
                    ], 2);
                return rn;
            case 9: // 1 weak car, 2 rare cars
                let ww = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRKangTaoWW1",
                        t"DynamicSpawnSystem.GRKangTaoWW2",
                        t"DynamicSpawnSystem.GRKangTaoWW3"
                    ], 1);

                let rn = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRKangTaoRN1",
                        t"DynamicSpawnSystem.GRKangTaoRN2",
                        t"DynamicSpawnSystem.GRKangTaoRN3"
                    ], 2);

                return ArrayMerge(ww, rn);
            case 10: // 1 weak/normal car, 1 rare car, 1 elite car
                let nw = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRKangTaoNW1",
                        t"DynamicSpawnSystem.GRKangTaoNW2",
                        t"DynamicSpawnSystem.GRKangTaoNW3"
                    ], 1);

                let rn = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRKangTaoRN1",
                        t"DynamicSpawnSystem.GRKangTaoRN2",
                        t"DynamicSpawnSystem.GRKangTaoRN3"
                    ], 1);

                let er = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRKangTaoER1",
                        t"DynamicSpawnSystem.GRKangTaoER2",
                        t"DynamicSpawnSystem.GRKangTaoER3"
                    ], 1);

                return ArrayMerge(ArrayMerge(nw, rn), er);
            case 11: // 2 rare cars, 1 elite car
                let rn = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRKangTaoRN1",
                        t"DynamicSpawnSystem.GRKangTaoRN2",
                        t"DynamicSpawnSystem.GRKangTaoRN3"
                    ], 2);

                let er = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRKangTaoER1",
                        t"DynamicSpawnSystem.GRKangTaoER2",
                        t"DynamicSpawnSystem.GRKangTaoER3"
                    ], 1);

                return ArrayMerge(rn, er);
            case 12: // 1 rare car, 2 elite cars
                let rn = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRKangTaoRN1",
                        t"DynamicSpawnSystem.GRKangTaoRN2",
                        t"DynamicSpawnSystem.GRKangTaoRN3"
                    ], 1);

                let er = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRKangTaoER1",
                        t"DynamicSpawnSystem.GRKangTaoER2",
                        t"DynamicSpawnSystem.GRKangTaoER3"
                    ], 2);

                return ArrayMerge(rn, er);
            case 13: // 3 rare cars
                let rn = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRKangTaoRN1",
                        t"DynamicSpawnSystem.GRKangTaoRN2",
                        t"DynamicSpawnSystem.GRKangTaoRN3"
                    ], 3);
                return rn;
            case 14: // 1 weak/normal car, 3 rare cars
                let nw = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRKangTaoNW1",
                        t"DynamicSpawnSystem.GRKangTaoNW2",
                        t"DynamicSpawnSystem.GRKangTaoNW3"
                    ], 1);

                let rn = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRKangTaoRN1",
                        t"DynamicSpawnSystem.GRKangTaoRN2",
                        t"DynamicSpawnSystem.GRKangTaoRN3"
                    ], 3);

                return ArrayMerge(nw, rn);
            case 15: // 1 rare car, 2 elite cars
                let rn = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRKangTaoRN1",
                        t"DynamicSpawnSystem.GRKangTaoRN2",
                        t"DynamicSpawnSystem.GRKangTaoRN3"
                    ], 1);

                let er = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRKangTaoER1",
                        t"DynamicSpawnSystem.GRKangTaoER2",
                        t"DynamicSpawnSystem.GRKangTaoER3"
                    ], 2);

                return ArrayMerge(rn, er);
            case 16: // 3 elite cars
                let er = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRKangTaoER1",
                        t"DynamicSpawnSystem.GRKangTaoER2",
                        t"DynamicSpawnSystem.GRKangTaoER3"
                    ], 3);
                return er;
            case 17: // 1 rare car, 3 elite cars
                let rn = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRKangTaoRN1",
                        t"DynamicSpawnSystem.GRKangTaoRN2",
                        t"DynamicSpawnSystem.GRKangTaoRN3"
                    ], 1);

                let er = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRKangTaoER1",
                        t"DynamicSpawnSystem.GRKangTaoER2",
                        t"DynamicSpawnSystem.GRKangTaoER3"
                    ], 3);

                return ArrayMerge(rn, er);
            case 18: // 2 rare cars, 3 elite cars
                let rn = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRKangTaoRN1",
                        t"DynamicSpawnSystem.GRKangTaoRN2",
                        t"DynamicSpawnSystem.GRKangTaoRN3"
                    ], 2);

                let er = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRKangTaoER1",
                        t"DynamicSpawnSystem.GRKangTaoER2",
                        t"DynamicSpawnSystem.GRKangTaoER3"
                    ], 3);

                return ArrayMerge(rn, er);
            case 19: // 4 elite cars
                let er = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRKangTaoER1",
                        t"DynamicSpawnSystem.GRKangTaoER2",
                        t"DynamicSpawnSystem.GRKangTaoER3"
                    ], 4);
                return er;
            case 20: // 1 rare car, 4 elite cars
                let rn = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRKangTaoRN1",
                        t"DynamicSpawnSystem.GRKangTaoRN2",
                        t"DynamicSpawnSystem.GRKangTaoRN3"
                    ], 1);

                let er = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRKangTaoER1",
                        t"DynamicSpawnSystem.GRKangTaoER2",
                        t"DynamicSpawnSystem.GRKangTaoER3"
                    ], 4);

                return ArrayMerge(rn, er);
            default:
                return [];
        }
    }
}
