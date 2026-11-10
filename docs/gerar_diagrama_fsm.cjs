const fs = require('fs');
const path = require('path');
const os = require('os');
const crypto = require('crypto');
const assert = require('assert');

function findTeros() {
    if (process.env.TEROSHDL_EXTENSION) return process.env.TEROSHDL_EXTENSION;
    for (const folder of ['.vscode/extensions', '.vscode-server/extensions']) {
        const base = path.join(os.homedir(), folder);
        if (!fs.existsSync(base)) continue;
        const extensions = fs.readdirSync(base)
            .filter(name => name.startsWith('teros-technology.teroshdl-'))
            .sort((a, b) => b.localeCompare(a, undefined, { numeric: true }));
        if (extensions.length) return path.join(base, extensions[0]);
    }
    throw new Error('Informe TEROSHDL_EXTENSION com a pasta da extensao TerosHDL.');
}

const escape = value => String(value).replace(/[&<>"']/g, char => ({
    '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&apos;'
})[char]);

async function main() {
    const root = path.dirname(__dirname);
    const source = fs.readFileSync(path.join(root, 'controller.vhd'), 'utf8');
    const { Paser_fsm_vhdl } = require(path.join(findTeros(), 'out/colibri/parser/ts_vhdl/fsm.js'));
    const parser = new Paser_fsm_vhdl('');
    await parser.init();
    assert(parser.loaded_wasm, 'O parser do TerosHDL nao iniciou.');
    const machines = parser.get_process(parser.parser.parse(source))
        .flatMap(process => parser.get_process_info(process))
        .filter(machine => parser.check_stm(machine));
    assert.strictEqual(machines.length, 1, 'Esperada uma unica FSM.');
    const machine = machines[0];

    const nodes = [
        ['S0', 830, 122, 380, 86, 'neutral', 'RESET', 'Limpa dados, VAL e acerto'],
        ['S1', 830, 270, 380, 86, 'neutral', 'MENU', '0: cifrar  |  1: decifrar'],
        ['S2', 365, 550, 340, 86, 'encrypt', 'INSERIR VALOR', 'V ← SW   ·   X ← SW'],
        ['S3', 365, 690, 340, 86, 'encrypt', 'CHAVE DA CIFRAGEM', 'K ← SW'],
        ['S4', 365, 850, 340, 100, 'encrypt', 'SELECIONAR OPERAÇÃO', 'Aguarda código + confirmar'],
        ['S5', 130, 1110, 230, 86, 'encrypt', 'PERMUTAÇÃO', 'X ← P(X)'],
        ['S6', 420, 1110, 230, 86, 'encrypt', 'ROL3', 'X ← ROL3(X)'],
        ['S7', 710, 1110, 230, 86, 'encrypt', 'XOR', 'X ← X xor K'],
        ['S8', 365, 1330, 340, 86, 'encrypt', 'SALVAR CIFRADO', 'C ← X   ·   VAL ← 1'],
        ['S9', 1335, 550, 340, 86, 'decrypt', 'PREPARAR TENTATIVA', 'X ← C   ·   acerto ← 0'],
        ['S10', 1335, 850, 340, 100, 'decrypt', 'SELECIONAR OPERAÇÃO', 'Aguarda código + confirmar'],
        ['S11', 1100, 1020, 230, 86, 'decrypt', 'PALPITE XOR', 'K ← SW ao confirmar'],
        ['S12', 1100, 1160, 230, 86, 'decrypt', 'XOR', 'X ← X xor K'],
        ['S13', 1390, 1160, 230, 86, 'decrypt', 'ROR3', 'X ← ROR3(X)'],
        ['S14', 1680, 1160, 230, 86, 'decrypt', 'PERMUTAÇÃO', 'X ← P(X)'],
        ['S15', 1335, 1330, 340, 86, 'decrypt', 'COMPARAR', 'acerto ← (X = V)'],
        ['S16', 1335, 1490, 340, 86, 'decrypt', 'RESULTADO', 't: acerto   |   F: erro'],
    ];

    const routes = [
        ['S0', 'S1', 'M 1020 208 V 270', 'automático', 1098, 243, 'auto'],
        ['S1', 'S2', 'M 900 356 V 400 H 535 V 550', 'modo = 0 + confirmar', 685, 385, 'encrypt'],
        ['S1', 'S9', 'M 1140 356 V 400 H 1505 V 550', 'modo = 1 + confirmar + VAL = 1', 1380, 385, 'decrypt'],
        ['S2', 'S3', 'M 535 636 V 690', 'confirmar', 605, 666, 'encrypt'],
        ['S3', 'S4', 'M 535 776 V 850', 'confirmar', 605, 818, 'encrypt'],
        ['S4', 'S5', 'M 445 950 V 990 H 245 V 1110', '11', 245, 1060, 'encrypt'],
        ['S4', 'S6', 'M 535 950 V 1110', '10', 570, 1045, 'encrypt'],
        ['S4', 'S7', 'M 625 950 V 990 H 825 V 1110', '01', 825, 1060, 'encrypt'],
        ['S4', 'S8', 'M 705 875 H 950 V 1373 H 705', '00 + confirmar', 825, 858, 'encrypt'],
        ['S5', 'S4', 'M 245 1196 V 1265 H 110 V 900 H 365', '', 0, 0, 'auto'],
        ['S6', 'S4', 'M 535 1196 V 1265 H 110 V 900 H 365', '', 0, 0, 'auto'],
        ['S7', 'S4', 'M 825 1196 V 1265 H 110 V 900 H 365', 'volta a S4 após cada operação', 525, 1248, 'auto'],
        ['S8', 'S1', 'M 535 1416 V 1470 H 35 V 313 H 830', 'volta ao menu; preserva o desafio', 405, 295, 'auto'],
        ['S9', 'S10', 'M 1505 636 V 850', 'automático', 1580, 745, 'auto'],
        ['S10', 'S11', 'M 1415 950 V 985 H 1215 V 1020', '01', 1300, 972, 'decrypt'],
        ['S10', 'S13', 'M 1505 950 V 1160', '10', 1540, 1070, 'decrypt'],
        ['S10', 'S14', 'M 1595 950 V 985 H 1795 V 1160', '11', 1795, 1088, 'decrypt'],
        ['S10', 'S15', 'M 1675 875 H 1920 V 1373 H 1675', '00 + confirmar', 1800, 858, 'decrypt'],
        ['S11', 'S12', 'M 1215 1106 V 1160', 'novo confirmar', 1300, 1140, 'decrypt'],
        ['S12', 'S10', 'M 1215 1246 V 1290 H 1080 V 900 H 1335', '', 0, 0, 'auto'],
        ['S13', 'S10', 'M 1505 1246 V 1290 H 1080 V 900 H 1335', '', 0, 0, 'auto'],
        ['S14', 'S10', 'M 1795 1246 V 1290 H 1080 V 900 H 1335', 'volta a S10 após cada operação', 1535, 1273, 'auto'],
        ['S15', 'S16', 'M 1505 1416 V 1490', 'automático', 1580, 1458, 'auto'],
        ['S16', 'S9', 'M 1675 1533 H 2000 V 593 H 1675', 'tentar_novamente', 1825, 576, 'decrypt'],
    ];


    assert.deepStrictEqual(machine.states.map(state => state.name).sort(), nodes.map(node => node[0]).sort());
    const actual = machine.states.flatMap(state => state.transitions.map(transition =>
        `${state.name}->${transition.destination}`)).sort();
    assert.deepStrictEqual(actual, routes.map(route => `${route[0]}->${route[1]}`).sort());
    const conditions = new Map(machine.states.flatMap(state => state.transitions.map(transition =>
        [`${state.name}->${transition.destination}`, transition.condition])));

    const colors = { neutral: '#475569', encrypt: '#2563eb', decrypt: '#047857', auto: '#64748b' };
    const parts = [];
    const text = (x, y, value, size = 18, fill = '#334155', anchor = 'start', weight = 400) =>
        parts.push(`<text x="${x}" y="${y}" font-size="${size}" fill="${fill}" text-anchor="${anchor}" font-weight="${weight}">${escape(value)}</text>`);
    const rect = (x, y, width, height, fill, stroke = 'none', radius = 14) =>
        parts.push(`<rect x="${x}" y="${y}" width="${width}" height="${height}" rx="${radius}" fill="${fill}" stroke="${stroke}" stroke-width="2"/>`);

    parts.push('<svg xmlns="http://www.w3.org/2000/svg" width="2040" height="1780" viewBox="0 0 2040 1780" font-family="DejaVu Sans, sans-serif" role="img" aria-labelledby="title description">');
    parts.push('<title id="title">Controladora: cifragem à esquerda e decifragem à direita</title>');
    parts.push('<desc id="description">FSM com 17 estados e 24 transições. Reset e menu acima; fases separadas em duas colunas. Códigos exigem confirmação. Setas tracejadas são automáticas.</desc>');
    parts.push(`<metadata>${escape(JSON.stringify({ source: 'controller.vhd', sha256: crypto.createHash('sha256').update(source).digest('hex'), transitions: actual }))}</metadata>`);
    parts.push('<defs>');
    for (const [name, color] of Object.entries(colors)) {
        parts.push(`<marker id="arrow-${name}" markerWidth="10" markerHeight="10" refX="9" refY="5" orient="auto" markerUnits="userSpaceOnUse"><path d="M 0 0 L 10 5 L 0 10 Z" fill="${color}"/></marker>`);
    }
    parts.push('</defs>');
    rect(0, 0, 2040, 1780, '#f8fafc', 'none', 0);
    text(80, 65, 'CONTROLADORA · FSM DE 10 BITS', 32, '#0f172a', 'start', 700);
    text(80, 98, 'Fluxos separados por fase · códigos curtos nas setas · estados e transições conferidos com o VHDL', 19);
    rect(80, 430, 910, 1170, '#eff6ff', '#bfdbfe', 22);
    rect(1050, 430, 910, 1170, '#ecfdf5', '#a7f3d0', 22);
    text(120, 476, 'CIFRAGEM', 28, colors.encrypt, 'start', 700);
    text(120, 509, 'S2–S8 · cria e salva o desafio', 18, colors.encrypt);
    text(1090, 476, 'DECIFRAGEM', 28, colors.decrypt, 'start', 700);
    text(1090, 509, 'S9–S16 · tenta recuperar V', 18, colors.decrypt);

    const returnLegs = new Map([
        ['S5->S4', 'M 245 1196 V 1265'], ['S6->S4', 'M 535 1196 V 1265'],
        ['S7->S4', 'M 825 1196 V 1265'], ['S12->S10', 'M 1215 1246 V 1290'],
        ['S13->S10', 'M 1505 1246 V 1290'], ['S14->S10', 'M 1795 1246 V 1290'],
    ]);
    for (const [from, to, route, label, x, y, style] of routes) {
        const key = `${from}->${to}`;
        const visibleRoute = returnLegs.get(key) || route;
        const marker = returnLegs.has(key) ? '' : ` marker-end="url(#arrow-${style})"`;
        parts.push(`<g data-source="${from}" data-target="${to}"><title>${escape(`${from} → ${to}: ${conditions.get(`${from}->${to}`) || 'automático'}`)}</title>`);
        parts.push(`<path d="${visibleRoute}" fill="none" stroke="${colors[style]}" stroke-width="2.5" stroke-linejoin="round"${style === 'auto' ? ' stroke-dasharray="8 6"' : ''}${marker}/></g>`);
    }

    for (const route of ['M 825 1265 H 110 V 900 H 365', 'M 1795 1290 H 1080 V 900 H 1335']) {
        parts.push(`<path d="${route}" fill="none" stroke="${colors.auto}" stroke-width="2.5" stroke-dasharray="8 6" stroke-linejoin="round" marker-end="url(#arrow-auto)"/>`);
    }
    for (const [, , , label, x, y, style] of routes) {
        if (!label) continue;
        const width = label.length * 9.2 + 20;
        rect(x - width / 2, y - 20, width, 28, '#ffffff', 'none', 7);
        text(x, y, label, 16, colors[style], 'middle', 500);
    }

    for (const [id, x, y, width, height, theme, title, action] of nodes) {
        parts.push(`<g id="${id}"><title>${escape(`${id} — ${title}: ${action}`)}</title>`);
        rect(x, y, width, height, '#ffffff', colors[theme]);
        rect(x + 16, y + 17, 49, 29, colors[theme], 'none', 7);
        text(x + 40.5, y + 38, id, 17, '#ffffff', 'middle', 700);
        text(x + 80, y + 37, title, width < 300 ? 16 : 18, '#0f172a', 'start', 700);
        text(x + 20, y + 68, action, width < 300 ? 16 : 18);
        parts.push('</g>');
    }
    text(1215, 730, 'V e C ficam preservados', 17, colors.decrypt, 'middle');
    text(1215, 758, 'durante as tentativas', 17, colors.decrypt, 'middle');
    rect(145, 1510, 780, 65, '#ffffff', '#dbeafe', 10);
    text(170, 1538, 'Pode encerrar com zero operações. Pode repetir qualquer operação.', 17);
    text(170, 1563, 'O retorno à seleção ocorre também após a terceira, quarta e seguintes.', 17);
    text(80, 1650, 'CÓDIGOS:  00 encerrar   ·   01 XOR   ·   10 rotação   ·   11 permutação', 20, '#0f172a', 'start', 600);
    text(80, 1684, 'Todo código exige novo confirmar. Sem comando, o estado de espera permanece. Tracejado = ação automática.', 19);
    text(80, 1720, 'RESET global: qualquer estado → S0. Repetir em S16: tentar_novamente; o mapeamento físico continua pendente.', 19);
    parts.push('</svg>');

    const svg = path.join(__dirname, 'controladora_organizada.svg');
    fs.writeFileSync(svg, parts.join('\n') + '\n');
    console.log('OK: 17 estados e 24 transicoes; cifragem a esquerda e decifragem a direita.');
    console.log(svg);
}

main().catch(error => { console.error(error); process.exitCode = 1; });
