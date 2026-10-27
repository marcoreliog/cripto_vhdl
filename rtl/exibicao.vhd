library ieee;
use ieee.std_logic_1164.all;
use work.cifrador_pkg.all;

entity exibicao is
    port (
        valor : in palavra10;
        estado, leds_status : in std_logic_vector(3 downto 0);
        hex0, hex1, hex2, hex3, hex4, hex5 : out std_logic_vector(7 downto 0);
        ledr : out std_logic_vector(9 downto 0)
    );
end entity;

architecture estrutural of exibicao is
begin
    u_hex0 : entity work.decodificador_hex port map (valor(3 downto 0), hex0);
    u_hex1 : entity work.decodificador_hex port map (valor(7 downto 4), hex1);
    u_hex2 : entity work.decodificador_hex port map ("00" & valor(9 downto 8), hex2);
    u_hex3 : entity work.decodificador_hex port map (estado, hex3);
    hex4 <= (others => '1'); hex5 <= (others => '1');
    ledr <= "000000" & leds_status;
end architecture;
