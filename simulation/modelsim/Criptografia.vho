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

LIBRARY FIFTYFIVENM;
LIBRARY IEEE;
USE FIFTYFIVENM.FIFTYFIVENM_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	permuter IS
    PORT (
	A : IN std_logic_vector(9 DOWNTO 0);
	P : OUT std_logic_vector(9 DOWNTO 0)
	);
END permuter;

ARCHITECTURE structure OF permuter IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_A : std_logic_vector(9 DOWNTO 0);
SIGNAL ww_P : std_logic_vector(9 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_ADC1~_CHSEL_bus\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_ADC2~_CHSEL_bus\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \~QUARTUS_CREATED_UNVM~~busy\ : std_logic;
SIGNAL \~QUARTUS_CREATED_ADC1~~eoc\ : std_logic;
SIGNAL \~QUARTUS_CREATED_ADC2~~eoc\ : std_logic;
SIGNAL \P[0]~output_o\ : std_logic;
SIGNAL \P[1]~output_o\ : std_logic;
SIGNAL \P[2]~output_o\ : std_logic;
SIGNAL \P[3]~output_o\ : std_logic;
SIGNAL \P[4]~output_o\ : std_logic;
SIGNAL \P[5]~output_o\ : std_logic;
SIGNAL \P[6]~output_o\ : std_logic;
SIGNAL \P[7]~output_o\ : std_logic;
SIGNAL \P[8]~output_o\ : std_logic;
SIGNAL \P[9]~output_o\ : std_logic;
SIGNAL \A[1]~input_o\ : std_logic;
SIGNAL \A[0]~input_o\ : std_logic;
SIGNAL \A[3]~input_o\ : std_logic;
SIGNAL \A[2]~input_o\ : std_logic;
SIGNAL \A[5]~input_o\ : std_logic;
SIGNAL \A[4]~input_o\ : std_logic;
SIGNAL \A[7]~input_o\ : std_logic;
SIGNAL \A[6]~input_o\ : std_logic;
SIGNAL \A[9]~input_o\ : std_logic;
SIGNAL \A[8]~input_o\ : std_logic;

COMPONENT hard_block
    PORT (
	devoe : IN std_logic;
	devclrn : IN std_logic;
	devpor : IN std_logic);
END COMPONENT;

BEGIN

ww_A <= A;
P <= ww_P;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\~QUARTUS_CREATED_ADC1~_CHSEL_bus\ <= (\~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\);

\~QUARTUS_CREATED_ADC2~_CHSEL_bus\ <= (\~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\);
auto_generated_inst : hard_block
PORT MAP (
	devoe => ww_devoe,
	devclrn => ww_devclrn,
	devpor => ww_devpor);

\~QUARTUS_CREATED_GND~I\ : fiftyfivenm_lcell_comb

GENERIC MAP (
	lut_mask => "0000000000000000",
	sum_lutc_input => "datac")

PORT MAP (
	combout => \~QUARTUS_CREATED_GND~I_combout\);

\P[0]~output\ : fiftyfivenm_io_obuf

GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")

PORT MAP (
	i => \A[1]~input_o\,
	devoe => ww_devoe,
	o => \P[0]~output_o\);

\P[1]~output\ : fiftyfivenm_io_obuf

GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")

PORT MAP (
	i => \A[0]~input_o\,
	devoe => ww_devoe,
	o => \P[1]~output_o\);

\P[2]~output\ : fiftyfivenm_io_obuf

GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")

PORT MAP (
	i => \A[3]~input_o\,
	devoe => ww_devoe,
	o => \P[2]~output_o\);

\P[3]~output\ : fiftyfivenm_io_obuf

GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")

PORT MAP (
	i => \A[2]~input_o\,
	devoe => ww_devoe,
	o => \P[3]~output_o\);

\P[4]~output\ : fiftyfivenm_io_obuf

GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")

PORT MAP (
	i => \A[5]~input_o\,
	devoe => ww_devoe,
	o => \P[4]~output_o\);

\P[5]~output\ : fiftyfivenm_io_obuf

GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")

PORT MAP (
	i => \A[4]~input_o\,
	devoe => ww_devoe,
	o => \P[5]~output_o\);

\P[6]~output\ : fiftyfivenm_io_obuf

GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")

PORT MAP (
	i => \A[7]~input_o\,
	devoe => ww_devoe,
	o => \P[6]~output_o\);

\P[7]~output\ : fiftyfivenm_io_obuf

GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")

PORT MAP (
	i => \A[6]~input_o\,
	devoe => ww_devoe,
	o => \P[7]~output_o\);

\P[8]~output\ : fiftyfivenm_io_obuf

GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")

PORT MAP (
	i => \A[9]~input_o\,
	devoe => ww_devoe,
	o => \P[8]~output_o\);

\P[9]~output\ : fiftyfivenm_io_obuf

GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")

PORT MAP (
	i => \A[8]~input_o\,
	devoe => ww_devoe,
	o => \P[9]~output_o\);

\A[1]~input\ : fiftyfivenm_io_ibuf

GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")

PORT MAP (
	i => ww_A(1),
	o => \A[1]~input_o\);

\A[0]~input\ : fiftyfivenm_io_ibuf

GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")

PORT MAP (
	i => ww_A(0),
	o => \A[0]~input_o\);

\A[3]~input\ : fiftyfivenm_io_ibuf

GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")

PORT MAP (
	i => ww_A(3),
	o => \A[3]~input_o\);

\A[2]~input\ : fiftyfivenm_io_ibuf

GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")

PORT MAP (
	i => ww_A(2),
	o => \A[2]~input_o\);

\A[5]~input\ : fiftyfivenm_io_ibuf

GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")

PORT MAP (
	i => ww_A(5),
	o => \A[5]~input_o\);

\A[4]~input\ : fiftyfivenm_io_ibuf

GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")

PORT MAP (
	i => ww_A(4),
	o => \A[4]~input_o\);

\A[7]~input\ : fiftyfivenm_io_ibuf

GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")

PORT MAP (
	i => ww_A(7),
	o => \A[7]~input_o\);

\A[6]~input\ : fiftyfivenm_io_ibuf

GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")

PORT MAP (
	i => ww_A(6),
	o => \A[6]~input_o\);

\A[9]~input\ : fiftyfivenm_io_ibuf

GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")

PORT MAP (
	i => ww_A(9),
	o => \A[9]~input_o\);

\A[8]~input\ : fiftyfivenm_io_ibuf

GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")

PORT MAP (
	i => ww_A(8),
	o => \A[8]~input_o\);

\~QUARTUS_CREATED_UNVM~\ : fiftyfivenm_unvm

GENERIC MAP (
	addr_range1_end_addr => -1,
	addr_range1_offset => -1,
	addr_range2_end_addr => -1,
	addr_range2_offset => -1,
	addr_range3_offset => -1,
	is_compressed_image => "false",
	is_dual_boot => "false",
	is_eram_skip => "false",
	max_ufm_valid_addr => -1,
	max_valid_addr => -1,
	min_ufm_valid_addr => -1,
	min_valid_addr => -1,
	part_name => "quartus_created_unvm",
	reserve_block => "true")

PORT MAP (
	nosc_ena => \~QUARTUS_CREATED_GND~I_combout\,
	xe_ye => \~QUARTUS_CREATED_GND~I_combout\,
	se => \~QUARTUS_CREATED_GND~I_combout\,
	busy => \~QUARTUS_CREATED_UNVM~~busy\);

\~QUARTUS_CREATED_ADC1~\ : fiftyfivenm_adcblock

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

PORT MAP (
	soc => \~QUARTUS_CREATED_GND~I_combout\,
	usr_pwd => VCC,
	tsen => \~QUARTUS_CREATED_GND~I_combout\,
	chsel => \~QUARTUS_CREATED_ADC1~_CHSEL_bus\,
	eoc => \~QUARTUS_CREATED_ADC1~~eoc\);

\~QUARTUS_CREATED_ADC2~\ : fiftyfivenm_adcblock

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

PORT MAP (
	soc => \~QUARTUS_CREATED_GND~I_combout\,
	usr_pwd => VCC,
	tsen => \~QUARTUS_CREATED_GND~I_combout\,
	chsel => \~QUARTUS_CREATED_ADC2~_CHSEL_bus\,
	eoc => \~QUARTUS_CREATED_ADC2~~eoc\);

ww_P(0) <= \P[0]~output_o\;

ww_P(1) <= \P[1]~output_o\;

ww_P(2) <= \P[2]~output_o\;

ww_P(3) <= \P[3]~output_o\;

ww_P(4) <= \P[4]~output_o\;

ww_P(5) <= \P[5]~output_o\;

ww_P(6) <= \P[6]~output_o\;

ww_P(7) <= \P[7]~output_o\;

ww_P(8) <= \P[8]~output_o\;

ww_P(9) <= \P[9]~output_o\;
END structure;
