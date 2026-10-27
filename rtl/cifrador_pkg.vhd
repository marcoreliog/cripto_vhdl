library ieee;
use ieee.std_logic_1164.all;

package cifrador_pkg is
    subtype palavra10 is std_logic_vector(9 downto 0);
    subtype codigo_op is std_logic_vector(2 downto 0);
    constant OP_SWITCHES : codigo_op := "000";
    constant OP_XOR      : codigo_op := "001";
    constant OP_ROL3     : codigo_op := "010";
    constant OP_PERMUTA  : codigo_op := "011";
    constant OP_ROR3     : codigo_op := "100";
end package;
