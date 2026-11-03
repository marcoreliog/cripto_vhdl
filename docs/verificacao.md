# Verificação executada em 03/11/2026

Comando executado na raiz: `sh simular.sh`.
GHDL 1.0.0 mcode (pacotes oficiais Ubuntu), VHDL-2008 e Python 3.10.12.
O GHDL foi extraído localmente; não foi instalado no sistema.

## Resultado

As quatro bancadas foram analisadas, elaboradas e simuladas. O verificador
externo terminou com código 0 e os seguintes resultados:

| Bancada | Conferência |
|---|---|
| Núcleo | 272 bordas de clock, 44 pontos fixos, todos os 16 estados |
| Interface | 287 bordas, 12 pontos fixos, oito apertos aceitos |
| Operadores | 8.192 combinações: 1.024 valores × quatro chaves × duas direções |
| Sequências | 1.162 bordas, todas as 27 sequências de três operações e recuperação pela inversa |

O script registra os números da execução corrente em `sim/resultados.json`.
A conferência acompanha estado, V, K, X, C, contador, validade, LED e exibição
após cada borda. Além do modelo por ciclo, 44 pontos com resultados fixos
constam em `testes/esperado_nucleo.json`. O verificador exige término e cobertura,
e reprova ondas incompletas. Os testbenches também passam por uma conferência
que rejeita as construções excluídas da apresentação.

## Cobertura dos requisitos

- Reset limpa e invalida o desafio; decifrar sem desafio fica em INIT.
- Original e chave são capturados só ao confirmar; modo fora do menu é ignorado.
- Seleção `11` nos dois seletores não altera valor ou contador.
- Três XOR: `001`, chave `003`, cifrado `002`.
- Tentativa com três palpites `000`: `002`, LED apagado, resultado estável.
- Nova tentativa com três palpites `003`: `001`, LED aceso e C preservado.
- Cada XOR pede um novo palpite e só executá-lo incrementa o contador.
- Palpites `000`, `000`, `003` também acertam, comprovando a regra de igualdade.
- Nova tentativa após acerto limpa o LED e restaura C.
- P → ROL3 → XOR produz `013`; XOR → ROR3 → P recupera `001`.
- Confirmação concorrente com n=3 nos dois seletores não causa quarta operação.
- A terceira camada já está em X antes de salvar C ou registrar a comparação.
- Nova cifragem invalida o desafio antigo ao sair do menu.
- Três P e três rotações são permitidos; todas as 27 sequências possíveis foram ensaiadas.
- Botão com oscilações na pressão e liberação, e aperto longo, gera um pulso por aperto.
- Dois estágios de sincronização, período do tick e largura do pulso são conferidos.
- A interface captura os dez bits, usa SW0 no menu e SW1:0 nos seletores.
- Displays conferidos em todos os instantes e todos os 16 dígitos testados no decodificador.
- P aplicada duas vezes e ROR3 após ROL3 restauram todas as 1.024 entradas.

## Pontos para a apresentação

Em `sim/criptografia.vcd`, `etapa` identifica os pontos abaixo. Use dados em hexadecimal.

| Etapa | Instante | Resultado esperado |
|---|---|---|
| 2 | 60 ns | Decifrar sem desafio: S0 |
| 9 | 310 ns | Operação inválida: S3, X=001, n=0 |
| 11 | 440 ns | Três XOR: S0, C=002, válido=1 |
| 16 | 630 ns | Aguarda confirmação do palpite em S12, n=0 |
| 21 | 860 ns | Tentativa errada: S15, X=002, LED=0 |
| 24 | 1.170 ns | Tentativa correta: S15, X=001, LED=1 |
| 26 | 1.270 ns | Nova tentativa: S9, X=002, n=0, LED=0 |
| 31 | 1.740 ns | Cifragem mista salva C=013 |
| 36 | 1.950 ns | S14: X=001, n=3, LED ainda 0 |
| 37 | 1.960 ns | S15: LED registrado em 1 |
| 41 | 2.290 ns | Nova cifragem invalida C anterior, S1 |
| 43 | 2.640 ns | Três ROR3 recuperam 201, LED=1 |

## Limites das verificações

Os VCDs foram conferidos por Python; GTKWave não estava instalado e não foi aberto.
As simulações digitais não verificam metastabilidade, bounce real ou requisitos
elétricos. Não foram executadas síntese do fabricante, análise de timing,
programação ou validação em FPGA. A placa não está identificada no material do ZIP.

SHA-256 do ZIP original antes e depois do trabalho:

```text
5483bdf2b6d948c754fb83e04709d83f5c877f7b9342611cecb1bc538c05e603
```

Os arquivos VHDL do ZIP foram comparados com os de mesmo nome da árvore anterior
antes da remoção. A implementação atual usa o conteúdo extraído do ZIP como base;
nenhum arquivo de lógica ou configuração física da implementação removida foi copiado.
