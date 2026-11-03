#!/usr/bin/env python3
"""Confere formas de onda GHDL usando somente a biblioteca padrao do Python."""
from dataclasses import dataclass
from itertools import product
import json
from pathlib import Path
import re
import sys

ROOT = Path(__file__).resolve().parent
SEGMENTOS = (0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07,
             0x7F, 0x6F, 0x77, 0x7C, 0x39, 0x5E, 0x79, 0x71)


class Falha(Exception):
    pass


def conferir(obtido, esperado, contexto):
    if obtido != esperado:
        raise Falha(f'{contexto}: esperado {esperado!r}, obtido {obtido!r}')


def ler_vcd(caminho):
    """Entrega cada instante depois de todos os deltas, e seu valor anterior."""
    with caminho.open(encoding='ascii') as arquivo:
        scopes, codigos, cabecalho = [], {}, []
        for linha in arquivo:
            cabecalho.append(linha)
            partes = linha.split()
            if not partes:
                continue
            if partes[0] == '$scope':
                scopes.append(partes[2])
            elif partes[0] == '$upscope':
                scopes.pop()
            elif partes[0] == '$var':
                nome = '.'.join(scopes + [partes[4].split('[')[0]])
                codigos.setdefault(partes[3], []).append(nome)
            elif partes[0] == '$enddefinitions':
                break
        escala = re.search(r'\$timescale\s+(\d+)\s+(\w+)\s+\$end', ''.join(cabecalho))
        if escala is None:
            raise Falha(f'{caminho}: escala de tempo ausente')
        fs = int(escala[1]) * dict(fs=1, ps=1000, ns=10**6, us=10**9, ms=10**12, s=10**15)[escala[2]]
        tempo, valores, mudancas = None, {}, {}
        for linha in arquivo:
            linha = linha.strip()
            if not linha or linha.startswith('$'):
                continue
            if linha.startswith('#'):
                if tempo is not None:
                    anteriores = valores.copy()
                    valores.update(mudancas)
                    yield tempo * fs, anteriores, valores
                    mudancas = {}
                tempo = int(linha[1:])
                continue
            if linha[0] in 'bB':
                bits, codigo = linha[1:].split()
            elif linha[0] in '01xXzZuU':
                bits, codigo = linha[0], linha[1:]
            else:
                continue
            valor = int(bits, 2) if all(b in '01' for b in bits) else None
            for nome in codigos.get(codigo, []):
                mudancas[nome] = valor
        if tempo is not None:
            anteriores = valores.copy()
            valores.update(mudancas)
            yield tempo * fs, anteriores, valores


def permutar(valor):
    # Referencia por posicao, independente do cabeamento VHDL.
    resultado = 0
    for bit in range(10):
        resultado |= ((valor >> bit) & 1) << (bit ^ 1)
    return resultado


def girar(valor, esquerda):
    if esquerda:
        return ((valor << 3) | (valor >> 7)) & 1023
    return (valor >> 3) | ((valor & 7) << 7)


@dataclass
class Nucleo:
    estado: int = 0
    v: int = 0
    k: int = 0
    x: int = 0
    c: int = 0
    n: int = 0
    valido: int = 0
    led: int = 0

    def clock(self, entrada):
        if entrada['reset']:
            self.__dict__.update(Nucleo().__dict__)
            return
        s, confirmar = self.estado, entrada['confirmar']
        if s == 0 and confirmar:
            if entrada['modo_decifrar'] == 0:
                self.valido = self.led = 0
                self.estado = 1
            elif self.valido:
                self.estado = 8
        elif s == 1 and confirmar:
            self.v = self.x = entrada['switches']
            self.estado = 2
        elif s == 2 and confirmar:
            self.k = entrada['switches']
            self.n, self.estado = 0, 3
        elif s in (3, 9):
            if self.n == 3:
                self.estado = 7 if s == 3 else 14
            elif confirmar and entrada['operacao'] < 3:
                destinos = (4, 5, 6) if s == 3 else (10, 11, 12)
                self.estado = destinos[entrada['operacao']]
        elif s in (4, 5, 6, 10, 11, 13):
            if s in (4, 10):
                self.x = permutar(self.x)
            elif s in (5, 11):
                self.x = girar(self.x, s == 5)
            else:
                self.x ^= self.k
            self.n += 1
            self.estado = 3 if s < 7 else 9
        elif s == 7:
            self.c, self.valido, self.estado = self.x, 1, 0
        elif s == 8:
            self.x, self.n, self.led, self.estado = self.c, 0, 0, 9
        elif s == 12 and confirmar:
            self.k, self.estado = entrada['switches'], 13
        elif s == 14:
            self.led, self.estado = int(self.x == self.v), 15
        elif s == 15 and confirmar:
            self.estado = 8


def caminhos_nucleo(core):
    return dict(estado=core+'.estado', v=core+'.dp.v_reg', k=core+'.dp.k_reg',
                x=core+'.dp.x_reg', c=core+'.dp.c_reg', n=core+'.dp.n',
                valido=core+'.dp.valido_reg', led=core+'.dp.acerto_reg')


def entradas(valores, core):
    nomes = ('reset', 'confirmar', 'modo_decifrar', 'switches', 'operacao')
    return {nome: valores[core+'.'+nome] for nome in nomes}


def conferir_nucleo(modelo, valores, core, contexto):
    for nome, caminho in caminhos_nucleo(core).items():
        conferir(valores[caminho], getattr(modelo, nome), contexto+' '+nome)
    saida = modelo.c if modelo.estado == 0 and modelo.valido else modelo.x
    conferir(valores[core+'.valor_saida'], saida, contexto+' exibicao')
    conferir(valores[core+'.led_acerto'], modelo.led, contexto+' LED')
    conferir(valores[core+'.fim_camadas'], int(modelo.n == 3), contexto+' fim_camadas')


def conferir_bancada_nucleo(onda, bench, esperados=None):
    core = bench+'.dut'
    modelo, visitados, pontos, sequencias = Nucleo(), set(), set(), set()
    camadas, clocks, prioridade = [], 0, set()
    for tempo, antes, atual in ler_vcd(ROOT/'sim'/onda):
        contexto = f'{bench} em {tempo/10**6:g} ns'
        if antes.get(bench+'.clk') == 0 and atual[bench+'.clk'] == 1:
            inp = entradas(antes, core)
            if inp['reset'] or (modelo.estado == 0 and inp['confirmar'] and not inp['modo_decifrar']):
                camadas = []
            if modelo.estado in (4, 5, 6):
                camadas.append(modelo.estado - 4)
            if modelo.estado == 7:
                conferir(len(camadas), 3, contexto+' numero de camadas')
                sequencias.add(tuple(camadas))
            if modelo.estado in (3, 9) and modelo.n == 3 and inp['confirmar']:
                prioridade.add(modelo.estado)
            modelo.clock(inp)
            conferir_nucleo(modelo, atual, core, contexto)
            clocks += 1
            visitados.add(modelo.estado)
        etapa = atual[bench+'.etapa']
        if etapa and etapa != antes.get(bench+'.etapa'):
            pontos.add(etapa)
            if esperados is not None:
                esperado = esperados[str(etapa)]
                conferir(tempo, esperado['tempo_ns']*10**6, contexto+' instante do ponto')
                for nome, caminho in caminhos_nucleo(core).items():
                    conferir(atual[caminho], esperado[nome], contexto+' '+esperado['descricao']+' '+nome)
            else:
                original = ((etapa - 1)*37 + 1) % 1024
                conferir(atual[core+'.estado'], 15, contexto+' RESULTADO')
                conferir(atual[core+'.valor_saida'], original, contexto+' recuperacao do original')
                conferir(atual[core+'.led_acerto'], 1, contexto+' acerto')
    conferir(atual[bench+'.terminou'], 1, bench+' terminou')
    if esperados is not None:
        conferir(pontos, {int(n) for n in esperados}, bench+' cobertura de pontos')
        conferir(visitados, set(range(16)), bench+' cobertura de estados')
        conferir(prioridade, {3, 9}, bench+' prioridade de n=3 nos dois seletores')
    else:
        conferir(pontos, set(range(1, 28)), bench+' cobertura de tentativas')
        conferir(sequencias, set(product(range(3), repeat=3)), bench+' cobertura das 27 sequencias')
    return dict(clocks=clocks, pontos=len(pontos), estados=len(visitados), sequencias=len(sequencias))


def conferir_interface():
    bench, wrapper = 'tb_interface', 'tb_interface.dut'
    core, filtro = wrapper+'.nucleo', wrapper+'.filtro'
    modelo = Nucleo()
    s1 = s2 = nivel = contagem = pulso = divisor = tick = 0
    pulsos, clocks, vistos = 0, 0, set()
    # estado, valor de saida, quantidade acumulada de apertos aceitos.
    pontos = {1:(0,0,0), 2:(1,0,1), 3:(1,0,1), 4:(1,0,1),
              5:(2,1,2), 6:(3,1,3), 7:(3,2,4), 8:(3,0x10,5),
              9:(0,0x13,6), 10:(0,0x13,6), 11:(0,0,6), 12:(2,0x3A5,8)}
    for tempo, antes, atual in ler_vcd(ROOT/'sim/interface.vcd'):
        contexto = f'interface em {tempo/10**6:g} ns'
        if antes.get(bench+'.clk') == 0 and atual[bench+'.clk'] == 1:
            modelo.clock(entradas(antes, core))
            conferir_nucleo(modelo, atual, core, contexto)
            if antes[wrapper+'.reset']:
                s1 = s2 = nivel = contagem = pulso = divisor = tick = 0
            else:
                antigo_s2 = s2
                s1, s2 = antes[wrapper+'.botao_confirmar'], s1
                pulso = 0
                if antes[wrapper+'.tick']:
                    if antigo_s2 == nivel:
                        contagem = 0
                    else:
                        contagem += 1
                        if contagem == 3:
                            nivel, contagem = antigo_s2, 0
                            pulso = int(nivel == 1)
                divisor += 1
                tick = int(divisor == 2)
                if tick:
                    divisor = 0
            for nome, esperado in [('sinc_1',s1), ('sinc_2',s2), ('filtrado',nivel),
                                   ('contagem',contagem), ('pulso',pulso)]:
                conferir(atual[filtro+'.'+nome], esperado, contexto+' filtro '+nome)
            conferir(atual[wrapper+'.tick'], tick, contexto+' tick')
            conferir(atual[wrapper+'.amostragem.n'], divisor, contexto+' divisor')
            if pulso:
                conferir(antes.get(filtro+'.pulso'), 0, contexto+' largura do pulso')
                pulsos += 1
            clocks += 1
        valor = atual[wrapper+'.valor_saida']
        if valor is not None:
            for nome, digito in [('hex2',(valor >> 8) & 3), ('hex1',(valor >> 4) & 15), ('hex0',valor & 15)]:
                conferir(atual[wrapper+'.'+nome], SEGMENTOS[digito], contexto+' '+nome)
        etapa = atual[bench+'.etapa']
        if etapa and etapa != antes.get(bench+'.etapa'):
            vistos.add(etapa)
            s, valor, quantidade = pontos[etapa]
            conferir(atual[wrapper+'.estado'], s, contexto+' estado no ponto')
            conferir(atual[wrapper+'.valor_saida'], valor, contexto+' valor no ponto')
            conferir(pulsos, quantidade, contexto+' contagem de apertos')
    conferir(atual[bench+'.terminou'], 1, 'interface terminou')
    conferir(vistos, set(pontos), 'interface cobertura de pontos')
    return dict(clocks=clocks, pontos=len(vistos), apertos_aceitos=pulsos)


def conferir_operadores():
    bench, amostras, combinacoes = 'tb_operadores', 0, set()
    for tempo, _, atual in ler_vcd(ROOT/'sim/operadores.vcd'):
        contexto = f'operadores em {tempo/10**6:g} ns'
        a, b, mode = (atual[bench+'.'+n] for n in ('a','b','mode'))
        esperado = dict(r_xor=a ^ b, r_rot=girar(a, bool(mode)), r_perm=permutar(a),
                        p_dupla=a, rol_fixo=girar(a, True), volta=a, igual=int(a == b),
                        incremento=((a & 3)+1) % 4, segmentos=SEGMENTOS[a & 15])
        for nome, valor in esperado.items():
            conferir(atual[bench+'.'+nome], valor, contexto+' '+nome)
        combinacoes.add((a,b,mode))
        amostras += 1
    conferir(atual[bench+'.terminou'], 1, 'operadores terminou')
    conferir(len(combinacoes), 1024*4*2, 'cobertura de operadores')
    return dict(amostras=amostras, combinacoes=len(combinacoes))


def conferir_estilo():
    # O verificador fica fora do VHDL mostrado na apresentacao.
    for tb in ROOT.glob('tb_*.vhd'):
        texto = re.sub(r'--[^\n]*', '', tb.read_text())
        proibido = re.search(r'\b(procedure|assert|report|severity)\b|\bwait\s+until\b', texto, re.I)
        if proibido:
            raise Falha(f'{tb.name}: construcao proibida no testbench: {proibido[0]}')


def main():
    conferir_estilo()
    esperados = json.loads((ROOT/'testes/esperado_nucleo.json').read_text())
    resultados = {
        'nucleo': conferir_bancada_nucleo('criptografia.vcd', 'tb_criptografia', esperados),
        'interface': conferir_interface(),
        'operadores': conferir_operadores(),
        'sequencias': conferir_bancada_nucleo('sequencias.vcd', 'tb_sequencias'),
    }
    (ROOT/'sim/resultados.json').write_text(json.dumps(resultados, ensure_ascii=False, indent=2)+'\n')
    for bancada, resultado in resultados.items():
        print(f'OK {bancada}: '+', '.join(f'{chave}={valor}' for chave, valor in resultado.items()))


if __name__ == '__main__':
    try:
        main()
    except (Falha, KeyError, OSError, ValueError) as erro:
        print(f'FALHOU: {erro}', file=sys.stderr)
        sys.exit(1)
