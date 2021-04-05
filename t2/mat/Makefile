
octave.log: t2p1.m ../t2_datagen.py
	python2.7 t2_datagen.py > data.txt
	octave $< > $@

clean:
	@rm -f octave.log octave-workspace *.tex *.txt *.eps *~

.PHONY: clean

