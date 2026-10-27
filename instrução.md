# Projeto completo: cifrador didático de 10 bits em VHDL

Implemente integralmente o projeto descrito abaixo. Crie os arquivos de código, testes, documentação e configuração do Quartus no workspace. Faça as verificações disponíveis e corrija os problemas encontrados. Quero um projeto organizado, compreensível para um aluno de Laboratório de Sistemas Digitais e preparado para demonstração na DE10-Lite.

## 1. Contexto e requisitos acadêmicos

O projeto é um sistema RTL em VHDL para a placa FPGA DE10-Lite. Deve conter:

- Unidade de controle baseada em FSM, separada do datapath em entidades VHDL distintas.
- FSM com pelo menos oito estados funcionalmente distintos; a arquitetura definida abaixo tem onze estados.
- Datapath com submódulos identificáveis e pelo menos dois registradores. Neste projeto serão três registradores de 10 bits.
- Reset que inicialize registradores e FSM.
- Código RTL sintetizável.
- Testbenches da unidade de controle, do datapath e do sistema integrado.
- Uso simultâneo de displays de sete segmentos e LEDs para informações complementares.
- Projeto do Quartus, restrições temporais, documentação da arquitetura e instruções para programar a placa.

Se o enunciado original ou os desenhos da FSM e do datapath estiverem anexados, confira-os. O texto abaixo especifica a arquitetura e permite implementar o projeto mesmo sem as imagens. Leia também eventuais instruções do repositório antes de editar arquivos.

O circuito é uma cifra didática composta por operações reversíveis. Documente esse propósito e não apresente o algoritmo como seguro para proteger informações reais. Preserve as três operações e a sequência aqui definidas.

## 2. Interface e funcionamento

As dez switches são reutilizadas em momentos diferentes:

1. No estado S1, SW[9:0] representam a chave inteira, de 10 bits.
2. Depois de confirmar a chave, no estado S2, as mesmas switches representam o valor inteiro a cifrar, também de 10 bits.
3. Depois da cifragem, no estado S6, SW0 serve para escolher se o resultado será mantido ou decifrado.

Portanto, não divida as switches entre chave e mensagem e não reduza os dados para quatro bits. Existem dois carregamentos distintos de palavras de 10 bits.

Controles:

- KEY0: confirmar. Gere um único pulso de um ciclo por aperto do botão.
- KEY1: reset global.
- Em S6, SW0 = 0 mantém o resultado cifrado.
- Em S6, SW0 = 1 junto com um novo pulso de confirmação inicia a decifragem.
- Sem confirmação, o circuito permanece em S6, independentemente de SW0.
- Em S10, mantém o valor recuperado até um reset.

Use o clock de 50 MHz da placa. Confira as polaridades dos botões e dos displays na documentação oficial. A lógica interna pode usar reset ativo em nível alto, com a adaptação apropriada na interface física.

Use sincronização para as entradas externas. Faça debounce de KEY0 e detecção de um único evento por aperto. O usuário deve estabilizar as switches antes de confirmar. O condicionamento deve permitir testes rápidos por meio de parâmetros de simulação. Mantenha toda a lógica no clock principal, utilizando enables; botões e switches não podem atuar como clocks dos registradores.

## 3. Algoritmo exato: três camadas

Todas as operações trabalham com exatamente 10 bits. X representa o valor de trabalho e K a chave armazenada.

### Cifragem

1. XOR: X recebe X XOR K.
2. Rotação circular de três posições para a esquerda: X recebe ROL3(X).
3. Permutação: X recebe P(X), que troca os bits de cada par vizinho.

Definições:

```text
ROL3(X) = X(6 downto 0) concatenado com X(9 downto 7)

P(X):
entrada: b9 b8 | b7 b6 | b5 b4 | b3 b2 | b1 b0
saída:   b8 b9 | b6 b7 | b4 b5 | b2 b3 | b0 b1
```

As rotações são circulares e não descartam bits. P é uma operação combinacional, sem estado, e P(P(X)) = X.

### Decifragem

Desfaça as operações na ordem inversa:

1. X recebe P(X).
2. X recebe ROR3(X).
3. X recebe X XOR K.

```text
ROR3(X) = X(2 downto 0) concatenado com X(9 downto 3)
```

Não adicione rodadas extras ou outros algoritmos. Cada camada é executada uma vez.

### Vetor conhecido para validar a implementação

```text
K = 1010101010
Mensagem = 0011001100
Após XOR = 1001100110
Após ROL3 = 1100110100
Cifrado após P = 1100111000

Decifragem:
Após P = 1100110100
Após ROR3 = 1001100110
Após XOR = 0011001100
```

Use esse vetor para conferir o resultado e os valores intermediários.

## 4. FSM: preserve os onze estados

Use a seguinte numeração e comportamento:

| Estado | Nome | Ação e transição |
|---|---|---|
| S0 | INICIO | Estado após reset, com registradores zerados. Aguarda confirmar para ir a S1. |
| S1 | CARREGA_CHAVE | Aguarda confirmar. Nesse evento, captura SW[9:0] em K_reg e segue para S2. |
| S2 | CARREGA_VALOR | Aguarda confirmar. Nesse evento, captura SW[9:0] em X_reg e segue para S3. |
| S3 | CIFRA_XOR | Atualiza X_reg com X_reg XOR K_reg. Segue automaticamente para S4. |
| S4 | CIFRA_ROTACAO | Atualiza X_reg com ROL3(X_reg). Segue automaticamente para S5. |
| S5 | CIFRA_PERMUTACAO | Atualiza simultaneamente X_reg e C_reg com P(X_reg). Segue para S6. |
| S6 | ESCOLHA | Preserva X_reg e C_reg. Com SW0 = 1 e confirmar, vai para S7. Nos demais casos permanece. |
| S7 | DECIFRA_PERMUTACAO | Atualiza X_reg com P(X_reg). Segue automaticamente para S8. |
| S8 | DECIFRA_ROTACAO | Atualiza X_reg com ROR3(X_reg). Segue automaticamente para S9. |
| S9 | DECIFRA_XOR | Atualiza X_reg com X_reg XOR K_reg. Segue automaticamente para S10. |
| S10 | FINAL | Preserva o valor recuperado em X_reg e a cópia cifrada em C_reg. Permanece até reset. |

O reset funciona em qualquer estado. Confirmações em estados de cálculo ou em S10 são ignoradas. Cada estado de cálculo ocupa um ciclo; as alterações dos registradores são feitas na borda de subida.

A carga em S1 e S2 depende do pulso confirmar: não sobrescreva os registradores continuamente enquanto o usuário ajusta as switches. Documente adequadamente as saídas condicionais do controle; não classifique a FSM como Moore pura se os enables dependerem da confirmação.

## 5. Datapath: blocos e conexões

Registradores, todos de 10 bits e com reset para zero:

- K_reg: guarda a chave; carrega somente com ld_k.
- X_reg: guarda o valor de trabalho; carrega somente com ld_x.
- C_reg: preserva o cifrado; carrega somente com ld_c, em S5.

Blocos combinacionais:

- XOR de 10 bits, recebendo X_reg e K_reg.
- ROL3, recebendo X_reg.
- P, recebendo X_reg.
- ROR3, recebendo X_reg.
- MUX principal de cinco entradas, cada uma de 10 bits.
- MUX de saída de duas entradas de 10 bits.
- Decodificadores dos displays de sete segmentos.

Mapeamento do MUX principal, controlado por sel_op[2:0]:

```text
000: switches sincronizadas
001: X_reg XOR K_reg
010: ROL3(X_reg)
011: P(X_reg)
100: ROR3(X_reg)
```

A saída desse MUX alimenta as entradas D de X_reg e C_reg. Os enables determinam qual registrador carrega.

Importante: em S5, os dois registradores devem receber a saída P(X_reg) na mesma borda. C_reg não pode receber o valor antigo de X_reg, anterior à permutação. Durante a decifragem, ld_c permanece desativado.

K_reg recebe diretamente as switches sincronizadas, com enable próprio. A saída de X_reg retorna como entrada dos quatro blocos de operação. Essa realimentação passa pelo registrador; não crie ciclos combinacionais.

Para códigos não utilizados de sel_op, adote uma saída determinística, por exemplo o próprio X_reg. Use defaults completos na lógica combinacional para evitar latches.

O MUX de saída usa sel_saida:

- 0: X_reg.
- 1: C_reg.

Selecione C_reg em S6 a S9 e X_reg nos demais estados. As operações são de latência fixa; documente as interfaces reais sem inventar um sinal de término de cálculo que o datapath não precisa.

## 6. Displays e LEDs

- HEX2, HEX1 e HEX0 mostram o valor selecionado, em hexadecimal, de 000 até 3FF. Complete com zeros os dois bits superiores do dígito mais significativo.
- HEX3 mostra o código do estado: 0 até 9 e A para S10.
- HEX4 e HEX5 ficam apagados.
- LEDR0: aguardando entrada, em S0, S1 ou S2.
- LEDR1: processando, em S3 a S5 ou S7 a S9.
- LEDR2: resultado cifrado disponível para escolha, em S6.
- LEDR3: resultado decifrado disponível, em S10.
- Demais LEDs apagados.

Confira no manual o sentido dos segmentos e os níveis ativos dos displays. LEDs e displays devem funcionar simultaneamente. As etapas de cálculo são rápidas; os estados de espera e os resultados permanecem visíveis.

## 7. Organização e estilo do código

Use nomes claros em português, processos curtos e comentários úteis para estudo. Use ieee.std_logic_1164 e ieee.numeric_std quando necessário. Evite bibliotecas aritméticas não padronizadas e recursos avançados sem necessidade.

Separe pelo menos:

- Unidade de controle.
- Datapath.
- Blocos combinacionais principais, em módulos identificáveis.
- Núcleo que integra controle e datapath.
- Condicionamento das entradas.
- Decodificação dos displays.
- Top-level da DE10-Lite.

Nos registradores, utilize enables e rising_edge do clock principal. As atribuições de uma operação devem respeitar os valores anteriores à borda. Rotação e permutação são conexões combinacionais; não implemente essas operações como vários ciclos adicionais.

## 8. Testes e verificação

Crie testbenches separados para controle, datapath, núcleo integrado e condicionamento dos botões. Inclua também uma simulação do top-level com debounce reduzido por parâmetro.

Prefiro testbenches didáticos com processos, geração de clock e wait for. Evite procedures, assert, report e severity nos arquivos VHDL de teste. Para verificação automática, use um script Python que analise resultados exportados, como VCD ou arquivos de simulação, e compare com uma referência independente. Um gráfico de ondas sozinho não basta para declarar os testes aprovados.

Verifique, pelo menos:

1. Reset inicial e reset no meio da operação.
2. Todas as transições e enables da FSM, inclusive esperas e confirmações ignoradas.
3. O vetor conhecido e seus valores intermediários.
4. Mensagens e chaves zeradas, todos os bits em um, padrões alternados e bits isolados.
5. Recuperação da mensagem após cifrar e decifrar.
6. Permanência em S6 sem confirmação e com SW0 = 0.
7. SW0 = 1 sem confirmação não inicia a decifragem.
8. C_reg preservado durante a decifragem.
9. Alterar switches depois das capturas não modifica a chave ou a mensagem armazenada.
10. Botão mantido pressionado gera uma confirmação, não várias.
11. Bounce simulado e liberação do botão para permitir um novo aperto.
12. Exibição hexadecimal e indicações dos LEDs.

Faça a referência em Python com inteiros limitados a 10 bits. Use o vetor conhecido e testes dos blocos para evitar que dois erros correspondentes na cifragem e na decifragem passem despercebidos.

Forneça um comando simples para rodar os testes com GHDL e gere arquivos de ondas compatíveis com GTKWave. Execute os testes quando as ferramentas estiverem disponíveis e registre o resultado real.

## 9. Quartus e preparação para a placa

Crie os arquivos .qpf, .qsf e .sdc. Liste todos os módulos necessários na ordem e com caminhos corretos. Use uma configuração de VHDL compatível com as ferramentas utilizadas.

Consulte o manual ou os arquivos de referência oficiais da Terasic para identificar o dispositivo exato e os pinos da DE10-Lite. Faça as atribuições do clock, switches, botões, LEDs e displays com base nessa fonte, e registre a referência na documentação. Não invente pinos ou use o pinout de outra placa.

Crie a restrição do clock de 50 MHz, período de 20 ns. Trate sincronizadores e restrições de CDC com justificativa, sem mascarar indiscriminadamente os caminhos temporais. Se o Quartus estiver disponível, execute compilação e analise recursos, avisos e timing.

Se não houver ferramenta, acesso à documentação oficial ou placa física disponível, indique precisamente quais verificações ficaram pendentes. Não apresente síntese, análise temporal ou teste na placa como executados quando não foram. Um pinout pendente deve ficar explicitamente identificado na documentação e na configuração.

## 10. Arquivos e documentação de entrega

Organize o projeto em diretórios como:

```text
rtl/
tb/
tests/
scripts/
quartus/
docs/
README.md
```

Entregue também:

- Especificação funcional, com objetivo, entradas, saídas e sequência de uso.
- FSM de alto nível e especificação de baixo nível, com transições e sinais acionados.
- Diagrama RTL do sistema e datapath com submódulos, larguras de barramentos e sinais de controle identificados.
- Tabela dos sinais ld_k, ld_x, ld_c, sel_op e sel_saida por estado, incluindo condições de confirmação.
- Explicação dos módulos e do funcionamento de cada camada e de sua inversa.
- Plano de testes e resultados realmente obtidos.
- Instruções para simular, abrir no Quartus, compilar e programar a placa.
- Roteiro de demonstração na DE10-Lite, incluindo manter cifrado e depois decifrar.
- Explicação das limitações criptográficas do projeto.

Use placeholders para turma e nomes dos integrantes se esses dados não forem fornecidos. Mantenha intermediários de build separados das fontes. Prepare um comando para gerar o ZIP de entrega com os arquivos necessários, excluindo caches grandes.

## 11. Execução e resposta final

Faça as escolhas rotineiras necessárias para concluir a implementação e documente-as. Preserve a interface, os onze estados, as três camadas e os três registradores definidos aqui.

Ao concluir, apresente os arquivos principais, comandos para simulação e compilação, testes executados e pendências concretas. Inclua uma explicação curta que me permita entender e defender o projeto em uma arguição individual.