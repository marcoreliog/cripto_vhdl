--COMPARADOR

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity comparator is
    generic(
        N : natural := 8
    );
    port(
        a, b : in std_logic_vector(N-1 downto 0);
        gt, eq, lt : out std_logic
    );
end comparator;

architecture arch of comparator is
begin
    gt <= '1' when a > b else '0';
    eq <= '1' when a = b else '0';
    lt <= '1' when a < b else '0';
end arch;