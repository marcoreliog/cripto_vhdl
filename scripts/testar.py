#!/usr/bin/env python3
"""Analise, elaboracao, simulacoes, scoreboards e sintese generica GHDL."""
import json
import subprocess
import sys
from datetime import datetime
from pathlib import Path
from zoneinfo import ZoneInfo

RAIZ = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(RAIZ))
from tests.verificar import verificar_tudo


def main():
    build = RAIZ / "build"
    for pasta in ("ghdl", "ondas", "logs"):
        (build / pasta).mkdir(parents=True, exist_ok=True)
    ghdl = ["bash", str(RAIZ / "scripts/ghdl.sh")]
    flags = ["--std=08", "--workdir=" + str(build / "ghdl")]

    def executar(argumentos, nome, saida=None):
        proc = subprocess.run(ghdl + argumentos, cwd=RAIZ, text=True, capture_output=True)
        (build / "logs" / (nome + ".log")).write_text(proc.stderr + ("" if saida else proc.stdout))
        if saida: saida.write_text(proc.stdout)
        if proc.returncode:
            raise RuntimeError(f"{nome} falhou:\n{proc.stdout[-4000:]}\n{proc.stderr[-4000:]}")
        return proc.stdout

    # Invalida resultados antigos antes de iniciar uma nova execucao.
    resultado = {"status": "em_execucao", "data": datetime.now(ZoneInfo("America/Sao_Paulo")).isoformat()}
    destino = build / "resultados.json"
    destino.write_text(json.dumps(resultado, indent=2) + "\n")
    try:
        resultado["ghdl"] = executar(["--version"], "versao").splitlines()[0]
        fontes = (RAIZ / "scripts/fontes.txt").read_text().split()
        bancos = sorted(str(p.relative_to(RAIZ)) for p in (RAIZ / "tb").glob("*.vhd"))
        executar(["-a", *flags, *fontes, *bancos], "analise")
        testes = [("tb_" + nome, None) for nome in ("blocos", "controle", "datapath", "nucleo", "top")]
        testes += [("tb_condicionador", n) for n in (1, 4, 7)]
        for banco, ciclos in testes:
            nome = banco + (f"_{ciclos}" if ciclos else "")
            executar(["-e", *flags, banco], nome + "_elaboracao")
            parametros = [f"-gCICLOS_TESTE={ciclos}"] if ciclos else []
            executar(["-r", *flags, banco, *parametros,
                      "--vcd=" + str(build / "ondas" / (nome + ".vcd")),
                      "--stop-time=1ms"], nome)
            print(f"Simulado: {nome}", flush=True)
        resultado["verificacoes"] = verificar_tudo(build / "ondas")
        executar(["--synth", *flags, "cifrador_de10_lite"], "sintese_ghdl", build / "sintese_ghdl.vhd")
        resultado["sintese_generica_ghdl"] = "aprovada; nao equivale a sintese/fitting/timing Quartus"
        resultado["status"] = "aprovado"
    except (OSError, RuntimeError, ValueError) as erro:
        resultado.update(status="falhou", erro=str(erro))
        print(str(erro), file=sys.stderr)
    destino.write_text(json.dumps(resultado, ensure_ascii=False, indent=2) + "\n")
    print(json.dumps(resultado, ensure_ascii=False, indent=2))
    return 0 if resultado["status"] == "aprovado" else 1


if __name__ == "__main__":
    sys.exit(main())
