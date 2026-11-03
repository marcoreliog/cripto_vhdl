library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity registrador is
 generic(N : positive := 10);
 port(clk, reset, carga : in std_logic;
      D : in std_logic_vector(N-1 downto 0);
      Q : out std_logic_vector(N-1 downto 0));
end entity;
architecture rtl of registrador is
begin
 process(clk)
 begin
  if rising_edge(clk) then
   if reset = '1' then Q <= (others => '0');
   elsif carga = '1' then Q <= D;
   end if;
  end if;
 end process;
end architecture;
