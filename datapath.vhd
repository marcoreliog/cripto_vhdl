--DATAPATH

library IEEE;
use IEEE.STD_LOGIC_1164.all;	


entity datapath is
	port(
	clk_sys, ld_x, ld_k, ld_v, ld_c, rot_dir, clr : in std_logic; --controles de dados
	
	sw : in std_logic_vector(9 downto 0); --inputs de dados
	
	sel : in std_logic_Vector(2 downto 0); -- seletor de mux
	
	equals, existe_cripto : out std_logic --flags para mudança de estado
	
	);
end datapath;

architecture arch_datapath of datapath is	
	signal val_x, val_k, val_v, val_c, out_xor, out_rot, out_perm, mux_x  : std_logic_vector(9 downto 0);
begin
	reg_v : entity work.registrador
		generic map (N => 10)
		port map(
			clk => clk_sys,
			clear => clr,
			carga => ld_v,
			D => sw,
			Q => val_v,
			loaded => open
		);
	
	reg_k : entity work.registrador
		generic map (N => 10)
		port map(
			clk => clk_sys,
			clear => clr,
			carga => ld_k,
			D => sw,
			Q => val_k,
			loaded => open
		);
	
	reg_x : entity work.registrador
		generic map (N => 10)
		port map(
			clk => clk_sys,
			clear => clr,
			carga => ld_x,
			D => mux_x,
			Q => val_x,
			loaded => open
		);
		
	reg_c : entity work.registrador
		generic map (N => 10)
		port map(
			clk => clk_sys,
			clear => clr,
			carga => ld_c,
			D => val_x,
			Q => val_c,
			loaded => existe_cripto
		);
		
	comp : entity work.comparator
		generic map (N => 10)
		port map(
			a => val_v,
			b => val_x,
			eq => equals,
			lt => open,
			gt => open
		);
			
	roller : entity work.roller
		port map(
			A => val_x,
			R => out_rot,
			mode => rot_dir
		);
	
	perm : entity work.permuter
		port map(
			A => val_x,
			P => out_perm
		);
	
	xor_maker : entity work.xor_maker
		port map(
			A => val_x,
			B => val_k,
			X => out_xor
		);
	
	WITH sel SELECT
		mux_x <=
			sw	WHEN "000",
			out_xor WHEN "001",
			out_rot WHEN "010",
			out_perm WHEN "011",
			val_c WHEN "100",
			val_x WHEN OTHERS;
	
	end architecture;			