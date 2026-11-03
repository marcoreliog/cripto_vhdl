library ieee;
use ieee.std_logic_1164.all;

-- Integracao logica, sem atribuir modelo, frequencia ou pinos de placa.
entity interface_logica is
    generic (
        DIVISOR_TICK : positive;
        AMOSTRAS_ESTAVEIS : positive
    );
    port (
        clk, reset : in std_logic; -- reset sincrono, ativo em 1, ja condicionado
        botao_confirmar : in std_logic; -- assincrono, 1 = apertado
        switches : in std_logic_vector(9 downto 0);
        HEX2, HEX1, HEX0 : out std_logic_vector(6 downto 0);
        led_acerto : out std_logic;
        valor_saida : out std_logic_vector(9 downto 0);
        estado : out std_logic_vector(3 downto 0)
    );
end entity;

architecture rtl of interface_logica is
    signal tick, confirmar : std_logic;
    signal valor : std_logic_vector(9 downto 0);
    signal digito2 : std_logic_vector(3 downto 0);
begin
    amostragem : entity work.clock_div
        generic map (DIVISOR => DIVISOR_TICK)
        port map (clk => clk, reset => reset, tick => tick);
    filtro : entity work.botao
        generic map (AMOSTRAS_ESTAVEIS => AMOSTRAS_ESTAVEIS)
        port map (
            clk => clk, reset => reset, tick => tick,
            entrada => botao_confirmar, nivel => open, pulso => confirmar
        );
    nucleo : entity work.temp1
        port map (
            clk => clk, reset => reset, confirmar => confirmar,
            modo_decifrar => switches(0), switches => switches,
            operacao => switches(1 downto 0),
            valor_saida => valor, led_acerto => led_acerto, estado => estado
        );

    valor_saida <= valor;
    digito2 <= "00" & valor(9 downto 8);
    display2 : entity work.hex7seg port map (digito => digito2, segmentos => HEX2);
    display1 : entity work.hex7seg port map (digito => valor(7 downto 4), segmentos => HEX1);
    display0 : entity work.hex7seg port map (digito => valor(3 downto 0), segmentos => HEX0);
end architecture;
