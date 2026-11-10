# Especificação da controladora — Cifrador e desafio de decifragem de 10 bits

## Instrução para o Codex

Use este documento como referência para atualizar a controladora VHDL do projeto existente. Leia primeiro `controller.vhd`, `datapath.vhd`, `Criptografia.vhd` e os arquivos responsáveis pela confirmação e pelo display, conforme os nomes no repositório. A entidade de topo deve continuar sendo **`Criptografia`**. Preserve a pinagem da placa e reaproveite os blocos existentes de permutação, rotação, XOR, registradores e comparação. Adapte os sinais e componentes que ainda seguirem a FSM anterior.

**Regra principal: a quantidade de operações é livre.** Em cada fase, o usuário pode aplicar quantas operações quiser, em qualquer ordem, inclusive repetir a mesma operação seguidamente. O comando `00`, confirmado pelo usuário, é o que encerra a fase. Se for escolhido logo no início, a fase termina com zero operações. A terceira operação tem o mesmo comportamento de qualquer outra: volta para a seleção. Não há contador de camadas na lógica de transição, nem máscara de operações usadas.

## Entradas e dados do desafio

- Use as dez switches para inserir o valor original, a chave de cifragem e cada palpite. Capture os dez bits juntos na borda de clock que aceita a confirmação.
- No menu, use um bit de seleção: `0` para cifrar e `1` para decifrar. Nas duas telas de seleção de operação, use um campo de dois bits. Reaproveite o mapeamento físico do repositório; se ainda não existir, use `SW(0)` no menu e `SW(1 downto 0)` na seleção de operações.
- Em estados que aguardam o usuário, mudar as switches por si só não muda de estado nem grava dados. Cada comando exige um novo pulso de `confirmar`. Segurar o botão não pode executar várias operações, confirmar uma chave ou avançar por vários estados. Se a interface atual só entregar o nível do botão, adapte-a para produzir um pulso por aperto.

| Nome | Função |
|---|---|
| `V` | Valor original de 10 bits, usado como referência na comparação. |
| `X` | Valor de trabalho de 10 bits. Recebe o valor inicial e o resultado de cada operação. |
| `K` | Chave de 10 bits. Guarda a chave de cifragem em S3 e recebe um novo palpite em S11 sempre que for escolhido XOR na decifragem. |
| `C` | Cifrado de 10 bits. É gravado em S8 e preservado durante as tentativas. |
| `VAL` / `cifrado_valido` | Flag que indica se existe um cifrado salvo e pronto para tentar decifrar. |
| `igual` | Saída combinacional do comparador: vale 1 quando `X = V`. |
| `acerto` | Resultado registrado da comparação. É atualizado em S15 e mantido enquanto a FSM estiver em S16. |

## Estados e transições

As transições e as escritas nos registradores ocorrem nas bordas do clock. Nos estados de espera, sem confirmação, mantenha o estado e os dados. Nos estados de ação automática, execute a ação uma vez e avance na mesma borda que efetiva a escrita. O reset tem prioridade sobre os comandos do usuário.

### Reset, menu e cifragem

| Estado | Ação e próximo estado |
|---|---|
| **S0 — RESET** | O reset global leva a FSM para S0 a partir de qualquer estado e limpa `V`, `K`, `X`, `C`, `VAL` e `acerto`. Após liberar o reset, avance para S1. |
| **S1 — MENU** | Com `0` e confirmação, limpe `VAL` e `acerto` e vá para S2. Com `1` e confirmação, vá para S9 somente se `VAL = 1`; caso contrário, fique em S1. Voltar ao menu depois de salvar o cifrado preserva o desafio. |
| **S2 — INSERIR_VALOR** | Na confirmação, carregue `V ← SW` e `X ← SW` na mesma borda. Vá para S3. |
| **S3 — INSERIR_CHAVE_C** | Na confirmação, carregue `K ← SW`. Vá para S4. |
| **S4 — SELECIONAR_C** | Na confirmação, interprete o código conforme a tabela abaixo. |
| **S5 — PERMUTAR_C** | Faça `X ← P(X)`. Retorne automaticamente para S4. |
| **S6 — ROL_C** | Faça `X ← ROL3(X)`. Retorne automaticamente para S4. |
| **S7 — XOR_C** | Faça `X ← X xor K`, usando a chave gravada em S3. Retorne automaticamente para S4. |
| **S8 — SALVAR_CIFRADO** | Faça `C ← X` e `VAL ← 1`. Retorne automaticamente para S1. `C` recebe a saída registrada de `X`. |

### Decifragem e resultado

| Estado | Ação e próximo estado |
|---|---|
| **S9 — PREPARAR_TENTATIVA** | Faça `X ← C` e limpe `acerto`. Vá automaticamente para S10. Este estado deve ser usado sempre que uma tentativa começar, inclusive uma repetição. |
| **S10 — SELECIONAR_D** | Na confirmação, interprete o código conforme a tabela abaixo. |
| **S11 — INSERIR_CHAVE_D** | Aguarde um novo aperto do botão. Na confirmação, carregue `K ← SW` com o palpite. Vá para S12. |
| **S12 — XOR_D** | Faça `X ← X xor K`, usando o palpite gravado em S11. Retorne automaticamente para S10. |
| **S13 — ROR_D** | Faça `X ← ROR3(X)`. Retorne automaticamente para S10. |
| **S14 — PERMUTAR_D** | Faça `X ← P(X)`. Retorne automaticamente para S10. |
| **S15 — COMPARAR** | Grave `acerto ← igual`, onde `igual` indica `X = V`. Vá automaticamente para S16. |
| **S16 — RESULTADO** | Mostre **t** (representação de T no display) se `acerto = 1`, ou **F** se `acerto = 0`. Se houver LED de acerto, acenda somente quando `acerto = 1`. Mantenha o resultado até um comando de saída ou reset. Veja abaixo a pendência sobre os comandos de saída. |

### Códigos de seleção

| Código + novo pulso de confirmação | Em S4: cifragem | Em S10: decifragem |
|---|---|---|
| `00` | S8 — salva e volta ao menu | S15 — compara e mostra o resultado |
| `01` | S7 — XOR com a chave da cifragem | S11 → S12 — recebe um palpite novo e aplica XOR |
| `10` | S6 — ROL3 | S13 — ROR3 |
| `11` | S5 — permutação de vizinhos | S14 — permutação de vizinhos |

O pulso que seleciona `01` em S10 só leva a S11; ele não confirma o palpite. Mesmo em dois XOR consecutivos, o caminho é `S10 → S11 → S12 → S10` para cada operação. A pessoa pode inserir o mesmo palpite de novo.

### Saídas de S16: regra funcional e pendência de pinagem lógica

A opção **tentar novamente** deve ir para S9 e recomeçar com o mesmo `C` salvo. A opção **desistir/reset** deve limpar o desafio e retornar ao menu passando por S0. A tentativa nova não depende de o resultado anterior ter sido T ou F. Os códigos escritos ao lado de S16 no rascunho não estão legíveis o bastante para fixar o mapeamento. Se o projeto já tiver comandos de tentar novamente e desistir, reaproveite-os. Se faltar o mapeamento, mantenha o reset global funcionando em S16 e sinalize qual comando de nova tentativa falta definir; não atribua códigos a partir da foto.

## Interface da controladora com o datapath

Os nomes abaixo são referências. Adapte os sinais aos nomes do repositório quando o comportamento for equivalente. A FSM decide o que executar; o datapath calcula os resultados e grava os dados.

| Sinal | Quando ativar / para que serve |
|---|---|
| `ld_v` | Em S2, somente na confirmação. |
| `ld_k` | Em S3 e S11, somente na confirmação. |
| `ld_x` e `sel_x` | Em S2 confirmado, selecione `SW`; em S9, selecione `C`; nos estados de operação, selecione a saída de XOR, roller ou permuter conforme o estado. |
| `rot_mode` | Em S6, selecione ROL3 (`1`); em S13, selecione ROR3 (`0`), conforme a interface do módulo `roller`. |
| `ld_c` | Em S8, grave o valor registrado de `X` em `C`. |
| `set_valido` | Em S8, indica que o cifrado foi salvo. |
| `clr_valido` | Quando a nova cifragem é aceita em S1. O reset global também limpa a flag. |
| `ld_acerto` | Somente em S15, para registrar `igual`. |
| `clr_acerto` | Ao aceitar uma nova cifragem em S1 e ao preparar uma tentativa em S9. O reset global também limpa o resultado. |

- Se `sel_x` já usa o MUX de cinco entradas da versão anterior, mantenha o mapeamento: `000 = SW`, `001 = XOR`, `010 = roller`, `011 = permuter`, `100 = C`.
- Use `cifrado_valido` para decidir se S1 pode iniciar a decifragem. Encaminhe `igual` ao registro de acerto, diretamente ou pela interface já existente. O acerto é a igualdade entre **o resultado e o original**; não compare as chaves.
- Retire `fim_camadas`, `inc_n` e `clr_n` da interface da FSM se servirem apenas ao limite antigo. Remova o contador do datapath e as ligações do topo se tiverem ficado sem função. Atualize os testes que esperavam a saída automática após a terceira operação.
- O bloco `P(X)` troca os vizinhos 9↔8, 7↔6, 5↔4, 3↔2 e 1↔0; o mesmo bloco atende as duas fases. `ROL3` e `ROR3` são rotações circulares inversas. Use os blocos existentes.

## Indicação de estado no display

Use o display para identificar o estado e, em S16, mostrar **t/F**. Se o projeto usa um só dígito para o estado, S0 a S15 cabem em hexadecimal (`0` a `F`). Para distinguir S16 internamente, use o tipo enumerado da FSM, um código de estado com pelo menos 5 bits, ou um sinal separado de resultado junto ao código de 4 bits do display. Evite truncar o número 16 para quatro bits, o que o confundiria com S0. Em S16, priorize o caractere de resultado no decodificador.

## Verificação em simulação

1. **Reset e menu:** aplique reset de um estado diferente de S0, verifique a limpeza dos dados e confirme que a opção `1` não inicia decifragem sem um cifrado válido.
2. **Repetição e quantidade livre:** cifre com quatro XOR seguidos usando a mesma chave. Após cada operação, inclusive a terceira e a quarta, espere S4; só confirme `00` para salvar. Como quatro XOR com a mesma chave se cancelam, o cifrado deve ser igual ao original.
3. **Palpite por operação:** escolha XOR duas vezes seguidas em S10 e verifique que a FSM espera uma nova confirmação em S11 a cada escolha. Verifique que o pulso usado para escolher XOR não carrega `K`.
4. **Resultado e preservação:** confirme `00` em S10 e verifique que `acerto` só é registrado em S15, com **t** para `X = V` e **F** para `X ≠ V`. Confira que `C` e `V` ficam intactos durante a tentativa. Se houver comando de repetir, verifique que o caminho passa por S9 e restaura `X` a partir de `C`.
5. **Encerramento imediato:** confirme `00` logo ao chegar a S4 ou S10 e verifique que a fase encerra sem executar operações.
6. **Botão e switches:** altere as switches sem apertar o botão e confirme que os dados permanecem estáveis. Mantenha o botão pressionado e verifique que a ação não se repete.

Ao concluir, informe os arquivos alterados, as simulações executadas e qualquer comando de S16 que ainda dependa de definição.
