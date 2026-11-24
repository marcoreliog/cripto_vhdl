library ieee;
use ieee.std_logic_1164.all;

entity tb_controller is
end tb_controller;

architecture test of tb_controller is

    component controller is
        port(
            enter, clock, modo, equals, existe_cripto : in std_logic;
            reset : in std_logic;
            op : in std_logic_vector(1 downto 0);
            ld_x, ld_k, ld_v, ld_c : out std_logic;
            sel : out std_logic_vector(2 downto 0);
            rot_dir, clr : out std_logic;
            display : out std_logic_vector(3 downto 0)
        );
    end component;

    signal my_clock : std_logic := '0';
    signal reset, modo, equals, existe_cripto : std_logic := '0';
    signal enter : std_logic := '1';
    signal op : std_logic_vector(1 downto 0) := "00";
    signal ld_x, ld_k, ld_v, ld_c, rot_dir, clr : std_logic;
    signal sel : std_logic_vector(2 downto 0);
    signal display : std_logic_vector(3 downto 0);

begin

    dut: controller
        port map(
            clock => my_clock,
            reset => reset,
            enter => enter,
            modo => modo,
            op => op,
            equals => equals,
            existe_cripto => existe_cripto,
            ld_x => ld_x,
            ld_k => ld_k,
            ld_v => ld_v,
            ld_c => ld_c,
            sel => sel,
            rot_dir => rot_dir,
            clr => clr,
            display => display
        );

    my_clock <= not my_clock after 5 ns;

    stimulus : process
    begin

        reset <= '0';
        wait for 12 ns;
        reset <= '1';
        wait for 10 ns;

        modo <= '1';
        enter <= '0';
        wait for 10 ns;
        enter <= '1';
        wait for 10 ns;

        modo <= '0';
        enter <= '0';
        wait for 10 ns;
        enter <= '1';
        wait for 10 ns;

        enter <= '0';
        wait for 10 ns;
        enter <= '1';
        wait for 10 ns;

        enter <= '0';
        wait for 10 ns;
        enter <= '1';
        wait for 10 ns;

        op <= "01";
        wait for 10 ns;

        enter <= '0';
        wait for 10 ns;
        enter <= '1';
        wait for 10 ns;

        op <= "10";
        enter <= '0';
        wait for 10 ns;
        enter <= '1';
        wait for 10 ns;

        op <= "11";
        enter <= '0';
        wait for 10 ns;
        enter <= '1';
        wait for 10 ns;

        op <= "00";
        enter <= '0';
        wait for 10 ns;
        enter <= '1';
        wait for 10 ns;

        existe_cripto <= '1';
        modo <= '1';
        enter <= '0';
        wait for 10 ns;
        enter <= '1';
        wait for 10 ns;

        op <= "11";
        enter <= '0';
        wait for 10 ns;
        enter <= '1';
        wait for 10 ns;

        op <= "10";
        enter <= '0';
        wait for 10 ns;
        enter <= '1';
        wait for 10 ns;

        op <= "01";
        enter <= '0';
        wait for 10 ns;
        enter <= '1';
        wait for 20 ns;

        enter <= '0';
        wait for 10 ns;
        enter <= '1';
        wait for 10 ns;

        op <= "00";
        equals <= '1';
        enter <= '0';
        wait for 10 ns;
        enter <= '1';
        wait for 20 ns;

        equals <= '0';
        wait for 10 ns;
        enter <= '0';
        wait for 10 ns;
        enter <= '1';
        wait for 10 ns;

        enter <= '0';
        wait for 10 ns;
        enter <= '1';
        wait for 10 ns;

        enter <= '0';
        wait for 10 ns;
        enter <= '1';
        wait for 20 ns;
        enter <= '0';
        wait for 10 ns;
        enter <= '1';
        wait for 10 ns;

        enter <= '0';
        wait for 10 ns;
        enter <= '1';
        wait for 10 ns;
        reset <= '0';
        existe_cripto <= '0';
        wait for 10 ns;
        reset <= '1';
        wait for 10 ns;

        wait;
    end process;
end test;
