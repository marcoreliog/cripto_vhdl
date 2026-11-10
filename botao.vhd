library ieee;
use ieee.std_logic_1164.all;

entity botao is
    generic (
        AMOSTRAS_ESTAVEIS : positive := 4
    );
    port (
        clk, reset, tick, entrada : in std_logic;
        nivel, pulso : out std_logic
    );
end botao;

architecture arch_botao of botao is
    signal sinc_1, sinc_2, filtrado : std_logic := '1';
    signal contagem : natural range 0 to AMOSTRAS_ESTAVEIS - 1 := 0;
    attribute ASYNC_REG : string;
    attribute ASYNC_REG of sinc_1, sinc_2 : signal is "TRUE";
begin
    nivel <= filtrado;

    process (clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                sinc_1 <= '1';
                sinc_2 <= '1';
                filtrado <= '1';
                contagem <= 0;
                pulso <= '0';
            else
                sinc_1 <= entrada;
                sinc_2 <= sinc_1;
                pulso <= '0';

                if tick = '1' then
                    if sinc_2 = filtrado then
                        contagem <= 0;
                    elsif contagem = AMOSTRAS_ESTAVEIS - 1 then
                        filtrado <= sinc_2;
                        contagem <= 0;
                        if sinc_2 = '1' then
                            pulso <= '1';
                        end if;
                    else
                        contagem <= contagem + 1;
                    end if;
                end if;
            end if;
        end if;
    end process;
end arch_botao;
