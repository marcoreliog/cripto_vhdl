# Cifrador e desafio de decifragem de 10 bits

Projeto didático em VHDL-2008, baseado nos arquivos de `cripto_vhdl.zip`.
O arquivo mestre `Criptografia.vhd` contém a entidade de topo **`Criptografia`**,
com botão, tick, switches, LED e displays, e o núcleo simulável `temp1`.
O núcleo `temp1` separa controlador e datapath e executa **exatamente três
operações, em qualquer ordem, com repetição permitida**. O acerto depende apenas
de recuperar o valor original. Esta cifra é didática e não serve para proteger dados.

A implementação anterior da árvore de trabalho foi removida conforme solicitado.
O ZIP original foi preservado, sem reempacotar nem sobrescrever. Seus operadores
`roller`, `XOR_cripto` e `permuter` mantêm as mesmas interfaces e conteúdos.
A lógica da FSM do ZIP foi mantida; foram acrescentados comentários, nomes
explícitos dos registradores, conexões por nome, interface lógica e verificação.
As ligações de `interface_logica.vhd` foram incorporadas a `Criptografia.vhd`;
a entidade e o arquivo `interface_logica` foram retirados. `botao.vhd` continua
separado. O núcleo `temp1` permanece no arquivo mestre para os testes diretos
das operações e dos 16 estados.

## Arquivos

| Arquivo | Função |
|---|---|
| `Criptografia.vhd` | Arquivo mestre: topo `Criptografia` e núcleo `temp1`, com todas as ligações |
| `controller.vhd` | FSM de 16 estados, cargas, MUXes e seleção das operações |
| `datapath.vhd` | `V_reg`, `K_reg`, `X_reg`, `C_reg`, contador, validade e acerto registrado |
| `registrador.vhd` | Registrador genérico, reset síncrono prioritário e enable de carga |
| `comparador.vhd` | Igualdade de vetores, largura genérica |
| `incrementador.vhd` | Soma um ao contador de dois bits |
| `xor.vhd` | Entidade `XOR_cripto`: XOR de dez bits |
| `roller.vhd` | ROL3 com `mode=1`; ROR3 com `mode=0` |
| `permuter.vhd` | Troca os cinco pares de bits vizinhos |
| `clock_div.vhd` | Pulso periódico `tick`, usado como enable, sem outro clock |
| `botao.vhd` | Dois flip-flops de sincronização, debounce e pulso de um ciclo por aperto |
| `hex7seg.vhd` | Decodificação hexadecimal em sete segmentos lógicos |
| `tb_criptografia.vhd` | Bancada de apresentação, com 44 pontos de conferência e esperas por tempo |
| `tb_interface.vhd` | Instancia o topo `Criptografia`; bounce, aperto longo, switches e displays |
| `tb_operadores.vhd` | 1.024 entradas, quatro chaves XOR e ambas as direções de rotação |
| `tb_sequencias.vhd` | Todas as 27 sequências de três operações e suas inversas |
| `testes/esperado_nucleo.json` | Valores e instantes esperados dos 44 pontos; números em decimal |
| `verificar_vcd.py` | Confere VCDs com modelo de referência, pontos fixos e cobertura |
| `simular.sh` | Compila, elabora, simula e executa a conferência automática |
| `fontes.txt` | Lista ordenada de implementação, compartilhada pela simulação e pelo Quartus |
| `quartus/Criptografia.qpf` / `.qsf` | Projeto básico com topo `Criptografia` e VHDL-2008; configuração física pendente |
| `quartus/fontes.tcl` | Importa os arquivos de `fontes.txt` no projeto do Quartus |
| `docs/arquitetura.md` | FSM completa, tabela do MUX e diagramas do datapath e do controle |
| `docs/verificacao.md` | Resultados executados e localização dos exemplos na forma de onda |
| `cripto_vhdl.zip` | Base original preservada |

`sim/` contém artefatos gerados e está no `.gitignore`. O histórico Git e os
metadados do ambiente não foram apagados.

O controlador mantém o estilo de dois processos do
[controlador da máquina de refrigerantes](https://github.com/marcoreliog/Laboratorio-de-Sistemas-Digitais/blob/master/controller.vhd):
um registra o estado em `rising_edge(clk)` e outro calcula as saídas e o próximo
estado. A espera pela soltura fica em `botao.vhd`, sem acrescentar estados à FSM
da cifra. O botão produz uma confirmação; ele não é usado como clock.

## Interface do núcleo `temp1`

| Sinal | Direção | Significado |
|---|---|---|
| `clk` | Entrada | Clock principal único |
| `reset` | Entrada | Síncrono, ativo em `1`; limpa registradores, validade, contador, LED e FSM |
| `confirmar` | Entrada | Pulso síncrono de **um ciclo**, já condicionado |
| `modo_decifrar` | Entrada | `0`: criar desafio; `1`: decifrar; lido só ao confirmar em S0 |
| `switches(9:0)` | Entrada | Original, chave ou palpite, lidos somente na confirmação do estado correspondente |
| `operacao(1:0)` | Entrada | Operação, lida somente na confirmação de S3 ou S9 |
| `valor_saida(9:0)` | Saída | `C_reg` em S0 com desafio válido; `X_reg` nos demais casos |
| `led_acerto` | Saída | Valor de `acerto_reg`, carregado em S14 e preservado em S15 |
| `estado(3:0)` | Saída | Número lógico do estado, de 0 a 15 |

| Operação | Código | Cifrar | Decifrar |
|---|---|---|---|
| Permutação P | `00` | Troca `9↔8`, `7↔6`, `5↔4`, `3↔2`, `1↔0` | Mesma P |
| Rotação | `01` | ROL3: `A(6 downto 0) & A(9 downto 7)` | ROR3: `A(2 downto 0) & A(9 downto 3)` |
| XOR | `10` | `X_reg xor K_reg` | Pede e confirma um novo palpite antes de cada XOR |
| Inválida | `11` | Permanece aguardando, sem alterar `X_reg` nem `n` | Mesmo comportamento |

Não existe máscara de operações usadas. Confirmar um palpite não incrementa
`n`: somente os estados que executam operações o incrementam. Quando `n=3`, o
encerramento tem prioridade sobre confirmação ou seleção.

## Uso com as dez switches

O topo `Criptografia` faz o seguinte mapeamento, sem exigir switches adicionais:

| Estado | Bits lidos ao confirmar |
|---|---|
| S0 `INIT` | `SW0`: `0` cifrar, `1` decifrar; `SW9:1` ignorados |
| S1 `INSERIR_VALOR` | `SW9:0`: valor original |
| S2 `INSERIR_CHAVE_C` | `SW9:0`: chave da cifragem |
| S3 / S9 `SELECIONAR_C/D` | `SW1:0`: código da operação; `SW9:2` ignorados |
| S12 `INSERIR_CHAVE_D` | `SW9:0`: novo palpite |
| S15 `RESULTADO` | Switches ignoradas; confirmação reinicia a tentativa |
| Estados automáticos | Switches ignoradas |

1. Aplique reset por pelo menos uma borda de subida. Em S0, coloque `SW0=0`
   e aperte e solte confirmar.
2. Em S1, ajuste as dez switches para o original e confirme. Em S2, ajuste
   a chave e confirme. A ordem é **original primeiro, chave depois**.
3. Em S3, escolha e confirme três operações. Pode repetir qualquer uma.
   Após a terceira, S7 guarda `X_reg` em `C_reg` e volta ao menu, preservando o desafio.
4. No menu, coloque `SW0=1` e confirme. Sem desafio válido, o sistema fica em S0.
   S8 restaura `C_reg` em `X_reg`, zera `n` e apaga o LED.
5. Em S9, escolha três operações. Cada escolha de XOR abre S12: ajuste as dez
   switches para o palpite e faça **outro aperto** para confirmá-lo.
6. Após três operações, S14 compara com o original; S15 mantém resultado e LED.
   Confirme em S15 para tentar novamente sobre o mesmo cifrado.
7. Para abandonar S15 e criar outro desafio, use reset. Em S0, iniciar nova
   cifragem já invalida o desafio anterior e limpa o LED.

Mantenha as switches estáveis **antes de apertar e até a confirmação ser
aceita**. Solte o botão por tempo suficiente para o filtro reconhecer a liberação
antes do próximo aperto. Mudar o modo fora do menu não altera a fase em andamento.

## Botão e displays do topo `Criptografia`

`botao_confirmar` é uma entrada assíncrona **lógica**, em que `1` significa
apertado. Há dois estágios de sincronização; a mudança de nível é aceita após
`AMOSTRAS_ESTAVEIS` amostras consecutivas. Só a transição filtrada de solto para
apertado gera um pulso; segurar o botão não repete confirmações. A liberação
também passa pelo filtro. A simulação não reproduz metastabilidade analógica.

Os genéricos `DIVISOR_TICK` e `AMOSTRAS_ESTAVEIS` são obrigatórios na integração.
Com frequência real `f_clk`, o intervalo entre amostras é
`DIVISOR_TICK / f_clk`; a janela nominal de filtro é esse intervalo multiplicado
por `AMOSTRAS_ESTAVEIS`, além da latência de sincronização e alinhamento.
Os valores `2` e `3` da bancada aceleram o teste e não são uma configuração de placa.
Todos os processos usam `rising_edge(clk)`; o tick é apenas um enable.

`reset` do topo é **síncrono, ativo em 1 e já condicionado**.
O adaptador físico deverá fornecer esse reset, incluindo o tratamento do botão
de reset, se existir. `botao.vhd` pode ser reutilizado para outros botões, com
inicialização e tick independentes do reset da aplicação. Antes do uso, é necessário
aplicar reset; não se pressupõe inicialização dos registradores na energização.

Os dígitos antes da decodificação são:

```vhdl
digito2 <= "00" & valor_saida(9 downto 8);
digito1 <= valor_saida(7 downto 4);
digito0 <= valor_saida(3 downto 0);
```

As portas `HEX2`, `HEX1` e `HEX0` já recebem a saída de `hex7seg`: sete bits na
ordem **gfedcba**, bit 0 = segmento a, com `1` significando segmento aceso.
`led_acerto=1` também é uma indicação lógica. Essas convenções não afirmam a
polaridade elétrica de uma placa específica.

## Simulação reproduzível

Dependências: GHDL com suporte a VHDL-2008 e Python 3 (sem pacotes adicionais).
Em Ubuntu/Debian, pode instalar o GHDL com `sudo apt-get install ghdl`.
GTKWave é opcional e só é necessário para a inspeção visual.

```sh
sh simular.sh
python3 verificar_vcd.py          # repete apenas a conferência dos VCDs existentes
gtkwave sim/criptografia.vcd
gtkwave sim/interface.vcd
```

O script compila na ordem das dependências, elabora quatro bancadas e termina
com quatro linhas `OK`. A ordem da implementação vem de `fontes.txt`; as bancadas
são acrescentadas apenas na simulação. A biblioteca de trabalho é recriada a cada
execução para não conservar entidades removidas. Falha de compilação, simulação, resultado ou cobertura
produz código de saída diferente de zero. O limite de 1 ms é uma proteção contra
simulação sem fim; o verificador exige que cada bancada tenha terminado.
São gerados `sim/criptografia.vcd`, `sim/interface.vcd`, `sim/operadores.vcd`,
`sim/sequencias.vcd` e `sim/resultados.json`.

Nesta sessão, o sistema não tinha GHDL. Pacotes oficiais do Ubuntu foram baixados
e extraídos localmente, sem instalação no sistema. A cópia em
`sim/ferramentas/ghdl/` permite executar `sh simular.sh` neste ambiente.
O script prioriza `GHDL` definido pelo usuário, depois o GHDL instalado e depois
essa cópia local. Ela é um artefato ignorado pelo Git, específico deste Linux;
em outra máquina ou após apagar `sim/`, instale o GHDL. Para escolher outro executável:

```sh
GHDL=/caminho/absoluto/para/ghdl sh simular.sh
```

No GTKWave, selecione representação hexadecimal para os dados. Observe:

- `tb_criptografia`: `clk`, `reset`, `confirmar`, `modo_decifrar`, `switches`,
  `operacao`, `estado`, `valor_saida`, `led_acerto`, `etapa`.
- `tb_criptografia.dut.dp`: `v_reg`, `k_reg`, `x_reg`, `c_reg`, `n`, `valido_reg`,
  `acerto_reg`, `prox_x` e `igual`.
- `tb_criptografia.dut`: `sel_x`, `ld_x`, `ld_c`, `inc_n`, `clr_n`, `fim_camadas`.
- `tb_interface.dut`: `tick`, `confirmar`; em `filtro`: `sinc_1`, `sinc_2`,
  `filtrado`, `contagem` e `pulso`.

Os testbenches usam processos, atribuições e `wait for`, sem `procedure`, `assert`,
`report`, `severity` ou `wait until`. A verificação automática fica no Python.
Em `tb_interface`, as etapas 13 e 14 mantêm o botão apertado depois de salvar
o original e mudam as switches para `003`: a FSM continua em S2, `K_reg=000`,
sem outra confirmação. Só depois de uma soltura filtrada e de um novo aperto
a etapa 6 chega a S3 com `K_reg=003`. Uma soltura curta também não rearma o botão.

## Exemplo completo

Valores nesta seção em hexadecimal, com três dígitos para representar dez bits.

| Fase | Entrada / operação | Valor de trabalho |
|---|---|---|
| Criar | Original `001`, depois chave `003` | `001` |
| Cifrar 1 | P (`00`) | `002` |
| Cifrar 2 | ROL3 (`01`) | `010` |
| Cifrar 3 | XOR (`10`) | `013`, salvo como cifrado |
| Tentar | Selecionar decifrar | Restaura `013` |
| Decifrar 1 | XOR (`10`), depois confirmar palpite `003` | `010` |
| Decifrar 2 | ROR3 (`01`) | `002` |
| Decifrar 3 | P (`00`) | `001`; LED aceso após S14 |

Outro ensaio: original `001`, chave `003`, três XOR produzem `002`.
Três palpites `000` deixam `002`, LED apagado. Confirmar em S15 restaura o
mesmo `002`; três palpites `003` recuperam `001`, LED aceso. Palpites
`000`, `000`, `003` também acertam: o circuito avalia a igualdade final,
sem verificar a estratégia da cifragem.

## Projeto Quartus e integração física pendente

Abra `quartus/Criptografia.qpf`. A revisão define `TOP_LEVEL_ENTITY Criptografia`
e VHDL-2008; `fontes.tcl` importa a mesma lista `fontes.txt` usada pelo GHDL,
sem testbenches. As opções seguem as referências de
[entidade principal](https://www.intel.com/programmable/technical-pdfs/683296.pdf)
e [versão de VHDL](https://docs.altera.com/r/docs/683296/25.3/quartus-prime-pro-edition-settings-file-reference-manual/vhdl_input_version).
Antes de compilar no Quartus, configure a FPGA e os genéricos `DIVISOR_TICK` e
`AMOSTRAS_ESTAVEIS` conforme o clock e a janela de debounce reais, além das
restrições físicas. Os genéricos não têm valores padrão de placa.

O ZIP não contém identificação de placa, diagramas, projeto do fabricante nem
restrições de pinos. As configurações antigas da árvore removida não foram
reutilizadas. O projeto Quartus contém a organização lógica; dispositivo, pinos,
polaridades e timing ainda precisam ser configurados. O ponto de partida para
essa integração é o topo `Criptografia`, em `Criptografia.vhd`.

Para gerar as restrições físicas e programar uma placa, faltam:

- Modelo e revisão da placa, identificação exata da FPGA e ferramenta de programação.
- Pino e frequência real do clock, tensão e padrão elétrico das entradas/saídas.
- Pinos e ordem das dez switches; pinos e polaridades dos botões de confirmar e reset.
- Forma de inicialização/reset da placa e condicionamento do reset físico.
- Pino e polaridade do LED de acerto.
- Pinos, ordem dos segmentos e polaridade dos displays; informar se são independentes
  ou multiplexados, e os sinais de habilitação de dígito quando necessários.

Com esses dados, o adaptador deve normalizar entradas, fornecer reset condicionado,
definir a janela de debounce, adaptar LED/segmentos e, se preciso, multiplexar os
displays. Depois é necessário configurar o dispositivo, definir o clock nas
restrições, sintetizar, verificar timing, gerar o arquivo de programação e testar
na placa. Essas etapas de ferramenta do fabricante e hardware **não foram realizadas**.
