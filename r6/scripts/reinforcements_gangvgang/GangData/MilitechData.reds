module Gibbon.GR.GangData


public class GRMilitechData extends GRGangData {
	public func GetTrafficSpawns() -> array<TweakDBID> {
		return GetRandomFrom(
			[
				t"DynamicSpawnSystem.GRMilitechTraffic1",
				t"DynamicSpawnSystem.GRMilitechTraffic2",
				t"DynamicSpawnSystem.GRMilitechTraffic3",
				t"DynamicSpawnSystem.GRMilitechTraffic4",
				t"DynamicSpawnSystem.GRMilitechTraffic5"
			], 1);
	}
	
    public func GetReinforcements(heat: Int32) -> array<TweakDBID> { 
        switch (heat) {
            case 1: // 2 weak (1 ww car)
                let ww = [t"DynamicSpawnSystem.GRMilitechWW"];

                return ww;
            case 2:  // 1 weak, 1 normal (1 wn car)        
                let nw = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMilitechNW1",
                        t"DynamicSpawnSystem.GRMilitechNW2"
                    ], 1);

                return nw;
            case 3: // 3 weak, 1 normal (1 ww car, 1 wn car)
                let nw = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMilitechNW1",
                        t"DynamicSpawnSystem.GRMilitechNW2"
                    ], 1);
                let ww = [t"DynamicSpawnSystem.GRMilitechWW"];   
                return ArrayMerge(nw, ww);
            case 4: // 2 weak, 2 normal 
                let nw = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMilitechNW1",
                        t"DynamicSpawnSystem.GRMilitechNW2"
                    ], 2);
                return nw;           
            case 5:  // 3 normal, 1 rare (rnnn car)
                let rnnn = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMilitechRNNN1",
                        t"DynamicSpawnSystem.GRMilitechRNNN2",
                        t"DynamicSpawnSystem.GRMilitechRNNN3",
                        t"DynamicSpawnSystem.GRMilitechRNNN4"
                    ], 1);
                return rnnn;
            case 6:  // 2 weak, 3 normal, 1 rare (rnnn car + ww car)
                let rnnn = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMilitechRNNN1",
                        t"DynamicSpawnSystem.GRMilitechRNNN2",
                        t"DynamicSpawnSystem.GRMilitechRNNN3",
                        t"DynamicSpawnSystem.GRMilitechRNNN4"
                    ], 1);

                let ww = [t"DynamicSpawnSystem.GRMilitechWW"];                  

                return ArrayMerge(rnnn, ww);
            case 7:  // 1 weak, 4 normal, 1 rare  (rnnn car + nw car)
                let rnnn = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMilitechRNNN1",
                        t"DynamicSpawnSystem.GRMilitechRNNN2",
                        t"DynamicSpawnSystem.GRMilitechRNNN3",
                        t"DynamicSpawnSystem.GRMilitechRNNN4"
                    ], 1);

                let nw = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMilitechNW1",
                        t"DynamicSpawnSystem.GRMilitechNW2"
                    ], 1);
                return ArrayMerge(rnnn, nw);
            case 8: // 3 weak, 4 normals, 1 rare  (rnnn car + nw car + ww car)  
                let rnnn = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMilitechRNNN1",
                        t"DynamicSpawnSystem.GRMilitechRNNN2",
                        t"DynamicSpawnSystem.GRMilitechRNNN3",
                        t"DynamicSpawnSystem.GRMilitechRNNN4"
                    ], 1);
                    
                let nw = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMilitechNW1",
                        t"DynamicSpawnSystem.GRMilitechNW2"
                    ], 1);     

                let ww = [t"DynamicSpawnSystem.GRMilitechWW"];                   
                return ArrayMerge(ArrayMerge(rnnn, nw), ww);
            case 9:  // 6 normals, 2 rare (2 rnnn car)   
                let rnnn = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMilitechRNNN1",
                        t"DynamicSpawnSystem.GRMilitechRNNN2",
                        t"DynamicSpawnSystem.GRMilitechRNNN3",
                        t"DynamicSpawnSystem.GRMilitechRNNN4"
                    ], 2);            
                return rnnn;      
            case 10: // 5 normals, 2 rares, 1 elite (ernn + rnnn)
                let ernn = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMilitechERNN1",
                        t"DynamicSpawnSystem.GRMilitechERNN2",
                        t"DynamicSpawnSystem.GRMilitechERNN3",
                        t"DynamicSpawnSystem.GRMilitechERNN4"
                    ], 1);  

                let rnnn = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMilitechRNNN1",
                        t"DynamicSpawnSystem.GRMilitechRNNN2",
                        t"DynamicSpawnSystem.GRMilitechRNNN3",
                        t"DynamicSpawnSystem.GRMilitechRNNN4"
                    ], 2);  

                return ArrayMerge(ernn, rnnn);
            case 11: // 4 normals 3 rares, 1 elite (ernn + rrnn)
                let ernn = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMilitechERNN1",
                        t"DynamicSpawnSystem.GRMilitechERNN2",
                        t"DynamicSpawnSystem.GRMilitechERNN3",
                        t"DynamicSpawnSystem.GRMilitechERNN4"
                    ], 1);  

                let rrnn = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMilitechRRNN1",
                        t"DynamicSpawnSystem.GRMilitechRRNN2",
                        t"DynamicSpawnSystem.GRMilitechRRNN3"
                    ], 1);  

                return ArrayMerge(ernn, rrnn);      
            case 12: // 2 weak, 4 normals, 3 rares, 1 elite (ernn + rrnn + ww)
                let ernn = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMilitechERNN1",
                        t"DynamicSpawnSystem.GRMilitechERNN2",
                        t"DynamicSpawnSystem.GRMilitechERNN3",
                        t"DynamicSpawnSystem.GRMilitechERNN4"
                    ], 1);  

                let rrnn = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMilitechRRNN1",
                        t"DynamicSpawnSystem.GRMilitechRRNN2",
                        t"DynamicSpawnSystem.GRMilitechRRNN3"
                    ], 1);  

                let ww = [t"DynamicSpawnSystem.GRMilitechWW"];   

                return ArrayMerge(ArrayMerge(ernn, rrnn), ww);                
            case 13: // 1 weak, 5 normals, 3 rares, 1 elite (ernn + rrnn + nw)
                let ernn = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMilitechERNN1",
                        t"DynamicSpawnSystem.GRMilitechERNN2",
                        t"DynamicSpawnSystem.GRMilitechERNN3",
                        t"DynamicSpawnSystem.GRMilitechERNN4"
                    ], 1);  

                let rrnn = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMilitechRRNN1",
                        t"DynamicSpawnSystem.GRMilitechRRNN2",
                        t"DynamicSpawnSystem.GRMilitechRRNN3"
                    ], 1);  
                    
                let nw = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMilitechNW1",
                        t"DynamicSpawnSystem.GRMilitechNW2"
                    ], 1);   

                return ArrayMerge(ArrayMerge(ernn, rrnn), nw);   
            case 14: // 7 normals, 4 rares, 1 elite (ernn + rrnn + rnnn)
                let ernn = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMilitechERNN1",
                        t"DynamicSpawnSystem.GRMilitechERNN2",
                        t"DynamicSpawnSystem.GRMilitechERNN3",
                        t"DynamicSpawnSystem.GRMilitechERNN4"
                    ], 1);  

                let rrnn = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMilitechRRNN1",
                        t"DynamicSpawnSystem.GRMilitechRRNN2",
                        t"DynamicSpawnSystem.GRMilitechRRNN3"
                    ], 1);  

                let rnnn = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMilitechRNNN1",
                        t"DynamicSpawnSystem.GRMilitechRNNN2",
                        t"DynamicSpawnSystem.GRMilitechRNNN3",
                        t"DynamicSpawnSystem.GRMilitechRNNN4"
                    ], 1);                      

                return ArrayMerge(ArrayMerge(ernn, rrnn), rnnn);   
            case 15: // 4 normals, 4 rares, 2 elite (2 ernn + rrnn)\
                let ernn = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMilitechERNN1",
                        t"DynamicSpawnSystem.GRMilitechERNN2",
                        t"DynamicSpawnSystem.GRMilitechERNN3",
                        t"DynamicSpawnSystem.GRMilitechERNN4"
                    ], 2);  

                let rrnn = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMilitechRRNN1",
                        t"DynamicSpawnSystem.GRMilitechRRNN2",
                        t"DynamicSpawnSystem.GRMilitechRRNN3"
                    ], 1);  

                return ArrayMerge(ernn, rrnn);   
            case 16: // 6 normals 5 rares, 2 elite (2 ernn + rrnn + nw)
                let ernn = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMilitechERNN1",
                        t"DynamicSpawnSystem.GRMilitechERNN2",
                        t"DynamicSpawnSystem.GRMilitechERNN3",
                        t"DynamicSpawnSystem.GRMilitechERNN4"
                    ], 2);  

                let rrnn = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMilitechRRNN1",
                        t"DynamicSpawnSystem.GRMilitechRRNN2",
                        t"DynamicSpawnSystem.GRMilitechRRNN3"
                    ], 1);  
                let nw = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMilitechNW1",
                        t"DynamicSpawnSystem.GRMilitechNW2"
                    ], 1);

                return ArrayMerge(ArrayMerge(ernn, rrnn), nw);   
            case 17: // 6 normals, 6 rares, 2 elite (2 ernn + 2rrnn )
                let ernn = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMilitechERNN1",
                        t"DynamicSpawnSystem.GRMilitechERNN2",
                        t"DynamicSpawnSystem.GRMilitechERNN3",
                        t"DynamicSpawnSystem.GRMilitechERNN4"
                    ], 2);  

                let rrnn = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMilitechRRNN1",
                        t"DynamicSpawnSystem.GRMilitechRRNN2",
                        t"DynamicSpawnSystem.GRMilitechRRNN3"
                    ], 2);  

                return ArrayMerge(ernn, rrnn);   
            case 18: // 6 normals, 6 rares, 2 elite (2 ernn + 2rrnn )
                let ernn = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMilitechERNN1",
                        t"DynamicSpawnSystem.GRMilitechERNN2",
                        t"DynamicSpawnSystem.GRMilitechERNN3",
                        t"DynamicSpawnSystem.GRMilitechERNN4"
                    ], 2);  

                let rrnn = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMilitechRRNN1",
                        t"DynamicSpawnSystem.GRMilitechRRNN2",
                        t"DynamicSpawnSystem.GRMilitechRRNN3"
                    ], 2);  

                return ArrayMerge(ernn, rrnn);   
            case 19: // 8 normals, 7 rares, 3 elite (3 ernn + 2rrnn )
                let ernn = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMilitechERNN1",
                        t"DynamicSpawnSystem.GRMilitechERNN2",
                        t"DynamicSpawnSystem.GRMilitechERNN3",
                        t"DynamicSpawnSystem.GRMilitechERNN4"
                    ], 3);  

                let rrnn = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMilitechRRNN1",
                        t"DynamicSpawnSystem.GRMilitechRRNN2",
                        t"DynamicSpawnSystem.GRMilitechRRNN3"
                    ], 2);  

                return ArrayMerge(ernn, rrnn);   
            case 20: // 12 normals, 8 rares, 4 elite (4 ernn + 2rrnn )
                let ernn = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMilitechERNN1",
                        t"DynamicSpawnSystem.GRMilitechERNN2",
                        t"DynamicSpawnSystem.GRMilitechERNN3",
                        t"DynamicSpawnSystem.GRMilitechERNN4"
                    ], 4);  

                let rrnn = GetRandomFrom(
                    [
                        t"DynamicSpawnSystem.GRMilitechRRNN1",
                        t"DynamicSpawnSystem.GRMilitechRRNN2",
                        t"DynamicSpawnSystem.GRMilitechRRNN3"
                    ], 2);  

                return ArrayMerge(ernn, rrnn);   
            default: 
                return [];
        }
    }
}