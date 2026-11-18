-- Copyright (C) 2018  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 18.1.0 Build 625 09/12/2018 SJ Lite Edition"

-- DATE "11/17/2026 23:36:04"

-- 
-- Device: Altera 10M50DAF484C7G Package FBGA484
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY FIFTYFIVENM;
LIBRARY IEEE;
USE FIFTYFIVENM.FIFTYFIVENM_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	hard_block IS
    PORT (
	devoe : IN std_logic;
	devclrn : IN std_logic;
	devpor : IN std_logic
	);
END hard_block;

-- Design Ports Information
-- ~ALTERA_TMS~	=>  Location: PIN_H2,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default
-- ~ALTERA_TCK~	=>  Location: PIN_G2,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default
-- ~ALTERA_TDI~	=>  Location: PIN_L4,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default
-- ~ALTERA_TDO~	=>  Location: PIN_M5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_CONFIG_SEL~	=>  Location: PIN_H10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_nCONFIG~	=>  Location: PIN_H9,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default
-- ~ALTERA_nSTATUS~	=>  Location: PIN_G9,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default
-- ~ALTERA_CONF_DONE~	=>  Location: PIN_F8,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default


ARCHITECTURE structure OF hard_block IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL \~ALTERA_TMS~~padout\ : std_logic;
SIGNAL \~ALTERA_TCK~~padout\ : std_logic;
SIGNAL \~ALTERA_TDI~~padout\ : std_logic;
SIGNAL \~ALTERA_CONFIG_SEL~~padout\ : std_logic;
SIGNAL \~ALTERA_nCONFIG~~padout\ : std_logic;
SIGNAL \~ALTERA_nSTATUS~~padout\ : std_logic;
SIGNAL \~ALTERA_CONF_DONE~~padout\ : std_logic;
SIGNAL \~ALTERA_TMS~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_TCK~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_TDI~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_CONFIG_SEL~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_nCONFIG~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_nSTATUS~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_CONF_DONE~~ibuf_o\ : std_logic;

BEGIN

ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
END structure;


LIBRARY ALTERA;
LIBRARY FIFTYFIVENM;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE FIFTYFIVENM.FIFTYFIVENM_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	controller IS
    PORT (
	enter : IN std_logic;
	clock : IN std_logic;
	modo : IN std_logic;
	equals : IN std_logic;
	existe_cripto : IN std_logic;
	reset : IN std_logic;
	op : IN std_logic_vector(1 DOWNTO 0);
	ld_x : BUFFER std_logic;
	ld_k : BUFFER std_logic;
	ld_v : BUFFER std_logic;
	ld_c : BUFFER std_logic;
	sel : BUFFER std_logic_vector(2 DOWNTO 0);
	rot_dir : BUFFER std_logic;
	clr : BUFFER std_logic;
	display : BUFFER std_logic_vector(3 DOWNTO 0)
	);
END controller;

-- Design Ports Information
-- equals	=>  Location: PIN_K15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ld_x	=>  Location: PIN_C11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ld_k	=>  Location: PIN_C12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ld_v	=>  Location: PIN_C10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ld_c	=>  Location: PIN_J11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- sel[0]	=>  Location: PIN_C9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- sel[1]	=>  Location: PIN_A11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- sel[2]	=>  Location: PIN_B8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- rot_dir	=>  Location: PIN_H12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clr	=>  Location: PIN_D12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- display[0]	=>  Location: PIN_A9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- display[1]	=>  Location: PIN_A10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- display[2]	=>  Location: PIN_A7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- display[3]	=>  Location: PIN_A12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- enter	=>  Location: PIN_B11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- modo	=>  Location: PIN_A8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- op[0]	=>  Location: PIN_B12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- op[1]	=>  Location: PIN_H13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clock	=>  Location: PIN_M8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reset	=>  Location: PIN_M9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- existe_cripto	=>  Location: PIN_B10,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF controller IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_enter : std_logic;
SIGNAL ww_clock : std_logic;
SIGNAL ww_modo : std_logic;
SIGNAL ww_equals : std_logic;
SIGNAL ww_existe_cripto : std_logic;
SIGNAL ww_reset : std_logic;
SIGNAL ww_op : std_logic_vector(1 DOWNTO 0);
SIGNAL ww_ld_x : std_logic;
SIGNAL ww_ld_k : std_logic;
SIGNAL ww_ld_v : std_logic;
SIGNAL ww_ld_c : std_logic;
SIGNAL ww_sel : std_logic_vector(2 DOWNTO 0);
SIGNAL ww_rot_dir : std_logic;
SIGNAL ww_clr : std_logic;
SIGNAL ww_display : std_logic_vector(3 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_ADC1~_CHSEL_bus\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_ADC2~_CHSEL_bus\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \reset~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \clock~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \equals~input_o\ : std_logic;
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \~QUARTUS_CREATED_UNVM~~busy\ : std_logic;
SIGNAL \~QUARTUS_CREATED_ADC1~~eoc\ : std_logic;
SIGNAL \~QUARTUS_CREATED_ADC2~~eoc\ : std_logic;
SIGNAL \ld_x~output_o\ : std_logic;
SIGNAL \ld_k~output_o\ : std_logic;
SIGNAL \ld_v~output_o\ : std_logic;
SIGNAL \ld_c~output_o\ : std_logic;
SIGNAL \sel[0]~output_o\ : std_logic;
SIGNAL \sel[1]~output_o\ : std_logic;
SIGNAL \sel[2]~output_o\ : std_logic;
SIGNAL \rot_dir~output_o\ : std_logic;
SIGNAL \clr~output_o\ : std_logic;
SIGNAL \display[0]~output_o\ : std_logic;
SIGNAL \display[1]~output_o\ : std_logic;
SIGNAL \display[2]~output_o\ : std_logic;
SIGNAL \display[3]~output_o\ : std_logic;
SIGNAL \clock~input_o\ : std_logic;
SIGNAL \clock~inputclkctrl_outclk\ : std_logic;
SIGNAL \enter~input_o\ : std_logic;
SIGNAL \op[1]~input_o\ : std_logic;
SIGNAL \op[0]~input_o\ : std_logic;
SIGNAL \Selector15~0_combout\ : std_logic;
SIGNAL \reset~input_o\ : std_logic;
SIGNAL \reset~inputclkctrl_outclk\ : std_logic;
SIGNAL \atual.PERM_D~q\ : std_logic;
SIGNAL \Selector11~0_combout\ : std_logic;
SIGNAL \atual.SEL_OP_D~q\ : std_logic;
SIGNAL \Selector12~0_combout\ : std_logic;
SIGNAL \Selector12~1_combout\ : std_logic;
SIGNAL \atual.TRY_K~q\ : std_logic;
SIGNAL \Selector13~0_combout\ : std_logic;
SIGNAL \atual.XOR_D~q\ : std_logic;
SIGNAL \modo~input_o\ : std_logic;
SIGNAL \existe_cripto~input_o\ : std_logic;
SIGNAL \Selector2~0_combout\ : std_logic;
SIGNAL \Selector16~0_combout\ : std_logic;
SIGNAL \Selector16~1_combout\ : std_logic;
SIGNAL \atual.RESULT~q\ : std_logic;
SIGNAL \Selector3~4_combout\ : std_logic;
SIGNAL \atual.INSERT_V~q\ : std_logic;
SIGNAL \atual.INSERT_K~q\ : std_logic;
SIGNAL \Selector6~0_combout\ : std_logic;
SIGNAL \Selector7~0_combout\ : std_logic;
SIGNAL \atual.ROL_C~q\ : std_logic;
SIGNAL \Selector8~0_combout\ : std_logic;
SIGNAL \atual.XOR_C~q\ : std_logic;
SIGNAL \Selector6~1_combout\ : std_logic;
SIGNAL \atual.PERM_C~q\ : std_logic;
SIGNAL \WideOr11~0_combout\ : std_logic;
SIGNAL \Selector5~0_combout\ : std_logic;
SIGNAL \atual.SEL_OP_C~q\ : std_logic;
SIGNAL \Selector9~0_combout\ : std_logic;
SIGNAL \atual.SAVE_C~q\ : std_logic;
SIGNAL \atual.INIT~feeder_combout\ : std_logic;
SIGNAL \atual.INIT~q\ : std_logic;
SIGNAL \WideOr12~0_combout\ : std_logic;
SIGNAL \Selector2~1_combout\ : std_logic;
SIGNAL \atual.MENU~q\ : std_logic;
SIGNAL \Selector10~0_combout\ : std_logic;
SIGNAL \WideOr12~1_combout\ : std_logic;
SIGNAL \Selector10~1_combout\ : std_logic;
SIGNAL \Selector10~2_combout\ : std_logic;
SIGNAL \atual.ATTEMPT_D~q\ : std_logic;
SIGNAL \Selector14~0_combout\ : std_logic;
SIGNAL \atual.ROR_D~q\ : std_logic;
SIGNAL \WideOr13~0_combout\ : std_logic;
SIGNAL \Selector17~0_combout\ : std_logic;
SIGNAL \Selector17~1_combout\ : std_logic;
SIGNAL \Selector18~0_combout\ : std_logic;
SIGNAL \WideOr9~0_combout\ : std_logic;
SIGNAL \WideOr8~0_combout\ : std_logic;
SIGNAL \Selector0~0_combout\ : std_logic;
SIGNAL \WideOr14~0_combout\ : std_logic;
SIGNAL \WideOr14~combout\ : std_logic;
SIGNAL \WideOr13~1_combout\ : std_logic;
SIGNAL \WideOr13~combout\ : std_logic;
SIGNAL \WideOr12~combout\ : std_logic;
SIGNAL \WideOr11~combout\ : std_logic;
SIGNAL \ALT_INV_enter~input_o\ : std_logic;
SIGNAL \ALT_INV_WideOr11~combout\ : std_logic;
SIGNAL \ALT_INV_WideOr12~combout\ : std_logic;
SIGNAL \ALT_INV_WideOr13~combout\ : std_logic;
SIGNAL \ALT_INV_WideOr14~combout\ : std_logic;

COMPONENT hard_block
    PORT (
	devoe : IN std_logic;
	devclrn : IN std_logic;
	devpor : IN std_logic);
END COMPONENT;

BEGIN

ww_enter <= enter;
ww_clock <= clock;
ww_modo <= modo;
ww_equals <= equals;
ww_existe_cripto <= existe_cripto;
ww_reset <= reset;
ww_op <= op;
ld_x <= ww_ld_x;
ld_k <= ww_ld_k;
ld_v <= ww_ld_v;
ld_c <= ww_ld_c;
sel <= ww_sel;
rot_dir <= ww_rot_dir;
clr <= ww_clr;
display <= ww_display;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\~QUARTUS_CREATED_ADC1~_CHSEL_bus\ <= (\~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\);

\~QUARTUS_CREATED_ADC2~_CHSEL_bus\ <= (\~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\);

\reset~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \reset~input_o\);

\clock~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \clock~input_o\);
\ALT_INV_enter~input_o\ <= NOT \enter~input_o\;
\ALT_INV_WideOr11~combout\ <= NOT \WideOr11~combout\;
\ALT_INV_WideOr12~combout\ <= NOT \WideOr12~combout\;
\ALT_INV_WideOr13~combout\ <= NOT \WideOr13~combout\;
\ALT_INV_WideOr14~combout\ <= NOT \WideOr14~combout\;
auto_generated_inst : hard_block
PORT MAP (
	devoe => ww_devoe,
	devclrn => ww_devclrn,
	devpor => ww_devpor);

-- Location: LCCOMB_X44_Y44_N20
\~QUARTUS_CREATED_GND~I\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \~QUARTUS_CREATED_GND~I_combout\ = GND

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	combout => \~QUARTUS_CREATED_GND~I_combout\);

-- Location: IOOBUF_X51_Y54_N23
\ld_x~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Selector17~1_combout\,
	devoe => ww_devoe,
	o => \ld_x~output_o\);

-- Location: IOOBUF_X54_Y54_N30
\ld_k~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Selector18~0_combout\,
	devoe => ww_devoe,
	o => \ld_k~output_o\);

-- Location: IOOBUF_X51_Y54_N30
\ld_v~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Selector17~0_combout\,
	devoe => ww_devoe,
	o => \ld_v~output_o\);

-- Location: IOOBUF_X49_Y54_N23
\ld_c~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \atual.SAVE_C~q\,
	devoe => ww_devoe,
	o => \ld_c~output_o\);

-- Location: IOOBUF_X46_Y54_N16
\sel[0]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \WideOr9~0_combout\,
	devoe => ww_devoe,
	o => \sel[0]~output_o\);

-- Location: IOOBUF_X51_Y54_N9
\sel[1]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \WideOr8~0_combout\,
	devoe => ww_devoe,
	o => \sel[1]~output_o\);

-- Location: IOOBUF_X46_Y54_N30
\sel[2]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \atual.ATTEMPT_D~q\,
	devoe => ww_devoe,
	o => \sel[2]~output_o\);

-- Location: IOOBUF_X49_Y54_N16
\rot_dir~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \atual.ROR_D~q\,
	devoe => ww_devoe,
	o => \rot_dir~output_o\);

-- Location: IOOBUF_X51_Y54_N2
\clr~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Selector0~0_combout\,
	devoe => ww_devoe,
	o => \clr~output_o\);

-- Location: IOOBUF_X46_Y54_N23
\display[0]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \ALT_INV_WideOr14~combout\,
	devoe => ww_devoe,
	o => \display[0]~output_o\);

-- Location: IOOBUF_X51_Y54_N16
\display[1]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \ALT_INV_WideOr13~combout\,
	devoe => ww_devoe,
	o => \display[1]~output_o\);

-- Location: IOOBUF_X49_Y54_N30
\display[2]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \ALT_INV_WideOr12~combout\,
	devoe => ww_devoe,
	o => \display[2]~output_o\);

-- Location: IOOBUF_X54_Y54_N23
\display[3]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \ALT_INV_WideOr11~combout\,
	devoe => ww_devoe,
	o => \display[3]~output_o\);

-- Location: IOIBUF_X0_Y18_N15
\clock~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clock,
	o => \clock~input_o\);

-- Location: CLKCTRL_G3
\clock~inputclkctrl\ : fiftyfivenm_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \clock~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \clock~inputclkctrl_outclk\);

-- Location: IOIBUF_X49_Y54_N8
\enter~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_enter,
	o => \enter~input_o\);

-- Location: IOIBUF_X54_Y54_N1
\op[1]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_op(1),
	o => \op[1]~input_o\);

-- Location: IOIBUF_X49_Y54_N1
\op[0]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_op(0),
	o => \op[0]~input_o\);

-- Location: LCCOMB_X47_Y50_N8
\Selector15~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Selector15~0_combout\ = (\op[0]~input_o\ & (!\enter~input_o\ & (\op[1]~input_o\ & \atual.SEL_OP_D~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \op[0]~input_o\,
	datab => \enter~input_o\,
	datac => \op[1]~input_o\,
	datad => \atual.SEL_OP_D~q\,
	combout => \Selector15~0_combout\);

-- Location: IOIBUF_X0_Y18_N22
\reset~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_reset,
	o => \reset~input_o\);

-- Location: CLKCTRL_G4
\reset~inputclkctrl\ : fiftyfivenm_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \reset~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \reset~inputclkctrl_outclk\);

-- Location: FF_X47_Y50_N9
\atual.PERM_D\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \Selector15~0_combout\,
	clrn => \reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \atual.PERM_D~q\);

-- Location: LCCOMB_X46_Y50_N0
\Selector11~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Selector11~0_combout\ = (\atual.PERM_D~q\) # (((\enter~input_o\ & \atual.SEL_OP_D~q\)) # (!\WideOr13~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \enter~input_o\,
	datab => \atual.PERM_D~q\,
	datac => \atual.SEL_OP_D~q\,
	datad => \WideOr13~0_combout\,
	combout => \Selector11~0_combout\);

-- Location: FF_X46_Y50_N1
\atual.SEL_OP_D\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \Selector11~0_combout\,
	clrn => \reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \atual.SEL_OP_D~q\);

-- Location: LCCOMB_X46_Y50_N2
\Selector12~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Selector12~0_combout\ = (!\op[1]~input_o\ & (\op[0]~input_o\ & (!\enter~input_o\ & \atual.SEL_OP_D~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \op[1]~input_o\,
	datab => \op[0]~input_o\,
	datac => \enter~input_o\,
	datad => \atual.SEL_OP_D~q\,
	combout => \Selector12~0_combout\);

-- Location: LCCOMB_X46_Y50_N14
\Selector12~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Selector12~1_combout\ = (\Selector12~0_combout\) # ((\enter~input_o\ & \atual.TRY_K~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \enter~input_o\,
	datac => \atual.TRY_K~q\,
	datad => \Selector12~0_combout\,
	combout => \Selector12~1_combout\);

-- Location: FF_X46_Y50_N15
\atual.TRY_K\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \Selector12~1_combout\,
	clrn => \reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \atual.TRY_K~q\);

-- Location: LCCOMB_X46_Y50_N30
\Selector13~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Selector13~0_combout\ = (!\enter~input_o\ & \atual.TRY_K~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \enter~input_o\,
	datad => \atual.TRY_K~q\,
	combout => \Selector13~0_combout\);

-- Location: FF_X46_Y50_N31
\atual.XOR_D\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \Selector13~0_combout\,
	clrn => \reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \atual.XOR_D~q\);

-- Location: IOIBUF_X46_Y54_N1
\modo~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_modo,
	o => \modo~input_o\);

-- Location: IOIBUF_X46_Y54_N8
\existe_cripto~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_existe_cripto,
	o => \existe_cripto~input_o\);

-- Location: LCCOMB_X46_Y50_N4
\Selector2~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Selector2~0_combout\ = (\atual.MENU~q\ & ((\enter~input_o\) # ((\modo~input_o\ & !\existe_cripto~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \modo~input_o\,
	datab => \existe_cripto~input_o\,
	datac => \enter~input_o\,
	datad => \atual.MENU~q\,
	combout => \Selector2~0_combout\);

-- Location: LCCOMB_X47_Y50_N10
\Selector16~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Selector16~0_combout\ = (!\op[0]~input_o\ & (!\enter~input_o\ & (\atual.SEL_OP_D~q\ & !\op[1]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \op[0]~input_o\,
	datab => \enter~input_o\,
	datac => \atual.SEL_OP_D~q\,
	datad => \op[1]~input_o\,
	combout => \Selector16~0_combout\);

-- Location: LCCOMB_X47_Y50_N14
\Selector16~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Selector16~1_combout\ = (\Selector16~0_combout\) # ((\enter~input_o\ & \atual.RESULT~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \enter~input_o\,
	datac => \atual.RESULT~q\,
	datad => \Selector16~0_combout\,
	combout => \Selector16~1_combout\);

-- Location: FF_X47_Y50_N15
\atual.RESULT\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \Selector16~1_combout\,
	clrn => \reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \atual.RESULT~q\);

-- Location: LCCOMB_X46_Y50_N22
\Selector3~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Selector3~4_combout\ = (\enter~input_o\ & (((\atual.INSERT_V~q\)))) # (!\enter~input_o\ & (!\modo~input_o\ & ((\atual.MENU~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011000110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \enter~input_o\,
	datab => \modo~input_o\,
	datac => \atual.INSERT_V~q\,
	datad => \atual.MENU~q\,
	combout => \Selector3~4_combout\);

-- Location: FF_X46_Y50_N23
\atual.INSERT_V\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \Selector3~4_combout\,
	clrn => \reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \atual.INSERT_V~q\);

-- Location: FF_X46_Y50_N13
\atual.INSERT_K\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	asdata => \atual.INSERT_V~q\,
	clrn => \reset~inputclkctrl_outclk\,
	sload => VCC,
	ena => \ALT_INV_enter~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \atual.INSERT_K~q\);

-- Location: LCCOMB_X47_Y50_N12
\Selector6~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Selector6~0_combout\ = (\atual.SEL_OP_C~q\ & !\atual.SEL_OP_D~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \atual.SEL_OP_C~q\,
	datac => \atual.SEL_OP_D~q\,
	combout => \Selector6~0_combout\);

-- Location: LCCOMB_X47_Y50_N26
\Selector7~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Selector7~0_combout\ = (!\op[0]~input_o\ & (!\enter~input_o\ & (\op[1]~input_o\ & \Selector6~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \op[0]~input_o\,
	datab => \enter~input_o\,
	datac => \op[1]~input_o\,
	datad => \Selector6~0_combout\,
	combout => \Selector7~0_combout\);

-- Location: FF_X47_Y50_N27
\atual.ROL_C\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \Selector7~0_combout\,
	clrn => \reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \atual.ROL_C~q\);

-- Location: LCCOMB_X47_Y50_N30
\Selector8~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Selector8~0_combout\ = (\op[0]~input_o\ & (\atual.SEL_OP_C~q\ & (!\op[1]~input_o\ & !\enter~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \op[0]~input_o\,
	datab => \atual.SEL_OP_C~q\,
	datac => \op[1]~input_o\,
	datad => \enter~input_o\,
	combout => \Selector8~0_combout\);

-- Location: FF_X47_Y50_N31
\atual.XOR_C\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \Selector8~0_combout\,
	clrn => \reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \atual.XOR_C~q\);

-- Location: LCCOMB_X47_Y50_N28
\Selector6~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Selector6~1_combout\ = (\op[0]~input_o\ & (!\enter~input_o\ & (\op[1]~input_o\ & \Selector6~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \op[0]~input_o\,
	datab => \enter~input_o\,
	datac => \op[1]~input_o\,
	datad => \Selector6~0_combout\,
	combout => \Selector6~1_combout\);

-- Location: FF_X47_Y50_N29
\atual.PERM_C\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \Selector6~1_combout\,
	clrn => \reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \atual.PERM_C~q\);

-- Location: LCCOMB_X47_Y50_N24
\WideOr11~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \WideOr11~0_combout\ = (!\atual.ROL_C~q\ & (!\atual.XOR_C~q\ & !\atual.PERM_C~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \atual.ROL_C~q\,
	datac => \atual.XOR_C~q\,
	datad => \atual.PERM_C~q\,
	combout => \WideOr11~0_combout\);

-- Location: LCCOMB_X47_Y50_N20
\Selector5~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Selector5~0_combout\ = ((\enter~input_o\ & ((\atual.SEL_OP_C~q\))) # (!\enter~input_o\ & (\atual.INSERT_K~q\))) # (!\WideOr11~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110001011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \atual.INSERT_K~q\,
	datab => \enter~input_o\,
	datac => \atual.SEL_OP_C~q\,
	datad => \WideOr11~0_combout\,
	combout => \Selector5~0_combout\);

-- Location: FF_X47_Y50_N21
\atual.SEL_OP_C\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \Selector5~0_combout\,
	clrn => \reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \atual.SEL_OP_C~q\);

-- Location: LCCOMB_X46_Y50_N8
\Selector9~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Selector9~0_combout\ = (\atual.SEL_OP_C~q\ & (!\op[1]~input_o\ & (!\enter~input_o\ & !\op[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \atual.SEL_OP_C~q\,
	datab => \op[1]~input_o\,
	datac => \enter~input_o\,
	datad => \op[0]~input_o\,
	combout => \Selector9~0_combout\);

-- Location: FF_X46_Y50_N9
\atual.SAVE_C\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \Selector9~0_combout\,
	clrn => \reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \atual.SAVE_C~q\);

-- Location: LCCOMB_X45_Y50_N28
\atual.INIT~feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \atual.INIT~feeder_combout\ = VCC

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	combout => \atual.INIT~feeder_combout\);

-- Location: FF_X45_Y50_N29
\atual.INIT\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \atual.INIT~feeder_combout\,
	clrn => \reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \atual.INIT~q\);

-- Location: LCCOMB_X46_Y50_N6
\WideOr12~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \WideOr12~0_combout\ = (!\atual.SAVE_C~q\ & \atual.INIT~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \atual.SAVE_C~q\,
	datad => \atual.INIT~q\,
	combout => \WideOr12~0_combout\);

-- Location: LCCOMB_X46_Y50_N24
\Selector2~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Selector2~1_combout\ = (\Selector2~0_combout\) # (((!\enter~input_o\ & \atual.RESULT~q\)) # (!\WideOr12~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \enter~input_o\,
	datab => \Selector2~0_combout\,
	datac => \atual.RESULT~q\,
	datad => \WideOr12~0_combout\,
	combout => \Selector2~1_combout\);

-- Location: FF_X46_Y50_N25
\atual.MENU\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \Selector2~1_combout\,
	clrn => \reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \atual.MENU~q\);

-- Location: LCCOMB_X46_Y50_N16
\Selector10~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Selector10~0_combout\ = (\modo~input_o\ & (\existe_cripto~input_o\ & (!\enter~input_o\ & \atual.MENU~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \modo~input_o\,
	datab => \existe_cripto~input_o\,
	datac => \enter~input_o\,
	datad => \atual.MENU~q\,
	combout => \Selector10~0_combout\);

-- Location: LCCOMB_X46_Y50_N20
\WideOr12~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \WideOr12~1_combout\ = (!\atual.INSERT_K~q\ & (!\atual.TRY_K~q\ & (!\atual.INSERT_V~q\ & !\atual.SEL_OP_D~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \atual.INSERT_K~q\,
	datab => \atual.TRY_K~q\,
	datac => \atual.INSERT_V~q\,
	datad => \atual.SEL_OP_D~q\,
	combout => \WideOr12~1_combout\);

-- Location: LCCOMB_X46_Y50_N10
\Selector10~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Selector10~1_combout\ = (\atual.SEL_OP_C~q\) # ((\atual.MENU~q\) # ((\atual.RESULT~q\) # (!\WideOr12~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \atual.SEL_OP_C~q\,
	datab => \atual.MENU~q\,
	datac => \atual.RESULT~q\,
	datad => \WideOr12~1_combout\,
	combout => \Selector10~1_combout\);

-- Location: LCCOMB_X46_Y50_N26
\Selector10~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Selector10~2_combout\ = (\Selector10~0_combout\) # ((\enter~input_o\ & (\atual.ATTEMPT_D~q\ & \Selector10~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \enter~input_o\,
	datab => \Selector10~0_combout\,
	datac => \atual.ATTEMPT_D~q\,
	datad => \Selector10~1_combout\,
	combout => \Selector10~2_combout\);

-- Location: FF_X46_Y50_N27
\atual.ATTEMPT_D\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \Selector10~2_combout\,
	clrn => \reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \atual.ATTEMPT_D~q\);

-- Location: LCCOMB_X47_Y50_N4
\Selector14~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Selector14~0_combout\ = (!\op[0]~input_o\ & (!\enter~input_o\ & (\op[1]~input_o\ & \atual.SEL_OP_D~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \op[0]~input_o\,
	datab => \enter~input_o\,
	datac => \op[1]~input_o\,
	datad => \atual.SEL_OP_D~q\,
	combout => \Selector14~0_combout\);

-- Location: FF_X47_Y50_N5
\atual.ROR_D\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \Selector14~0_combout\,
	clrn => \reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \atual.ROR_D~q\);

-- Location: LCCOMB_X46_Y50_N28
\WideOr13~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \WideOr13~0_combout\ = (!\atual.XOR_D~q\ & (!\atual.ATTEMPT_D~q\ & !\atual.ROR_D~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \atual.XOR_D~q\,
	datac => \atual.ATTEMPT_D~q\,
	datad => \atual.ROR_D~q\,
	combout => \WideOr13~0_combout\);

-- Location: LCCOMB_X47_Y50_N6
\Selector17~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Selector17~0_combout\ = (\atual.INSERT_V~q\ & !\enter~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \atual.INSERT_V~q\,
	datad => \enter~input_o\,
	combout => \Selector17~0_combout\);

-- Location: LCCOMB_X47_Y50_N18
\Selector17~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Selector17~1_combout\ = (((\atual.PERM_D~q\) # (\Selector17~0_combout\)) # (!\WideOr11~0_combout\)) # (!\WideOr13~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111110111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \WideOr13~0_combout\,
	datab => \WideOr11~0_combout\,
	datac => \atual.PERM_D~q\,
	datad => \Selector17~0_combout\,
	combout => \Selector17~1_combout\);

-- Location: LCCOMB_X47_Y50_N16
\Selector18~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Selector18~0_combout\ = (!\enter~input_o\ & ((\atual.INSERT_K~q\) # (\atual.TRY_K~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \atual.INSERT_K~q\,
	datac => \atual.TRY_K~q\,
	datad => \enter~input_o\,
	combout => \Selector18~0_combout\);

-- Location: LCCOMB_X47_Y50_N2
\WideOr9~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \WideOr9~0_combout\ = (\atual.XOR_C~q\) # ((\atual.XOR_D~q\) # ((\atual.PERM_D~q\) # (\atual.PERM_C~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \atual.XOR_C~q\,
	datab => \atual.XOR_D~q\,
	datac => \atual.PERM_D~q\,
	datad => \atual.PERM_C~q\,
	combout => \WideOr9~0_combout\);

-- Location: LCCOMB_X49_Y50_N28
\WideOr8~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \WideOr8~0_combout\ = (\atual.ROL_C~q\) # ((\atual.PERM_D~q\) # ((\atual.ROR_D~q\) # (\atual.PERM_C~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \atual.ROL_C~q\,
	datab => \atual.PERM_D~q\,
	datac => \atual.ROR_D~q\,
	datad => \atual.PERM_C~q\,
	combout => \WideOr8~0_combout\);

-- Location: LCCOMB_X45_Y50_N2
\Selector0~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Selector0~0_combout\ = ((!\enter~input_o\ & (\atual.MENU~q\ & !\modo~input_o\))) # (!\atual.INIT~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001101110011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \enter~input_o\,
	datab => \atual.INIT~q\,
	datac => \atual.MENU~q\,
	datad => \modo~input_o\,
	combout => \Selector0~0_combout\);

-- Location: LCCOMB_X47_Y50_N22
\WideOr14~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \WideOr14~0_combout\ = (\atual.ROL_C~q\) # ((\atual.XOR_D~q\) # ((\atual.PERM_D~q\) # (\atual.SEL_OP_C~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \atual.ROL_C~q\,
	datab => \atual.XOR_D~q\,
	datac => \atual.PERM_D~q\,
	datad => \atual.SEL_OP_C~q\,
	combout => \WideOr14~0_combout\);

-- Location: LCCOMB_X46_Y50_N12
WideOr14 : fiftyfivenm_lcell_comb
-- Equation(s):
-- \WideOr14~combout\ = ((\atual.SEL_OP_D~q\) # ((\atual.INSERT_V~q\) # (\WideOr14~0_combout\))) # (!\WideOr12~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \WideOr12~0_combout\,
	datab => \atual.SEL_OP_D~q\,
	datac => \atual.INSERT_V~q\,
	datad => \WideOr14~0_combout\,
	combout => \WideOr14~combout\);

-- Location: LCCOMB_X46_Y50_N18
\WideOr13~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \WideOr13~1_combout\ = (\atual.INIT~q\ & (!\atual.SEL_OP_C~q\ & !\atual.MENU~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \atual.INIT~q\,
	datac => \atual.SEL_OP_C~q\,
	datad => \atual.MENU~q\,
	combout => \WideOr13~1_combout\);

-- Location: LCCOMB_X49_Y50_N26
WideOr13 : fiftyfivenm_lcell_comb
-- Equation(s):
-- \WideOr13~combout\ = (((\atual.SAVE_C~q\) # (\atual.PERM_C~q\)) # (!\WideOr13~1_combout\)) # (!\WideOr13~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111110111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \WideOr13~0_combout\,
	datab => \WideOr13~1_combout\,
	datac => \atual.SAVE_C~q\,
	datad => \atual.PERM_C~q\,
	combout => \WideOr13~combout\);

-- Location: LCCOMB_X45_Y50_N0
WideOr12 : fiftyfivenm_lcell_comb
-- Equation(s):
-- \WideOr12~combout\ = (((\atual.MENU~q\) # (\atual.ATTEMPT_D~q\)) # (!\WideOr12~1_combout\)) # (!\WideOr12~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111110111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \WideOr12~0_combout\,
	datab => \WideOr12~1_combout\,
	datac => \atual.MENU~q\,
	datad => \atual.ATTEMPT_D~q\,
	combout => \WideOr12~combout\);

-- Location: LCCOMB_X47_Y50_N0
WideOr11 : fiftyfivenm_lcell_comb
-- Equation(s):
-- \WideOr11~combout\ = (\atual.INSERT_K~q\) # (((\atual.INSERT_V~q\) # (!\WideOr11~0_combout\)) # (!\WideOr13~1_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \atual.INSERT_K~q\,
	datab => \WideOr13~1_combout\,
	datac => \atual.INSERT_V~q\,
	datad => \WideOr11~0_combout\,
	combout => \WideOr11~combout\);

-- Location: IOIBUF_X78_Y41_N15
\equals~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_equals,
	o => \equals~input_o\);

-- Location: UNVM_X0_Y40_N40
\~QUARTUS_CREATED_UNVM~\ : fiftyfivenm_unvm
-- pragma translate_off
GENERIC MAP (
	addr_range1_end_addr => -1,
	addr_range1_offset => -1,
	addr_range2_offset => -1,
	is_compressed_image => "false",
	is_dual_boot => "false",
	is_eram_skip => "false",
	max_ufm_valid_addr => -1,
	max_valid_addr => -1,
	min_ufm_valid_addr => -1,
	min_valid_addr => -1,
	part_name => "quartus_created_unvm",
	reserve_block => "true")
-- pragma translate_on
PORT MAP (
	nosc_ena => \~QUARTUS_CREATED_GND~I_combout\,
	xe_ye => \~QUARTUS_CREATED_GND~I_combout\,
	se => \~QUARTUS_CREATED_GND~I_combout\,
	busy => \~QUARTUS_CREATED_UNVM~~busy\);

-- Location: ADCBLOCK_X43_Y52_N0
\~QUARTUS_CREATED_ADC1~\ : fiftyfivenm_adcblock
-- pragma translate_off
GENERIC MAP (
	analog_input_pin_mask => 0,
	clkdiv => 1,
	device_partname_fivechar_prefix => "none",
	is_this_first_or_second_adc => 1,
	prescalar => 0,
	pwd => 1,
	refsel => 0,
	reserve_block => "true",
	testbits => 66,
	tsclkdiv => 1,
	tsclksel => 0)
-- pragma translate_on
PORT MAP (
	soc => \~QUARTUS_CREATED_GND~I_combout\,
	usr_pwd => VCC,
	tsen => \~QUARTUS_CREATED_GND~I_combout\,
	chsel => \~QUARTUS_CREATED_ADC1~_CHSEL_bus\,
	eoc => \~QUARTUS_CREATED_ADC1~~eoc\);

-- Location: ADCBLOCK_X43_Y51_N0
\~QUARTUS_CREATED_ADC2~\ : fiftyfivenm_adcblock
-- pragma translate_off
GENERIC MAP (
	analog_input_pin_mask => 0,
	clkdiv => 1,
	device_partname_fivechar_prefix => "none",
	is_this_first_or_second_adc => 2,
	prescalar => 0,
	pwd => 1,
	refsel => 0,
	reserve_block => "true",
	testbits => 66,
	tsclkdiv => 1,
	tsclksel => 0)
-- pragma translate_on
PORT MAP (
	soc => \~QUARTUS_CREATED_GND~I_combout\,
	usr_pwd => VCC,
	tsen => \~QUARTUS_CREATED_GND~I_combout\,
	chsel => \~QUARTUS_CREATED_ADC2~_CHSEL_bus\,
	eoc => \~QUARTUS_CREATED_ADC2~~eoc\);

ww_ld_x <= \ld_x~output_o\;

ww_ld_k <= \ld_k~output_o\;

ww_ld_v <= \ld_v~output_o\;

ww_ld_c <= \ld_c~output_o\;

ww_sel(0) <= \sel[0]~output_o\;

ww_sel(1) <= \sel[1]~output_o\;

ww_sel(2) <= \sel[2]~output_o\;

ww_rot_dir <= \rot_dir~output_o\;

ww_clr <= \clr~output_o\;

ww_display(0) <= \display[0]~output_o\;

ww_display(1) <= \display[1]~output_o\;

ww_display(2) <= \display[2]~output_o\;

ww_display(3) <= \display[3]~output_o\;
END structure;


