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

-- DATE "11/23/2026 20:41:33"

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

ENTITY 	Criptografia IS
    PORT (
	base_clock : IN std_logic;
	enter : IN std_logic;
	reset : IN std_logic;
	sw : IN std_logic_vector(9 DOWNTO 0);
	leds : BUFFER std_logic_vector(9 DOWNTO 0);
	hex5 : BUFFER std_logic_vector(6 DOWNTO 0);
	hex4 : BUFFER std_logic_vector(6 DOWNTO 0);
	hex3 : BUFFER std_logic_vector(6 DOWNTO 0);
	hex2 : BUFFER std_logic_vector(6 DOWNTO 0);
	hex1 : BUFFER std_logic_vector(6 DOWNTO 0);
	hex0 : BUFFER std_logic_vector(6 DOWNTO 0)
	);
END Criptografia;

-- Design Ports Information
-- leds[0]	=>  Location: PIN_A8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- leds[1]	=>  Location: PIN_A9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- leds[2]	=>  Location: PIN_A10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- leds[3]	=>  Location: PIN_B10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- leds[4]	=>  Location: PIN_D13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- leds[5]	=>  Location: PIN_C13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- leds[6]	=>  Location: PIN_E14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- leds[7]	=>  Location: PIN_D14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- leds[8]	=>  Location: PIN_A11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- leds[9]	=>  Location: PIN_B11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex5[0]	=>  Location: PIN_J20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex5[1]	=>  Location: PIN_K20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex5[2]	=>  Location: PIN_L18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex5[3]	=>  Location: PIN_N18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex5[4]	=>  Location: PIN_M20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex5[5]	=>  Location: PIN_N19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex5[6]	=>  Location: PIN_N20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex4[0]	=>  Location: PIN_F18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex4[1]	=>  Location: PIN_E20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex4[2]	=>  Location: PIN_E19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex4[3]	=>  Location: PIN_J18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex4[4]	=>  Location: PIN_H19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex4[5]	=>  Location: PIN_F19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex4[6]	=>  Location: PIN_F20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex3[0]	=>  Location: PIN_F21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex3[1]	=>  Location: PIN_E22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex3[2]	=>  Location: PIN_E21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex3[3]	=>  Location: PIN_C19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex3[4]	=>  Location: PIN_C20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex3[5]	=>  Location: PIN_D19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex3[6]	=>  Location: PIN_E17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex2[0]	=>  Location: PIN_B20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex2[1]	=>  Location: PIN_A20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex2[2]	=>  Location: PIN_B19,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex2[3]	=>  Location: PIN_A21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex2[4]	=>  Location: PIN_B21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex2[5]	=>  Location: PIN_C22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex2[6]	=>  Location: PIN_B22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex1[0]	=>  Location: PIN_C18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex1[1]	=>  Location: PIN_D18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex1[2]	=>  Location: PIN_E18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex1[3]	=>  Location: PIN_B16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex1[4]	=>  Location: PIN_A17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex1[5]	=>  Location: PIN_A18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex1[6]	=>  Location: PIN_B17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex0[0]	=>  Location: PIN_C14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex0[1]	=>  Location: PIN_E15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex0[2]	=>  Location: PIN_C15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex0[3]	=>  Location: PIN_C16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex0[4]	=>  Location: PIN_E16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex0[5]	=>  Location: PIN_D17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- hex0[6]	=>  Location: PIN_C17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- sw[0]	=>  Location: PIN_C10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- enter	=>  Location: PIN_B8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- sw[1]	=>  Location: PIN_C11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- sw[2]	=>  Location: PIN_D12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- sw[3]	=>  Location: PIN_C12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- sw[4]	=>  Location: PIN_A12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- sw[5]	=>  Location: PIN_B12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- sw[6]	=>  Location: PIN_A13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- sw[7]	=>  Location: PIN_A14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- sw[8]	=>  Location: PIN_B14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- sw[9]	=>  Location: PIN_F15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reset	=>  Location: PIN_A7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- base_clock	=>  Location: PIN_P11,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF Criptografia IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_base_clock : std_logic;
SIGNAL ww_enter : std_logic;
SIGNAL ww_reset : std_logic;
SIGNAL ww_sw : std_logic_vector(9 DOWNTO 0);
SIGNAL ww_leds : std_logic_vector(9 DOWNTO 0);
SIGNAL ww_hex5 : std_logic_vector(6 DOWNTO 0);
SIGNAL ww_hex4 : std_logic_vector(6 DOWNTO 0);
SIGNAL ww_hex3 : std_logic_vector(6 DOWNTO 0);
SIGNAL ww_hex2 : std_logic_vector(6 DOWNTO 0);
SIGNAL ww_hex1 : std_logic_vector(6 DOWNTO 0);
SIGNAL ww_hex0 : std_logic_vector(6 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_ADC1~_CHSEL_bus\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_ADC2~_CHSEL_bus\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \clock_div|tick~clkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \base_clock~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \~QUARTUS_CREATED_UNVM~~busy\ : std_logic;
SIGNAL \~QUARTUS_CREATED_ADC1~~eoc\ : std_logic;
SIGNAL \~QUARTUS_CREATED_ADC2~~eoc\ : std_logic;
SIGNAL \leds[0]~output_o\ : std_logic;
SIGNAL \leds[1]~output_o\ : std_logic;
SIGNAL \leds[2]~output_o\ : std_logic;
SIGNAL \leds[3]~output_o\ : std_logic;
SIGNAL \leds[4]~output_o\ : std_logic;
SIGNAL \leds[5]~output_o\ : std_logic;
SIGNAL \leds[6]~output_o\ : std_logic;
SIGNAL \leds[7]~output_o\ : std_logic;
SIGNAL \leds[8]~output_o\ : std_logic;
SIGNAL \leds[9]~output_o\ : std_logic;
SIGNAL \hex5[0]~output_o\ : std_logic;
SIGNAL \hex5[1]~output_o\ : std_logic;
SIGNAL \hex5[2]~output_o\ : std_logic;
SIGNAL \hex5[3]~output_o\ : std_logic;
SIGNAL \hex5[4]~output_o\ : std_logic;
SIGNAL \hex5[5]~output_o\ : std_logic;
SIGNAL \hex5[6]~output_o\ : std_logic;
SIGNAL \hex4[0]~output_o\ : std_logic;
SIGNAL \hex4[1]~output_o\ : std_logic;
SIGNAL \hex4[2]~output_o\ : std_logic;
SIGNAL \hex4[3]~output_o\ : std_logic;
SIGNAL \hex4[4]~output_o\ : std_logic;
SIGNAL \hex4[5]~output_o\ : std_logic;
SIGNAL \hex4[6]~output_o\ : std_logic;
SIGNAL \hex3[0]~output_o\ : std_logic;
SIGNAL \hex3[1]~output_o\ : std_logic;
SIGNAL \hex3[2]~output_o\ : std_logic;
SIGNAL \hex3[3]~output_o\ : std_logic;
SIGNAL \hex3[4]~output_o\ : std_logic;
SIGNAL \hex3[5]~output_o\ : std_logic;
SIGNAL \hex3[6]~output_o\ : std_logic;
SIGNAL \hex2[0]~output_o\ : std_logic;
SIGNAL \hex2[1]~output_o\ : std_logic;
SIGNAL \hex2[2]~output_o\ : std_logic;
SIGNAL \hex2[3]~output_o\ : std_logic;
SIGNAL \hex2[4]~output_o\ : std_logic;
SIGNAL \hex2[5]~output_o\ : std_logic;
SIGNAL \hex2[6]~output_o\ : std_logic;
SIGNAL \hex1[0]~output_o\ : std_logic;
SIGNAL \hex1[1]~output_o\ : std_logic;
SIGNAL \hex1[2]~output_o\ : std_logic;
SIGNAL \hex1[3]~output_o\ : std_logic;
SIGNAL \hex1[4]~output_o\ : std_logic;
SIGNAL \hex1[5]~output_o\ : std_logic;
SIGNAL \hex1[6]~output_o\ : std_logic;
SIGNAL \hex0[0]~output_o\ : std_logic;
SIGNAL \hex0[1]~output_o\ : std_logic;
SIGNAL \hex0[2]~output_o\ : std_logic;
SIGNAL \hex0[3]~output_o\ : std_logic;
SIGNAL \hex0[4]~output_o\ : std_logic;
SIGNAL \hex0[5]~output_o\ : std_logic;
SIGNAL \hex0[6]~output_o\ : std_logic;
SIGNAL \base_clock~input_o\ : std_logic;
SIGNAL \base_clock~inputclkctrl_outclk\ : std_logic;
SIGNAL \clock_div|n[0]~24_combout\ : std_logic;
SIGNAL \reset~input_o\ : std_logic;
SIGNAL \clock_div|n[7]~40\ : std_logic;
SIGNAL \clock_div|n[8]~41_combout\ : std_logic;
SIGNAL \clock_div|n[8]~42\ : std_logic;
SIGNAL \clock_div|n[9]~43_combout\ : std_logic;
SIGNAL \clock_div|n[9]~44\ : std_logic;
SIGNAL \clock_div|n[10]~45_combout\ : std_logic;
SIGNAL \clock_div|n[10]~46\ : std_logic;
SIGNAL \clock_div|n[11]~47_combout\ : std_logic;
SIGNAL \clock_div|n[11]~48\ : std_logic;
SIGNAL \clock_div|n[12]~49_combout\ : std_logic;
SIGNAL \clock_div|n[12]~50\ : std_logic;
SIGNAL \clock_div|n[13]~51_combout\ : std_logic;
SIGNAL \clock_div|n[13]~52\ : std_logic;
SIGNAL \clock_div|n[14]~53_combout\ : std_logic;
SIGNAL \clock_div|n[14]~54\ : std_logic;
SIGNAL \clock_div|n[15]~55_combout\ : std_logic;
SIGNAL \clock_div|n[15]~56\ : std_logic;
SIGNAL \clock_div|n[16]~57_combout\ : std_logic;
SIGNAL \clock_div|n[16]~58\ : std_logic;
SIGNAL \clock_div|n[17]~59_combout\ : std_logic;
SIGNAL \clock_div|n[17]~60\ : std_logic;
SIGNAL \clock_div|n[18]~61_combout\ : std_logic;
SIGNAL \clock_div|n[18]~62\ : std_logic;
SIGNAL \clock_div|n[19]~63_combout\ : std_logic;
SIGNAL \clock_div|Equal0~5_combout\ : std_logic;
SIGNAL \clock_div|n[19]~64\ : std_logic;
SIGNAL \clock_div|n[20]~65_combout\ : std_logic;
SIGNAL \clock_div|n[20]~66\ : std_logic;
SIGNAL \clock_div|n[21]~67_combout\ : std_logic;
SIGNAL \clock_div|n[21]~68\ : std_logic;
SIGNAL \clock_div|n[22]~69_combout\ : std_logic;
SIGNAL \clock_div|n[22]~70\ : std_logic;
SIGNAL \clock_div|n[23]~71_combout\ : std_logic;
SIGNAL \clock_div|Equal0~6_combout\ : std_logic;
SIGNAL \clock_div|n[8]~26_combout\ : std_logic;
SIGNAL \clock_div|n[0]~25\ : std_logic;
SIGNAL \clock_div|n[1]~27_combout\ : std_logic;
SIGNAL \clock_div|n[1]~28\ : std_logic;
SIGNAL \clock_div|n[2]~29_combout\ : std_logic;
SIGNAL \clock_div|n[2]~30\ : std_logic;
SIGNAL \clock_div|n[3]~31_combout\ : std_logic;
SIGNAL \clock_div|n[3]~32\ : std_logic;
SIGNAL \clock_div|n[4]~33_combout\ : std_logic;
SIGNAL \clock_div|n[4]~34\ : std_logic;
SIGNAL \clock_div|n[5]~35_combout\ : std_logic;
SIGNAL \clock_div|n[5]~36\ : std_logic;
SIGNAL \clock_div|n[6]~37_combout\ : std_logic;
SIGNAL \clock_div|n[6]~38\ : std_logic;
SIGNAL \clock_div|n[7]~39_combout\ : std_logic;
SIGNAL \clock_div|Equal0~1_combout\ : std_logic;
SIGNAL \clock_div|Equal0~0_combout\ : std_logic;
SIGNAL \clock_div|Equal0~3_combout\ : std_logic;
SIGNAL \clock_div|Equal0~2_combout\ : std_logic;
SIGNAL \clock_div|Equal0~4_combout\ : std_logic;
SIGNAL \clock_div|tick~0_combout\ : std_logic;
SIGNAL \clock_div|tick~q\ : std_logic;
SIGNAL \clock_div|tick~clkctrl_outclk\ : std_logic;
SIGNAL \controller|atual.INIT~feeder_combout\ : std_logic;
SIGNAL \controller|atual.INIT~q\ : std_logic;
SIGNAL \sw[0]~input_o\ : std_logic;
SIGNAL \datapath|reg_v|Q~3_combout\ : std_logic;
SIGNAL \enter~input_o\ : std_logic;
SIGNAL \sw[1]~input_o\ : std_logic;
SIGNAL \controller|Selector3~0_combout\ : std_logic;
SIGNAL \controller|atual.INSERT_V~q\ : std_logic;
SIGNAL \controller|atual.INSERT_K~q\ : std_logic;
SIGNAL \controller|Selector8~0_combout\ : std_logic;
SIGNAL \controller|atual.XOR_C~q\ : std_logic;
SIGNAL \controller|Selector5~0_combout\ : std_logic;
SIGNAL \controller|Selector7~0_combout\ : std_logic;
SIGNAL \controller|atual.ROL_C~q\ : std_logic;
SIGNAL \controller|Selector6~0_combout\ : std_logic;
SIGNAL \controller|Selector6~1_combout\ : std_logic;
SIGNAL \controller|atual.PERM_C~q\ : std_logic;
SIGNAL \controller|Selector5~1_combout\ : std_logic;
SIGNAL \controller|atual.SEL_OP_C~q\ : std_logic;
SIGNAL \controller|Selector9~1_combout\ : std_logic;
SIGNAL \controller|WideOr11~0_combout\ : std_logic;
SIGNAL \controller|Selector10~1_combout\ : std_logic;
SIGNAL \controller|WideOr14~1_combout\ : std_logic;
SIGNAL \controller|WideOr12~1_combout\ : std_logic;
SIGNAL \controller|Selector10~2_combout\ : std_logic;
SIGNAL \controller|Selector9~4_combout\ : std_logic;
SIGNAL \controller|state_control~0_combout\ : std_logic;
SIGNAL \controller|Selector9~0_combout\ : std_logic;
SIGNAL \controller|Selector9~2_combout\ : std_logic;
SIGNAL \controller|Selector9~3_combout\ : std_logic;
SIGNAL \controller|Selector9~combout\ : std_logic;
SIGNAL \controller|atual.SAVE_C~q\ : std_logic;
SIGNAL \controller|Selector0~0_combout\ : std_logic;
SIGNAL \datapath|reg_c|loaded~0_combout\ : std_logic;
SIGNAL \datapath|reg_c|loaded~q\ : std_logic;
SIGNAL \controller|prox~16_combout\ : std_logic;
SIGNAL \controller|Selector16~0_combout\ : std_logic;
SIGNAL \controller|Selector16~1_combout\ : std_logic;
SIGNAL \controller|Selector16~combout\ : std_logic;
SIGNAL \controller|atual.RESULT~q\ : std_logic;
SIGNAL \controller|Selector2~0_combout\ : std_logic;
SIGNAL \controller|Selector2~1_combout\ : std_logic;
SIGNAL \controller|atual.MENU~q\ : std_logic;
SIGNAL \controller|Selector10~0_combout\ : std_logic;
SIGNAL \controller|Selector10~3_combout\ : std_logic;
SIGNAL \controller|Selector10~4_combout\ : std_logic;
SIGNAL \controller|atual.ATTEMPT_D~q\ : std_logic;
SIGNAL \controller|Selector14~0_combout\ : std_logic;
SIGNAL \controller|atual.ROR_D~q\ : std_logic;
SIGNAL \controller|WideOr13~0_combout\ : std_logic;
SIGNAL \controller|Selector15~0_combout\ : std_logic;
SIGNAL \controller|atual.PERM_D~q\ : std_logic;
SIGNAL \controller|Selector13~0_combout\ : std_logic;
SIGNAL \controller|atual.XOR_D~q\ : std_logic;
SIGNAL \controller|WideOr14~2_combout\ : std_logic;
SIGNAL \controller|Selector11~0_combout\ : std_logic;
SIGNAL \controller|atual.SEL_OP_D~q\ : std_logic;
SIGNAL \controller|Selector12~0_combout\ : std_logic;
SIGNAL \controller|Selector12~1_combout\ : std_logic;
SIGNAL \controller|atual.TRY_K~q\ : std_logic;
SIGNAL \datapath|reg_k|Q[1]~0_combout\ : std_logic;
SIGNAL \controller|WideOr8~0_combout\ : std_logic;
SIGNAL \datapath|reg_x|Q[0]~10_combout\ : std_logic;
SIGNAL \datapath|reg_x|Q[0]~15_combout\ : std_logic;
SIGNAL \datapath|reg_x|Q[0]~11_combout\ : std_logic;
SIGNAL \datapath|reg_v|Q~2_combout\ : std_logic;
SIGNAL \datapath|reg_x|Q[0]~12_combout\ : std_logic;
SIGNAL \sw[8]~input_o\ : std_logic;
SIGNAL \datapath|reg_v|Q~1_combout\ : std_logic;
SIGNAL \datapath|reg_k|Q[8]~feeder_combout\ : std_logic;
SIGNAL \sw[5]~input_o\ : std_logic;
SIGNAL \datapath|reg_v|Q~6_combout\ : std_logic;
SIGNAL \sw[4]~input_o\ : std_logic;
SIGNAL \datapath|reg_v|Q~7_combout\ : std_logic;
SIGNAL \sw[7]~input_o\ : std_logic;
SIGNAL \datapath|reg_v|Q~8_combout\ : std_logic;
SIGNAL \sw[6]~input_o\ : std_logic;
SIGNAL \datapath|reg_v|Q~9_combout\ : std_logic;
SIGNAL \sw[3]~input_o\ : std_logic;
SIGNAL \datapath|reg_v|Q~4_combout\ : std_logic;
SIGNAL \sw[2]~input_o\ : std_logic;
SIGNAL \datapath|reg_v|Q~5_combout\ : std_logic;
SIGNAL \datapath|reg_k|Q[2]~feeder_combout\ : std_logic;
SIGNAL \sw[9]~input_o\ : std_logic;
SIGNAL \datapath|reg_v|Q~0_combout\ : std_logic;
SIGNAL \datapath|reg_k|Q[9]~feeder_combout\ : std_logic;
SIGNAL \datapath|reg_x|Q~37_combout\ : std_logic;
SIGNAL \datapath|reg_x|Q~38_combout\ : std_logic;
SIGNAL \datapath|reg_x|Q[9]~9_combout\ : std_logic;
SIGNAL \datapath|reg_c|Q~10_combout\ : std_logic;
SIGNAL \datapath|reg_c|Q[5]~1_combout\ : std_logic;
SIGNAL \datapath|reg_x|Q[0]~16_combout\ : std_logic;
SIGNAL \datapath|reg_x|Q[0]~17_combout\ : std_logic;
SIGNAL \datapath|reg_x|Q~21_combout\ : std_logic;
SIGNAL \datapath|reg_x|Q~22_combout\ : std_logic;
SIGNAL \datapath|reg_x|Q~23_combout\ : std_logic;
SIGNAL \datapath|reg_x|Q[2]~2_combout\ : std_logic;
SIGNAL \datapath|reg_c|Q~3_combout\ : std_logic;
SIGNAL \datapath|reg_x|Q~24_combout\ : std_logic;
SIGNAL \datapath|reg_x|Q~25_combout\ : std_logic;
SIGNAL \datapath|reg_x|Q[3]~3_combout\ : std_logic;
SIGNAL \datapath|reg_c|Q~4_combout\ : std_logic;
SIGNAL \datapath|reg_x|Q~30_combout\ : std_logic;
SIGNAL \datapath|reg_x|Q~31_combout\ : std_logic;
SIGNAL \datapath|reg_x|Q[6]~6_combout\ : std_logic;
SIGNAL \datapath|reg_c|Q~7_combout\ : std_logic;
SIGNAL \datapath|reg_x|Q~32_combout\ : std_logic;
SIGNAL \datapath|reg_x|Q~33_combout\ : std_logic;
SIGNAL \datapath|reg_x|Q[7]~7_combout\ : std_logic;
SIGNAL \datapath|reg_c|Q~8_combout\ : std_logic;
SIGNAL \datapath|reg_x|Q~26_combout\ : std_logic;
SIGNAL \datapath|reg_x|Q~27_combout\ : std_logic;
SIGNAL \datapath|reg_x|Q[4]~4_combout\ : std_logic;
SIGNAL \datapath|reg_c|Q~5_combout\ : std_logic;
SIGNAL \datapath|reg_x|Q~28_combout\ : std_logic;
SIGNAL \datapath|reg_x|Q~29_combout\ : std_logic;
SIGNAL \datapath|reg_x|Q[5]~5_combout\ : std_logic;
SIGNAL \datapath|reg_c|Q~6_combout\ : std_logic;
SIGNAL \datapath|reg_x|Q~34_combout\ : std_logic;
SIGNAL \datapath|reg_x|Q~35_combout\ : std_logic;
SIGNAL \datapath|reg_x|Q~36_combout\ : std_logic;
SIGNAL \datapath|reg_x|Q[8]~8_combout\ : std_logic;
SIGNAL \datapath|reg_c|Q~9_combout\ : std_logic;
SIGNAL \datapath|reg_x|Q~18_combout\ : std_logic;
SIGNAL \datapath|reg_x|Q~19_combout\ : std_logic;
SIGNAL \datapath|reg_x|Q~20_combout\ : std_logic;
SIGNAL \datapath|reg_x|Q[1]~1_combout\ : std_logic;
SIGNAL \datapath|reg_c|Q~2_combout\ : std_logic;
SIGNAL \datapath|reg_x|Q~13_combout\ : std_logic;
SIGNAL \datapath|reg_x|Q~14_combout\ : std_logic;
SIGNAL \datapath|reg_x|Q[0]~0_combout\ : std_logic;
SIGNAL \datapath|reg_c|Q~0_combout\ : std_logic;
SIGNAL \datapath|comp|Equal0~0_combout\ : std_logic;
SIGNAL \datapath|comp|Equal0~4_combout\ : std_logic;
SIGNAL \datapath|comp|Equal0~1_combout\ : std_logic;
SIGNAL \datapath|comp|Equal0~2_combout\ : std_logic;
SIGNAL \datapath|comp|Equal0~3_combout\ : std_logic;
SIGNAL \datapath|comp|Equal0~5_combout\ : std_logic;
SIGNAL \controller|WideOr11~1_combout\ : std_logic;
SIGNAL \controller|WideOr11~combout\ : std_logic;
SIGNAL \controller|WideOr14~0_combout\ : std_logic;
SIGNAL \controller|WideOr14~combout\ : std_logic;
SIGNAL \controller|WideOr12~0_combout\ : std_logic;
SIGNAL \controller|WideOr12~combout\ : std_logic;
SIGNAL \controller|WideOr13~combout\ : std_logic;
SIGNAL \display|Mux19~2_combout\ : std_logic;
SIGNAL \display|Mux19~3_combout\ : std_logic;
SIGNAL \display|Mux20~2_combout\ : std_logic;
SIGNAL \display|Mux6~0_combout\ : std_logic;
SIGNAL \display|Mux6~1_combout\ : std_logic;
SIGNAL \display|Mux3~0_combout\ : std_logic;
SIGNAL \datapath|comp|Equal0~6_combout\ : std_logic;
SIGNAL \display|Mux13~0_combout\ : std_logic;
SIGNAL \display|Mux13~1_combout\ : std_logic;
SIGNAL \display|Mux13~2_combout\ : std_logic;
SIGNAL \display|Mux12~0_combout\ : std_logic;
SIGNAL \display|Mux12~1_combout\ : std_logic;
SIGNAL \display|Mux11~0_combout\ : std_logic;
SIGNAL \display|Mux11~1_combout\ : std_logic;
SIGNAL \display|Mux10~0_combout\ : std_logic;
SIGNAL \display|Mux10~1_combout\ : std_logic;
SIGNAL \display|Mux9~0_combout\ : std_logic;
SIGNAL \display|Mux9~1_combout\ : std_logic;
SIGNAL \display|Mux8~0_combout\ : std_logic;
SIGNAL \display|Mux8~1_combout\ : std_logic;
SIGNAL \display|Mux8~2_combout\ : std_logic;
SIGNAL \display|Mux7~0_combout\ : std_logic;
SIGNAL \clock_div|n\ : std_logic_vector(23 DOWNTO 0);
SIGNAL \datapath|reg_x|Q\ : std_logic_vector(9 DOWNTO 0);
SIGNAL \datapath|reg_v|Q\ : std_logic_vector(9 DOWNTO 0);
SIGNAL \datapath|reg_k|Q\ : std_logic_vector(9 DOWNTO 0);
SIGNAL \datapath|xor_maker|X\ : std_logic_vector(9 DOWNTO 0);
SIGNAL \datapath|reg_c|Q\ : std_logic_vector(9 DOWNTO 0);
SIGNAL \ALT_INV_enter~input_o\ : std_logic;
SIGNAL \display|ALT_INV_Mux19~3_combout\ : std_logic;
SIGNAL \display|ALT_INV_Mux7~0_combout\ : std_logic;
SIGNAL \display|ALT_INV_Mux8~2_combout\ : std_logic;
SIGNAL \display|ALT_INV_Mux9~1_combout\ : std_logic;
SIGNAL \display|ALT_INV_Mux10~1_combout\ : std_logic;
SIGNAL \display|ALT_INV_Mux11~1_combout\ : std_logic;
SIGNAL \display|ALT_INV_Mux12~1_combout\ : std_logic;
SIGNAL \display|ALT_INV_Mux13~2_combout\ : std_logic;
SIGNAL \display|ALT_INV_Mux6~1_combout\ : std_logic;
SIGNAL \display|ALT_INV_Mux19~2_combout\ : std_logic;

COMPONENT hard_block
    PORT (
	devoe : IN std_logic;
	devclrn : IN std_logic;
	devpor : IN std_logic);
END COMPONENT;

BEGIN

ww_base_clock <= base_clock;
ww_enter <= enter;
ww_reset <= reset;
ww_sw <= sw;
leds <= ww_leds;
hex5 <= ww_hex5;
hex4 <= ww_hex4;
hex3 <= ww_hex3;
hex2 <= ww_hex2;
hex1 <= ww_hex1;
hex0 <= ww_hex0;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\~QUARTUS_CREATED_ADC1~_CHSEL_bus\ <= (\~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\);

\~QUARTUS_CREATED_ADC2~_CHSEL_bus\ <= (\~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\);

\clock_div|tick~clkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \clock_div|tick~q\);

\base_clock~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \base_clock~input_o\);
\ALT_INV_enter~input_o\ <= NOT \enter~input_o\;
\display|ALT_INV_Mux19~3_combout\ <= NOT \display|Mux19~3_combout\;
\display|ALT_INV_Mux7~0_combout\ <= NOT \display|Mux7~0_combout\;
\display|ALT_INV_Mux8~2_combout\ <= NOT \display|Mux8~2_combout\;
\display|ALT_INV_Mux9~1_combout\ <= NOT \display|Mux9~1_combout\;
\display|ALT_INV_Mux10~1_combout\ <= NOT \display|Mux10~1_combout\;
\display|ALT_INV_Mux11~1_combout\ <= NOT \display|Mux11~1_combout\;
\display|ALT_INV_Mux12~1_combout\ <= NOT \display|Mux12~1_combout\;
\display|ALT_INV_Mux13~2_combout\ <= NOT \display|Mux13~2_combout\;
\display|ALT_INV_Mux6~1_combout\ <= NOT \display|Mux6~1_combout\;
\display|ALT_INV_Mux19~2_combout\ <= NOT \display|Mux19~2_combout\;
auto_generated_inst : hard_block
PORT MAP (
	devoe => ww_devoe,
	devclrn => ww_devclrn,
	devpor => ww_devpor);

-- Location: LCCOMB_X44_Y41_N24
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

-- Location: IOOBUF_X46_Y54_N2
\leds[0]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \datapath|reg_x|Q\(0),
	devoe => ww_devoe,
	o => \leds[0]~output_o\);

-- Location: IOOBUF_X46_Y54_N23
\leds[1]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \datapath|reg_x|Q\(1),
	devoe => ww_devoe,
	o => \leds[1]~output_o\);

-- Location: IOOBUF_X51_Y54_N16
\leds[2]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \datapath|reg_x|Q\(2),
	devoe => ww_devoe,
	o => \leds[2]~output_o\);

-- Location: IOOBUF_X46_Y54_N9
\leds[3]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \datapath|reg_x|Q\(3),
	devoe => ww_devoe,
	o => \leds[3]~output_o\);

-- Location: IOOBUF_X56_Y54_N30
\leds[4]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \datapath|reg_x|Q\(4),
	devoe => ww_devoe,
	o => \leds[4]~output_o\);

-- Location: IOOBUF_X58_Y54_N23
\leds[5]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \datapath|reg_x|Q\(5),
	devoe => ww_devoe,
	o => \leds[5]~output_o\);

-- Location: IOOBUF_X66_Y54_N23
\leds[6]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \datapath|reg_x|Q\(6),
	devoe => ww_devoe,
	o => \leds[6]~output_o\);

-- Location: IOOBUF_X56_Y54_N9
\leds[7]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \datapath|reg_x|Q\(7),
	devoe => ww_devoe,
	o => \leds[7]~output_o\);

-- Location: IOOBUF_X51_Y54_N9
\leds[8]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \datapath|reg_x|Q\(8),
	devoe => ww_devoe,
	o => \leds[8]~output_o\);

-- Location: IOOBUF_X49_Y54_N9
\leds[9]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \datapath|reg_x|Q\(9),
	devoe => ww_devoe,
	o => \leds[9]~output_o\);

-- Location: IOOBUF_X78_Y45_N9
\hex5[0]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \display|ALT_INV_Mux19~3_combout\,
	devoe => ww_devoe,
	o => \hex5[0]~output_o\);

-- Location: IOOBUF_X78_Y42_N2
\hex5[1]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \display|ALT_INV_Mux19~3_combout\,
	devoe => ww_devoe,
	o => \hex5[1]~output_o\);

-- Location: IOOBUF_X78_Y37_N16
\hex5[2]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \display|ALT_INV_Mux19~3_combout\,
	devoe => ww_devoe,
	o => \hex5[2]~output_o\);

-- Location: IOOBUF_X78_Y34_N24
\hex5[3]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => \hex5[3]~output_o\);

-- Location: IOOBUF_X78_Y34_N9
\hex5[4]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \display|ALT_INV_Mux19~3_combout\,
	devoe => ww_devoe,
	o => \hex5[4]~output_o\);

-- Location: IOOBUF_X78_Y34_N16
\hex5[5]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \display|ALT_INV_Mux19~3_combout\,
	devoe => ww_devoe,
	o => \hex5[5]~output_o\);

-- Location: IOOBUF_X78_Y34_N2
\hex5[6]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \display|ALT_INV_Mux19~3_combout\,
	devoe => ww_devoe,
	o => \hex5[6]~output_o\);

-- Location: IOOBUF_X78_Y40_N16
\hex4[0]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \display|ALT_INV_Mux19~2_combout\,
	devoe => ww_devoe,
	o => \hex4[0]~output_o\);

-- Location: IOOBUF_X78_Y40_N2
\hex4[1]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => \hex4[1]~output_o\);

-- Location: IOOBUF_X78_Y40_N23
\hex4[2]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => \hex4[2]~output_o\);

-- Location: IOOBUF_X78_Y42_N16
\hex4[3]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \display|ALT_INV_Mux19~2_combout\,
	devoe => ww_devoe,
	o => \hex4[3]~output_o\);

-- Location: IOOBUF_X78_Y45_N23
\hex4[4]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \display|ALT_INV_Mux19~2_combout\,
	devoe => ww_devoe,
	o => \hex4[4]~output_o\);

-- Location: IOOBUF_X78_Y40_N9
\hex4[5]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \display|ALT_INV_Mux19~2_combout\,
	devoe => ww_devoe,
	o => \hex4[5]~output_o\);

-- Location: IOOBUF_X78_Y35_N16
\hex4[6]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \display|Mux20~2_combout\,
	devoe => ww_devoe,
	o => \hex4[6]~output_o\);

-- Location: IOOBUF_X78_Y35_N23
\hex3[0]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \display|ALT_INV_Mux19~3_combout\,
	devoe => ww_devoe,
	o => \hex3[0]~output_o\);

-- Location: IOOBUF_X78_Y33_N9
\hex3[1]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => \hex3[1]~output_o\);

-- Location: IOOBUF_X78_Y33_N2
\hex3[2]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => \hex3[2]~output_o\);

-- Location: IOOBUF_X69_Y54_N9
\hex3[3]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \display|ALT_INV_Mux19~3_combout\,
	devoe => ww_devoe,
	o => \hex3[3]~output_o\);

-- Location: IOOBUF_X78_Y41_N9
\hex3[4]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \display|ALT_INV_Mux19~2_combout\,
	devoe => ww_devoe,
	o => \hex3[4]~output_o\);

-- Location: IOOBUF_X78_Y41_N2
\hex3[5]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \display|ALT_INV_Mux19~3_combout\,
	devoe => ww_devoe,
	o => \hex3[5]~output_o\);

-- Location: IOOBUF_X78_Y43_N16
\hex3[6]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \display|ALT_INV_Mux19~2_combout\,
	devoe => ww_devoe,
	o => \hex3[6]~output_o\);

-- Location: IOOBUF_X78_Y44_N9
\hex2[0]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => \hex2[0]~output_o\);

-- Location: IOOBUF_X66_Y54_N2
\hex2[1]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => \hex2[1]~output_o\);

-- Location: IOOBUF_X69_Y54_N16
\hex2[2]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => \hex2[2]~output_o\);

-- Location: IOOBUF_X78_Y44_N2
\hex2[3]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => \hex2[3]~output_o\);

-- Location: IOOBUF_X78_Y43_N2
\hex2[4]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \display|ALT_INV_Mux19~2_combout\,
	devoe => ww_devoe,
	o => \hex2[4]~output_o\);

-- Location: IOOBUF_X78_Y35_N2
\hex2[5]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => VCC,
	devoe => ww_devoe,
	o => \hex2[5]~output_o\);

-- Location: IOOBUF_X78_Y43_N9
\hex2[6]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \display|ALT_INV_Mux19~2_combout\,
	devoe => ww_devoe,
	o => \hex2[6]~output_o\);

-- Location: IOOBUF_X69_Y54_N23
\hex1[0]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \display|ALT_INV_Mux6~1_combout\,
	devoe => ww_devoe,
	o => \hex1[0]~output_o\);

-- Location: IOOBUF_X78_Y49_N9
\hex1[1]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \display|Mux19~3_combout\,
	devoe => ww_devoe,
	o => \hex1[1]~output_o\);

-- Location: IOOBUF_X78_Y49_N2
\hex1[2]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \display|Mux19~3_combout\,
	devoe => ww_devoe,
	o => \hex1[2]~output_o\);

-- Location: IOOBUF_X60_Y54_N9
\hex1[3]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \display|Mux3~0_combout\,
	devoe => ww_devoe,
	o => \hex1[3]~output_o\);

-- Location: IOOBUF_X64_Y54_N2
\hex1[4]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \display|Mux3~0_combout\,
	devoe => ww_devoe,
	o => \hex1[4]~output_o\);

-- Location: IOOBUF_X66_Y54_N30
\hex1[5]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \display|Mux3~0_combout\,
	devoe => ww_devoe,
	o => \hex1[5]~output_o\);

-- Location: IOOBUF_X69_Y54_N30
\hex1[6]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \display|ALT_INV_Mux19~3_combout\,
	devoe => ww_devoe,
	o => \hex1[6]~output_o\);

-- Location: IOOBUF_X58_Y54_N16
\hex0[0]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \display|ALT_INV_Mux13~2_combout\,
	devoe => ww_devoe,
	o => \hex0[0]~output_o\);

-- Location: IOOBUF_X74_Y54_N9
\hex0[1]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \display|ALT_INV_Mux12~1_combout\,
	devoe => ww_devoe,
	o => \hex0[1]~output_o\);

-- Location: IOOBUF_X60_Y54_N2
\hex0[2]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \display|ALT_INV_Mux11~1_combout\,
	devoe => ww_devoe,
	o => \hex0[2]~output_o\);

-- Location: IOOBUF_X62_Y54_N30
\hex0[3]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \display|ALT_INV_Mux10~1_combout\,
	devoe => ww_devoe,
	o => \hex0[3]~output_o\);

-- Location: IOOBUF_X74_Y54_N2
\hex0[4]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \display|ALT_INV_Mux9~1_combout\,
	devoe => ww_devoe,
	o => \hex0[4]~output_o\);

-- Location: IOOBUF_X74_Y54_N16
\hex0[5]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \display|ALT_INV_Mux8~2_combout\,
	devoe => ww_devoe,
	o => \hex0[5]~output_o\);

-- Location: IOOBUF_X74_Y54_N23
\hex0[6]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \display|ALT_INV_Mux7~0_combout\,
	devoe => ww_devoe,
	o => \hex0[6]~output_o\);

-- Location: IOIBUF_X34_Y0_N29
\base_clock~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_base_clock,
	o => \base_clock~input_o\);

-- Location: CLKCTRL_G19
\base_clock~inputclkctrl\ : fiftyfivenm_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \base_clock~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \base_clock~inputclkctrl_outclk\);

-- Location: LCCOMB_X58_Y52_N8
\clock_div|n[0]~24\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \clock_div|n[0]~24_combout\ = \clock_div|n\(0) $ (VCC)
-- \clock_div|n[0]~25\ = CARRY(\clock_div|n\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \clock_div|n\(0),
	datad => VCC,
	combout => \clock_div|n[0]~24_combout\,
	cout => \clock_div|n[0]~25\);

-- Location: IOIBUF_X49_Y54_N29
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

-- Location: LCCOMB_X58_Y52_N22
\clock_div|n[7]~39\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \clock_div|n[7]~39_combout\ = (\clock_div|n\(7) & (!\clock_div|n[6]~38\)) # (!\clock_div|n\(7) & ((\clock_div|n[6]~38\) # (GND)))
-- \clock_div|n[7]~40\ = CARRY((!\clock_div|n[6]~38\) # (!\clock_div|n\(7)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \clock_div|n\(7),
	datad => VCC,
	cin => \clock_div|n[6]~38\,
	combout => \clock_div|n[7]~39_combout\,
	cout => \clock_div|n[7]~40\);

-- Location: LCCOMB_X58_Y52_N24
\clock_div|n[8]~41\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \clock_div|n[8]~41_combout\ = (\clock_div|n\(8) & (\clock_div|n[7]~40\ $ (GND))) # (!\clock_div|n\(8) & (!\clock_div|n[7]~40\ & VCC))
-- \clock_div|n[8]~42\ = CARRY((\clock_div|n\(8) & !\clock_div|n[7]~40\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \clock_div|n\(8),
	datad => VCC,
	cin => \clock_div|n[7]~40\,
	combout => \clock_div|n[8]~41_combout\,
	cout => \clock_div|n[8]~42\);

-- Location: FF_X58_Y52_N25
\clock_div|n[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \base_clock~inputclkctrl_outclk\,
	d => \clock_div|n[8]~41_combout\,
	sclr => \clock_div|n[8]~26_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \clock_div|n\(8));

-- Location: LCCOMB_X58_Y52_N26
\clock_div|n[9]~43\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \clock_div|n[9]~43_combout\ = (\clock_div|n\(9) & (!\clock_div|n[8]~42\)) # (!\clock_div|n\(9) & ((\clock_div|n[8]~42\) # (GND)))
-- \clock_div|n[9]~44\ = CARRY((!\clock_div|n[8]~42\) # (!\clock_div|n\(9)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \clock_div|n\(9),
	datad => VCC,
	cin => \clock_div|n[8]~42\,
	combout => \clock_div|n[9]~43_combout\,
	cout => \clock_div|n[9]~44\);

-- Location: FF_X58_Y52_N27
\clock_div|n[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \base_clock~inputclkctrl_outclk\,
	d => \clock_div|n[9]~43_combout\,
	sclr => \clock_div|n[8]~26_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \clock_div|n\(9));

-- Location: LCCOMB_X58_Y52_N28
\clock_div|n[10]~45\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \clock_div|n[10]~45_combout\ = (\clock_div|n\(10) & (\clock_div|n[9]~44\ $ (GND))) # (!\clock_div|n\(10) & (!\clock_div|n[9]~44\ & VCC))
-- \clock_div|n[10]~46\ = CARRY((\clock_div|n\(10) & !\clock_div|n[9]~44\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \clock_div|n\(10),
	datad => VCC,
	cin => \clock_div|n[9]~44\,
	combout => \clock_div|n[10]~45_combout\,
	cout => \clock_div|n[10]~46\);

-- Location: FF_X58_Y52_N29
\clock_div|n[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \base_clock~inputclkctrl_outclk\,
	d => \clock_div|n[10]~45_combout\,
	sclr => \clock_div|n[8]~26_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \clock_div|n\(10));

-- Location: LCCOMB_X58_Y52_N30
\clock_div|n[11]~47\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \clock_div|n[11]~47_combout\ = (\clock_div|n\(11) & (!\clock_div|n[10]~46\)) # (!\clock_div|n\(11) & ((\clock_div|n[10]~46\) # (GND)))
-- \clock_div|n[11]~48\ = CARRY((!\clock_div|n[10]~46\) # (!\clock_div|n\(11)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \clock_div|n\(11),
	datad => VCC,
	cin => \clock_div|n[10]~46\,
	combout => \clock_div|n[11]~47_combout\,
	cout => \clock_div|n[11]~48\);

-- Location: FF_X58_Y52_N31
\clock_div|n[11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \base_clock~inputclkctrl_outclk\,
	d => \clock_div|n[11]~47_combout\,
	sclr => \clock_div|n[8]~26_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \clock_div|n\(11));

-- Location: LCCOMB_X58_Y51_N0
\clock_div|n[12]~49\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \clock_div|n[12]~49_combout\ = (\clock_div|n\(12) & (\clock_div|n[11]~48\ $ (GND))) # (!\clock_div|n\(12) & (!\clock_div|n[11]~48\ & VCC))
-- \clock_div|n[12]~50\ = CARRY((\clock_div|n\(12) & !\clock_div|n[11]~48\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \clock_div|n\(12),
	datad => VCC,
	cin => \clock_div|n[11]~48\,
	combout => \clock_div|n[12]~49_combout\,
	cout => \clock_div|n[12]~50\);

-- Location: FF_X58_Y51_N1
\clock_div|n[12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \base_clock~inputclkctrl_outclk\,
	d => \clock_div|n[12]~49_combout\,
	sclr => \clock_div|n[8]~26_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \clock_div|n\(12));

-- Location: LCCOMB_X58_Y51_N2
\clock_div|n[13]~51\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \clock_div|n[13]~51_combout\ = (\clock_div|n\(13) & (!\clock_div|n[12]~50\)) # (!\clock_div|n\(13) & ((\clock_div|n[12]~50\) # (GND)))
-- \clock_div|n[13]~52\ = CARRY((!\clock_div|n[12]~50\) # (!\clock_div|n\(13)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \clock_div|n\(13),
	datad => VCC,
	cin => \clock_div|n[12]~50\,
	combout => \clock_div|n[13]~51_combout\,
	cout => \clock_div|n[13]~52\);

-- Location: FF_X58_Y51_N3
\clock_div|n[13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \base_clock~inputclkctrl_outclk\,
	d => \clock_div|n[13]~51_combout\,
	sclr => \clock_div|n[8]~26_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \clock_div|n\(13));

-- Location: LCCOMB_X58_Y51_N4
\clock_div|n[14]~53\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \clock_div|n[14]~53_combout\ = (\clock_div|n\(14) & (\clock_div|n[13]~52\ $ (GND))) # (!\clock_div|n\(14) & (!\clock_div|n[13]~52\ & VCC))
-- \clock_div|n[14]~54\ = CARRY((\clock_div|n\(14) & !\clock_div|n[13]~52\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \clock_div|n\(14),
	datad => VCC,
	cin => \clock_div|n[13]~52\,
	combout => \clock_div|n[14]~53_combout\,
	cout => \clock_div|n[14]~54\);

-- Location: FF_X58_Y51_N5
\clock_div|n[14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \base_clock~inputclkctrl_outclk\,
	d => \clock_div|n[14]~53_combout\,
	sclr => \clock_div|n[8]~26_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \clock_div|n\(14));

-- Location: LCCOMB_X58_Y51_N6
\clock_div|n[15]~55\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \clock_div|n[15]~55_combout\ = (\clock_div|n\(15) & (!\clock_div|n[14]~54\)) # (!\clock_div|n\(15) & ((\clock_div|n[14]~54\) # (GND)))
-- \clock_div|n[15]~56\ = CARRY((!\clock_div|n[14]~54\) # (!\clock_div|n\(15)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \clock_div|n\(15),
	datad => VCC,
	cin => \clock_div|n[14]~54\,
	combout => \clock_div|n[15]~55_combout\,
	cout => \clock_div|n[15]~56\);

-- Location: FF_X58_Y51_N7
\clock_div|n[15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \base_clock~inputclkctrl_outclk\,
	d => \clock_div|n[15]~55_combout\,
	sclr => \clock_div|n[8]~26_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \clock_div|n\(15));

-- Location: LCCOMB_X58_Y51_N8
\clock_div|n[16]~57\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \clock_div|n[16]~57_combout\ = (\clock_div|n\(16) & (\clock_div|n[15]~56\ $ (GND))) # (!\clock_div|n\(16) & (!\clock_div|n[15]~56\ & VCC))
-- \clock_div|n[16]~58\ = CARRY((\clock_div|n\(16) & !\clock_div|n[15]~56\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \clock_div|n\(16),
	datad => VCC,
	cin => \clock_div|n[15]~56\,
	combout => \clock_div|n[16]~57_combout\,
	cout => \clock_div|n[16]~58\);

-- Location: FF_X58_Y51_N9
\clock_div|n[16]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \base_clock~inputclkctrl_outclk\,
	d => \clock_div|n[16]~57_combout\,
	sclr => \clock_div|n[8]~26_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \clock_div|n\(16));

-- Location: LCCOMB_X58_Y51_N10
\clock_div|n[17]~59\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \clock_div|n[17]~59_combout\ = (\clock_div|n\(17) & (!\clock_div|n[16]~58\)) # (!\clock_div|n\(17) & ((\clock_div|n[16]~58\) # (GND)))
-- \clock_div|n[17]~60\ = CARRY((!\clock_div|n[16]~58\) # (!\clock_div|n\(17)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \clock_div|n\(17),
	datad => VCC,
	cin => \clock_div|n[16]~58\,
	combout => \clock_div|n[17]~59_combout\,
	cout => \clock_div|n[17]~60\);

-- Location: FF_X58_Y51_N11
\clock_div|n[17]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \base_clock~inputclkctrl_outclk\,
	d => \clock_div|n[17]~59_combout\,
	sclr => \clock_div|n[8]~26_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \clock_div|n\(17));

-- Location: LCCOMB_X58_Y51_N12
\clock_div|n[18]~61\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \clock_div|n[18]~61_combout\ = (\clock_div|n\(18) & (\clock_div|n[17]~60\ $ (GND))) # (!\clock_div|n\(18) & (!\clock_div|n[17]~60\ & VCC))
-- \clock_div|n[18]~62\ = CARRY((\clock_div|n\(18) & !\clock_div|n[17]~60\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \clock_div|n\(18),
	datad => VCC,
	cin => \clock_div|n[17]~60\,
	combout => \clock_div|n[18]~61_combout\,
	cout => \clock_div|n[18]~62\);

-- Location: FF_X58_Y51_N13
\clock_div|n[18]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \base_clock~inputclkctrl_outclk\,
	d => \clock_div|n[18]~61_combout\,
	sclr => \clock_div|n[8]~26_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \clock_div|n\(18));

-- Location: LCCOMB_X58_Y51_N14
\clock_div|n[19]~63\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \clock_div|n[19]~63_combout\ = (\clock_div|n\(19) & (!\clock_div|n[18]~62\)) # (!\clock_div|n\(19) & ((\clock_div|n[18]~62\) # (GND)))
-- \clock_div|n[19]~64\ = CARRY((!\clock_div|n[18]~62\) # (!\clock_div|n\(19)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \clock_div|n\(19),
	datad => VCC,
	cin => \clock_div|n[18]~62\,
	combout => \clock_div|n[19]~63_combout\,
	cout => \clock_div|n[19]~64\);

-- Location: FF_X58_Y51_N15
\clock_div|n[19]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \base_clock~inputclkctrl_outclk\,
	d => \clock_div|n[19]~63_combout\,
	sclr => \clock_div|n[8]~26_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \clock_div|n\(19));

-- Location: LCCOMB_X58_Y51_N30
\clock_div|Equal0~5\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \clock_div|Equal0~5_combout\ = (\clock_div|n\(17)) # ((\clock_div|n\(16)) # ((\clock_div|n\(18)) # (!\clock_div|n\(19))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111101111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \clock_div|n\(17),
	datab => \clock_div|n\(16),
	datac => \clock_div|n\(19),
	datad => \clock_div|n\(18),
	combout => \clock_div|Equal0~5_combout\);

-- Location: LCCOMB_X58_Y51_N16
\clock_div|n[20]~65\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \clock_div|n[20]~65_combout\ = (\clock_div|n\(20) & (\clock_div|n[19]~64\ $ (GND))) # (!\clock_div|n\(20) & (!\clock_div|n[19]~64\ & VCC))
-- \clock_div|n[20]~66\ = CARRY((\clock_div|n\(20) & !\clock_div|n[19]~64\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \clock_div|n\(20),
	datad => VCC,
	cin => \clock_div|n[19]~64\,
	combout => \clock_div|n[20]~65_combout\,
	cout => \clock_div|n[20]~66\);

-- Location: FF_X58_Y51_N17
\clock_div|n[20]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \base_clock~inputclkctrl_outclk\,
	d => \clock_div|n[20]~65_combout\,
	sclr => \clock_div|n[8]~26_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \clock_div|n\(20));

-- Location: LCCOMB_X58_Y51_N18
\clock_div|n[21]~67\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \clock_div|n[21]~67_combout\ = (\clock_div|n\(21) & (!\clock_div|n[20]~66\)) # (!\clock_div|n\(21) & ((\clock_div|n[20]~66\) # (GND)))
-- \clock_div|n[21]~68\ = CARRY((!\clock_div|n[20]~66\) # (!\clock_div|n\(21)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \clock_div|n\(21),
	datad => VCC,
	cin => \clock_div|n[20]~66\,
	combout => \clock_div|n[21]~67_combout\,
	cout => \clock_div|n[21]~68\);

-- Location: FF_X58_Y51_N19
\clock_div|n[21]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \base_clock~inputclkctrl_outclk\,
	d => \clock_div|n[21]~67_combout\,
	sclr => \clock_div|n[8]~26_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \clock_div|n\(21));

-- Location: LCCOMB_X58_Y51_N20
\clock_div|n[22]~69\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \clock_div|n[22]~69_combout\ = (\clock_div|n\(22) & (\clock_div|n[21]~68\ $ (GND))) # (!\clock_div|n\(22) & (!\clock_div|n[21]~68\ & VCC))
-- \clock_div|n[22]~70\ = CARRY((\clock_div|n\(22) & !\clock_div|n[21]~68\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \clock_div|n\(22),
	datad => VCC,
	cin => \clock_div|n[21]~68\,
	combout => \clock_div|n[22]~69_combout\,
	cout => \clock_div|n[22]~70\);

-- Location: FF_X58_Y51_N21
\clock_div|n[22]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \base_clock~inputclkctrl_outclk\,
	d => \clock_div|n[22]~69_combout\,
	sclr => \clock_div|n[8]~26_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \clock_div|n\(22));

-- Location: LCCOMB_X58_Y51_N22
\clock_div|n[23]~71\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \clock_div|n[23]~71_combout\ = \clock_div|n\(23) $ (\clock_div|n[22]~70\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \clock_div|n\(23),
	cin => \clock_div|n[22]~70\,
	combout => \clock_div|n[23]~71_combout\);

-- Location: FF_X58_Y51_N23
\clock_div|n[23]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \base_clock~inputclkctrl_outclk\,
	d => \clock_div|n[23]~71_combout\,
	sclr => \clock_div|n[8]~26_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \clock_div|n\(23));

-- Location: LCCOMB_X58_Y51_N24
\clock_div|Equal0~6\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \clock_div|Equal0~6_combout\ = ((\clock_div|n\(22)) # ((\clock_div|n\(21)) # (!\clock_div|n\(20)))) # (!\clock_div|n\(23))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \clock_div|n\(23),
	datab => \clock_div|n\(22),
	datac => \clock_div|n\(21),
	datad => \clock_div|n\(20),
	combout => \clock_div|Equal0~6_combout\);

-- Location: LCCOMB_X57_Y52_N30
\clock_div|n[8]~26\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \clock_div|n[8]~26_combout\ = ((!\clock_div|Equal0~5_combout\ & (!\clock_div|Equal0~6_combout\ & !\clock_div|Equal0~4_combout\))) # (!\reset~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010101010111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \reset~input_o\,
	datab => \clock_div|Equal0~5_combout\,
	datac => \clock_div|Equal0~6_combout\,
	datad => \clock_div|Equal0~4_combout\,
	combout => \clock_div|n[8]~26_combout\);

-- Location: FF_X58_Y52_N9
\clock_div|n[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \base_clock~inputclkctrl_outclk\,
	d => \clock_div|n[0]~24_combout\,
	sclr => \clock_div|n[8]~26_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \clock_div|n\(0));

-- Location: LCCOMB_X58_Y52_N10
\clock_div|n[1]~27\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \clock_div|n[1]~27_combout\ = (\clock_div|n\(1) & (!\clock_div|n[0]~25\)) # (!\clock_div|n\(1) & ((\clock_div|n[0]~25\) # (GND)))
-- \clock_div|n[1]~28\ = CARRY((!\clock_div|n[0]~25\) # (!\clock_div|n\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \clock_div|n\(1),
	datad => VCC,
	cin => \clock_div|n[0]~25\,
	combout => \clock_div|n[1]~27_combout\,
	cout => \clock_div|n[1]~28\);

-- Location: FF_X58_Y52_N11
\clock_div|n[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \base_clock~inputclkctrl_outclk\,
	d => \clock_div|n[1]~27_combout\,
	sclr => \clock_div|n[8]~26_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \clock_div|n\(1));

-- Location: LCCOMB_X58_Y52_N12
\clock_div|n[2]~29\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \clock_div|n[2]~29_combout\ = (\clock_div|n\(2) & (\clock_div|n[1]~28\ $ (GND))) # (!\clock_div|n\(2) & (!\clock_div|n[1]~28\ & VCC))
-- \clock_div|n[2]~30\ = CARRY((\clock_div|n\(2) & !\clock_div|n[1]~28\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \clock_div|n\(2),
	datad => VCC,
	cin => \clock_div|n[1]~28\,
	combout => \clock_div|n[2]~29_combout\,
	cout => \clock_div|n[2]~30\);

-- Location: FF_X58_Y52_N13
\clock_div|n[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \base_clock~inputclkctrl_outclk\,
	d => \clock_div|n[2]~29_combout\,
	sclr => \clock_div|n[8]~26_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \clock_div|n\(2));

-- Location: LCCOMB_X58_Y52_N14
\clock_div|n[3]~31\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \clock_div|n[3]~31_combout\ = (\clock_div|n\(3) & (!\clock_div|n[2]~30\)) # (!\clock_div|n\(3) & ((\clock_div|n[2]~30\) # (GND)))
-- \clock_div|n[3]~32\ = CARRY((!\clock_div|n[2]~30\) # (!\clock_div|n\(3)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \clock_div|n\(3),
	datad => VCC,
	cin => \clock_div|n[2]~30\,
	combout => \clock_div|n[3]~31_combout\,
	cout => \clock_div|n[3]~32\);

-- Location: FF_X58_Y52_N15
\clock_div|n[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \base_clock~inputclkctrl_outclk\,
	d => \clock_div|n[3]~31_combout\,
	sclr => \clock_div|n[8]~26_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \clock_div|n\(3));

-- Location: LCCOMB_X58_Y52_N16
\clock_div|n[4]~33\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \clock_div|n[4]~33_combout\ = (\clock_div|n\(4) & (\clock_div|n[3]~32\ $ (GND))) # (!\clock_div|n\(4) & (!\clock_div|n[3]~32\ & VCC))
-- \clock_div|n[4]~34\ = CARRY((\clock_div|n\(4) & !\clock_div|n[3]~32\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \clock_div|n\(4),
	datad => VCC,
	cin => \clock_div|n[3]~32\,
	combout => \clock_div|n[4]~33_combout\,
	cout => \clock_div|n[4]~34\);

-- Location: FF_X58_Y52_N17
\clock_div|n[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \base_clock~inputclkctrl_outclk\,
	d => \clock_div|n[4]~33_combout\,
	sclr => \clock_div|n[8]~26_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \clock_div|n\(4));

-- Location: LCCOMB_X58_Y52_N18
\clock_div|n[5]~35\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \clock_div|n[5]~35_combout\ = (\clock_div|n\(5) & (!\clock_div|n[4]~34\)) # (!\clock_div|n\(5) & ((\clock_div|n[4]~34\) # (GND)))
-- \clock_div|n[5]~36\ = CARRY((!\clock_div|n[4]~34\) # (!\clock_div|n\(5)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \clock_div|n\(5),
	datad => VCC,
	cin => \clock_div|n[4]~34\,
	combout => \clock_div|n[5]~35_combout\,
	cout => \clock_div|n[5]~36\);

-- Location: FF_X58_Y52_N19
\clock_div|n[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \base_clock~inputclkctrl_outclk\,
	d => \clock_div|n[5]~35_combout\,
	sclr => \clock_div|n[8]~26_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \clock_div|n\(5));

-- Location: LCCOMB_X58_Y52_N20
\clock_div|n[6]~37\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \clock_div|n[6]~37_combout\ = (\clock_div|n\(6) & (\clock_div|n[5]~36\ $ (GND))) # (!\clock_div|n\(6) & (!\clock_div|n[5]~36\ & VCC))
-- \clock_div|n[6]~38\ = CARRY((\clock_div|n\(6) & !\clock_div|n[5]~36\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \clock_div|n\(6),
	datad => VCC,
	cin => \clock_div|n[5]~36\,
	combout => \clock_div|n[6]~37_combout\,
	cout => \clock_div|n[6]~38\);

-- Location: FF_X58_Y52_N21
\clock_div|n[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \base_clock~inputclkctrl_outclk\,
	d => \clock_div|n[6]~37_combout\,
	sclr => \clock_div|n[8]~26_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \clock_div|n\(6));

-- Location: FF_X58_Y52_N23
\clock_div|n[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \base_clock~inputclkctrl_outclk\,
	d => \clock_div|n[7]~39_combout\,
	sclr => \clock_div|n[8]~26_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \clock_div|n\(7));

-- Location: LCCOMB_X58_Y52_N2
\clock_div|Equal0~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \clock_div|Equal0~1_combout\ = (\clock_div|n\(7)) # (((!\clock_div|n\(5)) # (!\clock_div|n\(6))) # (!\clock_div|n\(4)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \clock_div|n\(7),
	datab => \clock_div|n\(4),
	datac => \clock_div|n\(6),
	datad => \clock_div|n\(5),
	combout => \clock_div|Equal0~1_combout\);

-- Location: LCCOMB_X58_Y52_N4
\clock_div|Equal0~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \clock_div|Equal0~0_combout\ = (((!\clock_div|n\(2)) # (!\clock_div|n\(3))) # (!\clock_div|n\(0))) # (!\clock_div|n\(1))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \clock_div|n\(1),
	datab => \clock_div|n\(0),
	datac => \clock_div|n\(3),
	datad => \clock_div|n\(2),
	combout => \clock_div|Equal0~0_combout\);

-- Location: LCCOMB_X58_Y51_N28
\clock_div|Equal0~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \clock_div|Equal0~3_combout\ = (((\clock_div|n\(14)) # (\clock_div|n\(13))) # (!\clock_div|n\(12))) # (!\clock_div|n\(15))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111110111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \clock_div|n\(15),
	datab => \clock_div|n\(12),
	datac => \clock_div|n\(14),
	datad => \clock_div|n\(13),
	combout => \clock_div|Equal0~3_combout\);

-- Location: LCCOMB_X58_Y52_N0
\clock_div|Equal0~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \clock_div|Equal0~2_combout\ = (\clock_div|n\(11)) # ((\clock_div|n\(8)) # ((!\clock_div|n\(10)) # (!\clock_div|n\(9))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \clock_div|n\(11),
	datab => \clock_div|n\(8),
	datac => \clock_div|n\(9),
	datad => \clock_div|n\(10),
	combout => \clock_div|Equal0~2_combout\);

-- Location: LCCOMB_X57_Y52_N18
\clock_div|Equal0~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \clock_div|Equal0~4_combout\ = (\clock_div|Equal0~1_combout\) # ((\clock_div|Equal0~0_combout\) # ((\clock_div|Equal0~3_combout\) # (\clock_div|Equal0~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \clock_div|Equal0~1_combout\,
	datab => \clock_div|Equal0~0_combout\,
	datac => \clock_div|Equal0~3_combout\,
	datad => \clock_div|Equal0~2_combout\,
	combout => \clock_div|Equal0~4_combout\);

-- Location: LCCOMB_X57_Y52_N10
\clock_div|tick~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \clock_div|tick~0_combout\ = (!\clock_div|Equal0~4_combout\ & (!\clock_div|Equal0~6_combout\ & (\reset~input_o\ & !\clock_div|Equal0~5_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \clock_div|Equal0~4_combout\,
	datab => \clock_div|Equal0~6_combout\,
	datac => \reset~input_o\,
	datad => \clock_div|Equal0~5_combout\,
	combout => \clock_div|tick~0_combout\);

-- Location: FF_X57_Y52_N11
\clock_div|tick\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \base_clock~inputclkctrl_outclk\,
	d => \clock_div|tick~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \clock_div|tick~q\);

-- Location: CLKCTRL_G13
\clock_div|tick~clkctrl\ : fiftyfivenm_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \clock_div|tick~clkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \clock_div|tick~clkctrl_outclk\);

-- Location: LCCOMB_X55_Y50_N8
\controller|atual.INIT~feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \controller|atual.INIT~feeder_combout\ = VCC

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	combout => \controller|atual.INIT~feeder_combout\);

-- Location: FF_X55_Y50_N9
\controller|atual.INIT\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock_div|tick~clkctrl_outclk\,
	d => \controller|atual.INIT~feeder_combout\,
	clrn => \reset~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \controller|atual.INIT~q\);

-- Location: IOIBUF_X51_Y54_N29
\sw[0]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_sw(0),
	o => \sw[0]~input_o\);

-- Location: LCCOMB_X55_Y50_N16
\datapath|reg_v|Q~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_v|Q~3_combout\ = (\controller|atual.INIT~q\ & \sw[0]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \controller|atual.INIT~q\,
	datac => \sw[0]~input_o\,
	combout => \datapath|reg_v|Q~3_combout\);

-- Location: IOIBUF_X46_Y54_N29
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

-- Location: IOIBUF_X51_Y54_N22
\sw[1]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_sw(1),
	o => \sw[1]~input_o\);

-- Location: LCCOMB_X54_Y50_N8
\controller|Selector3~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \controller|Selector3~0_combout\ = (\enter~input_o\ & (((\controller|atual.INSERT_V~q\)))) # (!\enter~input_o\ & (\controller|atual.MENU~q\ & ((!\sw[0]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000011100100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \enter~input_o\,
	datab => \controller|atual.MENU~q\,
	datac => \controller|atual.INSERT_V~q\,
	datad => \sw[0]~input_o\,
	combout => \controller|Selector3~0_combout\);

-- Location: FF_X54_Y50_N9
\controller|atual.INSERT_V\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock_div|tick~clkctrl_outclk\,
	d => \controller|Selector3~0_combout\,
	clrn => \reset~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \controller|atual.INSERT_V~q\);

-- Location: FF_X54_Y50_N15
\controller|atual.INSERT_K\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock_div|tick~clkctrl_outclk\,
	asdata => \controller|atual.INSERT_V~q\,
	clrn => \reset~input_o\,
	sload => VCC,
	ena => \ALT_INV_enter~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \controller|atual.INSERT_K~q\);

-- Location: LCCOMB_X54_Y51_N14
\controller|Selector8~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \controller|Selector8~0_combout\ = (!\enter~input_o\ & (!\sw[1]~input_o\ & (\controller|atual.SEL_OP_C~q\ & \sw[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \enter~input_o\,
	datab => \sw[1]~input_o\,
	datac => \controller|atual.SEL_OP_C~q\,
	datad => \sw[0]~input_o\,
	combout => \controller|Selector8~0_combout\);

-- Location: FF_X54_Y51_N15
\controller|atual.XOR_C\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock_div|tick~clkctrl_outclk\,
	d => \controller|Selector8~0_combout\,
	clrn => \reset~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \controller|atual.XOR_C~q\);

-- Location: LCCOMB_X54_Y50_N30
\controller|Selector5~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \controller|Selector5~0_combout\ = (\controller|atual.XOR_C~q\) # ((\enter~input_o\ & (\controller|atual.SEL_OP_C~q\)) # (!\enter~input_o\ & ((\controller|atual.INSERT_K~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101011111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \controller|atual.SEL_OP_C~q\,
	datab => \controller|atual.INSERT_K~q\,
	datac => \controller|atual.XOR_C~q\,
	datad => \enter~input_o\,
	combout => \controller|Selector5~0_combout\);

-- Location: LCCOMB_X54_Y51_N12
\controller|Selector7~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \controller|Selector7~0_combout\ = (!\enter~input_o\ & (\sw[1]~input_o\ & (\controller|atual.SEL_OP_C~q\ & !\sw[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \enter~input_o\,
	datab => \sw[1]~input_o\,
	datac => \controller|atual.SEL_OP_C~q\,
	datad => \sw[0]~input_o\,
	combout => \controller|Selector7~0_combout\);

-- Location: FF_X54_Y51_N13
\controller|atual.ROL_C\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock_div|tick~clkctrl_outclk\,
	d => \controller|Selector7~0_combout\,
	clrn => \reset~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \controller|atual.ROL_C~q\);

-- Location: LCCOMB_X52_Y51_N16
\controller|Selector6~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \controller|Selector6~0_combout\ = (\sw[1]~input_o\ & (\sw[0]~input_o\ & (\controller|atual.SEL_OP_C~q\ & !\enter~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \sw[1]~input_o\,
	datab => \sw[0]~input_o\,
	datac => \controller|atual.SEL_OP_C~q\,
	datad => \enter~input_o\,
	combout => \controller|Selector6~0_combout\);

-- Location: LCCOMB_X52_Y51_N18
\controller|Selector6~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \controller|Selector6~1_combout\ = (!\controller|atual.SEL_OP_D~q\ & \controller|Selector6~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \controller|atual.SEL_OP_D~q\,
	datad => \controller|Selector6~0_combout\,
	combout => \controller|Selector6~1_combout\);

-- Location: FF_X52_Y51_N19
\controller|atual.PERM_C\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock_div|tick~clkctrl_outclk\,
	d => \controller|Selector6~1_combout\,
	clrn => \reset~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \controller|atual.PERM_C~q\);

-- Location: LCCOMB_X54_Y50_N10
\controller|Selector5~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \controller|Selector5~1_combout\ = (\controller|Selector5~0_combout\) # ((\controller|atual.ROL_C~q\) # (\controller|atual.PERM_C~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \controller|Selector5~0_combout\,
	datac => \controller|atual.ROL_C~q\,
	datad => \controller|atual.PERM_C~q\,
	combout => \controller|Selector5~1_combout\);

-- Location: FF_X54_Y50_N11
\controller|atual.SEL_OP_C\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock_div|tick~clkctrl_outclk\,
	d => \controller|Selector5~1_combout\,
	clrn => \reset~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \controller|atual.SEL_OP_C~q\);

-- Location: LCCOMB_X54_Y50_N2
\controller|Selector9~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \controller|Selector9~1_combout\ = (\controller|atual.SEL_OP_D~q\) # ((!\controller|atual.SEL_OP_C~q\ & (!\enter~input_o\ & \controller|atual.MENU~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \controller|atual.SEL_OP_C~q\,
	datab => \enter~input_o\,
	datac => \controller|atual.MENU~q\,
	datad => \controller|atual.SEL_OP_D~q\,
	combout => \controller|Selector9~1_combout\);

-- Location: LCCOMB_X54_Y50_N18
\controller|WideOr11~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \controller|WideOr11~0_combout\ = (!\controller|atual.INSERT_K~q\ & !\controller|atual.INSERT_V~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \controller|atual.INSERT_K~q\,
	datad => \controller|atual.INSERT_V~q\,
	combout => \controller|WideOr11~0_combout\);

-- Location: LCCOMB_X54_Y52_N28
\controller|Selector10~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \controller|Selector10~1_combout\ = (\enter~input_o\) # ((!\controller|atual.TRY_K~q\ & (!\controller|atual.RESULT~q\ & \controller|WideOr11~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101110101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \enter~input_o\,
	datab => \controller|atual.TRY_K~q\,
	datac => \controller|atual.RESULT~q\,
	datad => \controller|WideOr11~0_combout\,
	combout => \controller|Selector10~1_combout\);

-- Location: LCCOMB_X54_Y50_N20
\controller|WideOr14~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \controller|WideOr14~1_combout\ = (!\controller|atual.SEL_OP_D~q\ & !\controller|atual.SEL_OP_C~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \controller|atual.SEL_OP_D~q\,
	datad => \controller|atual.SEL_OP_C~q\,
	combout => \controller|WideOr14~1_combout\);

-- Location: LCCOMB_X54_Y50_N28
\controller|WideOr12~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \controller|WideOr12~1_combout\ = (!\controller|atual.TRY_K~q\ & (!\controller|atual.INSERT_K~q\ & (!\controller|atual.MENU~q\ & !\controller|atual.INSERT_V~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \controller|atual.TRY_K~q\,
	datab => \controller|atual.INSERT_K~q\,
	datac => \controller|atual.MENU~q\,
	datad => \controller|atual.INSERT_V~q\,
	combout => \controller|WideOr12~1_combout\);

-- Location: LCCOMB_X54_Y52_N18
\controller|Selector10~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \controller|Selector10~2_combout\ = (\controller|atual.RESULT~q\) # ((\controller|atual.SEL_OP_C~q\) # ((\controller|atual.SEL_OP_D~q\) # (!\controller|WideOr12~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \controller|atual.RESULT~q\,
	datab => \controller|atual.SEL_OP_C~q\,
	datac => \controller|atual.SEL_OP_D~q\,
	datad => \controller|WideOr12~1_combout\,
	combout => \controller|Selector10~2_combout\);

-- Location: LCCOMB_X54_Y52_N6
\controller|Selector9~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \controller|Selector9~4_combout\ = (\controller|WideOr14~1_combout\ & ((\controller|Selector9~1_combout\) # ((\controller|Selector10~1_combout\ & \controller|Selector10~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110000010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \controller|Selector9~1_combout\,
	datab => \controller|Selector10~1_combout\,
	datac => \controller|WideOr14~1_combout\,
	datad => \controller|Selector10~2_combout\,
	combout => \controller|Selector9~4_combout\);

-- Location: LCCOMB_X52_Y52_N4
\controller|state_control~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \controller|state_control~0_combout\ = (\sw[1]~input_o\) # ((\enter~input_o\) # (\sw[0]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \sw[1]~input_o\,
	datac => \enter~input_o\,
	datad => \sw[0]~input_o\,
	combout => \controller|state_control~0_combout\);

-- Location: LCCOMB_X54_Y52_N8
\controller|Selector9~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \controller|Selector9~0_combout\ = (!\controller|WideOr14~1_combout\ & ((\enter~input_o\) # ((!\sw[0]~input_o\ & !\sw[1]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \sw[0]~input_o\,
	datab => \sw[1]~input_o\,
	datac => \controller|WideOr14~1_combout\,
	datad => \enter~input_o\,
	combout => \controller|Selector9~0_combout\);

-- Location: LCCOMB_X54_Y52_N2
\controller|Selector9~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \controller|Selector9~2_combout\ = (\controller|Selector9~0_combout\ & ((\controller|state_control~0_combout\ & (\controller|atual.SAVE_C~q\)) # (!\controller|state_control~0_combout\ & ((!\controller|Selector9~1_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000010110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \controller|atual.SAVE_C~q\,
	datab => \controller|state_control~0_combout\,
	datac => \controller|Selector9~0_combout\,
	datad => \controller|Selector9~1_combout\,
	combout => \controller|Selector9~2_combout\);

-- Location: LCCOMB_X54_Y52_N24
\controller|Selector9~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \controller|Selector9~3_combout\ = (\controller|Selector9~2_combout\) # ((!\enter~input_o\ & (\controller|atual.MENU~q\ & \controller|WideOr14~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111101000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \enter~input_o\,
	datab => \controller|atual.MENU~q\,
	datac => \controller|WideOr14~1_combout\,
	datad => \controller|Selector9~2_combout\,
	combout => \controller|Selector9~3_combout\);

-- Location: LCCOMB_X54_Y52_N30
\controller|Selector9\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \controller|Selector9~combout\ = (\controller|Selector9~4_combout\ & (\controller|atual.SAVE_C~q\ & ((\controller|prox~16_combout\) # (!\controller|Selector9~3_combout\)))) # (!\controller|Selector9~4_combout\ & (((\controller|Selector9~3_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101010110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \controller|Selector9~4_combout\,
	datab => \controller|prox~16_combout\,
	datac => \controller|atual.SAVE_C~q\,
	datad => \controller|Selector9~3_combout\,
	combout => \controller|Selector9~combout\);

-- Location: FF_X54_Y52_N31
\controller|atual.SAVE_C\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock_div|tick~clkctrl_outclk\,
	d => \controller|Selector9~combout\,
	clrn => \reset~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \controller|atual.SAVE_C~q\);

-- Location: LCCOMB_X55_Y50_N2
\controller|Selector0~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \controller|Selector0~0_combout\ = ((!\enter~input_o\ & (!\sw[0]~input_o\ & \controller|atual.MENU~q\))) # (!\controller|atual.INIT~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001111100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \enter~input_o\,
	datab => \sw[0]~input_o\,
	datac => \controller|atual.INIT~q\,
	datad => \controller|atual.MENU~q\,
	combout => \controller|Selector0~0_combout\);

-- Location: LCCOMB_X54_Y52_N22
\datapath|reg_c|loaded~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_c|loaded~0_combout\ = (!\controller|Selector0~0_combout\ & ((\controller|atual.SAVE_C~q\) # (\datapath|reg_c|loaded~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \controller|atual.SAVE_C~q\,
	datac => \datapath|reg_c|loaded~q\,
	datad => \controller|Selector0~0_combout\,
	combout => \datapath|reg_c|loaded~0_combout\);

-- Location: FF_X54_Y52_N23
\datapath|reg_c|loaded\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock_div|tick~clkctrl_outclk\,
	d => \datapath|reg_c|loaded~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \datapath|reg_c|loaded~q\);

-- Location: LCCOMB_X54_Y52_N4
\controller|prox~16\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \controller|prox~16_combout\ = (!\datapath|reg_c|loaded~q\ & \sw[0]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101000001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \datapath|reg_c|loaded~q\,
	datac => \sw[0]~input_o\,
	combout => \controller|prox~16_combout\);

-- Location: LCCOMB_X54_Y52_N16
\controller|Selector16~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \controller|Selector16~0_combout\ = (\controller|Selector9~0_combout\ & ((\controller|state_control~0_combout\ & (\controller|atual.RESULT~q\)) # (!\controller|state_control~0_combout\ & ((\controller|Selector9~1_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011000010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \controller|atual.RESULT~q\,
	datab => \controller|state_control~0_combout\,
	datac => \controller|Selector9~0_combout\,
	datad => \controller|Selector9~1_combout\,
	combout => \controller|Selector16~0_combout\);

-- Location: LCCOMB_X54_Y52_N10
\controller|Selector16~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \controller|Selector16~1_combout\ = (\controller|Selector16~0_combout\) # ((!\enter~input_o\ & (\controller|atual.MENU~q\ & \controller|WideOr14~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111101000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \enter~input_o\,
	datab => \controller|atual.MENU~q\,
	datac => \controller|WideOr14~1_combout\,
	datad => \controller|Selector16~0_combout\,
	combout => \controller|Selector16~1_combout\);

-- Location: LCCOMB_X54_Y52_N26
\controller|Selector16\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \controller|Selector16~combout\ = (\controller|Selector9~4_combout\ & (\controller|atual.RESULT~q\ & ((\controller|prox~16_combout\) # (!\controller|Selector16~1_combout\)))) # (!\controller|Selector9~4_combout\ & (((\controller|Selector16~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101010110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \controller|Selector9~4_combout\,
	datab => \controller|prox~16_combout\,
	datac => \controller|atual.RESULT~q\,
	datad => \controller|Selector16~1_combout\,
	combout => \controller|Selector16~combout\);

-- Location: FF_X54_Y52_N27
\controller|atual.RESULT\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock_div|tick~clkctrl_outclk\,
	d => \controller|Selector16~combout\,
	clrn => \reset~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \controller|atual.RESULT~q\);

-- Location: LCCOMB_X55_Y50_N30
\controller|Selector2~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \controller|Selector2~0_combout\ = ((\controller|atual.SAVE_C~q\) # ((!\enter~input_o\ & \controller|atual.RESULT~q\))) # (!\controller|atual.INIT~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111101001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \enter~input_o\,
	datab => \controller|atual.RESULT~q\,
	datac => \controller|atual.INIT~q\,
	datad => \controller|atual.SAVE_C~q\,
	combout => \controller|Selector2~0_combout\);

-- Location: LCCOMB_X55_Y50_N12
\controller|Selector2~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \controller|Selector2~1_combout\ = (\controller|Selector2~0_combout\) # ((\controller|atual.MENU~q\ & ((\enter~input_o\) # (\controller|prox~16_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101011101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \controller|Selector2~0_combout\,
	datab => \enter~input_o\,
	datac => \controller|atual.MENU~q\,
	datad => \controller|prox~16_combout\,
	combout => \controller|Selector2~1_combout\);

-- Location: FF_X55_Y50_N13
\controller|atual.MENU\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock_div|tick~clkctrl_outclk\,
	d => \controller|Selector2~1_combout\,
	clrn => \reset~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \controller|atual.MENU~q\);

-- Location: LCCOMB_X54_Y52_N20
\controller|Selector10~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \controller|Selector10~0_combout\ = (\sw[0]~input_o\ & (\controller|atual.MENU~q\ & (\datapath|reg_c|loaded~q\ & !\enter~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \sw[0]~input_o\,
	datab => \controller|atual.MENU~q\,
	datac => \datapath|reg_c|loaded~q\,
	datad => \enter~input_o\,
	combout => \controller|Selector10~0_combout\);

-- Location: LCCOMB_X54_Y52_N14
\controller|Selector10~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \controller|Selector10~3_combout\ = (\controller|atual.ATTEMPT_D~q\ & ((\enter~input_o\) # ((\controller|prox~16_combout\ & \controller|atual.MENU~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \enter~input_o\,
	datab => \controller|atual.ATTEMPT_D~q\,
	datac => \controller|prox~16_combout\,
	datad => \controller|atual.MENU~q\,
	combout => \controller|Selector10~3_combout\);

-- Location: LCCOMB_X54_Y52_N0
\controller|Selector10~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \controller|Selector10~4_combout\ = (\controller|Selector10~0_combout\) # ((\controller|Selector10~1_combout\ & (\controller|Selector10~3_combout\ & \controller|Selector10~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \controller|Selector10~0_combout\,
	datab => \controller|Selector10~1_combout\,
	datac => \controller|Selector10~3_combout\,
	datad => \controller|Selector10~2_combout\,
	combout => \controller|Selector10~4_combout\);

-- Location: FF_X54_Y52_N1
\controller|atual.ATTEMPT_D\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock_div|tick~clkctrl_outclk\,
	d => \controller|Selector10~4_combout\,
	clrn => \reset~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \controller|atual.ATTEMPT_D~q\);

-- Location: LCCOMB_X54_Y51_N0
\controller|Selector14~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \controller|Selector14~0_combout\ = (!\enter~input_o\ & (\sw[1]~input_o\ & (\controller|atual.SEL_OP_D~q\ & !\sw[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \enter~input_o\,
	datab => \sw[1]~input_o\,
	datac => \controller|atual.SEL_OP_D~q\,
	datad => \sw[0]~input_o\,
	combout => \controller|Selector14~0_combout\);

-- Location: FF_X54_Y51_N1
\controller|atual.ROR_D\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock_div|tick~clkctrl_outclk\,
	d => \controller|Selector14~0_combout\,
	clrn => \reset~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \controller|atual.ROR_D~q\);

-- Location: LCCOMB_X54_Y52_N12
\controller|WideOr13~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \controller|WideOr13~0_combout\ = (!\controller|atual.ATTEMPT_D~q\ & !\controller|atual.ROR_D~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000110011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \controller|atual.ATTEMPT_D~q\,
	datad => \controller|atual.ROR_D~q\,
	combout => \controller|WideOr13~0_combout\);

-- Location: LCCOMB_X54_Y51_N22
\controller|Selector15~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \controller|Selector15~0_combout\ = (!\enter~input_o\ & (\sw[1]~input_o\ & (\controller|atual.SEL_OP_D~q\ & \sw[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \enter~input_o\,
	datab => \sw[1]~input_o\,
	datac => \controller|atual.SEL_OP_D~q\,
	datad => \sw[0]~input_o\,
	combout => \controller|Selector15~0_combout\);

-- Location: FF_X54_Y51_N23
\controller|atual.PERM_D\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock_div|tick~clkctrl_outclk\,
	d => \controller|Selector15~0_combout\,
	clrn => \reset~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \controller|atual.PERM_D~q\);

-- Location: LCCOMB_X52_Y51_N20
\controller|Selector13~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \controller|Selector13~0_combout\ = (!\enter~input_o\ & \controller|atual.TRY_K~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \enter~input_o\,
	datad => \controller|atual.TRY_K~q\,
	combout => \controller|Selector13~0_combout\);

-- Location: FF_X52_Y51_N21
\controller|atual.XOR_D\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock_div|tick~clkctrl_outclk\,
	d => \controller|Selector13~0_combout\,
	clrn => \reset~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \controller|atual.XOR_D~q\);

-- Location: LCCOMB_X54_Y50_N16
\controller|WideOr14~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \controller|WideOr14~2_combout\ = (!\controller|atual.PERM_D~q\ & !\controller|atual.XOR_D~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001010101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \controller|atual.PERM_D~q\,
	datad => \controller|atual.XOR_D~q\,
	combout => \controller|WideOr14~2_combout\);

-- Location: LCCOMB_X54_Y50_N4
\controller|Selector11~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \controller|Selector11~0_combout\ = (((\enter~input_o\ & \controller|atual.SEL_OP_D~q\)) # (!\controller|WideOr14~2_combout\)) # (!\controller|WideOr13~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011001111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \enter~input_o\,
	datab => \controller|WideOr13~0_combout\,
	datac => \controller|atual.SEL_OP_D~q\,
	datad => \controller|WideOr14~2_combout\,
	combout => \controller|Selector11~0_combout\);

-- Location: FF_X54_Y50_N5
\controller|atual.SEL_OP_D\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock_div|tick~clkctrl_outclk\,
	d => \controller|Selector11~0_combout\,
	clrn => \reset~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \controller|atual.SEL_OP_D~q\);

-- Location: LCCOMB_X54_Y50_N12
\controller|Selector12~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \controller|Selector12~0_combout\ = (!\sw[1]~input_o\ & (\controller|atual.SEL_OP_D~q\ & (!\enter~input_o\ & \sw[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \sw[1]~input_o\,
	datab => \controller|atual.SEL_OP_D~q\,
	datac => \enter~input_o\,
	datad => \sw[0]~input_o\,
	combout => \controller|Selector12~0_combout\);

-- Location: LCCOMB_X54_Y50_N26
\controller|Selector12~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \controller|Selector12~1_combout\ = (\controller|Selector12~0_combout\) # ((\enter~input_o\ & \controller|atual.TRY_K~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \enter~input_o\,
	datac => \controller|atual.TRY_K~q\,
	datad => \controller|Selector12~0_combout\,
	combout => \controller|Selector12~1_combout\);

-- Location: FF_X54_Y50_N27
\controller|atual.TRY_K\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock_div|tick~clkctrl_outclk\,
	d => \controller|Selector12~1_combout\,
	clrn => \reset~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \controller|atual.TRY_K~q\);

-- Location: LCCOMB_X55_Y52_N6
\datapath|reg_k|Q[1]~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_k|Q[1]~0_combout\ = (\controller|Selector0~0_combout\) # ((!\enter~input_o\ & ((\controller|atual.TRY_K~q\) # (\controller|atual.INSERT_K~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100110010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \controller|atual.TRY_K~q\,
	datab => \enter~input_o\,
	datac => \controller|atual.INSERT_K~q\,
	datad => \controller|Selector0~0_combout\,
	combout => \datapath|reg_k|Q[1]~0_combout\);

-- Location: FF_X55_Y52_N25
\datapath|reg_k|Q[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock_div|tick~clkctrl_outclk\,
	asdata => \datapath|reg_v|Q~3_combout\,
	sload => VCC,
	ena => \datapath|reg_k|Q[1]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \datapath|reg_k|Q\(0));

-- Location: LCCOMB_X55_Y52_N24
\datapath|xor_maker|X[0]\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|xor_maker|X\(0) = \datapath|reg_k|Q\(0) $ (\datapath|reg_x|Q\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \datapath|reg_k|Q\(0),
	datad => \datapath|reg_x|Q\(0),
	combout => \datapath|xor_maker|X\(0));

-- Location: LCCOMB_X54_Y51_N18
\controller|WideOr8~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \controller|WideOr8~0_combout\ = (\controller|atual.ROL_C~q\) # ((\controller|atual.ROR_D~q\) # ((\controller|atual.PERM_D~q\) # (\controller|atual.PERM_C~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \controller|atual.ROL_C~q\,
	datab => \controller|atual.ROR_D~q\,
	datac => \controller|atual.PERM_D~q\,
	datad => \controller|atual.PERM_C~q\,
	combout => \controller|WideOr8~0_combout\);

-- Location: LCCOMB_X54_Y51_N8
\datapath|reg_x|Q[0]~10\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_x|Q[0]~10_combout\ = (!\controller|atual.PERM_D~q\ & (!\controller|atual.XOR_C~q\ & (!\controller|atual.XOR_D~q\ & !\controller|atual.PERM_C~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \controller|atual.PERM_D~q\,
	datab => \controller|atual.XOR_C~q\,
	datac => \controller|atual.XOR_D~q\,
	datad => \controller|atual.PERM_C~q\,
	combout => \datapath|reg_x|Q[0]~10_combout\);

-- Location: LCCOMB_X55_Y51_N10
\datapath|reg_x|Q[0]~15\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_x|Q[0]~15_combout\ = (!\controller|WideOr8~0_combout\ & !\datapath|reg_x|Q[0]~10_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000110011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \controller|WideOr8~0_combout\,
	datad => \datapath|reg_x|Q[0]~10_combout\,
	combout => \datapath|reg_x|Q[0]~15_combout\);

-- Location: LCCOMB_X54_Y51_N6
\datapath|reg_x|Q[0]~11\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_x|Q[0]~11_combout\ = (\controller|WideOr8~0_combout\ & ((!\datapath|reg_x|Q[0]~10_combout\) # (!\controller|atual.ROR_D~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \controller|atual.ROR_D~q\,
	datac => \datapath|reg_x|Q[0]~10_combout\,
	datad => \controller|WideOr8~0_combout\,
	combout => \datapath|reg_x|Q[0]~11_combout\);

-- Location: LCCOMB_X55_Y52_N26
\datapath|reg_v|Q~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_v|Q~2_combout\ = (\sw[1]~input_o\ & !\controller|Selector0~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000101000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \sw[1]~input_o\,
	datac => \controller|Selector0~0_combout\,
	combout => \datapath|reg_v|Q~2_combout\);

-- Location: FF_X55_Y52_N27
\datapath|reg_k|Q[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock_div|tick~clkctrl_outclk\,
	d => \datapath|reg_v|Q~2_combout\,
	ena => \datapath|reg_k|Q[1]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \datapath|reg_k|Q\(1));

-- Location: LCCOMB_X55_Y52_N28
\datapath|xor_maker|X[1]\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|xor_maker|X\(1) = \datapath|reg_x|Q\(1) $ (\datapath|reg_k|Q\(1))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \datapath|reg_x|Q\(1),
	datad => \datapath|reg_k|Q\(1),
	combout => \datapath|xor_maker|X\(1));

-- Location: LCCOMB_X54_Y51_N4
\datapath|reg_x|Q[0]~12\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_x|Q[0]~12_combout\ = (!\controller|WideOr8~0_combout\) # (!\datapath|reg_x|Q[0]~10_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \datapath|reg_x|Q[0]~10_combout\,
	datad => \controller|WideOr8~0_combout\,
	combout => \datapath|reg_x|Q[0]~12_combout\);

-- Location: IOIBUF_X56_Y54_N1
\sw[8]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_sw(8),
	o => \sw[8]~input_o\);

-- Location: LCCOMB_X55_Y52_N16
\datapath|reg_v|Q~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_v|Q~1_combout\ = (\sw[8]~input_o\ & !\controller|Selector0~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \sw[8]~input_o\,
	datad => \controller|Selector0~0_combout\,
	combout => \datapath|reg_v|Q~1_combout\);

-- Location: LCCOMB_X55_Y52_N12
\datapath|reg_k|Q[8]~feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_k|Q[8]~feeder_combout\ = \datapath|reg_v|Q~1_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \datapath|reg_v|Q~1_combout\,
	combout => \datapath|reg_k|Q[8]~feeder_combout\);

-- Location: FF_X55_Y52_N13
\datapath|reg_k|Q[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock_div|tick~clkctrl_outclk\,
	d => \datapath|reg_k|Q[8]~feeder_combout\,
	ena => \datapath|reg_k|Q[1]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \datapath|reg_k|Q\(8));

-- Location: LCCOMB_X56_Y52_N6
\datapath|xor_maker|X[8]\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|xor_maker|X\(8) = \datapath|reg_x|Q\(8) $ (\datapath|reg_k|Q\(8))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \datapath|reg_x|Q\(8),
	datad => \datapath|reg_k|Q\(8),
	combout => \datapath|xor_maker|X\(8));

-- Location: IOIBUF_X49_Y54_N1
\sw[5]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_sw(5),
	o => \sw[5]~input_o\);

-- Location: LCCOMB_X55_Y52_N22
\datapath|reg_v|Q~6\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_v|Q~6_combout\ = (\sw[5]~input_o\ & !\controller|Selector0~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \sw[5]~input_o\,
	datad => \controller|Selector0~0_combout\,
	combout => \datapath|reg_v|Q~6_combout\);

-- Location: FF_X55_Y52_N17
\datapath|reg_k|Q[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock_div|tick~clkctrl_outclk\,
	asdata => \datapath|reg_v|Q~6_combout\,
	sload => VCC,
	ena => \datapath|reg_k|Q[1]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \datapath|reg_k|Q\(5));

-- Location: LCCOMB_X56_Y51_N2
\datapath|xor_maker|X[5]\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|xor_maker|X\(5) = \datapath|reg_k|Q\(5) $ (\datapath|reg_x|Q\(5))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \datapath|reg_k|Q\(5),
	datac => \datapath|reg_x|Q\(5),
	combout => \datapath|xor_maker|X\(5));

-- Location: IOIBUF_X54_Y54_N22
\sw[4]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_sw(4),
	o => \sw[4]~input_o\);

-- Location: LCCOMB_X55_Y52_N0
\datapath|reg_v|Q~7\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_v|Q~7_combout\ = (\sw[4]~input_o\ & !\controller|Selector0~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \sw[4]~input_o\,
	datad => \controller|Selector0~0_combout\,
	combout => \datapath|reg_v|Q~7_combout\);

-- Location: FF_X55_Y52_N9
\datapath|reg_k|Q[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock_div|tick~clkctrl_outclk\,
	asdata => \datapath|reg_v|Q~7_combout\,
	sload => VCC,
	ena => \datapath|reg_k|Q[1]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \datapath|reg_k|Q\(4));

-- Location: LCCOMB_X55_Y52_N30
\datapath|xor_maker|X[4]\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|xor_maker|X\(4) = \datapath|reg_x|Q\(4) $ (\datapath|reg_k|Q\(4))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \datapath|reg_x|Q\(4),
	datad => \datapath|reg_k|Q\(4),
	combout => \datapath|xor_maker|X\(4));

-- Location: IOIBUF_X58_Y54_N29
\sw[7]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_sw(7),
	o => \sw[7]~input_o\);

-- Location: LCCOMB_X56_Y52_N8
\datapath|reg_v|Q~8\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_v|Q~8_combout\ = (\sw[7]~input_o\ & !\controller|Selector0~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \sw[7]~input_o\,
	datad => \controller|Selector0~0_combout\,
	combout => \datapath|reg_v|Q~8_combout\);

-- Location: FF_X56_Y52_N9
\datapath|reg_k|Q[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock_div|tick~clkctrl_outclk\,
	d => \datapath|reg_v|Q~8_combout\,
	ena => \datapath|reg_k|Q[1]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \datapath|reg_k|Q\(7));

-- Location: LCCOMB_X56_Y51_N30
\datapath|xor_maker|X[7]\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|xor_maker|X\(7) = \datapath|reg_x|Q\(7) $ (\datapath|reg_k|Q\(7))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \datapath|reg_x|Q\(7),
	datad => \datapath|reg_k|Q\(7),
	combout => \datapath|xor_maker|X\(7));

-- Location: IOIBUF_X54_Y54_N15
\sw[6]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_sw(6),
	o => \sw[6]~input_o\);

-- Location: LCCOMB_X55_Y52_N2
\datapath|reg_v|Q~9\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_v|Q~9_combout\ = (!\controller|Selector0~0_combout\ & \sw[6]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \controller|Selector0~0_combout\,
	datad => \sw[6]~input_o\,
	combout => \datapath|reg_v|Q~9_combout\);

-- Location: FF_X55_Y52_N3
\datapath|reg_k|Q[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock_div|tick~clkctrl_outclk\,
	d => \datapath|reg_v|Q~9_combout\,
	ena => \datapath|reg_k|Q[1]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \datapath|reg_k|Q\(6));

-- Location: LCCOMB_X55_Y51_N8
\datapath|xor_maker|X[6]\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|xor_maker|X\(6) = \datapath|reg_x|Q\(6) $ (\datapath|reg_k|Q\(6))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010110101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \datapath|reg_x|Q\(6),
	datad => \datapath|reg_k|Q\(6),
	combout => \datapath|xor_maker|X\(6));

-- Location: IOIBUF_X54_Y54_N29
\sw[3]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_sw(3),
	o => \sw[3]~input_o\);

-- Location: LCCOMB_X55_Y52_N14
\datapath|reg_v|Q~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_v|Q~4_combout\ = (!\controller|Selector0~0_combout\ & \sw[3]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \controller|Selector0~0_combout\,
	datad => \sw[3]~input_o\,
	combout => \datapath|reg_v|Q~4_combout\);

-- Location: FF_X55_Y52_N15
\datapath|reg_k|Q[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock_div|tick~clkctrl_outclk\,
	d => \datapath|reg_v|Q~4_combout\,
	ena => \datapath|reg_k|Q[1]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \datapath|reg_k|Q\(3));

-- Location: LCCOMB_X56_Y52_N30
\datapath|xor_maker|X[3]\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|xor_maker|X\(3) = \datapath|reg_k|Q\(3) $ (\datapath|reg_x|Q\(3))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010110101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \datapath|reg_k|Q\(3),
	datad => \datapath|reg_x|Q\(3),
	combout => \datapath|xor_maker|X\(3));

-- Location: IOIBUF_X51_Y54_N1
\sw[2]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_sw(2),
	o => \sw[2]~input_o\);

-- Location: LCCOMB_X55_Y52_N8
\datapath|reg_v|Q~5\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_v|Q~5_combout\ = (\sw[2]~input_o\ & !\controller|Selector0~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \sw[2]~input_o\,
	datad => \controller|Selector0~0_combout\,
	combout => \datapath|reg_v|Q~5_combout\);

-- Location: LCCOMB_X55_Y52_N20
\datapath|reg_k|Q[2]~feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_k|Q[2]~feeder_combout\ = \datapath|reg_v|Q~5_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \datapath|reg_v|Q~5_combout\,
	combout => \datapath|reg_k|Q[2]~feeder_combout\);

-- Location: FF_X55_Y52_N21
\datapath|reg_k|Q[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock_div|tick~clkctrl_outclk\,
	d => \datapath|reg_k|Q[2]~feeder_combout\,
	ena => \datapath|reg_k|Q[1]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \datapath|reg_k|Q\(2));

-- Location: LCCOMB_X55_Y52_N4
\datapath|xor_maker|X[2]\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|xor_maker|X\(2) = \datapath|reg_k|Q\(2) $ (\datapath|reg_x|Q\(2))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \datapath|reg_k|Q\(2),
	datad => \datapath|reg_x|Q\(2),
	combout => \datapath|xor_maker|X\(2));

-- Location: IOIBUF_X69_Y54_N1
\sw[9]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_sw(9),
	o => \sw[9]~input_o\);

-- Location: LCCOMB_X56_Y52_N28
\datapath|reg_v|Q~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_v|Q~0_combout\ = (\sw[9]~input_o\ & !\controller|Selector0~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \sw[9]~input_o\,
	datad => \controller|Selector0~0_combout\,
	combout => \datapath|reg_v|Q~0_combout\);

-- Location: LCCOMB_X56_Y52_N12
\datapath|reg_k|Q[9]~feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_k|Q[9]~feeder_combout\ = \datapath|reg_v|Q~0_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \datapath|reg_v|Q~0_combout\,
	combout => \datapath|reg_k|Q[9]~feeder_combout\);

-- Location: FF_X56_Y52_N13
\datapath|reg_k|Q[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock_div|tick~clkctrl_outclk\,
	d => \datapath|reg_k|Q[9]~feeder_combout\,
	ena => \datapath|reg_k|Q[1]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \datapath|reg_k|Q\(9));

-- Location: LCCOMB_X56_Y51_N24
\datapath|xor_maker|X[9]\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|xor_maker|X\(9) = \datapath|reg_x|Q\(9) $ (\datapath|reg_k|Q\(9))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \datapath|reg_x|Q\(9),
	datad => \datapath|reg_k|Q\(9),
	combout => \datapath|xor_maker|X\(9));

-- Location: LCCOMB_X56_Y51_N28
\datapath|reg_x|Q~37\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_x|Q~37_combout\ = (\datapath|reg_x|Q[0]~12_combout\ & (((\datapath|reg_x|Q[0]~11_combout\)))) # (!\datapath|reg_x|Q[0]~12_combout\ & ((\datapath|reg_x|Q[0]~11_combout\ & (\datapath|reg_x|Q\(6))) # (!\datapath|reg_x|Q[0]~11_combout\ & 
-- ((\datapath|reg_x|Q\(2))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \datapath|reg_x|Q\(6),
	datab => \datapath|reg_x|Q\(2),
	datac => \datapath|reg_x|Q[0]~12_combout\,
	datad => \datapath|reg_x|Q[0]~11_combout\,
	combout => \datapath|reg_x|Q~37_combout\);

-- Location: LCCOMB_X56_Y51_N6
\datapath|reg_x|Q~38\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_x|Q~38_combout\ = (\datapath|reg_x|Q[0]~12_combout\ & ((\datapath|reg_x|Q~37_combout\ & ((\datapath|reg_x|Q\(8)))) # (!\datapath|reg_x|Q~37_combout\ & (\sw[9]~input_o\)))) # (!\datapath|reg_x|Q[0]~12_combout\ & 
-- (((\datapath|reg_x|Q~37_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \sw[9]~input_o\,
	datab => \datapath|reg_x|Q\(8),
	datac => \datapath|reg_x|Q[0]~12_combout\,
	datad => \datapath|reg_x|Q~37_combout\,
	combout => \datapath|reg_x|Q~38_combout\);

-- Location: LCCOMB_X56_Y51_N26
\datapath|reg_x|Q[9]~9\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_x|Q[9]~9_combout\ = (\datapath|reg_x|Q[0]~15_combout\ & (\datapath|xor_maker|X\(9))) # (!\datapath|reg_x|Q[0]~15_combout\ & ((\datapath|reg_x|Q~38_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \datapath|reg_x|Q[0]~15_combout\,
	datab => \datapath|xor_maker|X\(9),
	datad => \datapath|reg_x|Q~38_combout\,
	combout => \datapath|reg_x|Q[9]~9_combout\);

-- Location: LCCOMB_X52_Y51_N2
\datapath|reg_c|Q~10\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_c|Q~10_combout\ = (\datapath|reg_x|Q\(9) & !\controller|Selector0~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \datapath|reg_x|Q\(9),
	datad => \controller|Selector0~0_combout\,
	combout => \datapath|reg_c|Q~10_combout\);

-- Location: LCCOMB_X52_Y51_N26
\datapath|reg_c|Q[5]~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_c|Q[5]~1_combout\ = (\controller|atual.SAVE_C~q\) # (\controller|Selector0~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \controller|atual.SAVE_C~q\,
	datad => \controller|Selector0~0_combout\,
	combout => \datapath|reg_c|Q[5]~1_combout\);

-- Location: FF_X52_Y51_N3
\datapath|reg_c|Q[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock_div|tick~clkctrl_outclk\,
	d => \datapath|reg_c|Q~10_combout\,
	ena => \datapath|reg_c|Q[5]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \datapath|reg_c|Q\(9));

-- Location: LCCOMB_X55_Y50_N0
\datapath|reg_x|Q[0]~16\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_x|Q[0]~16_combout\ = (\controller|Selector0~0_combout\) # ((\controller|atual.INSERT_V~q\ & !\enter~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \controller|atual.INSERT_V~q\,
	datac => \enter~input_o\,
	datad => \controller|Selector0~0_combout\,
	combout => \datapath|reg_x|Q[0]~16_combout\);

-- Location: LCCOMB_X55_Y51_N28
\datapath|reg_x|Q[0]~17\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_x|Q[0]~17_combout\ = ((\controller|atual.ROL_C~q\) # ((\datapath|reg_x|Q[0]~16_combout\) # (!\controller|WideOr13~0_combout\))) # (!\datapath|reg_x|Q[0]~10_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111011111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \datapath|reg_x|Q[0]~10_combout\,
	datab => \controller|atual.ROL_C~q\,
	datac => \controller|WideOr13~0_combout\,
	datad => \datapath|reg_x|Q[0]~16_combout\,
	combout => \datapath|reg_x|Q[0]~17_combout\);

-- Location: FF_X56_Y51_N27
\datapath|reg_x|Q[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock_div|tick~clkctrl_outclk\,
	d => \datapath|reg_x|Q[9]~9_combout\,
	asdata => \datapath|reg_c|Q\(9),
	sclr => \controller|Selector0~0_combout\,
	sload => \controller|atual.ATTEMPT_D~q\,
	ena => \datapath|reg_x|Q[0]~17_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \datapath|reg_x|Q\(9));

-- Location: LCCOMB_X56_Y51_N12
\datapath|reg_x|Q~21\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_x|Q~21_combout\ = (\datapath|reg_x|Q\(5) & \controller|atual.ROR_D~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \datapath|reg_x|Q\(5),
	datad => \controller|atual.ROR_D~q\,
	combout => \datapath|reg_x|Q~21_combout\);

-- Location: LCCOMB_X55_Y51_N30
\datapath|reg_x|Q~22\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_x|Q~22_combout\ = (\controller|WideOr8~0_combout\ & (((\datapath|reg_x|Q~21_combout\)) # (!\datapath|reg_x|Q[0]~10_combout\))) # (!\controller|WideOr8~0_combout\ & (((\sw[2]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \datapath|reg_x|Q[0]~10_combout\,
	datab => \sw[2]~input_o\,
	datac => \datapath|reg_x|Q~21_combout\,
	datad => \controller|WideOr8~0_combout\,
	combout => \datapath|reg_x|Q~22_combout\);

-- Location: LCCOMB_X55_Y51_N24
\datapath|reg_x|Q~23\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_x|Q~23_combout\ = (\datapath|reg_x|Q~22_combout\ & ((\datapath|reg_x|Q\(3)) # ((!\datapath|reg_x|Q[0]~11_combout\)))) # (!\datapath|reg_x|Q~22_combout\ & (((\datapath|reg_x|Q\(9) & \datapath|reg_x|Q[0]~11_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010110011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \datapath|reg_x|Q\(3),
	datab => \datapath|reg_x|Q\(9),
	datac => \datapath|reg_x|Q~22_combout\,
	datad => \datapath|reg_x|Q[0]~11_combout\,
	combout => \datapath|reg_x|Q~23_combout\);

-- Location: LCCOMB_X55_Y51_N14
\datapath|reg_x|Q[2]~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_x|Q[2]~2_combout\ = (\datapath|reg_x|Q[0]~15_combout\ & (\datapath|xor_maker|X\(2))) # (!\datapath|reg_x|Q[0]~15_combout\ & ((\datapath|reg_x|Q~23_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \datapath|reg_x|Q[0]~15_combout\,
	datab => \datapath|xor_maker|X\(2),
	datad => \datapath|reg_x|Q~23_combout\,
	combout => \datapath|reg_x|Q[2]~2_combout\);

-- Location: LCCOMB_X52_Y51_N4
\datapath|reg_c|Q~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_c|Q~3_combout\ = (\datapath|reg_x|Q\(2) & !\controller|Selector0~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \datapath|reg_x|Q\(2),
	datad => \controller|Selector0~0_combout\,
	combout => \datapath|reg_c|Q~3_combout\);

-- Location: FF_X52_Y51_N5
\datapath|reg_c|Q[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock_div|tick~clkctrl_outclk\,
	d => \datapath|reg_c|Q~3_combout\,
	ena => \datapath|reg_c|Q[5]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \datapath|reg_c|Q\(2));

-- Location: FF_X55_Y51_N15
\datapath|reg_x|Q[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock_div|tick~clkctrl_outclk\,
	d => \datapath|reg_x|Q[2]~2_combout\,
	asdata => \datapath|reg_c|Q\(2),
	sclr => \controller|Selector0~0_combout\,
	sload => \controller|atual.ATTEMPT_D~q\,
	ena => \datapath|reg_x|Q[0]~17_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \datapath|reg_x|Q\(2));

-- Location: LCCOMB_X56_Y51_N18
\datapath|reg_x|Q~24\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_x|Q~24_combout\ = (\datapath|reg_x|Q[0]~12_combout\ & (((\datapath|reg_x|Q[0]~11_combout\)))) # (!\datapath|reg_x|Q[0]~12_combout\ & ((\datapath|reg_x|Q[0]~11_combout\ & ((\datapath|reg_x|Q\(0)))) # (!\datapath|reg_x|Q[0]~11_combout\ & 
-- (\datapath|reg_x|Q\(6)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \datapath|reg_x|Q\(6),
	datab => \datapath|reg_x|Q\(0),
	datac => \datapath|reg_x|Q[0]~12_combout\,
	datad => \datapath|reg_x|Q[0]~11_combout\,
	combout => \datapath|reg_x|Q~24_combout\);

-- Location: LCCOMB_X56_Y51_N0
\datapath|reg_x|Q~25\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_x|Q~25_combout\ = (\datapath|reg_x|Q[0]~12_combout\ & ((\datapath|reg_x|Q~24_combout\ & ((\datapath|reg_x|Q\(2)))) # (!\datapath|reg_x|Q~24_combout\ & (\sw[3]~input_o\)))) # (!\datapath|reg_x|Q[0]~12_combout\ & 
-- (((\datapath|reg_x|Q~24_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \sw[3]~input_o\,
	datab => \datapath|reg_x|Q\(2),
	datac => \datapath|reg_x|Q[0]~12_combout\,
	datad => \datapath|reg_x|Q~24_combout\,
	combout => \datapath|reg_x|Q~25_combout\);

-- Location: LCCOMB_X56_Y51_N4
\datapath|reg_x|Q[3]~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_x|Q[3]~3_combout\ = (\datapath|reg_x|Q[0]~15_combout\ & (\datapath|xor_maker|X\(3))) # (!\datapath|reg_x|Q[0]~15_combout\ & ((\datapath|reg_x|Q~25_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \datapath|reg_x|Q[0]~15_combout\,
	datab => \datapath|xor_maker|X\(3),
	datad => \datapath|reg_x|Q~25_combout\,
	combout => \datapath|reg_x|Q[3]~3_combout\);

-- Location: LCCOMB_X52_Y51_N14
\datapath|reg_c|Q~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_c|Q~4_combout\ = (\datapath|reg_x|Q\(3) & !\controller|Selector0~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \datapath|reg_x|Q\(3),
	datad => \controller|Selector0~0_combout\,
	combout => \datapath|reg_c|Q~4_combout\);

-- Location: FF_X52_Y51_N15
\datapath|reg_c|Q[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock_div|tick~clkctrl_outclk\,
	d => \datapath|reg_c|Q~4_combout\,
	ena => \datapath|reg_c|Q[5]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \datapath|reg_c|Q\(3));

-- Location: FF_X56_Y51_N5
\datapath|reg_x|Q[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock_div|tick~clkctrl_outclk\,
	d => \datapath|reg_x|Q[3]~3_combout\,
	asdata => \datapath|reg_c|Q\(3),
	sclr => \controller|Selector0~0_combout\,
	sload => \controller|atual.ATTEMPT_D~q\,
	ena => \datapath|reg_x|Q[0]~17_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \datapath|reg_x|Q\(3));

-- Location: LCCOMB_X54_Y51_N2
\datapath|reg_x|Q~30\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_x|Q~30_combout\ = (\datapath|reg_x|Q[0]~12_combout\ & (((\sw[6]~input_o\) # (\datapath|reg_x|Q[0]~11_combout\)))) # (!\datapath|reg_x|Q[0]~12_combout\ & (\datapath|reg_x|Q\(9) & ((!\datapath|reg_x|Q[0]~11_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \datapath|reg_x|Q\(9),
	datab => \sw[6]~input_o\,
	datac => \datapath|reg_x|Q[0]~12_combout\,
	datad => \datapath|reg_x|Q[0]~11_combout\,
	combout => \datapath|reg_x|Q~30_combout\);

-- Location: LCCOMB_X54_Y51_N20
\datapath|reg_x|Q~31\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_x|Q~31_combout\ = (\datapath|reg_x|Q[0]~11_combout\ & ((\datapath|reg_x|Q~30_combout\ & ((\datapath|reg_x|Q\(7)))) # (!\datapath|reg_x|Q~30_combout\ & (\datapath|reg_x|Q\(3))))) # (!\datapath|reg_x|Q[0]~11_combout\ & 
-- (((\datapath|reg_x|Q~30_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \datapath|reg_x|Q\(3),
	datab => \datapath|reg_x|Q\(7),
	datac => \datapath|reg_x|Q[0]~11_combout\,
	datad => \datapath|reg_x|Q~30_combout\,
	combout => \datapath|reg_x|Q~31_combout\);

-- Location: LCCOMB_X55_Y51_N26
\datapath|reg_x|Q[6]~6\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_x|Q[6]~6_combout\ = (\datapath|reg_x|Q[0]~15_combout\ & (\datapath|xor_maker|X\(6))) # (!\datapath|reg_x|Q[0]~15_combout\ & ((\datapath|reg_x|Q~31_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \datapath|reg_x|Q[0]~15_combout\,
	datab => \datapath|xor_maker|X\(6),
	datad => \datapath|reg_x|Q~31_combout\,
	combout => \datapath|reg_x|Q[6]~6_combout\);

-- Location: LCCOMB_X52_Y51_N12
\datapath|reg_c|Q~7\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_c|Q~7_combout\ = (\datapath|reg_x|Q\(6) & !\controller|Selector0~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \datapath|reg_x|Q\(6),
	datad => \controller|Selector0~0_combout\,
	combout => \datapath|reg_c|Q~7_combout\);

-- Location: FF_X52_Y51_N13
\datapath|reg_c|Q[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock_div|tick~clkctrl_outclk\,
	d => \datapath|reg_c|Q~7_combout\,
	ena => \datapath|reg_c|Q[5]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \datapath|reg_c|Q\(6));

-- Location: FF_X55_Y51_N27
\datapath|reg_x|Q[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock_div|tick~clkctrl_outclk\,
	d => \datapath|reg_x|Q[6]~6_combout\,
	asdata => \datapath|reg_c|Q\(6),
	sclr => \controller|Selector0~0_combout\,
	sload => \controller|atual.ATTEMPT_D~q\,
	ena => \datapath|reg_x|Q[0]~17_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \datapath|reg_x|Q\(6));

-- Location: LCCOMB_X54_Y51_N10
\datapath|reg_x|Q~32\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_x|Q~32_combout\ = (\datapath|reg_x|Q[0]~12_combout\ & (((\datapath|reg_x|Q[0]~11_combout\)))) # (!\datapath|reg_x|Q[0]~12_combout\ & ((\datapath|reg_x|Q[0]~11_combout\ & ((\datapath|reg_x|Q\(4)))) # (!\datapath|reg_x|Q[0]~11_combout\ & 
-- (\datapath|reg_x|Q\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \datapath|reg_x|Q\(0),
	datab => \datapath|reg_x|Q\(4),
	datac => \datapath|reg_x|Q[0]~12_combout\,
	datad => \datapath|reg_x|Q[0]~11_combout\,
	combout => \datapath|reg_x|Q~32_combout\);

-- Location: LCCOMB_X56_Y51_N20
\datapath|reg_x|Q~33\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_x|Q~33_combout\ = (\datapath|reg_x|Q[0]~12_combout\ & ((\datapath|reg_x|Q~32_combout\ & (\datapath|reg_x|Q\(6))) # (!\datapath|reg_x|Q~32_combout\ & ((\sw[7]~input_o\))))) # (!\datapath|reg_x|Q[0]~12_combout\ & 
-- (((\datapath|reg_x|Q~32_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010111111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \datapath|reg_x|Q\(6),
	datab => \sw[7]~input_o\,
	datac => \datapath|reg_x|Q[0]~12_combout\,
	datad => \datapath|reg_x|Q~32_combout\,
	combout => \datapath|reg_x|Q~33_combout\);

-- Location: LCCOMB_X56_Y51_N8
\datapath|reg_x|Q[7]~7\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_x|Q[7]~7_combout\ = (\datapath|reg_x|Q[0]~15_combout\ & (\datapath|xor_maker|X\(7))) # (!\datapath|reg_x|Q[0]~15_combout\ & ((\datapath|reg_x|Q~33_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \datapath|reg_x|Q[0]~15_combout\,
	datab => \datapath|xor_maker|X\(7),
	datad => \datapath|reg_x|Q~33_combout\,
	combout => \datapath|reg_x|Q[7]~7_combout\);

-- Location: LCCOMB_X52_Y51_N10
\datapath|reg_c|Q~8\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_c|Q~8_combout\ = (\datapath|reg_x|Q\(7) & !\controller|Selector0~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \datapath|reg_x|Q\(7),
	datad => \controller|Selector0~0_combout\,
	combout => \datapath|reg_c|Q~8_combout\);

-- Location: FF_X52_Y51_N11
\datapath|reg_c|Q[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock_div|tick~clkctrl_outclk\,
	d => \datapath|reg_c|Q~8_combout\,
	ena => \datapath|reg_c|Q[5]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \datapath|reg_c|Q\(7));

-- Location: FF_X56_Y51_N9
\datapath|reg_x|Q[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock_div|tick~clkctrl_outclk\,
	d => \datapath|reg_x|Q[7]~7_combout\,
	asdata => \datapath|reg_c|Q\(7),
	sclr => \controller|Selector0~0_combout\,
	sload => \controller|atual.ATTEMPT_D~q\,
	ena => \datapath|reg_x|Q[0]~17_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \datapath|reg_x|Q\(7));

-- Location: LCCOMB_X54_Y51_N24
\datapath|reg_x|Q~26\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_x|Q~26_combout\ = (\datapath|reg_x|Q[0]~12_combout\ & (((\sw[4]~input_o\) # (\datapath|reg_x|Q[0]~11_combout\)))) # (!\datapath|reg_x|Q[0]~12_combout\ & (\datapath|reg_x|Q\(7) & ((!\datapath|reg_x|Q[0]~11_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \datapath|reg_x|Q\(7),
	datab => \sw[4]~input_o\,
	datac => \datapath|reg_x|Q[0]~12_combout\,
	datad => \datapath|reg_x|Q[0]~11_combout\,
	combout => \datapath|reg_x|Q~26_combout\);

-- Location: LCCOMB_X55_Y51_N6
\datapath|reg_x|Q~27\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_x|Q~27_combout\ = (\datapath|reg_x|Q[0]~11_combout\ & ((\datapath|reg_x|Q~26_combout\ & (\datapath|reg_x|Q\(5))) # (!\datapath|reg_x|Q~26_combout\ & ((\datapath|reg_x|Q\(1)))))) # (!\datapath|reg_x|Q[0]~11_combout\ & 
-- (((\datapath|reg_x|Q~26_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010111111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \datapath|reg_x|Q\(5),
	datab => \datapath|reg_x|Q\(1),
	datac => \datapath|reg_x|Q[0]~11_combout\,
	datad => \datapath|reg_x|Q~26_combout\,
	combout => \datapath|reg_x|Q~27_combout\);

-- Location: LCCOMB_X55_Y51_N16
\datapath|reg_x|Q[4]~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_x|Q[4]~4_combout\ = (\datapath|reg_x|Q[0]~15_combout\ & (\datapath|xor_maker|X\(4))) # (!\datapath|reg_x|Q[0]~15_combout\ & ((\datapath|reg_x|Q~27_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \datapath|xor_maker|X\(4),
	datab => \datapath|reg_x|Q[0]~15_combout\,
	datad => \datapath|reg_x|Q~27_combout\,
	combout => \datapath|reg_x|Q[4]~4_combout\);

-- Location: LCCOMB_X52_Y51_N28
\datapath|reg_c|Q~5\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_c|Q~5_combout\ = (\datapath|reg_x|Q\(4) & !\controller|Selector0~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \datapath|reg_x|Q\(4),
	datad => \controller|Selector0~0_combout\,
	combout => \datapath|reg_c|Q~5_combout\);

-- Location: FF_X52_Y51_N29
\datapath|reg_c|Q[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock_div|tick~clkctrl_outclk\,
	d => \datapath|reg_c|Q~5_combout\,
	ena => \datapath|reg_c|Q[5]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \datapath|reg_c|Q\(4));

-- Location: FF_X55_Y51_N17
\datapath|reg_x|Q[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock_div|tick~clkctrl_outclk\,
	d => \datapath|reg_x|Q[4]~4_combout\,
	asdata => \datapath|reg_c|Q\(4),
	sclr => \controller|Selector0~0_combout\,
	sload => \controller|atual.ATTEMPT_D~q\,
	ena => \datapath|reg_x|Q[0]~17_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \datapath|reg_x|Q\(4));

-- Location: LCCOMB_X56_Y51_N10
\datapath|reg_x|Q~28\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_x|Q~28_combout\ = (\datapath|reg_x|Q[0]~12_combout\ & (((\datapath|reg_x|Q[0]~11_combout\)))) # (!\datapath|reg_x|Q[0]~12_combout\ & ((\datapath|reg_x|Q[0]~11_combout\ & ((\datapath|reg_x|Q\(2)))) # (!\datapath|reg_x|Q[0]~11_combout\ & 
-- (\datapath|reg_x|Q\(8)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \datapath|reg_x|Q\(8),
	datab => \datapath|reg_x|Q\(2),
	datac => \datapath|reg_x|Q[0]~12_combout\,
	datad => \datapath|reg_x|Q[0]~11_combout\,
	combout => \datapath|reg_x|Q~28_combout\);

-- Location: LCCOMB_X56_Y51_N16
\datapath|reg_x|Q~29\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_x|Q~29_combout\ = (\datapath|reg_x|Q[0]~12_combout\ & ((\datapath|reg_x|Q~28_combout\ & ((\datapath|reg_x|Q\(4)))) # (!\datapath|reg_x|Q~28_combout\ & (\sw[5]~input_o\)))) # (!\datapath|reg_x|Q[0]~12_combout\ & 
-- (((\datapath|reg_x|Q~28_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \sw[5]~input_o\,
	datab => \datapath|reg_x|Q\(4),
	datac => \datapath|reg_x|Q[0]~12_combout\,
	datad => \datapath|reg_x|Q~28_combout\,
	combout => \datapath|reg_x|Q~29_combout\);

-- Location: LCCOMB_X56_Y51_N14
\datapath|reg_x|Q[5]~5\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_x|Q[5]~5_combout\ = (\datapath|reg_x|Q[0]~15_combout\ & (\datapath|xor_maker|X\(5))) # (!\datapath|reg_x|Q[0]~15_combout\ & ((\datapath|reg_x|Q~29_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \datapath|reg_x|Q[0]~15_combout\,
	datab => \datapath|xor_maker|X\(5),
	datad => \datapath|reg_x|Q~29_combout\,
	combout => \datapath|reg_x|Q[5]~5_combout\);

-- Location: LCCOMB_X52_Y51_N22
\datapath|reg_c|Q~6\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_c|Q~6_combout\ = (\datapath|reg_x|Q\(5) & !\controller|Selector0~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \datapath|reg_x|Q\(5),
	datad => \controller|Selector0~0_combout\,
	combout => \datapath|reg_c|Q~6_combout\);

-- Location: FF_X52_Y51_N23
\datapath|reg_c|Q[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock_div|tick~clkctrl_outclk\,
	d => \datapath|reg_c|Q~6_combout\,
	ena => \datapath|reg_c|Q[5]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \datapath|reg_c|Q\(5));

-- Location: FF_X56_Y51_N15
\datapath|reg_x|Q[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock_div|tick~clkctrl_outclk\,
	d => \datapath|reg_x|Q[5]~5_combout\,
	asdata => \datapath|reg_c|Q\(5),
	sclr => \controller|Selector0~0_combout\,
	sload => \controller|atual.ATTEMPT_D~q\,
	ena => \datapath|reg_x|Q[0]~17_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \datapath|reg_x|Q\(5));

-- Location: LCCOMB_X55_Y51_N22
\datapath|reg_x|Q~34\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_x|Q~34_combout\ = (\datapath|reg_x|Q\(1) & \controller|atual.ROR_D~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \datapath|reg_x|Q\(1),
	datad => \controller|atual.ROR_D~q\,
	combout => \datapath|reg_x|Q~34_combout\);

-- Location: LCCOMB_X55_Y51_N4
\datapath|reg_x|Q~35\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_x|Q~35_combout\ = (\controller|WideOr8~0_combout\ & (((\datapath|reg_x|Q~34_combout\)) # (!\datapath|reg_x|Q[0]~10_combout\))) # (!\controller|WideOr8~0_combout\ & (((\sw[8]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \datapath|reg_x|Q[0]~10_combout\,
	datab => \sw[8]~input_o\,
	datac => \datapath|reg_x|Q~34_combout\,
	datad => \controller|WideOr8~0_combout\,
	combout => \datapath|reg_x|Q~35_combout\);

-- Location: LCCOMB_X55_Y51_N18
\datapath|reg_x|Q~36\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_x|Q~36_combout\ = (\datapath|reg_x|Q~35_combout\ & (((\datapath|reg_x|Q\(9)) # (!\datapath|reg_x|Q[0]~11_combout\)))) # (!\datapath|reg_x|Q~35_combout\ & (\datapath|reg_x|Q\(5) & ((\datapath|reg_x|Q[0]~11_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100101011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \datapath|reg_x|Q\(5),
	datab => \datapath|reg_x|Q\(9),
	datac => \datapath|reg_x|Q~35_combout\,
	datad => \datapath|reg_x|Q[0]~11_combout\,
	combout => \datapath|reg_x|Q~36_combout\);

-- Location: LCCOMB_X55_Y51_N20
\datapath|reg_x|Q[8]~8\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_x|Q[8]~8_combout\ = (\datapath|reg_x|Q[0]~15_combout\ & (\datapath|xor_maker|X\(8))) # (!\datapath|reg_x|Q[0]~15_combout\ & ((\datapath|reg_x|Q~36_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \datapath|reg_x|Q[0]~15_combout\,
	datab => \datapath|xor_maker|X\(8),
	datad => \datapath|reg_x|Q~36_combout\,
	combout => \datapath|reg_x|Q[8]~8_combout\);

-- Location: LCCOMB_X52_Y51_N24
\datapath|reg_c|Q~9\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_c|Q~9_combout\ = (\datapath|reg_x|Q\(8) & !\controller|Selector0~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \datapath|reg_x|Q\(8),
	datad => \controller|Selector0~0_combout\,
	combout => \datapath|reg_c|Q~9_combout\);

-- Location: FF_X52_Y51_N25
\datapath|reg_c|Q[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock_div|tick~clkctrl_outclk\,
	d => \datapath|reg_c|Q~9_combout\,
	ena => \datapath|reg_c|Q[5]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \datapath|reg_c|Q\(8));

-- Location: FF_X55_Y51_N21
\datapath|reg_x|Q[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock_div|tick~clkctrl_outclk\,
	d => \datapath|reg_x|Q[8]~8_combout\,
	asdata => \datapath|reg_c|Q\(8),
	sclr => \controller|Selector0~0_combout\,
	sload => \controller|atual.ATTEMPT_D~q\,
	ena => \datapath|reg_x|Q[0]~17_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \datapath|reg_x|Q\(8));

-- Location: LCCOMB_X54_Y51_N26
\datapath|reg_x|Q~18\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_x|Q~18_combout\ = (\controller|atual.ROR_D~q\ & ((\datapath|reg_x|Q\(4)))) # (!\controller|atual.ROR_D~q\ & (\datapath|reg_x|Q\(8)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \controller|atual.ROR_D~q\,
	datac => \datapath|reg_x|Q\(8),
	datad => \datapath|reg_x|Q\(4),
	combout => \datapath|reg_x|Q~18_combout\);

-- Location: LCCOMB_X55_Y51_N2
\datapath|reg_x|Q~19\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_x|Q~19_combout\ = (\controller|WideOr8~0_combout\ & ((\datapath|reg_x|Q~18_combout\) # (!\datapath|reg_x|Q[0]~10_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \datapath|reg_x|Q[0]~10_combout\,
	datac => \datapath|reg_x|Q~18_combout\,
	datad => \controller|WideOr8~0_combout\,
	combout => \datapath|reg_x|Q~19_combout\);

-- Location: LCCOMB_X55_Y51_N12
\datapath|reg_x|Q~20\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_x|Q~20_combout\ = (\datapath|reg_x|Q[0]~12_combout\ & ((\datapath|reg_x|Q~19_combout\ & ((\datapath|reg_x|Q\(0)))) # (!\datapath|reg_x|Q~19_combout\ & (\sw[1]~input_o\)))) # (!\datapath|reg_x|Q[0]~12_combout\ & 
-- (((\datapath|reg_x|Q~19_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \sw[1]~input_o\,
	datab => \datapath|reg_x|Q[0]~12_combout\,
	datac => \datapath|reg_x|Q\(0),
	datad => \datapath|reg_x|Q~19_combout\,
	combout => \datapath|reg_x|Q~20_combout\);

-- Location: LCCOMB_X55_Y51_N0
\datapath|reg_x|Q[1]~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_x|Q[1]~1_combout\ = (\datapath|reg_x|Q[0]~15_combout\ & (\datapath|xor_maker|X\(1))) # (!\datapath|reg_x|Q[0]~15_combout\ & ((\datapath|reg_x|Q~20_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \datapath|reg_x|Q[0]~15_combout\,
	datab => \datapath|xor_maker|X\(1),
	datad => \datapath|reg_x|Q~20_combout\,
	combout => \datapath|reg_x|Q[1]~1_combout\);

-- Location: LCCOMB_X52_Y51_N6
\datapath|reg_c|Q~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_c|Q~2_combout\ = (\datapath|reg_x|Q\(1) & !\controller|Selector0~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \datapath|reg_x|Q\(1),
	datad => \controller|Selector0~0_combout\,
	combout => \datapath|reg_c|Q~2_combout\);

-- Location: FF_X52_Y51_N7
\datapath|reg_c|Q[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock_div|tick~clkctrl_outclk\,
	d => \datapath|reg_c|Q~2_combout\,
	ena => \datapath|reg_c|Q[5]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \datapath|reg_c|Q\(1));

-- Location: FF_X55_Y51_N1
\datapath|reg_x|Q[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock_div|tick~clkctrl_outclk\,
	d => \datapath|reg_x|Q[1]~1_combout\,
	asdata => \datapath|reg_c|Q\(1),
	sclr => \controller|Selector0~0_combout\,
	sload => \controller|atual.ATTEMPT_D~q\,
	ena => \datapath|reg_x|Q[0]~17_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \datapath|reg_x|Q\(1));

-- Location: LCCOMB_X54_Y51_N30
\datapath|reg_x|Q~13\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_x|Q~13_combout\ = (\datapath|reg_x|Q[0]~12_combout\ & ((\sw[0]~input_o\) # ((\datapath|reg_x|Q[0]~11_combout\)))) # (!\datapath|reg_x|Q[0]~12_combout\ & (((\datapath|reg_x|Q\(3) & !\datapath|reg_x|Q[0]~11_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000010101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \sw[0]~input_o\,
	datab => \datapath|reg_x|Q\(3),
	datac => \datapath|reg_x|Q[0]~12_combout\,
	datad => \datapath|reg_x|Q[0]~11_combout\,
	combout => \datapath|reg_x|Q~13_combout\);

-- Location: LCCOMB_X54_Y51_N28
\datapath|reg_x|Q~14\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_x|Q~14_combout\ = (\datapath|reg_x|Q[0]~11_combout\ & ((\datapath|reg_x|Q~13_combout\ & (\datapath|reg_x|Q\(1))) # (!\datapath|reg_x|Q~13_combout\ & ((\datapath|reg_x|Q\(7)))))) # (!\datapath|reg_x|Q[0]~11_combout\ & 
-- (((\datapath|reg_x|Q~13_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \datapath|reg_x|Q[0]~11_combout\,
	datab => \datapath|reg_x|Q\(1),
	datac => \datapath|reg_x|Q\(7),
	datad => \datapath|reg_x|Q~13_combout\,
	combout => \datapath|reg_x|Q~14_combout\);

-- Location: LCCOMB_X54_Y51_N16
\datapath|reg_x|Q[0]~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_x|Q[0]~0_combout\ = (\datapath|reg_x|Q[0]~15_combout\ & (\datapath|xor_maker|X\(0))) # (!\datapath|reg_x|Q[0]~15_combout\ & ((\datapath|reg_x|Q~14_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \datapath|xor_maker|X\(0),
	datab => \datapath|reg_x|Q[0]~15_combout\,
	datad => \datapath|reg_x|Q~14_combout\,
	combout => \datapath|reg_x|Q[0]~0_combout\);

-- Location: LCCOMB_X52_Y51_N8
\datapath|reg_c|Q~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|reg_c|Q~0_combout\ = (\datapath|reg_x|Q\(0) & !\controller|Selector0~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \datapath|reg_x|Q\(0),
	datad => \controller|Selector0~0_combout\,
	combout => \datapath|reg_c|Q~0_combout\);

-- Location: FF_X52_Y51_N9
\datapath|reg_c|Q[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock_div|tick~clkctrl_outclk\,
	d => \datapath|reg_c|Q~0_combout\,
	ena => \datapath|reg_c|Q[5]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \datapath|reg_c|Q\(0));

-- Location: FF_X54_Y51_N17
\datapath|reg_x|Q[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock_div|tick~clkctrl_outclk\,
	d => \datapath|reg_x|Q[0]~0_combout\,
	asdata => \datapath|reg_c|Q\(0),
	sclr => \controller|Selector0~0_combout\,
	sload => \controller|atual.ATTEMPT_D~q\,
	ena => \datapath|reg_x|Q[0]~17_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \datapath|reg_x|Q\(0));

-- Location: FF_X56_Y52_N27
\datapath|reg_v|Q[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock_div|tick~clkctrl_outclk\,
	asdata => \datapath|reg_v|Q~1_combout\,
	sload => VCC,
	ena => \datapath|reg_x|Q[0]~16_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \datapath|reg_v|Q\(8));

-- Location: FF_X56_Y52_N29
\datapath|reg_v|Q[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock_div|tick~clkctrl_outclk\,
	d => \datapath|reg_v|Q~0_combout\,
	ena => \datapath|reg_x|Q[0]~16_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \datapath|reg_v|Q\(9));

-- Location: LCCOMB_X56_Y52_N26
\datapath|comp|Equal0~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|comp|Equal0~0_combout\ = (\datapath|reg_x|Q\(9) & (\datapath|reg_v|Q\(9) & (\datapath|reg_x|Q\(8) $ (!\datapath|reg_v|Q\(8))))) # (!\datapath|reg_x|Q\(9) & (!\datapath|reg_v|Q\(9) & (\datapath|reg_x|Q\(8) $ (!\datapath|reg_v|Q\(8)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000001001000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \datapath|reg_x|Q\(9),
	datab => \datapath|reg_x|Q\(8),
	datac => \datapath|reg_v|Q\(8),
	datad => \datapath|reg_v|Q\(9),
	combout => \datapath|comp|Equal0~0_combout\);

-- Location: FF_X56_Y52_N11
\datapath|reg_v|Q[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock_div|tick~clkctrl_outclk\,
	asdata => \datapath|reg_v|Q~8_combout\,
	sload => VCC,
	ena => \datapath|reg_x|Q[0]~16_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \datapath|reg_v|Q\(7));

-- Location: FF_X55_Y52_N23
\datapath|reg_v|Q[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock_div|tick~clkctrl_outclk\,
	asdata => \datapath|reg_v|Q~9_combout\,
	sload => VCC,
	ena => \datapath|reg_x|Q[0]~16_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \datapath|reg_v|Q\(6));

-- Location: LCCOMB_X56_Y52_N10
\datapath|comp|Equal0~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|comp|Equal0~4_combout\ = (\datapath|reg_x|Q\(7) & (\datapath|reg_v|Q\(7) & (\datapath|reg_x|Q\(6) $ (!\datapath|reg_v|Q\(6))))) # (!\datapath|reg_x|Q\(7) & (!\datapath|reg_v|Q\(7) & (\datapath|reg_x|Q\(6) $ (!\datapath|reg_v|Q\(6)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000010000100001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \datapath|reg_x|Q\(7),
	datab => \datapath|reg_x|Q\(6),
	datac => \datapath|reg_v|Q\(7),
	datad => \datapath|reg_v|Q\(6),
	combout => \datapath|comp|Equal0~4_combout\);

-- Location: FF_X55_Y52_N5
\datapath|reg_v|Q[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock_div|tick~clkctrl_outclk\,
	asdata => \datapath|reg_v|Q~2_combout\,
	sload => VCC,
	ena => \datapath|reg_x|Q[0]~16_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \datapath|reg_v|Q\(1));

-- Location: FF_X55_Y52_N19
\datapath|reg_v|Q[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock_div|tick~clkctrl_outclk\,
	asdata => \datapath|reg_v|Q~3_combout\,
	sload => VCC,
	ena => \datapath|reg_x|Q[0]~16_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \datapath|reg_v|Q\(0));

-- Location: LCCOMB_X55_Y52_N18
\datapath|comp|Equal0~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|comp|Equal0~1_combout\ = (\datapath|reg_x|Q\(0) & (\datapath|reg_v|Q\(0) & (\datapath|reg_v|Q\(1) $ (!\datapath|reg_x|Q\(1))))) # (!\datapath|reg_x|Q\(0) & (!\datapath|reg_v|Q\(0) & (\datapath|reg_v|Q\(1) $ (!\datapath|reg_x|Q\(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000010000100001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \datapath|reg_x|Q\(0),
	datab => \datapath|reg_v|Q\(1),
	datac => \datapath|reg_v|Q\(0),
	datad => \datapath|reg_x|Q\(1),
	combout => \datapath|comp|Equal0~1_combout\);

-- Location: FF_X55_Y52_N1
\datapath|reg_v|Q[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock_div|tick~clkctrl_outclk\,
	asdata => \datapath|reg_v|Q~4_combout\,
	sload => VCC,
	ena => \datapath|reg_x|Q[0]~16_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \datapath|reg_v|Q\(3));

-- Location: FF_X55_Y52_N11
\datapath|reg_v|Q[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock_div|tick~clkctrl_outclk\,
	asdata => \datapath|reg_v|Q~5_combout\,
	sload => VCC,
	ena => \datapath|reg_x|Q[0]~16_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \datapath|reg_v|Q\(2));

-- Location: LCCOMB_X55_Y52_N10
\datapath|comp|Equal0~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|comp|Equal0~2_combout\ = (\datapath|reg_x|Q\(3) & (\datapath|reg_v|Q\(3) & (\datapath|reg_v|Q\(2) $ (!\datapath|reg_x|Q\(2))))) # (!\datapath|reg_x|Q\(3) & (!\datapath|reg_v|Q\(3) & (\datapath|reg_v|Q\(2) $ (!\datapath|reg_x|Q\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001000000001001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \datapath|reg_x|Q\(3),
	datab => \datapath|reg_v|Q\(3),
	datac => \datapath|reg_v|Q\(2),
	datad => \datapath|reg_x|Q\(2),
	combout => \datapath|comp|Equal0~2_combout\);

-- Location: FF_X56_Y52_N25
\datapath|reg_v|Q[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock_div|tick~clkctrl_outclk\,
	asdata => \datapath|reg_v|Q~7_combout\,
	sload => VCC,
	ena => \datapath|reg_x|Q[0]~16_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \datapath|reg_v|Q\(4));

-- Location: FF_X55_Y52_N29
\datapath|reg_v|Q[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock_div|tick~clkctrl_outclk\,
	asdata => \datapath|reg_v|Q~6_combout\,
	sload => VCC,
	ena => \datapath|reg_x|Q[0]~16_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \datapath|reg_v|Q\(5));

-- Location: LCCOMB_X56_Y52_N24
\datapath|comp|Equal0~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|comp|Equal0~3_combout\ = (\datapath|reg_x|Q\(4) & (\datapath|reg_v|Q\(4) & (\datapath|reg_x|Q\(5) $ (!\datapath|reg_v|Q\(5))))) # (!\datapath|reg_x|Q\(4) & (!\datapath|reg_v|Q\(4) & (\datapath|reg_x|Q\(5) $ (!\datapath|reg_v|Q\(5)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000010000100001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \datapath|reg_x|Q\(4),
	datab => \datapath|reg_x|Q\(5),
	datac => \datapath|reg_v|Q\(4),
	datad => \datapath|reg_v|Q\(5),
	combout => \datapath|comp|Equal0~3_combout\);

-- Location: LCCOMB_X56_Y52_N20
\datapath|comp|Equal0~5\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|comp|Equal0~5_combout\ = (\datapath|comp|Equal0~4_combout\ & (\datapath|comp|Equal0~1_combout\ & (\datapath|comp|Equal0~2_combout\ & \datapath|comp|Equal0~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \datapath|comp|Equal0~4_combout\,
	datab => \datapath|comp|Equal0~1_combout\,
	datac => \datapath|comp|Equal0~2_combout\,
	datad => \datapath|comp|Equal0~3_combout\,
	combout => \datapath|comp|Equal0~5_combout\);

-- Location: LCCOMB_X55_Y50_N22
\controller|WideOr11~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \controller|WideOr11~1_combout\ = (!\controller|atual.SEL_OP_C~q\ & (\controller|atual.INIT~q\ & (!\controller|atual.PERM_C~q\ & !\controller|atual.MENU~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \controller|atual.SEL_OP_C~q\,
	datab => \controller|atual.INIT~q\,
	datac => \controller|atual.PERM_C~q\,
	datad => \controller|atual.MENU~q\,
	combout => \controller|WideOr11~1_combout\);

-- Location: LCCOMB_X54_Y50_N24
\controller|WideOr11\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \controller|WideOr11~combout\ = (\controller|atual.XOR_C~q\) # (((\controller|atual.ROL_C~q\) # (!\controller|WideOr11~1_combout\)) # (!\controller|WideOr11~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \controller|atual.XOR_C~q\,
	datab => \controller|WideOr11~0_combout\,
	datac => \controller|atual.ROL_C~q\,
	datad => \controller|WideOr11~1_combout\,
	combout => \controller|WideOr11~combout\);

-- Location: LCCOMB_X55_Y50_N20
\controller|WideOr14~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \controller|WideOr14~0_combout\ = (\controller|atual.PERM_D~q\) # ((\controller|atual.SAVE_C~q\) # ((\controller|atual.XOR_D~q\) # (!\controller|atual.INIT~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111101111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \controller|atual.PERM_D~q\,
	datab => \controller|atual.SAVE_C~q\,
	datac => \controller|atual.INIT~q\,
	datad => \controller|atual.XOR_D~q\,
	combout => \controller|WideOr14~0_combout\);

-- Location: LCCOMB_X54_Y50_N14
\controller|WideOr14\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \controller|WideOr14~combout\ = (\controller|WideOr14~0_combout\) # ((\controller|atual.ROL_C~q\) # ((\controller|atual.INSERT_V~q\) # (!\controller|WideOr14~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \controller|WideOr14~0_combout\,
	datab => \controller|atual.ROL_C~q\,
	datac => \controller|atual.INSERT_V~q\,
	datad => \controller|WideOr14~1_combout\,
	combout => \controller|WideOr14~combout\);

-- Location: LCCOMB_X55_Y50_N6
\controller|WideOr12~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \controller|WideOr12~0_combout\ = ((\controller|atual.ATTEMPT_D~q\) # (\controller|atual.SAVE_C~q\)) # (!\controller|atual.INIT~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111110011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \controller|atual.INIT~q\,
	datac => \controller|atual.ATTEMPT_D~q\,
	datad => \controller|atual.SAVE_C~q\,
	combout => \controller|WideOr12~0_combout\);

-- Location: LCCOMB_X55_Y50_N18
\controller|WideOr12\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \controller|WideOr12~combout\ = ((\controller|atual.SEL_OP_D~q\) # (\controller|WideOr12~0_combout\)) # (!\controller|WideOr12~1_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111110101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \controller|WideOr12~1_combout\,
	datac => \controller|atual.SEL_OP_D~q\,
	datad => \controller|WideOr12~0_combout\,
	combout => \controller|WideOr12~combout\);

-- Location: LCCOMB_X55_Y50_N24
\controller|WideOr13\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \controller|WideOr13~combout\ = ((\controller|atual.SAVE_C~q\) # ((\controller|atual.XOR_D~q\) # (!\controller|WideOr13~0_combout\))) # (!\controller|WideOr11~1_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111011111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \controller|WideOr11~1_combout\,
	datab => \controller|atual.SAVE_C~q\,
	datac => \controller|WideOr13~0_combout\,
	datad => \controller|atual.XOR_D~q\,
	combout => \controller|WideOr13~combout\);

-- Location: LCCOMB_X60_Y50_N0
\display|Mux19~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \display|Mux19~2_combout\ = (!\controller|WideOr11~combout\ & (!\controller|WideOr14~combout\ & (!\controller|WideOr12~combout\ & !\controller|WideOr13~combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \controller|WideOr11~combout\,
	datab => \controller|WideOr14~combout\,
	datac => \controller|WideOr12~combout\,
	datad => \controller|WideOr13~combout\,
	combout => \display|Mux19~2_combout\);

-- Location: LCCOMB_X60_Y50_N28
\display|Mux19~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \display|Mux19~3_combout\ = (\datapath|comp|Equal0~0_combout\ & (\datapath|comp|Equal0~5_combout\ & \display|Mux19~2_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \datapath|comp|Equal0~0_combout\,
	datac => \datapath|comp|Equal0~5_combout\,
	datad => \display|Mux19~2_combout\,
	combout => \display|Mux19~3_combout\);

-- Location: LCCOMB_X60_Y50_N14
\display|Mux20~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \display|Mux20~2_combout\ = ((\datapath|comp|Equal0~0_combout\ & \datapath|comp|Equal0~5_combout\)) # (!\display|Mux19~2_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \datapath|comp|Equal0~0_combout\,
	datac => \datapath|comp|Equal0~5_combout\,
	datad => \display|Mux19~2_combout\,
	combout => \display|Mux20~2_combout\);

-- Location: LCCOMB_X60_Y50_N20
\display|Mux6~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \display|Mux6~0_combout\ = (!\controller|WideOr14~combout\ & (!\controller|WideOr12~combout\ & ((!\datapath|comp|Equal0~5_combout\) # (!\datapath|comp|Equal0~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000010011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \datapath|comp|Equal0~0_combout\,
	datab => \controller|WideOr14~combout\,
	datac => \datapath|comp|Equal0~5_combout\,
	datad => \controller|WideOr12~combout\,
	combout => \display|Mux6~0_combout\);

-- Location: LCCOMB_X59_Y50_N4
\display|Mux6~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \display|Mux6~1_combout\ = (\controller|WideOr11~combout\) # ((\controller|WideOr13~combout\ & (\controller|WideOr12~combout\)) # (!\controller|WideOr13~combout\ & ((\display|Mux6~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111111101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \controller|WideOr11~combout\,
	datab => \controller|WideOr12~combout\,
	datac => \controller|WideOr13~combout\,
	datad => \display|Mux6~0_combout\,
	combout => \display|Mux6~1_combout\);

-- Location: LCCOMB_X60_Y50_N6
\display|Mux3~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \display|Mux3~0_combout\ = (!\controller|WideOr11~combout\ & ((\controller|WideOr12~combout\ & ((!\controller|WideOr13~combout\))) # (!\controller|WideOr12~combout\ & ((\controller|WideOr14~combout\) # (\controller|WideOr13~combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010101010100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \controller|WideOr11~combout\,
	datab => \controller|WideOr14~combout\,
	datac => \controller|WideOr12~combout\,
	datad => \controller|WideOr13~combout\,
	combout => \display|Mux3~0_combout\);

-- Location: LCCOMB_X60_Y50_N2
\datapath|comp|Equal0~6\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \datapath|comp|Equal0~6_combout\ = (\datapath|comp|Equal0~0_combout\ & \datapath|comp|Equal0~5_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \datapath|comp|Equal0~0_combout\,
	datac => \datapath|comp|Equal0~5_combout\,
	combout => \datapath|comp|Equal0~6_combout\);

-- Location: LCCOMB_X60_Y50_N12
\display|Mux13~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \display|Mux13~0_combout\ = (!\controller|WideOr11~combout\ & ((\controller|WideOr14~combout\ & (\controller|WideOr12~combout\)) # (!\controller|WideOr14~combout\ & (!\controller|WideOr12~combout\ & \datapath|comp|Equal0~6_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000101000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \controller|WideOr11~combout\,
	datab => \controller|WideOr14~combout\,
	datac => \controller|WideOr12~combout\,
	datad => \datapath|comp|Equal0~6_combout\,
	combout => \display|Mux13~0_combout\);

-- Location: LCCOMB_X60_Y50_N26
\display|Mux13~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \display|Mux13~1_combout\ = (\controller|WideOr11~combout\ & ((\controller|WideOr14~combout\ $ (!\controller|WideOr12~combout\)) # (!\controller|WideOr13~combout\))) # (!\controller|WideOr11~combout\ & (((\controller|WideOr13~combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101011110101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \controller|WideOr11~combout\,
	datab => \controller|WideOr14~combout\,
	datac => \controller|WideOr12~combout\,
	datad => \controller|WideOr13~combout\,
	combout => \display|Mux13~1_combout\);

-- Location: LCCOMB_X60_Y50_N8
\display|Mux13~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \display|Mux13~2_combout\ = (\display|Mux13~0_combout\) # (\display|Mux13~1_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101011111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \display|Mux13~0_combout\,
	datac => \display|Mux13~1_combout\,
	combout => \display|Mux13~2_combout\);

-- Location: LCCOMB_X55_Y50_N14
\display|Mux12~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \display|Mux12~0_combout\ = (\controller|WideOr11~combout\ & ((\controller|WideOr12~combout\) # (\controller|WideOr14~combout\ $ (!\controller|WideOr13~combout\)))) # (!\controller|WideOr11~combout\ & (((\controller|WideOr13~combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101110001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \controller|WideOr12~combout\,
	datab => \controller|WideOr11~combout\,
	datac => \controller|WideOr14~combout\,
	datad => \controller|WideOr13~combout\,
	combout => \display|Mux12~0_combout\);

-- Location: LCCOMB_X55_Y50_N4
\display|Mux12~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \display|Mux12~1_combout\ = (\display|Mux12~0_combout\) # ((!\display|Mux6~0_combout\ & (!\controller|WideOr13~combout\ & !\controller|WideOr11~combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \display|Mux6~0_combout\,
	datab => \controller|WideOr13~combout\,
	datac => \display|Mux12~0_combout\,
	datad => \controller|WideOr11~combout\,
	combout => \display|Mux12~1_combout\);

-- Location: LCCOMB_X55_Y50_N10
\display|Mux11~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \display|Mux11~0_combout\ = (\controller|WideOr14~combout\ & ((\controller|WideOr12~combout\ & ((\controller|WideOr13~combout\))) # (!\controller|WideOr12~combout\ & (\controller|WideOr11~combout\)))) # (!\controller|WideOr14~combout\ & 
-- (((\controller|WideOr11~combout\) # (\controller|WideOr13~combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111101001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \controller|WideOr12~combout\,
	datab => \controller|WideOr11~combout\,
	datac => \controller|WideOr14~combout\,
	datad => \controller|WideOr13~combout\,
	combout => \display|Mux11~0_combout\);

-- Location: LCCOMB_X54_Y50_N6
\display|Mux11~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \display|Mux11~1_combout\ = (\display|Mux11~0_combout\) # ((!\display|Mux6~0_combout\ & (!\controller|WideOr13~combout\ & !\controller|WideOr11~combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \display|Mux6~0_combout\,
	datab => \controller|WideOr13~combout\,
	datac => \display|Mux11~0_combout\,
	datad => \controller|WideOr11~combout\,
	combout => \display|Mux11~1_combout\);

-- Location: LCCOMB_X60_Y50_N22
\display|Mux10~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \display|Mux10~0_combout\ = (\controller|WideOr11~combout\ & ((\controller|WideOr14~combout\ & ((\controller|WideOr12~combout\) # (!\controller|WideOr13~combout\))) # (!\controller|WideOr14~combout\ & (\controller|WideOr12~combout\ $ 
-- (\controller|WideOr13~combout\))))) # (!\controller|WideOr11~combout\ & (((\controller|WideOr13~combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101011110101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \controller|WideOr11~combout\,
	datab => \controller|WideOr14~combout\,
	datac => \controller|WideOr12~combout\,
	datad => \controller|WideOr13~combout\,
	combout => \display|Mux10~0_combout\);

-- Location: LCCOMB_X60_Y50_N24
\display|Mux10~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \display|Mux10~1_combout\ = (\display|Mux13~0_combout\) # (\display|Mux10~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101011111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \display|Mux13~0_combout\,
	datac => \display|Mux10~0_combout\,
	combout => \display|Mux10~1_combout\);

-- Location: LCCOMB_X60_Y50_N30
\display|Mux9~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \display|Mux9~0_combout\ = (\controller|WideOr14~combout\ & ((\controller|WideOr11~combout\ & ((\controller|WideOr12~combout\) # (!\controller|WideOr13~combout\))) # (!\controller|WideOr11~combout\ & ((\controller|WideOr13~combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100010010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \controller|WideOr11~combout\,
	datab => \controller|WideOr14~combout\,
	datac => \controller|WideOr12~combout\,
	datad => \controller|WideOr13~combout\,
	combout => \display|Mux9~0_combout\);

-- Location: LCCOMB_X60_Y50_N4
\display|Mux9~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \display|Mux9~1_combout\ = (\display|Mux9~0_combout\) # ((\display|Mux13~0_combout\ & (\controller|WideOr11~combout\ $ (!\controller|WideOr13~combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \controller|WideOr11~combout\,
	datab => \controller|WideOr13~combout\,
	datac => \display|Mux9~0_combout\,
	datad => \display|Mux13~0_combout\,
	combout => \display|Mux9~1_combout\);

-- Location: LCCOMB_X60_Y50_N10
\display|Mux8~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \display|Mux8~0_combout\ = (\controller|WideOr13~combout\ & (\controller|WideOr12~combout\ $ ((\controller|WideOr11~combout\)))) # (!\controller|WideOr13~combout\ & (!\controller|WideOr12~combout\ & (!\controller|WideOr11~combout\ & 
-- \datapath|comp|Equal0~5_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110011000010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \controller|WideOr12~combout\,
	datab => \controller|WideOr11~combout\,
	datac => \datapath|comp|Equal0~5_combout\,
	datad => \controller|WideOr13~combout\,
	combout => \display|Mux8~0_combout\);

-- Location: LCCOMB_X60_Y50_N16
\display|Mux8~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \display|Mux8~1_combout\ = \controller|WideOr13~combout\ $ (((\controller|WideOr12~combout\ & \controller|WideOr11~combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101111110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \controller|WideOr12~combout\,
	datac => \controller|WideOr11~combout\,
	datad => \controller|WideOr13~combout\,
	combout => \display|Mux8~1_combout\);

-- Location: LCCOMB_X60_Y50_N18
\display|Mux8~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \display|Mux8~2_combout\ = (\display|Mux8~1_combout\ & (\display|Mux8~0_combout\)) # (!\display|Mux8~1_combout\ & ((\controller|WideOr14~combout\) # ((\display|Mux8~0_combout\ & \datapath|comp|Equal0~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101011101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \display|Mux8~0_combout\,
	datab => \controller|WideOr14~combout\,
	datac => \datapath|comp|Equal0~0_combout\,
	datad => \display|Mux8~1_combout\,
	combout => \display|Mux8~2_combout\);

-- Location: LCCOMB_X55_Y50_N28
\display|Mux7~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \display|Mux7~0_combout\ = (\controller|WideOr12~combout\ & (\controller|WideOr11~combout\ $ (((\controller|WideOr13~combout\))))) # (!\controller|WideOr12~combout\ & (((\controller|WideOr14~combout\) # (\controller|WideOr13~combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111011111011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \controller|WideOr12~combout\,
	datab => \controller|WideOr11~combout\,
	datac => \controller|WideOr14~combout\,
	datad => \controller|WideOr13~combout\,
	combout => \display|Mux7~0_combout\);

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

ww_leds(0) <= \leds[0]~output_o\;

ww_leds(1) <= \leds[1]~output_o\;

ww_leds(2) <= \leds[2]~output_o\;

ww_leds(3) <= \leds[3]~output_o\;

ww_leds(4) <= \leds[4]~output_o\;

ww_leds(5) <= \leds[5]~output_o\;

ww_leds(6) <= \leds[6]~output_o\;

ww_leds(7) <= \leds[7]~output_o\;

ww_leds(8) <= \leds[8]~output_o\;

ww_leds(9) <= \leds[9]~output_o\;

ww_hex5(0) <= \hex5[0]~output_o\;

ww_hex5(1) <= \hex5[1]~output_o\;

ww_hex5(2) <= \hex5[2]~output_o\;

ww_hex5(3) <= \hex5[3]~output_o\;

ww_hex5(4) <= \hex5[4]~output_o\;

ww_hex5(5) <= \hex5[5]~output_o\;

ww_hex5(6) <= \hex5[6]~output_o\;

ww_hex4(0) <= \hex4[0]~output_o\;

ww_hex4(1) <= \hex4[1]~output_o\;

ww_hex4(2) <= \hex4[2]~output_o\;

ww_hex4(3) <= \hex4[3]~output_o\;

ww_hex4(4) <= \hex4[4]~output_o\;

ww_hex4(5) <= \hex4[5]~output_o\;

ww_hex4(6) <= \hex4[6]~output_o\;

ww_hex3(0) <= \hex3[0]~output_o\;

ww_hex3(1) <= \hex3[1]~output_o\;

ww_hex3(2) <= \hex3[2]~output_o\;

ww_hex3(3) <= \hex3[3]~output_o\;

ww_hex3(4) <= \hex3[4]~output_o\;

ww_hex3(5) <= \hex3[5]~output_o\;

ww_hex3(6) <= \hex3[6]~output_o\;

ww_hex2(0) <= \hex2[0]~output_o\;

ww_hex2(1) <= \hex2[1]~output_o\;

ww_hex2(2) <= \hex2[2]~output_o\;

ww_hex2(3) <= \hex2[3]~output_o\;

ww_hex2(4) <= \hex2[4]~output_o\;

ww_hex2(5) <= \hex2[5]~output_o\;

ww_hex2(6) <= \hex2[6]~output_o\;

ww_hex1(0) <= \hex1[0]~output_o\;

ww_hex1(1) <= \hex1[1]~output_o\;

ww_hex1(2) <= \hex1[2]~output_o\;

ww_hex1(3) <= \hex1[3]~output_o\;

ww_hex1(4) <= \hex1[4]~output_o\;

ww_hex1(5) <= \hex1[5]~output_o\;

ww_hex1(6) <= \hex1[6]~output_o\;

ww_hex0(0) <= \hex0[0]~output_o\;

ww_hex0(1) <= \hex0[1]~output_o\;

ww_hex0(2) <= \hex0[2]~output_o\;

ww_hex0(3) <= \hex0[3]~output_o\;

ww_hex0(4) <= \hex0[4]~output_o\;

ww_hex0(5) <= \hex0[5]~output_o\;

ww_hex0(6) <= \hex0[6]~output_o\;
END structure;


