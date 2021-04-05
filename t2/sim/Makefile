all: ngspice.log
	$(eval NGSFIGS=$(shell grep _FIG $< | sed 's/_FIG//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(eval NGSFIGPS=$(addsuffix .ps, $(NGSFIGS)))
	$(foreach i, $(NGSFIGPS), ps2pdf $i;)
	$(eval NGSTABS=$(shell grep _TAB $< | sed 's/_TAB//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(foreach i, $(NGSTABS), sed -n '/^$i_TAB/,/^$i_END/{p;/^$i_END/q}' $< | grep -v $i_TAB | grep -v $i_END | grep -v '#' | sed 's/\=/\&/g' | sed 's/$$/\\\\ \\hline/g' > $i_tab.tex;)

ngspice.log: t2p1.net t2p2.net t2p3.net t2p4.net t2p5.net      
	ngspice -b  t2p1.net -o $@
	ngspice -b  t2p2.net -o $@
	ngspice -b  t2p3.net -o $@
	ngspice -b  t2p4.net -o $@
	ngspice -b  t2p5.net -o $@
clean:
	@rm -f ngspice.log *.tex *.pdf *.ps *~

.PHONY: all clean
