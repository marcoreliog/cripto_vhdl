library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.cifrador_pkg.all;

entity tb_blocos is end entity;
architecture simulacao of tb_blocos is
    signal valor, chave : palavra10 := (others => '0');
    signal valor_xor, valor_rol, valor_p, valor_ror : palavra10;
    signal digito : std_logic_vector(3 downto 0) := (others => '0');
    signal segmentos_n : std_logic_vector(7 downto 0);
begin
    u_xor : entity work.xor10 port map (valor, chave, valor_xor);
    u_rol : entity work.rotacao_esquerda3 port map (valor, valor_rol);
    u_p : entity work.permutacao_pares port map (valor, valor_p);
    u_ror : entity work.rotacao_direita3 port map (valor, valor_ror);
    u_hex : entity work.decodificador_hex port map (digito, segmentos_n);
    estimulos : process
    begin
        for i in 0 to 1023 loop
            valor <= std_logic_vector(to_unsigned(i, 10));
            chave <= std_logic_vector(to_unsigned((i*73+341) mod 1024, 10));
            digito <= std_logic_vector(to_unsigned(i mod 16, 4));
            wait for 20 ns;
        end loop;
        wait;
    end process;
end architecture;
