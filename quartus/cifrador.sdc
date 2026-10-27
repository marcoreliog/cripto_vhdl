create_clock -name clock50 -period 20.000 [get_ports {MAX10_CLK1_50}]
derive_clock_uncertainty

# As entradas manuais nao tem relacao de fase com clock50.
# Corte SOMENTE pino -> primeiro estagio. meta -> sync continua temporizado.
set sw_primeiro [get_registers {*u_entradas|sw_meta*}]
set tecla_primeiro [get_registers {*u_entradas|tecla_meta}]
set reset_estagios [get_registers {*u_entradas|reset_meta *u_entradas|reset_sync}]

# Erro explicito em vez de aceitar silenciosamente restricoes sem destino.
if {[get_collection_size $sw_primeiro] != 10} {
    error "CDC: esperado sw_meta de 10 bits; confira nomes no netlist."
}
if {[get_collection_size $tecla_primeiro] != 1} {
    error "CDC: esperado um tecla_meta; confira nomes no netlist."
}
if {[get_collection_size $reset_estagios] != 2} {
    error "CDC: esperados reset_meta e reset_sync; confira nomes no netlist."
}
set_false_path -from [get_ports {SW[*]}] -to $sw_primeiro
set_false_path -from [get_ports {KEY[0]}] -to $tecla_primeiro
# KEY1 chega apenas aos clears/presets assincronos do sincronizador de reset.
# A soltura propagada por reset_sync e os resets SINCRONOS ficam temporizados.
set_false_path -from [get_ports {KEY[1]}] -to $reset_estagios

# LEDs/displays nao possuem receptor sincrono externo. Orçamento de projeto:
# caminhos de saida devem assentar em ate 20 ns, sem inventar clock receptor.
set saidas_visuais [get_ports {LEDR[*] HEX0[*] HEX1[*] HEX2[*] HEX3[*] HEX4[*] HEX5[*]}]
set_max_delay 20.000 -to $saidas_visuais
set_min_delay 0.000 -to $saidas_visuais
