library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity roller is
 port(mode : in std_logic; A : in std_logic_vector(9 downto 0);
      R : out std_logic_vector(9 downto 0));
end entity;
architecture arch_roller of roller is
begin
 with mode select R <= A(6 downto 0) & A(9 downto 7) when '1',
                       A(2 downto 0) & A(9 downto 3) when others;
end architecture;
