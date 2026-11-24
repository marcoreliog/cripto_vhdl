library ieee;
use ieee.std_logic_1164.all;

entity tb_hex7seg is
end tb_hex7seg;

architecture test of tb_hex7seg is

    component hex7seg is
        generic (ATIVO_EM_ZERO : boolean := true);
        port (
            estado : in std_logic_vector(3 downto 0);
            acerto : in std_logic;
            hex5, hex4, hex3, hex2, hex1, hex0 : out std_logic_vector(6 downto 0)
        );
    end component;

    signal estado : std_logic_vector(3 downto 0) := "0000";
    signal acerto : std_logic := '0';
    signal hex5, hex4, hex3, hex2, hex1, hex0 : std_logic_vector(6 downto 0);

begin

    dut : hex7seg
        port map (
            estado => estado,
            acerto => acerto,
            hex5 => hex5,
            hex4 => hex4,
            hex3 => hex3,
            hex2 => hex2,
            hex1 => hex1,
            hex0 => hex0
        );

    stimulus : process
    begin

        wait for 10 ns;

        estado <= "1001";
        wait for 10 ns;

        estado <= "1010";
        wait for 10 ns;

        estado <= "1111";
        acerto <= '1';
        wait for 10 ns;

        acerto <= '0';
        wait;
    end process;

end test;
