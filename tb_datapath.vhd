library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.env.all;

entity tb_datapath is
end tb_datapath;

architecture test of tb_datapath is
    subtype word is std_logic_vector(9 downto 0);
    signal clock, clear : std_logic := '0';
    signal ld_v, ld_k, ld_x, ld_c, rot_dir : std_logic := '0';
    signal switches : word := (others => '0');
    signal sel : std_logic_vector(2 downto 0) := "000";
    signal valor_saida, cifrado : word;
    signal igual : std_logic;

    signal a, b : word := (others => '0');
    signal eq : std_logic;
    signal reg_i : std_logic_vector(3 downto 0) := "0000";
    signal reg_q : std_logic_vector(3 downto 0);
    signal reg_ld, reg_clr : std_logic := '0';
begin
    dut: entity work.datapath
        port map (
            clock => clock, clear => clear, switches => switches,
            ld_v => ld_v, ld_k => ld_k, ld_x => ld_x, ld_c => ld_c,
            rot_dir => rot_dir, sel => sel, igual => igual,
            valor_saida => valor_saida, cifrado => cifrado
        );

    compara: entity work.comparador
        port map (a => a, b => b, igual => eq);

    registro: entity work.registrador
        generic map (W => 4)
        port map (i => reg_i, ld => reg_ld, clk => clock, clr => reg_clr, q => reg_q);

    stimulus: process
        type keys_t is array (0 to 3) of natural;
        constant keys : keys_t := (0, 1, 341, 1023);
        variable original, expected, saved, previous : word;

        function bits(value : natural) return word is
        begin
            return std_logic_vector(to_unsigned(value, 10));
        end function;

        function permute(value : word) return word is
            variable result : word;
        begin
            for pair in 0 to 4 loop
                result(2 * pair) := value(2 * pair + 1);
                result(2 * pair + 1) := value(2 * pair);
            end loop;
            return result;
        end function;

        procedure tick is
        begin
            clock <= '0'; wait for 5 ns;
            clock <= '1'; wait for 1 ns;
            clock <= '0'; wait for 4 ns;
        end procedure;

        procedure idle_loads is
        begin
            ld_v <= '0'; ld_k <= '0'; ld_x <= '0'; ld_c <= '0';
        end procedure;

        procedure apply_mux(code : std_logic_vector(2 downto 0);
                            want : word; direction : std_logic := '0') is
        begin
            idle_loads; ld_x <= '1'; sel <= code; rot_dir <= direction;
            tick;
            assert valor_saida = want report "MUX, operacao ou realimentacao incorreta" severity failure;
            if want = original then
                assert igual = '1' report "Comparador desconectado de X ou V" severity failure;
            else
                assert igual = '0' report "Comparador nao distingue X de V" severity failure;
            end if;
        end procedure;
    begin
        reg_clr <= '1'; clear <= '1'; tick;
        assert reg_q = "0000" and valor_saida = bits(0) and cifrado = bits(0) and igual = '1'
            report "Clear inicial incorreto" severity failure;
        reg_clr <= '0'; clear <= '0';

        reg_i <= "1010"; reg_ld <= '1'; wait for 1 ns;
        assert reg_q = "0000" report "Carga fora da borda" severity failure;
        tick; assert reg_q = "1010" severity failure;
        reg_ld <= '0'; reg_i <= "0101"; tick;
        assert reg_q = "1010" report "Registrador perdeu valor com ld = 0" severity failure;
        reg_clr <= '1'; reg_ld <= '1'; reg_i <= "1111"; wait for 1 ns;
        assert reg_q = "1010" report "Clear deve ser sincrono" severity failure;
        tick; assert reg_q = "0000" report "Clear perdeu prioridade sobre ld" severity failure;
        reg_clr <= '0'; reg_ld <= '0';

        for value in 0 to 1023 loop
            a <= bits(value); b <= bits(value); wait for 1 ns;
            assert eq = '1' severity failure;
            for bit_index in 0 to 9 loop
                b <= bits(value) xor bits(2 ** bit_index); wait for 1 ns;
                assert eq = '0' report "Comparador ignorou um bit" severity failure;
                b <= bits(value); wait for 1 ns;
                assert eq = '1' severity failure;
            end loop;
        end loop;
        a <= (others => 'X'); b <= (others => 'X'); wait for 1 ns;
        assert eq = '0' report "Valores indefinidos nao podem sinalizar acerto" severity failure;
        a <= bits(0); b <= bits(0); wait for 1 ns;
        assert eq = '1' severity failure;

        for value in 0 to 1023 loop
            for key_index in keys'range loop
                original := bits(value);
                idle_loads; sel <= "000"; switches <= original;
                ld_v <= '1'; ld_x <= '1'; tick;
                assert valor_saida = original and igual = '1' severity failure;

                idle_loads; switches <= bits(keys(key_index)); ld_k <= '1'; tick;
                idle_loads; switches <= not original; tick;
                assert valor_saida = original report "Switches alteraram X sem carga" severity failure;

                expected := permute(original);
                apply_mux("011", expected);
                expected := std_logic_vector(rotate_left(unsigned(expected), 3));
                apply_mux("010", expected, '1');
                expected := expected xor bits(keys(key_index));
                apply_mux("001", expected);

                saved := expected; idle_loads; ld_c <= '1'; tick;
                assert cifrado = saved report "C nao recebeu o X registrado" severity failure;

                expected := expected xor bits(keys(key_index));
                apply_mux("001", expected);
                expected := std_logic_vector(rotate_right(unsigned(expected), 3));
                apply_mux("010", expected);
                expected := permute(expected);
                apply_mux("011", expected);
                assert expected = original and cifrado = saved
                    report "Inversas nao recuperaram V ou alteraram C" severity failure;

                apply_mux("100", saved);
                for unused in 5 to 7 loop
                    apply_mux(std_logic_vector(to_unsigned(unused, 3)), saved);
                end loop;
                apply_mux("0X1", saved);
                assert cifrado = saved severity failure;

                previous := valor_saida;
                idle_loads; sel <= "000"; switches <= not previous;
                ld_x <= '1'; ld_c <= '1'; tick;
                assert valor_saida = not previous and cifrado = previous
                    report "C recebeu o MUX em vez do X registrado" severity failure;

                previous := valor_saida;
                clear <= '1'; ld_v <= '1'; ld_k <= '1'; switches <= bits(1023);
                wait for 1 ns;
                assert valor_saida = previous report "Clear do datapath nao e sincrono" severity failure;
                tick;
                assert valor_saida = bits(0) and cifrado = bits(0) and igual = '1'
                    report "Clear nao limpou X, C ou V" severity failure;
                clear <= '0'; idle_loads; ld_x <= '1'; sel <= "001"; tick;
                assert valor_saida = bits(0) report "Clear nao limpou K" severity failure;
            end loop;
        end loop;

        report "OK: registrador generico, comparador de 10 bits e 4096 cenarios do datapath";
        stop;
        wait;
    end process;

    watchdog: process
    begin
        wait for 4 ms;
        assert false report "A bancada nao terminou" severity failure;
        wait;
    end process;
end test;
