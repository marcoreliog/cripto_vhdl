library ieee;
use ieee.std_logic_1164.all;

-- S0 a S14: 00 a 14 em HEX1 e HEX0. S15: ACERTO ou ERRO.
-- HEX5 fica na esquerda e HEX0 na direita.
-- Cada saida usa a ordem gfedcba, com o segmento a no bit 0.
-- ATIVO_EM_ZERO = true faz o pino acender o segmento com nivel 0.
entity hex7seg is
    generic (
        ATIVO_EM_ZERO : boolean := true
    );
    port (
        estado : in  std_logic_vector(3 downto 0);
        acerto : in  std_logic;
        hex5   : out std_logic_vector(6 downto 0);
        hex4   : out std_logic_vector(6 downto 0);
        hex3   : out std_logic_vector(6 downto 0);
        hex2   : out std_logic_vector(6 downto 0);
        hex1   : out std_logic_vector(6 downto 0);
        hex0   : out std_logic_vector(6 downto 0)
    );
end entity hex7seg;

architecture rtl of hex7seg is
    -- Nos sinais internos, 1 marca um segmento aceso.
    constant APAGADO : std_logic_vector(6 downto 0) := "0000000";
    signal hex5_acesos, hex4_acesos, hex3_acesos,
           hex2_acesos, hex1_acesos, hex0_acesos : std_logic_vector(6 downto 0);
begin
    decodificar : process (estado, acerto)
    begin
        hex5_acesos <= APAGADO;
        hex4_acesos <= APAGADO;
        hex3_acesos <= APAGADO;
        hex2_acesos <= APAGADO;
        hex1_acesos <= APAGADO;
        hex0_acesos <= APAGADO;

        -- HEX1 mostra a dezena e HEX0 mostra a unidade.
        case estado is
            when "0000" => -- 00
                hex1_acesos <= "0111111";
                hex0_acesos <= "0111111";
            when "0001" => -- 01
                hex1_acesos <= "0111111";
                hex0_acesos <= "0000110";
            when "0010" => -- 02
                hex1_acesos <= "0111111";
                hex0_acesos <= "1011011";
            when "0011" => -- 03
                hex1_acesos <= "0111111";
                hex0_acesos <= "1001111";
            when "0100" => -- 04
                hex1_acesos <= "0111111";
                hex0_acesos <= "1100110";
            when "0101" => -- 05
                hex1_acesos <= "0111111";
                hex0_acesos <= "1101101";
            when "0110" => -- 06
                hex1_acesos <= "0111111";
                hex0_acesos <= "1111101";
            when "0111" => -- 07
                hex1_acesos <= "0111111";
                hex0_acesos <= "0000111";
            when "1000" => -- 08
                hex1_acesos <= "0111111";
                hex0_acesos <= "1111111";
            when "1001" => -- 09
                hex1_acesos <= "0111111";
                hex0_acesos <= "1101111";
            when "1010" => -- 10
                hex1_acesos <= "0000110";
                hex0_acesos <= "0111111";
            when "1011" => -- 11
                hex1_acesos <= "0000110";
                hex0_acesos <= "0000110";
            when "1100" => -- 12
                hex1_acesos <= "0000110";
                hex0_acesos <= "1011011";
            when "1101" => -- 13
                hex1_acesos <= "0000110";
                hex0_acesos <= "1001111";
            when "1110" => -- 14
                hex1_acesos <= "0000110";
                hex0_acesos <= "1100110";
            when "1111" => -- RESULT
                case acerto is
                    when '1' => -- ACERTO
                        hex5_acesos <= "1110111"; -- A
                        hex4_acesos <= "0111001"; -- C
                        hex3_acesos <= "1111001"; -- E
                        hex2_acesos <= "1010000"; -- r
                        hex1_acesos <= "1111000"; -- t
                        hex0_acesos <= "0111111"; -- O
                    when '0' => -- ERRO centralizado
                        hex4_acesos <= "1111001"; -- E
                        hex3_acesos <= "1010000"; -- r
                        hex2_acesos <= "1010000"; -- r
                        hex1_acesos <= "0111111"; -- O
                    when others => null;
                end case;
            when others => null;
        end case;
    end process decodificar;

    hex5 <= not hex5_acesos when ATIVO_EM_ZERO else hex5_acesos;
    hex4 <= not hex4_acesos when ATIVO_EM_ZERO else hex4_acesos;
    hex3 <= not hex3_acesos when ATIVO_EM_ZERO else hex3_acesos;
    hex2 <= not hex2_acesos when ATIVO_EM_ZERO else hex2_acesos;
    hex1 <= not hex1_acesos when ATIVO_EM_ZERO else hex1_acesos;
    hex0 <= not hex0_acesos when ATIVO_EM_ZERO else hex0_acesos;
end architecture rtl;
