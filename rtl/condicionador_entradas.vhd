library ieee;
use ieee.std_logic_1164.all;
use work.cifrador_pkg.all;

entity condicionador_entradas is
    generic (CICLOS_DEBOUNCE : positive := 500000); -- 10 ms a 50 MHz
    port (
        clk, key0_n, key1_n : in std_logic;
        sw : in palavra10;
        reset, confirmar : out std_logic;
        switches : out palavra10
    );
end entity;

architecture rtl of condicionador_entradas is
    signal reset_meta, reset_sync : std_logic := '1';
    signal tecla_meta, tecla_sync : std_logic;
    signal sw_meta, sw_sync : palavra10;
    signal nivel_estavel : std_logic;
    signal contador : natural range 0 to CICLOS_DEBOUNCE-1;
    attribute altera_attribute : string;
    attribute altera_attribute of reset_meta, reset_sync, tecla_meta,
        tecla_sync, sw_meta, sw_sync : signal is
        "-name SYNCHRONIZER_IDENTIFICATION FORCED_IF_ASYNCHRONOUS";
begin
    -- KEY1 ativo baixo: assertiva assincrona apenas neste sincronizador.
    -- Soltura sincronizada em dois estagios; o nucleo usa reset sincrono.
    process(clk, key1_n)
    begin
        if key1_n = '0' then
            reset_meta <= '1'; reset_sync <= '1';
        elsif rising_edge(clk) then
            reset_meta <= '0'; reset_sync <= reset_meta;
        end if;
    end process;
    reset <= reset_sync;

    process(clk)
    begin
        if rising_edge(clk) then
            if reset_sync = '1' then
                tecla_meta <= '1'; tecla_sync <= '1';
                sw_meta <= (others => '0'); sw_sync <= (others => '0');
            else
                tecla_meta <= key0_n; tecla_sync <= tecla_meta;
                sw_meta <= sw; sw_sync <= sw_meta;
            end if;
        end if;
    end process;
    switches <= sw_sync;

    process(clk)
    begin
        if rising_edge(clk) then
            confirmar <= '0';
            if reset_sync = '1' then
                nivel_estavel <= '1'; contador <= 0;
            elsif tecla_sync = nivel_estavel then
                contador <= 0;
            elsif contador = CICLOS_DEBOUNCE-1 then
                -- A transicao para pressionado gera um pulso de um ciclo.
                nivel_estavel <= tecla_sync;
                contador <= 0;
                if tecla_sync = '0' then confirmar <= '1'; end if;
            else
                contador <= contador + 1;
            end if;
        end if;
    end process;
end architecture;
