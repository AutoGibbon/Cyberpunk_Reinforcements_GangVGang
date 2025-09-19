module Gibbon.GR.GangData

public abstract class GRGangData {
    public func GetReinforcements(heat: Int32) -> array<TweakDBID> 
}

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

func ArrayMerge(first: array<TweakDBID>, second: array<TweakDBID>) -> array<TweakDBID> {
    let arraySize = ArraySize(second);
    let i = 0;

    while i < arraySize {
        ArrayPush(first, second[i]);

        i += 1;
    }

    return first;
}

