library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_interface is end entity;
architecture sim of tb_interface is
    signal clk, reset, botao_confirmar, led_acerto : std_logic := '0';
    signal switches, valor_saida : std_logic_vector(9 downto 0) := (others => '0');
    signal HEX2, HEX1, HEX0 : std_logic_vector(6 downto 0);
    signal estado : std_logic_vector(3 downto 0);
    signal etapa : natural := 0;
    signal terminou : boolean := false;
begin
    dut : entity work.interface_logica
        generic map (DIVISOR_TICK => 2, AMOSTRAS_ESTAVEIS => 3)
        port map (
            clk => clk, reset => reset, botao_confirmar => botao_confirmar,
            switches => switches, HEX2 => HEX2, HEX1 => HEX1, HEX0 => HEX0,
            led_acerto => led_acerto, valor_saida => valor_saida, estado => estado
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
        reset <= '1'; wait for 20 ns;
        reset <= '0'; wait for 20 ns;
        -- Oscilacoes assincronas mais curtas que a janela do filtro.
        botao_confirmar <= '1'; wait for 7 ns;
        botao_confirmar <= '0'; wait for 13 ns;
        botao_confirmar <= '1'; wait for 9 ns;
        botao_confirmar <= '0'; wait for 91 ns;
        etapa <= 1; wait for 10 ns; -- ainda INIT; nenhum pulso

        botao_confirmar <= '1'; wait for 240 ns;
        etapa <= 2; wait for 10 ns; -- INSERIR_VALOR; um unico aperto
        wait for 120 ns;
        etapa <= 3; wait for 10 ns; -- segurar nao confirma o valor
        -- Bounce na liberacao tambem nao pode gerar um novo pulso.
        botao_confirmar <= '0'; wait for 7 ns;
        botao_confirmar <= '1'; wait for 13 ns;
        botao_confirmar <= '0'; wait for 100 ns;
        etapa <= 4; wait for 10 ns;

        switches <= std_logic_vector(to_unsigned(1, 10));
        botao_confirmar <= '1'; wait for 180 ns;
        etapa <= 5; wait for 10 ns; -- V = X = 001
        botao_confirmar <= '0'; wait for 120 ns;
        switches <= std_logic_vector(to_unsigned(3, 10));
        botao_confirmar <= '1'; wait for 180 ns;
        etapa <= 6; wait for 10 ns; -- K = 003
        botao_confirmar <= '0'; wait for 120 ns;

        switches <= "0000000000"; -- SW1:0 = 00: permutacao
        botao_confirmar <= '1'; wait for 180 ns;
        etapa <= 7; wait for 10 ns; -- X = 002
        botao_confirmar <= '0'; wait for 120 ns;
        switches <= "0000000001"; -- SW1:0 = 01: ROL3
        botao_confirmar <= '1'; wait for 180 ns;
        etapa <= 8; wait for 10 ns; -- X = 010
        botao_confirmar <= '0'; wait for 120 ns;
        switches <= "0000000010"; -- SW1:0 = 10: XOR
        botao_confirmar <= '1'; wait for 180 ns;
        etapa <= 9; wait for 10 ns; -- INIT, C = 013
        wait for 120 ns;
        etapa <= 10; wait for 10 ns; -- continua INIT, mesmo com botao preso

        reset <= '1'; botao_confirmar <= '0'; wait for 20 ns;
        etapa <= 11; wait for 10 ns;
        reset <= '0'; switches <= "0000000000"; wait for 100 ns;
        botao_confirmar <= '1'; wait for 180 ns;
        botao_confirmar <= '0'; wait for 120 ns;
        switches <= std_logic_vector(to_unsigned(16#3A5#, 10));
        botao_confirmar <= '1'; wait for 180 ns;
        etapa <= 12; wait for 10 ns; -- tres digitos: 3 A 5
        terminou <= true;
        wait for 10 ns;
        wait;
    end process;
end architecture;
