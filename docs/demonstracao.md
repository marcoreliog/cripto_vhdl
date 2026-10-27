# Roteiro de demonstração e arguição

## Preparação

Preencha turma/integrantes. Execute `make test`, `make check`, compile no Quartus,
revise os relatórios e programe o `.sof` como indicado em [placa e timing](placa_e_timing.md).
Após programar, solte KEY0 e pressione/solte KEY1. Faça apertos e solturas de
KEY0 mais longos que 10 ms. Ajuste as switches com calma antes de confirmar.

## Demonstração do vetor conhecido

| Passo | Ação | Observação esperada |
|---|---|---|
| 1 | Reset por KEY1 | HEX3=0, valor 000, LEDR0 aceso |
| 2 | Aperte e solte KEY0 | HEX3=1, aguarda chave |
| 3 | SW9..0=1010101010, confirme | HEX3=2; K capturado como 2AA |
| 4 | SW9..0=0011001100, confirme | Após cálculo, HEX3=6 e HEX2..0=338; LEDR2 aceso |
| 5 | Mantenha SW0=0, confirme | Permanece 6/338 |
| 6 | Mude SW0 para 1 sem confirmar | Continua 6/338 |
| 7 | Novo aperto de KEY0 | Depois da volta, HEX3=A e HEX2..0=0CC; LEDR3 aceso |
| 8 | Altere switches e confirme | Mantém A/0CC |
| 9 | Reset | Volta a 0/000 |

Para mostrar que um aperto não confirma duas fases, mantenha KEY0 pressionado
no passo 2 por um segundo: deve permanecer em S1 até soltar e pressionar novamente.
LEDR1 acende apenas durante poucos ciclos e normalmente não será percebido a olho.
Use as ondas para explicar os cálculos intermediários; não alongue esses estados.

## Segundo exemplo

Chave zero e mensagem `1111111111` (`3FF`) resultam em `3FF`. É um bom exemplo
da largura completa de 10 bits e do dígito mais significativo limitado a 0..3.
Uma chave de dez bits também pode ser capturada independentemente da mensagem:
as switches são reutilizadas em instantes distintos.

## Explicação oral curta

“O controle tem onze estados e comanda o datapath por enables e seletores.
Primeiro guardo a chave em K e a mensagem em X. Em três ciclos faço XOR com K,
rotação circular por três e troca dos bits vizinhos. Na última dessas bordas,
X e C recebem o mesmo resultado; C fica guardado durante toda a volta.
Ao confirmar a opção de decifrar, desfaço as operações na ordem inversa.
Os botões são sincronizados e filtrados; só um pulso de um ciclo chega ao
controle a cada aperto. Todos os registradores usam o mesmo clock de 50 MHz.”

## Pontos para responder individualmente

| Pergunta | Resposta técnica |
|---|---|
| Por que três registradores? | K preserva a chave, X é a realimentação do cálculo e C preserva o cifrado enquanto X é decifrado. |
| Por que C não captura X diretamente em S5? | Na mesma borda, X ainda representa o valor anterior; ambos precisam receber P(X), a saída comum do MUX. |
| Rotacionar perde bits? | Não. Os três bits superiores retornam às posições inferiores. ROR3 desfaz ROL3. |
| Por que repetir P desfaz P? | Cada par é trocado duas vezes, voltando à ordem original. |
| Por que inverter a ordem das camadas? | A última transformação aplicada precisa ser desfeita primeiro. |
| A FSM é Moore? | Tem saídas condicionais Mealy: os enables de carga em S1/S2 dependem de confirmar. |
| Onde está o término do datapath? | Não há handshake done: cada operação é combinacional e ocupa um estado de um ciclo. |
| Se apertar confirmar durante o cálculo? | A FSM segue a sequência automática; a confirmação é ignorada. |
| SW0=1 basta para decifrar? | Não: S6 exige simultaneamente um novo evento confirmar. |
| Por que dois FFs nas entradas? | Dão tempo de resolução à metastabilidade antes de usar o sinal na lógica. O barramento ainda precisa estar estabilizado. |
| Reset é assíncrono? | A assertiva física atua no sincronizador de reset; sua liberação é sincronizada. FSM e registradores têm reset síncrono prioritário. |
| Por que o LED de cálculo mal aparece? | São três ciclos de 20 ns por direção. Os resultados permanecem nos estados de espera/final. |
| É criptografia segura? | Há só 1.024 chaves; um par conhecido revela K. O objetivo é estudar RTL, não proteger informações. |
| O que foi comprovado? | Simulação com comparação automática e síntese genérica GHDL. Timing e funcionamento elétrico dependem do Quartus e da placa, ainda pendentes nesta entrega. |

## Entrega

```bash
make test
make check
make zip
```

O ZIP inclui fontes, testes, configuração, documentos e evidências pequenas.
Exclui executáveis baixados, ondas grandes, caches, bancos Quartus e bitstreams.
Após extrair em outro diretório, execute os mesmos comandos com GHDL instalado.
`make clean` remove os intermediários conhecidos e preserva `build/tools/`.
