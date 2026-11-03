library ieee;
use ieee.std_logic_1164.all;

-- Segmentos logicos ativos em 1, ordem gfedcba (bit 0 = a).
-- Adaptar polaridade e ordem dos pinos no futuro modulo da placa.
entity hex7seg is
    port (
        digito : in std_logic_vector(3 downto 0);
        segmentos : out std_logic_vector(6 downto 0)
    );
end entity;

architecture rtl of hex7seg is
begin
    with digito select segmentos <=
        "0111111" when x"0", "0000110" when x"1",
        "1011011" when x"2", "1001111" when x"3",
        "1100110" when x"4", "1101101" when x"5",
        "1111101" when x"6", "0000111" when x"7",
        "1111111" when x"8", "1101111" when x"9",
        "1110111" when x"A", "1111100" when x"B",
        "0111001" when x"C", "1011110" when x"D",
        "1111001" when x"E", "1110001" when x"F",
        "0000000" when others;
end architecture;
