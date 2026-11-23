library ieee;
use ieee.std_logic_1164.all;
use std.env.all;

entity tb_permuter is
end entity tb_permuter;

architecture test of tb_permuter is
    signal a, p : std_logic_vector(9 downto 0) := (others => '0');
begin
    dut : entity work.permuter port map (A => a, P => p);

    stimulus : process
    begin
        a <= "1011001001";
        wait for 1 ns;
        assert p = "0111000110"
            report "permutacao dos pares incorreta" severity failure;

        a <= "0000000000";
        wait for 1 ns;
        assert p = "0000000000"
            report "permutacao de zero incorreta" severity failure;

        report "permuter: todos os testes passaram." severity note;
        stop;
        wait;
    end process;
end architecture test;
