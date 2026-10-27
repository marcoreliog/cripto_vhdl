"""Scoreboards por ciclo e cobertura obrigatoria; falhas encerram com codigo nao zero."""
from pathlib import Path
from .referencia import (rol3, ror3, permuta, cifra, decifra, controles,
                         transicao, operacao, segmentos)
from .vcd import VCD


def igual(obtido, esperado, contexto):
    if obtido != esperado:
        raise ValueError(f"{contexto}: obtido={obtido}, esperado={esperado}")


def exigir(condicao, contexto):
    if not condicao:
        raise ValueError(contexto)


def verificar_referencia():
    igual([204 ^ 682, rol3(614), cifra(204, 682)], [614, 820, 824], "vetor cifragem")
    igual([permuta(824), ror3(820), decifra(824, 682)], [820, 614, 204], "vetor inverso")
    for bit in range(10):
        igual(rol3(1 << bit), 1 << ((bit+3) % 10), "ROL bit isolado")
        igual(ror3(1 << bit), 1 << ((bit-3) % 10), "ROR bit isolado")
        igual(permuta(1 << bit), 1 << (bit ^ 1), "P bit isolado")
    for chave in range(1024):
        for mensagem in range(1024):
            igual(decifra(cifra(mensagem, chave), chave), mensagem, "inversa referencia")
    return {"pares_referencia": 1024**2, "vetor_conhecido": "aprovado"}


def verificar_blocos(caminho):
    onda = VCD(caminho)
    valores_vistos, digitos = set(), set()
    amostras = 0
    for tempo, agora in onda.grupos():
        ler = lambda nome: onda.inteiro(agora, "tb_blocos." + nome)
        x, k, d = ler("valor"), ler("chave"), ler("digito")
        for sinal, esperado in (("valor_xor", x ^ k), ("valor_rol", rol3(x)),
                                ("valor_p", permuta(x)), ("valor_ror", ror3(x)),
                                ("segmentos_n", segmentos(d))):
            igual(ler(sinal), esperado, f"blocos t={tempo} {sinal}")
        valores_vistos.add(x); digitos.add(d); amostras += 1
    igual(len(valores_vistos), 1024, "cobertura blocos")
    igual(len(digitos), 16, "cobertura decodificador")
    return {"valores_por_bloco": len(valores_vistos), "digitos": len(digitos), "amostras": amostras}


def verificar_controle(caminho):
    onda = VCD(caminho)
    anterior, estado, bordas = None, 0, 0
    cobertura, resets = set(), set()
    nomes = ("ld_k", "ld_x", "ld_c", "sel_op", "sel_saida", "leds_status")
    for tempo, agora in onda.grupos():
        ler = lambda nome, v=agora: onda.inteiro(v, "tb_controle." + nome)
        if anterior is not None and ler("clk", anterior) == 0 and ler("clk") == 1:
            if ler("reset", anterior):
                resets.add(estado); estado = 0
            else:
                estado = transicao(estado, ler("confirmar", anterior), ler("escolher_decifrar", anterior))
            bordas += 1
        if bordas:
            igual(ler("estado_codigo"), estado, f"FSM t={tempo}")
            esperado = controles(estado, ler("confirmar"))
            igual(tuple(ler(n) for n in nomes), esperado, f"controle S{estado} t={tempo}")
            cobertura.add((estado, ler("confirmar"), ler("escolher_decifrar")))
        anterior = agora
    igual({s for s, _, _ in cobertura}, set(range(11)), "estados FSM")
    for s in range(11):
        for confirmar in range(2):
            exigir(any(e == s and c == confirmar for e, c, _ in cobertura), f"sem S{s} confirmar={confirmar}")
    exigir({(6, c, w) for c in range(2) for w in range(2)} <= cobertura, "escolhas S6 incompletas")
    igual(resets, set(range(11)), "reset em todos os estados FSM")
    igual(onda.inteiro(anterior, "tb_controle.executando"), 0, "fim FSM")
    return {"bordas": bordas, "estados": 11, "estados_interrompidos_por_reset": len(resets),
            "combinacoes_estado_confirmar_escolha": len(cobertura)}


class ModeloNucleo:
    def __init__(self):
        self.estado = self.k = self.x = self.c = 0
        self.bordas = self.concluidas = self.conhecidas = 0
        self.resets, self.pares, self.mensagens, self.chaves, self.escolhas = set(), set(), set(), set(), set()
        self.mensagem = 0
        self.etapas_conhecidas = set()

    def passo(self, reset, confirmar, sw):
        s = self.estado
        self.bordas += 1
        if reset:
            self.resets.add(s)
            self.estado = self.k = self.x = self.c = 0
            return
        if s == 6:
            self.escolhas.add((confirmar, sw & 1))
        if s == 1 and confirmar:
            self.k = sw
        elif s == 2 and confirmar:
            self.x = self.mensagem = sw
            self.mensagens.add(sw); self.chaves.add(self.k)
            self.pares.add((self.k, sw))
        elif s in (3, 9):
            self.x ^= self.k
        elif s == 4:
            self.x = rol3(self.x)
        elif s == 5:
            self.x = self.c = permuta(self.x)
            igual(self.c, cifra(self.mensagem, self.k), "camadas cifragem")
        elif s == 7:
            self.x = permuta(self.x)
        elif s == 8:
            self.x = ror3(self.x)
        self.estado = transicao(s, confirmar, sw & 1)
        if s == 9:
            igual(self.x, self.mensagem, "recuperacao completa")
            self.concluidas += 1
            if (self.k, self.mensagem) == (682, 204):
                self.conhecidas += 1
        if (self.k, self.mensagem) == (682, 204) and s in (3, 4, 5, 7, 8, 9):
            self.etapas_conhecidas.add(s)

    def conferir(self, ler, contexto):
        esperado = {"estado_codigo": self.estado, "chave_debug": self.k,
                    "trabalho_debug": self.x, "cifrado_debug": self.c,
                    "valor_saida": self.c if 6 <= self.estado <= 9 else self.x,
                    "leds_status": controles(self.estado, 0)[-1]}
        for nome, valor in esperado.items():
            igual(ler(nome), valor, contexto + " " + nome)

    def resumo(self):
        return {"bordas": self.bordas, "ciclos_completos": self.concluidas,
                "pares_distintos": len(self.pares), "mensagens_distintas": len(self.mensagens),
                "chaves_distintas": len(self.chaves), "vetores_conhecidos": self.conhecidas,
                "estados_interrompidos_por_reset": len(self.resets)}


def verificar_nucleo(caminho):
    onda, modelo = VCD(caminho), ModeloNucleo()
    anterior = None
    for tempo, agora in onda.grupos():
        ler = lambda nome, v=agora: onda.inteiro(v, "tb_nucleo." + nome)
        if anterior is not None and ler("clk", anterior) == 0 and ler("clk") == 1:
            modelo.passo(ler("reset", anterior), ler("confirmar", anterior), ler("switches", anterior))
            modelo.conferir(ler, f"nucleo t={tempo}")
        anterior = agora
    # O ultimo percurso do ensaio de resets tambem chega a S10.
    igual(modelo.concluidas, 1052, "1051 vetores e um percurso do ensaio de resets")
    igual(len(modelo.mensagens), 1024, "cobertura mensagens")
    igual(len(modelo.chaves), 1024, "cobertura chaves")
    igual(modelo.resets, set(range(11)), "reset em todos os estados nucleo")
    igual(modelo.escolhas, {(0, 0), (0, 1), (1, 0), (1, 1)}, "S6 integrado")
    igual(modelo.etapas_conhecidas, {3, 4, 5, 7, 8, 9}, "intermediarios vetor conhecido")
    igual(onda.inteiro(anterior, "tb_nucleo.executando"), 0, "fim nucleo")
    return modelo.resumo()


def verificar_datapath(caminho):
    onda = VCD(caminho)
    anterior, k, x, c, bordas = None, 0, 0, 0, 0
    valores = {op: set() for op in range(5)}
    seletores, enables = set(), set()
    for tempo, agora in onda.grupos():
        ler = lambda nome, v=agora: onda.inteiro(v, "tb_datapath." + nome)
        if anterior is not None and ler("clk", anterior) == 0 and ler("clk") == 1:
            sw, sel = ler("switches", anterior), ler("sel_op", anterior)
            lk, lx, lc = (ler(n, anterior) for n in ("ld_k", "ld_x", "ld_c"))
            if ler("reset", anterior):
                k = x = c = 0
            else:
                if lx:
                    if sel <= 4: valores[sel].add(sw if sel == 0 else x)
                    seletores.add(sel)
                enables.add((lk, lx, lc))
                d = operacao(sel, sw, x, k)
                if lk: k = sw
                if lx: x = d
                if lc: c = d
            bordas += 1
        if bordas:
            for nome, esperado in (("chave_debug", k), ("trabalho_debug", x),
                                    ("cifrado_debug", c),
                                    ("valor_saida", c if ler("sel_saida") else x)):
                igual(ler(nome), esperado, f"datapath t={tempo} {nome}")
        anterior = agora
    igual(seletores, set(range(8)), "todos seletores incluindo invalidos")
    for op in range(5): igual(len(valores[op]), 1024, f"cobertura operacao {op}")
    exigir({(0, 0, 0), (1, 0, 0), (0, 1, 0), (0, 1, 1), (0, 0, 1)} <= enables, "enables datapath")
    igual(onda.inteiro(anterior, "tb_datapath.executando"), 0, "fim datapath")
    return {"bordas": bordas, "seletores": sorted(seletores), "valores_por_operacao": 1024}


class ModeloEntradas:
    """Pipeline, filtro e pulso modelados a partir dos pinos, sem usar o DUT."""
    def __init__(self, ciclos):
        self.ciclos = ciclos
        self.rm = self.rs = self.tm = self.ts = self.nivel = 1
        self.sm = self.ss = self.contador = self.pulso = self.pulsos = 0

    def observar(self, key0, key1, sw, borda):
        if not key1:
            self.rm = self.rs = 1
        if borda:
            reset_anterior = self.rs
            tm, ts, sm = self.tm, self.ts, self.sm
            if key1:
                self.rs, self.rm = self.rm, 0
            self.pulso = 0
            if reset_anterior:
                self.tm = self.ts = self.nivel = 1
                self.sm = self.ss = self.contador = 0
            else:
                self.tm, self.ts = key0, tm
                self.sm, self.ss = sw, sm
                if ts == self.nivel:
                    self.contador = 0
                elif self.contador + 1 == self.ciclos:
                    self.nivel, self.contador = ts, 0
                    self.pulso = 1-ts
                else:
                    self.contador += 1
            self.pulsos += self.pulso


def verificar_condicionador(caminho, ciclos):
    onda, modelo = VCD(caminho), ModeloEntradas(ciclos)
    anterior, bordas = None, 0
    for tempo, agora in onda.grupos():
        ler = lambda nome, v=agora: onda.inteiro(v, "tb_condicionador." + nome)
        borda = anterior is not None and ler("clk", anterior) == 0 and ler("clk") == 1
        # Estimulos externos estao fora da borda ativa: podem ser lidos em agora.
        modelo.observar(ler("key0_n"), ler("key1_n"), ler("sw"), borda)
        if borda: bordas += 1
        if bordas:
            for nome, esperado in (("reset", modelo.rs), ("confirmar", modelo.pulso),
                                    ("switches", modelo.ss)):
                igual(ler(nome), esperado, f"condicionador N={ciclos} t={tempo} {nome}")
        anterior = agora
    if ciclos >= 4: igual(modelo.pulsos, 3, "apertos validos sem bounce")
    exigir(modelo.pulsos >= 3, "falta aperto apos liberar/resetar")
    igual(onda.inteiro(anterior, "tb_condicionador.executando"), 0, "fim condicionador")
    return {"ciclos_debounce": ciclos, "bordas": bordas, "pulsos": modelo.pulsos}


def verificar_top(caminho):
    onda, entradas, nucleo = VCD(caminho), ModeloEntradas(4), ModeloNucleo()
    anterior, bordas = None, 0
    estados, resets = set(), set()
    for tempo, agora in onda.grupos():
        ler = lambda nome, v=agora: onda.inteiro(v, "tb_top." + nome)
        borda = anterior is not None and ler("clk", anterior) == 0 and ler("clk") == 1
        if borda:
            if entradas.rs: resets.add(nucleo.estado)
            nucleo.passo(entradas.rs, entradas.pulso, entradas.ss)
            bordas += 1
        key = ler("key")
        entradas.observar(key & 1, (key >> 1) & 1, ler("sw"), borda)
        if bordas:
            # Verifica fisicamente segmentos/LEDs e tambem o estado interno.
            for nome, esperado in (("dut.reset", entradas.rs), ("dut.confirmar", entradas.pulso),
                                    ("dut.switches", entradas.ss),
                                    ("dut.estado_codigo", nucleo.estado)):
                igual(ler(nome), esperado, f"top t={tempo} {nome}")
            valor = nucleo.c if 6 <= nucleo.estado <= 9 else nucleo.x
            for indice, d in enumerate((valor & 15, (valor >> 4) & 15,
                                       (valor >> 8) & 3, nucleo.estado)):
                igual(ler(f"hex{indice}"), segmentos(d), f"top HEX{indice} t={tempo}")
            igual(ler("hex4"), 255, "HEX4 apagado")
            igual(ler("hex5"), 255, "HEX5 apagado")
            igual(ler("ledr"), controles(nucleo.estado, 0)[-1], f"top LEDR t={tempo}")
            estados.add(nucleo.estado)
        anterior = agora
    igual(estados, set(range(11)), "top todos estados")
    igual(nucleo.concluidas, 5, "top cinco transacoes completas")
    exigir(3 in resets, "reset fisico nao interrompeu S3")
    igual(entradas.pulsos, 33, "top um evento por aperto valido")
    igual(onda.inteiro(anterior, "tb_top.executando"), 0, "top terminou antes do watchdog")
    return {**nucleo.resumo(), "pulsos_fisicos": entradas.pulsos, "estados_exibidos": len(estados),
            "reset_fisico_em_S3": True}


def verificar_tudo(diretorio):
    diretorio = Path(diretorio)
    resultado = {"referencia": verificar_referencia()}
    for nome, funcao in (("blocos", verificar_blocos), ("controle", verificar_controle),
                          ("datapath", verificar_datapath), ("nucleo", verificar_nucleo),
                          ("top", verificar_top)):
        resultado[nome] = funcao(diretorio / f"tb_{nome}.vcd")
    for ciclos in (1, 4, 7):
        resultado[f"condicionador_{ciclos}"] = verificar_condicionador(
            diretorio / f"tb_condicionador_{ciclos}.vcd", ciclos)
    return resultado
