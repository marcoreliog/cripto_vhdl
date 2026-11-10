library ieee;
use ieee.std_logic_1164.all;

entity datapath is
    port (
        clock, clear : in std_logic;
        ld_v, ld_k, ld_x, ld_c, rot_dir : in std_logic;
        switches : in std_logic_vector(9 downto 0);
        sel : in std_logic_vector(2 downto 0);
        igual : out std_logic;
        valor_saida, cifrado : out std_logic_vector(9 downto 0)
    );
end datapath;

architecture arch_datapath of datapath is
    signal v_q, k_q, x_q, c_q : std_logic_vector(9 downto 0);
    signal xor_s, rot_s, perm_s, x_d : std_logic_vector(9 downto 0);
begin
    valor_original: entity work.registrador
        port map (
            i => switches,
            ld => ld_v,
            clk => clock,
            clr => clear,
            q => v_q
        );

    chave: entity work.registrador
        port map (
            i => switches,
            ld => ld_k,
            clk => clock,
            clr => clear,
            q => k_q
        );

    valor_trabalho: entity work.registrador
        port map (
            i => x_d,
            ld => ld_x,
            clk => clock,
            clr => clear,
            q => x_q
        );

    valor_cifrado: entity work.registrador
        port map (

            i => x_q,
            ld => ld_c,
            clk => clock,
            clr => clear,
            q => c_q
        );

    operador_xor: entity work.XOR_cripto
        port map (
            A => x_q,
            B => k_q,
            X => xor_s
        );

    rotacao: entity work.roller
        port map (
            mode => rot_dir,
            A => x_q,
            R => rot_s
        );

    permutacao: entity work.permuter
        port map (
            A => x_q,
            P => perm_s
        );

    compara_original: entity work.comparador
        port map (
            a => x_q,
            b => v_q,
            igual => igual
        );

    with sel select
        x_d <= switches when "000",
               xor_s    when "001",
               rot_s    when "010",
               perm_s   when "011",
               c_q      when "100",
               x_q      when others;

    valor_saida <= x_q;
    cifrado <= c_q;
end arch_datapath;
