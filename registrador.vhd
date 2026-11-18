--REGISTRADOR
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity registrador is
 generic(N : positive := 8);
 port(clk, clear, carga : in std_logic;
      D : in std_logic_vector(N-1 downto 0);
      Q : out std_logic_vector(N-1 downto 0));
		loaded : in std_logic;
end entity;
architecture rtl of registrador is
begin
 process(clk)
 begin
  if rising_edge(clk) then
   if clear = '1' then 
      Q <= (others => '0');
      loaded <= '0';
   elsif carga = '1' then 
      Q <= D;
      loaded <= '1';
   end if;
  end if;
 end process;
 
end architecture;