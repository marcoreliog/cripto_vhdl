library ieee;
use ieee.std_logic_1164.all;
use work.cifrador_pkg.all;

entity rotacao_esquerda3 is
    port (valor : in palavra10; resultado : out palavra10);
end entity;

architecture combinacional of rotacao_esquerda3 is
begin
    resultado <= valor(6 downto 0) & valor(9 downto 7);
end architecture;
