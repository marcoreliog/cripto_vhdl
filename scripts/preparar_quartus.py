#!/usr/bin/env python3
"""Copia apenas a configuracao para que os bancos Quartus fiquem em build/."""
from pathlib import Path
import shutil

RAIZ = Path(__file__).resolve().parents[1]
destino = RAIZ / "build/quartus/projeto"
destino.mkdir(parents=True, exist_ok=True)
for nome in ("cifrador.qpf", "cifrador.qsf", "pins_de10_lite.qsf", "cifrador.sdc", "relatorios.tcl"):
    origem = RAIZ / "quartus" / nome
    if nome == "cifrador.qsf":
        texto = origem.read_text().replace("../rtl/", "../../../rtl/")
        texto = texto.replace("../build/quartus/output_files", "../output_files")
        (destino / nome).write_text(texto)
    else:
        shutil.copy2(origem, destino / nome)
print("Abra " + str(destino / "cifrador.qpf"))
