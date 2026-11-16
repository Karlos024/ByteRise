// O BÔNUS EXPIRA TAMBÉM ENQUANTO OS CONTROLES ESTÃO BLOQUEADOS.
var _dt_buff = max(0, delta_time / 1000000);
var _buff_anterior = buff_clique_tempo;
buff_clique_tempo = max(0, buff_clique_tempo - _dt_buff);
if (instance_exists(obj_ctld_Configuracoes) && obj_ctld_Configuracoes.exibir_config) {
    arrastando = false;
    vel = 0;
    exit;
}
var _na_tela = (room == rm_Tela_principal_3);
var _dt = min(delta_time / 1000000, 0.05);
var _guia = f3_tutorial_ativo();
var _etapa_guia = _guia ? obj_Tutorial_interativo_3.etapa : -1;
var _janela_aberta = (instance_exists(obj_ctld_Configuracoes) && obj_ctld_Configuracoes.exibir_config == true)
                  || (instance_exists(obj_ctld_Troca) && obj_ctld_Troca.exibir_troca_fase == true);
var _clique = false;   
//CONTROLES
if (!_na_tela || _janela_aberta || (_guia && _etapa_guia != 7 && _etapa_guia != 9)) {
    arrastando = false;
    vel = 0;
} else {
    
    if (!arrastando) {
        if (mouse_wheel_down()) vel += 8;
        if (mouse_wheel_up())   vel -= 8;
        vel = clamp(vel, -40, 40);
    }
    
    if (mouse_check_button_pressed(mb_left)) {
        var _sobre_guia = point_in_rectangle(mouse_x, mouse_y, 250, 546, 350, 572);
        var _alvo_guia = !_guia || point_in_rectangle(mouse_x, mouse_y, 42, 270, 315, 570);
        if (mouse_y > area_topo && mouse_y < area_base && !_sobre_guia && _alvo_guia) {
            arrastando = true;
            moveu = false;
            global.cam3_moveu = false;
            toque_y0 = mouse_y;
            cam_y0 = global.cam3_y;
            vel = 0;
        }
    }
    if (arrastando) {
        if (mouse_check_button(mb_left)) {
            var _d = toque_y0 - mouse_y;   
            if (abs(_d) > 8) {
                moveu = true;
                global.cam3_moveu = true;
            }
            if (moveu) {
                var _novo = clamp(cam_y0 + _d, 0, scroll_max);
                vel = _novo - global.cam3_y;
                global.cam3_y = _novo;
            }
        } else {
            
            if (!moveu && (!_guia || _etapa_guia == 7)) _clique = true;
            arrastando = false;
        }
    } else {
        //INÉRCIA
        if (abs(vel) > 0.2) {
            global.cam3_y = clamp(global.cam3_y + vel, 0, scroll_max);
            vel *= 0.92;
            if (global.cam3_y <= 0 || global.cam3_y >= scroll_max) vel = 0;
        } else {
            vel = 0;
        }
    }
}
//CHEFE
if (_clique) {
    rotina_frame = 182;
    rotina_tempo = 0;
    rotina_batendo = true;
}

rotina_tempo += _dt * 1000;
if (rotina_batendo) {
    while (rotina_frame <= 221 && rotina_tempo >= rotina_duracao[rotina_frame]) {
        rotina_tempo -= rotina_duracao[rotina_frame];
        rotina_frame++;
    }
    if (rotina_frame > 221) {
        rotina_frame = 222;
        rotina_tempo = 0;
        rotina_batendo = false;
    }
} else {
    while (rotina_tempo >= rotina_duracao[rotina_frame]) {
        rotina_tempo -= rotina_duracao[rotina_frame];
        rotina_frame = (rotina_frame + 1) mod array_length(rotina_duracao);
    }
}

if (_guia && _etapa_guia != 7) exit;

// CADA CLIQUE RENOVA 0,25 S; NUNCA SOMA DURAÇÃO NEM MULTIPLICA NOVAMENTE.
if (_clique) {
    _buff_anterior = 0.25;
    buff_clique_tempo = max(0, 0.25 - _dt_buff);
}
// INTEGRA A FRAÇÃO BONIFICADA DO QUADRO, INCLUSIVE NO FIM DOS 0,25 S.
var _fracao_buff = (_dt_buff > 0) ? min(_buff_anterior, _dt_buff) / _dt_buff : 0;
var _vel_personagens = 1 + _fracao_buff;
var _auto = velocidade_cafe() * _dt;
var _val_clique = _clique ? valor_do_clique(3) : 0;
var _inc = _auto + _val_clique;
var _bonus_producao = (variable_global_exists("ms_producao_tempo") && global.ms_producao_tempo > 0) ? 2 : 1;
var _bonus_entrega = (variable_global_exists("ms_entrega_tempo") && global.ms_entrega_tempo > 0) ? 2 : 1;
var _auto_producao = (_bonus_producao > 1) ? max(_auto, _dt / 10) : _auto;
var _inc_producao = _auto_producao * _bonus_producao * _vel_personagens;
// SEM CAFÉ, O APOIO DO CLIQUE MANTÉM A MONTAGEM ATIVA APENAS DURANTE O BÔNUS.
if (_auto_producao == 0) _inc_producao = (_dt / 10) * 2 * _fracao_buff;
var _inc_veiculo = max(_auto, _dt / 10) * _bonus_entrega * _vel_personagens;
//FUNCIONÁRIOS

var _inc_entregador = (_dt * enc_duracao / 5 + _auto) * _vel_personagens;


var _inc_exportador = (_dt * exp_duracao / 5 + _auto) * _vel_personagens;
//TRANSPORTE
var _nt_s = clamp(nivel_up("transporte"), 0, 3);
var _nveic = veiculo_qtd[_nt_s];
var _cap_veic = veiculo_capacidade[_nt_s];
var _automatizado = (nivel_up("funcionario_3") >= 3);   
//MONTADORES
var _nivel_tipo = [nivel_up("celular"), nivel_up("tablet"), nivel_up("notebook")];
for (var t = 0; t < 3; t++) {
    var _liberadas = bancadas_do_nivel(_nivel_tipo[t]);
    for (var b = 0; b < 3; b++) {
        if (b >= _liberadas) continue;
        if (global.f3_prontos[t][b] >= capacidade_saida) {
            montador_frame[t][b] = 0;
            continue;
        }

        
        var _frame = montador_frame[t][b];
        if (_inc_producao > 0 || _frame > 0) {
            _frame += (8 + 4 * nivel_up("cafe")) * _dt * _bonus_producao * _vel_personagens;
            if (_frame >= montador_quadros) _frame = (_inc_producao > 0) ? _frame mod montador_quadros : 0;
        }
        montador_frame[t][b] = _frame;
        global.f3_prog[t][b] += _inc_producao;
        if (global.f3_prog[t][b] >= 1) {
            global.f3_prog[t][b] -= 1;
            global.f3_prontos[t][b] += 1;
            global.f3_total_montados += 1;
            if (!variable_global_exists("ms_f3_producao")) global.ms_f3_producao = 0;
            global.ms_f3_producao += 1;
        }
    }
}
//EXPORTADORES
var _cap_por_nivel = [2, 4, 6, 9];   
var _cap_carga = _cap_por_nivel[clamp(nivel_up("funcionario_3"), 0, 3)];
var _n_exp = exportadores_ativos();
for (var ie = 0; ie < _n_exp; ie++) {
    var _e = global.f3_exp[ie];
    
    if (!variable_struct_exists(_e, "paradas")) {
        _e.paradas = [];
        _e.idx = 0;
    }
    switch (_e.estado) {
        
        case 0:
            var _melhor_tipo = -1;
            var _melhor_qtd = 0;
            for (var te = 0; te < 3; te++) {
                
                var _ocupado = false;
                for (var oe = 0; oe < _n_exp; oe++) {
                    var _o = global.f3_exp[oe];
                    if (oe != ie && _o.estado == 1 && _o.tipo == te) _ocupado = true;
                }
                if (_ocupado) continue;
                var _soma = 0;
                for (var be = 0; be < 3; be++) {
                    _soma += global.f3_prontos[te][be];
                }
                if (_soma > _melhor_qtd) {
                    _melhor_qtd = _soma;
                    _melhor_tipo = te;
                }
            }
            if (_melhor_tipo != -1) {
                
                var _em_transito = 0;
                for (var _ei = 0; _ei < _n_exp; _ei++) _em_transito += global.f3_exp[_ei].qtd;
                if (array_length(global.f3_esteira.fila) + _em_transito >= capacidade_caixas) break;
                _e.tipo = _melhor_tipo;
                _e.qtd = 0;
                
                _e.paradas = [];
                var _plan = 0;
                for (var bp = 2; bp >= 0; bp--) {
                    if (_plan < _cap_carga && global.f3_prontos[_melhor_tipo][bp] > 0) {
                        array_push(_e.paradas, bp);
                        _plan += global.f3_prontos[_melhor_tipo][bp];
                    }
                }
                _e.idx = 0;
                var _b0 = _e.paradas[0];
                _e.rota = montar_rota(_e.x, _e.y, bancada_x[_b0] - 28, bancada_y[_e.tipo] + exportador_parada_dy);
                _e.p = 0;
                _e.estado = 1;
            }
            break;
        
        case 1:
            _e.p += _inc_exportador / exp_duracao;
            var _pt1 = ponto_na_rota(_e.rota, _e.p);
            _e.x = _pt1.x;
            _e.y = _pt1.y;
            if (_e.p >= 1 - 0.000001) {
                
                var _bi = _e.paradas[_e.idx];
                var _pega = min(_cap_carga - _e.qtd, global.f3_prontos[_e.tipo][_bi]);
                global.f3_prontos[_e.tipo][_bi] -= _pega;
                _e.qtd += _pega;
                _e.idx += 1;
                if (_e.idx < array_length(_e.paradas) && _e.qtd < _cap_carga) {
                    
                    var _bn = _e.paradas[_e.idx];
                    _e.rota = montar_rota(_e.x, _e.y, bancada_x[_bn] - 28, bancada_y[_e.tipo] + exportador_parada_dy);
                    _e.p = 0;
                } else {
                    
                    _e.rota = montar_rota(_e.x, _e.y, _e.home_x, _e.home_y);
                    _e.p = 0;
                    _e.estado = 2;
                }
            }
            break;
        
        case 2:
            _e.p += _inc_exportador / exp_duracao;
            var _pt2 = ponto_na_rota(_e.rota, _e.p);
            _e.x = _pt2.x;
            _e.y = _pt2.y;
            if (_e.p >= 1 - 0.000001) {
                repeat (_e.qtd) {
                    array_push(global.f3_esteira.fila, _e.tipo);
                }
                _e.qtd = 0;
                _e.tipo = -1;
                _e.paradas = [];
                _e.idx = 0;
                _e.p = 0;
                _e.estado = 0;
            }
            break;
    }
}
//ESTEIRA
var _est = global.f3_esteira;
//ROTAS
if (!variable_struct_exists(_est, "versao_rotas") || _est.versao_rotas != 2
    || !variable_struct_exists(_est, "rota_automatica") || _est.rota_automatica != _automatizado) {
    for (var ir = 0; ir < array_length(_est.transito); ir++) {
        var _caixa_rota = _est.transito[ir];
        var _espera_rota = min(0, _caixa_rota.p * _caixa_rota.distancia);
        _caixa_rota.rota = rota_da_esteira(_caixa_rota.veic, false);
        _caixa_rota.distancia = comprimento_rota(_caixa_rota.rota);
        if (_caixa_rota.p < 0) _caixa_rota.p = _espera_rota / _caixa_rota.distancia;
    }
    _est.versao_rotas = 2;
    _est.rota_automatica = _automatizado;
}
{
    _est.frame = (_est.frame + 12 * _dt * _vel_personagens) mod 24;
    
    for (var it = array_length(_est.transito) - 1; it >= 0; it--) {
        var _cx = _est.transito[it];
        _cx.p = min(1, _cx.p + (48 * _dt * _vel_personagens) / _cx.distancia);
        if (_cx.p >= 1) {
            if (_cx.veic < 0) {
                array_push(_est.saida, _cx.tipo);
            } else {
                var _dest = global.f3_veic[_cx.veic];
                array_push(_dest.carga, _cx.tipo);
                _dest.reservado--;
            }
            array_delete(_est.transito, it, 1);
        }
    }
    
    _est.entrada_tempo += _dt;
    var _entradas = 0;
    if (_est.entrada_tempo >= esteira_duracao || _clique) {
        _entradas = esteira_lote[_nt_s];
        _est.entrada_tempo = 0;
    }
    repeat (_entradas) {
        var _antiga = _automatizado && array_length(_est.saida) > 0;
        var _tem = _antiga || array_length(_est.fila) > 0;
        if (!_tem) break;
        if (array_length(_est.transito) + array_length(_est.saida) >= capacidade_caixas && !_antiga) break;
        var _alvo_est = -1;
        if (_automatizado) {
            for (var va = 0; va < _nveic; va++) {
                var _vc_est = global.f3_veic[va];
                if (_vc_est.estado == 0 && array_length(_vc_est.carga) + _vc_est.reservado < _cap_veic) {
                    _alvo_est = va;
                    break;
                }
            }
            if (_alvo_est < 0) break;
        }
        var _tipo_est;
        if (_antiga) {
            _tipo_est = _est.saida[0];
            array_delete(_est.saida, 0, 1);
        } else {
            _tipo_est = _est.fila[0];
            array_delete(_est.fila, 0, 1);
        }
        var _rota_est = rota_da_esteira(_alvo_est, _antiga);
        if (_alvo_est >= 0) {
            global.f3_veic[_alvo_est].reservado++;
        }
        
        var _espera_est = 0;
        for (var ce = 0; ce < array_length(_est.transito); ce++) {
            var _anterior = _est.transito[ce];
            _espera_est = min(_espera_est, _anterior.p * _anterior.distancia - 16);
        }
        var _dist_est = comprimento_rota(_rota_est);
        array_push(_est.transito, { tipo: _tipo_est, veic: _alvo_est, rota: _rota_est, distancia: _dist_est, p: _espera_est / _dist_est });
    }
}
_est.prog = (array_length(_est.transito) > 0) ? _est.transito[0].p : 0;
//ENCOMENDADORES
for (var ic = 0; ic < _n_exp; ic++) {
    var _en = global.f3_enc[ic];
    switch (_en.estado) {
        
        case 0:
            if (!_automatizado && array_length(_est.saida) > 0) {
                var _alvo = -1;
                var _livre_alvo = 0;
                for (var vi = 0; vi < _nveic; vi++) {
                    var _vc = global.f3_veic[vi];
                    var _livre = _cap_veic - array_length(_vc.carga) - _vc.reservado;
                    if (_vc.estado == 0 && _livre > 0) {
                        _alvo = vi;
                        _livre_alvo = _livre;
                        break;
                    }
                }
                if (_alvo != -1) {
                    var _pega_e = min(_cap_carga, _livre_alvo, array_length(_est.saida));
                    
                    _en.carga = [];
                    repeat (_pega_e) {
                        array_push(_en.carga, _est.saida[0]);
                        array_delete(_est.saida, 0, 1);
                    }
                    _en.qtd = _pega_e;
                    _en.veic = _alvo;
                    global.f3_veic[_alvo].reservado += _pega_e;
                    
                    var _lado = (vaga_x[_alvo] < 180) ? 1 : -1;
                    _en.x0 = _en.x;
                    _en.y0 = _en.y;
                    _en.x1 = vaga_x[_alvo] + _lado * (veiculo_w[_nt_s] / 2 + 18);
                    _en.y1 = vaga_y[_alvo];
                    _en.p = 0;
                    _en.estado = 1;
                }
            }
            break;
        
        case 1:
            _en.p += _inc_entregador / enc_duracao;
            var _pc = min(_en.p, 1);
            _en.x = lerp(_en.x0, _en.x1, _pc);
            _en.y = lerp(_en.y0, _en.y1, _pc);
            if (_en.p >= 1 - 0.000001) {
                var _vd = global.f3_veic[_en.veic];
                for (var di = 0; di < array_length(_en.carga); di++) {
                    array_push(_vd.carga, _en.carga[di]);
                }
                _vd.reservado -= _en.qtd;
                _en.carga = [];
                _en.qtd = 0;
                _en.x0 = _en.x;
                _en.y0 = _en.y;
                _en.x1 = _en.home_x;
                _en.y1 = _en.home_y;
                _en.p = 0;
                _en.estado = 2;
            }
            break;
        
        case 2:
            _en.p += _inc_entregador / enc_duracao;
            var _pd = min(_en.p, 1);
            _en.x = lerp(_en.x0, _en.x1, _pd);
            _en.y = lerp(_en.y0, _en.y1, _pd);
            if (_en.p >= 1 - 0.000001) {
                _en.p = 0;
                _en.estado = 0;
            }
            break;
    }
}
//VEÍCULOS
for (var vj = 0; vj < _nveic; vj++) {
    var _vv = global.f3_veic[vj];
    switch (_vv.estado) {
        
        case 0:
            if (array_length(_vv.carga) >= _cap_veic && _vv.reservado == 0) {
                _vv.p = 0;
                _vv.estado = 1;
                
                if (variable_global_exists("sc_ligado") && global.sc_ligado) {
                    audio_play_sound(snd_Moeda, 1, false);
                }
            }
            break;
        
        case 1:
            _vv.p += _inc_veiculo / (viagem_duracao / 2);
            if (_vv.p >= 1) {
                
                var _ganho_m = 0;
                var _ganho_xp = 0;
                for (var ci = 0; ci < array_length(_vv.carga); ci++) {
                    var _tp = _vv.carga[ci];
                    var _nvl = clamp(nivel_up(nome_global_tipo[_tp]), 1, 15) - 1;
                    
                    var _valor_moedas = moeda_dispositivo[_tp][_nvl];
                    var _valor_xp = xp_dispositivo[_tp][_nvl];
                    
                    var _recompensa_final = floor(_valor_moedas * multiplicador_pagamento * ((variable_global_exists("ms_superproducao_tempo") && global.ms_superproducao_tempo > 0) ? 2 : 1));
                    _ganho_m += _recompensa_final;
                    _ganho_xp += _valor_xp;
                }
                global.moedas += _ganho_m;
                if (variable_global_exists("moedas_acumuladas")) global.moedas_acumuladas += _ganho_m;
                global.experiencia_atual += _ganho_xp;
                global.f3_total_entregues += array_length(_vv.carga);
                if (!variable_global_exists("ms_f3_entregas")) global.ms_f3_entregas = 0;
                global.ms_f3_entregas += 1;
                _vv.carga = [];
                _vv.espera = veiculo_espera;
                _vv.estado = 2;
            }
            break;
        
        case 2:
            _vv.espera -= _dt;
            if (_vv.espera <= 0) {
                _vv.p = 0;
                _vv.estado = 3;
            }
            break;
        
        case 3:
            _vv.p += _inc_veiculo / (viagem_duracao / 2);
            if (_vv.p >= 1) {
                _vv.p = 0;
                _vv.estado = 0;
            }
            break;
    }
}
//ANIMAÇÕES
for (var i = 0; i < 2; i++) {
    atualizar_visual(global.f3_exp[i]);
    atualizar_visual(global.f3_enc[i]);
}
