module Gibbon.GR.GangData

public abstract class GRGangData {
    protected func GetReinforcements(heat: Int32) -> array<TweakDBID> 

	public func GetTrafficSpawns() -> array<TweakDBID> {
		return this.GetReinforcementsClamped(RandRange(1, 8), 1);
	}
    
    public func GetReinforcementsClamped(heat: Int32, maxCount: Int32) -> array<TweakDBID> {
        let reinforcements = this.GetReinforcements(heat);
        let count = ArraySize(reinforcements);
        if count <= maxCount {
            return reinforcements;
        } else {
            return GetRandomFrom(reinforcements, maxCount);
        }
    }
}

func GetRandomFrom(from: array<TweakDBID>, count: Int32) -> array<TweakDBID> {
    let arraySize = ArraySize(from);
    let output: array<TweakDBID> = [];
    let randomNumber: Int32;
    let i: Int32 = 0;
    while i < count {
        randomNumber = RandRange(0, arraySize - 1);

        ArrayPush(output, from[randomNumber]);

        i += 1;
    }

    return output;
}

/*
func GetRandomFrom(from: array<TweakDBID>, count: Int32) -> array<TweakDBID> {
    let arraySize = ArraySize(from);
    let output: array<TweakDBID> = [];
    let randomNumber: Int32;
    let i: Int32 = 0;
    while i < arraySize {
        randomNumber = RandRange(0, arraySize); 

        ArrayPush(output, from[randomNumber]);

        i += 1;
    }

    return output;
}
*/

func ArrayMerge(first: array<TweakDBID>, second: array<TweakDBID>) -> array<TweakDBID> {
    let arraySize = ArraySize(second);
    let i = 0;

    while i < arraySize {
        ArrayPush(first, second[i]);

        i += 1;
    }

    return first;
}

// abbreviations: W = weak, N = normal, R = rare, E = elite