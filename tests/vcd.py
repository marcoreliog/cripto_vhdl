"""Leitor VCD em streaming: agrupa deltas do mesmo instante antes de observar."""
import re


class VCD:
    def __init__(self, caminho):
        self.caminho = caminho
        self.sinais = {}
        self.escala_fs = None

    def grupos(self):
        with self.caminho.open(encoding="ascii") as arquivo:
            escopos = []
            cabecalho = ""
            for linha in arquivo:
                campos = linha.split()
                cabecalho += linha
                if linha.startswith("$scope"):
                    escopos.append(campos[2])
                elif linha.startswith("$upscope"):
                    escopos.pop()
                elif linha.startswith("$var"):
                    nome = re.sub(r"\[.*\]$", "", campos[4])
                    self.sinais[".".join(escopos + [nome])] = campos[3]
                elif linha.startswith("$enddefinitions"):
                    break
            escala = re.search(r"\$timescale\s+(\d+)\s*(fs|ps|ns|us|ms|s)", cabecalho)
            if not escala:
                raise ValueError("VCD sem unidade de tempo")
            self.escala_fs = int(escala[1]) * {
                "fs": 1, "ps": 1000, "ns": 1000000, "us": 10**9,
                "ms": 10**12, "s": 10**15}[escala[2]]
            valores, tempo = {}, 0
            for linha in arquivo:
                linha = linha.strip()
                if not linha:
                    continue
                if linha[0] == '#':
                    novo = int(linha[1:])
                    if novo != tempo:
                        yield tempo, valores.copy()
                        tempo = novo
                elif linha[0] in "01xXzZuUwWhHlL-":
                    valores[linha[1:]] = linha[0].lower()
                elif linha[0] in "bB":
                    valor, identificador = linha[1:].split()
                    valores[identificador] = valor.lower()
            yield tempo, valores.copy()

    def inteiro(self, valores, nome):
        if nome not in self.sinais:
            raise ValueError(f"Sinal ausente: {nome}")
        valor = valores.get(self.sinais[nome], "u")
        if any(c not in "01" for c in valor):
            raise ValueError(f"Sinal {nome} indefinido: {valor}")
        return int(valor, 2)
