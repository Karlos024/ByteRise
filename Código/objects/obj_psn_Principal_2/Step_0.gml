if (tutorial_f2_ativo() && obj_Tutorial_interativo_2.etapa != 6) {
    // MANTÉM A POSE PARADA NO FUNDO DO TUTORIAL, ANTES DA ETAPA PRÁTICA.
    arrastando = false;
    image_speed = 0;
    image_index = 0;
    exit;
}
//APAGA QUANDO COMPRA O NÍVEL 3 DOS FUNCIONÁRIOS
if (variable_global_exists("funcionario_2") && global.funcionario_2 >= 3 && !tutorial_f2_ativo()) {
    arrastando = false;
    voltando = false;
    mesa_atual = noone;
    instance_destroy();
    exit;
}

if (!variable_instance_exists(id, "x_anterior")) {
    x_anterior = x;
    y_anterior = y;
}

var _buff_movimento = movimento_bonus_clique(mouse_check_button_pressed(mb_left));

//DESATIVA O ARRASTAR QUANDO ESTIVER VOLTANDO
if (variable_instance_exists(id, "voltando") && voltando == true) {
    arrastando = false;
    
    //DECLARAÇÃO DAS COORDENADAS
    var linha_horizontal_baixo_y = y_original + 150;
    var alvo_volta_x = x;
    var alvo_volta_y = y;
    
    //DEFINE O PONTO DE PARTIDA HORIZONTAL BASEADO NA SUA MESA ATUAL OU NA ORIGEM
    var origem_x = x_original;
    if (mesa_atual != noone && instance_exists(mesa_atual)) {
        origem_x = (mesa_atual.bbox_left + mesa_atual.bbox_right) / 2;
    }
    
    //MOVIMENTAÇÃO PARA RETORNAR AO PONTO ORIGINAL
    if (fase_volta_psn == 0) {
        alvo_volta_x = origem_x;
        alvo_volta_y = linha_horizontal_baixo_y;
        if (point_distance(x, y, alvo_volta_x, alvo_volta_y) <= 4) {
            fase_volta_psn = 1;
        }
    } else if (fase_volta_psn == 1) {
        alvo_volta_x = x_original + 15;
        alvo_volta_y = linha_horizontal_baixo_y;
        if (point_distance(x, y, alvo_volta_x, alvo_volta_y) <= 4) {
            fase_volta_psn = 2;
        }
    } else if (fase_volta_psn == 2) {
        alvo_volta_x = x_original + 15;
        alvo_volta_y = y_original;
        if (point_distance(x, y, alvo_volta_x, alvo_volta_y) <= 4) {
            fase_volta_psn = 3;
        }
    } else if (fase_volta_psn == 3) {
        alvo_volta_x = x_original;
        alvo_volta_y = y_original;
    }
    
    //CONTROLE DE VELOCIDADE ACELERADA
    var velocidade_atual = velocidade;
    if (variable_global_exists("funcionario_2") && global.funcionario_2 >= 2) {
        velocidade_atual = velocidade * 2;
    }
    
    velocidade_atual *= _buff_movimento;

    //VELOCIDADE DO MOVIMENTO POR FRAME
    var distancia_posto = point_distance(x, y, alvo_volta_x, alvo_volta_y);
    var margem_chegada = 4;
    if (fase_volta_psn == 3) { margem_chegada = 2; }
    
    //VOLTA O PROTAGONISTA ATÉ O PONTO ORIGINAL OU ZERA SUAS VARIÁVEIS CASO ELE JÁ TENHA CHEGADO
    if (distancia_posto > margem_chegada) {
        var posto = point_direction(x, y, alvo_volta_x, alvo_volta_y);
        x += lengthdir_x(min(velocidade_atual, distancia_posto), posto);
        y += lengthdir_y(min(velocidade_atual, distancia_posto), posto);
    } else if (fase_volta_psn == 3) {
        x = x_original;
        y = y_original;
        voltando = false;
        fase_volta_psn = 0;
        mesa_atual = noone;
        
        //RECEBE O PAGAMENTO DE ACORDO COM A MESA
        var balcao = instance_find(obj_Balcao_2, 0);
        if (balcao != noone && ds_list_size(balcao.fila) > 0) {
            var cliente_da_vez = balcao.fila[| 0];
            
            //CONCLUI O PEDIDO
            if (instance_exists(cliente_da_vez) && cliente_da_vez.estado_fila == 1 && cliente_da_vez.timer_atendimento >= cliente_da_vez.tempo_atendimento) {
                cliente_da_vez.veio_da_fila_2 = false;
                cliente_da_vez.atendimento_concluido_posto = true;
            }
        }
    }
}

//SISTEMA DE CLICAR E ARRASTAR
if (!instance_exists(obj_Pedido_2) && !voltando) {
    if (mouse_check_button_pressed(mb_left) && position_meeting(mouse_x, mouse_y, id)) {
        arrastando = true;
        mesa_atual = noone;
        fase_volta_psn = 0;
        image_index = 0;
    }
}

if (arrastando) {
	
    //DECLARAÇÃO
    var mouse_limitado_x = mouse_x;
    var mouse_limitado_y = mouse_y;
    
    //LIMITA O MOUSE
    if (instance_exists(obj_Cenario_2)) {
        var margem = 40;
        mouse_limitado_x = clamp(mouse_x, obj_Cenario_2.bbox_left + margem, obj_Cenario_2.bbox_right - margem);
        mouse_limitado_y = clamp(mouse_y, obj_Cenario_2.bbox_top + margem, obj_Cenario_2.bbox_bottom - margem);
    }
    
    if (instance_exists(obj_Balcao_2)) {
        var ajuste_balcao = 80;
        if (mouse_limitado_y < obj_Balcao_2.bbox_top + ajuste_balcao) {
            mouse_limitado_y = obj_Balcao_2.bbox_top + ajuste_balcao;
        }
    }
    
    x = mouse_limitado_x;
    y = mouse_limitado_y;
    
    //SISTEMA DE ENCAIXAR NA MESA
    if (mouse_check_button_released(mb_left)) {
        arrastando = false;
        
        //QUAL MESA COLIDIU AO SER SOLTO
        var mesa_colidida = instance_place(x, y, obj_Mesa_HD_SSD);
        var tipo_mesa = 0;
        
        if (mesa_colidida == noone) {
            mesa_colidida = instance_place(x, y, obj_Mesa_PSU);
            tipo_mesa = 1;
        }
        if (mesa_colidida == noone) {
            mesa_colidida = instance_place(x, y, obj_Mesa_GPU);
            tipo_mesa = 2;
        }
        
        //VERIFICA SE A MESA FOI COMPRADA E SE JÁ NÃO TEM UM FUNCIONÁRIO TRABALHANDO NELA
        if (mesa_colidida != noone) {
            var func = instance_find(obj_psn_Consertador_2, 0);
            var func_na_mesa = (!tutorial_f2_ativo() && func != noone && func.mesa_alvo == mesa_colidida && func.estado_func > 0);
            var upgrade_comprado = false;
            
            if (tipo_mesa == 0 && variable_global_exists("hd_ssd") && global.hd_ssd > 0) { upgrade_comprado = true; }
            if (tipo_mesa == 1 && variable_global_exists("psu") && global.psu > 0) { upgrade_comprado = true; }
            if (tipo_mesa == 2 && variable_global_exists("gpu") && global.gpu > 0) { upgrade_comprado = true; }
            
            //ENCAIXA O PERSONAGEM NA MESA SE AS CONDIÇÕES FOREM VÁLIDAS
            if (tutorial_f2_ativo()) {
                var _guia_f2 = obj_Tutorial_interativo_2;
                if (!instance_exists(_guia_f2.cliente) || _guia_f2.cliente.pedido_area != tipo_mesa) upgrade_comprado = false;
                else if (upgrade_comprado) _guia_f2.arrastou = true;
            }
            if (upgrade_comprado && !func_na_mesa) {
                x = mesa_colidida.x;
                y = mesa_colidida.y + 10;
                mesa_atual = mesa_colidida;
                image_index = 46;
            } else {
                voltando = true;
                fase_volta_psn = 0;
                mesa_atual = noone;
            }
        } else {
            voltando = true;
            fase_volta_psn = 0;
            mesa_atual = noone;
        }
    }
}

//ANIMAÇÃO
image_speed = 0;
if (arrastando) {
    image_index += 0.20;
    if (image_index < 24 || image_index > 39) {
        image_index = 24;
    }
} else if (x != x_anterior || y != y_anterior) {
    var _dx = x - x_anterior;
    var _dy = y - y_anterior;
    var _frame_min = 40;
    var _frame_max = 47;
    
    if (abs(_dx) > abs(_dy)) {
        _frame_min = 48;
        _frame_max = 55;
        if (_dx > 0) {
            image_xscale = -abs(image_xscale);
        } else {
            image_xscale = abs(image_xscale);
        }
    } else {
        image_xscale = abs(image_xscale);
        if (_dy > 0) {
            _frame_min = 40;
            _frame_max = 47;
        } else {
            _frame_min = 56;
            _frame_max = 63;
        }
    }
    image_index += 0.25 * _buff_movimento;
    if (image_index < _frame_min || image_index > _frame_max) {
        image_index = _frame_min;
    }
} else if (mesa_atual != noone && !voltando) {
    image_index += 0.20;
    if (image_index < 64 || image_index > 71) {
        image_index = 64;
    }
} else {
    image_xscale = abs(image_xscale);
    image_index += 0.1;
    if (image_index < 0 || image_index > 23) {
        image_index = 0;
    }
}
x_anterior = x;
y_anterior = y;
