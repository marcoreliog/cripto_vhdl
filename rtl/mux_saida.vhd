library ieee;
use ieee.std_logic_1164.all;
use work.cifrador_pkg.all;

entity mux_saida is
    port (valor_x, valor_c : in palavra10;
          sel_saida : in std_logic; resultado : out palavra10);
end entity;

architecture combinacional of mux_saida is
begin
    resultado <= valor_c when sel_saida = '1' else valor_x;
end architecture;
