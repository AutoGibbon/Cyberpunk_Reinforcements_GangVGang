module Gibbon.GR.GangData




public class GRVoodooData extends GRGangData {
	public func GetTrafficSpawns() -> array<TweakDBID> {
		return GetRandomFrom(
			[
				t"DynamicSpawnSystem.GRVoodooTraffic1",
				t"DynamicSpawnSystem.GRVoodooTraffic2",
				t"DynamicSpawnSystem.GRVoodooTraffic3",
				t"DynamicSpawnSystem.GRVoodooTraffic4",
				t"DynamicSpawnSystem.GRVoodooTraffic5"
			], 1);
	}
	
    public func GetReinforcements(heat: Int32) -> array<TweakDBID> { 
        switch (heat) {
            case 1: // 1 weak merc
                let weakMercBike = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRVoodooMercWeakBike1",
                        t"DynamicSpawnSystem.GRVoodooMercWeakBike2",
                        t"DynamicSpawnSystem.GRVoodooMercWeakBike3",
                        t"DynamicSpawnSystem.GRVoodooMercWeakBike4"
                    ], 1);
                return weakMercBike;
            case 2:  // 2 weak mercs        
                let weakMercBike = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRVoodooMercWeakBike1",
                        t"DynamicSpawnSystem.GRVoodooMercWeakBike2",
                        t"DynamicSpawnSystem.GRVoodooMercWeakBike3",
                        t"DynamicSpawnSystem.GRVoodooMercWeakBike4"
                    ], 2);
                return weakMercBike;
            case 3: // 2 weak mercs, 1 vd bike
                let weakMercBike = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRVoodooMercWeakBike1",
                        t"DynamicSpawnSystem.GRVoodooMercWeakBike2",
                        t"DynamicSpawnSystem.GRVoodooMercWeakBike3",
                        t"DynamicSpawnSystem.GRVoodooMercWeakBike4"
                    ], 2);
                
                let normalVoodooBike = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRVoodooNormalBike1",
                        t"DynamicSpawnSystem.GRVoodooNormalBike2",
                        t"DynamicSpawnSystem.GRVoodooNormalBike3",
                        t"DynamicSpawnSystem.GRVoodooNormalBike4",
                        t"DynamicSpawnSystem.GRVoodooNormalBike5",
                        t"DynamicSpawnSystem.GRVoodooNormalBike6"
                    ], 2);

                return ArrayMerge(weakMercBike, normalVoodooBike);
            case 4: // 2 weak, 2 normal(merc squaad), 1 normal voodoo bike
                let normalVoodooBike = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRVoodooNormalBike1",
                        t"DynamicSpawnSystem.GRVoodooNormalBike2",
                        t"DynamicSpawnSystem.GRVoodooNormalBike3",
                        t"DynamicSpawnSystem.GRVoodooNormalBike4",
                        t"DynamicSpawnSystem.GRVoodooNormalBike5",
                        t"DynamicSpawnSystem.GRVoodooNormalBike6"
                    ], 1);
                let weakMercSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRVoodooMercWeakSquad1",
                        t"DynamicSpawnSystem.GRVoodooMercWeakSquad2",
                        t"DynamicSpawnSystem.GRVoodooMercWeakSquad3"
                    ], 1);
                return ArrayMerge(weakMercSquad, normalVoodooBike);        
            case 5:  // 2 weak, 2 normal(merc squaad), 1 rare  1 normal (small voodoo car)
                let weakMercSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRVoodooMercWeakSquad1",
                        t"DynamicSpawnSystem.GRVoodooMercWeakSquad2",
                        t"DynamicSpawnSystem.GRVoodooMercWeakSquad3"
                    ], 1);

                let voodooCar2 = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRVoodooRareNormal1",
                        t"DynamicSpawnSystem.GRVoodooRareNormal2",
                        t"DynamicSpawnSystem.GRVoodooRareNormal3",
                        t"DynamicSpawnSystem.GRVoodooRareNormal4",
                        t"DynamicSpawnSystem.GRVoodooRareNormal5",
                        t"DynamicSpawnSystem.GRVoodooRareNormal6"
                    ], 1);

                return ArrayMerge(weakMercSquad, voodooCar2);   
            case 6:  // 2 weak, 2 normal(merc squaad), 1 rare  1 normal (small voodoo car), 1 n voodoo bike
                let normalVoodooBike = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRVoodooNormalBike1",
                        t"DynamicSpawnSystem.GRVoodooNormalBike2",
                        t"DynamicSpawnSystem.GRVoodooNormalBike3",
                        t"DynamicSpawnSystem.GRVoodooNormalBike4",
                        t"DynamicSpawnSystem.GRVoodooNormalBike5",
                        t"DynamicSpawnSystem.GRVoodooNormalBike6"
                    ], 1);  

                let weakMercSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRVoodooMercWeakSquad1",
                        t"DynamicSpawnSystem.GRVoodooMercWeakSquad2",
                        t"DynamicSpawnSystem.GRVoodooMercWeakSquad3"
                    ], 1);

                let voodooCar2 = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRVoodooRareNormal1",
                        t"DynamicSpawnSystem.GRVoodooRareNormal2",
                        t"DynamicSpawnSystem.GRVoodooRareNormal3",
                        t"DynamicSpawnSystem.GRVoodooRareNormal4",
                        t"DynamicSpawnSystem.GRVoodooRareNormal5",
                        t"DynamicSpawnSystem.GRVoodooRareNormal6"
                    ], 1);                              
                return ArrayMerge(ArrayMerge(weakMercSquad, voodooCar2), normalVoodooBike);   
            case 7:  // 2 weak, 2 normal(merc squaad), 1 rare  1 normal (small voodoo car), 2 n voodoo bike
                let normalVoodooBike = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRVoodooNormalBike1",
                        t"DynamicSpawnSystem.GRVoodooNormalBike2",
                        t"DynamicSpawnSystem.GRVoodooNormalBike3",
                        t"DynamicSpawnSystem.GRVoodooNormalBike4",
                        t"DynamicSpawnSystem.GRVoodooNormalBike5",
                        t"DynamicSpawnSystem.GRVoodooNormalBike6"
                    ], 2);  

                let weakMercSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRVoodooMercWeakSquad1",
                        t"DynamicSpawnSystem.GRVoodooMercWeakSquad2",
                        t"DynamicSpawnSystem.GRVoodooMercWeakSquad3"
                    ], 1);

                let voodooCar2 = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRVoodooRareNormal1",
                        t"DynamicSpawnSystem.GRVoodooRareNormal2",
                        t"DynamicSpawnSystem.GRVoodooRareNormal3",
                        t"DynamicSpawnSystem.GRVoodooRareNormal4",
                        t"DynamicSpawnSystem.GRVoodooRareNormal5",
                        t"DynamicSpawnSystem.GRVoodooRareNormal6"
                    ], 1);                              
                return ArrayMerge(ArrayMerge(weakMercSquad, voodooCar2), normalVoodooBike);   
            case 8: // 2 weak, 2 normal(merc squaad), 2 rare  2 normal (2 small voodoo car)
                let weakMercSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRVoodooMercWeakSquad1",
                        t"DynamicSpawnSystem.GRVoodooMercWeakSquad2",
                        t"DynamicSpawnSystem.GRVoodooMercWeakSquad3"
                    ], 2);

                let voodooCar2 = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRVoodooRareNormal1",
                        t"DynamicSpawnSystem.GRVoodooRareNormal2",
                        t"DynamicSpawnSystem.GRVoodooRareNormal3",
                        t"DynamicSpawnSystem.GRVoodooRareNormal4",
                        t"DynamicSpawnSystem.GRVoodooRareNormal5",
                        t"DynamicSpawnSystem.GRVoodooRareNormal6"
                    ], 2);                              
                return ArrayMerge(weakMercSquad, voodooCar2);   
            case 9:  //  Medium Merc Squad(2 normal 2 rare), 1 voodoo rare runner on bike
                let runnerBike = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRVoodooRunnerBike1",
                        t"DynamicSpawnSystem.GRVoodooRunnerBike2"
                    ], 1);

                let mediumMercSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRVoodooMercMediumSquad1",
                        t"DynamicSpawnSystem.GRVoodooMercMediumSquad2",
                        t"DynamicSpawnSystem.GRVoodooMercMediumSquad3",
                        t"DynamicSpawnSystem.GRVoodooMercMediumSquad4",
                        t"DynamicSpawnSystem.GRVoodooMercMediumSquad5",
                        t"DynamicSpawnSystem.GRVoodooMercMediumSquad6"
                    ], 1);   

                return ArrayMerge(runnerBike, mediumMercSquad);       
            case 10: // Medium Merc Squad(2 normal 2 rare), 1 voodoo elite car (elite + normal)
                let mediumMercSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRVoodooMercMediumSquad1",
                        t"DynamicSpawnSystem.GRVoodooMercMediumSquad2",
                        t"DynamicSpawnSystem.GRVoodooMercMediumSquad3",
                        t"DynamicSpawnSystem.GRVoodooMercMediumSquad4",
                        t"DynamicSpawnSystem.GRVoodooMercMediumSquad5",
                        t"DynamicSpawnSystem.GRVoodooMercMediumSquad6"
                    ], 1);   

                let voodooEliteCar = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRVoodooEliteCar1",
                        t"DynamicSpawnSystem.GRVoodooEliteCar2",
                        t"DynamicSpawnSystem.GRVoodooEliteCar3",
                        t"DynamicSpawnSystem.GRVoodooEliteCar4"
                    ], 1);

                return ArrayMerge(voodooEliteCar, mediumMercSquad);    
            case 11: //  Medium Merc Squad(2 normal 2 rare), Merc Hit Squad(1 lite, 2 rares, 1 normal), 1 voodoo normal bike
                let mediumMercSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRVoodooMercMediumSquad1",
                        t"DynamicSpawnSystem.GRVoodooMercMediumSquad2",
                        t"DynamicSpawnSystem.GRVoodooMercMediumSquad3",
                        t"DynamicSpawnSystem.GRVoodooMercMediumSquad4",
                        t"DynamicSpawnSystem.GRVoodooMercMediumSquad5",
                        t"DynamicSpawnSystem.GRVoodooMercMediumSquad6"
                    ], 1);   

                let eliteMercSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRVoodooMercEliteSquad1",
                        t"DynamicSpawnSystem.GRVoodooMercEliteSquad2",
                        t"DynamicSpawnSystem.GRVoodooMercEliteSquad3",
                        t"DynamicSpawnSystem.GRVoodooMercEliteSquad4",
                        t"DynamicSpawnSystem.GRVoodooMercEliteSquad5"
                    ], 1);   

                let normalVoodooBike = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRVoodooNormalBike1",
                        t"DynamicSpawnSystem.GRVoodooNormalBike2",
                        t"DynamicSpawnSystem.GRVoodooNormalBike3",
                        t"DynamicSpawnSystem.GRVoodooNormalBike4",
                        t"DynamicSpawnSystem.GRVoodooNormalBike5",
                        t"DynamicSpawnSystem.GRVoodooNormalBike6"
                    ], 1);  

                return ArrayMerge(ArrayMerge(eliteMercSquad, mediumMercSquad), normalVoodooBike);     
            case 12: // Medium Merc Squad(2 normal 2 rare), Merc Hit Squad(1 lite, 2 rares, 1 normal), 1 voodoo runner rare
                 let mediumMercSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRVoodooMercMediumSquad1",
                        t"DynamicSpawnSystem.GRVoodooMercMediumSquad2",
                        t"DynamicSpawnSystem.GRVoodooMercMediumSquad3",
                        t"DynamicSpawnSystem.GRVoodooMercMediumSquad4",
                        t"DynamicSpawnSystem.GRVoodooMercMediumSquad5",
                        t"DynamicSpawnSystem.GRVoodooMercMediumSquad6"
                    ], 1);   

                let eliteMercSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRVoodooMercEliteSquad1",
                        t"DynamicSpawnSystem.GRVoodooMercEliteSquad2",
                        t"DynamicSpawnSystem.GRVoodooMercEliteSquad3",
                        t"DynamicSpawnSystem.GRVoodooMercEliteSquad4",
                        t"DynamicSpawnSystem.GRVoodooMercEliteSquad5"
                    ], 1);         
                let runnerBike = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRVoodooRunnerBike1",
                        t"DynamicSpawnSystem.GRVoodooRunnerBike2"
                    ], 1);     
                return ArrayMerge(ArrayMerge(eliteMercSquad, mediumMercSquad), runnerBike);               
            case 13: // Medium Merc Squad(2 normal 2 rare), Merc Hit Squad(1 lite, 2 rares, 1 normal), 1 rare  1 normal (small voodoo car)
                 let mediumMercSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRVoodooMercMediumSquad1",
                        t"DynamicSpawnSystem.GRVoodooMercMediumSquad2",
                        t"DynamicSpawnSystem.GRVoodooMercMediumSquad3",
                        t"DynamicSpawnSystem.GRVoodooMercMediumSquad4",
                        t"DynamicSpawnSystem.GRVoodooMercMediumSquad5",
                        t"DynamicSpawnSystem.GRVoodooMercMediumSquad6"
                    ], 1);   

                let eliteMercSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRVoodooMercEliteSquad1",
                        t"DynamicSpawnSystem.GRVoodooMercEliteSquad2",
                        t"DynamicSpawnSystem.GRVoodooMercEliteSquad3",
                        t"DynamicSpawnSystem.GRVoodooMercEliteSquad4",
                        t"DynamicSpawnSystem.GRVoodooMercEliteSquad5"
                    ], 1);      
                let voodooCar2 = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRVoodooRareNormal1",
                        t"DynamicSpawnSystem.GRVoodooRareNormal2",
                        t"DynamicSpawnSystem.GRVoodooRareNormal3",
                        t"DynamicSpawnSystem.GRVoodooRareNormal4",
                        t"DynamicSpawnSystem.GRVoodooRareNormal5",
                        t"DynamicSpawnSystem.GRVoodooRareNormal6"
                    ], 1); 

                return ArrayMerge(ArrayMerge(eliteMercSquad, mediumMercSquad), voodooCar2);  
            case 14: // 2 * Medium Merc Squad(2 normal 2 rare), 1 Voodoo elite car
                let mediumMercSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRVoodooMercMediumSquad1",
                        t"DynamicSpawnSystem.GRVoodooMercMediumSquad2",
                        t"DynamicSpawnSystem.GRVoodooMercMediumSquad3",
                        t"DynamicSpawnSystem.GRVoodooMercMediumSquad4",
                        t"DynamicSpawnSystem.GRVoodooMercMediumSquad5",
                        t"DynamicSpawnSystem.GRVoodooMercMediumSquad6"
                    ], 2);   

                let voodooEliteCar = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRVoodooEliteCar1",
                        t"DynamicSpawnSystem.GRVoodooEliteCar2",
                        t"DynamicSpawnSystem.GRVoodooEliteCar3",
                        t"DynamicSpawnSystem.GRVoodooEliteCar4"
                    ], 1);                    
                return ArrayMerge(voodooEliteCar, mediumMercSquad);
            case 15: // 2 * Merc Elite squads, 1 Voodoo runner rare
                let eliteMercSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRVoodooMercEliteSquad1",
                        t"DynamicSpawnSystem.GRVoodooMercEliteSquad2",
                        t"DynamicSpawnSystem.GRVoodooMercEliteSquad3",
                        t"DynamicSpawnSystem.GRVoodooMercEliteSquad4",
                        t"DynamicSpawnSystem.GRVoodooMercEliteSquad5"
                    ], 2);   
                    let runnerBike = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRVoodooRunnerBike1",
                        t"DynamicSpawnSystem.GRVoodooRunnerBike2"
                    ], 1); 
                return ArrayMerge(runnerBike, eliteMercSquad);
            case 16: // Voodoo Elite  Squad (2 elites, 2 rares), Medium Merc Squad(2 normal 2 rare)
                let eliteVoodooSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRVoodooEliteSquad1",
                        t"DynamicSpawnSystem.GRVoodooEliteSquad2"
                    ], 1); 

                let mediumMercSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRVoodooMercMediumSquad1",
                        t"DynamicSpawnSystem.GRVoodooMercMediumSquad2",
                        t"DynamicSpawnSystem.GRVoodooMercMediumSquad3",
                        t"DynamicSpawnSystem.GRVoodooMercMediumSquad4",
                        t"DynamicSpawnSystem.GRVoodooMercMediumSquad5",
                        t"DynamicSpawnSystem.GRVoodooMercMediumSquad6"
                    ], 1);  

                return ArrayMerge(eliteVoodooSquad, mediumMercSquad);
            case 17: // Voodoo Elite  Squad (2 elites, 2 rares), 2Medium Merc Squad(2 normal 2 rare)
                let eliteVoodooSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRVoodooEliteSquad1",
                        t"DynamicSpawnSystem.GRVoodooEliteSquad2"
                    ], 1); 

                let mediumMercSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRVoodooMercMediumSquad1",
                        t"DynamicSpawnSystem.GRVoodooMercMediumSquad2",
                        t"DynamicSpawnSystem.GRVoodooMercMediumSquad3",
                        t"DynamicSpawnSystem.GRVoodooMercMediumSquad4",
                        t"DynamicSpawnSystem.GRVoodooMercMediumSquad5",
                        t"DynamicSpawnSystem.GRVoodooMercMediumSquad6"
                    ], 2);  

                return ArrayMerge(eliteVoodooSquad, mediumMercSquad);
            case 18: // Voodoo Elite  Squad (2 elites, 2 rares), 1 Merc Elite Squad
                let eliteVoodooSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRVoodooEliteSquad1",
                        t"DynamicSpawnSystem.GRVoodooEliteSquad2"
                    ], 1); 

                let eliteMercSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRVoodooMercEliteSquad1",
                        t"DynamicSpawnSystem.GRVoodooMercEliteSquad2",
                        t"DynamicSpawnSystem.GRVoodooMercEliteSquad3",
                        t"DynamicSpawnSystem.GRVoodooMercEliteSquad4",
                        t"DynamicSpawnSystem.GRVoodooMercEliteSquad5"
                    ], 1);                      
                return ArrayMerge(eliteMercSquad, eliteVoodooSquad);  
            case 19: // Voodoo Elite  Squad (2 elites, 2 rares), 1 Merc Elite Squad, 1 Runner bike
                let eliteVoodooSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRVoodooEliteSquad1",
                        t"DynamicSpawnSystem.GRVoodooEliteSquad2"
                    ], 1); 

                let runnerBike = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRVoodooRunnerBike1",
                        t"DynamicSpawnSystem.GRVoodooRunnerBike2"
                    ], 1);   

                let eliteMercSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRVoodooMercEliteSquad1",
                        t"DynamicSpawnSystem.GRVoodooMercEliteSquad2",
                        t"DynamicSpawnSystem.GRVoodooMercEliteSquad3",
                        t"DynamicSpawnSystem.GRVoodooMercEliteSquad4",
                        t"DynamicSpawnSystem.GRVoodooMercEliteSquad5"
                    ], 1);                      
                return ArrayMerge(ArrayMerge(eliteMercSquad, eliteVoodooSquad), runnerBike);  
            case 20: // Voodoo Elite  Squad (2 elites, 2 rares), 2 Merc Elite Squad
                let eliteVoodooSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRVoodooEliteSquad1",
                        t"DynamicSpawnSystem.GRVoodooEliteSquad2"
                    ], 1); 

                let eliteMercSquad = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRVoodooMercEliteSquad1",
                        t"DynamicSpawnSystem.GRVoodooMercEliteSquad2",
                        t"DynamicSpawnSystem.GRVoodooMercEliteSquad3",
                        t"DynamicSpawnSystem.GRVoodooMercEliteSquad4",
                        t"DynamicSpawnSystem.GRVoodooMercEliteSquad5"
                    ], 2);                      
                return ArrayMerge(eliteMercSquad, eliteVoodooSquad);  
            default: 
                return [];
        }
    }
}