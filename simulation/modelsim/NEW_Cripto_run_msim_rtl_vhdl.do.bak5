transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -2008 -work work {D:/User/Downloads/NEW_CRIPTO/cripto_vhdl/controller.vhd}

vcom -2008 -work work {D:/User/Downloads/NEW_CRIPTO/cripto_vhdl/tb_controller.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L fiftyfivenm -L rtl_work -L work -voptargs="+acc"  tb_controller

add wave *
view structure
view signals
run 500 ns
