public class BinauralB
{
    1 => float gain;
    
    float audibleFreq;
    float phasingFreq;
    
    SinOsc lSin => Gain left;
    SinOsc rSin => Gain right;
    
    
    
    
    fun void setAudibleFreq(float newFreq)
    {
        newFreq => audibleFreq;
        updateOscs();
    }
    
    fun void setPhasingFreq(float newFreq)
    {
        newFreq => phasingFreq;
        updateOscs();
    }

    fun void setFreqs(float audFreq, float phaseFreq)
    {
        setAudibleFreq(audFreq);
        setPhasingFreq(phaseFreq);
    }    
    
    fun void updateOscs()
    {
        audibleFreq + (phasingFreq/2.0) => lSin.freq;
        audibleFreq - (phasingFreq/2.0) => rSin.freq;
        gain => lSin.gain => rSin.gain;
    }
    
    fun void setGain(float newGain)
    {
        newGain => gain;
        updateOscs();
    }
    
}
/*
BinauralB b0;
b0.left => dac.left;
b0.right => dac.right;
b0.setGain(0.1);
b0.setFreqs(220,9);

BinauralB b1;
b1.left => dac.left;
b1.right => dac.right;
b1.setGain(0.05);
b1.setFreqs(110,6);

BinauralB b2;
b2.left => dac.left;
b2.right => dac.right;
b2.setGain(0.05);
b2.setFreqs(55,3);

120::second => now;
*/