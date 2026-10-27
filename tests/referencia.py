"""Modelo de inteiros de 10 bits; nao le sinais internos para calcular o esperado."""
MASK = (1 << 10) - 1


def rol3(x):
    x &= MASK
    return ((x << 3) | (x >> 7)) & MASK


def ror3(x):
    x &= MASK
    return ((x >> 3) | (x << 7)) & MASK


def permuta(x):
    return (((x & 0x155) << 1) | ((x & 0x2AA) >> 1)) & MASK


def cifra(mensagem, chave):
    return permuta(rol3((mensagem ^ chave) & MASK))


def decifra(cifrado, chave):
    return (ror3(permuta(cifrado)) ^ chave) & MASK


def controles(estado, confirmar):
    """ld_k, ld_x, ld_c, sel_op, sel_saida, leds; defaults definidos."""
    tabela = {
        0: (0, 0, 0, 0, 0, 1),
        1: (confirmar, 0, 0, 0, 0, 1),
        2: (0, confirmar, 0, 0, 0, 1),
        3: (0, 1, 0, 1, 0, 2),
        4: (0, 1, 0, 2, 0, 2),
        5: (0, 1, 1, 3, 0, 2),
        6: (0, 0, 0, 0, 1, 4),
        7: (0, 1, 0, 3, 1, 2),
        8: (0, 1, 0, 4, 1, 2),
        9: (0, 1, 0, 1, 1, 2),
        10: (0, 0, 0, 0, 0, 8),
    }
    return tabela[estado]


def transicao(estado, confirmar, escolha):
    if estado in (0, 1, 2):
        return estado + confirmar
    if estado == 6:
        return 7 if confirmar and escolha else 6
    if estado == 10:
        return 10
    return estado + 1


def operacao(sel, sw, x, k):
    return {0: sw, 1: x ^ k, 2: rol3(x), 3: permuta(x), 4: ror3(x)}.get(sel, x)


def segmentos(digito):
    # Referencia por nomes geometricos; o RTL usa constantes hexadecimais.
    acesos = ("abcdef", "bc", "abdeg", "abcdg", "bcfg", "acdfg", "acdefg",
              "abc", "abcdefg", "abcdfg", "abcefg", "cdefg", "adef", "bcdeg",
              "adefg", "aefg")
    return 0xFF ^ sum(1 << (ord(c) - ord('a')) for c in acesos[digito])
