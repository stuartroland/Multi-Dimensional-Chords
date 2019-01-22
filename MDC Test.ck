    //SETUP MDC AND AUDIO CHAIN____________________________________________________________________
    MDC multi;
    OneZeroX lpf;
    multi.out => lpf.in;
    lpf.out => dac;

    multi.setUpdateStepSize(1::samp);
    lpf.setMag(18.0);


// DEFINE TONES AND CHORDS________________________________________________________________________________

// +++++++++++++++++++++
184.0 => float tonic;       //Define fundamental note, tonic
[tonic*0.5,tonic,tonic*(6.0/5),tonic*1.5,tonic*(16.0/9),tonic*2,tonic*(1+10/8.0),tonic*(2+2.0/3)] @=> float chord[];      //Define chord
// ---------------------


//Modulation Rate Sequencing________________________________________________________________________
    
// +++++++++++++++++++++
[16.0,12.0,8.0,6.0,4.0,2.0,1.0] @=> float freqPoints[];     // modulation freq progression, Hz
// ---------------------

// +++++++++++++++++++++
[0::minute,2::minute, 5::minute, 8::minute, 10::minute, 12.5::minute, 15::minute] @=> dur changeTimes[];     //Modulation change times
//[0::minute,3::minute/10.0,8::minute/10.0,15::minute/10.0,25::minute/10.0,30::minute/10.0] @=> dur changeTimes[];
// ---------------------

    changeTimes[changeTimes.cap()-1] => dur totalTime;
    freqPoints[0] => float startFreq;
    freqPoints[freqPoints.cap()-1] => float endFreq;

 
// SETUP LOOP__________________________________________________________________
    
    1::second => dur updateStep;

    now => time startT;
    //(totalTime-sustainLow) => dur changeTime;
    float newFreq;

    fun int getSection()    {
        for ( 0 => int i; i<changeTimes.cap(); i++)
        {
            if ( (now-startT) < (changeTimes[i]) )  return i;
        }
    }

    0 => int section;

    
    multi.loadChord(chord);
    multi.setAmpChange(0.75);

// MAIN LOOP_____________________________________________________________________
    spork ~ multi.modGates(0.1::second);
    
    while ( now < startT+totalTime )
    {
        getSection() => section;
        <<<"Section: ",section>>>;
        
        freqPoints[section-1] + ((now-(startT+changeTimes[section-1]))/(changeTimes[section]-changeTimes[section-1]))*(freqPoints[section]-freqPoints[section-1]) => newFreq;
        <<<newFreq>>>;

        multi.updateModRates(newFreq);
        
        <<<(now-startT)/second," seconds">>>;
        updateStep => now;
    }