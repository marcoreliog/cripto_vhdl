library ieee;
use ieee.std_logic_1164.all;
use std.env.all;

entity tb_roller is
end entity tb_roller;

architecture test of tb_roller is
    signal mode : std_logic := '0';
    signal a, r : std_logic_vector(9 downto 0) := (others => '0');
begin
    dut : entity work.roller port map (mode => mode, A => a, R => r);

    stimulus : process
    begin
        a <= "1011010011";
        mode <= '0';
        wait for 1 ns;
        assert r = "1010011101"
            report "rotacao para a esquerda incorreta" severity failure;

        mode <= '1';
        wait for 1 ns;
        assert r = "0111011010"
            report "rotacao para a direita incorreta" severity failure;

        report "roller: todos os testes passaram." severity note;
        stop;
        wait;
    end process;
end architecture test;
