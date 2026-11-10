library ieee;
use ieee.std_logic_1164.all;

entity Criptografia is
    generic (
        DIVISOR_TICK : positive := 50000;
        AMOSTRAS_ESTAVEIS : positive := 4
    );
    port (
        clk, reset : in std_logic;
        botao_confirmar : in std_logic;
        switches : in std_logic_vector(9 downto 0);
        HEX3, HEX2, HEX1, HEX0 : out std_logic_vector(6 downto 0);
        led_acerto, existe_cripto : out std_logic;
        valor_saida : out std_logic_vector(9 downto 0);
        estado : out std_logic_vector(4 downto 0);
        botao_repetir : in std_logic := '0'
    );
end Criptografia;

architecture arch_criptografia of Criptografia is
    signal tick, confirmar, repetir : std_logic;
    signal ld_v, ld_k, ld_x, ld_c, rot_dir, clear : std_logic;
    signal igual, valido, acerto, resultado : std_logic;
    signal sel : std_logic_vector(2 downto 0);
    signal estado_s : std_logic_vector(4 downto 0);
    signal valor_atual, cifrado, valor : std_logic_vector(9 downto 0);
    signal digito2 : std_logic_vector(3 downto 0);
begin
    amostragem: entity work.clock_div
        generic map (
            DIVISOR => DIVISOR_TICK
        )
        port map (
            clk => clk,
            reset => reset,
            tick => tick
        );

    confirmar_filtrado: entity work.botao
        generic map (
            AMOSTRAS_ESTAVEIS => AMOSTRAS_ESTAVEIS
        )
        port map (
            clk => clk,
            reset => reset,
            tick => tick,
            entrada => botao_confirmar,
            nivel => open,
            pulso => confirmar
        );

    repetir_filtrado: entity work.botao
        generic map (
            AMOSTRAS_ESTAVEIS => AMOSTRAS_ESTAVEIS
        )
        port map (
            clk => clk,
            reset => reset,
            tick => tick,
            entrada => botao_repetir,
            nivel => open,
            pulso => repetir
        );

    controladora: entity work.controller
        port map (
            enter => confirmar,
            clock => clk,
            reset => reset,
            op => switches(1 downto 0),
            ld_x => ld_x,
            ld_k => ld_k,
            ld_v => ld_v,
            ld_c => ld_c,
            sel => sel,
            rot_dir => rot_dir,
            existe_cripto => valido,
            acerto => acerto,
            clear => clear,
            estado => estado_s,
            modo_decifrar => switches(0),
            igual => igual,
            tentar_novamente => repetir
        );

    dados: entity work.datapath
        port map (
            clock => clk,
            clear => clear,
            ld_v => ld_v,
            ld_k => ld_k,
            ld_x => ld_x,
            ld_c => ld_c,
            rot_dir => rot_dir,
            switches => switches,
            sel => sel,
            igual => igual,
            valor_saida => valor_atual,
            cifrado => cifrado
        );

    valor <= cifrado when estado_s = "00001" and valido = '1' else valor_atual;
    digito2 <= "00" & valor(9 downto 8);
    resultado <= '1' when estado_s = "10000" else '0';

    display_valor0: entity work.hex7seg
        port map (
            digito => valor(3 downto 0),
            segmentos => HEX0
        );

    display_valor1: entity work.hex7seg
        port map (
            digito => valor(7 downto 4),
            segmentos => HEX1
        );

    display_valor2: entity work.hex7seg
        port map (
            digito => digito2,
            segmentos => HEX2
        );

    display_estado: entity work.hex7seg
        port map (
            digito => estado_s(3 downto 0),
            segmentos => HEX3,
            resultado => resultado,
            acerto => acerto
        );

    valor_saida <= valor;
    estado <= estado_s;
    led_acerto <= acerto;
    existe_cripto <= valido;
end arch_criptografia;
