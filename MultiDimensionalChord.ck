// Multi Dimensional Chords
// Stuart Roland

public class MDC {

    IsochronicTone iso[3];

    float chord[3];

    Gain gate[3];                   
    SinOsc glfo[3];
    Gain out;
    
    10 => float startModFreq;
    float modRates[];    

    
    10::samp => dur updateStepSize;    // try adjusting, this affects the noise
    1 => int undulating;    // Toggle modulating, flowing effect by commenting this out
    
    0 => int built;

    1.0 => float ampChange;
    
    // scale the effect of the gating, to make more (higher) or less (lower) change in volume
    fun void setAmpChange(float newAmpChange) {
        newAmpChange => ampChange;
    }
    
    fun void setUpdateStepSize(dur newUpdateStep) {
        newUpdateStep => updateStepSize;
    }
    
    fun void loadChord(float freqs[]) {
        freqs @=> chord;
        IsochronicTone newIso[chord.cap()] @=> iso;
        Gain newGate[chord.cap()] @=> gate;                   
        SinOsc newGlfo[chord.cap()] @=> glfo;
        1 => built;
        
        scaleModChord(startModFreq) @=>  modRates;
        for (0 => int i; i<iso.cap(); i++)
        {
            if(undulating) {glfo[i] => blackhole;}       
            iso[i].out => gate[i] => out;
            iso[i].setToneFreq(chord[i]);
            iso[i].setModulationFreq(modRates[i]);
            iso[i].setGain(1.0/iso.cap());
            iso[i].setModScale(0.8);
            iso[i].setStepSize(updateStepSize);   

            spork ~ iso[i].modulateForever();
        }
    }
    
    // get factor to multiply a pitch freq by to get desired modulation rate
    fun float getModScaler(float pitchFreq, float modRate)
    {
        return modRate/pitchFreq;
    }
    // get array of modulation freqs based on chord pitch freqs centered on given mod freq
    fun float[] scaleModChord(float centerModRate)
    {
        if (built) {
            (chord.cap()/2) => int center;
            if(!(chord.cap()%2)) -1 +=> center;
            //<<<center>>>;
            getModScaler(chord[center],centerModRate) => float scaler;
            float mods[chord.cap()];
            for(0 => int i; i<chord.cap();i++)
            {
                chord[i]*scaler => mods[i];
            }
            return mods;
        }
    }

    fun void setModChordRates(float speed) {
        if(built) {
            scaleModChord(speed) @=> float gateMods[];
            for (0 => int i; i<glfo.cap(); i++)
            {
                gateMods[i] => glfo[i].freq;
            }    
        }   
    }
        
    fun void modGates(dur update)
    {
        while(1)    {
            for (0 => int i; i<glfo.cap(); i++)
            {
                0.5+(glfo[i].last()*0.5*ampChange) => gate[i].gain;
                //<<<gate[i].gain()>>>;
            }    
            update => now;
        }
    }
    
    fun void updateModRates(float newModRate) {
        scaleModChord(newModRate) @=> modRates;
        setModChordRates(newModRate/40.0);
        for (0 => int i; i<iso.cap(); i++)
        {
            iso[i].setModulationFreq(modRates[i]);
        }
    }
}
