# Multi-Dimensional-Chords

A novel synthesis algorithm designed to explore the non-duality of pitch and rhythm, both of which are fundamentally frequency.

Both the frequencies of the tones that make up the multi-dimensional chord and the rhythms at which those tones are played are derived from the same ratios.

This process can be used to voice any intervals or chords, but works particularly well with ones related by simple ratios, such as those from just tunings, as otherwise the rhythms of the tones will get out of sync (like when using intervals and chords from 12 Tone Equal Temperament).


## Examples
#### A Multi-Dimensional Interval
To consider a simpler example of the multi-dimensional interval of an octave (1 : 2), the two tones might have pitches of A3, at 220 Hz, and A4, at 440 Hz (220 : 440) === (1 : 2). In this case, the lower A3 note would be played at a rhythm of once per second, while A4 would then be played twice per second (1 : 2).
A short sample of this multi-dimensional interval is included. (MDI Octave 220Hz 1BPS.wav)

#### A Multi-Dimensional Chord
As an example of a multi-dimensional chord, consider a (just intoned) minor triad with ratios (1 : 6/5 : 3/2) === (1 : 1.2 : 1.5). If we play the chord with a fundamental tone of 180 Hz, the third and the fifth are at 216 and 270 Hz respectively. These tones are all played on a rhythm that is based on these very same ratios (1 : 1.2 : 1.5), so if the fundamental sounds 1 time per second, then the third will sound 1.2 times per second, and the fifth at 1.5 times per second. So the rhythms and the frequencies of these tones are both defined by the same ratios, hence my term multi-dimensional chords.
A 10 second sample of this minor triad multi-dimensional chord played with a fundamental of 180 Hz and a fundamental rhythm of 3 BPS is included. (MDC Minor Triad 180Hz 3BPS.wav)

#### A Song Made with Multi-Dimensional Chords
Also included is a short "song" created entirely with Multi-Dimensional Chords, called Fractal Fragment. The ratios between the pitch frequencies and the rhythmic frequencies are varied extensively for musical effect (varying the rate that the song pulses/undulates at to drive the song forward).

#### Binaural Beats Track for Meditation and Relaxation
Finally I included an example of a binaural beats track I made using my BinauralB, IsochronicTone, and MDC classes that I developed. This is a long track that is meant to relax the listener with the simple but beautiful sounds that this code can create. Over the course of the track, the rhythm slows gradually but significantly, diving deeper into the multi-dimensional chords throughout.


## Running the Code
#### Installing ChucK
To run this code, you will need to install ChucK, the strongly-timed audio programming languange that this project was created in. ChucK can be downloaded from http://chuck.cs.princeton.edu/ where you will also find installation instructions. Note that ChucK can be a little finicky to install.
On Windows, the executable downloads as a .man file (no idea what to do with that file type), which I have had to manually rename to a .zip file (a rather dangerous way to deal with files I admit), unzip, then install with the executible.
Installing on Linux is another challenge, as there are 3 installation methods, each of which has worked unreliably for me, but once you get one working it's fine.
I have no personal experience with installing on Macs, though I would guess this would actually be the most stable and straightforward platform, as I believe the developers primarily write on and develop for Macs.
#### Running the Examples
Once ChucK is installed, you can run and mess around with the examples in the "MDC Test.ck" file. Edit this file to play around with the code, but run the file "MDC Test Init.ck". This Init file loads in the dependencies and then runs the examples in "MDC Test.ck"
