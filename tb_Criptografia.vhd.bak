library ieee;
use ieee.std_logic_1164.all;
use std.env.all;

entity tb_Criptografia is
end entity tb_Criptografia;

architecture test of tb_Criptografia is
    signal base_clock : std_logic := '0';
    signal enter : std_logic := '1';
    signal reset, modo : std_logic := '0';
    signal op : std_logic_vector(1 downto 0) := "00";
    signal sw : std_logic_vector(9 downto 0) := (others => '0');
    signal hex5, hex4, hex3, hex2, hex1, hex0 : std_logic_vector(6 downto 0);

    type digitos is array (0 to 9) of std_logic_vector(6 downto 0);
    constant DECIMAL : digitos := (
        "1000000", "1111001", "0100100", "0110000", "0011001",
        "0010010", "0000010", "1111000", "0000000", "0010000"
    );
    constant APAGADO : std_logic_vector(6 downto 0) := "1111111";
    constant ACERTO : std_logic_vector(41 downto 0) :=
        not ("1110111" & "0111001" & "1111001" & "1010000" & "1111000" & "0111111");
    constant ERRO : std_logic_vector(41 downto 0) :=
        not ("0000000" & "1111001" & "1010000" & "1010000" & "0111111" & "0000000");
begin
    dut: entity work.Criptografia
        port map (
            base_clock => base_clock,
            enter => enter,
            reset => reset,
            modo => modo,
            op => op,
            sw => sw,
            hex5 => hex5,
            hex4 => hex4,
            hex3 => hex3,
            hex2 => hex2,
            hex1 => hex1,
            hex0 => hex0
        );

    base_clock <= not base_clock after 5 ns;

    stimulus: process
        procedure passo is
        begin
            wait until rising_edge(base_clock);
            wait for 1 ns;
        end procedure;

        procedure conferir_estado(constant estado : in natural) is
        begin
            assert std_logic_vector'(hex5 & hex4 & hex3 & hex2 & hex1 & hex0) =
                (APAGADO & APAGADO & APAGADO & APAGADO &
                 DECIMAL(estado / 10) & DECIMAL(estado mod 10))
                report "Display incorreto no estado " & integer'image(estado)
                severity failure;
        end procedure;

        -- A controladora espera Enter ativo em '0' por um ciclo.
        procedure confirmar(constant proximo_estado : in natural) is
        begin
            enter <= '0';
            passo;
            enter <= '1';
            conferir_estado(proximo_estado);
        end procedure;

        procedure operacao(
            constant codigo : in std_logic_vector(1 downto 0);
            constant estado_operacao, estado_selecao : in natural
        ) is
        begin
            op <= codigo;
            confirmar(estado_operacao);
            passo;
            conferir_estado(estado_selecao);
        end procedure;

        procedure finalizar(constant esperado : in std_logic_vector(41 downto 0)) is
        begin
            op <= "00";
            enter <= '0';
            passo;
            enter <= '1';
            assert (hex5 & hex4 & hex3 & hex2 & hex1 & hex0) = esperado
                report "Resultado incorreto no display" severity failure;
            passo;
            assert (hex5 & hex4 & hex3 & hex2 & hex1 & hex0) = esperado
                report "RESULT deve aguardar Enter" severity failure;
        end procedure;
    begin
        -- Reset limpa os registradores; sem cifrado, nao permite decifrar.
        passo;
        conferir_estado(0);
        reset <= '1';
        passo;
        conferir_estado(1);
        modo <= '1';
        confirmar(1);

        -- Cifrar 723 com chave 342: XOR, ROL e permutacao; salvar 31.
        modo <= '0';
        confirmar(2);
        sw <= "1011010011";
        confirmar(3);
        sw <= "0101010110";
        confirmar(4);
        operacao("01", 7, 4);
        operacao("10", 6, 4);
        operacao("11", 5, 4);
        op <= "00";
        confirmar(8);
        passo;
        conferir_estado(1);

        -- Decifrar com chave errada deve mostrar ERRO.
        modo <= '1';
        confirmar(9);
        passo;
        conferir_estado(10);
        operacao("11", 14, 10);
        operacao("10", 13, 10);
        op <= "01";
        confirmar(11);
        passo;
        conferir_estado(11);
        sw <= "0000000000";
        confirmar(12);
        passo;
        conferir_estado(10);
        finalizar(ERRO);

        -- Nova tentativa restaura o cifrado salvo; chave correta da ACERTO.
        confirmar(1);
        confirmar(9);
        passo;
        conferir_estado(10);
        operacao("11", 14, 10);
        operacao("10", 13, 10);
        op <= "01";
        confirmar(11);
        sw <= "0101010110";
        confirmar(12);
        passo;
        conferir_estado(10);
        finalizar(ACERTO);

        -- Reset durante uma tentativa invalida o cifrado anterior.
        confirmar(1);
        confirmar(9);
        passo;
        conferir_estado(10);
        wait for 2 ns;
        reset <= '0';
        wait for 1 ns;
        conferir_estado(0);
        passo;
        reset <= '1';
        passo;
        conferir_estado(1);
        confirmar(1);

        -- Um cifrado igual a zero tambem deve ser considerado salvo.
        modo <= '0';
        confirmar(2);
        sw <= "0000000000";
        confirmar(3);
        confirmar(4);
        op <= "00";
        confirmar(8);
        passo;
        conferir_estado(1);
        modo <= '1';
        confirmar(9);
        passo;
        conferir_estado(10);
        finalizar(ACERTO);

        report "Integracao Criptografia: todos os testes passaram." severity note;
        stop;
        wait;
    end process;
end architecture test;
