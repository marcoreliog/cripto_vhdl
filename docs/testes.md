# Plano de testes e resultados

## Método e reprodução

Execute `make test` na raiz. `scripts/testar.py` analisa e elabora VHDL-2008,
executa oito simulações, gera VCD e chama `tests/verificar.py`. O leitor VCD
agrupa todas as mudanças de um mesmo instante antes de observar os sinais,
evitando comparar valores intermediários de ciclos delta.

Os testbenches usam processos, clock e `wait for`, sem procedures próprias,
`assert`, `report` ou `severity`. Estímulos mudam fora da borda de subida, salvo
a detecção do estado seguida de 2 ns de atraso no teste do reset físico. Clocks
param com o fim dos estímulos. Há um watchdog de 1 ms; os verificadores também
exigem o marcador de término, de modo que travar o top em uma espera não passa.

A referência Python usa inteiros limitados a 10 bits, máscaras e deslocamentos,
independentes das concatenações do RTL. Seu vetor conhecido é fixado explicitamente,
e os blocos têm testes sobre todos os valores, impedindo que erros inversos
correspondentes passem apenas por recuperar a mensagem. O decodificador é
comparado a uma referência geométrica de segmentos a..g, não às constantes do RTL.

O scoreboard do núcleo calcula estado e registradores a partir das entradas e
do estado esperado anterior. Ele não usa os enables ou resultados internos do
DUT para prever o próximo valor. O top é previsto a partir de KEY e SW físicos,
incluindo sincronizadores, filtro, evento, núcleo e codificação dos segmentos.
O teste isolado do controle confere também as saídas combinacionais entre bordas.

## Cobertura por testbench

| Banco / verificações | Cobertura exigida |
|---|---|
| tb_blocos | XOR, ROL3, P e ROR3 com 1.024 valores; 16 códigos de display |
| tb_controle | Todos os estados, confirmar=0/1 em cada um, todas as escolhas de S6, enables/seletores/LEDs, reset de cada estado |
| tb_datapath | Operações com todos os valores originais; seletores 0..7; cargas e retenções; cargas simultâneas X/C e C independente; prioridade do reset |
| tb_nucleo | Vetor conhecido completo, zeros/uns, alternados, dez bits isolados na mensagem e na chave, varredura de 1.024 mensagens e 1.024 chaves, esperas e resets |
| tb_condicionador, N=1 | Caso limite do parâmetro; sincronização e pulso por transição aceita |
| tb_condicionador, N=4 | Bounce na pressão/soltura, aperto longo, rearme, reset e sincronização de SW |
| tb_condicionador, N=7 | Mesmo ensaio com outro limiar de filtragem |
| tb_top, N=4 | Cinco transações físicas completas, 33 apertos aceitos, seis displays, dez LEDs e reset físico em S3 |

O núcleo recebe 1.051 vetores regulares: sete casos especiais, vinte casos de
bits isolados e uma varredura de 1.024 valores. O ensaio adicional de reset percorre
S0..S10; seu último percurso completa mais uma volta, totalizando **1.052**.
A varredura usa `K=(73*M+341) mod 1024`, que cobre todas as chaves porque 73 é
coprimo de 1024. Isso não é o produto cartesiano de todos os pares no DUT.
O produto cartesiano de 1.048.576 pares foi exercitado apenas na referência Python.

As verificações de núcleo/top comparam K, X e C ou a exibição esperada a cada
borda, incluindo:

1. Reset inicial e interrupção em cada estado; prioridade do reset sobre cargas.
2. Caminho exato S0→...→S10 e três ciclos para cada conjunto de camadas.
3. Intermediários conhecidos `0CC→266→334→338→334→266→0CC`.
4. S6 com SW0=1 sem confirmação, com SW0=0 e confirmação e sem ambos.
5. Confirmações ignoradas nas camadas e em S10; retenção após o final.
6. C preservado em todas as etapas inversas; saída C em S6..S9 e X em S10.
7. Switches alteradas depois de captura sem sobrescrever K ou X automaticamente.
8. Um único evento durante cada aperto mantido, filtragem de bounce e novo
   evento somente depois de uma soltura aceita.
9. Hexadecimal 000..3FF, dígito A para S10, DP/HEX4/HEX5 apagados e LEDs de fase.

N=1 aceita os pulsos de bounce de um ciclo: espera-se que produza mais eventos.
Esse caso verifica o limite do parâmetro, não a rejeição de ruído. Em N=4/7, os
três apertos válidos produzem exatamente três eventos, apesar dos bounces.

## Resultado executado em 27/10/2026

Ambiente: Ubuntu 22.04, Python 3.10, GHDL 1.0.0 (mcode, GNAT 10.3.1), Tcl 8.6.
Como GHDL não estava instalado, os pacotes oficiais Ubuntu `ghdl-mcode`,
`ghdl-common` e `libgnat-10` foram baixados e extraídos em `build/tools/ghdl/`,
sem instalação no sistema. Os intermediários e ferramentas não entram no ZIP.

| Verificação | Resultado observado |
|---|---|
| Análise/elaboração dos 15 RTL e seis TBs | Aprovada |
| tb_blocos | 1.024 valores por bloco e 16 dígitos aprovados |
| tb_controle | 144 bordas, 11 estados, resets dos 11 estados, 26 combinações observadas |
| tb_datapath | 17.412 bordas, oito seletores, 1.024 valores por operação aprovados |
| tb_nucleo | 26.363 bordas, 1.052 percursos, 1.051 pares distintos aprovados |
| tb_top | 1.321 bordas, cinco percursos completos, 33 eventos, 11 estados exibidos aprovados |
| tb_condicionador N=1 | 139 bordas, 11 eventos, conforme limiar de um ciclo |
| tb_condicionador N=4 | 139 bordas, três eventos, bounce rejeitado |
| tb_condicionador N=7 | 139 bordas, três eventos, bounce rejeitado |
| Referência Python | Vetor conhecido e 1.048.576 pares aprovados |
| Síntese genérica GHDL do top | Aprovada; netlist em build/sintese_ghdl.vhd |
| make check | 15 fontes, 71 pinos únicos e padrões I/O aprovados; QSF executado em Tcl |

O ZIP foi extraído em outro diretório, sob `/tmp`, e os comandos `make test`,
`make check` e `make preparar-quartus` foram executados novamente com sucesso,
utilizando apenas o executável/bibliotecas GHDL do workspace original. Os fontes,
testes e configurações vieram do ZIP. Também foram conferidos os links locais
da documentação e a existência dos quinze fontes e do SDC no QSF preparado.
O resumo da reprodução está em [reproducao_zip.json](reproducao_zip.json).

GHDL emitiu seis avisos `unhandled attribute "altera_attribute"` na síntese genérica,
um por sinal marcado para Quartus. O atributo é destinado ao reconhecimento de
sincronizadores na ferramenta física. Não houve erro de síntese genérica; esses
avisos não foram ocultados. O log está em `build/logs/sintese_ghdl.log`.

As evidências legíveis por máquina estão em [resultados.json](resultados.json) e
[conferencia.json](conferencia.json), snapshots da execução de entrega. Cada
`make test` reescreve `build/resultados.json` e cada `make check` reescreve
`build/conferencia.json`. O ZIP inclui essas evidências atuais e os logs pequenos,
além dos snapshots. Compare as datas ao reproduzir uma entrega.

## Inspeção de ondas

```bash
gtkwave build/ondas/tb_nucleo.vcd
gtkwave build/ondas/tb_top.vcd
```

No núcleo, adicione clk, reset, confirmar, switches, estado_codigo, chave_debug,
trabalho_debug e cifrado_debug. Use radix hexadecimal nos dados. Os primeiros
500 ns contêm o vetor conhecido. No top, observe KEY, SW, dut.confirmar,
dut.estado_codigo, HEX0..HEX5 e LEDR. As ondas foram exportadas e lidas pelo
verificador, mas a interface GTKWave não foi aberta: o programa não está instalado.

## Limites e pendências

Não foram executados Quartus, fitting ou TimeQuest: recursos, avisos físicos,
slack, Fmax, reconhecimento das cadeias e resolução dos nomes no SDC permanecem
pendentes. A conferência Tcl não substitui a interpretação do SDC contra um netlist.
Não se mediu consumo nem comportamento elétrico em placa. Simulação RTL não
modela metastabilidade analógica nem prova MTBF dos sincronizadores.
