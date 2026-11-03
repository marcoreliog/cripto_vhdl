library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity incrementador is
 port(A : in std_logic_vector(1 downto 0); R : out std_logic_vector(1 downto 0));
end entity;
architecture rtl of incrementador is
begin
 R <= std_logic_vector(unsigned(A) + 1);
end architecture;
