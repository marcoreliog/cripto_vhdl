library ieee;
use ieee.std_logic_1164.all;
use std.env.all;

entity tb_xor_maker is
end entity tb_xor_maker;

architecture test of tb_xor_maker is
    signal a, b, x : std_logic_vector(9 downto 0) := (others => '0');
begin
    dut : entity work.xor_maker port map (A => a, B => b, X => x);

    stimulus : process
    begin
        a <= "1011010011";
        b <= "0101010110";
        wait for 1 ns;
        assert x = "1110000101"
            report "XOR incorreto" severity failure;

        a <= "1111111111";
        b <= "1111111111";
        wait for 1 ns;
        assert x = "0000000000"
            report "XOR de valores iguais deve ser zero" severity failure;

        report "xor_maker: todos os testes passaram." severity note;
        stop;
        wait;
    end process;
end architecture test;
