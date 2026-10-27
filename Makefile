.PHONY: test check preparar-quartus quartus timing zip clean

test:
	python3 scripts/testar.py

check:
	python3 scripts/conferir_projeto.py

preparar-quartus:
	python3 scripts/preparar_quartus.py

quartus: preparar-quartus
	cd build/quartus/projeto && quartus_sh --flow compile cifrador

timing:
	cd build/quartus/projeto && quartus_sta -t relatorios.tcl

zip:
	python3 scripts/empacotar.py

clean:
	python3 scripts/limpar.py
