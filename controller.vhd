--CONTROLLER

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity controller is
	port(
		enter, clock, modo, equals, existe_cripto : in std_logic;
		
		reset : in std_logic := '0';
		
		op : in std_logic_vector(1 downto 0);
		
		--modo e op são inputs de switches
		--reset e enter são botões distintos
		
		ld_x, ld_k, ld_v, ld_c : out std_logic;
		sel : out std_logic_vector(2 downto 0);
		rot_dir, clr : out std_logic;
		display : out std_logic_vector(3 downto 0) := "0000" --controle do display
	);
end entity;

architecture arch_controller of controller is
	type state is
	(
	INIT, MENU, INSERT_V, INSERT_K,
	SEL_OP_C, PERM_C, ROL_C, XOR_C,
	SAVE_C, ATTEMPT_D, SEL_OP_D,
	TRY_K, XOR_D, ROR_D, PERM_D, RESULT
	);
	
	signal atual, prox : state := INIT;	
	
	
begin
	 update : process (clock, reset)
    begin
			if reset = '0' then
            atual <= INIT;
			elsif rising_edge(clock) then
				atual <= prox;
  			end if;
    end process;
	 
	 state_control : process(all)
	 begin
		   prox <= atual;
		   ld_v <= '0';
		   ld_k <= '0';
	 	   ld_x <= '0';
	  	   ld_c <= '0';
		   rot_dir <= '0';
		   clr <= '0';
		   sel <= "000";
			
			
		   case atual is
			
			WHEN INIT =>
				clr <= '1';
				prox <= MENU;
				
			WHEN MENU => 
				if enter = '0' THEN
					if modo = '0' THEN
						clr <= '1';
						prox <= INSERT_V;
					elsif modo = '1' AND existe_cripto = '1' THEN 
						prox <= ATTEMPT_D;
					end if;
				end if;
				
			WHEN INSERT_V => 
				if enter = '0' THEN
					ld_x <= '1';
					ld_v <= '1';
					sel <= "000";
					prox <= INSERT_K;
				end if;
			WHEN INSERT_K =>
				if enter = '0' THEN
					ld_k <= '1';
					sel <= "000";
					prox <= SEL_OP_C;
				end if;
				
			WHEN SEL_OP_C =>
				if enter = '0' AND op = "00" THEN	
					prox <= SAVE_C;
				end if;	
				if enter = '0' AND op = "01" THEN
					prox <= XOR_C;
				end if;
				if enter = '0' AND op = "10" THEN
					prox <= ROL_C;
				end if;
				if enter = '0' AND op = "11" THEN
					prox <= PERM_C;
				end if;

			WHEN XOR_C =>
				ld_x <= '1';
				sel <= "001";
				prox <= SEL_OP_C;
			WHEN ROL_C =>
				ld_x <= '1';
				sel <= "010";
				rot_dir <= '0';
				prox <= SEL_OP_C;
			WHEN PERM_C =>
				ld_x <= '1';
				sel <= "011";
				prox <= SEL_OP_C;
			
			WHEN SAVE_C =>
				ld_c <= '1';
				prox <= MENU;
				
			WHEN ATTEMPT_D =>
				ld_x <= '1';
				sel <= "100";
				prox <= SEL_OP_D;
				
			WHEN SEL_OP_D =>
				if enter = '0' AND op = "00" THEN	
					prox <= RESULT;
				end if;
				if enter = '0' AND op = "01" THEN
					prox <= TRY_K;
				end if;
				if enter = '0' AND op = "10" THEN
					prox <= ROR_D;
				end if;
				if enter = '0' AND op = "11" THEN
					prox <= PERM_D;
				end if;
				
			WHEN TRY_K =>
				if enter = '0' THEN
					ld_k <= '1';
					prox <= XOR_D;
				end if;
			WHEN XOR_D =>
				ld_x <= '1';
				sel <= "001";
				prox <= SEL_OP_D;
			WHEN ROR_D =>
				ld_x <= '1';
				sel <= "010";
				rot_dir <= '1';
				prox <= SEL_OP_D;
			WHEN PERM_D =>
				ld_x <= '1';
				sel <= "011";
				prox <= SEL_OP_D;
				
			WHEN RESULT =>
				if enter = '0' THEN	--estado parado para exibir o resultado
					prox <= MENU;
				end if;
		  end case;
		end process;
		
		
		WITH atual SELECT
		display <=
	    "0000" WHEN INIT,
		 
		 "0001" WHEN MENU,
		 "0010" WHEN INSERT_V,
		 "0011" WHEN INSERT_K,
		 "0100" WHEN SEL_OP_C,
		 "0101" WHEN PERM_C,
		 "0110" WHEN ROL_C,
		 "0111" WHEN XOR_C,
		 "1000" WHEN SAVE_C,
		 
		 "1001" WHEN ATTEMPT_D,
		 "1010" WHEN SEL_OP_D,
		 "1011" WHEN TRY_K,
		 "1100" WHEN XOR_D,
		 "1101" WHEN ROR_D,
		 "1110" WHEN PERM_D,
		 "1111" WHEN RESULT;
		 
end arch_controller;