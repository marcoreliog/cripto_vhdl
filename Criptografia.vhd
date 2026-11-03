library ieee;
use ieee.std_logic_1164.all;

-- Nucleo independente de placa. confirmar deve durar exatamente um ciclo.
entity temp1 is
    port (
        clk, reset, confirmar, modo_decifrar : in std_logic;
        switches : in std_logic_vector(9 downto 0);
        operacao : in std_logic_vector(1 downto 0);
        valor_saida : out std_logic_vector(9 downto 0);
        led_acerto : out std_logic;
        estado : out std_logic_vector(3 downto 0)
    );
end entity;

architecture rtl of temp1 is
    signal ld_v, ld_k, ld_x, ld_c, rot_mode : std_logic;
    signal clr_n, inc_n, ld_acerto, clr_acerto : std_logic;
    signal set_valido, clr_valido, sel_saida : std_logic;
    signal fim_camadas, cifrado_valido : std_logic;
    signal sel_x : std_logic_vector(2 downto 0);
begin
    uc : entity work.controller
        port map (
            clk => clk, reset => reset, confirmar => confirmar,
            modo_decifrar => modo_decifrar, operacao => operacao,
            fim_camadas => fim_camadas, cifrado_valido => cifrado_valido,
            ld_v => ld_v, ld_k => ld_k, ld_x => ld_x, ld_c => ld_c,
            rot_mode => rot_mode, clr_n => clr_n, inc_n => inc_n,
            ld_acerto => ld_acerto, clr_acerto => clr_acerto,
            set_valido => set_valido, clr_valido => clr_valido,
            sel_saida => sel_saida, sel_x => sel_x, estado => estado
        );

    dp : entity work.datapath
        port map (
            clk => clk, reset => reset, switches => switches,
            ld_v => ld_v, ld_k => ld_k, ld_x => ld_x, ld_c => ld_c,
            rot_mode => rot_mode, clr_n => clr_n, inc_n => inc_n,
            ld_acerto => ld_acerto, clr_acerto => clr_acerto,
            set_valido => set_valido, clr_valido => clr_valido,
            sel_saida => sel_saida, sel_x => sel_x,
            fim_camadas => fim_camadas, cifrado_valido => cifrado_valido,
            acerto => led_acerto, valor_saida => valor_saida
        );
end architecture;
