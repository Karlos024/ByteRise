if (room != rm_Tela_principal_3) exit;
var _cam = global.cam3_y;
draw_set_font(font_Pequena);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_sprite(spr_Cenario_3, 0, 180, 640 - _cam);
//CHEFE
draw_sprite(spr_f3_rotina, rotina_frame, mesa_x, mesa_y - _cam);
//BANCADAS
var _nivel_tipo = [nivel_up("celular"), nivel_up("tablet"), nivel_up("notebook")];
for (var t = 0; t < 3; t++) {
    var _liberadas = bancadas_do_nivel(_nivel_tipo[t]);
    for (var b = 0; b < 3; b++) {
        var _bx = bancada_x[b];
        var _by = bancada_y[t] - _cam;
        if (b < _liberadas) {
            
            draw_sprite_ext(ator_montador, floor(montador_frame[t][b]), _bx, _by - 28, 0.65, 0.65, 0, c_white, 1);
            draw_sprite_ext(ator_bancada, 0, _bx, _by + 5, 0.5, 0.5, 0, c_white, 1);
            
            for (var s = 0; s < capacidade_saida; s++) {
                var _sx = _bx - 44 + s * 13;
                var _sy = _by + 30;
                var _ocupado = (s < global.f3_prontos[t][b]);
                if (_ocupado && ator_dispositivo[t] != noone && sprite_exists(ator_dispositivo[t])) {
                    draw_set_alpha(1);
                    draw_set_color(c_white);
                    draw_sprite_ext(ator_dispositivo[t], 0, _sx, _sy, 0.25, 0.25, 0, c_white, 1);
                } else {
                    if (_ocupado) {
                        draw_set_color(cor_tipo[t]);
                        draw_rectangle(_sx - 5, _sy - 5, _sx + 5, _sy + 5, false);
                    }
                    draw_set_color(c_dkgray);
                    draw_rectangle(_sx - 5, _sy - 5, _sx + 5, _sy + 5, true);
                }
            }
            
            if (global.f3_prontos[t][b] < capacidade_saida) {
                desenhar_mostrador(_bx + 24, _by + 30, global.f3_prog[t][b], 8);
            }
        } else {
            
            draw_set_color(c_dkgray);
            draw_set_alpha(0.6);
            draw_rectangle(_bx - bancada_w / 2, _by - bancada_h / 2, _bx + bancada_w / 2, _by + bancada_h / 2, true);
            draw_set_alpha(1);
        }
    }
}
//ESTEIRA
var _est = global.f3_esteira;
var _automatizado = (nivel_up("funcionario_3") >= 3);
if (_automatizado) {
    draw_sprite(spr_f3_esteira_gigante, floor(_est.frame), esteira_auto_x, esteira_auto_y - _cam);
} else {
    draw_sprite(spr_Esteira, floor(_est.frame) mod 9, esteira_x, esteira_y - _cam);
}

for (var it = 0; it < array_length(_est.transito); it++) {
    var _c = _est.transito[it];
    if (_c.p < 0) continue;
    var _pos_c = ponto_na_rota(_c.rota, _c.p);
    draw_sprite(ator_caixa[_c.tipo], 0, _pos_c.x, _pos_c.y - _cam);
}

if (array_length(_est.fila) > 0) {
    marcador(esteira_x + 48, esteira_y - 52 - _cam, 22, 14, c_ltgray, string(array_length(_est.fila)));
}

if (array_length(_est.fila) > 0 && array_length(_est.saida) < capacidade_caixas) {
    desenhar_mostrador(esteira_x + 48, esteira_y - _cam, _est.prog, 8);
}
//CAIXAS
var _andar_qtd = [5, 4, 3, 2, 1];
var _slot = 0;
for (var _andar = 0; _andar < 5; _andar++) {
    var _qtd_andar = _andar_qtd[_andar];
    for (var _k = 0; _k < _qtd_andar; _k++) {
        var _cx = esteira_x + (_k - (_qtd_andar - 1) / 2) * 14;
        var _cy = esteira_y + 80 - _andar * 13 - _cam;
        var _tem_caixa = (_slot < array_length(_est.saida));
        if (_tem_caixa && ator_caixa[_est.saida[_slot]] != noone && sprite_exists(ator_caixa[_est.saida[_slot]])) {
            draw_set_alpha(1);
            draw_set_color(c_white);
            draw_sprite(ator_caixa[_est.saida[_slot]], 0, _cx, _cy);
        } else {
            if (_tem_caixa) {
                draw_set_color(cor_tipo[_est.saida[_slot]]);
                draw_rectangle(_cx - 6, _cy - 6, _cx + 6, _cy + 6, false);
            }
            // AS POSIÇÕES VAZIAS NÃO DESENHAM UMA SEGUNDA PIRÂMIDE NO CHÃO.
        }
        _slot++;
    }
}
//EXPORTADORES
var _n_exp = exportadores_ativos();
for (var ie = 0; ie < _n_exp; ie++) {
    var _e = global.f3_exp[ie];
    var _dir = _e.visual_dir;
    var _esc = 0.65;
    var _carga_esc = (_dir == 2) ? 0.25 : 0.5;
    var _px = _e.x + ((_dir == 2) ? -25 * _esc * _e.visual_lado : 0);
    var _py = _e.y - _cam + 20 * _esc;
    
    if (_e.qtd > 0 && _dir == 1) {
        draw_sprite_part_ext(palete_sprites[_e.tipo], _e.qtd - 1, 0, 0, 64, 52, _px - 32 * _carga_esc, _py - 52 * _carga_esc, _carga_esc, _carga_esc, c_white, 1);
    }
    draw_sprite_ext(emp_sprites[_dir], floor(_e.visual_frame), _e.x, _e.y - _cam, _esc * _e.visual_lado, _esc, 0, c_white, 1);
    if (_e.qtd > 0 && _dir != 1) {
        draw_sprite_part_ext(palete_sprites[_e.tipo], _e.qtd - 1, 0, 0, 64, 52, _px - 32 * _carga_esc, _py - 52 * _carga_esc, _carga_esc, _carga_esc, c_white, 1);
    }

    
    if (_e.estado != 0) {
        desenhar_mostrador(_e.home_x + 22, _e.home_y - _cam, _e.p, 8);
    }
}
//ENCOMENDADORES
for (var ic = 0; ic < _n_exp; ic++) {
    var _en = global.f3_enc[ic];
    if (!_automatizado || _en.estado != 0) {
        var _sprites_vazios = [spr_f3_enc_vazio_frente, spr_f3_enc_vazio_costas, spr_f3_enc_vazio_perfil];
        var _spr_enc = _sprites_vazios[_en.visual_dir];
        var _quadro_enc = floor(_en.visual_frame);
        if (_en.qtd > 0) {
            _spr_enc = enc_sprites[_en.visual_dir][_en.qtd - 1];
        } else if (_en.estado == 0) {
            
            var _idle_enc = asset_get_index("spr_f3_transportador_idle");
            if (_idle_enc != -1 && sprite_exists(_idle_enc)) _spr_enc = _idle_enc;
            if (_en.estado == 0) _quadro_enc = floor(current_time / 160) mod 8;
        }
        draw_sprite_ext(_spr_enc, _quadro_enc, _en.x, _en.y - _cam, 0.65 * _en.visual_lado, 0.65, 0, c_white, 1);

        
        if (_en.estado != 0) {
            desenhar_mostrador(_en.home_x + 22, _en.home_y - _cam, _en.p, 8);
        }
    }
}
//VEÍCULOS
var _nt = clamp(nivel_up("transporte"), 0, 3);
for (var v = 0; v < veiculo_qtd[_nt]; v++) {
    var _vv = global.f3_veic[v];
    var _vx = vaga_x[v];
    var _vy = vaga_y[v];
    
    var _ang = 0;
    if (_vv.estado == 1 || _vv.estado == 3) {
        var _rt = rota_do_veiculo(v);
        var _pv = (_vv.estado == 1) ? _vv.p : 1 - _vv.p;
        var _pos = ponto_na_rota(_rt, _pv);
        _vx = _pos.x;
        _vy = _pos.y;
        _ang = angulo_na_rota(_rt, _pv, (_vv.estado == 1) ? 1 : -1);
    }
    
    if (_vv.estado != 2) {
        
        var _spr_v = frota_sprites[_nt];
        var _vf = clamp(array_length(_vv.carga), 0, sprite_get_number(_spr_v) - 1);
        // MANTÉM A FRENTE PARA A SAÍDA: O RETORNO À VAGA ACONTECE DE RÉ.
        var _lado_v = (vaga_x[v] < 180) ? -1 : 1;
        draw_sprite_ext(_spr_v, _vf, _vx, _vy - _cam, _lado_v * (77 / 124) * 1.129 * 1.15, (77 / 124) * 1.129 * 1.15, 0, c_white, 1);
    }
    if (_vv.estado == 0) {
        
        marcador(vaga_x[v], vaga_y[v] - veiculo_h[_nt] / 2 - 10 - _cam, 30, 14, c_ltgray, string(array_length(_vv.carga)) + "/" + string(veiculo_capacidade[_nt]));
    } else {
        
        var _prog_v = 0;
        if (_vv.estado == 1) _prog_v = _vv.p / 3;
        if (_vv.estado == 2) _prog_v = 1 / 3 + (1 - _vv.espera / veiculo_espera) / 3;
        if (_vv.estado == 3) _prog_v = 2 / 3 + _vv.p / 3;
        desenhar_mostrador(vaga_x[v], vaga_y[v] - _cam, _prog_v, 8);
    }
}

// EASTER EGG - RUA LIVRE, ANTES DO JARDIM E ACIMA DO MENU INFERIOR.
var _rit_escala = 0.5;
var _rit_largura = sprite_get_width(spr_Easteregg_RitMatica) * _rit_escala;
var _rit_altura = sprite_get_height(spr_Easteregg_RitMatica) * _rit_escala;
var _rit_direita = min(286, room_width - 8);
var _rit_base = min(altura_mundo - 60, scroll_max + area_base - 4);
var _rit_x = _rit_direita - _rit_largura;
var _rit_y = _rit_base - _rit_altura - _cam;
// A RUA ACOMPANHA A ROLAGEM; NAO MOSTRA A ANIMACAO CORTADA PELOS MENUS.
if (_rit_y >= area_topo && _rit_y + _rit_altura <= area_base) {
    var _rit_frame = floor(current_time * 0.012) mod max(1, sprite_get_number(spr_Easteregg_RitMatica));
    draw_sprite_ext(spr_Easteregg_RitMatica, _rit_frame,
        _rit_x + sprite_get_xoffset(spr_Easteregg_RitMatica) * _rit_escala,
        _rit_y + sprite_get_yoffset(spr_Easteregg_RitMatica) * _rit_escala,
        _rit_escala, _rit_escala, 0, c_white, 1);
}

draw_set_color(c_white);
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
