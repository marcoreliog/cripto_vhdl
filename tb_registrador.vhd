library ieee;
use ieee.std_logic_1164.all;

entity tb_registrador is
end tb_registrador;

architecture test of tb_registrador is

    component registrador is
        generic (N : positive := 8);
        port (
            clk, clear, carga : in std_logic;
            D : in std_logic_vector(N-1 downto 0);
            Q : out std_logic_vector(N-1 downto 0);
            loaded : out std_logic
        );
    end component;

    signal clk, clear, carga : std_logic := '0';
    signal d, q : std_logic_vector(3 downto 0) := (others => '0');
    signal loaded : std_logic;

begin

    dut : registrador
        generic map (N => 4)
        port map (clk => clk, clear => clear, carga => carga,
                  D => d, Q => q, loaded => loaded);

    clk <= not clk after 5 ns;

    stimulus : process
    begin

        clear <= '1';
        wait for 10 ns;

        clear <= '0';
        d <= "1010";
        carga <= '1';
        wait for 10 ns;

        carga <= '0';
        d <= "0101";
        wait for 10 ns;

        clear <= '1';
        carga <= '1';
        wait for 10 ns;

        wait;
    end process;

end test;
