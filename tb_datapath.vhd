library ieee;
use ieee.std_logic_1164.all;

entity tb_datapath is
end tb_datapath;

architecture test of tb_datapath is

    component datapath is
        port(
            clk_sys, ld_x, ld_k, ld_v, ld_c, rot_dir, clr : in std_logic;
            sw : in std_logic_vector(9 downto 0);
            sel : in std_logic_vector(2 downto 0);
            leds : out std_logic_vector(9 downto 0);
            equals, existe_cripto : out std_logic
        );
    end component;

    signal my_clock : std_logic := '0';
    signal ld_x, ld_k, ld_v, ld_c, rot_dir, clr : std_logic := '0';
    signal sw : std_logic_vector(9 downto 0) := (others => '0');
    signal sel : std_logic_vector(2 downto 0) := "000";
    signal leds : std_logic_vector(9 downto 0);
    signal equals, existe_cripto : std_logic;

begin

    dut: datapath
        port map(
            clk_sys => my_clock,
            clr => clr,
            sw => sw,
            ld_x => ld_x,
            ld_k => ld_k,
            ld_v => ld_v,
            ld_c => ld_c,
            leds => leds,
            sel => sel,
            rot_dir => rot_dir,
            equals => equals,
            existe_cripto => existe_cripto
        );

    my_clock <= not my_clock after 5 ns;

    -- Simular por 500 ns. Observar equals, existe_cripto e, dentro de dut,
    -- val_v, val_k, val_x e val_c. equals compara val_v com val_x.
    -- Cifragem esperada: 723 --XOR 342--> 901 --ROL 3--> 47 --PERM--> 31.
    -- Decifragem esperada: 31 --PERM--> 47 --ROR 3--> 901 --XOR 342--> 723.
    stimulus : process
    begin
        -- Clear sincrono: apos a borda, registradores = 0,
        -- equals = 1 e existe_cripto = 0.
        clr <= '1';
        wait for 12 ns;
        clr <= '0';

        -- Carregar V e X com o valor original 723; equals = 1.
        sw <= "1011010011";
        sel <= "000";
        ld_v <= '1';
        ld_x <= '1';
        wait for 10 ns;
        ld_v <= '0';
        ld_x <= '0';

        -- Carregar K com 342, preservando V e X.
        sw <= "0101010110";
        ld_k <= '1';
        wait for 10 ns;
        ld_k <= '0';

        -- Mudar sw e sel sem carga deve manter X = 723 e K = 342.
        sw <= "0000000000";
        sel <= "001";
        wait for 10 ns;

        -- XOR com a chave registrada: X = 901, equals = 0.
        ld_x <= '1';
        wait for 10 ns;
        ld_x <= '0';
        wait for 10 ns;

        -- Rotacao de tres bits para a esquerda: X = 47.
        sel <= "010";
        rot_dir <= '0';
        ld_x <= '1';
        wait for 10 ns;
        ld_x <= '0';
        wait for 10 ns;

        -- Trocar os bits de cada par vizinho: X = 31.
        sel <= "011";
        ld_x <= '1';
        wait for 10 ns;
        ld_x <= '0';
        wait for 10 ns;

        -- Salvar o cifrado: C = 31 e existe_cripto = 1 apos a borda.
        ld_c <= '1';
        wait for 10 ns;
        ld_c <= '0';
        wait for 10 ns;

        -- Substituir X por 17 sem alterar o cifrado salvo em C.
        sw <= "0000010001";
        sel <= "000";
        ld_x <= '1';
        wait for 10 ns;
        ld_x <= '0';
        wait for 10 ns;

        -- Restaurar C em X: X = 31, C continua valido.
        sel <= "100";
        ld_x <= '1';
        wait for 10 ns;
        ld_x <= '0';
        wait for 10 ns;

        -- Desfazer permutacao: X = 47.
        sel <= "011";
        ld_x <= '1';
        wait for 10 ns;
        ld_x <= '0';
        wait for 10 ns;

        -- Desfazer rotacao, agora para a direita: X = 901.
        sel <= "010";
        rot_dir <= '1';
        ld_x <= '1';
        wait for 10 ns;
        ld_x <= '0';
        wait for 10 ns;

        -- Desfazer XOR: X = V = 723, equals = 1.
        sel <= "001";
        ld_x <= '1';
        wait for 10 ns;
        ld_x <= '0';
        wait for 10 ns;

        -- Seletores nao usados devem manter X = 723, mesmo com ld_x = 1.
        sw <= "1111111111";
        ld_x <= '1';
        sel <= "111";
        wait for 10 ns;
        sel <= "110";
        wait for 10 ns;
        sel <= "101";
        wait for 10 ns;
        ld_x <= '0';
        wait for 10 ns;

        -- Nova tentativa a partir de C = 31.
        sel <= "100";
        ld_x <= '1';
        wait for 10 ns;
        ld_x <= '0';
        wait for 10 ns;

        -- Usar chave incorreta K = 0.
        sw <= "0000000000";
        ld_k <= '1';
        wait for 10 ns;
        ld_k <= '0';

        sel <= "011";
        ld_x <= '1';
        wait for 10 ns;
        ld_x <= '0';
        wait for 10 ns;

        sel <= "010";
        rot_dir <= '1';
        ld_x <= '1';
        wait for 10 ns;
        ld_x <= '0';
        wait for 10 ns;

        -- XOR com zero mantem X = 901, diferente de V; equals = 0.
        sel <= "001";
        ld_x <= '1';
        wait for 10 ns;
        ld_x <= '0';
        wait for 10 ns;

        -- Corrigir a chave e aplicar XOR: X volta a 723, equals = 1.
        sw <= "0101010110";
        ld_k <= '1';
        wait for 10 ns;
        ld_k <= '0';
        ld_x <= '1';
        wait for 10 ns;
        ld_x <= '0';
        wait for 10 ns;

        -- Clear tem prioridade sobre todas as cargas.
        -- V, K, X e C = 0, equals = 1 e existe_cripto = 0.
        clr <= '1';
        sw <= "1111111111";
        sel <= "000";
        ld_v <= '1';
        ld_k <= '1';
        ld_x <= '1';
        ld_c <= '1';
        wait for 10 ns;
        clr <= '0';
        ld_v <= '0';
        ld_k <= '0';
        ld_x <= '0';
        ld_c <= '0';
        wait for 10 ns;

        -- Restaurar C zerado e aplicar XOR com K zerado: X permanece 0.
        sel <= "100";
        ld_x <= '1';
        wait for 10 ns;
        sel <= "001";
        wait for 10 ns;
        ld_x <= '0';

        -- Salvar o valor zero tambem deve ativar existe_cripto.
        ld_c <= '1';
        wait for 10 ns;
        ld_c <= '0';
        wait for 10 ns;

        wait;
    end process;
end test;
