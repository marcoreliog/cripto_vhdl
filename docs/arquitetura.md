# Especificação funcional e implementação RTL

Turma: [PREENCHER]. Integrantes: [PREENCHER].

## Objetivo e interface

Implementar uma cifra reversível de 10 bits para exercitar FSM, registradores,
MUXes, operações combinacionais e uma interface humana na DE10-Lite.

| Porta física | Direção/largura | Função |
|---|---|---|
| MAX10_CLK1_50 | entrada, 1 | Clock de 50 MHz, borda de subida |
| KEY | entrada, 2 | KEY0 confirmar e KEY1 reset, ambos ativos baixos |
| SW | entrada, 10 | Palavra completa: chave em S1, mensagem em S2, escolha em S6 |
| LEDR | saída, 10 | Quatro indicações de estado ativas altas, demais zero |
| HEX0..HEX5 | saída, 8 cada | Sete segmentos e DP ativos baixos |

O núcleo recebe `clk`, `reset` síncrono ativo alto, `confirmar` de um ciclo e
`switches[9:0]` já sincronizadas. Produz `valor_saida[9:0]`, `estado_codigo[3:0]`,
`leds_status[3:0]` e três saídas de observação dos registradores. Estas últimas
ficam abertas no top-level, sem ocupar pinos. A interface não possui `done`:
as operações têm latência fixa e o estado informa a fase corrente.

## Operações

Todos os operandos e resultados têm dez bits; não há extensão de mensagem ou chave.

| Camada | Operação de cifragem | Inversa |
|---|---|---|
| XOR | X XOR K | X XOR K |
| Rotação | X(6..0) & X(9..7), circular à esquerda por 3 | X(2..0) & X(9..3), circular à direita por 3 |
| Permutação P | Troca b9/b8, b7/b6, b5/b4, b3/b2, b1/b0 | A mesma P |

`C = P(ROL3(M XOR K))` e `M = ROR3(P(C)) XOR K`.
Não há rodadas adicionais. Rotação e P são ligações de fios; cada uma é selecionada
durante um estado, sem contador de deslocamentos nem clock derivado.

| Momento (depois da borda) | X binário | X hexadecimal | C hexadecimal |
|---|---|---|---|
| Captura de M, entrada em S3 | 0011001100 | 0CC | 000 |
| XOR, entrada em S4 | 1001100110 | 266 | 000 |
| ROL3, entrada em S5 | 1100110100 | 334 | 000 |
| P, entrada em S6 | 1100111000 | 338 | 338 |
| Entrada em S7 | 1100111000 | 338 | 338 |
| P, entrada em S8 | 1100110100 | 334 | 338 |
| ROR3, entrada em S9 | 1001100110 | 266 | 338 |
| XOR, entrada em S10 | 0011001100 | 0CC | 338 |

Chave deste vetor: K=`1010101010`=`2AA`.

## FSM de baixo nível

`c` significa pulso confirmar e `w` significa SW0 sincronizada.
Os sinais da tabela são combinacionais durante o estado. A ação acontece na
borda de saída desse estado, ao mesmo tempo que a FSM assume o próximo estado.
O reset tem prioridade sobre todos os enables.

| Estado / nome | ld_k | ld_x | ld_c | sel_op | sel_saida | Próximo estado |
|---|---:|---:|---:|---|---:|---|
| S0 INICIO | 0 | 0 | 0 | 000 | 0 | c=1: S1; senão S0 |
| S1 CARREGA_CHAVE | c | 0 | 0 | 000 | 0 | c=1: S2; senão S1 |
| S2 CARREGA_VALOR | 0 | c | 0 | 000 | 0 | c=1: S3; senão S2 |
| S3 CIFRA_XOR | 0 | 1 | 0 | 001 | 0 | S4 |
| S4 CIFRA_ROTACAO | 0 | 1 | 0 | 010 | 0 | S5 |
| S5 CIFRA_PERMUTACAO | 0 | 1 | 1 | 011 | 0 | S6 |
| S6 ESCOLHA | 0 | 0 | 0 | 000 | 1 | c=1 e w=1: S7; senão S6 |
| S7 DECIFRA_PERMUTACAO | 0 | 1 | 0 | 011 | 1 | S8 |
| S8 DECIFRA_ROTACAO | 0 | 1 | 0 | 100 | 1 | S9 |
| S9 DECIFRA_XOR | 0 | 1 | 0 | 001 | 1 | S10 |
| S10 FINAL | 0 | 0 | 0 | 000 | 0 | S10 |

Os estados de cálculo ignoram confirmar e w. S10 também os ignora. Em S6,
as combinações (c,w)=(0,0), (0,1) e (1,0) preservam o cifrado; somente (1,1)
inicia a volta. Não há retorno a S1 sem reset.

As saídas `ld_k` e `ld_x` em S1 e S2 dependem de uma entrada: trata-se de uma
FSM com saídas condicionais do tipo Mealy, com as demais saídas dependentes do
estado. Não é uma máquina Moore pura. A codificação exposta é 0..10, mas o
Quartus pode recodificar o armazenamento interno da FSM para otimizar a FPGA.

Ao resetar, a próxima borda zera K, X e C e leva a S0, em qualquer fase.
Sem reset, S0 apenas aguarda; os registradores não são sobrescritos enquanto se
ajustam as switches em S1/S2. Toda carga usa `rising_edge(clk)` e enable.

## Datapath

`K_reg`, `X_reg` e `C_reg` são três instâncias de `registrador10`. As entradas D
de X e C recebem `proximo_valor`, a mesma saída do MUX principal. Assim, em S5
ambos capturam P do **X anterior à borda**. C não recebe o X anterior sem P.
Durante S7..S9, `ld_c=0`, preservando o resultado cifrado.

K recebe diretamente as switches sincronizadas, condicionado a `ld_k`. X alimenta
XOR, ROL3, P e ROR3 e retorna pelo MUX e pelo registrador, sem laço combinacional.

| sel_op | Entrada selecionada |
|---|---|
| 000 | switches[9:0] |
| 001 | X XOR K |
| 010 | ROL3(X) |
| 011 | P(X) |
| 100 | ROR3(X) |
| 101, 110, 111 | X, retenção determinística mesmo se ld_x=1 |

O MUX de saída mostra X quando `sel_saida=0` e C quando `sel_saida=1`. Em S6..S9
a exibição permanece no cifrado, mesmo quando X muda. Ao chegar a S10, mostra X
recuperado. As saídas combinacionais possuem defaults completos; não se inferem
latches. Os códigos não usados do seletor são ensaiados separadamente no datapath.

## Módulos e responsabilidades

| Entidade | Responsabilidade |
|---|---|
| cifrador_pkg | Tipo palavra10 e constantes do seletor |
| xor10 | XOR combinacional de dez bits |
| rotacao_esquerda3 / rotacao_direita3 | Rotações circulares por fiação |
| permutacao_pares | Cinco trocas de vizinhos por fiação |
| mux_operacao / mux_saida | Seleção dos valores de entrada dos registradores e de exibição |
| registrador10 | Dez flip-flops com enable e reset síncrono prioritário |
| datapath | Interconexão dos blocos e dos três registradores |
| unidade_controle | FSM, transições, enables, seletores, estado e status |
| nucleo_cifrador | Controle + datapath, entradas já condicionadas |
| condicionador_entradas | Sincronização, adaptação do reset, debounce e evento |
| decodificador_hex | Dígito hexadecimal para DP/g/f/e/d/c/b/a ativos baixos |
| exibicao | Três dígitos de dado, um de estado, dois apagados e LEDs |
| cifrador_de10_lite | Conexão da placa ao condicionador, núcleo e exibição |

## Condicionamento e temporização funcional

SW e KEY0 atravessam dois flip-flops em série. Cada bit de SW tem sua própria
cadeia: isso reduz a propagação de metastabilidade, mas não torna atômica uma
palavra que esteja sendo alterada. O usuário deve estabilizar a palavra antes de
confirmar. Nenhum botão nem switch atua como clock.

KEY0 precisa permanecer diferente do nível aceito por `CICLOS_DEBOUNCE` amostras
consecutivas. O filtro reinicia a contagem quando retorna ao nível já aceito.
Somente a transição aceita de solto (1) para pressionado (0) emite `confirmar=1`
por um ciclo; a soltura também precisa passar pelo filtro para rearmar. Um aperto
mantido não repete eventos. Por padrão são 500.000 amostras, ou 10 ms. O núcleo
consome o evento na borda seguinte à emissão do pulso registrado.

Com parâmetro 1, o bloco mantém a sincronização e o evento único por transição,
mas não rejeita bounce com um ciclo de duração. Os ensaios com 4 e 7 ciclos
verificam a filtragem efetiva, e o top-level usa 4 para simular rapidamente.

KEY1 é ativo baixo e tem assertiva assíncrona somente nos dois flip-flops do
sincronizador de reset. Sua liberação passa por dois estágios. O reset interno
é aplicado de forma síncrona à FSM e aos registradores. Um aperto deve abranger
uma borda de clock; a ação humana é muito mais lenta que 20 ns. Se KEY0 estiver
pressionado ao sair do reset, poderá produzir um evento após a filtragem; para
iniciar manualmente em S0, solte KEY0 ao resetar.

A cifra exige três bordas após a captura da mensagem. A volta exige três bordas
de cálculo após a transição S6→S7. Esses estados são rápidos demais para inspeção
visual individual; S0/S1/S2/S6/S10 permanecem visíveis. O arquivo VCD permite
observar cada etapa sem alterar a FSM para retardá-la.

## Exibição

Segmentos: bit0=a (superior), 1=b, 2=c, 3=d, 4=e, 5=f, 6=g (central), 7=DP.
O display é de ânodo comum e um segmento acende com zero. HEX2 recebe `00 & X[9:8]`
ou `00 & C[9:8]`, garantindo a faixa 000..3FF. Dígitos B e D usam formas `b` e `d`.

| Estados | LEDR[3:0] | Informação |
|---|---|---|
| S0, S1, S2 | 0001 | Aguardando entrada |
| S3, S4, S5, S7, S8, S9 | 0010 | Processando |
| S6 | 0100 | Cifrado preservado e escolha disponível |
| S10 | 1000 | Mensagem recuperada |

LEDR[9:4]=0. HEX4/5 e DP de todos os displays ficam em 1, apagados.

## Limitações criptográficas

Há apenas 1.024 chaves e 1.024 mensagens possíveis. Rotação e P são permutações
fixas de bits, e XOR é linear. Um par conhecido M,C revela diretamente
`K = M XOR ROR3(P(C))`. A mesma entrada com a mesma chave sempre gera a mesma
saída; não há aleatoriedade nem autenticação. LEDs, displays e sinais de debug
também tornam os dados observáveis. Use o circuito apenas como demonstração RTL.
