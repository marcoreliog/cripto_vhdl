library ieee;
use ieee.std_logic_1164.all;
use work.cifrador_pkg.all;

entity tb_controle is end entity;
architecture simulacao of tb_controle is
    signal clk : std_logic := '0';
    signal executando : boolean := true;
    signal reset : std_logic := '1';
    signal confirmar, escolher_decifrar : std_logic := '0';
    signal ld_k, ld_x, ld_c, sel_saida : std_logic;
    signal sel_op : codigo_op;
    signal estado_codigo, leds_status : std_logic_vector(3 downto 0);
begin
    clk <= not clk after 10 ns when executando else '0';
    dut : entity work.unidade_controle
        port map (clk, reset, confirmar, escolher_decifrar, ld_k, ld_x, ld_c,
                  sel_op, sel_saida, estado_codigo, leds_status);
    estimulos : process
    begin
        -- Cada percurso repete os calculos com confirmar baixo ou alto.
        for variante in 0 to 1 loop
            reset <= '1'; confirmar <= '0'; escolher_decifrar <= '0';
            wait for 40 ns; reset <= '0';
            wait for 40 ns; escolher_decifrar <= '1';
            wait for 20 ns; confirmar <= '1';
            wait for 20 ns; confirmar <= '0';
            wait for 40 ns; confirmar <= '1';
            wait for 20 ns; confirmar <= '0';
            wait for 40 ns; confirmar <= '1';
            wait for 20 ns;
            if variante = 0 then confirmar <= '0'; end if;
            wait for 60 ns;
            confirmar <= '0'; escolher_decifrar <= '0'; wait for 40 ns;
            escolher_decifrar <= '1'; wait for 40 ns;
            confirmar <= '1'; escolher_decifrar <= '0'; wait for 40 ns;
            escolher_decifrar <= '1'; wait for 20 ns;
            if variante = 0 then confirmar <= '0'; end if;
            wait for 60 ns;
            confirmar <= '0'; wait for 20 ns;
            confirmar <= '1'; wait for 40 ns;
        end loop;
        -- Com confirmar=1 e escolha=1, o numero de bordas visita S0..S10.
        -- O reset seguinte interrompe cada um dos onze estados.
        for alvo in 0 to 10 loop
            reset <= '1'; confirmar <= '1'; escolher_decifrar <= '1';
            wait for 40 ns; reset <= '0';
            wait for alvo * 20 ns;
            reset <= '1'; wait for 20 ns;
        end loop;
        executando <= false; wait;
    end process;
end architecture;
