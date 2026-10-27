# DE10-Lite, Quartus e restrições temporais

## Fonte do dispositivo, pinout e polaridades

Fonte técnica primária: **Terasic, DE10-Lite User Manual, edição de 5 de junho de
2020**, autoria Terasic. Foi consultada uma [cópia pública do manual no distribuidor
Mouser](https://www.mouser.com/datasheet/2/598/DE10-Lite_User_Manual-1100361.pdf).
A [página oficial de downloads da Terasic](https://www.terasic.com.tw/cgi-bin/page/archive.pl?CategoryNo=220&Language=English&No=1049&PartNo=4)
foi localizada, mas as tentativas de abertura direta expiraram. A transcrição
vem do manual identificado, não de outro modelo de placa. Consulta: 27/10/2026.
As figuras dos botões e dos segmentos também foram inspecionadas visualmente
em uma [segunda cópia da mesma edição Terasic, hospedada na UPC](https://digsys.upc.edu/csd/units/DE10_Lite/DE10-Lite_User_Manual.pdf).

Referências por página impressa (nesta edição coincidem com o índice PDF começando em zero):

| Item | Local do manual | Aplicação |
|---|---|---|
| FPGA | p. 5 | MAX 10 10M50DAF484C7G |
| Clock | p. 24, tabela 3-2 | MAX10_CLK1_50 em P11, 50 MHz |
| Botões | p. 25, tabela 3-3 e figuras 3-13/3-14 | KEY0=B8, KEY1=A7; pressionado=0 |
| Switches | p. 26, tabela 3-4 | Para cima=1, para baixo=0 |
| LEDs | p. 27, tabela 3-5 | Ativos altos |
| Displays | pp. 28–29, tabela 3-6 e figura 3-17 | Ânodo comum; segmentos/DP ativos baixos |

Todos os 71 pinos utilizados estão em [pinos_de10_lite.csv](pinos_de10_lite.csv).
`quartus/pins_de10_lite.qsf` contém as mesmas atribuições e os padrões elétricos:
`3.3-V LVTTL` e, para KEY, `3.3 V SCHMITT TRIGGER`. As listas dos barramentos
no QSF começam no índice zero. `make check` executa os loops Tcl e compara as
atribuições expandidas ao CSV, incluindo quantidade, unicidade e padrões I/O.

O pinout está documentado e conferido no manual. Sua aplicação no dispositivo
após fitting e o comportamento elétrico real ainda exigem Quartus e a placa.

## Preparação e compilação

1. Disponibilize Quartus Prime Lite/Standard com o pacote de dispositivos MAX 10.
   Inclua `quartus/bin` no PATH, com `quartus_sh`, `quartus_sta` e `quartus_pgm`.
2. Execute `make preparar-quartus`. O script copia QPF/QSF/SDC e Tcl para
   `build/quartus/projeto/` e ajusta somente os caminhos das fontes e do diretório
   de saída. As fontes continuam em `rtl/`.
3. Abra `build/quartus/projeto/cifrador.qpf`. Confira `cifrador_de10_lite` como
   top-level, VHDL-2008 e dispositivo `10M50DAF484C7G`.
4. Use Processing → Start Compilation ou `make quartus` na raiz.
5. Leia os avisos de síntese, o relatório de fitting e TimeQuest. Execute
   `make timing` para exportar relatórios em `build/quartus/relatorios/`.

O QSF lista as quinze fontes RTL na ordem do manifesto `scripts/fontes.txt`.
Nenhum testbench entra na síntese. O resultado esperado do fluxo físico é
`build/quartus/output_files/cifrador.sof`. Os bancos `db/` e `incremental_db/`
são criados dentro da cópia em `build/quartus/projeto/`. O QSF original também
pode ser aberto diretamente, mas nesse caso o Quartus pode criar bancos em
`quartus/`; eles são ignorados pelo empacotamento.

Não é fornecido um `.sof` pré-compilado, pois o Quartus não estava disponível
para gerar e conferir esse artefato neste ambiente.

## Clock, sincronização e CDC

`cifrador.sdc` cria `clock50` de **20,000 ns**, deriva a incerteza e aplica exceções
somente a caminhos assíncronos identificados:

| Origem | Destino da exceção | Razão |
|---|---|---|
| SW[9:0] | sw_meta[9:0] em u_entradas | Entrada manual sem fase definida |
| KEY0 | tecla_meta em u_entradas | Botão assíncrono antes do primeiro FF |
| KEY1 | reset_meta e reset_sync em u_entradas | Assertiva assíncrona do sincronizador de reset |

**Não** se cortam os caminhos `sw_meta→sw_sync`, `tecla_meta→tecla_sync`,
`reset_meta→reset_sync`, `reset_sync→lógica síncrona`, FSM→datapath ou a
realimentação X→operação→X/C. Estes precisam fechar timing a 50 MHz.

Os seis sinais dos sincronizadores têm o atributo Quartus
`SYNCHRONIZER_IDENTIFICATION FORCED_IF_ASYNCHRONOUS`. O SDC verifica se as
coleções encontram exatamente dez, um e dois registradores; falha explicitamente
se a hierarquia pós-síntese mudar. Os padrões incluem a instância `u_entradas`
para não atingirem registradores de outras entidades. Validar esses nomes
na primeira compilação é uma pendência concreta, já que GHDL não gera um netlist
TimeQuest.

SW é um barramento sincronizado bit a bit, sem protocolo de transferência atômica.
O protocolo humano de estabilizar switches antes da confirmação é obrigatório.
O atributo ajuda o reconhecimento/posicionamento da cadeia; não elimina a
probabilidade de metastabilidade. A liberação do reset é sincronizada e o núcleo
consome reset somente na borda do clock.

LEDR e HEX não possuem um receptor externo com clock. Em vez de inventar tempos
de setup de um receptor, o projeto impõe um orçamento explícito de assentamento
de saída de 20 ns e mínimo de 0 ns, via `set_max_delay`/`set_min_delay`. O tempo
de resposta visual humano não é usado como justificativa para cortar a lógica
interna. Os segmentos constantes apagados podem não formar caminhos analisáveis.

O uso de exceções específicas por origem/destino segue a orientação de
[restrições de CDC da Intel](https://www.intel.com/content/www/us/en/docs/programmable/683243/25-1/constraining-cdc-paths.html).
A opção do atributo é descrita em [Metastability Analysis, ajuda Altera](https://resources.altera.com/quartushelp/current/mapIdTopics/sth1413172172690.htm).
Essas fontes explicam os mecanismos; não substituem a validação do projeto
na edição Lite/Standard instalada.

Na primeira compilação, conferir:

- Clock de 50 MHz reconhecido e ausência de clocks originados de KEY/SW.
- Coleções do SDC não vazias e exceções atingindo apenas os destinos listados.
- Dois estágios preservados/reconhecidos por entrada no relatório de sincronizadores.
- Setup e hold da lógica síncrona; recovery/removal fora das exceções justificadas.
- Relatório de caminhos não restringidos, explicando entradas assíncronas e saídas
  constantes, sem deixar caminhos internos inadvertidamente descobertos.
- Ausência de latches e de múltiplos drivers, quantidade de recursos e avisos
  de pinos, configuração MAX 10 e padrões de I/O.

`make timing` exporta clock, setup, hold, recovery, removal, exceções e caminhos
não restringidos. Os relatórios de recursos/avisos são produzidos por `make quartus`.
Não foi declarado slack, Fmax, consumo ou número de LEs sem a ferramenta física.

## Programação via JTAG

Após uma compilação bem-sucedida, conecte o cabo à porta USB-Blaster da DE10-Lite
e disponibilize seu driver. Feche o Control Panel se ele estiver ocupando o cabo.

```bash
quartus_pgm -l
quartus_pgm -c 1 -m jtag -o 'p;build/quartus/output_files/cifrador.sof'
```

Selecione o cabo correto em vez de assumir que sempre seja o primeiro. Pela GUI:
Tools → Programmer → Hardware Setup → USB-Blaster → Auto Detect; selecione
o MAX 10, carregue o `.sof`, marque Program/Configure e clique Start. Isso segue
a sequência do manual, seção 3.1, pp. 17–22. Pressione KEY1 depois de programar.
Este procedimento JTAG carrega a configuração volátil; programação permanente
da flash requer um fluxo específico com `.pof`, que não foi executado.

## Estado real da preparação

Executados: consulta do manual, conferência de pinos e padrões, QSF avaliado em
Tcl, análise/elaboração/simulação e síntese genérica do top no GHDL.

Pendentes: execução real do Quartus e TimeQuest, revisão de recursos/avisos/slacks,
resolução dos nomes pós-síntese no SDC e programação/demonstração em placa.
O GHDL avisa que não interpreta `altera_attribute`; esse aviso é esperado no
check genérico e não comprova reconhecimento dos sincronizadores pelo Quartus.
