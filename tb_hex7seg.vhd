library ieee;
use ieee.std_logic_1164.all;
use std.env.all;

entity tb_hex7seg is
end entity tb_hex7seg;

architecture test of tb_hex7seg is
    signal estado : std_logic_vector(3 downto 0) := "0000";
    signal acerto : std_logic := '0';
    signal hex5, hex4, hex3, hex2, hex1, hex0 : std_logic_vector(6 downto 0);
begin
    dut : entity work.hex7seg
        port map (
            estado => estado,
            acerto => acerto,
            hex5 => hex5,
            hex4 => hex4,
            hex3 => hex3,
            hex2 => hex2,
            hex1 => hex1,
            hex0 => hex0
        );

    stimulus : process
    begin
        wait for 1 ns;
        assert hex5 & hex4 & hex3 & hex2 & hex1 & hex0 =
            "1111111" & "1111111" & "1111111" & "1111111" & "1000000" & "1000000"
            report "estado 00 incorreto" severity failure;

        estado <= "1001";
        wait for 1 ns;
        assert hex1 = "1000000" and hex0 = "0010000"
            report "estado 09 incorreto" severity failure;

        estado <= "1010";
        wait for 1 ns;
        assert hex1 = "1111001" and hex0 = "1000000"
            report "estado 10 incorreto" severity failure;

        estado <= "1111";
        acerto <= '1';
        wait for 1 ns;
        assert hex5 & hex4 & hex3 & hex2 & hex1 & hex0 =
            "0001000" & "1000110" & "0000110" & "0101111" & "0000111" & "1000000"
            report "mensagem de acerto incorreta" severity failure;

        acerto <= '0';
        wait for 1 ns;
        assert hex5 & hex4 & hex3 & hex2 & hex1 & hex0 =
            "1111111" & "0000110" & "0101111" & "0101111" & "1000000" & "1111111"
            report "mensagem de erro incorreta" severity failure;

        report "hex7seg: todos os testes passaram." severity note;
        stop;
        wait;
    end process;
end architecture test;
