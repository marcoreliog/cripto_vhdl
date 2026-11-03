library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Ensaio complementar: todas as 3^3 sequencias, com sua inversa.
entity tb_sequencias is end entity;
architecture sim of tb_sequencias is
    signal clk, reset, confirmar, modo_decifrar, led_acerto : std_logic := '0';
    signal switches, valor_saida : std_logic_vector(9 downto 0) := (others => '0');
    signal operacao : std_logic_vector(1 downto 0) := "00";
    signal estado : std_logic_vector(3 downto 0);
    signal etapa : natural := 0;
    signal terminou : boolean := false;
begin
    dut : entity work.temp1
        port map (
            clk => clk, reset => reset, confirmar => confirmar,
            modo_decifrar => modo_decifrar, switches => switches,
            operacao => operacao, valor_saida => valor_saida,
            led_acerto => led_acerto, estado => estado
        );
    process
    begin
        while not terminou loop
            clk <= '0'; wait for 5 ns;
            clk <= '1'; wait for 5 ns;
        end loop;
        clk <= '0';
        wait;
    end process;
    process
        type operacoes_t is array (0 to 2) of natural range 0 to 2;
        variable sequencia : operacoes_t;
    begin
        for caso in 0 to 26 loop
            sequencia(0) := caso / 9;
            sequencia(1) := (caso / 3) mod 3;
            sequencia(2) := caso mod 3;
            reset <= '1'; confirmar <= '0'; wait for 20 ns;
            reset <= '0'; modo_decifrar <= '0';
            confirmar <= '1'; wait for 10 ns;
            confirmar <= '0'; wait for 20 ns;
            switches <= std_logic_vector(to_unsigned((caso * 37 + 1) mod 1024, 10));
            confirmar <= '1'; wait for 10 ns;
            confirmar <= '0'; wait for 20 ns;
            switches <= std_logic_vector(to_unsigned((caso * 19 + 3) mod 1024, 10));
            confirmar <= '1'; wait for 10 ns;
            confirmar <= '0'; wait for 20 ns;
            for camada in 0 to 2 loop
                operacao <= std_logic_vector(to_unsigned(sequencia(camada), 2));
                confirmar <= '1'; wait for 10 ns;
                confirmar <= '0'; wait for 30 ns;
            end loop;
            modo_decifrar <= '1';
            confirmar <= '1'; wait for 10 ns;
            confirmar <= '0'; wait for 20 ns;
            for camada in 2 downto 0 loop
                operacao <= std_logic_vector(to_unsigned(sequencia(camada), 2));
                confirmar <= '1'; wait for 10 ns;
                confirmar <= '0'; wait for 30 ns;
                if sequencia(camada) = 2 then
                    -- Cada XOR tem sua propria confirmacao de palpite.
                    switches <= std_logic_vector(to_unsigned((caso * 19 + 3) mod 1024, 10));
                    confirmar <= '1'; wait for 10 ns;
                    confirmar <= '0'; wait for 30 ns;
                end if;
            end loop;
            etapa <= caso + 1;
            wait for 10 ns;
        end loop;
        terminou <= true;
        wait for 10 ns;
        wait;
    end process;
end architecture;
