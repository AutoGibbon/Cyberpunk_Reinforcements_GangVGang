module Gibbon.GR.GangData




public class GRMaelstormData extends GRGangData {
    public func GetReinforcements(heat: Int32) -> array<TweakDBID> { 
        switch (heat) {
            case 1: // 1 weak
                let weakBike = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMaelStormWeakBike1",
                        t"DynamicSpawnSystem.GRMaelStormWeakBike2"
                    ], 1);
                return weakBike;
            case 2:  // 1 weak, 1 normal     
                let weakNormalCar = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMaelStormWeakNormalCar1",
                        t"DynamicSpawnSystem.GRMaelStormWeakNormalCar2",
                        t"DynamicSpawnSystem.GRMaelStormWeakNormalCar3",
                        t"DynamicSpawnSystem.GRMaelStormWeakNormalCar4",
                        t"DynamicSpawnSystem.GRMaelStormWeakNormalCar5",
                        t"DynamicSpawnSystem.GRMaelStormWeakNormalCar6",
                        t"DynamicSpawnSystem.GRMaelStormWeakNormalCar7",
                        t"DynamicSpawnSystem.GRMaelStormWeakNormalCar8"
                    ], 1);

                return weakNormalCar;
            case 3: // 2 weak, 1 normal
                let weakNormalCar = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMaelStormWeakNormalCar1",
                        t"DynamicSpawnSystem.GRMaelStormWeakNormalCar2",
                        t"DynamicSpawnSystem.GRMaelStormWeakNormalCar3",
                        t"DynamicSpawnSystem.GRMaelStormWeakNormalCar4",
                        t"DynamicSpawnSystem.GRMaelStormWeakNormalCar5",
                        t"DynamicSpawnSystem.GRMaelStormWeakNormalCar6",
                        t"DynamicSpawnSystem.GRMaelStormWeakNormalCar7",
                        t"DynamicSpawnSystem.GRMaelStormWeakNormalCar8"
                    ], 1);
                let weakBike = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMaelStormWeakBike1",
                        t"DynamicSpawnSystem.GRMaelStormWeakBike2"
                    ], 1);   

                return ArrayMerge(weakNormalCar, weakBike);
            case 4: // 2 weak, 2 normal
                return GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMaelStormWeakNormalCar1",
                        t"DynamicSpawnSystem.GRMaelStormWeakNormalCar2",
                        t"DynamicSpawnSystem.GRMaelStormWeakNormalCar3",
                        t"DynamicSpawnSystem.GRMaelStormWeakNormalCar4",
                        t"DynamicSpawnSystem.GRMaelStormWeakNormalCar5",
                        t"DynamicSpawnSystem.GRMaelStormWeakNormalCar6",
                        t"DynamicSpawnSystem.GRMaelStormWeakNormalCar7",
                        t"DynamicSpawnSystem.GRMaelStormWeakNormalCar8"
                    ], 2);          
            case 5:  // 3 normal, 1 rare
                return GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar1",
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar2",
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar3",
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar4"
                    ], 1);   
            case 6:  // 1 weak, 3 normal, 1 rare
                let squad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar1",
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar2",
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar3",
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar4"
                    ], 1); 

                let weakBike = GetRandomFrom(
                [
                    t"DynamicSpawnSystem.GRMaelStormWeakBike1",
                    t"DynamicSpawnSystem.GRMaelStormWeakBike2"
                ], 1);                 
                return ArrayMerge(squad, weakBike);
            case 7:  // 3 weak, 3 normal, 1 rare
                let squad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar1",
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar2",
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar3",
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar4"
                    ], 1); 

                let weakBike = GetRandomFrom(
                [
                    t"DynamicSpawnSystem.GRMaelStormWeakBike1",
                    t"DynamicSpawnSystem.GRMaelStormWeakBike2"
                ], 3);                 
                return ArrayMerge(squad, weakBike);
            case 8: // 2 weak, 4 normals, 1 rare       
                let squad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar1",
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar2",
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar3",
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar4"
                    ], 1); 

                let weakBike = GetRandomFrom(
                [
                    t"DynamicSpawnSystem.GRMaelStormWeakBike1",
                    t"DynamicSpawnSystem.GRMaelStormWeakBike2"
                ], 3);   
                let weakNormalCar = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMaelStormWeakNormalCar1",
                        t"DynamicSpawnSystem.GRMaelStormWeakNormalCar2",
                        t"DynamicSpawnSystem.GRMaelStormWeakNormalCar3",
                        t"DynamicSpawnSystem.GRMaelStormWeakNormalCar4",
                        t"DynamicSpawnSystem.GRMaelStormWeakNormalCar5",
                        t"DynamicSpawnSystem.GRMaelStormWeakNormalCar6",
                        t"DynamicSpawnSystem.GRMaelStormWeakNormalCar7",
                        t"DynamicSpawnSystem.GRMaelStormWeakNormalCar8"
                    ], 1);
                return ArrayMerge(ArrayMerge(squad, weakBike), weakNormalCar);
            case 9:  // 6 normals, 2 rare    
                return GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar1",
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar2",
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar3",
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar4"
                    ], 2);    
            case 10: // 2 elite
                return [t"DynamicSpawnSystem.GRMaelStormEliteBike1", t"DynamicSpawnSystem.GRMaelStormEliteBike1"];
            case 11: // 5 normals 3 rares, 1 elite
                let rrnnSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMaelStormRareRareNormalNormalCar1",
                        t"DynamicSpawnSystem.GRMaelStormRareRareNormalNormalCar2",
                        t"DynamicSpawnSystem.GRMaelStormRareRareNormalNormalCar3",
                        t"DynamicSpawnSystem.GRMaelStormRareRareNormalNormalCar4"
                    ], 1); 
                let elite = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar1",
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar2",
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar3",
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar4"
                    ], 1);  

                let squad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar1",
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar2",
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar3",
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar4"
                    ], 1); 

                return ArrayMerge(ArrayMerge(squad, elite), rrnnSquad);      
            case 12: // 1 weak, 5 normals, 3 rares, 1 elite
                let rrnnSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMaelStormRareRareNormalNormalCar1",
                        t"DynamicSpawnSystem.GRMaelStormRareRareNormalNormalCar2",
                        t"DynamicSpawnSystem.GRMaelStormRareRareNormalNormalCar3",
                        t"DynamicSpawnSystem.GRMaelStormRareRareNormalNormalCar4"
                    ], 1); 
                let elite = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar1",
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar2",
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar3",
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar4"
                    ], 1);  

                let squad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar1",
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar2",
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar3",
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar4"
                    ], 1); 

                let weakNormalCar = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMaelStormWeakNormalCar1",
                        t"DynamicSpawnSystem.GRMaelStormWeakNormalCar2",
                        t"DynamicSpawnSystem.GRMaelStormWeakNormalCar3",
                        t"DynamicSpawnSystem.GRMaelStormWeakNormalCar4",
                        t"DynamicSpawnSystem.GRMaelStormWeakNormalCar5",
                        t"DynamicSpawnSystem.GRMaelStormWeakNormalCar6",
                        t"DynamicSpawnSystem.GRMaelStormWeakNormalCar7",
                        t"DynamicSpawnSystem.GRMaelStormWeakNormalCar8"
                    ], 1);

                return ArrayMerge(weakNormalCar, ArrayMerge(ArrayMerge(squad, elite), rrnnSquad));                  
            case 13: // 7 normals, 5 rares, 1 elite
                let rrnnSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMaelStormRareRareNormalNormalCar1",
                        t"DynamicSpawnSystem.GRMaelStormRareRareNormalNormalCar2",
                        t"DynamicSpawnSystem.GRMaelStormRareRareNormalNormalCar3",
                        t"DynamicSpawnSystem.GRMaelStormRareRareNormalNormalCar4"
                    ], 2); 
                let elite = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar1",
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar2",
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar3",
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar4"
                    ], 1);  

                let squad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar1",
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar2",
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar3",
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar4"
                    ], 1); 

                return ArrayMerge(ArrayMerge(squad, elite), rrnnSquad);      
            case 14: // 6 normals, 6 rares, 1 elite
                let rrnnSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMaelStormRareRareNormalNormalCar1",
                        t"DynamicSpawnSystem.GRMaelStormRareRareNormalNormalCar2",
                        t"DynamicSpawnSystem.GRMaelStormRareRareNormalNormalCar3",
                        t"DynamicSpawnSystem.GRMaelStormRareRareNormalNormalCar4"
                    ], 3); 
                let elite = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar1",
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar2",
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar3",
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar4"
                    ], 1);  

                return ArrayMerge(rrnnSquad, elite);     
            case 15: // 4 normals, 4 rares, 2 elite
                let rrnnSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMaelStormRareRareNormalNormalCar1",
                        t"DynamicSpawnSystem.GRMaelStormRareRareNormalNormalCar2",
                        t"DynamicSpawnSystem.GRMaelStormRareRareNormalNormalCar3",
                        t"DynamicSpawnSystem.GRMaelStormRareRareNormalNormalCar4"
                    ], 2); 
                let elite = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar1",
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar2",
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar3",
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar4"
                    ], 2);  

                return ArrayMerge(rrnnSquad, elite);   
            case 16: // 7 normals 5 rares, 2 elite
                let squad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar1",
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar2",
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar3",
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar4"
                    ], 1); 
        
                let rrnnSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMaelStormRareRareNormalNormalCar1",
                        t"DynamicSpawnSystem.GRMaelStormRareRareNormalNormalCar2",
                        t"DynamicSpawnSystem.GRMaelStormRareRareNormalNormalCar3",
                        t"DynamicSpawnSystem.GRMaelStormRareRareNormalNormalCar4"
                    ], 2); 
                let elite = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar1",
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar2",
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar3",
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar4"
                    ], 2);  

                return ArrayMerge(ArrayMerge(rrnnSquad, elite), squad);  
            case 17: // 6 normals, 6 rares, 2 elite
                let rrnnSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMaelStormRareRareNormalNormalCar1",
                        t"DynamicSpawnSystem.GRMaelStormRareRareNormalNormalCar2",
                        t"DynamicSpawnSystem.GRMaelStormRareRareNormalNormalCar3",
                        t"DynamicSpawnSystem.GRMaelStormRareRareNormalNormalCar4"
                    ], 3); 
                let elite = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar1",
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar2",
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar3",
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar4"
                    ], 2);  

                return ArrayMerge(rrnnSquad, elite);   
            case 18: // 2 normals, 6 rares, 2 elite
                let rrnnSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMaelStormRareRareNormalNormalCar1",
                        t"DynamicSpawnSystem.GRMaelStormRareRareNormalNormalCar2",
                        t"DynamicSpawnSystem.GRMaelStormRareRareNormalNormalCar3",
                        t"DynamicSpawnSystem.GRMaelStormRareRareNormalNormalCar4"
                    ], 1); 

                let rares = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMaelStormFullHouse1",
                        t"DynamicSpawnSystem.GRMaelStormFullHouse2"
                    ], 1); 

                let elite = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar1",
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar2",
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar3",
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar4"
                    ], 2);  
            
                return ArrayMerge(ArrayMerge(rrnnSquad, elite), rares);
            case 19: // 8 rares, 2 elite
                let rares = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMaelStormFullHouse1",
                        t"DynamicSpawnSystem.GRMaelStormFullHouse2"
                    ], 2); 

                let elite = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar1",
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar2",
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar3",
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar4"
                    ], 2);  
            
                return ArrayMerge(rares, elite);
            case 20: // 8 rares, 3 elite
                let rares = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMaelStormFullHouse1",
                        t"DynamicSpawnSystem.GRMaelStormFullHouse2"
                    ], 2); 

                let elite = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar1",
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar2",
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar3",
                        t"DynamicSpawnSystem.GRMaelStormRareNormalCar4"
                    ], 3);  
            
                return ArrayMerge(rares, elite);
            default: 
                return [];
        }
    }
}