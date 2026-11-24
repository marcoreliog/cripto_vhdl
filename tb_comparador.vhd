library ieee;
use ieee.std_logic_1164.all;

entity tb_comparador is
end tb_comparador;

architecture test of tb_comparador is

    component comparator is
        generic (N : natural := 8);
        port (
            a, b : in std_logic_vector(N-1 downto 0);
            gt, eq, lt : out std_logic
        );
    end component;

    signal a, b : std_logic_vector(3 downto 0) := (others => '0');
    signal gt, eq, lt : std_logic;

begin

    dut : comparator
        generic map (N => 4)
        port map (a => a, b => b, gt => gt, eq => eq, lt => lt);

    stimulus : process
    begin

        a <= "0110";
        b <= "0110";
        wait for 10 ns;

        a <= "1001";
        b <= "0110";
        wait for 10 ns;

        a <= "0011";
        b <= "1010";
        wait;
    end process;

end test;
