library ieee;
use ieee.std_logic_1164.all;

-- Decodificador combinacional dos estados descritos no README.
-- S0 a S14: 0 a E; S15 (RESULT): t para acerto ou F para erro.
-- Segmentos na ordem gfedcba: segmentos(0) = a, segmentos(6) = g.
-- ATIVO_EM_ZERO = true: 0 acende; false: 1 acende.
-- Estados invalidos ou resultado indefinido deixam o display apagado.
-- Para uma controladora com saida de 4 bits, ligar estado => '0' & display
-- na futura integracao do topo.
entity hex7seg is
    generic (
        ATIVO_EM_ZERO : boolean := true
    );
    port (
        estado    : in  std_logic_vector(4 downto 0);
        acerto    : in  std_logic;
        segmentos : out std_logic_vector(6 downto 0)
    );
end entity hex7seg;

architecture rtl of hex7seg is

    
    signal segmentos_acesos : std_logic_vector(6 downto 0);
begin
    decodificar : process (estado, acerto)
    begin
        segmentos_acesos <= "0000000";

        case estado is
            when "00000" => segmentos_acesos <= "0111111"; -- 0
            when "00001" => segmentos_acesos <= "0000110"; -- 1
            when "00010" => segmentos_acesos <= "1011011"; -- 2
            when "00011" => segmentos_acesos <= "1001111"; -- 3
            when "00100" => segmentos_acesos <= "1100110"; -- 4
            when "00101" => segmentos_acesos <= "1101101"; -- 5
            when "00110" => segmentos_acesos <= "1111101"; -- 6
            when "00111" => segmentos_acesos <= "0000111"; -- 7
            when "01000" => segmentos_acesos <= "1111111"; -- 8
            when "01001" => segmentos_acesos <= "1101111"; -- 9
            when "01010" => segmentos_acesos <= "1110111"; -- A
            when "01011" => segmentos_acesos <= "1111100"; -- b
            when "01100" => segmentos_acesos <= "0111001"; -- C
            when "01101" => segmentos_acesos <= "1011110"; -- d
            when "01110" => segmentos_acesos <= "1111001"; -- E
            when "01111" =>
                case acerto is
                    when '1'    => segmentos_acesos <= "1111000"; -- t
                    when '0'    => segmentos_acesos <= "1110001"; -- F
                    when others => null;
                end case;
            when others => null;
        end case;
    end process decodificar;

    segmentos <= not segmentos_acesos when ATIVO_EM_ZERO else segmentos_acesos;
end architecture rtl;
