#!/usr/bin/env python3
"""Remove somente artefatos conhecidos; preserva ferramentas locais baixadas."""
from pathlib import Path
import shutil

RAIZ = Path(__file__).resolve().parents[1]
for nome in ("ghdl", "ondas", "logs", "quartus"):
    shutil.rmtree(RAIZ / "build" / nome, ignore_errors=True)
for nome in ("resultados.json", "conferencia.json", "sintese_ghdl.vhd"):
    (RAIZ / "build" / nome).unlink(missing_ok=True)
for pasta in ("tests", "scripts"):
    shutil.rmtree(RAIZ / pasta / "__pycache__", ignore_errors=True)
print("Artefatos removidos. build/tools/ foi preservado.")
