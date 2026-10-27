# Cifrador didático de 10 bits — DE10-Lite

**Turma:** [PREENCHER] · **Integrantes:** [PREENCHER] · **Disciplina:** Laboratório de Sistemas Digitais

Projeto RTL em VHDL-2008 com FSM de onze estados, controle e datapath separados,
três registradores de 10 bits, condicionamento de entradas e exibição simultânea
em LEDs e displays. A cifra serve ao estudo de circuitos sequenciais; não oferece
segurança para dados reais.

## Começar

Requisitos para verificação: Python 3.10+, GHDL com VHDL-2008 e síntese genérica,
GNU Make e Tcl (`tclsh`, para conferir o QSF). GTKWave é opcional. Em Ubuntu,
os pacotes são `ghdl`, `make`, `tcl` e, opcionalmente, `gtkwave`.

Na raiz do projeto:

```bash
make test                   # 8 simulações, comparação automática e síntese GHDL
make check                  # manifesto, estilo dos TBs, QSF, 71 pinos e padrões I/O
gtkwave build/ondas/tb_nucleo.vcd
gtkwave build/ondas/tb_top.vcd
make zip                    # dist/cifrador_vhdl_de10_lite.zip
```

`make test` retorna código diferente de zero se houver falha. Os resultados
ficam em `build/resultados.json`, os logs em `build/logs/` e as ondas VCD em
`build/ondas/`. Os testes não exigem pacotes Python externos. É possível usar
`GHDL=/caminho/para/ghdl make test`. Neste workspace, o script também reconhece
o GHDL extraído localmente em `build/tools/ghdl/`; essa ferramenta não integra o ZIP.

## Usar a placa

Clock único: `MAX10_CLK1_50`, 50 MHz. `KEY0` confirma; `KEY1` reinicia. Os botões
são ativos baixos. Solte KEY0 por pelo menos 10 ms entre apertos; mantenha cada
aperto por mais de 10 ms. Estabilize as switches antes de confirmar, por exemplo
aguardando 20 ms depois de ajustá-las.

1. Pressione e solte KEY1. HEX3 mostra `0`, HEX2..0 mostram `000`, LEDR0 acende.
2. Pressione e solte KEY0: chega a S1, código `1`.
3. Coloque a chave **inteira de 10 bits** em SW9..SW0 e confirme: chega a S2.
4. Coloque a mensagem **inteira de 10 bits** nas mesmas switches e confirme.
5. O cálculo ocupa três ciclos de 20 ns. Em S6, HEX3 mostra `6`, HEX2..0 mostram
   o cifrado e LEDR2 acende. SW0=0 mantém esse resultado, mesmo confirmando.
6. Para decifrar, coloque SW0=1 e faça um novo aperto de KEY0. Depois de S7..S9,
   S10 mostra código `A`, mensagem recuperada e LEDR3 aceso. Apenas reset sai de S10.

Vetor de demonstração: chave `1010101010` (`2AA`), mensagem `0011001100` (`0CC`),
cifrado `1100111000` (`338`). A volta recupera `0CC`.

HEX2..0 exibem o valor em hexadecimal de `000` até `3FF`; HEX3 mostra o estado;
HEX4 e HEX5 e todos os pontos decimais permanecem apagados. LEDR0 indica entrada,
LEDR1 cálculo, LEDR2 escolha e LEDR3 final; LEDR9..4 ficam apagados.

## Quartus e programação

Instale Quartus Prime Lite/Standard com suporte ao MAX 10 e USB-Blaster. Dispositivo
configurado: **10M50DAF484C7G**. O pinout foi conferido no manual da Terasic;
consulte [fontes e CDC](docs/placa_e_timing.md).

```bash
make preparar-quartus
# Abra build/quartus/projeto/cifrador.qpf na GUI, ou:
make quartus
make timing
quartus_pgm -l
quartus_pgm -c 1 -m jtag -o 'p;build/quartus/output_files/cifrador.sof'
```

Ajuste `-c 1` ao cabo listado. O último comando configura a FPGA via JTAG;
o projeto não inclui um fluxo de gravação permanente da flash.
O procedimento completo está em [compilação e placa](docs/placa_e_timing.md).
Os bancos de compilação ficam em `build/quartus/projeto/`, separados das fontes.
`quartus/cifrador.qpf` também é válido para abertura direta, mas a cópia preparada
é recomendada para manter todos os intermediários em `build/`.

## Arquivos

| Local | Conteúdo |
|---|---|
| `rtl/unidade_controle.vhd` | FSM S0..S10, enables, seletores e LEDs |
| `rtl/datapath.vhd` | K, X, C e instâncias dos blocos combinacionais |
| `rtl/nucleo_cifrador.vhd` | Integração controle/datapath, sem condicionamento |
| `rtl/condicionador_entradas.vhd` | Sincronizadores, reset e debounce parametrizado |
| `rtl/cifrador_de10_lite.vhd` | Interface física da placa |
| `rtl/decodificador_hex.vhd`, `rtl/exibicao.vhd` | Segmentos ativos baixos e LEDs |
| `tb/`, `tests/` | Estímulos VHDL e referências/verificadores Python |
| `quartus/` | QPF, QSF, pinout, SDC e relatórios TimeQuest |
| `scripts/` | Simulação, conferência, preparação, limpeza e ZIP |
| `docs/` | Especificação, diagramas, testes e roteiro de defesa |

Documentos: [especificação e FSM](docs/arquitetura.md),
[diagramas RTL](docs/diagramas.md), [verificação e resultados](docs/testes.md),
[demonstração e arguição](docs/demonstracao.md).
O arquivo original do workspace, `instrução.md`, foi preservado; coincide com o
documento de especificação fornecido. Não foram encontrados desenhos adicionais.

## Verificações executadas e pendências

Em 27/10/2026, GHDL 1.0.0: oito simulações e síntese genérica aprovadas.
O núcleo completou 1.052 percursos com 1.051 pares distintos; cada bloco recebeu
todos os 1.024 valores. A referência Python verificou separadamente 1.048.576 pares.
A conferência do QSF em Tcl aprovou as 15 fontes e os 71 pinos.
Os detalhes e as limitações de cobertura estão em [testes](docs/testes.md).

**Pendências concretas:** Quartus não está disponível: faltam síntese para MAX 10,
fitting, confirmação dos nomes de nós no SDC, recursos, avisos e fechamento temporal.
Não há placa física conectada/verificada: faltam programação e demonstração elétrica.
GTKWave não está instalado neste ambiente; as ondas foram geradas e lidas em Python.

Para defender o projeto: a FSM escolhe uma operação por ciclo e controla os enables;
o datapath guarda a chave, transforma X e preserva uma cópia cifrada em C. XOR é
desfeito pelo mesmo XOR, P por P e ROL3 por ROR3, em ordem inversa. Em S5, X e C
recebem o resultado permutado simultaneamente. O botão é uma entrada sincronizada,
filtrada e convertida em um evento; todos os registradores usam o clock de 50 MHz.
