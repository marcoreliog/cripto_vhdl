library ieee;
use ieee.std_logic_1164.all;

entity tb_controller is
end tb_controller;

architecture test of tb_controller is

    -- Declaracao do componente, como no tb_coin_detector.
    component controller is
        port(
            enter, clock, modo, equals, existe_cripto : in std_logic;
            reset : in std_logic;
            op : in std_logic_vector(1 downto 0);
            ld_x, ld_k, ld_v, ld_c : out std_logic;
            sel : out std_logic_vector(2 downto 0);
            rot_dir, clr : out std_logic;
            display : out std_logic_vector(3 downto 0)
        );
    end component;

    signal my_clock : std_logic := '0';
    signal reset, modo, equals, existe_cripto : std_logic := '0';
    signal enter : std_logic := '1';
    signal op : std_logic_vector(1 downto 0) := "00";
    signal ld_x, ld_k, ld_v, ld_c, rot_dir, clr : std_logic;
    signal sel : std_logic_vector(2 downto 0);
    signal display : std_logic_vector(3 downto 0);

begin

    dut: controller
        port map(
            clock => my_clock,
            reset => reset,
            enter => enter,
            modo => modo,
            op => op,
            equals => equals,
            existe_cripto => existe_cripto,
            ld_x => ld_x,
            ld_k => ld_k,
            ld_v => ld_v,
            ld_c => ld_c,
            sel => sel,
            rot_dir => rot_dir,
            clr => clr,
            display => display
        );

    my_clock <= not my_clock after 5 ns;

    -- Simular por 500 ns e observar display e os sinais de controle.
    -- Reset e Enter sao ativos em '0'. Cada pulso de Enter dura 10 ns.
    -- Os estimulos mudam entre as bordas de subida do clock.
    stimulus : process
    begin
        -- INIT: display = 0000 e clr = 1. Depois do reset, MENU = 0001.
        reset <= '0';
        wait for 12 ns;
        reset <= '1';
        wait for 10 ns;

        -- Sem cifrado salvo, tentar decifrar deve manter MENU.
        modo <= '1';
        enter <= '0';
        wait for 10 ns;
        enter <= '1';
        wait for 10 ns;

        -- Iniciar cifragem: clr = 1 no MENU; depois INSERT_V = 0010.
        modo <= '0';
        enter <= '0';
        wait for 10 ns;
        enter <= '1';
        wait for 10 ns;

        -- Confirmar o valor: ld_v = ld_x = 1; depois INSERT_K = 0011.
        enter <= '0';
        wait for 10 ns;
        enter <= '1';
        wait for 10 ns;

        -- Confirmar a chave: ld_k = 1; depois SEL_OP_C = 0100.
        enter <= '0';
        wait for 10 ns;
        enter <= '1';
        wait for 10 ns;

        -- Mudar op sem Enter deve manter SEL_OP_C.
        op <= "01";
        wait for 10 ns;

        -- XOR_C = 0111: ld_x = 1, sel = 001; retorna a SEL_OP_C.
        enter <= '0';
        wait for 10 ns;
        enter <= '1';
        wait for 10 ns;

        -- ROL_C = 0110: ld_x = 1, sel = 010, rot_dir = 0.
        op <= "10";
        enter <= '0';
        wait for 10 ns;
        enter <= '1';
        wait for 10 ns;

        -- PERM_C = 0101: ld_x = 1, sel = 011.
        op <= "11";
        enter <= '0';
        wait for 10 ns;
        enter <= '1';
        wait for 10 ns;

        -- SAVE_C = 1000: ld_c = 1; retorna ao MENU.
        op <= "00";
        enter <= '0';
        wait for 10 ns;
        enter <= '1';
        wait for 10 ns;

        -- Simular a flag do datapath apos salvar o cifrado.
        -- ATTEMPT_D = 1001: ld_x = 1, sel = 100; depois SEL_OP_D = 1010.
        existe_cripto <= '1';
        modo <= '1';
        enter <= '0';
        wait for 10 ns;
        enter <= '1';
        wait for 10 ns;

        -- PERM_D = 1110: ld_x = 1, sel = 011.
        op <= "11";
        enter <= '0';
        wait for 10 ns;
        enter <= '1';
        wait for 10 ns;

        -- ROR_D = 1101: ld_x = 1, sel = 010, rot_dir = 1.
        op <= "10";
        enter <= '0';
        wait for 10 ns;
        enter <= '1';
        wait for 10 ns;

        -- TRY_K = 1011 deve aguardar outra confirmacao da chave.
        op <= "01";
        enter <= '0';
        wait for 10 ns;
        enter <= '1';
        wait for 20 ns;

        -- Carregar o palpite: ld_k = 1; depois XOR_D = 1100, sel = 001.
        enter <= '0';
        wait for 10 ns;
        enter <= '1';
        wait for 10 ns;

        -- Finalizar com acerto: RESULT = 1111 aguarda Enter.
        op <= "00";
        equals <= '1';
        enter <= '0';
        wait for 10 ns;
        enter <= '1';
        wait for 20 ns;

        -- A mudanca de equals sozinha nao deve tirar RESULT.
        equals <= '0';
        wait for 10 ns;
        enter <= '0';
        wait for 10 ns;
        enter <= '1';
        wait for 10 ns;

        -- Nova tentativa com o mesmo cifrado: ATTEMPT_D e SEL_OP_D.
        enter <= '0';
        wait for 10 ns;
        enter <= '1';
        wait for 10 ns;

        -- Finalizar com erro: RESULT tambem aguarda Enter.
        enter <= '0';
        wait for 10 ns;
        enter <= '1';
        wait for 20 ns;
        enter <= '0';
        wait for 10 ns;
        enter <= '1';
        wait for 10 ns;

        -- Reiniciar durante uma tentativa, fora da borda do clock.
        enter <= '0';
        wait for 10 ns;
        enter <= '1';
        wait for 10 ns;
        reset <= '0';
        existe_cripto <= '0';
        wait for 10 ns;
        reset <= '1';
        wait for 10 ns;

        wait;
    end process;
end test;
