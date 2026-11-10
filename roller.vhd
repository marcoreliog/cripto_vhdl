--ROLLER

library ieee;
use ieee.std_logic_1164.all;

entity roller is
	port(
		mode : in std_logic;
		A : in std_logic_vector(9 downto 0);
		R : out std_logic_vector(9 downto 0)
		);
end roller;

architecture arch_roller of roller is
begin
	with mode select
	R <= A(6 downto 0) & A(9 downto 7) WHEN '1',
		  A(2 downto 0) & A(9 downto 3) WHEN others;
	
end;
