# Depois de make quartus: make timing. Requer banco de fitting existente.
project_open cifrador
create_timing_netlist
read_sdc
update_timing_netlist
file mkdir ../relatorios
report_clocks -file ../relatorios/clocks.txt
report_timing -setup -npaths 20 -file ../relatorios/setup.txt
report_timing -hold -npaths 20 -file ../relatorios/hold.txt
report_timing -recovery -npaths 20 -file ../relatorios/recovery.txt
report_timing -removal -npaths 20 -file ../relatorios/removal.txt
report_exceptions -file ../relatorios/excecoes.txt
report_ucp -file ../relatorios/nao_restritos.txt
delete_timing_netlist
project_close
