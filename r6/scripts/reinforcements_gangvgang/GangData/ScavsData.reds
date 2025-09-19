module Gibbon.GR.GangData




public class GRScavData extends GRGangData {
    public func GetReinforcements(heat: Int32) -> array<TweakDBID> { 
        switch (heat) {
            case 1: // 2 weak
                let weakCar = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRScavCarNormalTrash1",
                        t"DynamicSpawnSystem.GRScavCarNormalTrash2",
                        t"DynamicSpawnSystem.GRScavCarNormalTrash3"
                    ], 1);
                return weakCar;
            case 2:  // 4 weak             
                let weakCar = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRScavCarNormalTrash1",
                        t"DynamicSpawnSystem.GRScavCarNormalTrash2",
                        t"DynamicSpawnSystem.GRScavCarNormalTrash3"
                    ], 2);
                return weakCar;
            case 3: // 5 weak
                let weakCar = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRScavCarNormalTrash1",
                        t"DynamicSpawnSystem.GRScavCarNormalTrash2",
                        t"DynamicSpawnSystem.GRScavCarNormalTrash3"
                    ], 2);

                let weakBike = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRScavBikeRangeNormal1",
                        t"DynamicSpawnSystem.GRScavBikeRangeNormal2"
                    ], 1);
                return ArrayMerge(weakCar, weakBike);
            case 4: // 5 weak, 1 normal
                let weakCar = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRScavCarNormalTrash1",
                        t"DynamicSpawnSystem.GRScavCarNormalTrash2",
                        t"DynamicSpawnSystem.GRScavCarNormalTrash3"
                    ], 2);

                let weakBike = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRScavBikeRangeNormal1",
                        t"DynamicSpawnSystem.GRScavBikeRangeNormal2"
                    ], 1);

                let normalBike = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRScavBikeNormal1",
                        t"DynamicSpawnSystem.GRScavBikeNormal2",
                        t"DynamicSpawnSystem.GRScavBikeNormal3",
                        t"DynamicSpawnSystem.GRScavBikeNormal4",
                        t"DynamicSpawnSystem.GRScavBikeNormal5",
                        t"DynamicSpawnSystem.GRScavBikeNormal6",
                        t"DynamicSpawnSystem.GRScavBikeNormal7",
                        t"DynamicSpawnSystem.GRScavBikeNormal8",
                        t"DynamicSpawnSystem.GRScavBikeNormal9",
                        t"DynamicSpawnSystem.GRScavBikeNormal10",
                        t"DynamicSpawnSystem.GRScavBikeNormal11"
                    ], 1);

                return ArrayMerge(ArrayMerge(weakCar, weakBike), normalBike);
            case 5:  // 5 weak, 2 normal
                let weakSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRScavCarWeakSquad1",
                        t"DynamicSpawnSystem.GRScavCarWeakSquad2",
                        t"DynamicSpawnSystem.GRScavCarWeakSquad3"
                    ], 1);
                
                let weakBike = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRScavBikeRangeNormal1",
                        t"DynamicSpawnSystem.GRScavBikeRangeNormal2"
                    ], 1);

                let normalCar = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRScavCarNormalNormal1",
                        t"DynamicSpawnSystem.GRScavCarNormalNormal2",
                        t"DynamicSpawnSystem.GRScavCarNormalNormal3",
                        t"DynamicSpawnSystem.GRScavCarNormalNormal4",
                        t"DynamicSpawnSystem.GRScavCarNormalNormal5",
                        t"DynamicSpawnSystem.GRScavCarNormalNormal6"
                    ], 2);
            
                return ArrayMerge(ArrayMerge(normalCar, weakBike), weakSquad);
            case 6:  // 6 weak, 2 normal
                let weakSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRScavCarWeakSquad1",
                        t"DynamicSpawnSystem.GRScavCarWeakSquad2",
                        t"DynamicSpawnSystem.GRScavCarWeakSquad3"
                    ], 1);
                
                let weakCar = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRScavCarNormalTrash1",
                        t"DynamicSpawnSystem.GRScavCarNormalTrash2",
                        t"DynamicSpawnSystem.GRScavCarNormalTrash3"
                    ], 1);

                let normalCar = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRScavCarNormalNormal1",
                        t"DynamicSpawnSystem.GRScavCarNormalNormal2",
                        t"DynamicSpawnSystem.GRScavCarNormalNormal3",
                        t"DynamicSpawnSystem.GRScavCarNormalNormal4",
                        t"DynamicSpawnSystem.GRScavCarNormalNormal5",
                        t"DynamicSpawnSystem.GRScavCarNormalNormal6"
                    ], 2);
            
                return ArrayMerge(ArrayMerge(normalCar, weakCar), weakSquad);
            case 7:  // 6 weak, 3 normal
                let weakSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRScavCarWeakSquad1",
                        t"DynamicSpawnSystem.GRScavCarWeakSquad2",
                        t"DynamicSpawnSystem.GRScavCarWeakSquad3"
                    ], 1);
                
                let weakCar = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRScavCarNormalTrash1",
                        t"DynamicSpawnSystem.GRScavCarNormalTrash2",
                        t"DynamicSpawnSystem.GRScavCarNormalTrash3"
                    ], 1);

                let normalCar = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRScavCarNormalNormal1",
                        t"DynamicSpawnSystem.GRScavCarNormalNormal2",
                        t"DynamicSpawnSystem.GRScavCarNormalNormal3",
                        t"DynamicSpawnSystem.GRScavCarNormalNormal4",
                        t"DynamicSpawnSystem.GRScavCarNormalNormal5",
                        t"DynamicSpawnSystem.GRScavCarNormalNormal6"
                    ], 2);
            
                let normalBike = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRScavBikeNormal1",
                        t"DynamicSpawnSystem.GRScavBikeNormal2",
                        t"DynamicSpawnSystem.GRScavBikeNormal3",
                        t"DynamicSpawnSystem.GRScavBikeNormal4",
                        t"DynamicSpawnSystem.GRScavBikeNormal5",
                        t"DynamicSpawnSystem.GRScavBikeNormal6",
                        t"DynamicSpawnSystem.GRScavBikeNormal7",
                        t"DynamicSpawnSystem.GRScavBikeNormal8",
                        t"DynamicSpawnSystem.GRScavBikeNormal9",
                        t"DynamicSpawnSystem.GRScavBikeNormal10",
                        t"DynamicSpawnSystem.GRScavBikeNormal11"
                    ], 1);

                return ArrayMerge(ArrayMerge(ArrayMerge(normalCar, weakCar), weakSquad), normalBike);
            case 8: // 7 weap, 3 normal          
                let weakSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRScavCarWeakSquad1",
                        t"DynamicSpawnSystem.GRScavCarWeakSquad2",
                        t"DynamicSpawnSystem.GRScavCarWeakSquad3"
                    ], 1);
                
                let weakCar = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRScavCarNormalTrash1",
                        t"DynamicSpawnSystem.GRScavCarNormalTrash2",
                        t"DynamicSpawnSystem.GRScavCarNormalTrash3"
                    ], 1);

                let normalCar = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRScavCarNormalNormal1",
                        t"DynamicSpawnSystem.GRScavCarNormalNormal2",
                        t"DynamicSpawnSystem.GRScavCarNormalNormal3",
                        t"DynamicSpawnSystem.GRScavCarNormalNormal4",
                        t"DynamicSpawnSystem.GRScavCarNormalNormal5",
                        t"DynamicSpawnSystem.GRScavCarNormalNormal6"
                    ], 2);
            
                let normalBike = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRScavBikeNormal1",
                        t"DynamicSpawnSystem.GRScavBikeNormal2",
                        t"DynamicSpawnSystem.GRScavBikeNormal3",
                        t"DynamicSpawnSystem.GRScavBikeNormal4",
                        t"DynamicSpawnSystem.GRScavBikeNormal5",
                        t"DynamicSpawnSystem.GRScavBikeNormal6",
                        t"DynamicSpawnSystem.GRScavBikeNormal7",
                        t"DynamicSpawnSystem.GRScavBikeNormal8",
                        t"DynamicSpawnSystem.GRScavBikeNormal9",
                        t"DynamicSpawnSystem.GRScavBikeNormal10",
                        t"DynamicSpawnSystem.GRScavBikeNormal11"
                    ], 1);

                let weakBike = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRScavBikeRangeNormal1",
                        t"DynamicSpawnSystem.GRScavBikeRangeNormal2"
                    ], 1);

                return ArrayMerge(ArrayMerge(ArrayMerge(ArrayMerge(normalCar, weakCar), weakSquad), normalBike), weakBike);
            case 9:  //  8 weak, 4 normal
                let weakSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRScavCarWeakSquad1",
                        t"DynamicSpawnSystem.GRScavCarWeakSquad2",
                        t"DynamicSpawnSystem.GRScavCarWeakSquad3"
                    ], 2);

                let normalSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRScavCarNormalSquad1",
                        t"DynamicSpawnSystem.GRScavCarNormalSquad2",
                        t"DynamicSpawnSystem.GRScavCarNormalSquad3",
                        t"DynamicSpawnSystem.GRScavCarNormalSquad4"
                    ], 1);
                return ArrayMerge(weakSquad, normalSquad);      
            case 10: // 8 weak, 3 normal, 1 rare
                let weakSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRScavCarWeakSquad1",
                        t"DynamicSpawnSystem.GRScavCarWeakSquad2",
                        t"DynamicSpawnSystem.GRScavCarWeakSquad3"
                    ], 2);

                let rareSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRScavCarNormalRareSquad1",
                        t"DynamicSpawnSystem.GRScavCarNormalRareSquad2",
                        t"DynamicSpawnSystem.GRScavCarNormalRareSquad3",
                        t"DynamicSpawnSystem.GRScavCarNormalRareSquad4"
                    ], 1);

                return ArrayMerge(weakSquad, rareSquad);  
            case 11: // 8 weak, 4 noromal, 1 rare
                let weakSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRScavCarWeakSquad1",
                        t"DynamicSpawnSystem.GRScavCarWeakSquad2",
                        t"DynamicSpawnSystem.GRScavCarWeakSquad3"
                    ], 2);

                let rareSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRScavCarNormalRareSquad1",
                        t"DynamicSpawnSystem.GRScavCarNormalRareSquad2",
                        t"DynamicSpawnSystem.GRScavCarNormalRareSquad3",
                        t"DynamicSpawnSystem.GRScavCarNormalRareSquad4"
                    ], 1);

                let normalBike = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRScavBikeNormal1",
                        t"DynamicSpawnSystem.GRScavBikeNormal2",
                        t"DynamicSpawnSystem.GRScavBikeNormal3",
                        t"DynamicSpawnSystem.GRScavBikeNormal4",
                        t"DynamicSpawnSystem.GRScavBikeNormal5",
                        t"DynamicSpawnSystem.GRScavBikeNormal6",
                        t"DynamicSpawnSystem.GRScavBikeNormal7",
                        t"DynamicSpawnSystem.GRScavBikeNormal8",
                        t"DynamicSpawnSystem.GRScavBikeNormal9",
                        t"DynamicSpawnSystem.GRScavBikeNormal10",
                        t"DynamicSpawnSystem.GRScavBikeNormal11"
                    ], 1);

                return ArrayMerge(normalBike, ArrayMerge(weakSquad, rareSquad));      
            case 12: // 8 weak, 6 normal, 1 rare
                let weakSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRScavCarWeakSquad1",
                        t"DynamicSpawnSystem.GRScavCarWeakSquad2",
                        t"DynamicSpawnSystem.GRScavCarWeakSquad3"
                    ], 2);

                let rareSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRScavCarNormalRareSquad1",
                        t"DynamicSpawnSystem.GRScavCarNormalRareSquad2",
                        t"DynamicSpawnSystem.GRScavCarNormalRareSquad3",
                        t"DynamicSpawnSystem.GRScavCarNormalRareSquad4"
                    ], 2);

                let normalBike = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRScavBikeNormal1",
                        t"DynamicSpawnSystem.GRScavBikeNormal2",
                        t"DynamicSpawnSystem.GRScavBikeNormal3",
                        t"DynamicSpawnSystem.GRScavBikeNormal4",
                        t"DynamicSpawnSystem.GRScavBikeNormal5",
                        t"DynamicSpawnSystem.GRScavBikeNormal6",
                        t"DynamicSpawnSystem.GRScavBikeNormal7",
                        t"DynamicSpawnSystem.GRScavBikeNormal8",
                        t"DynamicSpawnSystem.GRScavBikeNormal9",
                        t"DynamicSpawnSystem.GRScavBikeNormal10",
                        t"DynamicSpawnSystem.GRScavBikeNormal11"
                    ], 1);

                return ArrayMerge(normalBike, ArrayMerge(weakSquad, rareSquad));                
            case 13: // 8 weak, 7 normal, 2 rare
                let weakSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRScavCarWeakSquad1",
                        t"DynamicSpawnSystem.GRScavCarWeakSquad2",
                        t"DynamicSpawnSystem.GRScavCarWeakSquad3"
                    ], 2);

                let rareSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRScavCarNormalRareSquad1",
                        t"DynamicSpawnSystem.GRScavCarNormalRareSquad2",
                        t"DynamicSpawnSystem.GRScavCarNormalRareSquad3",
                        t"DynamicSpawnSystem.GRScavCarNormalRareSquad4"
                    ], 2);

                let normalBike = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRScavBikeNormal1",
                        t"DynamicSpawnSystem.GRScavBikeNormal2",
                        t"DynamicSpawnSystem.GRScavBikeNormal3",
                        t"DynamicSpawnSystem.GRScavBikeNormal4",
                        t"DynamicSpawnSystem.GRScavBikeNormal5",
                        t"DynamicSpawnSystem.GRScavBikeNormal6",
                        t"DynamicSpawnSystem.GRScavBikeNormal7",
                        t"DynamicSpawnSystem.GRScavBikeNormal8",
                        t"DynamicSpawnSystem.GRScavBikeNormal9",
                        t"DynamicSpawnSystem.GRScavBikeNormal10",
                        t"DynamicSpawnSystem.GRScavBikeNormal11"
                    ], 1);

                return ArrayMerge(normalBike, ArrayMerge(weakSquad, rareSquad));     
            case 14: // 8 weak, 8 normal, 2 rare
                let weakSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRScavCarWeakSquad1",
                        t"DynamicSpawnSystem.GRScavCarWeakSquad2",
                        t"DynamicSpawnSystem.GRScavCarWeakSquad3"
                    ], 2);

                let rareSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRScavCarNormalRareSquad1",
                        t"DynamicSpawnSystem.GRScavCarNormalRareSquad2",
                        t"DynamicSpawnSystem.GRScavCarNormalRareSquad3",
                        t"DynamicSpawnSystem.GRScavCarNormalRareSquad4"
                    ], 2);

                let normalBike = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRScavBikeNormal1",
                        t"DynamicSpawnSystem.GRScavBikeNormal2",
                        t"DynamicSpawnSystem.GRScavBikeNormal3",
                        t"DynamicSpawnSystem.GRScavBikeNormal4",
                        t"DynamicSpawnSystem.GRScavBikeNormal5",
                        t"DynamicSpawnSystem.GRScavBikeNormal6",
                        t"DynamicSpawnSystem.GRScavBikeNormal7",
                        t"DynamicSpawnSystem.GRScavBikeNormal8",
                        t"DynamicSpawnSystem.GRScavBikeNormal9",
                        t"DynamicSpawnSystem.GRScavBikeNormal10",
                        t"DynamicSpawnSystem.GRScavBikeNormal11"
                    ], 2);

                return ArrayMerge(normalBike, ArrayMerge(weakSquad, rareSquad));     
            case 15: // 12 weak, 9 normal, 3 rare
                let weakSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRScavCarWeakSquad1",
                        t"DynamicSpawnSystem.GRScavCarWeakSquad2",
                        t"DynamicSpawnSystem.GRScavCarWeakSquad3"
                    ], 3);

                let rareSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRScavCarNormalRareSquad1",
                        t"DynamicSpawnSystem.GRScavCarNormalRareSquad2",
                        t"DynamicSpawnSystem.GRScavCarNormalRareSquad3",
                        t"DynamicSpawnSystem.GRScavCarNormalRareSquad4"
                    ], 3);

                return ArrayMerge(weakSquad, rareSquad);     
            case 16: // 8 weak,  10 normal, 3 rare
                let weakSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRScavCarWeakSquad1",
                        t"DynamicSpawnSystem.GRScavCarWeakSquad2",
                        t"DynamicSpawnSystem.GRScavCarWeakSquad3"
                    ], 2);

                let rareSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRScavCarNormalRareSquad1",
                        t"DynamicSpawnSystem.GRScavCarNormalRareSquad2",
                        t"DynamicSpawnSystem.GRScavCarNormalRareSquad3",
                        t"DynamicSpawnSystem.GRScavCarNormalRareSquad4"
                    ], 3);

                let normalBike = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRScavBikeNormal1",
                        t"DynamicSpawnSystem.GRScavBikeNormal2",
                        t"DynamicSpawnSystem.GRScavBikeNormal3",
                        t"DynamicSpawnSystem.GRScavBikeNormal4",
                        t"DynamicSpawnSystem.GRScavBikeNormal5",
                        t"DynamicSpawnSystem.GRScavBikeNormal6",
                        t"DynamicSpawnSystem.GRScavBikeNormal7",
                        t"DynamicSpawnSystem.GRScavBikeNormal8",
                        t"DynamicSpawnSystem.GRScavBikeNormal9",
                        t"DynamicSpawnSystem.GRScavBikeNormal10",
                        t"DynamicSpawnSystem.GRScavBikeNormal11"
                    ], 1);

                return ArrayMerge(normalBike, ArrayMerge(weakSquad, rareSquad));     
            case 17: // 4 weak, 12 normal, 4 rare
                let weakSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRScavCarWeakSquad1",
                        t"DynamicSpawnSystem.GRScavCarWeakSquad2",
                        t"DynamicSpawnSystem.GRScavCarWeakSquad3"
                    ], 1);

                let rareSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRScavCarNormalRareSquad1",
                        t"DynamicSpawnSystem.GRScavCarNormalRareSquad2",
                        t"DynamicSpawnSystem.GRScavCarNormalRareSquad3",
                        t"DynamicSpawnSystem.GRScavCarNormalRareSquad4"
                    ], 4);

                return ArrayMerge(weakSquad, rareSquad);     
            case 18: // 14 normal, 4 rare
                let rareSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRScavCarNormalRareSquad1",
                        t"DynamicSpawnSystem.GRScavCarNormalRareSquad2",
                        t"DynamicSpawnSystem.GRScavCarNormalRareSquad3",
                        t"DynamicSpawnSystem.GRScavCarNormalRareSquad4"
                    ], 4);
                let normalBike = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRScavBikeNormal1",
                        t"DynamicSpawnSystem.GRScavBikeNormal2",
                        t"DynamicSpawnSystem.GRScavBikeNormal3",
                        t"DynamicSpawnSystem.GRScavBikeNormal4",
                        t"DynamicSpawnSystem.GRScavBikeNormal5",
                        t"DynamicSpawnSystem.GRScavBikeNormal6",
                        t"DynamicSpawnSystem.GRScavBikeNormal7",
                        t"DynamicSpawnSystem.GRScavBikeNormal8",
                        t"DynamicSpawnSystem.GRScavBikeNormal9",
                        t"DynamicSpawnSystem.GRScavBikeNormal10",
                        t"DynamicSpawnSystem.GRScavBikeNormal11"
                    ], 2);
                return ArrayMerge(normalBike, rareSquad);   
            case 19: // 16 normal, 4 rare
                let normalSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRScavCarNormalSquad1",
                        t"DynamicSpawnSystem.GRScavCarNormalSquad2",
                        t"DynamicSpawnSystem.GRScavCarNormalSquad3",
                        t"DynamicSpawnSystem.GRScavCarNormalSquad4"
                    ], 1);

                let rareSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRScavCarNormalRareSquad1",
                        t"DynamicSpawnSystem.GRScavCarNormalRareSquad2",
                        t"DynamicSpawnSystem.GRScavCarNormalRareSquad3",
                        t"DynamicSpawnSystem.GRScavCarNormalRareSquad4"
                    ], 4);
                return ArrayMerge(rareSquad, normalSquad);
            case 20: // 15 normals, 5 rare
                return GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRScavCarNormalRareSquad1",
                        t"DynamicSpawnSystem.GRScavCarNormalRareSquad2",
                        t"DynamicSpawnSystem.GRScavCarNormalRareSquad3",
                        t"DynamicSpawnSystem.GRScavCarNormalRareSquad4"
                    ], 5);
            default: 
                return [];
        }
    }
}

public class TestReinforcementData extends GRGangData {
    public func GetReinforcements(heat: Int32) -> array<TweakDBID> { 
        switch (heat) {
            case 1: // 1 weak
                return [];
            case 2:  // 1 weak, 1 normal                
                return [];
            case 3: // 2 weak, 1 normal
                return [];
            case 4: // 2 weak, 2 normal
                return [];           
            case 5:  // 2 weak, 2 normal, 1 rare
                return [];
            case 6:  // 3 weak, 2 normal, 1 rare
                return [];
            case 7:  // 3 weak, 3 normal, 1 rare
                return [];
            case 8: // 2 weak, 3 normals, 2 rare            
                return [];
            case 9:  //  1 weak, 4 normals, 2 rare    
                return [];      
            case 10: // 4 normals, 2 rares, 1 elite
                return [];
            case 11: // 5 normals 3 rares, 1 elite
                return [];       
            case 12: // 6 normals, 4 rares, 1 elite
                return [];               
            case 13: // 7 normals, 4 rares, 1 elite
                return [];
            case 14: // 8 normals, 4 rares, 1 elite
                return [];
            case 15: // 6 normals, 4 rares, 2 elite
                return [];
            case 16: // 5 normals 5 rares, 2 elite
                return [];
            case 17: // 2 normals, 6 rares, 2 elite
                return [];
            case 18: // 7 rares, 2 elite
                return [];  
            case 19: // 8 rares, 2 elite
                return [];
            case 20: // 8 rares, 3 elite
                return [];
            default: 
                return [];
        }
    }
}