library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_top is end entity;
architecture simulacao of tb_top is
    signal clk : std_logic := '0';
    signal executando : boolean := true;
    signal key : std_logic_vector(1 downto 0) := "01";
    signal sw : std_logic_vector(9 downto 0) := (others => '0');
    signal ledr : std_logic_vector(9 downto 0);
    signal hex0, hex1, hex2, hex3, hex4, hex5 : std_logic_vector(7 downto 0);
begin
    clk <= not clk after 10 ns when executando else '0';
    dut : entity work.cifrador_de10_lite
        generic map (CICLOS_DEBOUNCE => 4)
        port map (clk, key, sw, ledr, hex0, hex1, hex2, hex3, hex4, hex5);
    estimulos : process
        variable chave, mensagem : natural;
    begin
        for caso in 0 to 4 loop
            case caso is
                when 0 => chave := 682; mensagem := 204;
                when 1 => chave := 0; mensagem := 1023;
                when 2 => chave := 1023; mensagem := 0;
                when 3 => chave := 341; mensagem := 682;
                when others => chave := 1; mensagem := 512;
            end case;
            key <= "01"; wait for 100 ns;
            key(1) <= '1'; wait for 200 ns;
            -- Um aperto longo deve avancar somente de S0 para S1.
            key(0) <= '0'; wait for 400 ns;
            key(0) <= '1'; wait for 240 ns;
            sw <= std_logic_vector(to_unsigned(chave, 10)); wait for 100 ns;
            -- Bounce anterior ao aperto de captura da chave.
            for i in 0 to 2 loop
                key(0) <= '0'; wait for 20 ns;
                key(0) <= '1'; wait for 20 ns;
            end loop;
            key(0) <= '0'; wait for 400 ns;
            key(0) <= '1'; wait for 240 ns;
            sw <= std_logic_vector(to_unsigned(mensagem, 10)); wait for 100 ns;
            key(0) <= '0'; wait for 400 ns;
            key(0) <= '1'; wait for 240 ns;
            sw <= (others => '0'); wait for 120 ns;
            -- Confirmar com SW0=0 mantem o cifrado.
            key(0) <= '0'; wait for 400 ns;
            key(0) <= '1'; wait for 240 ns;
            sw(0) <= '1'; wait for 300 ns; -- SW0 sozinho nao inicia nada
            key(0) <= '0'; wait for 400 ns;
            key(0) <= '1'; wait for 240 ns;
            sw <= (others => '1');
            key(0) <= '0'; wait for 400 ns; -- ignorado em S10
            key(0) <= '1'; wait for 240 ns;
        end loop;
        -- Reset fisico durante o calculo, ao entrar em S3.
        key <= "01"; wait for 100 ns; key(1) <= '1'; wait for 200 ns;
        for i in 0 to 1 loop
            key(0) <= '0'; wait for 400 ns; key(0) <= '1'; wait for 240 ns;
        end loop;
        key(0) <= '0';
        wait until hex3 = x"B0"; -- codigo hexadecimal 3, S3
        wait for 2 ns; key(1) <= '0'; wait for 100 ns;
        key <= "11"; wait for 200 ns;
        executando <= false; wait;
    end process;
end architecture;
