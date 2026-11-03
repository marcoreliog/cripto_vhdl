#!/bin/sh
set -eu
cd "$(dirname "$0")"
if [ -z "${GHDL:-}" ]; then
    if command -v ghdl >/dev/null 2>&1; then
        GHDL=ghdl
    elif [ -x sim/ferramentas/ghdl/bin/ghdl ]; then
        GHDL="$PWD/sim/ferramentas/ghdl/bin/ghdl"
    else
        GHDL=ghdl
    fi
fi
if ! command -v "$GHDL" >/dev/null 2>&1; then
    echo 'GHDL nao encontrado. Instale ghdl e execute novamente: sh simular.sh' >&2
    exit 127
fi
if ! command -v python3 >/dev/null 2>&1; then
    echo 'Python 3 nao encontrado; necessario para conferir o VCD.' >&2
    exit 127
fi
mkdir -p sim
cd sim
rm -f resultados.json
"$GHDL" -a --std=08 ../registrador.vhd ../comparador.vhd ../incrementador.vhd \
    ../roller.vhd ../xor.vhd ../permuter.vhd ../clock_div.vhd \
    ../datapath.vhd ../controller.vhd ../Criptografia.vhd \
    ../botao.vhd ../hex7seg.vhd ../interface_logica.vhd \
    ../tb_criptografia.vhd ../tb_interface.vhd ../tb_operadores.vhd ../tb_sequencias.vhd
for bancada in tb_criptografia tb_interface tb_operadores tb_sequencias; do
    echo "Simulando $bancada (VHDL-2008)..."
    "$GHDL" -e --std=08 "$bancada"
    case "$bancada" in
        tb_criptografia) onda=criptografia ;;
        tb_interface) onda=interface ;;
        tb_operadores) onda=operadores ;;
        tb_sequencias) onda=sequencias ;;
    esac
    "$GHDL" -r --std=08 "$bancada" --vcd="$onda.vcd" --assert-level=error --stop-time=1ms
done
cd ..
python3 verificar_vcd.py
