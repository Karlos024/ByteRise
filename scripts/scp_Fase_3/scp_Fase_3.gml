//ESTADO DA FÁBRICA
function f3_limpar_producao() {
    if (instance_exists(obj_Cenario_3)) instance_destroy(obj_Cenario_3);
    if (instance_exists(obj_Tutorial_interativo_3)) instance_destroy(obj_Tutorial_interativo_3);
    global.f3_inicializado = false;
    global.cam3_y = 0;
    global.cam3_moveu = false;
    global.f3_total_montados = 0;
    global.f3_total_entregues = 0;
}

function f3_tutorial_ativo() {
    return instance_exists(obj_Tutorial_interativo_3) && obj_Tutorial_interativo_3.ativo;
}

function f3_tutorial_permite(_objeto) {
    if (!f3_tutorial_ativo()) return true;
    var _t = instance_find(obj_Tutorial_interativo_3, 0);
    return _objeto == _t.alvo_objeto();
}

function f3_tutorial_iniciar() {
    if (!instance_exists(obj_Tutorial_interativo_3)) {
        instance_create_depth(0, 0, -15000, obj_Tutorial_interativo_3);
    }
    with (obj_Tutorial_interativo_3) {
        ativo = true;
        etapa = 0;
        espera = 0.2;
    }
    global.cam3_y = 0;
}

//SALVAMENTO DA FÁBRICA
function f3_exportar_estado() {
    if (!variable_global_exists("f3_inicializado") || !global.f3_inicializado) return "";
    return json_stringify({
        versao: 1, prog: global.f3_prog, prontos: global.f3_prontos,
        exp: global.f3_exp, enc: global.f3_enc, esteira: global.f3_esteira,
        veic: global.f3_veic, montados: global.f3_total_montados,
        entregues: global.f3_total_entregues
    });
}

function f3_restaurar_estado(_texto) {
    if (_texto == "") return;
    try {
        var _s = json_parse(_texto);
        if (!is_struct(_s) || !variable_struct_exists(_s, "versao") || _s.versao != 1) return;
        var _campos = ["prog", "prontos", "exp", "enc", "veic"];
        var _tamanhos = [3, 3, 2, 2, 4];
        for (var _i = 0; _i < array_length(_campos); _i++) {
            if (!variable_struct_exists(_s, _campos[_i])) return;
            var _a = variable_struct_get(_s, _campos[_i]);
            if (!is_array(_a) || array_length(_a) != _tamanhos[_i]) return;
        }
        for (var _t = 0; _t < 3; _t++) {
            if (!is_array(_s.prog[_t]) || array_length(_s.prog[_t]) != 3) return;
            if (!is_array(_s.prontos[_t]) || array_length(_s.prontos[_t]) != 3) return;
            for (var _b = 0; _b < 3; _b++) {
                if (!f3_numero_valido(_s.prog[_t][_b], 0, 1)) return;
                if (!f3_numero_valido(_s.prontos[_t][_b], 0, 3) || floor(_s.prontos[_t][_b]) != _s.prontos[_t][_b]) return;
            }
        }
        if (!is_struct(_s.esteira) || !f3_tipos_validos(_s.esteira.fila) || !f3_tipos_validos(_s.esteira.saida)) return;
        if (!is_array(_s.esteira.transito) || !f3_numero_valido(_s.esteira.frame, 0, 24)) return;
        if (!f3_numero_valido(_s.esteira.prog, -100, 1)) return;
        if (!f3_numero_valido(_s.esteira.entrada_tempo, 0, 1)) return;
        for (var _i = 0; _i < array_length(_s.esteira.transito); _i++) {
            var _c = _s.esteira.transito[_i];
            if (!is_struct(_c) || !f3_numero_valido(_c.tipo, 0, 2) || _c.tipo != floor(_c.tipo)) return;
            if (!f3_numero_valido(_c.veic, -1, 3) || _c.veic != floor(_c.veic)) return;
            if (!f3_numero_valido(_c.distancia, 1, 10000) || !f3_numero_valido(_c.p, -100, 1)) return;
            if (!f3_rota_valida(_c.rota)) return;
        }
        for (var _i = 0; _i < 2; _i++) {
            var _e = _s.exp[_i];
            var _c = _s.enc[_i];
            if (!is_struct(_e) || !is_struct(_c)) return;
            if (!f3_numero_valido(_e.estado, 0, 2) || _e.estado != floor(_e.estado)) return;
            if (!f3_numero_valido(_c.estado, 0, 2) || _c.estado != floor(_c.estado)) return;
            if (!f3_numero_valido(_e.qtd, 0, 9) || _e.qtd != floor(_e.qtd)) return;
            if (!f3_numero_valido(_e.tipo, -1, 2) || _e.tipo != floor(_e.tipo)) return;
            if (_e.estado != 0 && _e.tipo < 0) return;
            if (!f3_numero_valido(_e.p, 0, 2) || !f3_numero_valido(_c.p, 0, 2)) return;
            if (!f3_rota_valida(_e.rota) || !f3_tipos_validos(_c.carga)) return;
            if (_c.qtd != array_length(_c.carga) || !f3_numero_valido(_c.veic, 0, 3) || _c.veic != floor(_c.veic)) return;
            var _coordenadas = ["x", "y", "home_x", "home_y"];
            for (var _j = 0; _j < array_length(_coordenadas); _j++) {
                if (!f3_numero_valido(variable_struct_get(_e, _coordenadas[_j]), -1000, 2000)) return;
                if (!f3_numero_valido(variable_struct_get(_c, _coordenadas[_j]), -1000, 2000)) return;
            }
            if (!f3_numero_valido(_c.x0, -1000, 2000) || !f3_numero_valido(_c.y0, -1000, 2000)
                || !f3_numero_valido(_c.x1, -1000, 2000) || !f3_numero_valido(_c.y1, -1000, 2000)) return;
            if (_e.estado != 0) {
                if (!is_array(_e.paradas) || !f3_tipos_validos(_e.paradas)) return;
                if (!f3_numero_valido(_e.idx, 0, array_length(_e.paradas)) || _e.idx != floor(_e.idx)) return;
                if (_e.estado == 1 && _e.idx >= array_length(_e.paradas)) return;
            }
        }
        for (var _i = 0; _i < 4; _i++) {
            var _v = _s.veic[_i];
            if (!is_struct(_v) || !f3_tipos_validos(_v.carga)) return;
            if (!f3_numero_valido(_v.estado, 0, 3) || _v.estado != floor(_v.estado)) return;
            if (!f3_numero_valido(_v.reservado, 0, 10) || _v.reservado != floor(_v.reservado)) return;
            if (!f3_numero_valido(_v.p, 0, 2) || !f3_numero_valido(_v.espera, -1, 5)) return;
            var _reservas = 0;
            for (var _j = 0; _j < 2; _j++) if (_s.enc[_j].estado == 1 && _s.enc[_j].veic == _i) _reservas += _s.enc[_j].qtd;
            for (var _j = 0; _j < array_length(_s.esteira.transito); _j++) if (_s.esteira.transito[_j].veic == _i) _reservas++;
            if (_reservas != _v.reservado) return;
        }
        if (!f3_numero_valido(_s.montados, 0, 1000000000000000) || !f3_numero_valido(_s.entregues, 0, 1000000000000000)) return;
        global.f3_prog = _s.prog;
        global.f3_prontos = _s.prontos;
        global.f3_exp = _s.exp;
        global.f3_enc = _s.enc;
        global.f3_esteira = _s.esteira;
        global.f3_veic = _s.veic;
        global.f3_total_montados = _s.montados;
        global.f3_total_entregues = _s.entregues;
        global.f3_inicializado = true;
    } catch (_erro) {
        
        f3_limpar_producao();
    }
}

function f3_numero_valido(_v, _min, _max) {
    return is_real(_v) && !is_nan(_v) && !is_infinity(_v) && _v >= _min && _v <= _max;
}

function f3_tipos_validos(_itens) {
    if (!is_array(_itens) || array_length(_itens) > 1000) return false;
    for (var _i = 0; _i < array_length(_itens); _i++) {
        if (!f3_numero_valido(_itens[_i], 0, 2) || _itens[_i] != floor(_itens[_i])) return false;
    }
    return true;
}

function f3_rota_valida(_rota) {
    if (!is_array(_rota) || array_length(_rota) > 20) return false;
    for (var _i = 0; _i < array_length(_rota); _i++) {
        if (!is_array(_rota[_i]) || array_length(_rota[_i]) != 2) return false;
        if (!f3_numero_valido(_rota[_i][0], -1000, 2000) || !f3_numero_valido(_rota[_i][1], -1000, 2000)) return false;
    }
    return true;
}

//INTERFACE DOS TUTORIAIS
function tutorial_som() {
    if (!variable_global_exists("sc_ligado") || global.sc_ligado) audio_play_sound(snd_Troca_de_tela, 1, false);
}
function tutorial_caixa(_t) {
    draw_set_font(font_Pequena);
    var _idioma = variable_global_exists("idm") ? clamp(global.idm, 0, 2) : 0;
    var _r = _t.retangulo_alvo();
    var _escala = 1.2;
    var _titulo = string_replace_all(_t.textos[_t.etapa][_idioma], " ", "    ");
    var _texto = string_replace_all(_t.descricoes[_t.etapa][_idioma], " ", "    ");
    var _th = string_height_ext(_titulo, 17, 308 / _escala) * _escala;
    var _dh = string_height_ext(_texto, 17, 308 / _escala) * _escala;
    var _h = 38 + _th + _dh + 52;
    var _y = (_r[3] <= 365) ? min(390, 630 - _h) : 70;
    return {y:_y, h:_h, titulo:_titulo, texto:_texto, th:_th, botao:_y+_h-45, escala:_escala};
}
function tutorial_continuar(_t, _x, _y) {
    var _c = tutorial_caixa(_t);
    if (mouse_check_button_released(mb_left) && point_in_rectangle(_x,_y,224,_c.botao,334,_c.botao+35)) {
        tutorial_som(); _t.avancar();
    }
}
function tutorial_desenhar(_t, _fase) {
    var _idioma = variable_global_exists("idm") ? clamp(global.idm,0,2) : 0;
    draw_set_font(font_Pequena);
    draw_set_halign(fa_center); draw_set_valign(fa_middle);
    if (!_t.ativo) {
        
    } else {
        var _r = _t.retangulo_alvo();
        draw_set_color(c_black); draw_set_alpha(0.78);
        draw_rectangle(0,0,360,_r[1],false); draw_rectangle(0,_r[3],360,640,false);
        draw_rectangle(0,_r[1],_r[0],_r[3],false); draw_rectangle(_r[2],_r[1],360,_r[3],false);
        draw_set_alpha(1); draw_set_color(make_color_rgb(255,210,75));
        draw_rectangle(_r[0],_r[1],_r[2],_r[3],true);
        var _ax=(_r[0]+_r[2])/2, _ay=max(60,_r[1]-12-sin(_t.pulsacao*5)*4);
        draw_triangle(_ax-7,_ay-10,_ax+7,_ay-10,_ax,_ay,false);
        
        if (_fase==2 && _t.etapa==6 && !_t.arrastou && instance_exists(_t.cliente) && instance_exists(obj_psn_Principal_2)) {
            var _mesas=[obj_Mesa_HD_SSD,obj_Mesa_PSU,obj_Mesa_GPU];
            var _mesa=instance_find(_mesas[_t.cliente.pedido_area],0);
            var _p=instance_find(obj_psn_Principal_2,0);
            if (_mesa!=noone) {
                draw_set_color(make_color_rgb(255,210,75));
                draw_arrow(_p.x,_p.y+20,_mesa.x,_mesa.y,12);
                draw_circle(_mesa.x,_mesa.y,22+sin(_t.pulsacao*5)*3,true);
            }
        }
        var _c = tutorial_caixa(_t);
        draw_set_color(make_color_rgb(20,29,46)); draw_roundrect(12,_c.y,348,_c.y+_c.h,false);
        draw_set_halign(fa_left); draw_set_valign(fa_top);
        draw_set_color(make_color_rgb(255,210,75));
        var _numero = _t.etapa+1, _total = array_length(_t.textos);
        if (_fase == 3) { _total--; if (_t.etapa>8) _numero--; }
        draw_text(24,_c.y+8,string(_numero)+" / "+string(_total));
        draw_text_ext_transformed(24,_c.y+26,_c.titulo,17,308/_c.escala,_c.escala,_c.escala,0);
        draw_set_color(c_white);
        draw_text_ext_transformed(24,_c.y+32+_c.th,_c.texto,17,308/_c.escala,_c.escala,_c.escala,0);
        var _botao = (_t.etapa==0 || (_fase==1 && _t.etapa>=5) || (_fase==2 && _t.etapa==5) || (_fase==3 && _t.etapa>=10));
        if (_botao) {
            draw_set_color(make_color_rgb(40,95,140)); draw_roundrect(224,_c.botao,334,_c.botao+35,false);
            draw_set_color(c_white); draw_set_halign(fa_center); draw_set_valign(fa_middle);
            var _rotulo=["CONTINUAR","CONTINUE","CONTINUAR"]; draw_text(279,_c.botao+17,_rotulo[_idioma]);
        }
        
        if (_t.etapa==0) {
            var _sprites=[spr_Fliperama_Cube,spr_Tutorial_personagem_2,spr_psn_Montador_3];
            var _spr=_sprites[_fase-1];
            var _s=min(150/sprite_get_width(_spr),100/sprite_get_height(_spr));
            var _px=180, _py=max(410,_c.y+_c.h+62);
            draw_sprite_ext(_spr,floor(_t.pulsacao*8) mod sprite_get_number(_spr),_px+(sprite_get_xoffset(_spr)-sprite_get_width(_spr)/2)*_s,_py+(sprite_get_yoffset(_spr)-sprite_get_height(_spr)/2)*_s,_s,_s,0,c_white,1);
        }
        draw_set_color(c_white); draw_set_halign(fa_center); draw_set_valign(fa_middle);
        var _pular=["PULAR","SKIP","SALTAR"]; draw_text(311,27,_pular[_idioma]);
    }
    draw_set_color(c_white); draw_set_alpha(1); draw_set_halign(fa_left); draw_set_valign(fa_top);
}

function tutorial_f2_ativo() { return instance_exists(obj_Tutorial_interativo_2) && obj_Tutorial_interativo_2.ativo; }
function tutorial_f2_pratica(_t) {
    if (!_t.pratica_preparada) {
        _t.pratica_preparada=true; _t.arrastou=false; _t.pratica_concluida=false; _t.cliente=noone;
        _t.descricoes[6]=["Aguarde o primeiro cliente chegar ao balcão. Depois, arraste o personagem até a bancada indicada.","Wait for the first customer to reach the counter. Then drag the character to the indicated bench.","Espera al primer cliente en el mostrador. Después, arrastra el personaje al banco indicado."];
        if (!instance_exists(obj_psn_Principal_2)) instance_create_depth(115,384,0,obj_psn_Principal_2);
        with (obj_psn_Principal_2) { voltando=false; arrastando=false; mesa_atual=noone; x=x_original; y=y_original; }
    }
    if (!instance_exists(_t.cliente) && instance_exists(obj_Balcao_2)) {
        var _b=instance_find(obj_Balcao_2,0);
        if (ds_list_size(_b.fila)>0) {
            var _c=_b.fila[|0];
            if (instance_exists(_c) && _c.estado_fila==1) { _t.cliente=_c; _c.timer_atendimento=0; }
        }
    }
    if (instance_exists(_t.cliente)) {
        var _nomes=["HD/SSD","PSU","GPU"];
        var _nome=_nomes[_t.cliente.pedido_area];
        if (!_t.arrastou) _t.descricoes[6]=["Segure o personagem e arraste até a bancada de "+_nome+". Solte sobre ela para iniciar o primeiro atendimento.","Hold the character and drag to the "+_nome+" bench. Release to start the first repair.","Mantén pulsado el personaje y arrástralo al banco de "+_nome+". Suelta para iniciar la reparación."];
        else _t.descricoes[6]=["Muito bem! Toque na área iluminada para terminar o conserto. Aguarde o personagem voltar e receber o pagamento.","Great! Tap the highlighted area to finish the repair. Wait for the character to return and collect payment.","¡Bien! Toca el área iluminada para terminar. Espera que el personaje vuelva y cobre."];
    }
    if (_t.pratica_concluida) _t.avancar();
}

//TUTORIAIS INTERATIVOS
function tutorial_permite(_obj) {
    if (instance_exists(obj_Tutorial_interativo_1) && obj_Tutorial_interativo_1.ativo) return _obj == obj_Tutorial_interativo_1.alvo_objeto();
    if (instance_exists(obj_Tutorial_interativo_2) && obj_Tutorial_interativo_2.ativo) return _obj == obj_Tutorial_interativo_2.alvo_objeto();
    return true;
}
function tutorial_iniciar_fase(_fase) {
    var _obj = (_fase == 1) ? obj_Tutorial_interativo_1 : obj_Tutorial_interativo_2;
    var _guia = instance_find(_obj, 0);
    if (_guia == noone) _guia = instance_create_depth(0, 0, -15000, _obj);
    _guia.ativo = true;
    _guia.etapa = 0;
    _guia.espera = 0.2;
    if (_fase == 1) {
        global.tutorial_f1_iniciado = true;
        global.tutorial_f1_concluido = false;
    } else {
        global.tutorial_f2_concluido = false;
    }
}