--CLOCK DIVIDER
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-- Pulso periódico de enable, sem criar um segundo clock.
entity clock_div is
 generic(DIVISOR : positive := 50000);
 port(clk, reset : in std_logic; tick : out std_logic);
end entity;
architecture rtl of clock_div is
 signal n : natural range 0 to DIVISOR-1;
begin
 process(clk)
 begin
  if rising_edge(clk) then
   tick <= '0';
   if reset = '1' then n <= 0;
   elsif n = DIVISOR-1 then n <= 0; tick <= '1';
   else n <= n + 1;
   end if;
  end if;
 end process;
end architecture;