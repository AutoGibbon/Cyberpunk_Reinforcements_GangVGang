module Gibbon.GR.GangData




public class GRArasakaData extends GRGangData {
	public func GetTrafficSpawns() -> array<TweakDBID> { return [];}

    public func GetReinforcements(heat: Int32) -> array<TweakDBID> { 
        switch (heat) {
            case 1: // empty
                return [t"DynamicSpawnSystem.GRArasakaRangerA"];
            case 2:  // empty       
                return [t"DynamicSpawnSystem.GRArasakaRangerA"];
            case 3: // empty
                return [t"DynamicSpawnSystem.GRArasakaRangerB"];
            case 4: // 4 normal (rangers)
                let rangers = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRArasakaRangersNormal1",
                        t"DynamicSpawnSystem.GRArasakaRangersNormal2"
                    ], 1);
                return rangers;        
            case 5:  // 2 rares (soldier rares)
                let rares = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRArasakaRareRare1",
                        t"DynamicSpawnSystem.GRArasakaRareRare2",
                        t"DynamicSpawnSystem.GRArasakaRareRare3",
                        t"DynamicSpawnSystem.GRArasakaRareRare4"
                    ], 1);
                return rares;     
            case 6:  // 4 normals 2 rares (soldier rares)
                let rangers = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRArasakaRangersNormal1",
                        t"DynamicSpawnSystem.GRArasakaRangersNormal2"
                    ], 1);

                let rares = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRArasakaRareRare1",
                        t"DynamicSpawnSystem.GRArasakaRareRare2",
                        t"DynamicSpawnSystem.GRArasakaRareRare3",
                        t"DynamicSpawnSystem.GRArasakaRareRare4"
                    ], 1);                                
                return ArrayMerge(rangers, rares);
            case 7:  // 4 normals 2 rares (soldier rares)
                let rangers = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRArasakaRangersNormal1",
                        t"DynamicSpawnSystem.GRArasakaRangersNormal2"
                    ], 1);

                let rares = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRArasakaRareRare1",
                        t"DynamicSpawnSystem.GRArasakaRareRare2",
                        t"DynamicSpawnSystem.GRArasakaRareRare3",
                        t"DynamicSpawnSystem.GRArasakaRareRare4"
                    ], 1);                                
                return ArrayMerge(rangers, rares);
            case 8: // 4 rares (snadrad squads)      
                return GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRArasakaStandardSquad1",
                        t"DynamicSpawnSystem.GRArasakaStandardSquad2",
                        t"DynamicSpawnSystem.GRArasakaStandardSquad3",
                        t"DynamicSpawnSystem.GRArasakaStandardSquad4",
                        t"DynamicSpawnSystem.GRArasakaStandardSquad5"
                    ], 1);
            case 9:  //  4 rares (snadrad squads)     
                 return GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRArasakaStandardSquad1",
                        t"DynamicSpawnSystem.GRArasakaStandardSquad2",
                        t"DynamicSpawnSystem.GRArasakaStandardSquad3",
                        t"DynamicSpawnSystem.GRArasakaStandardSquad4",
                        t"DynamicSpawnSystem.GRArasakaStandardSquad5"
                    ], 1);  
            case 10: // 4 rares (standard squads), 1 elite (assassin)
                let standardSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRArasakaStandardSquad1",
                        t"DynamicSpawnSystem.GRArasakaStandardSquad2",
                        t"DynamicSpawnSystem.GRArasakaStandardSquad3",
                        t"DynamicSpawnSystem.GRArasakaStandardSquad4",
                        t"DynamicSpawnSystem.GRArasakaStandardSquad5"
                    ], 1);
                let eliteBike = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRArasakaEliteAssassinBike1",
                        t"DynamicSpawnSystem.GRArasakaEliteAssassinBike2",
                        t"DynamicSpawnSystem.GRArasakaEliteAssassinBike3",
                        t"DynamicSpawnSystem.GRArasakaEliteAssassinBike4",
                        t"DynamicSpawnSystem.GRArasakaEliteAssassinBike5"
                    ], 1);
                return ArrayMerge(standardSquad, eliteBike);
            case 11: // 8 normies (rangers), 4 rare ((specialised)), 1 elite (assassin)
                let rangers = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRArasakaRangersNormal1",
                        t"DynamicSpawnSystem.GRArasakaRangersNormal2"
                    ], 2);
                let eliteBike = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRArasakaEliteAssassinBike1",
                        t"DynamicSpawnSystem.GRArasakaEliteAssassinBike2",
                        t"DynamicSpawnSystem.GRArasakaEliteAssassinBike3",
                        t"DynamicSpawnSystem.GRArasakaEliteAssassinBike4",
                        t"DynamicSpawnSystem.GRArasakaEliteAssassinBike5"
                    ], 1);
                let specialisedSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRArasakaSpecSquad1",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad2",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad3",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad4",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad5",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad6",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad7"
                    ], 1);
                return ArrayMerge(ArrayMerge(rangers, eliteBike), specialisedSquad);   
            case 12: // 8 rares (1 standard squad, 1 specialised), 1 elite (non juggernaut)
                let standardSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRArasakaStandardSquad1",
                        t"DynamicSpawnSystem.GRArasakaStandardSquad2",
                        t"DynamicSpawnSystem.GRArasakaStandardSquad3",
                        t"DynamicSpawnSystem.GRArasakaStandardSquad4",
                        t"DynamicSpawnSystem.GRArasakaStandardSquad5"
                    ], 1);
                let eliteBike = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRArasakaEliteAssassinBike1",
                        t"DynamicSpawnSystem.GRArasakaEliteAssassinBike2",
                        t"DynamicSpawnSystem.GRArasakaEliteAssassinBike3",
                        t"DynamicSpawnSystem.GRArasakaEliteAssassinBike4",
                        t"DynamicSpawnSystem.GRArasakaEliteAssassinBike5"
                    ], 1);
                let specialisedSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRArasakaSpecSquad1",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad2",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad3",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad4",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad5",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad6",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad7"
                    ], 1);
                return ArrayMerge(ArrayMerge(standardSquad, eliteBike), specialisedSquad);             
            case 13: // 8 rares (1 standard squad, 1 specialised), 1 elite (non juggernaut)
                let standardSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRArasakaStandardSquad1",
                        t"DynamicSpawnSystem.GRArasakaStandardSquad2",
                        t"DynamicSpawnSystem.GRArasakaStandardSquad3",
                        t"DynamicSpawnSystem.GRArasakaStandardSquad4",
                        t"DynamicSpawnSystem.GRArasakaStandardSquad5"
                    ], 1);
                let eliteBike = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRArasakaEliteAssassinBike1",
                        t"DynamicSpawnSystem.GRArasakaEliteAssassinBike2",
                        t"DynamicSpawnSystem.GRArasakaEliteAssassinBike3",
                        t"DynamicSpawnSystem.GRArasakaEliteAssassinBike4",
                        t"DynamicSpawnSystem.GRArasakaEliteAssassinBike5"
                    ], 1);
                let specialisedSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRArasakaSpecSquad1",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad2",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad3",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad4",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad5",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad6",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad7"
                    ], 1);
                return ArrayMerge(ArrayMerge(standardSquad, eliteBike), specialisedSquad);     
            case 14: // 8 rares, 2 elite
                let standardSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRArasakaStandardSquad1",
                        t"DynamicSpawnSystem.GRArasakaStandardSquad2",
                        t"DynamicSpawnSystem.GRArasakaStandardSquad3",
                        t"DynamicSpawnSystem.GRArasakaStandardSquad4",
                        t"DynamicSpawnSystem.GRArasakaStandardSquad5"
                    ], 1);
                let heavySquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRHeavyAssault1",
                        t"DynamicSpawnSystem.GRHeavyAssault2",
                        t"DynamicSpawnSystem.GRHeavyAssault3",
                        t"DynamicSpawnSystem.GRHeavyAssault4"
                    ], 1);
                let specialisedSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRArasakaSpecSquad1",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad2",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad3",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad4",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad5",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad6",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad7"
                    ], 1);
                return ArrayMerge(ArrayMerge(standardSquad, heavySquad), specialisedSquad);     
            case 15: // 8 rares 3 elite
                let eliteBike = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRArasakaEliteAssassinBike1",
                        t"DynamicSpawnSystem.GRArasakaEliteAssassinBike2",
                        t"DynamicSpawnSystem.GRArasakaEliteAssassinBike3",
                        t"DynamicSpawnSystem.GRArasakaEliteAssassinBike4",
                        t"DynamicSpawnSystem.GRArasakaEliteAssassinBike5"
                    ], 1);            
                let standardSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRArasakaStandardSquad1",
                        t"DynamicSpawnSystem.GRArasakaStandardSquad2",
                        t"DynamicSpawnSystem.GRArasakaStandardSquad3",
                        t"DynamicSpawnSystem.GRArasakaStandardSquad4",
                        t"DynamicSpawnSystem.GRArasakaStandardSquad5"
                    ], 1);
                let heavySquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRHeavyAssault1",
                        t"DynamicSpawnSystem.GRHeavyAssault2",
                        t"DynamicSpawnSystem.GRHeavyAssault3",
                        t"DynamicSpawnSystem.GRHeavyAssault4"
                    ], 1);
                let specialisedSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRArasakaSpecSquad1",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad2",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad3",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad4",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad5",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad6",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad7"
                    ], 1);
                return ArrayMerge(eliteBike, ArrayMerge(ArrayMerge(standardSquad, heavySquad), specialisedSquad));     
            case 16: // 12 rares, 3 elite
                let eliteBike = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRArasakaEliteAssassinBike1",
                        t"DynamicSpawnSystem.GRArasakaEliteAssassinBike2",
                        t"DynamicSpawnSystem.GRArasakaEliteAssassinBike3",
                        t"DynamicSpawnSystem.GRArasakaEliteAssassinBike4",
                        t"DynamicSpawnSystem.GRArasakaEliteAssassinBike5"
                    ], 1);            
                let standardSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRArasakaStandardSquad1",
                        t"DynamicSpawnSystem.GRArasakaStandardSquad2",
                        t"DynamicSpawnSystem.GRArasakaStandardSquad3",
                        t"DynamicSpawnSystem.GRArasakaStandardSquad4",
                        t"DynamicSpawnSystem.GRArasakaStandardSquad5"
                    ], 2);
                let heavySquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRHeavyAssault1",
                        t"DynamicSpawnSystem.GRHeavyAssault2",
                        t"DynamicSpawnSystem.GRHeavyAssault3",
                        t"DynamicSpawnSystem.GRHeavyAssault4"
                    ], 1);
                let specialisedSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRArasakaSpecSquad1",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad2",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad3",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad4",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad5",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad6",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad7"
                    ], 1);
                return ArrayMerge(eliteBike, ArrayMerge(ArrayMerge(standardSquad, heavySquad), specialisedSquad));    
            case 17: // 12 rares, 4 elite
                let eliteBike = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRArasakaEliteAssassinBike1",
                        t"DynamicSpawnSystem.GRArasakaEliteAssassinBike2",
                        t"DynamicSpawnSystem.GRArasakaEliteAssassinBike3",
                        t"DynamicSpawnSystem.GRArasakaEliteAssassinBike4",
                        t"DynamicSpawnSystem.GRArasakaEliteAssassinBike5"
                    ], 2);            
                let standardSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRArasakaStandardSquad1",
                        t"DynamicSpawnSystem.GRArasakaStandardSquad2",
                        t"DynamicSpawnSystem.GRArasakaStandardSquad3",
                        t"DynamicSpawnSystem.GRArasakaStandardSquad4",
                        t"DynamicSpawnSystem.GRArasakaStandardSquad5"
                    ], 2);
                let heavySquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRHeavyAssault1",
                        t"DynamicSpawnSystem.GRHeavyAssault2",
                        t"DynamicSpawnSystem.GRHeavyAssault3",
                        t"DynamicSpawnSystem.GRHeavyAssault4"
                    ], 1);
                let specialisedSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRArasakaSpecSquad1",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad2",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad3",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad4",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad5",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad6",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad7"
                    ], 1);
                return ArrayMerge(eliteBike, ArrayMerge(ArrayMerge(standardSquad, heavySquad), specialisedSquad));    
            case 18: // 12 rares, 4 elite
                let eliteBike = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRArasakaEliteAssassinBike1",
                        t"DynamicSpawnSystem.GRArasakaEliteAssassinBike2",
                        t"DynamicSpawnSystem.GRArasakaEliteAssassinBike3",
                        t"DynamicSpawnSystem.GRArasakaEliteAssassinBike4",
                        t"DynamicSpawnSystem.GRArasakaEliteAssassinBike5"
                    ], 2);            
                let standardSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRArasakaStandardSquad1",
                        t"DynamicSpawnSystem.GRArasakaStandardSquad2",
                        t"DynamicSpawnSystem.GRArasakaStandardSquad3",
                        t"DynamicSpawnSystem.GRArasakaStandardSquad4",
                        t"DynamicSpawnSystem.GRArasakaStandardSquad5"
                    ], 1);
                let heavySquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRHeavyAssault1",
                        t"DynamicSpawnSystem.GRHeavyAssault2",
                        t"DynamicSpawnSystem.GRHeavyAssault3",
                        t"DynamicSpawnSystem.GRHeavyAssault4"
                    ], 1);
                let specialisedSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRArasakaSpecSquad1",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad2",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad3",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad4",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad5",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad6",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad7"
                    ], 2);
                return ArrayMerge(eliteBike, ArrayMerge(ArrayMerge(standardSquad, heavySquad), specialisedSquad));   
            case 19: // 12 rares, 5 elite
                let eliteBike = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRArasakaEliteAssassinBike1",
                        t"DynamicSpawnSystem.GRArasakaEliteAssassinBike2",
                        t"DynamicSpawnSystem.GRArasakaEliteAssassinBike3",
                        t"DynamicSpawnSystem.GRArasakaEliteAssassinBike4",
                        t"DynamicSpawnSystem.GRArasakaEliteAssassinBike5"
                    ], 3);            
                let standardSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRArasakaStandardSquad1",
                        t"DynamicSpawnSystem.GRArasakaStandardSquad2",
                        t"DynamicSpawnSystem.GRArasakaStandardSquad3",
                        t"DynamicSpawnSystem.GRArasakaStandardSquad4",
                        t"DynamicSpawnSystem.GRArasakaStandardSquad5"
                    ], 1);
                let heavySquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRHeavyAssault1",
                        t"DynamicSpawnSystem.GRHeavyAssault2",
                        t"DynamicSpawnSystem.GRHeavyAssault3",
                        t"DynamicSpawnSystem.GRHeavyAssault4"
                    ], 1);
                let specialisedSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRArasakaSpecSquad1",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad2",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad3",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad4",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad5",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad6",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad7"
                    ], 2);
                return ArrayMerge(eliteBike, ArrayMerge(ArrayMerge(standardSquad, heavySquad), specialisedSquad));  
            case 20: // 12 rares, 6 elite
                let eliteBike = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRArasakaEliteAssassinBike1",
                        t"DynamicSpawnSystem.GRArasakaEliteAssassinBike2",
                        t"DynamicSpawnSystem.GRArasakaEliteAssassinBike3",
                        t"DynamicSpawnSystem.GRArasakaEliteAssassinBike4",
                        t"DynamicSpawnSystem.GRArasakaEliteAssassinBike5"
                    ], 2);            
                let standardSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRArasakaStandardSquad1",
                        t"DynamicSpawnSystem.GRArasakaStandardSquad2",
                        t"DynamicSpawnSystem.GRArasakaStandardSquad3",
                        t"DynamicSpawnSystem.GRArasakaStandardSquad4",
                        t"DynamicSpawnSystem.GRArasakaStandardSquad5"
                    ], 1);
                let heavySquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRHeavyAssault1",
                        t"DynamicSpawnSystem.GRHeavyAssault2",
                        t"DynamicSpawnSystem.GRHeavyAssault3",
                        t"DynamicSpawnSystem.GRHeavyAssault4"
                    ], 2);
                let specialisedSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRArasakaSpecSquad1",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad2",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad3",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad4",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad5",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad6",
                        t"DynamicSpawnSystem.GRArasakaSpecSquad7"
                    ], 2);
                return ArrayMerge(eliteBike, ArrayMerge(ArrayMerge(standardSquad, heavySquad), specialisedSquad));  
            default: 
                return [];
        }
    }
}