library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Testbench de apresentacao: entradas, clock, processos e esperas por tempo.
-- Cada etapa numerada e conferida externamente por verificar_vcd.py.
entity tb_criptografia is end entity;
architecture sim of tb_criptografia is
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
    begin
        reset <= '1';
        wait for 20 ns;
        reset <= '0';
        -- CP1: Reset limpa o desafio e os registradores (20 ns).
        etapa <= 1;
        wait for 10 ns;

        modo_decifrar <= '1';
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 20 ns;
        -- CP2: Decifrar sem desafio permanece em INIT (60 ns).
        etapa <= 2;
        wait for 10 ns;

        modo_decifrar <= '0';
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 20 ns;
        -- CP3: Cifrar espera o valor original (100 ns).
        etapa <= 3;
        wait for 10 ns;

        switches <= std_logic_vector(to_unsigned(683, 10));
        wait for 20 ns;
        -- CP4: Mudar switches sem confirmar nao captura V nem X (130 ns).
        etapa <= 4;
        wait for 10 ns;

        switches <= std_logic_vector(to_unsigned(1, 10));
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 20 ns;
        -- CP5: Confirmacao captura V e X juntos (170 ns).
        etapa <= 5;
        wait for 10 ns;

        switches <= std_logic_vector(to_unsigned(341, 10));
        wait for 20 ns;
        -- CP6: Chave nao e capturada sem confirmacao (200 ns).
        etapa <= 6;
        wait for 10 ns;

        switches <= std_logic_vector(to_unsigned(3, 10));
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 20 ns;
        -- CP7: Confirmacao captura K e zera n (240 ns).
        etapa <= 7;
        wait for 10 ns;

        modo_decifrar <= '1';
        switches <= std_logic_vector(to_unsigned(1023, 10));
        wait for 20 ns;
        -- CP8: Modo fora do menu e switches fora da entrada sao ignorados (270 ns).
        etapa <= 8;
        wait for 10 ns;

        operacao <= "11";
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 20 ns;
        -- CP9: Operacao 11 na cifra nao altera X nem n (310 ns).
        etapa <= 9;
        wait for 10 ns;

        operacao <= "10";
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 20 ns;
        operacao <= "10";
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 20 ns;
        -- CP10: Duas camadas XOR deixam X em 001 e n em 2 (380 ns).
        etapa <= 10;
        wait for 10 ns;

        operacao <= "10";
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 10 ns;
        operacao <= "00";
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 20 ns;
        -- CP11: Tres XOR produzem 002; confirmacao com n=3 nao cria quarta camada (440 ns).
        etapa <= 11;
        wait for 10 ns;

        switches <= std_logic_vector(to_unsigned(341, 10));
        wait for 30 ns;
        -- CP12: Menu preserva e exibe C sem resetar o desafio (480 ns).
        etapa <= 12;
        wait for 10 ns;

        modo_decifrar <= '1';
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 20 ns;
        -- CP13: Preparacao restaura C e zera contador e LED (520 ns).
        etapa <= 13;
        wait for 10 ns;

        operacao <= "11";
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 20 ns;
        -- CP14: Operacao 11 na tentativa nao altera X nem n (560 ns).
        etapa <= 14;
        wait for 10 ns;

        operacao <= "10";
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 20 ns;
        -- CP15: Escolher XOR abre entrada de palpite sem executar camada (600 ns).
        etapa <= 15;
        wait for 10 ns;

        switches <= std_logic_vector(to_unsigned(341, 10));
        wait for 20 ns;
        -- CP16: Palpite exige uma confirmacao propria e nao consome camada (630 ns).
        etapa <= 16;
        wait for 10 ns;

        switches <= std_logic_vector(to_unsigned(0, 10));
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 30 ns;
        -- CP17: Primeiro XOR com palpite 000 executa uma camada (680 ns).
        etapa <= 17;
        wait for 10 ns;

        operacao <= "10";
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 20 ns;
        -- CP18: Segundo XOR exige outro palpite (720 ns).
        etapa <= 18;
        wait for 10 ns;

        switches <= std_logic_vector(to_unsigned(0, 10));
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 30 ns;
        -- CP19: Segundo palpite confirmado executa somente uma camada (770 ns).
        etapa <= 19;
        wait for 10 ns;

        operacao <= "10";
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 20 ns;
        -- CP20: Terceiro XOR exige terceiro palpite (810 ns).
        etapa <= 20;
        wait for 10 ns;

        switches <= std_logic_vector(to_unsigned(0, 10));
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 30 ns;
        -- CP21: Tentativa errada termina em 002 com LED apagado (860 ns).
        etapa <= 21;
        wait for 10 ns;

        switches <= std_logic_vector(to_unsigned(1023, 10));
        operacao <= "00";
        modo_decifrar <= '0';
        wait for 40 ns;
        -- CP22: RESULTADO errado permanece estavel sem confirmar (910 ns).
        etapa <= 22;
        wait for 10 ns;

        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 20 ns;
        -- CP23: Nova tentativa usa o mesmo C (950 ns).
        etapa <= 23;
        wait for 10 ns;

        -- Camada XOR 1: selecionar e depois confirmar o palpite.
        operacao <= "10";
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 20 ns;
        switches <= std_logic_vector(to_unsigned(3, 10));
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 30 ns;
        -- Camada XOR 2: selecionar e depois confirmar o palpite.
        operacao <= "10";
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 20 ns;
        switches <= std_logic_vector(to_unsigned(3, 10));
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 30 ns;
        -- Camada XOR 3: selecionar e depois confirmar o palpite.
        operacao <= "10";
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 20 ns;
        switches <= std_logic_vector(to_unsigned(3, 10));
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 30 ns;
        -- CP24: Tres palpites 003 recuperam 001 e acendem o LED (1170 ns).
        etapa <= 24;
        wait for 10 ns;

        wait for 50 ns;
        -- CP25: RESULTADO correto mantem LED e valor registrados (1230 ns).
        etapa <= 25;
        wait for 10 ns;

        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 20 ns;
        -- CP26: Reiniciar depois de acertar apaga o LED e restaura C (1270 ns).
        etapa <= 26;
        wait for 10 ns;

        operacao <= "10";
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 20 ns;
        switches <= std_logic_vector(to_unsigned(0, 10));
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 30 ns;
        operacao <= "10";
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 20 ns;
        switches <= std_logic_vector(to_unsigned(0, 10));
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 30 ns;
        operacao <= "10";
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 20 ns;
        switches <= std_logic_vector(to_unsigned(3, 10));
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 30 ns;
        -- CP27: Palpites diferentes 000 000 003 tambem acertam por igualdade (1490 ns).
        etapa <= 27;
        wait for 10 ns;

        reset <= '1';
        wait for 20 ns;
        reset <= '0';
        -- CP28: Reset apos sucesso cancela o desafio (1520 ns).
        etapa <= 28;
        wait for 10 ns;

        modo_decifrar <= '0';
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 20 ns;
        switches <= std_logic_vector(to_unsigned(1, 10));
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 20 ns;
        switches <= std_logic_vector(to_unsigned(3, 10));
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 20 ns;
        operacao <= "00";
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 20 ns;
        -- CP29: Caminho misto: P de 001 resulta em 002 (1650 ns).
        etapa <= 29;
        wait for 10 ns;

        operacao <= "01";
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 20 ns;
        -- CP30: Caminho misto: ROL3 de 002 resulta em 010 (1690 ns).
        etapa <= 30;
        wait for 10 ns;

        operacao <= "10";
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 30 ns;
        -- CP31: Caminho misto: XOR produz e salva 013 (1740 ns).
        etapa <= 31;
        wait for 10 ns;

        modo_decifrar <= '1';
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 20 ns;
        -- CP32: Tentativa mista comeca em 013 (1780 ns).
        etapa <= 32;
        wait for 10 ns;

        operacao <= "10";
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 20 ns;
        -- CP33: XOR misto pede palpite antes de executar (1820 ns).
        etapa <= 33;
        wait for 10 ns;

        switches <= std_logic_vector(to_unsigned(3, 10));
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 30 ns;
        -- CP34: XOR inverso com 003 produz 010 (1870 ns).
        etapa <= 34;
        wait for 10 ns;

        operacao <= "01";
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 20 ns;
        -- CP35: ROR3 de 010 produz 002 (1910 ns).
        etapa <= 35;
        wait for 10 ns;

        operacao <= "00";
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 10 ns;
        operacao <= "00";
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        -- CP36: Terceiro resultado 001 ja esta registrado em COMPARAR (1950 ns).
        etapa <= 36;
        wait for 10 ns;

        -- CP37: Clock seguinte registra o acerto (1960 ns).
        etapa <= 37;
        wait for 10 ns;

        wait for 30 ns;
        -- CP38: C e V permanecem preservados no resultado misto (2000 ns).
        etapa <= 38;
        wait for 10 ns;

        reset <= '1';
        wait for 20 ns;
        reset <= '0';
        -- CP39: Reset prepara ensaio de permutacoes repetidas (2030 ns).
        etapa <= 39;
        wait for 10 ns;

        modo_decifrar <= '0';
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 20 ns;
        switches <= std_logic_vector(to_unsigned(677, 10));
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 20 ns;
        switches <= std_logic_vector(to_unsigned(938, 10));
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 20 ns;
        operacao <= "00";
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 30 ns;
        operacao <= "00";
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 30 ns;
        operacao <= "00";
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 30 ns;
        -- CP40: Tres permutacoes sao permitidas e salvam 15A (2250 ns).
        etapa <= 40;
        wait for 10 ns;

        modo_decifrar <= '0';
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 20 ns;
        -- CP41: Nova cifra invalida o desafio anterior ja no menu (2290 ns).
        etapa <= 41;
        wait for 10 ns;

        switches <= std_logic_vector(to_unsigned(513, 10));
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 20 ns;
        switches <= std_logic_vector(to_unsigned(341, 10));
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 20 ns;
        operacao <= "01";
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 30 ns;
        operacao <= "01";
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 30 ns;
        operacao <= "01";
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 30 ns;
        -- CP42: Tres ROL3 sao permitidos e salvam 300 (2480 ns).
        etapa <= 42;
        wait for 10 ns;

        modo_decifrar <= '1';
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 20 ns;
        operacao <= "01";
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 30 ns;
        operacao <= "01";
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 30 ns;
        operacao <= "01";
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 30 ns;
        -- CP43: Tres ROR3 recuperam 201 e acendem LED (2640 ns).
        etapa <= 43;
        wait for 10 ns;

        reset <= '1';
        wait for 20 ns;
        reset <= '0';
        modo_decifrar <= '1';
        confirmar <= '1';
        wait for 10 ns;
        confirmar <= '0';
        wait for 20 ns;
        -- CP44: Reset final cancela desafio e bloqueia nova decifragem (2700 ns).
        etapa <= 44;
        wait for 10 ns;

        terminou <= true;
        wait for 10 ns;
        wait;
    end process;
end architecture;
