library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity controller is
 port(clk, reset, confirmar, modo_decifrar, fim_camadas, cifrado_valido : in std_logic;
      operacao : in std_logic_vector(1 downto 0);
      ld_v, ld_k, ld_x, ld_c, rot_mode, clr_n, inc_n, ld_acerto, clr_acerto, set_valido, clr_valido, sel_saida : out std_logic;
      sel_x : out std_logic_vector(2 downto 0);
      estado : out std_logic_vector(3 downto 0));
end entity;
architecture rtl of controller is
 -- A posicao no tipo preserva a interface estado = S0 ... S15.
 type estado_t is (
  INIT, INSERIR_VALOR, INSERIR_CHAVE_C, SELECIONAR_C,
  PERMUTAR_C, ROL_C, XOR_C, SALVAR_CIFRADO,
  PREPARA_TENTATIVA, SELECIONAR_D, PERMUTAR_D, ROR_D,
  INSERIR_CHAVE_D, XOR_D, COMPARAR, RESULTADO
 );
 signal atual, prox : estado_t;
begin
 estado <= std_logic_vector(to_unsigned(estado_t'pos(atual), 4));
 process(clk)
 begin
  if rising_edge(clk) then
   if reset = '1' then atual <= INIT;
   else atual <= prox;
   end if;
  end if;
 end process;
 process(all)
 begin
  -- Padroes em todas as saidas: sem latches e sem cargas acidentais.
  prox <= atual;
  ld_v <= '0';
  ld_k <= '0';
  ld_x <= '0';
  ld_c <= '0';
  rot_mode <= '0';
  clr_n <= '0';
  inc_n <= '0';
  ld_acerto <= '0';
  clr_acerto <= '0';
  set_valido <= '0';
  clr_valido <= '0';
  sel_saida <= '0';
  sel_x <= "000";
  case atual is
   when INIT =>
    if confirmar = '1' then
     if modo_decifrar = '0' then
      clr_valido <= '1'; clr_acerto <= '1'; prox <= INSERIR_VALOR;
     elsif cifrado_valido = '1' then
      prox <= PREPARA_TENTATIVA;
     end if;
    end if;
   when INSERIR_VALOR =>
    if confirmar = '1' then ld_v <= '1'; ld_x <= '1'; prox <= INSERIR_CHAVE_C; end if;
   when INSERIR_CHAVE_C =>
    if confirmar = '1' then ld_k <= '1'; clr_n <= '1'; prox <= SELECIONAR_C; end if;
   when SELECIONAR_C =>
    -- O teste de n = 3 tem prioridade; nao existe quarta operacao.
    if fim_camadas = '1' then prox <= SALVAR_CIFRADO;
    elsif confirmar = '1' then
     case operacao is
      when "00" => prox <= PERMUTAR_C;
      when "01" => prox <= ROL_C;
      when "10" => prox <= XOR_C;
      when others => null;
     end case;
    end if;
   when PERMUTAR_C | ROL_C | XOR_C =>
    ld_x <= '1'; inc_n <= '1'; prox <= SELECIONAR_C;
    case atual is
     when PERMUTAR_C => sel_x <= "011";
     when ROL_C => sel_x <= "010"; rot_mode <= '1';
     when others => sel_x <= "001";
    end case;
   when SALVAR_CIFRADO =>
    -- X ja recebeu a terceira operacao em um clock anterior.
    ld_c <= '1'; set_valido <= '1'; prox <= INIT;
   when PREPARA_TENTATIVA =>
    ld_x <= '1'; sel_x <= "100"; clr_n <= '1'; clr_acerto <= '1';
    prox <= SELECIONAR_D;
   when SELECIONAR_D =>
    if fim_camadas = '1' then prox <= COMPARAR;
    elsif confirmar = '1' then
     case operacao is
      when "00" => prox <= PERMUTAR_D;
      when "01" => prox <= ROR_D;
      when "10" => prox <= INSERIR_CHAVE_D;
      when others => null;
     end case;
    end if;
   when PERMUTAR_D | ROR_D | XOR_D =>
    ld_x <= '1'; inc_n <= '1'; prox <= SELECIONAR_D;
    case atual is
     when PERMUTAR_D => sel_x <= "011";
     when ROR_D => sel_x <= "010";
     when others => sel_x <= "001";
    end case;
   when INSERIR_CHAVE_D =>
    -- Confirmar o palpite nao incrementa n. S13 executa a camada.
    if confirmar = '1' then ld_k <= '1'; prox <= XOR_D; end if;
   when COMPARAR =>
    -- Comparacao usa X registrado; o LED so e carregado aqui.
    ld_acerto <= '1'; prox <= RESULTADO;
   when RESULTADO =>
    if confirmar = '1' then prox <= PREPARA_TENTATIVA; end if;
  end case;
  if atual = INIT and cifrado_valido = '1' then sel_saida <= '1'; end if;
 end process;
end architecture;
