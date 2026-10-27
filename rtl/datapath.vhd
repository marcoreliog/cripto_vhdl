library ieee;
use ieee.std_logic_1164.all;
use work.cifrador_pkg.all;

entity datapath is
    port (
        clk, reset : in std_logic;
        switches : in palavra10;
        ld_k, ld_x, ld_c : in std_logic;
        sel_op : in codigo_op;
        sel_saida : in std_logic;
        valor_saida, chave_debug, trabalho_debug, cifrado_debug : out palavra10
    );
end entity;

architecture estrutural of datapath is
    signal k_reg, x_reg, c_reg : palavra10;
    signal valor_xor, valor_rol, valor_p, valor_ror, proximo_valor : palavra10;
begin
    u_xor : entity work.xor10 port map (x_reg, k_reg, valor_xor);
    u_rol : entity work.rotacao_esquerda3 port map (x_reg, valor_rol);
    u_p   : entity work.permutacao_pares port map (x_reg, valor_p);
    u_ror : entity work.rotacao_direita3 port map (x_reg, valor_ror);
    u_mux : entity work.mux_operacao
        port map (switches, valor_xor, valor_rol, valor_p, valor_ror,
                  x_reg, sel_op, proximo_valor);

    u_k : entity work.registrador10 port map (clk, reset, ld_k, switches, k_reg);
    u_x : entity work.registrador10 port map (clk, reset, ld_x, proximo_valor, x_reg);
    -- X e C recebem a MESMA saida do mux, inclusive na borda de S5 -> S6.
    u_c : entity work.registrador10 port map (clk, reset, ld_c, proximo_valor, c_reg);
    u_saida : entity work.mux_saida port map (x_reg, c_reg, sel_saida, valor_saida);

    chave_debug <= k_reg;
    trabalho_debug <= x_reg;
    cifrado_debug <= c_reg;
end architecture;
