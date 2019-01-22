public class OneZeroX   {
    
    1.0 => float mag;
    1 => int imag;
    0.0 => float fmag;
    1 => int oldI;
    
    Gain in;
    Gain out;
    
    OneZero filtStack[imag];
    OneZero ffilt;
    Gain fsplit => Gain fbypass => Gain fadd => out;
    fsplit => ffilt => fadd;
    
    buildFilts();
    
    fun void buildFilts() {
        disconnect();
        
        if(imag > 0)    {
            OneZero newFilts[imag] @=> filtStack;
            <<<"filt stack: ",imag>>>;
            in => filtStack[0];
            for ( 0 => int f; f<imag-1; f++) {
                filtStack[f] => filtStack[f+1];
            }
            filtStack[imag-1] => fsplit;
        }
        else    in => fsplit;
            
        fmag => ffilt.gain;
        1.0-fmag => fbypass.gain;
        
        imag => oldI;
    }
    // make sure to unchuck (disconnect) the old ones and in from fsplit when these are not desired
    
    fun void setMag(float newMag) {
        newMag => mag;
        newMag $ int => imag;
        newMag % 1 => fmag;
        buildFilts();
    }
    
    fun void disconnect()   {
        ffilt.gain() => float oldF;
        if(oldI > 0)    {
            in =< filtStack[0];
            for ( 0 => int f; f<oldI-1; f++) {
                filtStack[f] =< filtStack[f+1];
            }
            filtStack[oldI-1] =< fsplit;
        }
        else {
            in =< fsplit;
        }
    }
    
}


// TESTING _______________________________________
/*
Noise n;
OneZeroX x;
n => x.in;
x.out => dac;

0.2 => n.gain;

x.setMag(0);
 1::second => now;

for ( 0 => int i; i<100; i++)   {
    x.setMag(i/10.0);
    <<<i/10.0>>>;
    0.1::second => now;
}
*/