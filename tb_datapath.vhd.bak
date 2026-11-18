library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.env.all;

entity tb_datapath is
end tb_datapath;

architecture test of tb_datapath is
    constant ORIGINAL : natural := 723;
    constant CHAVE : natural := 342;
    -- Valores esperados para XOR, ROL por 3 e troca dos pares, nessa ordem.
    constant APOS_XOR : natural := 901;
    constant APOS_ROL : natural := 47;
    constant CIFRADO : natural := 31;

    signal clk, clr, ld_x, ld_k, ld_v, ld_c, rot_dir : std_logic := '0';
    signal sw : std_logic_vector(9 downto 0) := (others => '0');
    signal sel : std_logic_vector(2 downto 0) := "000";
    signal equals, existe_cripto : std_logic;
begin
    clk <= not clk after 5 ns;

    dut : entity work.datapath
        port map (
            clk_sys => clk, clr => clr, sw => sw,
            ld_x => ld_x, ld_k => ld_k, ld_v => ld_v, ld_c => ld_c,
            sel => sel, rot_dir => rot_dir, equals => equals, existe_cripto => existe_cripto
        );

    process
        procedure tick is
        begin
            wait until rising_edge(clk);
            wait for 1 ns;
        end procedure;

        procedure carregar_x(fonte : std_logic_vector(2 downto 0); direcao : std_logic := '0') is
        begin
            sel <= fonte;
            rot_dir <= direcao;
            ld_x <= '1';
            tick;
            ld_x <= '0';
        end procedure;

        -- V serve como referencia para observar X pela saida publica equals.
        procedure verificar_x(valor : natural; etapa : string) is
        begin
            ld_v <= '1';
            sw <= std_logic_vector(to_unsigned((valor + 1) mod 1024, sw'length));
            tick;
            assert equals = '0' report etapa & ": o comparador aceitou outro valor" severity failure;

            sw <= std_logic_vector(to_unsigned(valor, sw'length));
            tick;
            assert equals = '1' report etapa & ": X diferente de " & integer'image(valor) severity failure;
            ld_v <= '0';
        end procedure;
    begin
        clr <= '1';
        tick;
        assert equals = '1' and existe_cripto = '0' report "Limpeza inicial incompleta" severity failure;
        clr <= '0';
        verificar_x(0, "X zerado por clr");

        sw <= std_logic_vector(to_unsigned(ORIGINAL, sw'length));
        ld_v <= '1';
        carregar_x("000");
        ld_v <= '0';
        assert equals = '1' report "V e X nao receberam o valor original" severity failure;

        sw <= std_logic_vector(to_unsigned(CHAVE, sw'length));
        ld_k <= '1';
        tick;
        ld_k <= '0';
        assert equals = '1' report "Carregar K alterou V ou X" severity failure;

        -- Mudar a chave externa ou o seletor so deve afetar X se ld_x estiver ativo.
        sw <= (others => '0');
        sel <= "001";
        tick;
        assert equals = '1' report "X mudou sem ld_x" severity failure;
        carregar_x("001");
        assert equals = '0' report "XOR nao alterou X" severity failure;
        verificar_x(APOS_XOR, "XOR com a chave registrada");

        carregar_x("010", '0');
        verificar_x(APOS_ROL, "Rotacao de tres bits para a esquerda");
        carregar_x("011");
        verificar_x(CIFRADO, "Troca dos pares vizinhos");

        sw <= (others => '1');
        for codigo in 5 to 7 loop
            carregar_x(std_logic_vector(to_unsigned(codigo, sel'length)));
            assert equals = '1' report "Seletor invalido nao preservou X" severity failure;
        end loop;

        ld_c <= '1';
        wait for 1 ns;
        assert existe_cripto = '0' report "C ficou valido antes da borda de clock" severity failure;
        tick;
        ld_c <= '0';
        assert existe_cripto = '1' report "C salvo sem flag de validade" severity failure;

        -- Comparar o cifrado salvo com o valor original.
        sw <= std_logic_vector(to_unsigned(ORIGINAL, sw'length));
        ld_v <= '1';
        tick;
        ld_v <= '0';
        assert equals = '0' report "O cifrado coincidiu com o original" severity failure;

        sw <= std_logic_vector(to_unsigned(17, sw'length));
        carregar_x("000");
        verificar_x(17, "Substituir X sem regravar C");
        carregar_x("100");
        verificar_x(CIFRADO, "Restaurar o cifrado salvo em C");
        assert existe_cripto = '1' report "Restaurar C invalidou o desafio" severity failure;

        -- Conferir o valor de X em cada etapa da inversao.
        carregar_x("011");
        verificar_x(APOS_ROL, "Desfazer permutacao");
        carregar_x("010", '1');
        verificar_x(APOS_XOR, "Desfazer rotacao para a direita");
        carregar_x("001");
        verificar_x(ORIGINAL, "Recuperar o original por XOR");

        -- Nova tentativa com a mesma referencia e a mesma copia em C.
        carregar_x("100");
        assert equals = '0' and existe_cripto = '1' report "Nova tentativa nao restaurou C" severity failure;
        carregar_x("011");
        carregar_x("010", '1');
        carregar_x("001");
        assert equals = '1' report "Decifragem nao recuperou o original" severity failure;

        clr <= '1';
        sw <= (others => '1');
        sel <= "000";
        ld_v <= '1';
        ld_x <= '1';
        ld_k <= '1';
        ld_c <= '1';
        tick;
        assert equals = '1' and existe_cripto = '0' report "Clear nao teve prioridade sobre as cargas" severity failure;
        clr <= '0';
        ld_v <= '0';
        ld_x <= '0';
        ld_k <= '0';
        ld_c <= '0';
        verificar_x(0, "Clear zerou X apesar da carga");
        carregar_x("001");
        assert equals = '1' report "Clear nao zerou K" severity failure;

        ld_c <= '1';
        tick;
        ld_c <= '0';
        assert existe_cripto = '1' report "Cifrado zero deve ser considerado valido" severity failure;

        report "PASS: datapath, cargas, XOR, rotacoes, permutacao, restauracao, comparacao e clear" severity note;
        stop;
        wait;
    end process;
end test;
