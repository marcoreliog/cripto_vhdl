library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity comparador is
 generic(N : positive := 10);
 port(A, B : in std_logic_vector(N-1 downto 0); igual : out std_logic);
end entity;
architecture rtl of comparador is
begin
 igual <= '1' when A = B else '0';
end architecture;
