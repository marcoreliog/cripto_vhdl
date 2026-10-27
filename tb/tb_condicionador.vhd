library ieee;
use ieee.std_logic_1164.all;
use work.cifrador_pkg.all;

entity tb_condicionador is
    generic (CICLOS_TESTE : positive := 4);
end entity;
architecture simulacao of tb_condicionador is
    signal clk : std_logic := '0';
    signal executando : boolean := true;
    signal key0_n : std_logic := '1';
    signal key1_n : std_logic := '0';
    signal sw : palavra10 := (others => '0');
    signal reset, confirmar : std_logic;
    signal switches : palavra10;
begin
    clk <= not clk after 10 ns when executando else '0';
    dut : entity work.condicionador_entradas
        generic map (CICLOS_DEBOUNCE => CICLOS_TESTE)
        port map (clk, key0_n, key1_n, sw, reset, confirmar, switches);
    estimulos : process
    begin
        wait for 43 ns; key1_n <= '1';
        wait for 160 ns; sw <= "1010101010";
        -- Pulsos curtos alternados na pressao e soltura (bounce).
        for i in 0 to 3 loop
            key0_n <= '0'; wait for 20 ns;
            key0_n <= '1'; wait for 20 ns;
        end loop;
        key0_n <= '0'; wait for 400 ns;
        for i in 0 to 3 loop
            key0_n <= '1'; wait for 20 ns;
            key0_n <= '0'; wait for 20 ns;
        end loop;
        key0_n <= '1'; wait for 240 ns;
        sw <= "0011001100";
        key0_n <= '0'; wait for 400 ns;
        key0_n <= '1'; wait for 240 ns;
        -- KEY1 assincrono no meio do uso; reset cancela o filtro.
        key0_n <= '0'; wait for 37 ns;
        key1_n <= '0'; wait for 53 ns;
        key0_n <= '1'; key1_n <= '1'; wait for 240 ns;
        key0_n <= '0'; wait for 400 ns;
        key0_n <= '1'; wait for 240 ns;
        executando <= false; wait;
    end process;
end architecture;
