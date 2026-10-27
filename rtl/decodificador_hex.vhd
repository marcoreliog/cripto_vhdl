library ieee;
use ieee.std_logic_1164.all;

entity decodificador_hex is
    port (digito : in std_logic_vector(3 downto 0);
          segmentos_n : out std_logic_vector(7 downto 0));
end entity;

architecture combinacional of decodificador_hex is
begin
    -- bit 7 = DP apagado; bits 6..0 = g,f,e,d,c,b,a (ativos baixos).
    with digito select segmentos_n <=
        x"C0" when x"0", x"F9" when x"1", x"A4" when x"2", x"B0" when x"3",
        x"99" when x"4", x"92" when x"5", x"82" when x"6", x"F8" when x"7",
        x"80" when x"8", x"90" when x"9", x"88" when x"A", x"83" when x"B",
        x"C6" when x"C", x"A1" when x"D", x"86" when x"E", x"8E" when x"F",
        x"FF" when others;
end architecture;
