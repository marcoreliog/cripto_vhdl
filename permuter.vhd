--PERMUTER

library ieee;
use ieee.std_logic_1164.all;

entity permuter is
	port(
		A : in std_logic_vector(9 downto 0);
		P : out std_logic_vector(9 downto 0)
		);
end permuter;

architecture arch_permuter of permuter is
begin
	P(9) <= A(8); P(8) <= A(9); 

	P(7) <= A(6); P(6) <= A(7); 
	
	P(5) <= A(4); P(4) <= A(5); 
	
	P(3) <= A(2); P(2) <= A(3); 
	
	P(1) <= A(0); P(0) <= A(1); 

end;
