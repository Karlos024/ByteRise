if (instance_number(obj_Cenario_3) > 1) {
    instance_destroy();
    exit;
}
persistent = true;
depth = 50;   
//CENÁRIO
altura_mundo = 1280;
altura_tela = 640;
scroll_max = altura_mundo - altura_tela;

area_topo = 64;
area_base = 576;
if (!variable_global_exists("cam3_y")) global.cam3_y = 0;
global.cam3_moveu = false;   
arrastando = false;
moveu = false;
toque_y0 = 0;
cam_y0 = 0;
vel = 0;
buff_clique_tempo = 0;
//SPRITES
ator_protagonista = noone;
ator_bancada = spr_Balcao_3;
ator_montador = spr_psn_Montador_3;
montador_frame = [[0, 0, 0], [0, 0, 0], [0, 0, 0]];
montador_quadros = sprite_get_number(ator_montador);
ator_exportador = noone;
ator_encomendador = noone;
ator_dispositivo = [spr_up_Celular, spr_up_Tablet, spr_up_Notebook];
ator_caixa = [spr_f3_caixa_celular, spr_f3_caixa_tablet, spr_f3_caixa_notebook];           
ator_veiculo = [noone, noone, noone, noone];  
//POSIÇÕES
mesa_x = 180;  mesa_y = 215;
bancada_x = [90, 180, 270];   
bancada_y = [330, 430, 530];  
bancada_w = 64;  bancada_h = 34;
esteira_x = 94;  esteira_y = 705;
esteira_auto_x = 180;  esteira_auto_y = 708;
exportador_x = 94;    exportador_y = 618;
encomendador_x = 94;  encomendador_y = 815;
vaga_x = [62, 298, 62, 298];
vaga_y = [905, 905, 962, 962];

corredores_x = [316];         
exportador_parada_dy = 62;    
//PROCESSOS
capacidade_saida = 3;      
exp_duracao = 0.5;         
esteira_duracao = 0.4;     
capacidade_caixas = 15;    
esteira_lote = [1, 2, 4, 8];   
enc_duracao = 0.5;         
viagem_duracao = 1.0;      
veiculo_saida_x = 80;      
veiculo_espera = 5;        
veiculo_capacidade = [4, 6, 8, 10];   
//GANHOS
moeda_dispositivo = [
    [3600, 3600, 4400, 4400, 4400, 5400, 5400, 6600, 6600, 6600, 8000, 8000, 9600, 9600, 12000],
    [5000, 5000, 6000, 6000, 6000, 7200, 7200, 8600, 8600, 8600, 10200, 10200, 12200, 12200, 15000],
    [7000, 7000, 8400, 8400, 8400, 10000, 10000, 11800, 11800, 11800, 13800, 13800, 16400, 16400, 20000]
];
xp_dispositivo = [
    [350, 420, 420, 500, 500, 500, 590, 590, 690, 690, 690, 745, 745, 800, 800],
    [450, 530, 530, 620, 620, 620, 720, 720, 830, 830, 830, 880, 880, 950, 950],
    [600, 700, 700, 820, 820, 820, 950, 950, 1000, 1000, 1000, 1120, 1120, 1260, 1260]
];
nome_global_tipo = ["celular", "tablet", "notebook"];
//MONTADORES

if (!variable_global_exists("f3_inicializado") || !global.f3_inicializado) {
    global.f3_prog = [[0, 0, 0], [0, 0, 0], [0, 0, 0]];      
    global.f3_prontos = [[0, 0, 0], [0, 0, 0], [0, 0, 0]];   
}
//EXPORTADORES E ESTEIRA

if (!variable_global_exists("f3_inicializado") || !global.f3_inicializado) {
    global.f3_exp = [];
    for (var ie = 0; ie < 2; ie++) {
        array_push(global.f3_exp, {
            estado: 0, p: 0, tipo: -1, banc: 0, qtd: 0,
            x: exportador_x + ie * 40, y: exportador_y,
            home_x: exportador_x + ie * 40, home_y: exportador_y,
            rota: []
        });
    }
    
    global.f3_esteira = { fila: [], saida: [], prog: 0, entrada_tempo: 0 };
}
//ENCOMENDADORES

if (!variable_global_exists("f3_inicializado") || !global.f3_inicializado) {
    global.f3_enc = [];
    for (var ic = 0; ic < 2; ic++) {
        array_push(global.f3_enc, {
            estado: 0, p: 0, qtd: 0, carga: [], veic: 0,
            x: encomendador_x + ic * 40, y: encomendador_y,
            x0: 0, y0: 0, x1: 0, y1: 0,
            home_x: encomendador_x + ic * 40, home_y: encomendador_y
        });
    }
}
//VEÍCULOS


if (!variable_global_exists("f3_inicializado") || !global.f3_inicializado) {
    global.f3_veic = [];
    for (var iv = 0; iv < 4; iv++) {
        array_push(global.f3_veic, { carga: [], reservado: 0, estado: 0, p: 0, espera: 0 });
    }
}

cor_tipo = [make_color_rgb(120, 170, 255), make_color_rgb(120, 220, 140), make_color_rgb(255, 200, 90)];

veiculo_nome = ["SAVERO", "SAV+C", "VAN", "CAMINH."];
veiculo_qtd = [1, 2, 3, 4];
veiculo_w = [52, 56, 62, 68];
veiculo_h = [30, 34, 38, 46];
veiculo_cor = [make_color_rgb(200, 90, 90), make_color_rgb(210, 140, 70), make_color_rgb(200, 200, 90), make_color_rgb(160, 110, 200)];

multiplicador_pagamento = 1.0;

valor_do_clique = function(_fase) {
    return 0.05;
};

nivel_up = function(_nome) {
    return variable_global_exists(_nome) ? variable_global_get(_nome) : 0;
};

bancadas_do_nivel = function(_n) {
    if (_n >= 10) return 3;
    if (_n >= 5) return 2;
    if (_n >= 1) return 1;
    return 0;
};

exportadores_ativos = function() {
    return (nivel_up("funcionario_3") >= 2) ? 2 : 1;
};

velocidade_cafe = function() {
    switch (nivel_up("cafe")) {
        case 1: return 1 / 10;
        case 2: return 1 / 7;
        case 3: return 1 / 5;
    }
    return 0;
};

faixa_do_y = function(_y) {
    var _f = 0;
    for (var i = 0; i < 3; i++) {
        if (_y > bancada_y[i] + 41) _f++;
    }
    return _f;
};

montar_rota = function(_x0, _y0, _x1, _y1) {
    var _rota = [[_x0, _y0]];
    if (faixa_do_y(_y0) != faixa_do_y(_y1)) {
        var _xc = corredores_x[0];
        var _melhor = abs(_x0 - _xc) + abs(_x1 - _xc);
        for (var i = 1; i < array_length(corredores_x); i++) {
            var _d = abs(_x0 - corredores_x[i]) + abs(_x1 - corredores_x[i]);
            if (_d < _melhor) {
                _melhor = _d;
                _xc = corredores_x[i];
            }
        }
        array_push(_rota, [_xc, _y0]);
        array_push(_rota, [_xc, _y1]);
    }
    array_push(_rota, [_x1, _y1]);
    return _rota;
};

ponto_na_rota = function(_rota, _p) {
    var _n = array_length(_rota);
    var _total = 0;
    for (var i = 1; i < _n; i++) {
        _total += point_distance(_rota[i - 1][0], _rota[i - 1][1], _rota[i][0], _rota[i][1]);
    }
    var _resta = clamp(_p, 0, 1) * _total;
    for (var j = 1; j < _n; j++) {
        var _seg = point_distance(_rota[j - 1][0], _rota[j - 1][1], _rota[j][0], _rota[j][1]);
        if (_resta <= _seg || j == _n - 1) {
            var _t = (_seg > 0) ? clamp(_resta / _seg, 0, 1) : 1;
            return {
                x: lerp(_rota[j - 1][0], _rota[j][0], _t),
                y: lerp(_rota[j - 1][1], _rota[j][1], _t)
            };
        }
        _resta -= _seg;
    }
    return { x: _rota[_n - 1][0], y: _rota[_n - 1][1] };
};

rota_do_veiculo = function(_v) {
    var _sx = vaga_x[_v];
    var _sy = vaga_y[_v];
    var _fx = (_sx < 180) ? -veiculo_saida_x : 360 + veiculo_saida_x;
    return [[_sx, _sy], [_fx, _sy]];
};

angulo_na_rota = function(_rota, _p, _d) {
    var _a = ponto_na_rota(_rota, clamp(_p - _d * 0.02, 0, 1));
    var _b = ponto_na_rota(_rota, clamp(_p + _d * 0.02, 0, 1));
    return point_direction(_a.x, _a.y, _b.x, _b.y);
};

marcador = function(_x, _y, _w, _h, _cor, _txt) {
    draw_set_alpha(1);
    draw_set_color(_cor);
    draw_rectangle(_x - _w / 2, _y - _h / 2, _x + _w / 2, _y + _h / 2, false);
    draw_set_color(c_black);
    draw_rectangle(_x - _w / 2, _y - _h / 2, _x + _w / 2, _y + _h / 2, true);
    if (_txt != "") {
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_text(_x, _y, _txt);
    }
};

marcador_rot = function(_x, _y, _w, _h, _ang, _cor, _txt) {
    var _lx = [-_w / 2, _w / 2, _w / 2, -_w / 2];
    var _ly = [-_h / 2, -_h / 2, _h / 2, _h / 2];
    var _px = [0, 0, 0, 0];
    var _py = [0, 0, 0, 0];
    for (var i = 0; i < 4; i++) {
        _px[i] = _x + lengthdir_x(_lx[i], _ang) + lengthdir_x(_ly[i], _ang - 90);
        _py[i] = _y + lengthdir_y(_lx[i], _ang) + lengthdir_y(_ly[i], _ang - 90);
    }
    draw_set_alpha(1);
    draw_set_color(_cor);
    draw_primitive_begin(pr_trianglefan);
    for (var i = 0; i < 4; i++) draw_vertex(_px[i], _py[i]);
    draw_primitive_end();
    draw_set_color(c_black);
    draw_primitive_begin(pr_linestrip);
    for (var i = 0; i < 5; i++) draw_vertex(_px[i mod 4], _py[i mod 4]);
    draw_primitive_end();
    if (_txt != "") {
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_text(_x, _y, _txt);
    }
};

desenhar_ator = function(_spr, _x, _y, _w, _h, _cor, _txt, _ang) {
    if (is_undefined(_ang)) _ang = 0;
    if (_spr != noone && sprite_exists(_spr)) {
        draw_set_alpha(1);
        draw_set_color(c_white);
        draw_sprite_ext(_spr, 0, _x, _y, 1, 1, _ang, c_white, 1);
    } else {
        marcador_rot(_x, _y, _w, _h, _ang, _cor, _txt);
    }
};

desenhar_mostrador = function(_x, _y, _p, _raio) {
    
    draw_set_color(c_black);
    draw_circle(_x, _y, _raio * 20 / 14, false);
    
    draw_set_color(make_color_rgb(60, 60, 60));
    draw_circle(_x, _y, _raio, false);
    
    var progresso_limpo = clamp(floor(_p * 100), 0, 100);
    
    if (progresso_limpo > 0) {
        if (progresso_limpo < 100) {
            draw_set_color(c_red);
        } else {
            draw_set_color(c_lime);
        }
        
        draw_primitive_begin(pr_trianglefan);
        draw_vertex(_x, _y);
        for (var k = 0; k <= (progresso_limpo / 100) * 360; k += 2) {
            draw_vertex(_x + lengthdir_x(_raio, k - 90), _y + lengthdir_y(_raio, k - 90));
        }
        draw_primitive_end();
    }
    draw_set_color(c_white);
};
//ANIMAÇÕES
rotina_frame = 0;
rotina_tempo = 0;
rotina_batendo = false;
rotina_duracao = [80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 60, 60, 60, 60, 60, 70, 90, 70, 40, 40, 110, 70, 60, 60, 60, 60, 60, 70, 90, 70, 40, 40, 110, 70, 60, 60, 60, 60, 60, 70, 90, 70, 40, 40, 110, 70, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80];
emp_sprites = [spr_f3_emp_frente, spr_f3_emp_costas, spr_f3_emp_perfil];
palete_sprites = [spr_f3_palete_celular, spr_f3_palete_tablet, spr_f3_palete_notebook];
enc_sprites = [[spr_f3_enc_frente_1, spr_f3_enc_frente_2, spr_f3_enc_frente_3, spr_f3_enc_frente_4, spr_f3_enc_frente_5, spr_f3_enc_frente_6, spr_f3_enc_frente_7, spr_f3_enc_frente_8, spr_f3_enc_frente_9], [spr_f3_enc_costas_1, spr_f3_enc_costas_2, spr_f3_enc_costas_3, spr_f3_enc_costas_4, spr_f3_enc_costas_5, spr_f3_enc_costas_6, spr_f3_enc_costas_7, spr_f3_enc_costas_8, spr_f3_enc_costas_9], [spr_f3_enc_perfil_1, spr_f3_enc_perfil_2, spr_f3_enc_perfil_3, spr_f3_enc_perfil_4, spr_f3_enc_perfil_5, spr_f3_enc_perfil_6, spr_f3_enc_perfil_7, spr_f3_enc_perfil_8, spr_f3_enc_perfil_9]];

frota_sprites = [spr_f3_saveiro_carga, spr_f3_saveiro_cacamba_carga, spr_f3_van_carga, spr_f3_caminhao_carga];

//MOVIMENTAÇÃO
atualizar_visual = function(_a) {
    if (!variable_struct_exists(_a, "visual_x")) {
        _a.visual_x = _a.x;
        _a.visual_y = _a.y;
        _a.visual_dir = 0;
        _a.visual_lado = 1;
        _a.visual_frame = 0;
    }
    var _dx = _a.x - _a.visual_x;
    var _dy = _a.y - _a.visual_y;
    var _dist = point_distance(0, 0, _dx, _dy);
    if (_dist > 0) {
        if (abs(_dx) > abs(_dy)) {
            _a.visual_dir = 2;
            _a.visual_lado = (_dx < 0) ? 1 : -1;
        } else {
            _a.visual_dir = (_dy > 0) ? 0 : 1;
            _a.visual_lado = 1;
        }
        _a.visual_frame = (_a.visual_frame + _dist / 4) mod 8;
    } else {
        _a.visual_frame = 0;
    }
    _a.visual_x = _a.x;
    _a.visual_y = _a.y;
};

for (var i = 0; i < 2; i++) {
    atualizar_visual(global.f3_exp[i]);
    atualizar_visual(global.f3_enc[i]);
}


if (!variable_struct_exists(global.f3_esteira, "transito")) global.f3_esteira.transito = [];
if (!variable_struct_exists(global.f3_esteira, "frame")) global.f3_esteira.frame = 0;

//ROTA DA ESTEIRA
rota_da_esteira = function(_v, _da_saida) {
    var _automatica = (nivel_up("funcionario_3") >= 3 || _v >= 0);
    var _spr = _automatica ? spr_f3_esteira_gigante : spr_Esteira;
    var _ox = (_automatica ? esteira_auto_x : esteira_x) - sprite_get_xoffset(_spr);
    var _oy = (_automatica ? esteira_auto_y : esteira_y) - sprite_get_yoffset(_spr);
    var _rota;
    if (!_automatica) {
        _rota = [[35, 18], [35, 106]];
    } else {
        _rota = [[94, _da_saida ? 717 : 632], [94, 759]];
        if (_v >= 0) {
            
            var _saidas = [832, 897];
            var _sy = _saidas[0];
            if (abs(_saidas[1] + _oy - vaga_y[_v]) < abs(_sy + _oy - vaga_y[_v])) _sy = _saidas[1];
            var _sx = (vaga_x[_v] < esteira_auto_x) ? 106 : 252;
            array_push(_rota, [184, 759]);
            array_push(_rota, [184, _sy]);
            array_push(_rota, [_sx, _sy]);
        }
    }
    
    for (var i = 0; i < array_length(_rota); i++) {
        _rota[i][0] += _ox;
        _rota[i][1] += _oy;
    }
    return _rota;
};

//DISTÂNCIA DA ROTA
comprimento_rota = function(_rota) {
    var _total = 0;
    for (var i = 1; i < array_length(_rota); i++) {
        _total += point_distance(_rota[i - 1][0], _rota[i - 1][1], _rota[i][0], _rota[i][1]);
    }
    return max(1, _total);
};

//TUTORIAL
if (!variable_global_exists("f3_total_montados")) global.f3_total_montados = 0;
if (!variable_global_exists("f3_total_entregues")) global.f3_total_entregues = 0;
if (!variable_global_exists("tutorial_f3_concluido")) global.tutorial_f3_concluido = false;
global.f3_inicializado = true;
global.fase_atual = 3;
if (!variable_struct_exists(global.f3_esteira, "entrada_tempo")) global.f3_esteira.entrada_tempo = 0;
if (!instance_exists(obj_Tutorial_interativo_3)) instance_create_depth(0, 0, -15000, obj_Tutorial_interativo_3);
if (!global.tutorial_f3_concluido && !f3_tutorial_ativo()) f3_tutorial_iniciar();
