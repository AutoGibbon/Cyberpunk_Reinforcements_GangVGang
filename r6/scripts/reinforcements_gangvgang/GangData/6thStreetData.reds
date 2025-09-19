module Gibbon.GR.GangData

public class GRSixthStreetData extends GRGangData {
    public func GetReinforcements(heat: Int32) -> array<TweakDBID> { 
        switch (heat) {
            case 1: // 1 weak - (biker)
                return [t"DynamicSpawnSystem.GRSixthWeakBike1"];
            case 2:  // 1 weak, 1 normal (patrol car 1w/1n)
                let patrolCar = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRSixthPatrol1",
                        t"DynamicSpawnSystem.GRSixthPatrol2",
                        t"DynamicSpawnSystem.GRSixthPatrol3",
                        t"DynamicSpawnSystem.GRSixthPatrol4",
                        t"DynamicSpawnSystem.GRSixthPatrol5"
                    ], 1);
                return patrolCar;
            case 3: // 2 weak, 1 normal (biker + patrol)
                let patrolCar = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRSixthPatrol1",
                        t"DynamicSpawnSystem.GRSixthPatrol2",
                        t"DynamicSpawnSystem.GRSixthPatrol3",
                        t"DynamicSpawnSystem.GRSixthPatrol4",
                        t"DynamicSpawnSystem.GRSixthPatrol5"
                    ], 1);
                let biker = [t"DynamicSpawnSystem.GRSixthWeakBike1"];

                return ArrayMerge(patrolCar, biker);
            case 4: // 2 weak, 2 normal (2 patrols)
                return GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRSixthPatrol1",
                        t"DynamicSpawnSystem.GRSixthPatrol2",
                        t"DynamicSpawnSystem.GRSixthPatrol3",
                        t"DynamicSpawnSystem.GRSixthPatrol4",
                        t"DynamicSpawnSystem.GRSixthPatrol5"
                    ], 2);           
            case 5:  // 3 normal, 1 rare (standard squad)
                let standardSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRSixthStandardSquad1 ",
                        t"DynamicSpawnSystem.GRSixthStandardSquad2",
                        t"DynamicSpawnSystem.GRSixthStandardSquad3",
                        t"DynamicSpawnSystem.GRSixthStandardSquad4"
                    ], 1);

                return standardSquad;
            case 6:  // 1 weak, 3 normal, 1 rare (standdard squad + bike)
               let standardSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRSixthStandardSquad1 ",
                        t"DynamicSpawnSystem.GRSixthStandardSquad2",
                        t"DynamicSpawnSystem.GRSixthStandardSquad3",
                        t"DynamicSpawnSystem.GRSixthStandardSquad4"
                    ], 1);    
                let biker = [t"DynamicSpawnSystem.GRSixthWeakBike1"];  

                return ArrayMerge(biker, standardSquad);
            case 7:  // 1 weak, 4 normal, 1 rare (standard squad + patrol car)
                let standardSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRSixthStandardSquad1 ",
                        t"DynamicSpawnSystem.GRSixthStandardSquad2",
                        t"DynamicSpawnSystem.GRSixthStandardSquad3",
                        t"DynamicSpawnSystem.GRSixthStandardSquad4"
                    ], 1);    
                let patrolCar = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRSixthPatrol1",
                        t"DynamicSpawnSystem.GRSixthPatrol2",
                        t"DynamicSpawnSystem.GRSixthPatrol3",
                        t"DynamicSpawnSystem.GRSixthPatrol4",
                        t"DynamicSpawnSystem.GRSixthPatrol5"
                    ], 1); 

                return ArrayMerge(patrolCar, standardSquad);
            case 8: // 2 weak, 3 normals, 2 rare (rrnn, patrol car, bike)       
                let rrnn = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRSixthRareSquad1",
                        t"DynamicSpawnSystem.GRSixthRareSquad2",
                        t"DynamicSpawnSystem.GRSixthRareSquad3",
                        t"DynamicSpawnSystem.GRSixthRareSquad4"
                    ], 1);   
                let patrolCar = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRSixthPatrol1",
                        t"DynamicSpawnSystem.GRSixthPatrol2",
                        t"DynamicSpawnSystem.GRSixthPatrol3",
                        t"DynamicSpawnSystem.GRSixthPatrol4",
                        t"DynamicSpawnSystem.GRSixthPatrol5"
                    ], 1); 
                let biker = [t"DynamicSpawnSystem.GRSixthWeakBike1"];

                return ArrayMerge(ArrayMerge(patrolCar, rrnn), biker);
            case 9:  //  2 weak, 4 normals, 2 rare     (rrnn, 2x patrol car)    
                let rrnn = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRSixthRareSquad1",
                        t"DynamicSpawnSystem.GRSixthRareSquad2",
                        t"DynamicSpawnSystem.GRSixthRareSquad3",
                        t"DynamicSpawnSystem.GRSixthRareSquad4"
                    ], 1);   
                let patrolCar = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRSixthPatrol1",
                        t"DynamicSpawnSystem.GRSixthPatrol2",
                        t"DynamicSpawnSystem.GRSixthPatrol3",
                        t"DynamicSpawnSystem.GRSixthPatrol4",
                        t"DynamicSpawnSystem.GRSixthPatrol5"
                    ], 2); 

                return ArrayMerge(patrolCar, rrnn);  
            case 10: // 1 weak, 2 normals, 2 rares, 1 elite (errn + patrol car)
                let errn = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRSixthEliteSquad1",
                        t"DynamicSpawnSystem.GRSixthEliteSquad2",
                        t"DynamicSpawnSystem.GRSixthEliteSquad3",
                        t"DynamicSpawnSystem.GRSixthEliteSquad4"
                    ], 1);   
                let patrolCar = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRSixthPatrol1",
                        t"DynamicSpawnSystem.GRSixthPatrol2",
                        t"DynamicSpawnSystem.GRSixthPatrol3",
                        t"DynamicSpawnSystem.GRSixthPatrol4",
                        t"DynamicSpawnSystem.GRSixthPatrol5"
                    ], 1); 
                return ArrayMerge(errn, patrolCar);
            case 11: // 5 normals 3 rares, 1 elite (errn + standard squad)
                let errn = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRSixthEliteSquad1",
                        t"DynamicSpawnSystem.GRSixthEliteSquad2",
                        t"DynamicSpawnSystem.GRSixthEliteSquad3",
                        t"DynamicSpawnSystem.GRSixthEliteSquad4"
                    ], 1);   
                    let standardSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRSixthStandardSquad1 ",
                        t"DynamicSpawnSystem.GRSixthStandardSquad2",
                        t"DynamicSpawnSystem.GRSixthStandardSquad3",
                        t"DynamicSpawnSystem.GRSixthStandardSquad4"
                    ], 1);               
                return ArrayMerge(errn, standardSquad);       
            case 12: // 1 weak, 5 normals, 4 rares, 1 elite (errn + standard squad + bike)
                let errn = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRSixthEliteSquad1",
                        t"DynamicSpawnSystem.GRSixthEliteSquad2",
                        t"DynamicSpawnSystem.GRSixthEliteSquad3",
                        t"DynamicSpawnSystem.GRSixthEliteSquad4"
                    ], 1);   
                    let standardSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRSixthStandardSquad1 ",
                        t"DynamicSpawnSystem.GRSixthStandardSquad2",
                        t"DynamicSpawnSystem.GRSixthStandardSquad3",
                        t"DynamicSpawnSystem.GRSixthStandardSquad4"
                    ], 1);               
                let bike = [t"DynamicSpawnSystem.GRSixthWeakBike1"];

                return ArrayMerge(ArrayMerge(errn, standardSquad), bike);                 
            case 13: // 6 normals, 4 rares, 1 elite (errn + 2 standard squads)
                let errn = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRSixthEliteSquad1",
                        t"DynamicSpawnSystem.GRSixthEliteSquad2",
                        t"DynamicSpawnSystem.GRSixthEliteSquad3",
                        t"DynamicSpawnSystem.GRSixthEliteSquad4"
                    ], 1);   
                    let standardSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRSixthStandardSquad1 ",
                        t"DynamicSpawnSystem.GRSixthStandardSquad2",
                        t"DynamicSpawnSystem.GRSixthStandardSquad3",
                        t"DynamicSpawnSystem.GRSixthStandardSquad4"
                    ], 2);               
                return ArrayMerge(errn, standardSquad);   
            case 14: // 2weak, 6 normals, 4 rares, 1 elite (errn + 2 standard squads + bike)
                let errn = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRSixthEliteSquad1",
                        t"DynamicSpawnSystem.GRSixthEliteSquad2",
                        t"DynamicSpawnSystem.GRSixthEliteSquad3",
                        t"DynamicSpawnSystem.GRSixthEliteSquad4"
                    ], 1);   
                    let standardSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRSixthStandardSquad1 ",
                        t"DynamicSpawnSystem.GRSixthStandardSquad2",
                        t"DynamicSpawnSystem.GRSixthStandardSquad3",
                        t"DynamicSpawnSystem.GRSixthStandardSquad4"
                    ], 2);               
                let bike = [t"DynamicSpawnSystem.GRSixthWeakBike1", t"DynamicSpawnSystem.GRSixthWeakBike1"];

                return ArrayMerge(ArrayMerge(errn, standardSquad), bike);   
            case 15: // 6 normals, 4 rares, 2 elite (2 errn + standard quad)
                   let errn = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRSixthEliteSquad1",
                        t"DynamicSpawnSystem.GRSixthEliteSquad2",
                        t"DynamicSpawnSystem.GRSixthEliteSquad3",
                        t"DynamicSpawnSystem.GRSixthEliteSquad4"
                    ], 2);   
                    let standardSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRSixthStandardSquad1 ",
                        t"DynamicSpawnSystem.GRSixthStandardSquad2",
                        t"DynamicSpawnSystem.GRSixthStandardSquad3",
                        t"DynamicSpawnSystem.GRSixthStandardSquad4"
                    ], 1);               
                return ArrayMerge(errn, standardSquad);   
            case 16: // 5 normals 5 rares, 2 elite (2 errn + standard quad + bike)
                let errn = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRSixthEliteSquad1",
                        t"DynamicSpawnSystem.GRSixthEliteSquad2",
                        t"DynamicSpawnSystem.GRSixthEliteSquad3",
                        t"DynamicSpawnSystem.GRSixthEliteSquad4"
                    ], 2);   

                    let standardSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRSixthStandardSquad1 ",
                        t"DynamicSpawnSystem.GRSixthStandardSquad2",
                        t"DynamicSpawnSystem.GRSixthStandardSquad3",
                        t"DynamicSpawnSystem.GRSixthStandardSquad4"
                    ], 1);               
                let bike = [t"DynamicSpawnSystem.GRSixthWeakBike1"];

                return ArrayMerge(ArrayMerge(errn, standardSquad), bike);   
            case 17: // 2 normals, 6 rares, 2 elite (2 errn + standard quad + patrol)
                let errn = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRSixthEliteSquad1",
                        t"DynamicSpawnSystem.GRSixthEliteSquad2",
                        t"DynamicSpawnSystem.GRSixthEliteSquad3",
                        t"DynamicSpawnSystem.GRSixthEliteSquad4"
                    ], 2);   
                    
                    let standardSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRSixthStandardSquad1 ",
                        t"DynamicSpawnSystem.GRSixthStandardSquad2",
                        t"DynamicSpawnSystem.GRSixthStandardSquad3",
                        t"DynamicSpawnSystem.GRSixthStandardSquad4"
                    ], 1);               
                let patrolCar = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRSixthPatrol1",
                        t"DynamicSpawnSystem.GRSixthPatrol2",
                        t"DynamicSpawnSystem.GRSixthPatrol3",
                        t"DynamicSpawnSystem.GRSixthPatrol4",
                        t"DynamicSpawnSystem.GRSixthPatrol5"
                    ], 1); 
                return ArrayMerge(ArrayMerge(errn, standardSquad), patrolCar);   
            case 18: // 6 normals, 6 rares, 2 elite (2 errn + 2standard quad )
                   let errn = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRSixthEliteSquad1",
                        t"DynamicSpawnSystem.GRSixthEliteSquad2",
                        t"DynamicSpawnSystem.GRSixthEliteSquad3",
                        t"DynamicSpawnSystem.GRSixthEliteSquad4"
                    ], 2);   
                    let standardSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRSixthStandardSquad1 ",
                        t"DynamicSpawnSystem.GRSixthStandardSquad2",
                        t"DynamicSpawnSystem.GRSixthStandardSquad3",
                        t"DynamicSpawnSystem.GRSixthStandardSquad4"
                    ], 2);               
                return ArrayMerge(errn, standardSquad);   
            case 19: // 8 rares, 2 elite + (2 errn + 2standard quad  + bike)
                let errn = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRSixthEliteSquad1",
                        t"DynamicSpawnSystem.GRSixthEliteSquad2",
                        t"DynamicSpawnSystem.GRSixthEliteSquad3",
                        t"DynamicSpawnSystem.GRSixthEliteSquad4"
                    ], 2);   

                    let standardSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRSixthStandardSquad1 ",
                        t"DynamicSpawnSystem.GRSixthStandardSquad2",
                        t"DynamicSpawnSystem.GRSixthStandardSquad3",
                        t"DynamicSpawnSystem.GRSixthStandardSquad4"
                    ], 2);               
                let bike = [t"DynamicSpawnSystem.GRSixthWeakBike1"];

                return ArrayMerge(ArrayMerge(errn, standardSquad), bike);   
            case 20: // 3 normals 7 rares, 3 elite (3 errn + standard)
                   let errn = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRSixthEliteSquad1",
                        t"DynamicSpawnSystem.GRSixthEliteSquad2",
                        t"DynamicSpawnSystem.GRSixthEliteSquad3",
                        t"DynamicSpawnSystem.GRSixthEliteSquad4"
                    ], 3);   
                    let standardSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRSixthStandardSquad1 ",
                        t"DynamicSpawnSystem.GRSixthStandardSquad2",
                        t"DynamicSpawnSystem.GRSixthStandardSquad3",
                        t"DynamicSpawnSystem.GRSixthStandardSquad4"
                    ], 1);               
                return ArrayMerge(errn, standardSquad);   
            default: 
                return [];
        }
    }
}