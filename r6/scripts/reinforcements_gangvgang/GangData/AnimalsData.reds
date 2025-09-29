module Gibbon.GR.GangData

public class GRAnimalsData extends GRGangData {
	public func GetReinforcements(heat: Int32) -> array<TweakDBID> { 
        switch (heat) {
            case 1: // 1 weak
                let weakBike = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRAnimalsWeakBike1",
                        t"DynamicSpawnSystem.GRAnimalsWeakBike2",
                        t"DynamicSpawnSystem.GRAnimalsWeakBike3"
                    ], 1);
                return weakBike;
            case 2:  // 1 weak, 1 normal           
                let weakBike = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRAnimalsWeakBike1",
                        t"DynamicSpawnSystem.GRAnimalsWeakBike2",
                        t"DynamicSpawnSystem.GRAnimalsWeakBike3"
                    ], 1);

                let normalCar = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRAnimalsNormal1",
                        t"DynamicSpawnSystem.GRAnimalsNormal2",
                        t"DynamicSpawnSystem.GRAnimalsNormal3",
                        t"DynamicSpawnSystem.GRAnimalsNormal4",
                        t"DynamicSpawnSystem.GRAnimalsNormal5",
                        t"DynamicSpawnSystem.GRAnimalsNormal6",
                        t"DynamicSpawnSystem.GRAnimalsNormal7",
                        t"DynamicSpawnSystem.GRAnimalsNormal8"
                    ], 1);

                return ArrayMerge(normalCar, weakBike);
            case 3: // 2 normal
                let doubleTrouble = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRAnimalsNormalNormal1",
                        t"DynamicSpawnSystem.GRAnimalsNormalNormal2",
                        t"DynamicSpawnSystem.GRAnimalsNormalNormal3",
                        t"DynamicSpawnSystem.GRAnimalsNormalNormal4"
                    ], 1);
                return doubleTrouble;
            case 4: // 1 rare
                let rareBike = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRAnimalsRare1",
                        t"DynamicSpawnSystem.GRAnimalsRare2",
                        t"DynamicSpawnSystem.GRAnimalsRare3",
                        t"DynamicSpawnSystem.GRAnimalsRare4",
                        t"DynamicSpawnSystem.GRAnimalsRare5",
                        t"DynamicSpawnSystem.GRAnimalsRare6",
                        t"DynamicSpawnSystem.GRAnimalsRare7",
                        t"DynamicSpawnSystem.GRAnimalsRare8",
                        t"DynamicSpawnSystem.GRAnimalsRare9"
                    ], 1);
            
                return rareBike;           
            case 5:  // 2 normal, 1 rare
                let doubleTrouble = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRAnimalsNormalNormal1",
                        t"DynamicSpawnSystem.GRAnimalsNormalNormal2",
                        t"DynamicSpawnSystem.GRAnimalsNormalNormal3",
                        t"DynamicSpawnSystem.GRAnimalsNormalNormal4"
                    ], 1);
                let rareBike = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRAnimalsRare1",
                        t"DynamicSpawnSystem.GRAnimalsRare2",
                        t"DynamicSpawnSystem.GRAnimalsRare3",
                        t"DynamicSpawnSystem.GRAnimalsRare4",
                        t"DynamicSpawnSystem.GRAnimalsRare5",
                        t"DynamicSpawnSystem.GRAnimalsRare6",
                        t"DynamicSpawnSystem.GRAnimalsRare7",
                        t"DynamicSpawnSystem.GRAnimalsRare8",
                        t"DynamicSpawnSystem.GRAnimalsRare9"
                    ], 1);

                return ArrayMerge(doubleTrouble, rareBike);
            case 6:  // 1 weak, 2 normal, 1 rare
                let doubleTrouble = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRAnimalsNormalNormal1",
                        t"DynamicSpawnSystem.GRAnimalsNormalNormal2",
                        t"DynamicSpawnSystem.GRAnimalsNormalNormal3",
                        t"DynamicSpawnSystem.GRAnimalsNormalNormal4"
                    ], 1);
                let rareBike = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRAnimalsRare1",
                        t"DynamicSpawnSystem.GRAnimalsRare2",
                        t"DynamicSpawnSystem.GRAnimalsRare3",
                        t"DynamicSpawnSystem.GRAnimalsRare4",
                        t"DynamicSpawnSystem.GRAnimalsRare5",
                        t"DynamicSpawnSystem.GRAnimalsRare6",
                        t"DynamicSpawnSystem.GRAnimalsRare7",
                        t"DynamicSpawnSystem.GRAnimalsRare8",
                        t"DynamicSpawnSystem.GRAnimalsRare9"
                    ], 1);

                let weakBike = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRAnimalsWeakBike1",
                        t"DynamicSpawnSystem.GRAnimalsWeakBike2",
                        t"DynamicSpawnSystem.GRAnimalsWeakBike3"
                    ], 1);
                return ArrayMerge(doubleTrouble, ArrayMerge(rareBike, weakBike));
            case 7:  // 1 weak, 2 normal, 2 rare
                let weakBike = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRAnimalsWeakBike1",
                        t"DynamicSpawnSystem.GRAnimalsWeakBike2",
                        t"DynamicSpawnSystem.GRAnimalsWeakBike3"
                    ], 1);
                let squad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRAnimalsRareRareNormalNormal1",
                        t"DynamicSpawnSystem.GRAnimalsRareRareNormalNormal2",
                        t"DynamicSpawnSystem.GRAnimalsRareRareNormalNormal3"
                    ], 1);
                return ArrayMerge(squad, weakBike);
            case 8: // 2 normals, 3 rare            
                let weakBike = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRAnimalsWeakBike1",
                        t"DynamicSpawnSystem.GRAnimalsWeakBike2",
                        t"DynamicSpawnSystem.GRAnimalsWeakBike3"
                    ], 1);
                let squad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRAnimalsRareRareNormalNormal1",
                        t"DynamicSpawnSystem.GRAnimalsRareRareNormalNormal2",
                        t"DynamicSpawnSystem.GRAnimalsRareRareNormalNormal3"
                    ], 1);
                return ArrayMerge(squad, weakBike);
            case 9:  //  1 weak, 2 normals, 3 rare    
                let weakBike = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRAnimalsWeakBike1",
                        t"DynamicSpawnSystem.GRAnimalsWeakBike2",
                        t"DynamicSpawnSystem.GRAnimalsWeakBike3"
                    ], 1);

                let rareBike = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRAnimalsRare1",
                        t"DynamicSpawnSystem.GRAnimalsRare2",
                        t"DynamicSpawnSystem.GRAnimalsRare3",
                        t"DynamicSpawnSystem.GRAnimalsRare4",
                        t"DynamicSpawnSystem.GRAnimalsRare5",
                        t"DynamicSpawnSystem.GRAnimalsRare6",
                        t"DynamicSpawnSystem.GRAnimalsRare7",
                        t"DynamicSpawnSystem.GRAnimalsRare8",
                        t"DynamicSpawnSystem.GRAnimalsRare9"
                    ], 1);

                let squad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRAnimalsRareRareNormalNormal1",
                        t"DynamicSpawnSystem.GRAnimalsRareRareNormalNormal2",
                        t"DynamicSpawnSystem.GRAnimalsRareRareNormalNormal3"
                    ], 1);
                return ArrayMerge(ArrayMerge(squad, weakBike), rareBike);    
            case 10: //  2 rares, 2 elite
                let eliteSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRAnimalsRareRareEliteElite1",
                        t"DynamicSpawnSystem.GRAnimalsRareRareEliteElite2",
                        t"DynamicSpawnSystem.GRAnimalsRareRareEliteElite3"
                    ], 1);

                return eliteSquad;
            case 11: // 4 normals 2 rares, 2 elite
                    let eliteSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRAnimalsRareRareEliteElite1",
                        t"DynamicSpawnSystem.GRAnimalsRareRareEliteElite2",
                        t"DynamicSpawnSystem.GRAnimalsRareRareEliteElite3"
                    ], 1);

                let doubleTrouble = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRAnimalsNormalNormal1",
                        t"DynamicSpawnSystem.GRAnimalsNormalNormal2",
                        t"DynamicSpawnSystem.GRAnimalsNormalNormal3",
                        t"DynamicSpawnSystem.GRAnimalsNormalNormal4"
                    ], 2);
                return ArrayMerge(doubleTrouble, eliteSquad);       
            case 12: // 2 normals, 4 rares, 2 elite
                let eliteSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRAnimalsRareRareEliteElite1",
                        t"DynamicSpawnSystem.GRAnimalsRareRareEliteElite2",
                        t"DynamicSpawnSystem.GRAnimalsRareRareEliteElite3"
                    ], 1);

                let squad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRAnimalsRareRareNormalNormal1",
                        t"DynamicSpawnSystem.GRAnimalsRareRareNormalNormal2",
                        t"DynamicSpawnSystem.GRAnimalsRareRareNormalNormal3"
                    ], 1);                    
                return ArrayMerge(squad, eliteSquad);               
            case 13: // 1 weak, 2 normals, 4 rares, 2 elite
                let weakBike = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRAnimalsWeakBike1",
                        t"DynamicSpawnSystem.GRAnimalsWeakBike2",
                        t"DynamicSpawnSystem.GRAnimalsWeakBike3"
                    ], 1);
                let eliteSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRAnimalsRareRareEliteElite1",
                        t"DynamicSpawnSystem.GRAnimalsRareRareEliteElite2",
                        t"DynamicSpawnSystem.GRAnimalsRareRareEliteElite3"
                    ], 1);

                let squad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRAnimalsRareRareNormalNormal1",
                        t"DynamicSpawnSystem.GRAnimalsRareRareNormalNormal2",
                        t"DynamicSpawnSystem.GRAnimalsRareRareNormalNormal3"
                    ], 1);      

                return ArrayMerge(weakBike, ArrayMerge(squad, eliteSquad));    
            case 14: // 2 normals, 5 rares, 2 elite
                let rareBike = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRAnimalsRare1",
                        t"DynamicSpawnSystem.GRAnimalsRare2",
                        t"DynamicSpawnSystem.GRAnimalsRare3",
                        t"DynamicSpawnSystem.GRAnimalsRare4",
                        t"DynamicSpawnSystem.GRAnimalsRare5",
                        t"DynamicSpawnSystem.GRAnimalsRare6",
                        t"DynamicSpawnSystem.GRAnimalsRare7",
                        t"DynamicSpawnSystem.GRAnimalsRare8",
                        t"DynamicSpawnSystem.GRAnimalsRare9"
                    ], 1);
            
                let eliteSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRAnimalsRareRareEliteElite1",
                        t"DynamicSpawnSystem.GRAnimalsRareRareEliteElite2",
                        t"DynamicSpawnSystem.GRAnimalsRareRareEliteElite3"
                    ], 1);

                let squad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRAnimalsRareRareNormalNormal1",
                        t"DynamicSpawnSystem.GRAnimalsRareRareNormalNormal2",
                        t"DynamicSpawnSystem.GRAnimalsRareRareNormalNormal3"
                    ], 1);      

                return ArrayMerge(rareBike, ArrayMerge(squad, eliteSquad));    
            case 15: // 2 normals, 4 rares, 3 elite
                let eliteBike = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRAnimalsElite1",
                        t"DynamicSpawnSystem.GRAnimalsElite2",
                        t"DynamicSpawnSystem.GRAnimalsElite3",
                        t"DynamicSpawnSystem.GRAnimalsElite4"
                    ], 1);
            
                let eliteSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRAnimalsRareRareEliteElite1",
                        t"DynamicSpawnSystem.GRAnimalsRareRareEliteElite2",
                        t"DynamicSpawnSystem.GRAnimalsRareRareEliteElite3"
                    ], 1);

                let squad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRAnimalsRareRareNormalNormal1",
                        t"DynamicSpawnSystem.GRAnimalsRareRareNormalNormal2",
                        t"DynamicSpawnSystem.GRAnimalsRareRareNormalNormal3"
                    ], 1);      

                return ArrayMerge(eliteBike, ArrayMerge(squad, eliteSquad)); 
            case 16: // 5 rares, 3 elite
                let eliteBike = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRAnimalsElite1",
                        t"DynamicSpawnSystem.GRAnimalsElite2",
                        t"DynamicSpawnSystem.GRAnimalsElite3",
                        t"DynamicSpawnSystem.GRAnimalsElite4"
                    ], 1);
            
                let eliteSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRAnimalsRareRareEliteElite1",
                        t"DynamicSpawnSystem.GRAnimalsRareRareEliteElite2",
                        t"DynamicSpawnSystem.GRAnimalsRareRareEliteElite3"
                    ], 1);
                let rareBike = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRAnimalsRare1",
                        t"DynamicSpawnSystem.GRAnimalsRare2",
                        t"DynamicSpawnSystem.GRAnimalsRare3",
                        t"DynamicSpawnSystem.GRAnimalsRare4",
                        t"DynamicSpawnSystem.GRAnimalsRare5",
                        t"DynamicSpawnSystem.GRAnimalsRare6",
                        t"DynamicSpawnSystem.GRAnimalsRare7",
                        t"DynamicSpawnSystem.GRAnimalsRare8",
                        t"DynamicSpawnSystem.GRAnimalsRare9"
                    ], 1);
            
                return ArrayMerge(rareBike, ArrayMerge(eliteBike, eliteSquad)); 
            case 17: // 6 rares, 3 elite
                let eliteBike = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRAnimalsElite1",
                        t"DynamicSpawnSystem.GRAnimalsElite2",
                        t"DynamicSpawnSystem.GRAnimalsElite3",
                        t"DynamicSpawnSystem.GRAnimalsElite4"
                    ], 1);
            
                let eliteSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRAnimalsRareRareEliteElite1",
                        t"DynamicSpawnSystem.GRAnimalsRareRareEliteElite2",
                        t"DynamicSpawnSystem.GRAnimalsRareRareEliteElite3"
                    ], 1);
                let rareBike = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRAnimalsRare1",
                        t"DynamicSpawnSystem.GRAnimalsRare2",
                        t"DynamicSpawnSystem.GRAnimalsRare3",
                        t"DynamicSpawnSystem.GRAnimalsRare4",
                        t"DynamicSpawnSystem.GRAnimalsRare5",
                        t"DynamicSpawnSystem.GRAnimalsRare6",
                        t"DynamicSpawnSystem.GRAnimalsRare7",
                        t"DynamicSpawnSystem.GRAnimalsRare8",
                        t"DynamicSpawnSystem.GRAnimalsRare9"
                    ], 4);
            
                return ArrayMerge(rareBike, ArrayMerge(eliteBike, eliteSquad)); 
            case 18: // 3 rares, 4 elite
                let eliteBike = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRAnimalsElite1",
                        t"DynamicSpawnSystem.GRAnimalsElite2",
                        t"DynamicSpawnSystem.GRAnimalsElite3",
                        t"DynamicSpawnSystem.GRAnimalsElite4"
                    ], 2);
            
                let eliteSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRAnimalsRareRareEliteElite1",
                        t"DynamicSpawnSystem.GRAnimalsRareRareEliteElite2",
                        t"DynamicSpawnSystem.GRAnimalsRareRareEliteElite3"
                    ], 1);
                let rareBike = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRAnimalsRare1",
                        t"DynamicSpawnSystem.GRAnimalsRare2",
                        t"DynamicSpawnSystem.GRAnimalsRare3",
                        t"DynamicSpawnSystem.GRAnimalsRare4",
                        t"DynamicSpawnSystem.GRAnimalsRare5",
                        t"DynamicSpawnSystem.GRAnimalsRare6",
                        t"DynamicSpawnSystem.GRAnimalsRare7",
                        t"DynamicSpawnSystem.GRAnimalsRare8",
                        t"DynamicSpawnSystem.GRAnimalsRare9"
                    ], 1);
            
                return ArrayMerge(rareBike, ArrayMerge(eliteBike, eliteSquad)); 
            case 19: // 4 rares, 4 elite
                return GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRAnimalsRareRareEliteElite1",
                        t"DynamicSpawnSystem.GRAnimalsRareRareEliteElite2",
                        t"DynamicSpawnSystem.GRAnimalsRareRareEliteElite3"
                    ], 2);
            case 20: // 4 rares, 5 elite
                let eliteSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRAnimalsRareRareEliteElite1",
                        t"DynamicSpawnSystem.GRAnimalsRareRareEliteElite2",
                        t"DynamicSpawnSystem.GRAnimalsRareRareEliteElite3"
                    ], 2);
                let eliteBike = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRAnimalsElite1",
                        t"DynamicSpawnSystem.GRAnimalsElite2",
                        t"DynamicSpawnSystem.GRAnimalsElite3",
                        t"DynamicSpawnSystem.GRAnimalsElite4"
                    ], 1);
                return  ArrayMerge(eliteBike, eliteSquad);
            default: 
                return [];
        }
    }
}