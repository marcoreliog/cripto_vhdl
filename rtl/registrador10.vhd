library ieee;
use ieee.std_logic_1164.all;
use work.cifrador_pkg.all;

entity registrador10 is
    port (clk, reset, habilita : in std_logic;
          entrada : in palavra10; saida : out palavra10);
end entity;

architecture rtl of registrador10 is
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                saida <= (others => '0');
            elsif habilita = '1' then
                saida <= entrada;
            end if;
        end if;
    end process;
end architecture;
