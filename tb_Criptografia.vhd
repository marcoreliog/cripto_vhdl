library ieee;
use ieee.std_logic_1164.all;

entity tb_Criptografia is
end tb_Criptografia;

architecture test of tb_Criptografia is

    component Criptografia is
        generic (
            DIVISOR : positive := 10000000
        );
        port (
            base_clock : in std_logic;
            enter, reset : in std_logic;
            sw : in std_logic_vector(9 downto 0);
            leds : out std_logic_vector(9 downto 0);
            hex5, hex4, hex3, hex2, hex1, hex0 : out std_logic_vector(6 downto 0)
        );
    end component;

    signal base_clock : std_logic := '0';
    signal enter : std_logic := '1';
    signal reset : std_logic := '0';
    signal sw : std_logic_vector(9 downto 0) := (others => '0');
    signal leds : std_logic_vector(9 downto 0);
    signal hex5, hex4, hex3, hex2, hex1, hex0 : std_logic_vector(6 downto 0);

begin

    dut : Criptografia
        generic map (DIVISOR => 2)
        port map (
            base_clock => base_clock,
            enter => enter,
            reset => reset,
            sw => sw,
            leds => leds,
            hex5 => hex5,
            hex4 => hex4,
            hex3 => hex3,
            hex2 => hex2,
            hex1 => hex1,
            hex0 => hex0
        );

    base_clock <= not base_clock after 5 ns;

    stimulus : process
    begin

        wait for 6 ns;
        reset <= '1';

        wait for 31 ns;
        sw(0) <= '0';
        enter <= '0';
        wait for 10 ns;
        enter <= '1';

        sw <= "1011010011";
        wait for 8 ns;
        enter <= '0';
        wait for 12 ns;
        enter <= '1';

        sw <= "0101010110";
        wait for 8 ns;
        enter <= '0';
        wait for 12 ns;
        enter <= '1';

        wait for 8 ns;
        sw(1 downto 0) <= "01";
        enter <= '0';
        wait for 12 ns;
        enter <= '1';

        wait for 28 ns;
        sw(1 downto 0) <= "10";
        enter <= '0';
        wait for 12 ns;
        enter <= '1';

        wait for 28 ns;
        sw(1 downto 0) <= "11";
        enter <= '0';
        wait for 12 ns;
        enter <= '1';

        wait for 28 ns;
        sw(1 downto 0) <= "00";
        enter <= '0';
        wait for 12 ns;
        enter <= '1';
        wait for 28 ns;

        sw(0) <= '1';
        enter <= '0';
        wait for 12 ns;
        enter <= '1';

        wait for 28 ns;
        sw(1 downto 0) <= "11";
        enter <= '0';
        wait for 12 ns;
        enter <= '1';

        wait for 28 ns;
        sw(1 downto 0) <= "10";
        enter <= '0';
        wait for 12 ns;
        enter <= '1';

        wait for 28 ns;
        sw(1 downto 0) <= "01";
        enter <= '0';
        wait for 12 ns;
        enter <= '1';

        sw <= "0101010110";
        wait for 8 ns;
        enter <= '0';
        wait for 12 ns;
        enter <= '1';
        wait for 28 ns;

        sw(1 downto 0) <= "00";
        enter <= '0';
        wait for 12 ns;
        enter <= '1';
        wait;
    end process;

end test;
