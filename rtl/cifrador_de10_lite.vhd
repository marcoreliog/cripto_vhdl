library ieee;
use ieee.std_logic_1164.all;
use work.cifrador_pkg.all;

entity cifrador_de10_lite is
    generic (CICLOS_DEBOUNCE : positive := 500000);
    port (
        MAX10_CLK1_50 : in std_logic;
        KEY : in std_logic_vector(1 downto 0);
        SW : in std_logic_vector(9 downto 0);
        LEDR : out std_logic_vector(9 downto 0);
        HEX0, HEX1, HEX2, HEX3, HEX4, HEX5 : out std_logic_vector(7 downto 0)
    );
end entity;

architecture estrutural of cifrador_de10_lite is
    signal reset, confirmar : std_logic;
    signal switches, valor_saida : palavra10;
    signal estado_codigo, leds_status : std_logic_vector(3 downto 0);
begin
    u_entradas : entity work.condicionador_entradas
        generic map (CICLOS_DEBOUNCE => CICLOS_DEBOUNCE)
        port map (MAX10_CLK1_50, KEY(0), KEY(1), SW, reset, confirmar, switches);
    u_nucleo : entity work.nucleo_cifrador
        port map (MAX10_CLK1_50, reset, confirmar, switches, valor_saida,
                  estado_codigo, leds_status, open, open, open);
    u_exibicao : entity work.exibicao
        port map (valor_saida, estado_codigo, leds_status,
                  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, LEDR);
end architecture;
