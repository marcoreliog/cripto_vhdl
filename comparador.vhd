library ieee;
use ieee.std_logic_1164.all;

entity comparador is
    generic (
        data_width : positive := 10
    );
    port (
        a, b : in std_logic_vector(data_width - 1 downto 0);
        igual : out std_logic
    );
end comparador;

architecture arch_comparador of comparador is
begin

    igual <= '1' when not is_x(a) and not is_x(b) and a = b else '0';
end arch_comparador;
