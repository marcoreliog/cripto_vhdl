library ieee;
use ieee.std_logic_1164.all;

entity tb_clock_div is
end tb_clock_div;

architecture test of tb_clock_div is

    component clock_div is
        generic (DIVISOR : positive := 10000000);
        port (
            clk, reset : in std_logic;
            tick : out std_logic
        );
    end component;

    signal clk : std_logic := '0';
    signal reset : std_logic := '0';
    signal tick : std_logic;

begin

    dut : clock_div
        generic map (DIVISOR => 4)
        port map (clk => clk, reset => reset, tick => tick);

    clk <= not clk after 5 ns;

    stimulus : process
    begin

        reset <= '1';
        wait for 10 ns;
        reset <= '0';

        wait for 35 ns;
        wait for 10 ns;

        reset <= '1';
        wait for 10 ns;
        reset <= '0';
        wait;
    end process;

end test;
