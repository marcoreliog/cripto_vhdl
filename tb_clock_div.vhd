library ieee;
use ieee.std_logic_1164.all;
use std.env.all;

entity tb_clock_div is
end entity tb_clock_div;

architecture test of tb_clock_div is
    signal clk : std_logic := '0';
    signal reset : std_logic := '0';
    signal tick : std_logic;
begin
    dut : entity work.clock_div
        generic map (DIVISOR => 4)
        port map (clk => clk, reset => reset, tick => tick);

    clk <= not clk after 5 ns;

    stimulus : process
        procedure ciclo is
        begin
            wait until rising_edge(clk);
            wait for 1 ns;
        end procedure;
    begin
        reset <= '1';
        ciclo;
        assert tick = '0' report "tick deve ficar baixo durante reset" severity failure;

        reset <= '0';
        ciclo;
        ciclo;
        ciclo;
        assert tick = '0' report "tick antecipado" severity failure;
        ciclo;
        assert tick = '1' report "tick nao ocorreu no divisor configurado" severity failure;
        ciclo;
        assert tick = '0' report "tick deve durar um ciclo" severity failure;

        reset <= '1';
        ciclo;
        assert tick = '0' report "reset deve limpar tick" severity failure;

        report "clock_div: todos os testes passaram." severity note;
        stop;
        wait;
    end process;
end architecture test;
