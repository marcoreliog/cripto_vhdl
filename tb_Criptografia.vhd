library ieee;
use ieee.std_logic_1164.all;
use std.env.all;

entity tb_Criptografia is
end entity tb_Criptografia;

architecture test of tb_Criptografia is
    signal base_clock : std_logic := '0';
    signal reference_clock : std_logic;
    signal enter : std_logic := '1';
    signal reset : std_logic := '0';
    signal sw : std_logic_vector(9 downto 0) := (others => '0');
    signal leds : std_logic_vector(9 downto 0);
    signal hex5, hex4, hex3, hex2, hex1, hex0 : std_logic_vector(6 downto 0);
begin
    dut : entity work.Criptografia
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

    reference_divider : entity work.clock_div
        generic map (DIVISOR => 2)
        port map (
            clk => base_clock,
            reset => not reset,
            tick => reference_clock
        );

    base_clock <= not base_clock after 5 ns;

    stimulus : process
        procedure passo is
        begin
            wait until rising_edge(reference_clock);
            wait for 1 ns;
        end procedure;

        procedure confirmar is -- simulando apertar enter
        begin
            enter <= '0';
            passo;
            enter <= '1';
        end procedure;

        procedure operacao(constant codigo : in std_logic_vector(1 downto 0)) is -- simular inputar a operação da criptografia 
        begin
            sw(1 downto 0) <= codigo;
            confirmar;
            passo;
        end procedure;
    begin
        wait until rising_edge(base_clock);
        wait for 1 ns;
        reset <= '1';
        passo;

        -- Cifrar 723 com a chave 342.
        sw(0) <= '0';
        confirmar;
        sw <= "1011010011";
        confirmar;
        sw <= "0101010110";
        confirmar;
        operacao("01");
        operacao("10");
        operacao("11");
        operacao("00");
        passo;
        assert leds = "0000011111"
            report "Cifrado incorreto no sistema integrado" severity failure;

        -- Decifrar usando a chave correta.
        sw(0) <= '1';
        confirmar;
        passo;
        operacao("11");
        operacao("10");
        sw(1 downto 0) <= "01";
        confirmar;
        sw <= "0101010110";
        confirmar;
        passo;
        sw(1 downto 0) <= "00";
        confirmar;

        assert leds = "1011010011"
            report "Valor decifrado incorreto no sistema integrado" severity failure;
        assert hex5 & hex4 & hex3 & hex2 & hex1 & hex0 =
            "0001000" & "1000110" & "0000110" & "0101111" & "0000111" & "1000000"
            report "O resultado correto nao foi exibido" severity failure;

        report "Integracao Criptografia: todos os testes passaram." severity note;
        stop;
        wait;
    end process;
end architecture test;
