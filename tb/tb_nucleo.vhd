library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.cifrador_pkg.all;

entity tb_nucleo is end entity;
architecture simulacao of tb_nucleo is
    signal clk : std_logic := '0';
    signal executando : boolean := true;
    signal reset : std_logic := '1';
    signal confirmar : std_logic := '0';
    signal switches : palavra10 := (others => '0');
    signal valor_saida, chave_debug, trabalho_debug, cifrado_debug : palavra10;
    signal estado_codigo, leds_status : std_logic_vector(3 downto 0);
begin
    clk <= not clk after 10 ns when executando else '0';
    dut : entity work.nucleo_cifrador
        port map (clk, reset, confirmar, switches, valor_saida, estado_codigo,
                  leds_status, chave_debug, trabalho_debug, cifrado_debug);
    estimulos : process
        variable chave, mensagem : natural;
    begin
        for caso in 0 to 1050 loop
            case caso is
                when 0 => chave := 682; mensagem := 204; -- vetor do enunciado
                when 1 => chave := 0; mensagem := 0;
                when 2 => chave := 1023; mensagem := 1023;
                when 3 => chave := 0; mensagem := 1023;
                when 4 => chave := 1023; mensagem := 0;
                when 5 => chave := 341; mensagem := 682;
                when 6 => chave := 682; mensagem := 341;
                when 7 to 16 => chave := 682; mensagem := 2**(caso-7);
                when 17 to 26 => chave := 2**(caso-17); mensagem := 341;
                when others =>
                    mensagem := caso-27;
                    chave := (mensagem*73+341) mod 1024;
            end case;
            reset <= '1'; confirmar <= '0'; wait for 40 ns;
            reset <= '0'; wait for 20 ns;
            confirmar <= '1'; wait for 20 ns; confirmar <= '0';
            -- Ajuste das switches em S1 nao deve carregar nada.
            switches <= (others => '1'); wait for 20 ns;
            switches <= std_logic_vector(to_unsigned(chave, 10)); wait for 20 ns;
            confirmar <= '1'; wait for 20 ns; confirmar <= '0';
            switches <= std_logic_vector(to_unsigned(mensagem, 10)); wait for 40 ns;
            confirmar <= '1'; wait for 20 ns;
            switches <= (others => '1'); -- nao pode sobrescrever K ou X
            if caso mod 2 = 0 then confirmar <= '0'; end if;
            wait for 60 ns; -- S3, S4, S5: exatamente tres bordas
            confirmar <= '0'; switches <= (others => '0'); wait for 40 ns;
            switches(0) <= '1'; wait for 40 ns; -- sem confirmar, fica S6
            switches(0) <= '0'; confirmar <= '1'; wait for 20 ns;
            confirmar <= '0'; wait for 20 ns; -- confirma com SW0=0: fica S6
            switches(0) <= '1'; confirmar <= '1'; wait for 20 ns;
            if caso mod 2 = 0 then confirmar <= '0'; end if;
            wait for 60 ns; -- S7, S8, S9
            switches <= (others => '0'); confirmar <= '1'; wait for 40 ns;
        end loop;
        -- Reset interrompe todos os estados, inclusive durante as camadas.
        for alvo in 0 to 10 loop
            reset <= '1'; confirmar <= '1'; switches <= (others => '1');
            wait for 40 ns; reset <= '0'; wait for alvo * 20 ns;
            reset <= '1'; wait for 20 ns;
        end loop;
        executando <= false; wait;
    end process;
end architecture;
