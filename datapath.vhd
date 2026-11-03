library ieee;
use ieee.std_logic_1164.all;

entity datapath is
    port (
        clk, reset : in std_logic;
        switches : in std_logic_vector(9 downto 0);
        ld_v, ld_k, ld_x, ld_c, rot_mode : in std_logic;
        clr_n, inc_n, ld_acerto, clr_acerto : in std_logic;
        set_valido, clr_valido, sel_saida : in std_logic;
        sel_x : in std_logic_vector(2 downto 0);
        fim_camadas, cifrado_valido, acerto : out std_logic;
        valor_saida : out std_logic_vector(9 downto 0)
    );
end entity;

architecture rtl of datapath is
    signal V_reg, K_reg, X_reg, C_reg : std_logic_vector(9 downto 0);
    signal prox_x, r_xor, r_rot, r_perm : std_logic_vector(9 downto 0);
    signal n, n_mais_um, prox_n : std_logic_vector(1 downto 0);
    signal carga_n, igual, acerto_reg, valido_reg : std_logic;
begin
    rv : entity work.registrador
        port map (clk => clk, reset => reset, carga => ld_v, D => switches, Q => V_reg);
    rk : entity work.registrador
        port map (clk => clk, reset => reset, carga => ld_k, D => switches, Q => K_reg);
    rx : entity work.registrador
        port map (clk => clk, reset => reset, carga => ld_x, D => prox_x, Q => X_reg);
    -- O cifrado recebe o X ja registrado, nunca a saida combinacional do MUX.
    rc : entity work.registrador
        port map (clk => clk, reset => reset, carga => ld_c, D => X_reg, Q => C_reg);

    ox : entity work.XOR_cripto port map (A => X_reg, B => K_reg, X => r_xor);
    ro : entity work.roller port map (mode => rot_mode, A => X_reg, R => r_rot);
    pe : entity work.permuter port map (A => X_reg, P => r_perm);
    cv : entity work.comparador port map (A => X_reg, B => V_reg, igual => igual);

    ad : entity work.incrementador port map (A => n, R => n_mais_um);
    carga_n <= clr_n or inc_n;
    prox_n <= "00" when clr_n = '1' else n_mais_um;
    rn : entity work.registrador
        generic map (N => 2)
        port map (clk => clk, reset => reset, carga => carga_n, D => prox_n, Q => n);
    cn : entity work.comparador
        generic map (N => 2)
        port map (A => n, B => "11", igual => fim_camadas);

    with sel_x select prox_x <=
        switches when "000",
        r_xor    when "001",
        r_rot    when "010",
        r_perm   when "011",
        C_reg    when "100",
        X_reg    when others;

    valor_saida <= C_reg when sel_saida = '1' else X_reg;
    cifrado_valido <= valido_reg;
    acerto <= acerto_reg;

    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' or clr_valido = '1' then
                valido_reg <= '0';
            elsif set_valido = '1' then
                valido_reg <= '1';
            end if;
            if reset = '1' or clr_acerto = '1' then
                acerto_reg <= '0';
            elsif ld_acerto = '1' then
                acerto_reg <= igual;
            end if;
        end if;
    end process;
end architecture;
