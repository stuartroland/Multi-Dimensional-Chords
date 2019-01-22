me.dir()+"Dependencies/IsochronicTone.ck" => string itPath;
me.dir()+"MultiDimensionalChord.ck" => string mdcPath;
me.dir()+"Dependencies/OneZeroX.ck" => string filtPath;
me.dir()+"MDC Test.ck" => string testPath;

Machine.add(itPath);
Machine.add(mdcPath);
Machine.add(filtPath);

10::samp => now;

Machine.add(testPath);