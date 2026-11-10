-- Controladora do cifrador: FSM descrita em controladora_fsm.md.
-- enter e tentar_novamente devem chegar sincronizados com clock.
library ieee;
use ieee.std_logic_1164.all;

entity controller is
    port (
        enter, clock : in std_logic;
        reset : in std_logic := '0';
        op : in std_logic_vector(1 downto 0);

        ld_x, ld_k, ld_v, ld_c : out std_logic;
        sel : out std_logic_vector(2 downto 0);
        rot_dir, existe_cripto, acerto, clear : out std_logic;
        estado : out std_logic_vector(4 downto 0) := "00000";

        -- Lido em S1: 0 cria um desafio; 1 inicia a decifragem.
        modo_decifrar : in std_logic := '0';
        -- Realimentacao do comparador: X_reg = V_reg.
        igual : in std_logic := '0';
        -- Comando logico de S16, ainda sem mapeamento fisico definido.
        -- Sem conexao, S16 aguarda o reset global.
        tentar_novamente : in std_logic := '0'
    );
end controller;

architecture fsm of controller is
    -- S0: reset; S1: menu; S2: inserir valor; S3: inserir chave C.
    -- S4: selecionar C; S5: permutar C; S6: ROL C; S7: XOR C.
    -- S8: salvar cifrado; S9: preparar tentativa; S10: selecionar D.
    -- S11: inserir chave D; S12: XOR D; S13: ROR D; S14: permutar D.
    -- S15: comparar; S16: resultado.
    type state_t is (
        S0, S1, S2, S3, S4, S5, S6, S7, S8,
        S9, S10, S11, S12, S13, S14, S15, S16
    );
    signal estado_atual, estado_prox : state_t := S0;
    signal valido_reg, acerto_reg : std_logic := '0';
    signal enter_anterior, repetir_anterior : std_logic := '0';
    signal confirmar, repetir : std_logic;
begin
    existe_cripto <= valido_reg;
    acerto <= acerto_reg;
    confirmar <= enter and not enter_anterior;
    repetir <= tentar_novamente and not repetir_anterior;

    process (clock)
    begin
        if rising_edge(clock) then
            -- Um comando por aperto, inclusive ao sair de um reset.
            enter_anterior <= enter;
            repetir_anterior <= tentar_novamente;

            if reset = '1' then
                estado_atual <= S0;
                valido_reg <= '0';
                acerto_reg <= '0';
            else
                estado_atual <= estado_prox;

                if estado_atual = S0 or
                   (estado_atual = S1 and confirmar = '1' and modo_decifrar = '0') then
                    valido_reg <= '0';
                elsif estado_atual = S8 then
                    valido_reg <= '1';
                end if;

                if estado_atual = S0 or estado_atual = S9 or
                   (estado_atual = S1 and confirmar = '1' and modo_decifrar = '0') then
                    acerto_reg <= '0';
                elsif estado_atual = S15 then
                    -- O resultado depende de X = V, nao da igualdade das chaves.
                    acerto_reg <= igual;
                end if;
            end if;
        end if;
    end process;

    process (estado_atual, confirmar, repetir, op, modo_decifrar, valido_reg, reset)
    begin
        ld_v <= '0';
        ld_k <= '0';
        ld_x <= '0';
        ld_c <= '0';
        rot_dir <= '0';
        clear <= reset;
        -- MUX de X: 000 SW; 001 XOR; 010 roller; 011 permuter; 100 C.
        sel <= "000";
        estado_prox <= estado_atual;

        case estado_atual is
            when S0 =>
                clear <= '1';
                estado_prox <= S1;

            when S1 =>
                if confirmar = '1' and modo_decifrar = '0' then
                    estado_prox <= S2;
                elsif confirmar = '1' and modo_decifrar = '1' and valido_reg = '1' then
                    estado_prox <= S9;
                end if;

            when S2 =>
                if confirmar = '1' then
                    ld_v <= '1';
                    ld_x <= '1';
                    estado_prox <= S3;
                end if;

            when S3 =>
                if confirmar = '1' then
                    ld_k <= '1';
                    estado_prox <= S4;
                end if;

            when S4 =>
                -- Operacoes livres: somente 00 confirmado encerra a fase.
                if confirmar = '1' and op = "00" then
                    estado_prox <= S8;
                elsif confirmar = '1' and op = "01" then
                    estado_prox <= S7;
                elsif confirmar = '1' and op = "10" then
                    estado_prox <= S6;
                elsif confirmar = '1' and op = "11" then
                    estado_prox <= S5;
                end if;

            when S5 =>
                ld_x <= '1';
                sel <= "011";
                estado_prox <= S4;

            when S6 =>
                ld_x <= '1';
                sel <= "010";
                rot_dir <= '1';
                estado_prox <= S4;

            when S7 =>
                ld_x <= '1';
                sel <= "001";
                estado_prox <= S4;

            when S8 =>
                -- C recebe o X ja registrado, mesmo apos zero operacoes.
                ld_c <= '1';
                estado_prox <= S1;

            when S9 =>
                ld_x <= '1';
                sel <= "100";
                estado_prox <= S10;

            when S10 =>
                if confirmar = '1' and op = "00" then
                    estado_prox <= S15;
                elsif confirmar = '1' and op = "01" then
                    estado_prox <= S11;
                elsif confirmar = '1' and op = "10" then
                    estado_prox <= S13;
                elsif confirmar = '1' and op = "11" then
                    estado_prox <= S14;
                end if;

            when S11 =>
                -- Exige outro aperto para confirmar o palpite de cada XOR.
                if confirmar = '1' then
                    ld_k <= '1';
                    estado_prox <= S12;
                end if;

            when S12 =>
                ld_x <= '1';
                sel <= "001";
                estado_prox <= S10;

            when S13 =>
                ld_x <= '1';
                sel <= "010";
                estado_prox <= S10;

            when S14 =>
                ld_x <= '1';
                sel <= "011";
                estado_prox <= S10;

            when S15 =>
                estado_prox <= S16;

            when S16 =>
                -- O display usa estado = 10000 e acerto para mostrar t/F.
                if repetir = '1' then
                    estado_prox <= S9;
                end if;
        end case;

        -- O reset tambem bloqueia cargas e limpa o datapath na mesma borda.
        if reset = '1' then
            estado_prox <= S0;
            ld_v <= '0';
            ld_k <= '0';
            ld_x <= '0';
            ld_c <= '0';
            sel <= "000";
            rot_dir <= '0';
        end if;
    end process;

    with estado_atual select
        estado <= "00000" when S0,
                  "00001" when S1,
                  "00010" when S2,
                  "00011" when S3,
                  "00100" when S4,
                  "00101" when S5,
                  "00110" when S6,
                  "00111" when S7,
                  "01000" when S8,
                  "01001" when S9,
                  "01010" when S10,
                  "01011" when S11,
                  "01100" when S12,
                  "01101" when S13,
                  "01110" when S14,
                  "01111" when S15,
                  "10000" when S16;
end fsm;
