library ieee;
use ieee.std_logic_1164.all;
use work.cifrador_pkg.all;

entity nucleo_cifrador is
    port (
        clk, reset, confirmar : in std_logic;
        switches : in palavra10;
        valor_saida : out palavra10;
        estado_codigo, leds_status : out std_logic_vector(3 downto 0);
        chave_debug, trabalho_debug, cifrado_debug : out palavra10
    );
end entity;

architecture estrutural of nucleo_cifrador is
    signal ld_k, ld_x, ld_c, sel_saida : std_logic;
    signal sel_op : codigo_op;
begin
    u_controle : entity work.unidade_controle
        port map (clk, reset, confirmar, switches(0), ld_k, ld_x, ld_c,
                  sel_op, sel_saida, estado_codigo, leds_status);
    u_datapath : entity work.datapath
        port map (clk, reset, switches, ld_k, ld_x, ld_c, sel_op, sel_saida,
                  valor_saida, chave_debug, trabalho_debug, cifrado_debug);
end architecture;
