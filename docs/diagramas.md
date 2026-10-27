# Diagramas do sistema

Os diagramas Mermaid podem ser visualizados em um leitor Markdown com suporte
a Mermaid. Os arquivos VHDL são a implementação; o RTL Viewer do Quartus após
compilação permite conferir o circuito elaborado.

## FSM de alto nível

```mermaid
stateDiagram-v2
    [*] --> S0: reset
    S0: S0 INICIO
    S1: S1 CARREGA_CHAVE
    S2: S2 CARREGA_VALOR
    S3: S3 CIFRA_XOR
    S4: S4 CIFRA_ROTACAO
    S5: S5 CIFRA_PERMUTACAO
    S6: S6 ESCOLHA
    S7: S7 DECIFRA_PERMUTACAO
    S8: S8 DECIFRA_ROTACAO
    S9: S9 DECIFRA_XOR
    S10: S10 FINAL
    S0 --> S0: confirmar=0
    S0 --> S1: confirmar=1
    S1 --> S1: confirmar=0
    S1 --> S2: confirmar=1 / ld_k
    S2 --> S2: confirmar=0
    S2 --> S3: confirmar=1 / ld_x, SW
    S3 --> S4: ld_x, XOR
    S4 --> S5: ld_x, ROL3
    S5 --> S6: ld_x e ld_c, P
    S6 --> S6: confirmar=0 ou SW0=0
    S6 --> S7: confirmar=1 e SW0=1
    S7 --> S8: ld_x, P
    S8 --> S9: ld_x, ROR3
    S9 --> S10: ld_x, XOR
    S10 --> S10: qualquer entrada
    note right of S0
        reset em qualquer estado leva a S0
        e zera K, X e C na borda seguinte.
    end note
```

As ações escritas nas setas são executadas na borda que muda o estado. O diagrama
omite as onze setas de reset para facilitar a leitura; todas elas existem.

## Sistema RTL

```mermaid
flowchart LR
    CLK["MAX10_CLK1_50: 1 bit"] --> E
    KEYS["KEY: 2 bits, ativos baixos"] --> E
    SW["SW: 10 bits"] --> E["condicionador_entradas\n2 FF por entrada + filtro + evento"]
    E -->|"reset: 1; confirmar: 1; SW0: 1"| UC["unidade_controle\nFSM S0..S10"]
    E -->|"switches: 10"| DP["datapath\nK, X, C: 10 bits cada"]
    UC -->|"ld_k, ld_x, ld_c: 1 cada\nsel_op: 3; sel_saida: 1"| DP
    UC -->|"estado: 4; status: 4"| EX["exibicao\n4 decodificadores hex"]
    DP -->|"valor_saida: 10"| EX
    EX --> HX["HEX0..5: 8 bits cada\nsegmentos/DP ativos baixos"]
    EX --> LD["LEDR: 10 bits\nativos altos"]
    CLK --> UC
    CLK --> DP
```

Reset interno também chega aos três registradores do datapath. O mesmo clock
alimenta todos os blocos sequenciais; as operações e os MUXes são combinacionais.

## Datapath detalhado

```mermaid
flowchart LR
    SW["switches 10"] --> K["K_reg 10\nenable ld_k"]
    SW -->|"000"| M["mux_operacao\n5 entradas de 10\nsel_op 3"]
    X["X_reg 10\nenable ld_x"] --> XOR["xor10"]
    K --> XOR
    X --> ROL["rotacao_esquerda3"]
    X --> P["permutacao_pares"]
    X --> ROR["rotacao_direita3"]
    XOR -->|"001: 10"| M
    ROL -->|"010: 10"| M
    P -->|"011: 10"| M
    ROR -->|"100: 10"| M
    X -->|"outros: atual 10"| M
    M -->|"proximo_valor 10"| X
    M -->|"proximo_valor 10"| C["C_reg 10\nenable ld_c"]
    X -->|"0: 10"| MS["mux_saida\nsel_saida 1"]
    C -->|"1: 10"| MS
    MS -->|"valor_saida 10"| EX["exibicao"]
```

`clk` e `reset` comuns aos três registradores foram omitidos das setas do datapath.
A realimentação de X passa obrigatoriamente por seu registrador. Em S5, `ld_x=ld_c=1`
captura a saída P no mesmo instante nos dois destinos; nas camadas inversas C retém.
