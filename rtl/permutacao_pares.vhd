library ieee;
use ieee.std_logic_1164.all;
use work.cifrador_pkg.all;

entity permutacao_pares is
    port (valor : in palavra10; resultado : out palavra10);
end entity;

architecture combinacional of permutacao_pares is
begin
    pares : for i in 0 to 4 generate
        resultado(2*i)   <= valor(2*i+1);
        resultado(2*i+1) <= valor(2*i);
    end generate;
end architecture;
