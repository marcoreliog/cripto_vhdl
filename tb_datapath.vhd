library ieee;
use ieee.std_logic_1164.all;

entity tb_datapath is
end tb_datapath;

architecture test of tb_datapath is

    component datapath is
        port(
            clk_sys, ld_x, ld_k, ld_v, ld_c, rot_dir, clr : in std_logic;
            sw : in std_logic_vector(9 downto 0);
            sel : in std_logic_vector(2 downto 0);
            leds : out std_logic_vector(9 downto 0);
            equals, existe_cripto : out std_logic
        );
    end component;

    signal my_clock : std_logic := '0';
    signal ld_x, ld_k, ld_v, ld_c, rot_dir, clr : std_logic := '0';
    signal sw : std_logic_vector(9 downto 0) := (others => '0');
    signal sel : std_logic_vector(2 downto 0) := "000";
    signal leds : std_logic_vector(9 downto 0);
    signal equals, existe_cripto : std_logic;

begin

    dut: datapath
        port map(
            clk_sys => my_clock,
            clr => clr,
            sw => sw,
            ld_x => ld_x,
            ld_k => ld_k,
            ld_v => ld_v,
            ld_c => ld_c,
            leds => leds,
            sel => sel,
            rot_dir => rot_dir,
            equals => equals,
            existe_cripto => existe_cripto
        );

    my_clock <= not my_clock after 5 ns;

    stimulus : process
    begin

        clr <= '1';
        wait for 12 ns;
        clr <= '0';

        sw <= "1011010011";
        sel <= "000";
        ld_v <= '1';
        ld_x <= '1';
        wait for 10 ns;
        ld_v <= '0';
        ld_x <= '0';

        sw <= "0101010110";
        ld_k <= '1';
        wait for 10 ns;
        ld_k <= '0';

        sw <= "0000000000";
        sel <= "001";
        wait for 10 ns;

        ld_x <= '1';
        wait for 10 ns;
        ld_x <= '0';
        wait for 10 ns;

        sel <= "010";
        rot_dir <= '0';
        ld_x <= '1';
        wait for 10 ns;
        ld_x <= '0';
        wait for 10 ns;

        sel <= "011";
        ld_x <= '1';
        wait for 10 ns;
        ld_x <= '0';
        wait for 10 ns;

        ld_c <= '1';
        wait for 10 ns;
        ld_c <= '0';
        wait for 10 ns;

        sw <= "0000010001";
        sel <= "000";
        ld_x <= '1';
        wait for 10 ns;
        ld_x <= '0';
        wait for 10 ns;

        sel <= "100";
        ld_x <= '1';
        wait for 10 ns;
        ld_x <= '0';
        wait for 10 ns;

        sel <= "011";
        ld_x <= '1';
        wait for 10 ns;
        ld_x <= '0';
        wait for 10 ns;

        sel <= "010";
        rot_dir <= '1';
        ld_x <= '1';
        wait for 10 ns;
        ld_x <= '0';
        wait for 10 ns;

        sel <= "001";
        ld_x <= '1';
        wait for 10 ns;
        ld_x <= '0';
        wait for 10 ns;

        sw <= "1111111111";
        ld_x <= '1';
        sel <= "111";
        wait for 10 ns;
        sel <= "110";
        wait for 10 ns;
        sel <= "101";
        wait for 10 ns;
        ld_x <= '0';
        wait for 10 ns;

        sel <= "100";
        ld_x <= '1';
        wait for 10 ns;
        ld_x <= '0';
        wait for 10 ns;

        sw <= "0000000000";
        ld_k <= '1';
        wait for 10 ns;
        ld_k <= '0';

        sel <= "011";
        ld_x <= '1';
        wait for 10 ns;
        ld_x <= '0';
        wait for 10 ns;

        sel <= "010";
        rot_dir <= '1';
        ld_x <= '1';
        wait for 10 ns;
        ld_x <= '0';
        wait for 10 ns;

        sel <= "001";
        ld_x <= '1';
        wait for 10 ns;
        ld_x <= '0';
        wait for 10 ns;

        sw <= "0101010110";
        ld_k <= '1';
        wait for 10 ns;
        ld_k <= '0';
        ld_x <= '1';
        wait for 10 ns;
        ld_x <= '0';
        wait for 10 ns;

        clr <= '1';
        sw <= "1111111111";
        sel <= "000";
        ld_v <= '1';
        ld_k <= '1';
        ld_x <= '1';
        ld_c <= '1';
        wait for 10 ns;
        clr <= '0';
        ld_v <= '0';
        ld_k <= '0';
        ld_x <= '0';
        ld_c <= '0';
        wait for 10 ns;

        sel <= "100";
        ld_x <= '1';
        wait for 10 ns;
        sel <= "001";
        wait for 10 ns;
        ld_x <= '0';

        ld_c <= '1';
        wait for 10 ns;
        ld_c <= '0';
        wait for 10 ns;

        wait;
    end process;
end test;
