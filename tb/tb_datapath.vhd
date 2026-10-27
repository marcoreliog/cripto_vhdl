library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.cifrador_pkg.all;

entity tb_datapath is end entity;
architecture simulacao of tb_datapath is
    signal clk : std_logic := '0';
    signal executando : boolean := true;
    signal reset : std_logic := '1';
    signal switches : palavra10 := (others => '0');
    signal ld_k, ld_x, ld_c, sel_saida : std_logic := '0';
    signal sel_op : codigo_op := OP_SWITCHES;
    signal valor_saida, chave_debug, trabalho_debug, cifrado_debug : palavra10;
begin
    clk <= not clk after 10 ns when executando else '0';
    dut : entity work.datapath
        port map (clk, reset, switches, ld_k, ld_x, ld_c, sel_op, sel_saida,
                  valor_saida, chave_debug, trabalho_debug, cifrado_debug);
    estimulos : process
    begin
        wait for 40 ns; reset <= '0';
        for valor in 0 to 1023 loop
            switches <= std_logic_vector(to_unsigned((valor*73+341) mod 1024, 10));
            ld_k <= '1'; ld_x <= '0'; ld_c <= '0'; wait for 20 ns;
            ld_k <= '0'; ld_x <= '1'; sel_op <= OP_SWITCHES;
            switches <= std_logic_vector(to_unsigned(valor, 10)); wait for 20 ns;
            -- Cada bloco e exercitado sobre todos os 1024 valores originais.
            for operacao in 1 to 4 loop
                sel_op <= OP_SWITCHES; wait for 20 ns;
                sel_op <= std_logic_vector(to_unsigned(operacao, 3));
                ld_c <= '1'; wait for 20 ns; ld_c <= '0';
            end loop;
            for invalido in 5 to 7 loop
                sel_op <= std_logic_vector(to_unsigned(invalido, 3));
                wait for 20 ns;
            end loop;
            ld_x <= '0'; switches <= (others => '1');
            sel_saida <= '1'; wait for 20 ns;
            sel_saida <= '0'; wait for 20 ns;
            -- C tambem tem enable independente de X (interface do datapath).
            ld_c <= '1'; sel_op <= OP_PERMUTA; wait for 20 ns;
            ld_c <= '0'; wait for 20 ns;
        end loop;
        reset <= '1'; ld_k <= '1'; ld_x <= '1'; ld_c <= '1';
        wait for 40 ns; executando <= false; wait;
    end process;
end architecture;
