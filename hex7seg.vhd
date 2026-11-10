library ieee;
use ieee.std_logic_1164.all;

entity hex7seg is
    port (
        digito : in std_logic_vector(3 downto 0);
        segmentos : out std_logic_vector(6 downto 0);
        resultado : in std_logic := '0';
        acerto : in std_logic := '0'
    );
end hex7seg;

architecture arch_hex7seg of hex7seg is
    signal hexadecimal : std_logic_vector(6 downto 0);
begin
    with digito select
        hexadecimal <= "0111111" when x"0",
                       "0000110" when x"1",
                       "1011011" when x"2",
                       "1001111" when x"3",
                       "1100110" when x"4",
                       "1101101" when x"5",
                       "1111101" when x"6",
                       "0000111" when x"7",
                       "1111111" when x"8",
                       "1101111" when x"9",
                       "1110111" when x"A",
                       "1111100" when x"B",
                       "0111001" when x"C",
                       "1011110" when x"D",
                       "1111001" when x"E",
                       "1110001" when x"F",
                       "0000000" when others;

    segmentos <= "1111000" when resultado = '1' and acerto = '1' else
                 "1110001" when resultado = '1' and acerto = '0' else
                 hexadecimal when resultado = '0' else
                 "0000000";
end arch_hex7seg;
