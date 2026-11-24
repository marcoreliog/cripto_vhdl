library ieee;
use ieee.std_logic_1164.all;

entity tb_roller is
end tb_roller;

architecture test of tb_roller is

    component roller is
        port (
            mode : in std_logic;
            A : in std_logic_vector(9 downto 0);
            R : out std_logic_vector(9 downto 0)
        );
    end component;

    signal mode : std_logic := '0';
    signal a : std_logic_vector(9 downto 0) := (others => '0');
    signal r : std_logic_vector(9 downto 0);

begin

    dut : roller port map (mode => mode, A => a, R => r);

    stimulus : process
    begin

        a <= "1011010011";
        mode <= '0';
        wait for 10 ns;

        mode <= '1';
        wait;
    end process;

end test;
