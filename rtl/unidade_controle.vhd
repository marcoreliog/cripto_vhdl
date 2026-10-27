library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.cifrador_pkg.all;

entity unidade_controle is
    port (
        clk, reset, confirmar, escolher_decifrar : in std_logic;
        ld_k, ld_x, ld_c : out std_logic;
        sel_op : out codigo_op;
        sel_saida : out std_logic;
        estado_codigo : out std_logic_vector(3 downto 0);
        leds_status : out std_logic_vector(3 downto 0)
    );
end entity;

architecture rtl of unidade_controle is
    type estado_tipo is (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10);
    signal estado, proximo_estado : estado_tipo;
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                estado <= S0;
            else
                estado <= proximo_estado;
            end if;
        end if;
    end process;

    -- Enables em S1/S2 dependem de confirmar: FSM com saidas Mealy.
    process(all)
    begin
        proximo_estado <= estado;
        ld_k <= '0'; ld_x <= '0'; ld_c <= '0';
        sel_op <= OP_SWITCHES;
        sel_saida <= '0';
        leds_status <= "0000";
        case estado is
            when S0 =>
                leds_status <= "0001";
                if confirmar = '1' then proximo_estado <= S1; end if;
            when S1 =>
                leds_status <= "0001";
                if confirmar = '1' then
                    ld_k <= '1'; proximo_estado <= S2;
                end if;
            when S2 =>
                leds_status <= "0001";
                if confirmar = '1' then
                    ld_x <= '1'; proximo_estado <= S3;
                end if;
            when S3 =>
                leds_status <= "0010";
                ld_x <= '1'; sel_op <= OP_XOR; proximo_estado <= S4;
            when S4 =>
                leds_status <= "0010";
                ld_x <= '1'; sel_op <= OP_ROL3; proximo_estado <= S5;
            when S5 =>
                leds_status <= "0010";
                ld_x <= '1'; ld_c <= '1'; sel_op <= OP_PERMUTA;
                proximo_estado <= S6;
            when S6 =>
                leds_status <= "0100"; sel_saida <= '1';
                if confirmar = '1' and escolher_decifrar = '1' then
                    proximo_estado <= S7;
                end if;
            when S7 =>
                leds_status <= "0010"; sel_saida <= '1';
                ld_x <= '1'; sel_op <= OP_PERMUTA; proximo_estado <= S8;
            when S8 =>
                leds_status <= "0010"; sel_saida <= '1';
                ld_x <= '1'; sel_op <= OP_ROR3; proximo_estado <= S9;
            when S9 =>
                leds_status <= "0010"; sel_saida <= '1';
                ld_x <= '1'; sel_op <= OP_XOR; proximo_estado <= S10;
            when S10 =>
                leds_status <= "1000";
        end case;
    end process;

    estado_codigo <= std_logic_vector(to_unsigned(estado_tipo'pos(estado), 4));
end architecture;
