#!/usr/bin/env bash
set -euo pipefail
raiz=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
if [[ -n ${GHDL:-} ]]; then
    exec "$GHDL" "$@"
elif command -v ghdl >/dev/null 2>&1; then
    exec ghdl "$@"
elif [[ -x "$raiz/build/tools/ghdl/usr/bin/ghdl-mcode" ]]; then
    prefixo="$raiz/build/tools/ghdl/usr"
    export LD_LIBRARY_PATH="$prefixo/lib/x86_64-linux-gnu${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
    export GHDL_PREFIX="$prefixo/lib/ghdl/mcode"
    exec "$prefixo/bin/ghdl-mcode" "$@"
else
    echo 'GHDL ausente. Instale ghdl, ou defina GHDL=/caminho/ghdl.' >&2
    exit 127
fi
