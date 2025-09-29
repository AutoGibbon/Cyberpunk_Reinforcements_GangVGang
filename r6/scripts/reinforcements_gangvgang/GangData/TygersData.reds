module Gibbon.GR.GangData


public class GRTygerData extends GRGangData {public func GetReinforcements(heat: Int32) -> array<TweakDBID> { 
        switch (heat) {
            case 1: // 1 weak
                let weakBike = GetRandomFrom(
                    [
                     t"DynamicSpawnSystem.GRTygerBikeRangedWeak1",
                     t"DynamicSpawnSystem.GRTygerBikeRangedWeak2"
                    ], 1);    
                return weakBike;
            case 2:  // 1 weak, 1 normal
                let weakBike = GetRandomFrom(
                    [
                     t"DynamicSpawnSystem.GRTygerBikeMeleeWeak1",
                     t"DynamicSpawnSystem.GRTygerBikeRangedWeak1",
                     t"DynamicSpawnSystem.GRTygerBikeRangedWeak2"
                    ], 1);    

                let normalBike = GetRandomFrom(
                    [
                     t"DynamicSpawnSystem.GRTygerBikeMeleeNormal1",
                     t"DynamicSpawnSystem.GRTygerBikeRangedNormal1",
                     t"DynamicSpawnSystem.GRTygerBikeRangedNormal2",
                     t"DynamicSpawnSystem.GRTygerBikeRangedNormal4",
                     t"DynamicSpawnSystem.GRTygerBikeRangedNormal5"
                    ], 1);                       
                return ArrayMerge(weakBike, normalBike);
            case 3: // 2 weak, 1 normal
                let weakBike = GetRandomFrom(
                    [
                     t"DynamicSpawnSystem.GRTygerBikeMeleeWeak1",
                     t"DynamicSpawnSystem.GRTygerBikeRangedWeak1",
                     t"DynamicSpawnSystem.GRTygerBikeRangedWeak2"
                    ], 1);  

                let weakNormalCar = GetRandomFrom(
                    [
                     t"DynamicSpawnSystem.GRTygerCarWeakNormal1",
                     t"DynamicSpawnSystem.GRTygerCarWeakNormal2",
                     t"DynamicSpawnSystem.GRTygerCarWeakNormal3",
                     t"DynamicSpawnSystem.GRTygerCarWeakNormal4",
                     t"DynamicSpawnSystem.GRTygerCarWeakNormal5"
                    ], 1);  

                return ArrayMerge(weakNormalCar, weakBike);
            case 4: // 2 weak, 2 normal
                return GetRandomFrom(
                    [
                     t"DynamicSpawnSystem.GRTygerCarWeakNormal1",
                     t"DynamicSpawnSystem.GRTygerCarWeakNormal2",
                     t"DynamicSpawnSystem.GRTygerCarWeakNormal3",
                     t"DynamicSpawnSystem.GRTygerCarWeakNormal4",
                     t"DynamicSpawnSystem.GRTygerCarWeakNormal5"
                    ], 2);            
            case 5:  // 2 weak, 2 normal, 1 rare
                let rareBike = GetRandomFrom(
                    [
                     t"DynamicSpawnSystem.GRTygerBikeRare1",
                     t"DynamicSpawnSystem.GRTygerBikeRare2",
                     t"DynamicSpawnSystem.GRTygerBikeRare3",
                     t"DynamicSpawnSystem.GRTygerBikeRare4",
                     t"DynamicSpawnSystem.GRTygerBikeRare5",
                     t"DynamicSpawnSystem.GRTygerBikeRare6"
                    ], 1);  

                let weakNormalCar = GetRandomFrom(
                    [
                     t"DynamicSpawnSystem.GRTygerCarWeakNormal1",
                     t"DynamicSpawnSystem.GRTygerCarWeakNormal2",
                     t"DynamicSpawnSystem.GRTygerCarWeakNormal3",
                     t"DynamicSpawnSystem.GRTygerCarWeakNormal4",
                     t"DynamicSpawnSystem.GRTygerCarWeakNormal5"
                    ], 2);  

                return ArrayMerge(weakNormalCar, rareBike);
            case 6:  // 3 weak, 2 normal, 1 rare
                let weakBike = GetRandomFrom(
                    [
                     t"DynamicSpawnSystem.GRTygerBikeMeleeWeak1",
                     t"DynamicSpawnSystem.GRTygerBikeRangedWeak1",
                     t"DynamicSpawnSystem.GRTygerBikeRangedWeak2"
                    ], 1);  

                let rareBike = GetRandomFrom(
                    [
                     t"DynamicSpawnSystem.GRTygerBikeRare1",
                     t"DynamicSpawnSystem.GRTygerBikeRare2",
                     t"DynamicSpawnSystem.GRTygerBikeRare3",
                     t"DynamicSpawnSystem.GRTygerBikeRare4",
                     t"DynamicSpawnSystem.GRTygerBikeRare5",
                     t"DynamicSpawnSystem.GRTygerBikeRare6"
                    ], 1);  

                let weakNormalCar = GetRandomFrom(
                    [
                     t"DynamicSpawnSystem.GRTygerCarWeakNormal1",
                     t"DynamicSpawnSystem.GRTygerCarWeakNormal2",
                     t"DynamicSpawnSystem.GRTygerCarWeakNormal3",
                     t"DynamicSpawnSystem.GRTygerCarWeakNormal4",
                     t"DynamicSpawnSystem.GRTygerCarWeakNormal5"
                    ], 2);  

                return ArrayMerge(ArrayMerge(weakNormalCar, rareBike), weakBike);
            case 7:  // 3 weak, 3 normal, 1 rare
                let normalBike = GetRandomFrom(
                    [
                     t"DynamicSpawnSystem.GRTygerBikeMeleeNormal1",
                     t"DynamicSpawnSystem.GRTygerBikeRangedNormal1",
                     t"DynamicSpawnSystem.GRTygerBikeRangedNormal2",
                     t"DynamicSpawnSystem.GRTygerBikeRangedNormal4",
                     t"DynamicSpawnSystem.GRTygerBikeRangedNormal5"
                    ], 1);    

                let weakBike = GetRandomFrom(
                    [
                     t"DynamicSpawnSystem.GRTygerBikeMeleeWeak1",
                     t"DynamicSpawnSystem.GRTygerBikeRangedWeak1",
                     t"DynamicSpawnSystem.GRTygerBikeRangedWeak2"
                    ], 1);  

                let rareBike = GetRandomFrom(
                    [
                     t"DynamicSpawnSystem.GRTygerBikeRare1",
                     t"DynamicSpawnSystem.GRTygerBikeRare2",
                     t"DynamicSpawnSystem.GRTygerBikeRare3",
                     t"DynamicSpawnSystem.GRTygerBikeRare4",
                     t"DynamicSpawnSystem.GRTygerBikeRare5",
                     t"DynamicSpawnSystem.GRTygerBikeRare6"
                    ], 1);  

                let weakNormalCar = GetRandomFrom(
                    [
                     t"DynamicSpawnSystem.GRTygerCarWeakNormal1",
                     t"DynamicSpawnSystem.GRTygerCarWeakNormal2",
                     t"DynamicSpawnSystem.GRTygerCarWeakNormal3",
                     t"DynamicSpawnSystem.GRTygerCarWeakNormal4",
                     t"DynamicSpawnSystem.GRTygerCarWeakNormal5"
                    ], 2);  

                return ArrayMerge(ArrayMerge(ArrayMerge(weakNormalCar, rareBike), weakBike), normalBike);
            case 8: // 2 weak, 3 normals, 2 rare        
                let rareNormalCar = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRTygerCarNormalRare1",
                        t"DynamicSpawnSystem.GRTygerCarNormalRare2",
                        t"DynamicSpawnSystem.GRTygerCarNormalRare3",
                        t"DynamicSpawnSystem.GRTygerCarNormalRare4",
                        t"DynamicSpawnSystem.GRTygerCarNormalRare5",
                        t"DynamicSpawnSystem.GRTygerCarNormalRare6",
                        t"DynamicSpawnSystem.GRTygerCarNormalRare7",
                        t"DynamicSpawnSystem.GRTygerCarNormalRare8"
                    ], 1);

                let weakNormalCar = GetRandomFrom(
                    [
                     t"DynamicSpawnSystem.GRTygerCarWeakNormal1",
                     t"DynamicSpawnSystem.GRTygerCarWeakNormal2",
                     t"DynamicSpawnSystem.GRTygerCarWeakNormal3",
                     t"DynamicSpawnSystem.GRTygerCarWeakNormal4",
                     t"DynamicSpawnSystem.GRTygerCarWeakNormal5"
                    ], 2);   

                let rareBike = GetRandomFrom(
                    [
                     t"DynamicSpawnSystem.GRTygerBikeRare1",
                     t"DynamicSpawnSystem.GRTygerBikeRare2",
                     t"DynamicSpawnSystem.GRTygerBikeRare3",
                     t"DynamicSpawnSystem.GRTygerBikeRare4",
                     t"DynamicSpawnSystem.GRTygerBikeRare5",
                     t"DynamicSpawnSystem.GRTygerBikeRare6"
                    ], 1); 

                return ArrayMerge(ArrayMerge(weakNormalCar, rareBike), rareNormalCar);
            case 9:  //  2 weak, 4 normals, 2 rare    
                let rareNormalCar = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRTygerCarNormalRare1",
                        t"DynamicSpawnSystem.GRTygerCarNormalRare2",
                        t"DynamicSpawnSystem.GRTygerCarNormalRare3",
                        t"DynamicSpawnSystem.GRTygerCarNormalRare4",
                        t"DynamicSpawnSystem.GRTygerCarNormalRare5",
                        t"DynamicSpawnSystem.GRTygerCarNormalRare6",
                        t"DynamicSpawnSystem.GRTygerCarNormalRare7",
                        t"DynamicSpawnSystem.GRTygerCarNormalRare8"
                    ], 2);

                let weakNormalCar = GetRandomFrom(
                    [
                     t"DynamicSpawnSystem.GRTygerCarWeakNormal1",
                     t"DynamicSpawnSystem.GRTygerCarWeakNormal2",
                     t"DynamicSpawnSystem.GRTygerCarWeakNormal3",
                     t"DynamicSpawnSystem.GRTygerCarWeakNormal4",
                     t"DynamicSpawnSystem.GRTygerCarWeakNormal5"
                    ], 2);  

                return ArrayMerge(weakNormalCar, rareNormalCar);   
            case 10: // 1 weak, 3 normals, 2 rares, 1 elite
                let rareNormalSquad = GetRandomFrom(
                    [
                     t"DynamicSpawnSystem.GRTygerCarRareWeakNormalNormal1",
                     t"DynamicSpawnSystem.GRTygerCarRareWeakNormalNormal2",
                     t"DynamicSpawnSystem.GRTygerCarRareWeakNormalNormal3",
                     t"DynamicSpawnSystem.GRTygerCarRareWeakNormalNormal4",
                     t"DynamicSpawnSystem.GRTygerCarRareWeakNormalNormal5",
                     t"DynamicSpawnSystem.GRTygerCarRareWeakNormalNormal6"
                    ], 1);  

                let eliteRareCar = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRTygerCarEliteRare1",
                        t"DynamicSpawnSystem.GRTygerCarEliteRare2",
                        t"DynamicSpawnSystem.GRTygerCarEliteRare3",
                        t"DynamicSpawnSystem.GRTygerCarEliteRare4",
                        t"DynamicSpawnSystem.GRTygerCarEliteRare5",
                        t"DynamicSpawnSystem.GRTygerCarEliteRare6"
                    ], 1
                );

                let normalBike = GetRandomFrom(
                    [
                     t"DynamicSpawnSystem.GRTygerBikeMeleeNormal1",
                     t"DynamicSpawnSystem.GRTygerBikeRangedNormal1",
                     t"DynamicSpawnSystem.GRTygerBikeRangedNormal2",
                     t"DynamicSpawnSystem.GRTygerBikeRangedNormal4",
                     t"DynamicSpawnSystem.GRTygerBikeRangedNormal5"
                    ], 1);  

                return ArrayMerge(ArrayMerge(rareNormalSquad, eliteRareCar), normalBike); 
            case 11: // 5 normals 3 rares, 1 elite
            
                let eliteRareCar = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRTygerCarEliteRare1",
                        t"DynamicSpawnSystem.GRTygerCarEliteRare2",
                        t"DynamicSpawnSystem.GRTygerCarEliteRare3",
                        t"DynamicSpawnSystem.GRTygerCarEliteRare4",
                        t"DynamicSpawnSystem.GRTygerCarEliteRare5",
                        t"DynamicSpawnSystem.GRTygerCarEliteRare6"
                    ], 1
                );

                let normalBike = GetRandomFrom(
                    [
                     t"DynamicSpawnSystem.GRTygerBikeMeleeNormal1",
                     t"DynamicSpawnSystem.GRTygerBikeRangedNormal1",
                     t"DynamicSpawnSystem.GRTygerBikeRangedNormal2",
                     t"DynamicSpawnSystem.GRTygerBikeRangedNormal4",
                     t"DynamicSpawnSystem.GRTygerBikeRangedNormal5"
                    ], 3);  

                let rareNormalCar = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRTygerCarNormalRare1",
                        t"DynamicSpawnSystem.GRTygerCarNormalRare2",
                        t"DynamicSpawnSystem.GRTygerCarNormalRare3",
                        t"DynamicSpawnSystem.GRTygerCarNormalRare4",
                        t"DynamicSpawnSystem.GRTygerCarNormalRare5",
                        t"DynamicSpawnSystem.GRTygerCarNormalRare6",
                        t"DynamicSpawnSystem.GRTygerCarNormalRare7",
                        t"DynamicSpawnSystem.GRTygerCarNormalRare8"
                    ], 2);
                return ArrayMerge(ArrayMerge(rareNormalCar, eliteRareCar), normalBike);       
            case 12: // 3 weak, 6 normals, 4 rares, 1 elite
                let rareNormalSquad = GetRandomFrom(
                    [
                     t"DynamicSpawnSystem.GRTygerCarRareWeakNormalNormal1",
                     t"DynamicSpawnSystem.GRTygerCarRareWeakNormalNormal2",
                     t"DynamicSpawnSystem.GRTygerCarRareWeakNormalNormal3",
                     t"DynamicSpawnSystem.GRTygerCarRareWeakNormalNormal4",
                     t"DynamicSpawnSystem.GRTygerCarRareWeakNormalNormal5",
                     t"DynamicSpawnSystem.GRTygerCarRareWeakNormalNormal6"
                    ], 3);  

                let eliteRareCar = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRTygerCarEliteRare1",
                        t"DynamicSpawnSystem.GRTygerCarEliteRare2",
                        t"DynamicSpawnSystem.GRTygerCarEliteRare3",
                        t"DynamicSpawnSystem.GRTygerCarEliteRare4",
                        t"DynamicSpawnSystem.GRTygerCarEliteRare5",
                        t"DynamicSpawnSystem.GRTygerCarEliteRare6"
                    ], 1
                );
                return ArrayMerge(eliteRareCar, rareNormalSquad);               
            case 13: // 3 weak, 7 normals, 4 rares, 1 elite
                let normalBike = GetRandomFrom(
                    [
                     t"DynamicSpawnSystem.GRTygerBikeMeleeNormal1",
                     t"DynamicSpawnSystem.GRTygerBikeRangedNormal1",
                     t"DynamicSpawnSystem.GRTygerBikeRangedNormal2",
                     t"DynamicSpawnSystem.GRTygerBikeRangedNormal4",
                     t"DynamicSpawnSystem.GRTygerBikeRangedNormal5"
                    ], 1);  

                let rareNormalSquad = GetRandomFrom(
                    [
                     t"DynamicSpawnSystem.GRTygerCarRareWeakNormalNormal1",
                     t"DynamicSpawnSystem.GRTygerCarRareWeakNormalNormal2",
                     t"DynamicSpawnSystem.GRTygerCarRareWeakNormalNormal3",
                     t"DynamicSpawnSystem.GRTygerCarRareWeakNormalNormal4",
                     t"DynamicSpawnSystem.GRTygerCarRareWeakNormalNormal5",
                     t"DynamicSpawnSystem.GRTygerCarRareWeakNormalNormal6"
                    ], 3);  

                let eliteRareCar = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRTygerCarEliteRare1",
                        t"DynamicSpawnSystem.GRTygerCarEliteRare2",
                        t"DynamicSpawnSystem.GRTygerCarEliteRare3",
                        t"DynamicSpawnSystem.GRTygerCarEliteRare4",
                        t"DynamicSpawnSystem.GRTygerCarEliteRare5",
                        t"DynamicSpawnSystem.GRTygerCarEliteRare6"
                    ], 1
                );
                return ArrayMerge(ArrayMerge(eliteRareCar, rareNormalSquad), normalBike);   
            case 14: // 3 weaks ,8 normals, 4 rares, 1 elite
                let normalBike = GetRandomFrom(
                    [
                     t"DynamicSpawnSystem.GRTygerBikeMeleeNormal1",
                     t"DynamicSpawnSystem.GRTygerBikeRangedNormal1",
                     t"DynamicSpawnSystem.GRTygerBikeRangedNormal2",
                     t"DynamicSpawnSystem.GRTygerBikeRangedNormal4",
                     t"DynamicSpawnSystem.GRTygerBikeRangedNormal5"
                    ], 2);  

                let rareNormalSquad = GetRandomFrom(
                    [
                     t"DynamicSpawnSystem.GRTygerCarRareWeakNormalNormal1",
                     t"DynamicSpawnSystem.GRTygerCarRareWeakNormalNormal2",
                     t"DynamicSpawnSystem.GRTygerCarRareWeakNormalNormal3",
                     t"DynamicSpawnSystem.GRTygerCarRareWeakNormalNormal4",
                     t"DynamicSpawnSystem.GRTygerCarRareWeakNormalNormal5",
                     t"DynamicSpawnSystem.GRTygerCarRareWeakNormalNormal6"
                    ], 3);  

                let eliteRareCar = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRTygerCarEliteRare1",
                        t"DynamicSpawnSystem.GRTygerCarEliteRare2",
                        t"DynamicSpawnSystem.GRTygerCarEliteRare3",
                        t"DynamicSpawnSystem.GRTygerCarEliteRare4",
                        t"DynamicSpawnSystem.GRTygerCarEliteRare5",
                        t"DynamicSpawnSystem.GRTygerCarEliteRare6"
                    ], 1);
                return ArrayMerge(ArrayMerge(eliteRareCar, rareNormalSquad), normalBike);   
            case 15: // 6 normals, 4 rares, 2 elite
                let normalBike = GetRandomFrom(
                    [
                     t"DynamicSpawnSystem.GRTygerBikeMeleeNormal1",
                     t"DynamicSpawnSystem.GRTygerBikeRangedNormal1",
                     t"DynamicSpawnSystem.GRTygerBikeRangedNormal2",
                     t"DynamicSpawnSystem.GRTygerBikeRangedNormal4",
                     t"DynamicSpawnSystem.GRTygerBikeRangedNormal5"
                    ], 2);  

                let rareNormalCar = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRTygerCarNormalRare1",
                        t"DynamicSpawnSystem.GRTygerCarNormalRare2",
                        t"DynamicSpawnSystem.GRTygerCarNormalRare3",
                        t"DynamicSpawnSystem.GRTygerCarNormalRare4",
                        t"DynamicSpawnSystem.GRTygerCarNormalRare5",
                        t"DynamicSpawnSystem.GRTygerCarNormalRare6",
                        t"DynamicSpawnSystem.GRTygerCarNormalRare7",
                        t"DynamicSpawnSystem.GRTygerCarNormalRare8"
                    ], 2);

                let eliteRareCar = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRTygerCarEliteRare1",
                        t"DynamicSpawnSystem.GRTygerCarEliteRare2",
                        t"DynamicSpawnSystem.GRTygerCarEliteRare3",
                        t"DynamicSpawnSystem.GRTygerCarEliteRare4",
                        t"DynamicSpawnSystem.GRTygerCarEliteRare5",
                        t"DynamicSpawnSystem.GRTygerCarEliteRare6"
                    ], 2);
                return ArrayMerge(ArrayMerge(eliteRareCar, rareNormalCar), normalBike);   
            case 16: // 5 normals 5 rares, 2 elite
                let normalBike = GetRandomFrom(
                    [
                     t"DynamicSpawnSystem.GRTygerBikeMeleeNormal1",
                     t"DynamicSpawnSystem.GRTygerBikeRangedNormal1",
                     t"DynamicSpawnSystem.GRTygerBikeRangedNormal2",
                     t"DynamicSpawnSystem.GRTygerBikeRangedNormal4",
                     t"DynamicSpawnSystem.GRTygerBikeRangedNormal5"
                    ], 2);  

                let rareNormalCar = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRTygerCarNormalRare1",
                        t"DynamicSpawnSystem.GRTygerCarNormalRare2",
                        t"DynamicSpawnSystem.GRTygerCarNormalRare3",
                        t"DynamicSpawnSystem.GRTygerCarNormalRare4",
                        t"DynamicSpawnSystem.GRTygerCarNormalRare5",
                        t"DynamicSpawnSystem.GRTygerCarNormalRare6",
                        t"DynamicSpawnSystem.GRTygerCarNormalRare7",
                        t"DynamicSpawnSystem.GRTygerCarNormalRare8"
                    ], 2);

                let rareBike = GetRandomFrom(
                    [
                     t"DynamicSpawnSystem.GRTygerBikeMeleeRare1",
                     t"DynamicSpawnSystem.GRTygerBikeMeleeRare2", 
                     t"DynamicSpawnSystem.GRTygerBikeRangedRare1", 
                     t"DynamicSpawnSystem.GRTygerBikeRangedRare2",
                     t"DynamicSpawnSystem.GRTygerBikeRangedRare3"
                    ], 1);  

                let eliteRareCar = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRTygerCarEliteRare1",
                        t"DynamicSpawnSystem.GRTygerCarEliteRare2",
                        t"DynamicSpawnSystem.GRTygerCarEliteRare3",
                        t"DynamicSpawnSystem.GRTygerCarEliteRare4",
                        t"DynamicSpawnSystem.GRTygerCarEliteRare5",
                        t"DynamicSpawnSystem.GRTygerCarEliteRare6"
                    ], 2);
                return ArrayMerge(ArrayMerge(ArrayMerge(eliteRareCar, rareNormalCar), normalBike), rareBike);   
            case 17: // 2 normals, 6 rares, 2 elite

                let rareNormalCar = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRTygerCarNormalRare1",
                        t"DynamicSpawnSystem.GRTygerCarNormalRare2",
                        t"DynamicSpawnSystem.GRTygerCarNormalRare3",
                        t"DynamicSpawnSystem.GRTygerCarNormalRare4",
                        t"DynamicSpawnSystem.GRTygerCarNormalRare5",
                        t"DynamicSpawnSystem.GRTygerCarNormalRare6",
                        t"DynamicSpawnSystem.GRTygerCarNormalRare7",
                        t"DynamicSpawnSystem.GRTygerCarNormalRare8"
                    ], 2);

                let rareBike = GetRandomFrom(
                    [
                     t"DynamicSpawnSystem.GRTygerBikeMeleeRare1",
                     t"DynamicSpawnSystem.GRTygerBikeMeleeRare2", 
                     t"DynamicSpawnSystem.GRTygerBikeRangedRare1", 
                     t"DynamicSpawnSystem.GRTygerBikeRangedRare2",
                     t"DynamicSpawnSystem.GRTygerBikeRangedRare3"
                    ], 2);  

                let eliteRareCar = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRTygerCarEliteRare1",
                        t"DynamicSpawnSystem.GRTygerCarEliteRare2",
                        t"DynamicSpawnSystem.GRTygerCarEliteRare3",
                        t"DynamicSpawnSystem.GRTygerCarEliteRare4",
                        t"DynamicSpawnSystem.GRTygerCarEliteRare5",
                        t"DynamicSpawnSystem.GRTygerCarEliteRare6"
                    ], 2);
                return ArrayMerge(ArrayMerge(eliteRareCar, rareNormalCar), rareBike); 
            case 18: // 1 normal, 7 rares, 2 elite
                let rareSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRTygerCarRareRareRareNormal1",
                        t"DynamicSpawnSystem.GRTygerCarRareRareRareNormal2",
                        t"DynamicSpawnSystem.GRTygerCarRareRareRareNormal3"
                    ], 1);

                let rareBike = GetRandomFrom(
                    [
                     t"DynamicSpawnSystem.GRTygerBikeMeleeRare1",
                     t"DynamicSpawnSystem.GRTygerBikeMeleeRare2", 
                     t"DynamicSpawnSystem.GRTygerBikeRangedRare1", 
                     t"DynamicSpawnSystem.GRTygerBikeRangedRare2",
                     t"DynamicSpawnSystem.GRTygerBikeRangedRare3"
                    ], 2);  

                let eliteRareCar = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRTygerCarEliteRare1",
                        t"DynamicSpawnSystem.GRTygerCarEliteRare2",
                        t"DynamicSpawnSystem.GRTygerCarEliteRare3",
                        t"DynamicSpawnSystem.GRTygerCarEliteRare4",
                        t"DynamicSpawnSystem.GRTygerCarEliteRare5",
                        t"DynamicSpawnSystem.GRTygerCarEliteRare6"
                    ], 2);

                return ArrayMerge(ArrayMerge(eliteRareCar, rareSquad), rareBike); 
            case 19: // 1 normal, 8 rares, 2 elite
                let rareSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRTygerCarRareRareRareNormal1",
                        t"DynamicSpawnSystem.GRTygerCarRareRareRareNormal2",
                        t"DynamicSpawnSystem.GRTygerCarRareRareRareNormal3"
                    ], 1);

                let rareBike = GetRandomFrom(
                    [
                     t"DynamicSpawnSystem.GRTygerBikeMeleeRare1",
                     t"DynamicSpawnSystem.GRTygerBikeMeleeRare2", 
                     t"DynamicSpawnSystem.GRTygerBikeRangedRare1", 
                     t"DynamicSpawnSystem.GRTygerBikeRangedRare2",
                     t"DynamicSpawnSystem.GRTygerBikeRangedRare3"
                    ], 3);  

                let eliteRareCar = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRTygerCarEliteRare1",
                        t"DynamicSpawnSystem.GRTygerCarEliteRare2",
                        t"DynamicSpawnSystem.GRTygerCarEliteRare3",
                        t"DynamicSpawnSystem.GRTygerCarEliteRare4",
                        t"DynamicSpawnSystem.GRTygerCarEliteRare5",
                        t"DynamicSpawnSystem.GRTygerCarEliteRare6"
                    ], 2);

                return ArrayMerge(ArrayMerge(eliteRareCar, rareSquad), rareBike); 
            case 20: // 2 normals, 10 rares, 3 elite
                let rareSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRTygerCarRareRareRareNormal1",
                        t"DynamicSpawnSystem.GRTygerCarRareRareRareNormal2",
                        t"DynamicSpawnSystem.GRTygerCarRareRareRareNormal3"
                    ], 2);

                let rareBike = GetRandomFrom(
                    [
                     t"DynamicSpawnSystem.GRTygerBikeMeleeRare1",
                     t"DynamicSpawnSystem.GRTygerBikeMeleeRare2", 
                     t"DynamicSpawnSystem.GRTygerBikeRangedRare1", 
                     t"DynamicSpawnSystem.GRTygerBikeRangedRare2",
                     t"DynamicSpawnSystem.GRTygerBikeRangedRare3"
                    ], 1);  

                let eliteRareCar = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRTygerCarEliteRare1",
                        t"DynamicSpawnSystem.GRTygerCarEliteRare2",
                        t"DynamicSpawnSystem.GRTygerCarEliteRare3",
                        t"DynamicSpawnSystem.GRTygerCarEliteRare4",
                        t"DynamicSpawnSystem.GRTygerCarEliteRare5",
                        t"DynamicSpawnSystem.GRTygerCarEliteRare6"
                    ], 3);

                return ArrayMerge(ArrayMerge(eliteRareCar, rareSquad), rareBike); 
            default: 
                return [];
        }
    }
}