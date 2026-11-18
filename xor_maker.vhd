--XOR
library ieee;
use ieee.std_logic_1164.all;

entity XOR_maker is
	port(
		A, B : in std_logic_vector(9 downto 0);
		X : out std_logic_vector(9 downto 0)
		);
end XOR_maker;

architecture arch_xor of XOR_maker is
begin
	X <= A xor B;
end;
