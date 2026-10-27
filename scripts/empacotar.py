#!/usr/bin/env python3
"""Entrega com fontes, configuracao, documentacao e evidencias pequenas."""
from pathlib import Path
from zipfile import ZipFile, ZIP_DEFLATED

RAIZ = Path(__file__).resolve().parents[1]
pastas = ("rtl", "tb", "tests", "scripts", "quartus", "docs")
arquivos = [RAIZ / nome for nome in ("README.md", "Makefile", ".gitignore", "instrução.md")]
for pasta in pastas:
    arquivos += [p for p in (RAIZ / pasta).rglob("*") if p.is_file()
                 and "__pycache__" not in p.parts
                 and p.suffix not in (".pyc", ".qws", ".qdf", ".smsg")
                 and not {"db", "incremental_db", "output_files"}.intersection(p.parts)]
evidencias = [RAIZ / "build/resultados.json", RAIZ / "build/conferencia.json"]
evidencias += list((RAIZ / "build/logs").glob("*.log"))
arquivos += [p for p in evidencias if p.exists()]
(RAIZ / "dist").mkdir(exist_ok=True)
destino = RAIZ / "dist/cifrador_vhdl_de10_lite.zip"
with ZipFile(destino, "w", ZIP_DEFLATED) as entrega:
    for arquivo in sorted(set(arquivos)):
        entrega.write(arquivo, "cifrador_vhdl/" + str(arquivo.relative_to(RAIZ)))
print(f"{destino} ({destino.stat().st_size} bytes; {len(set(arquivos))} arquivos)")
