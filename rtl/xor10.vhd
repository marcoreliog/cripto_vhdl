library ieee;
use ieee.std_logic_1164.all;
use work.cifrador_pkg.all;

entity xor10 is
    port (valor, chave : in palavra10; resultado : out palavra10);
end entity;

architecture combinacional of xor10 is
begin
    resultado <= valor xor chave;
end architecture;
