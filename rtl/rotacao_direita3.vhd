library ieee;
use ieee.std_logic_1164.all;
use work.cifrador_pkg.all;

entity rotacao_direita3 is
    port (valor : in palavra10; resultado : out palavra10);
end entity;

architecture combinacional of rotacao_direita3 is
begin
    resultado <= valor(2 downto 0) & valor(9 downto 3);
end architecture;
