library ieee;
use ieee.std_logic_1164.all;

entity tb_xor_maker is
end tb_xor_maker;

architecture test of tb_xor_maker is

    component xor_maker is
        port (
            A, B : in std_logic_vector(9 downto 0);
            X : out std_logic_vector(9 downto 0)
        );
    end component;

    signal a, b : std_logic_vector(9 downto 0) := (others => '0');
    signal x : std_logic_vector(9 downto 0);

begin

    dut : xor_maker port map (A => a, B => b, X => x);

    stimulus : process
    begin

        a <= "1011010011";
        b <= "0101010110";
        wait for 10 ns;

        a <= "1111111111";
        b <= "1111111111";
        wait;
    end process;

end test;
