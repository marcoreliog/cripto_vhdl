#!/usr/bin/env python3
"""Confere arquivos e executa QSF em Tcl sem simular um compilador Quartus."""
import csv
import json
import re
import shutil
import subprocess
from pathlib import Path

RAIZ = Path(__file__).resolve().parents[1]


def exigir(condicao, mensagem):
    if not condicao:
        raise ValueError(mensagem)


def main():
    manifesto = (RAIZ / "scripts/fontes.txt").read_text().split()
    exigir(set(manifesto) == {str(p.relative_to(RAIZ)) for p in (RAIZ / "rtl").glob("*.vhd")},
           "Manifesto diverge das fontes RTL")
    for p in manifesto:
        exigir((RAIZ / p).is_file(), f"Fonte ausente: {p}")
    for p in (RAIZ / "tb").glob("*.vhd"):
        codigo = re.sub(r"--[^\n]*", "", p.read_text()).lower()
        exigir(not re.search(r"\b(procedure|assert|report|severity)\b", codigo), f"Estilo de teste: {p}")
    tcl = r'''
proc set_global_assignment {args} {puts [join [linsert $args 0 global] "\t"]}
proc set_location_assignment {pino opcao porta} {puts "pin\t$porta\t$pino"}
proc set_instance_assignment {opcao nome valor destino porta} {puts "io\t$porta\t$valor"}
source cifrador.qsf
'''
    proc = subprocess.run(["tclsh"], input=tcl, cwd=RAIZ / "quartus", text=True, capture_output=True)
    exigir(proc.returncode == 0 and not proc.stderr, "Falha Tcl QSF: " + proc.stderr)
    pinos, ios, globais, fontes = {}, {}, {}, []
    for linha in proc.stdout.splitlines():
        campos = linha.split("\t")
        if campos[0] == "pin":
            exigir(campos[1] not in pinos, f"Porta duplicada: {campos[1]}")
            pinos[campos[1]] = campos[2].removeprefix("PIN_")
        elif campos[0] == "io":
            ios[campos[1]] = campos[2]
        elif campos[0] == "global":
            globais[campos[2]] = campos[3]
            if campos[2] == "VHDL_FILE":
                fontes.append(str((RAIZ / "quartus" / campos[3]).resolve().relative_to(RAIZ)))
    with (RAIZ / "docs/pinos_de10_lite.csv").open() as arquivo:
        esperados = {r["porta"]: r["pino"] for r in csv.DictReader(arquivo)}
    exigir(pinos == esperados, "QSF diverge da transcricao das tabelas do manual")
    exigir(len(pinos) == len(set(pinos.values())) == 71, "Pinos ausentes ou compartilhados")
    exigir(fontes == manifesto, "Ordem/caminhos VHDL no QSF divergem do manifesto")
    exigir(globais["DEVICE"] == "10M50DAF484C7G", "Dispositivo incorreto")
    exigir(globais["TOP_LEVEL_ENTITY"] == "cifrador_de10_lite", "Top incorreto")
    exigir(globais["VHDL_INPUT_VERSION"] == "VHDL_2008", "Versao VHDL incorreta")
    for porta in pinos:
        esperado = "3.3 V SCHMITT TRIGGER" if porta.startswith("KEY[") else "3.3-V LVTTL"
        exigir(ios.get(porta) == esperado, f"Padrao eletrico {porta}")
    sdc = (RAIZ / "quartus/cifrador.sdc").read_text()
    exigir("-period 20.000" in sdc, "Clock 50 MHz ausente")
    exigir("set_clock_groups" not in sdc and "-from [all_registers]" not in sdc,
           "Revisar excecoes amplas")
    resultado = {"status": "aprovado", "fontes_rtl": len(fontes), "pinos": len(pinos),
                 "qsf_executado_em_tcl": True,
                 "quartus_sh_disponivel": shutil.which("quartus_sh") is not None,
                 "quartus_sta_disponivel": shutil.which("quartus_sta") is not None,
                 "limite": "Conferencia estrutural; SDC/netlist/fitting exigem Quartus."}
    (RAIZ / "build").mkdir(exist_ok=True)
    (RAIZ / "build/conferencia.json").write_text(json.dumps(resultado, ensure_ascii=False, indent=2) + "\n")
    print(json.dumps(resultado, ensure_ascii=False, indent=2))


if __name__ == "__main__":
    main()
