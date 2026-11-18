--CRIPTOGRAFIA
library ieee;
use ieee.std_logic_1164.all;

entity Criptografia is
	port (
		base_clock : in std_logic;
		enter, reset : in std_logic;
		sw : in std_logic_vector(9 downto 0);

		hex5, hex4, hex3, hex2, hex1, hex0 : out std_logic_vector(6 downto 0)
	);
end entity Criptografia;

architecture rtl of Criptografia is
	-- Entradas externas. Enter e reset sao ativos em '0'.
	signal sclock, sbase_Clock, senter, sreset, smodo : std_logic;
	signal sop : std_logic_vector(1 downto 0);
	signal ssw : std_logic_vector(9 downto 0);

	-- Controles da controladora para o datapath.
	signal sld_x, sld_k, sld_v, sld_c, srot_dir, sclr : std_logic;
	signal ssel : std_logic_vector(2 downto 0);

	-- Flags do datapath para a controladora e o display.
	signal sequals, sexiste_cripto : std_logic;
	signal sdisplay : std_logic_vector(3 downto 0);
begin
	datapath: entity work.datapath
		port map (
			clk_sys => sclock,
			ld_x => sld_x,
			ld_k => sld_k,
			ld_v => sld_v,
			ld_c => sld_c,
			rot_dir => srot_dir,
			clr => sclr,
			sw => ssw,
			sel => ssel,
			equals => sequals,
			existe_cripto => sexiste_cripto
		);

	controller: entity work.controller
		port map (
			clock => sclock,
			enter => senter,
			reset => sreset,
			modo => smodo,
			op => sop,
			equals => sequals,
			existe_cripto => sexiste_cripto,
			ld_x => sld_x,
			ld_k => sld_k,
			ld_v => sld_v,
			ld_c => sld_c,
			sel => ssel,
			rot_dir => srot_dir,
			clr => sclr,
			display => sdisplay
		);

	display: entity work.hex7seg
		generic map (
			ATIVO_EM_ZERO => true
		)
		port map (
			estado => sdisplay,
			acerto => sequals,
			hex5 => hex5,
			hex4 => hex4,
			hex3 => hex3,
			hex2 => hex2,
			hex1 => hex1,
			hex0 => hex0
		);
		
	clock_div: entity work.clock_div
		port map (
			clk => sbase_Clock,
			reset => sreset,
			tick => sclock
		);

	-- Controladora e datapath usam o mesmo clock.
	sbase_clock <= base_clock;
	senter <= enter;
	sreset <= reset;
	smodo <= sw(0);
	sop <= sw(1 downto 0);
	ssw <= sw;
end architecture rtl;
