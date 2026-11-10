library ieee;
use ieee.std_logic_1164.all;

entity registrador is
    generic (
        W : positive := 10
    );
    port (
        i : in std_logic_vector(W - 1 downto 0);
        ld, clk, clr : in std_logic;
        q : out std_logic_vector(W - 1 downto 0)
    );
end registrador;

architecture arch_registrador of registrador is
begin

    process (clk)
    begin
        if rising_edge(clk) then
            if clr = '1' then
                q <= (others => '0');
            elsif ld = '1' then
                q <= i;
            end if;
        end if;
    end process;
end arch_registrador;
