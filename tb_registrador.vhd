library ieee;
use ieee.std_logic_1164.all;
use std.env.all;

entity tb_registrador is
end entity tb_registrador;

architecture test of tb_registrador is
    signal clk, clear, carga : std_logic := '0';
    signal d, q : std_logic_vector(3 downto 0) := (others => '0');
    signal loaded : std_logic;
begin
    dut : entity work.registrador
        generic map (N => 4)
        port map (clk => clk, clear => clear, carga => carga, D => d, Q => q, loaded => loaded);

    clk <= not clk after 5 ns;

    stimulus : process
        procedure ciclo is
        begin
            wait until rising_edge(clk);
            wait for 1 ns;
        end procedure;
    begin
        clear <= '1';
        ciclo;
        assert q = "0000" and loaded = '0'
            report "clear sincrono incorreto" severity failure;

        clear <= '0';
        d <= "1010";
        carga <= '1';
        ciclo;
        assert q = "1010" and loaded = '1'
            report "carga do registrador incorreta" severity failure;

        carga <= '0';
        d <= "0101";
        ciclo;
        assert q = "1010" and loaded = '1'
            report "registrador nao manteve o valor" severity failure;

        clear <= '1';
        carga <= '1';
        ciclo;
        assert q = "0000" and loaded = '0'
            report "clear deve ter prioridade sobre carga" severity failure;

        report "registrador: todos os testes passaram." severity note;
        stop;
        wait;
    end process;
end architecture test;
