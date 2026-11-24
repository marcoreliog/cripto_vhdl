library ieee;
use ieee.std_logic_1164.all;

entity tb_permuter is
end tb_permuter;

architecture test of tb_permuter is

    component permuter is
        port (
            A : in std_logic_vector(9 downto 0);
            P : out std_logic_vector(9 downto 0)
        );
    end component;

    signal a : std_logic_vector(9 downto 0) := (others => '0');
    signal p : std_logic_vector(9 downto 0);

begin

    dut : permuter port map (A => a, P => p);

    stimulus : process
    begin

        a <= "1011001001";
        wait for 10 ns;

        a <= "0000000000";
        wait;
    end process;

end test;
