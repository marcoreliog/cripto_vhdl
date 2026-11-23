library ieee;
use ieee.std_logic_1164.all;
use std.env.all;

entity tb_comparador is
end entity tb_comparador;

architecture test of tb_comparador is
    signal a, b : std_logic_vector(3 downto 0) := (others => '0');
    signal gt, eq, lt : std_logic;
begin
    dut : entity work.comparator
        generic map (N => 4)
        port map (a => a, b => b, gt => gt, eq => eq, lt => lt);

    stimulus : process
    begin
        a <= "0110";
        b <= "0110";
        wait for 1 ns;
        assert gt = '0' and eq = '1' and lt = '0'
            report "comparacao de valores iguais incorreta" severity failure;

        a <= "1001";
        b <= "0110";
        wait for 1 ns;
        assert gt = '1' and eq = '0' and lt = '0'
            report "comparacao maior que incorreta" severity failure;

        a <= "0011";
        b <= "1010";
        wait for 1 ns;
        assert gt = '0' and eq = '0' and lt = '1'
            report "comparacao menor que incorreta" severity failure;

        report "comparator: todos os testes passaram." severity note;
        stop;
        wait;
    end process;
end architecture test;
