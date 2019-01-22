public class IsochronicTone
{
    220.0 => float toneFreq;
    8.0 => float modulationFreq;
    1.0 => float scaleMod;
    20::samp => dur stepSize;
    
    SinOsc tone => Gain out;
    SinOsc lfo => blackhole;
    
    updateOscs();
    
    fun void modulateForever()
    {
        ((1.0-scaleMod)/2) => float scaleOffset; //offset from zero to scale, keeping .5 as center gain
        while(1) {
            ((lfo.last()+1)/2.0)*scaleMod + scaleOffset => tone.gain;
            //<<<((lfo.last()+1)/2.0)*.8 + .1>>>;
            //<<<((lfo.last()+1)/2.0)*scaleMod + scaleOffset>>>;
            
            stepSize => now;
        }
    }
    fun void modulateForever(dur newStepSize)
    {
        setStepSize(newStepSize);
        modulateForever();
    }
    fun void setStepSize(dur newStepSize)
    {
        newStepSize => stepSize;
    }
    fun void setToneFreq(float newFreq)
    {
        newFreq => toneFreq;
        updateOscs();
    }
    fun void setModulationFreq(float newFreq)
    {
        newFreq => modulationFreq;
        updateOscs();
    }
    fun void setGain(float newGain)
    {
        newGain => out.gain;
    }
    fun void updateOscs()
    {
        toneFreq => tone.freq;
        modulationFreq => lfo.freq;
    }
    fun void setModScale(float newModScale)
    {
        newModScale => scaleMod;
    }
    
}

// TESTING _____________________
/*
IsochronicTone iso;
iso.out => dac;
iso.setToneFreq(220);
iso.setModulationFreq(8);
iso.setGain(0.5);
iso.setModScale(0.8);
iso.setStepSize(20::samp);
spork ~ iso.modulateForever();
10::second => now;
*/