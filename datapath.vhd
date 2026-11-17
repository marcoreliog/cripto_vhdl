--DATAPATH

library IEEE;
use IEEE.STD_LOGIC_1164.all;	


entity datapath is
	port(
	clk_sys, ld_x, ld_k, ld_v, ld_c, rot_dir, existe_cripto, clear : in std_logic; --controles de dados
	
	switches : in std_logic_vector(9 downto 0); --inputs de dados
	
	sel : in std_logic_Vector(2 downto 0); -- seletor de mux
	
	equals, existe_cripto : out std_logic; --flags para mudança de estado
	
	);
end datapath;