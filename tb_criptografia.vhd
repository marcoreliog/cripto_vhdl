library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.env.all;

entity tb_criptografia is
    generic (
        DIVISOR_TEST : positive := 2;
        AMOSTRAS_TEST : positive := 3
    );
end tb_criptografia;

architecture test of tb_criptografia is
    subtype word is std_logic_vector(9 downto 0);
    subtype segments is std_logic_vector(6 downto 0);
    type digits_t is array (0 to 15) of segments;
    constant digits : digits_t := (
        "0111111", "0000110", "1011011", "1001111",
        "1100110", "1101101", "1111101", "0000111",
        "1111111", "1101111", "1110111", "1111100",
        "0111001", "1011110", "1111001", "1110001"
    );
    constant settle : positive := 10 + DIVISOR_TEST * (AMOSTRAS_TEST + 1);
    signal clk, reset, confirmar, repetir : std_logic := '0';
    signal switches : word := (others => '0');
    signal valor : word;
    signal estado : std_logic_vector(4 downto 0);
    signal led, valido : std_logic;
    signal hex3, hex2, hex1, hex0 : segments;
begin
    clk <= not clk after 5 ns;

    dut: entity work.Criptografia
        generic map (
            DIVISOR_TICK => DIVISOR_TEST,
            AMOSTRAS_ESTAVEIS => AMOSTRAS_TEST
        )
        port map (
            clk => clk,
            reset => reset,
            botao_confirmar => confirmar,
            switches => switches,
            HEX3 => hex3,
            HEX2 => hex2,
            HEX1 => hex1,
            HEX0 => hex0,
            led_acerto => led,
            existe_cripto => valido,
            valor_saida => valor,
            estado => estado,
            botao_repetir => repetir
        );

    stimulus: process
        type coverage_t is array (0 to 16) of boolean;
        variable visited : coverage_t := (others => false);

        function bits(value : natural) return word is
        begin
            return std_logic_vector(to_unsigned(value, 10));
        end function;

        procedure tick(cycles : positive := 1) is
            variable current : natural;
        begin
            for count in 1 to cycles loop
                wait until rising_edge(clk);
                wait for 1 ns;
                current := to_integer(unsigned(estado));
                assert current <= 16 severity failure;
                visited(current) := true;
                assert hex0 = digits(to_integer(unsigned(valor(3 downto 0))))
                    and hex1 = digits(to_integer(unsigned(valor(7 downto 4))))
                    and hex2 = digits(to_integer(unsigned(valor(9 downto 8))))
                    report "Displays de valor desconectados" severity failure;
                if current = 16 then
                    if led = '1' then
                        assert hex3 = "1111000" report "Resultado correto deve mostrar t" severity failure;
                    else
                        assert hex3 = "1110001" report "Resultado incorreto deve mostrar F" severity failure;
                    end if;
                else
                    assert hex3 = digits(current) report "Display de estado incorreto" severity failure;
                end if;
            end loop;
        end procedure;

        procedure expect_state(value : natural) is
        begin
            assert to_integer(unsigned(estado)) = value
                report "Estado inesperado no topo: esperado S" & integer'image(value)
                & ", recebido S" & integer'image(to_integer(unsigned(estado))) severity failure;
        end procedure;

        procedure press_to(value : natural) is
        begin
            confirmar <= '1'; tick(settle); expect_state(value);
            confirmar <= '0'; tick(settle); expect_state(value);
        end procedure;

        procedure retry is
        begin
            repetir <= '1'; tick(settle); expect_state(10);
            assert valor = bits(19) and led = '0' and valido = '1'
                report "Repeticao nao restaurou o cifrado" severity failure;
            repetir <= '0'; tick(settle); expect_state(10);
        end procedure;
    begin
        reset <= '1'; confirmar <= '1'; tick(3);
        expect_state(0);
        assert valor = bits(0) and led = '0' and valido = '0' severity failure;
        reset <= '0'; tick(settle); expect_state(1);
        confirmar <= '0'; tick(settle);

        switches <= bits(1); press_to(1);
        assert valido = '0' severity failure;

        switches <= bits(0);
        if DIVISOR_TEST * AMOSTRAS_TEST >= 4 then
            for bounce in 1 to 3 loop
                confirmar <= '1'; tick;
                confirmar <= '0'; tick(3);
            end loop;
            tick(settle); expect_state(1);
        end if;
        press_to(2);

        switches <= bits(1); confirmar <= '1'; tick(settle); expect_state(3);
        assert valor = bits(1) severity failure;
        switches <= bits(1023); tick(settle); expect_state(3);
        assert valor = bits(1) report "Aperto longo recarregou o original" severity failure;
        confirmar <= '0'; tick(settle);
        switches <= bits(3); press_to(4);

        switches <= bits(3); press_to(4);
        assert valor = bits(2) severity failure;
        switches <= bits(2); press_to(4);
        assert valor = bits(16) severity failure;
        switches <= bits(1); press_to(4);
        assert valor = bits(19) severity failure;
        press_to(4);
        assert valor = bits(16) severity failure;
        press_to(4);
        assert valor = bits(19) severity failure;
        switches <= bits(0); press_to(1);
        assert valor = bits(19) and valido = '1' severity failure;

        switches <= bits(1); press_to(10);
        assert valor = bits(19) severity failure;
        switches <= bits(1); press_to(11);
        assert valor = bits(19) report "Selecionar XOR alterou X antes do palpite" severity failure;
        switches <= bits(4); press_to(10);
        assert valor = bits(23) severity failure;
        switches <= bits(0); press_to(16);
        assert led = '0' and valido = '1' severity failure;

        switches <= bits(1023); press_to(16);
        assert valor = bits(23) and led = '0' severity failure;
        retry;
        switches <= bits(1); press_to(11);
        switches <= bits(3); press_to(10);
        assert valor = bits(16) severity failure;
        switches <= bits(2); press_to(10);
        assert valor = bits(2) severity failure;
        switches <= bits(3); press_to(10);
        assert valor = bits(1) severity failure;
        switches <= bits(0); press_to(16);
        assert valor = bits(1) and led = '1' and valido = '1' severity failure;

        retry;
        switches <= bits(0); press_to(16);
        assert valor = bits(19) and led = '0' severity failure;

        reset <= '1'; confirmar <= '1'; repetir <= '1'; tick(2);
        expect_state(0);
        assert valor = bits(0) and led = '0' and valido = '0' severity failure;
        reset <= '0'; tick(settle); expect_state(1);
        confirmar <= '0'; repetir <= '0'; tick(settle);

        switches <= bits(0); press_to(2);
        switches <= bits(341); press_to(3);
        switches <= bits(1023); press_to(4);
        switches <= bits(0); press_to(1);
        assert valor = bits(341) and valido = '1' severity failure;
        switches <= bits(1); press_to(10);
        switches <= bits(0); press_to(16);
        assert valor = bits(341) and led = '1' severity failure;

        for current in visited'range loop
            assert visited(current) report "Estado sem cobertura no topo" severity failure;
        end loop;
        report "OK: topo Criptografia, botoes, displays, S0-S16, cifragem, decifragem, repeticao e reset";
        stop;
        wait;
    end process;

    watchdog: process
    begin
        wait for 1 ms;
        assert false report "A bancada nao terminou" severity failure;
        wait;
    end process;
end test;
