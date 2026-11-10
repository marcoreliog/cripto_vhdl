library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.env.all;

entity tb_controller is
end entity;

architecture test of tb_controller is
    subtype word is std_logic_vector(9 downto 0);
    signal clock, reset, enter, modo, tentar : std_logic := '0';
    signal op : std_logic_vector(1 downto 0) := "00";
    signal switches, v, k, x, c : word := (others => '0');
    signal prox_x, r_xor, r_rot, r_perm : word;
    signal ld_x, ld_k, ld_v, ld_c, rot_dir, valido, acerto, clear : std_logic;
    signal igual, igual_real : std_logic;
    signal x_real, c_real : word;
    signal igual_forcado : std_logic := 'X';
    signal sel : std_logic_vector(2 downto 0);
    signal estado : std_logic_vector(4 downto 0);
begin
    dut : entity work.controller
        port map (
            enter => enter, clock => clock, reset => reset, op => op,
            ld_x => ld_x, ld_k => ld_k, ld_v => ld_v, ld_c => ld_c,
            sel => sel, rot_dir => rot_dir, existe_cripto => valido,
            acerto => acerto, clear => clear, estado => estado,
            modo_decifrar => modo, igual => igual, tentar_novamente => tentar
        );

    dp : entity work.datapath
        port map (
            clock => clock, clear => clear, switches => switches,
            ld_v => ld_v, ld_k => ld_k, ld_x => ld_x, ld_c => ld_c,
            rot_dir => rot_dir, sel => sel, igual => igual_real,
            valor_saida => x_real, cifrado => c_real
        );

    ox : entity work.XOR_cripto port map (A => x, B => k, X => r_xor);
    ro : entity work.roller port map (mode => rot_dir, A => x, R => r_rot);
    pe : entity work.permuter port map (A => x, P => r_perm);
    igual <= igual_forcado when igual_forcado /= 'X' else igual_real;
    with sel select prox_x <=
        switches when "000", r_xor when "001", r_rot when "010",
        r_perm when "011", c when "100", x when others;

    modelo_datapath : process (clock)
    begin
        if rising_edge(clock) then
            if clear = '1' then
                v <= (others => '0');
                k <= (others => '0');
                x <= (others => '0');
                c <= (others => '0');
            else
                if ld_v = '1' then v <= switches; end if;
                if ld_k = '1' then k <= switches; end if;
                if ld_x = '1' then x <= prox_x; end if;
                if ld_c = '1' then c <= x; end if;
            end if;
        end if;
    end process;

    stimulus : process
        type coverage_t is array (0 to 16) of boolean;
        type sequence_t is array (0 to 3) of natural range 1 to 3;
        variable visited : coverage_t := (others => false);
        variable sequencia : sequence_t;
        variable encoded, steps : natural;
        variable old_k, saved_v, saved_c, expected : word;

        function bits(value : natural) return word is
        begin
            return std_logic_vector(to_unsigned(value, 10));
        end function;

        function reference(value, key : word; code : natural; inverse : boolean) return word is
            variable result : word;
        begin
            case code is
                when 1 => result := value xor key;
                when 2 =>
                    if inverse then result := std_logic_vector(rotate_right(unsigned(value), 3));
                    else result := std_logic_vector(rotate_left(unsigned(value), 3)); end if;
                when others =>
                    for pair in 0 to 4 loop
                        result(2 * pair) := value(2 * pair + 1);
                        result(2 * pair + 1) := value(2 * pair);
                    end loop;
            end case;
            return result;
        end function;

        procedure tick is
        begin
            clock <= '0'; wait for 5 ns;
            clock <= '1'; wait for 1 ns;
            assert x_real = x and c_real = c
                report "Datapath real divergiu do modelo de referencia" severity failure;
            if x = v then
                assert igual_real = '1' report "Comparador nao reconheceu X = V" severity failure;
            else
                assert igual_real = '0' report "Comparador aceitou X diferente de V" severity failure;
            end if;
            visited(to_integer(unsigned(estado))) := true;
            clock <= '0'; wait for 4 ns;
        end procedure;

        procedure expect_state(value : natural) is
        begin
            assert to_integer(unsigned(estado)) = value
                report "Esperado S" & integer'image(value) & ", recebido S" &
                       integer'image(to_integer(unsigned(estado))) severity failure;
        end procedure;

        procedure press is
        begin
            enter <= '0'; tick;
            enter <= '1'; tick;
            enter <= '0'; wait for 1 ns;
        end procedure;

        procedure reset_to_menu is
        begin
            enter <= '0'; tentar <= '0'; reset <= '1'; igual_forcado <= 'X';
            tick; expect_state(0);
            assert v = bits(0) and k = bits(0) and x = bits(0) and c = bits(0)
                and valido = '0' and acerto = '0' severity failure;
            reset <= '0'; tick; expect_state(1);
        end procedure;

        procedure create_challenge(value, key : natural) is
        begin
            expect_state(1); modo <= '0'; press; expect_state(2);
            assert valido = '0' and acerto = '0' severity failure;
            switches <= bits(value); press; expect_state(3);
            assert v = bits(value) and x = bits(value) severity failure;
            switches <= bits(key); press; expect_state(4);
            assert k = bits(key) severity failure;
        end procedure;

        procedure operation(code : natural; inverse : boolean; guess : natural := 3) is
            variable expected_value, before_k, before_v, before_c : word;
            variable selection : natural;
        begin
            if inverse then selection := 10; else selection := 4; end if;
            expect_state(selection);
            before_k := k; before_v := v; before_c := c;
            if inverse and code = 1 then
                expected_value := reference(x, bits(guess), code, inverse);
            else
                expected_value := reference(x, k, code, inverse);
            end if;
            op <= std_logic_vector(to_unsigned(code, 2)); press;
            if inverse and code = 1 then
                expect_state(11);
                assert k = before_k and ld_k = '0' and ld_x = '0'
                    report "Selecionar XOR nao pode confirmar o palpite" severity failure;
                switches <= bits((guess + 17) mod 1024); tick; tick;
                expect_state(11);
                assert k = before_k severity failure;
                switches <= bits(guess); press; expect_state(12);
                assert k = bits(guess) severity failure;
            elsif code = 1 then expect_state(7);
            elsif code = 2 and inverse then expect_state(13);
            elsif code = 2 then expect_state(6);
            elsif inverse then expect_state(14);
            else expect_state(5);
            end if;
            assert ld_x = '1' severity failure;
            tick; expect_state(selection);
            assert x = expected_value report "Resultado incorreto da operacao" severity failure;
            assert v = before_v and c = before_c
                report "Operacao alterou o original ou o cifrado salvo" severity failure;
            tick; expect_state(selection);
        end procedure;

        procedure save_challenge is
            variable value : word;
        begin
            expect_state(4); value := x; op <= "00"; press; expect_state(8);
            assert ld_c = '1' and valido = '0' severity failure;
            tick; expect_state(1);
            assert c = value and valido = '1' severity failure;
        end procedure;

        procedure start_attempt is
        begin
            expect_state(1); modo <= '1'; press; expect_state(9);
            assert sel = "100" and ld_x = '1' severity failure;
            tick; expect_state(10);
            assert x = c and acerto = '0' severity failure;
        end procedure;

        procedure finish_attempt(result : std_logic) is
            variable previous_result : std_logic;
        begin
            expect_state(10); previous_result := acerto;
            op <= "00"; press; expect_state(15);
            assert acerto = previous_result
                report "Acerto mudou antes da borda de S15" severity failure;
            tick; expect_state(16);
            assert acerto = result and valido = '1' severity failure;
            tick; tick; expect_state(16);
        end procedure;

        procedure retry_attempt is
        begin
            expect_state(16); tentar <= '0'; tick;
            tentar <= '1'; tick; expect_state(9);
            tentar <= '0'; tick; expect_state(10);
            assert x = c and acerto = '0' and valido = '1' severity failure;
        end procedure;
    begin
        reset_to_menu;
        modo <= '1'; press; expect_state(1);
        assert valido = '0' report "Nao pode decifrar sem desafio" severity failure;

        modo <= '0'; enter <= '0'; tick; enter <= '1'; tick; expect_state(2);
        switches <= bits(511);
        for count in 1 to 5 loop tick; expect_state(2); end loop;
        assert v = bits(0) and x = bits(0) severity failure;
        enter <= '0'; tick; press; expect_state(3);
        assert v = bits(511) and x = bits(511) severity failure;
        switches <= bits(3); press; expect_state(4);
        switches <= bits(1023); op <= "11"; tick; tick;
        expect_state(4); assert k = bits(3) and x = bits(511) severity failure;

        for count in 1 to 4 loop operation(1, false); end loop;
        assert x = v severity failure;
        save_challenge; saved_c := c; saved_v := v;
        start_attempt;

        op <= "01"; enter <= '0'; tick; old_k := k;
        enter <= '1'; tick; expect_state(11); switches <= bits(5);
        for count in 1 to 5 loop tick; expect_state(11); end loop;
        assert k = old_k and x = c severity failure;
        enter <= '0'; tick; press; expect_state(12); tick; expect_state(10);
        operation(1, true, 5);
        finish_attempt('1');
        assert c = saved_c and v = saved_v severity failure;

        igual_forcado <= '0'; op <= "00"; press; expect_state(16);
        op <= "11"; press; expect_state(16);
        assert acerto = '1' severity failure;
        igual_forcado <= 'X'; retry_attempt;
        operation(1, true, 1); finish_attempt('0');
        igual_forcado <= '1'; tick;
        assert acerto = '0' severity failure;
        igual_forcado <= 'X'; retry_attempt;
        finish_attempt('1');

        reset_to_menu; create_challenge(341, 777);
        save_challenge; assert c = bits(341) severity failure;
        start_attempt; finish_attempt('1');

        reset_to_menu; create_challenge(1, 3); op <= "01";
        enter <= '0'; tick; enter <= '1'; tick; expect_state(7);
        tick; expect_state(4); assert x = bits(2) severity failure;
        for count in 1 to 5 loop tick; expect_state(4); end loop;
        assert x = bits(2) severity failure;
        enter <= '0'; tick;

        for sample in 0 to 5 loop
            for code_sequence in 0 to 80 loop
                reset_to_menu;
                create_challenge((sample * 137) mod 1024, (sample * 173 + 3) mod 1024);
                encoded := code_sequence; expected := v;
                for index in 0 to 3 loop
                    sequencia(index) := encoded mod 3 + 1; encoded := encoded / 3;
                    expected := reference(expected, k, sequencia(index), false);
                    operation(sequencia(index), false);
                end loop;
                save_challenge;
                assert c = expected severity failure;
                start_attempt;
                for index in 3 downto 0 loop
                    operation(sequencia(index), true, (sample * 173 + 3) mod 1024);
                end loop;
                finish_attempt('1');
            end loop;
        end loop;

        for target in 0 to 16 loop
            enter <= '0'; tentar <= '0'; reset <= '1'; tick; reset <= '0';
            steps := 0;
            while to_integer(unsigned(estado)) /= target loop
                steps := steps + 1;
                assert steps < 20 report "Estado inacessivel no teste de reset" severity failure;
                case to_integer(unsigned(estado)) is
                    when 0 => tick;
                    when 1 => modo <= valido; press;
                    when 2 => switches <= bits(1); press;
                    when 3 => switches <= bits(3); press;
                    when 4 =>
                        if target = 5 then op <= "11";
                        elsif target = 6 then op <= "10";
                        elsif target = 7 then op <= "01";
                        else op <= "00"; end if;
                        press;
                    when 10 =>
                        if target = 11 or target = 12 then op <= "01";
                        elsif target = 13 then op <= "10";
                        elsif target = 14 then op <= "11";
                        else op <= "00"; end if;
                        press;
                    when 11 => switches <= bits(3); press;
                    when others => tick;
                end case;
            end loop;

            reset <= '1'; enter <= '1'; tentar <= '1'; tick; expect_state(0);
            assert v = bits(0) and k = bits(0) and x = bits(0) and c = bits(0)
                and valido = '0' and acerto = '0' severity failure;
            reset <= '0'; tick; expect_state(1);
            tick; expect_state(1);
        end loop;

        for index in visited'range loop
            assert visited(index) report "Estado sem cobertura" severity failure;
        end loop;
        report "OK: controller + datapath reais, 486 sequencias, operacoes livres, palpites, resultado, repeticao, botao e reset S0-S16";
        stop;
        wait;
    end process;

    watchdog : process
    begin
        wait for 4 ms;
        assert false report "A bancada nao terminou" severity failure;
        wait;
    end process;
end architecture;
