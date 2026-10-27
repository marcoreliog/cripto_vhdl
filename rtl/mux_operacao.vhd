library ieee;
use ieee.std_logic_1164.all;
use work.cifrador_pkg.all;

entity mux_operacao is
    port (
        switches, valor_xor, valor_rol, valor_p, valor_ror, atual : in palavra10;
        sel_op : in codigo_op;
        resultado : out palavra10
    );
end entity;

architecture combinacional of mux_operacao is
begin
    with sel_op select resultado <=
        switches  when OP_SWITCHES,
        valor_xor when OP_XOR,
        valor_rol when OP_ROL3,
        valor_p   when OP_PERMUTA,
        valor_ror when OP_ROR3,
        atual     when others;
end architecture;
