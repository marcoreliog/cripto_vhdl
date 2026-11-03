library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_operadores is end entity;
architecture sim of tb_operadores is
    signal A, B, r_xor, r_rot, r_perm, p_dupla, rol_fixo, volta : std_logic_vector(9 downto 0);
    signal mode, igual : std_logic;
    signal incremento : std_logic_vector(1 downto 0);
    signal segmentos : std_logic_vector(6 downto 0);
    signal terminou : boolean := false;
begin
    ox : entity work.XOR_cripto port map (A => A, B => B, X => r_xor);
    ro : entity work.roller port map (mode => mode, A => A, R => r_rot);
    pe : entity work.permuter port map (A => A, P => r_perm);
    pp : entity work.permuter port map (A => r_perm, P => p_dupla);
    rl : entity work.roller port map (mode => '1', A => A, R => rol_fixo);
    rr : entity work.roller port map (mode => '0', A => rol_fixo, R => volta);
    co : entity work.comparador port map (A => A, B => B, igual => igual);
    inc : entity work.incrementador port map (A => A(1 downto 0), R => incremento);
    hex : entity work.hex7seg port map (digito => A(3 downto 0), segmentos => segmentos);
    process
    begin
        for valor in 0 to 1023 loop
            A <= std_logic_vector(to_unsigned(valor, 10));
            for chave in 0 to 3 loop
                B <= std_logic_vector(to_unsigned(chave * 341, 10));
                mode <= '0'; wait for 10 ns;
                mode <= '1'; wait for 10 ns;
            end loop;
        end loop;
        terminou <= true;
        wait;
    end process;
end architecture;
