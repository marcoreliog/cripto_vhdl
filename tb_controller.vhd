library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.env.all;

entity tb_controller is
end tb_controller;

architecture test of tb_controller is
    signal clk, reset, modo, equals, existe_cripto : std_logic := '0';
    signal enter : std_logic := '1';
    signal op : std_logic_vector(1 downto 0) := "00";
    signal ld_x, ld_k, ld_v, ld_c, rot_dir, clr : std_logic;
    signal sel : std_logic_vector(2 downto 0);
    signal display : std_logic_vector(3 downto 0);
begin
    clk <= not clk after 5 ns;

    dut : entity work.controller
        port map (
            clock => clk, reset => reset, enter => enter, modo => modo, op => op,
            equals => equals, existe_cripto => existe_cripto,
            ld_x => ld_x, ld_k => ld_k, ld_v => ld_v, ld_c => ld_c,
            sel => sel, rot_dir => rot_dir, clr => clr, display => display
        );

    process
        procedure tick is
        begin
            wait until rising_edge(clk);
            wait for 1 ns;
        end procedure;

        procedure verificar(
            estado : natural; etapa : string;
            cargas : std_logic_vector(3 downto 0) := "0000";
            selecao : std_logic_vector(2 downto 0) := "000";
            direcao : std_logic := '0'; limpar : std_logic := '0'
        ) is
        begin
            assert display = std_logic_vector(to_unsigned(estado, display'length))
                report etapa & ": esperado estado " & integer'image(estado) &
                       ", display=" & to_hstring(display) severity failure;
            assert (ld_v & ld_k & ld_x & ld_c) = cargas
                report etapa & ": sinais de carga incorretos" severity failure;
            assert sel = selecao and rot_dir = direcao and clr = limpar
                report etapa & ": selecao, direcao ou limpeza incorreta" severity failure;
        end procedure;

        procedure confirmar(
            estado : natural; etapa : string;
            cargas : std_logic_vector(3 downto 0) := "0000";
            limpar : std_logic := '0'
        ) is
        begin
            enter <= '0'; -- Enter ativo em zero.
            wait for 1 ns;
            verificar(estado, etapa, cargas => cargas, limpar => limpar);
            tick;
            enter <= '1';
            wait for 1 ns;
        end procedure;
    begin
        tick;
        verificar(0, "Reset mantido", limpar => '1');
        reset <= '1';
        tick;
        verificar(1, "Saida de INIT");

        modo <= '1';
        confirmar(1, "Decifrar sem desafio");
        verificar(1, "Menu sem cifrado valido");

        modo <= '0';
        confirmar(1, "Iniciar cifragem", limpar => '1');
        verificar(2, "Espera do valor original");
        tick;
        verificar(2, "INSERT_V sem Enter");
        confirmar(2, "Carregar V e X", cargas => "1010");
        verificar(3, "Espera da chave");
        confirmar(3, "Carregar K", cargas => "0100");
        verificar(4, "Selecao de cifragem");

        op <= "01";
        tick;
        verificar(4, "Operacao mudou sem Enter");
        for repeticao in 1 to 4 loop
            confirmar(4, "Selecionar XOR na cifragem");
            verificar(7, "XOR_C", cargas => "0010", selecao => "001");
            tick;
            verificar(4, "Retorno depois de XOR_C");
        end loop;

        op <= "10";
        confirmar(4, "Selecionar rotacao esquerda");
        verificar(6, "ROL_C", cargas => "0010", selecao => "010", direcao => '0');
        tick;
        verificar(4, "Retorno depois de ROL_C");

        op <= "11";
        confirmar(4, "Selecionar permutacao na cifragem");
        verificar(5, "PERM_C", cargas => "0010", selecao => "011");
        tick;
        verificar(4, "Retorno depois de PERM_C");

        op <= "00";
        confirmar(4, "Finalizar cifragem");
        verificar(8, "SAVE_C", cargas => "0001");
        tick;
        verificar(1, "Retorno ao menu depois de salvar");

        existe_cripto <= '1';
        modo <= '1';
        confirmar(1, "Iniciar tentativa com cifrado valido");
        verificar(9, "ATTEMPT_D", cargas => "0010", selecao => "100");
        tick;
        verificar(10, "Selecao de decifragem");

        op <= "11";
        confirmar(10, "Selecionar permutacao na decifragem");
        verificar(14, "PERM_D", cargas => "0010", selecao => "011");
        tick;
        verificar(10, "Retorno depois de PERM_D");

        op <= "10";
        confirmar(10, "Selecionar rotacao direita");
        verificar(13, "ROR_D", cargas => "0010", selecao => "010", direcao => '1');
        tick;
        verificar(10, "Retorno depois de ROR_D");

        op <= "01";
        for repeticao in 1 to 2 loop
            confirmar(10, "Selecionar XOR na decifragem");
            verificar(11, "TRY_K");
            tick;
            verificar(11, "TRY_K deve aguardar outro Enter");
            confirmar(11, "Carregar palpite", cargas => "0100");
            verificar(12, "XOR_D", cargas => "0010", selecao => "001");
            tick;
            verificar(10, "Retorno depois de XOR_D");
        end loop;

        op <= "00";
        equals <= '1';
        confirmar(10, "Finalizar decifragem");
        verificar(15, "RESULT com acerto");
        equals <= '0';
        tick;
        verificar(15, "RESULT deve aguardar Enter mesmo com erro");
        confirmar(15, "Confirmar resultado");
        verificar(1, "Retorno ao menu depois do resultado");

        confirmar(1, "Repetir tentativa sem salvar outro cifrado");
        verificar(9, "Restaurar C na nova tentativa", cargas => "0010", selecao => "100");

        reset <= '0';
        wait for 1 ns;
        verificar(0, "Reset assincrono durante tentativa", limpar => '1');
        reset <= '1';
        tick;
        verificar(1, "Menu depois de reiniciar");

        report "PASS: controlador, 16 estados, cargas, operacoes, resultado e reset" severity note;
        stop;
        wait;
    end process;
end test;
