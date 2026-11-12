if (!inicializado) {
	//DECLARAÇÃO DE VARIÁVEIS CASO NÃO EXISTAM AINDA
    if (!variable_instance_exists(id, "fator_empurrao_movimento")) { fator_empurrao_movimento = 0.15; }
    if (!variable_instance_exists(id, "velocidade_npc")) { velocidade_npc = 1.5; }
    if (!variable_instance_exists(id, "na_fila_fliperama")) { na_fila_fliperama = false; }
    if (!variable_instance_exists(id, "fase_caminho")) { fase_caminho = 0; }
    if (!variable_instance_exists(id, "fliperama_alvo")) { fliperama_alvo = noone; }
    if (!variable_instance_exists(id, "espaco_fila")) { espaco_fila = 55; }
    if (!variable_instance_exists(id, "dentro_x")) { dentro_x = x; }
    if (!variable_instance_exists(id, "dentro_y")) { dentro_y = y; }
    if (!variable_instance_exists(id, "spawner_x")) { spawner_x = xstart; }
    if (!variable_instance_exists(id, "spawner_y")) { spawner_y = ystart; }

    //COORDENADAS DO CAMINHO
    corredor_esquerdo_x = 91.75;
    corredor_direito_x = 263.25;
    fila_x_balcao = 115;
    fila_x_balcao_2 = 253;
    fila_y_frente = 318;
    fila_y_curva = 230;
    chegada_horizontal_y = 346;
    desvio_esquerdo_y = 373;
    saida_horizontal_y = 380;

    //DADOS DO CLIENTE
    fliperama_x = x;
    fliperama_y = y;
    corredor_alvo_x = corredor_esquerdo_x;
    sem_fliperama = 0;
    rota = [];
	
	//POSIÇÃO DA FILA
    balcao_inst = noone;
    with (obj_Balcao_1) {
        if (variable_instance_exists(id, "fase") && fase == other.fase) {
            other.balcao_inst = id;
        }
    }
    if (balcao_inst != noone && variable_instance_exists(balcao_inst, "fila")) {
        balcao_x = balcao_inst.x;
        balcao_y = balcao_inst.y;
        fila_dir = 90;
        if (!variable_instance_exists(balcao_inst, "ocupado_2")) { balcao_inst.ocupado_2 = false; }

		//DEFINE QUEM ESTÁ NA FRENTE DE QUEM
        if (!variable_global_exists("senha_cliente")) { global.senha_cliente = 0; }
        senha = global.senha_cliente;
        global.senha_cliente += 1;

        //ESCOLHA DO BALCÃO
        balcao_num = 0;
        if (variable_global_exists("funcionario_1") && global.funcionario_1 >= 3) {
            var quantidade_0 = 0;
            var quantidade_1 = 0;
            with (object_index) {
                if (id != other.id && inicializado && estado_fila <= 2) {
                    if (balcao_num == 1) { quantidade_1++; } else { quantidade_0++; }
                }
            }
            if (quantidade_1 < quantidade_0) { balcao_num = 1; }
        }

       //VERIFICA SE O ID JÁ ESTÁ NA FILA
        if (balcao_num == 0) {
            if (ds_list_find_index(balcao_inst.fila, id) == -1) {
                ds_list_add(balcao_inst.fila, id);
            }
        }
        inicializado = true;
    }
    exit;
}

if (room != rm_Tela_principal_1) {
    image_speed = 0;
    exit;
}

//RECUPERAÇÃO DE DADOS QUANDO TROCA DE TELA
if (!instance_exists(balcao_inst)) {
    balcao_inst = noone;
    with (obj_Balcao_1) {
        if (variable_instance_exists(id, "fase") && fase == other.fase) {
            other.balcao_inst = id;
        }
    }
    if (balcao_inst != noone) {
        if (!variable_instance_exists(balcao_inst, "ocupado_2")) { balcao_inst.ocupado_2 = false; }
        if (estado_fila <= 2) {
            if (balcao_num == 0 && variable_instance_exists(balcao_inst, "fila")) {
                if (ds_list_find_index(balcao_inst.fila, id) == -1) {
                    if (estado_fila == 0) { ds_list_add(balcao_inst.fila, id); }
                    else { ds_list_insert(balcao_inst.fila, 0, id); }
                }
            }
            
			//QUANDO TEM CLIENTE SENDO ATENDIDO O BALCÃO FICA OCUPADO
            if (estado_fila >= 1) {
                if (balcao_num == 0) { balcao_inst.ocupado = true; }
                else { balcao_inst.ocupado_2 = true; }
            }
        }
    }
}

//SE O CLIENTE BUGOU E SUMIU DO ALVO A PROTEÇÃO REECONTRA
if ((estado_fila == 3 || estado_fila == 4) && !instance_exists(fliperama_alvo)) {
    var fliperama = noone;
    with (obj_Fliperama_Cube) {
        if (fliperama == noone && point_distance(x, y, other.fliperama_x, other.fliperama_y) < 1) { fliperama = id; }
    }
    if (fliperama == noone) {
        with (obj_Fliperama_Alfredos) {
            if (fliperama == noone && point_distance(x, y, other.fliperama_x, other.fliperama_y) < 1) { fliperama = id; }
        }
    }
    if (fliperama == noone) {
        with (obj_Fliperama_Pocket) {
            if (fliperama == noone && point_distance(x, y, other.fliperama_x, other.fliperama_y) < 1) { fliperama = id; }
        }
    }

	//SE ACHOU UM FLIPERAMA VAI NORMALMENTE MAS CASO AO CONTRÁRIO ELE VAI EMBORA
    if (fliperama != noone) {
        fliperama_alvo = fliperama;
        fliperama.ocupado = true;
        sem_fliperama = 0;
    } else {
        sem_fliperama += 1;
        if (sem_fliperama > 30) {
            sem_fliperama = 0;
            fase_saida = 0;
            estado_fila = 5;
        }
    }
}

//CONFIGURAÇÃO DO TEMPO
var _fps = game_get_speed(gamespeed_fps);
if (!variable_global_exists("tempo")) { global.tempo = 1.0; }


//CLIQUE E MISSÃO SUPER CLIQUE
var clique = 0;

if (mouse_check_button_pressed(mb_left)) {

    if (mouse_y >= 64 && mouse_y <= 576) {

        var ignora = false;

        if (instance_exists(obj_ctld_Configuracoes)) {
            if (obj_ctld_Configuracoes.exibir_config) {
                ignora = true;
            }
        }

        if (instance_exists(obj_ctld_Troca)) {
            if (obj_ctld_Troca.exibir_troca_fase) {
                ignora = true;
            }
        }

        //CONTA SOMENTE DURANTE O ATENDIMENTO
        if (!ignora && (estado_fila == 1 || estado_fila == 4)) {

            clique = global.tempo;

            //BÔNUS TEMPORÁRIO
            if (global.ms_superclique_tempo > 0) {
                clique += global.ms_superclique_bonus;
            }

            //REGISTRA A MISSÃO
            scp_ms_superclique();
        }
    }
}

//VELOCIDADE COM CLIQUE
var velocidade_atual = velocidade_npc;
if (clique > 0) {
    velocidade_atual = velocidade_npc + max(1, round(clique * _fps * fator_empurrao_movimento));
}

//ANDA EM LINHA RETA
var andar_ate = function(andar_ate_x, andar_ate_y, andar_ate_velocidade) {
    var dist = point_distance(x, y, andar_ate_x, andar_ate_y);
    if (dist > 0) {
        var _dir = point_direction(x, y, andar_ate_x, andar_ate_y);
        x += lengthdir_x(min(andar_ate_velocidade, dist), _dir);
        y += lengthdir_y(min(andar_ate_velocidade, dist), _dir);
    }
    return point_distance(x, y, andar_ate_x, andar_ate_y);
};

//COLUNA DA FILA DO BALCÃO
var coluna_x = fila_x_balcao_2;
if (balcao_num == 0) {
    coluna_x = fila_x_balcao;
} else {
    coluna_x = fila_x_balcao_2;
}

//CORREDOR DO FLIPERAMA ALVO
var corredor_x = corredor_alvo_x;

switch (estado_fila) {

    //GERENCIA A MOVIMENTAÇÃO DO CLIENTE ATÉ A SUA POSIÇÃO NA FILA DO BALCÃO
    case 0:
        if (!instance_exists(balcao_inst)) { break; }

        //POSIÇÃO NA FILA
        var idx = 0;
        with (object_index) {
            if (id != other.id && inicializado && balcao_num == other.balcao_num && estado_fila <= 2 && senha < other.senha) {
                idx++;
            }
        }

		//DECLARAÇÃO DA FILA
		var trecho = fila_y_frente - fila_y_curva;
		var espaco    = min(espaco_fila, trecho / 2);
		var atras  = idx * espaco;
		var fila_x = coluna_x;
		var fila_y = fila_y_frente - atras;

		//CAMINHO PRA CHEGAR NA FILA
        if (fase_entrada == 0) {
            if (andar_ate(spawner_x, fila_y_curva, velocidade_npc) <= 0.5) { fase_entrada = 1; }
        }
        else if (fase_entrada == 1) {
            if (andar_ate(fila_x, fila_y_curva, velocidade_npc) <= 0.5) { fase_entrada = 2; }
        }
        else {
            var alvo_y = fila_y;
            if (abs(x - fila_x) > 1) { alvo_y = min(fila_y, fila_y_curva); }
            var vaga = andar_ate(fila_x, alvo_y, velocidade_npc);
            if (vaga <= 0.5 && abs(x - fila_x) <= 1 && abs(y - fila_y) <= 1) {
                x = fila_x;
                y = fila_y;

                //CADA BALCÃO ATENDE O SEU CLIENTE
                if (idx == 0) {
                    if (balcao_num == 0 && !balcao_inst.ocupado) {
                        balcao_inst.ocupado = true;
                        estado_fila = 1;
                        timer_atendimento = 0;
                    }
                    else if (balcao_num == 1 && !balcao_inst.ocupado_2) {
                        balcao_inst.ocupado_2 = true;
                        estado_fila = 1;
                        timer_atendimento = 0;
                    }
                }
            }
        }
        break;

    //SENDO ATENDIDO NO BALCÃO
    case 1:
        if (!instance_exists(balcao_inst)) { break; }
        x = coluna_x;
        y = fila_y_frente;
        timer_atendimento += (1 / _fps) + clique;
        var nivel_funcionario = 0;
        if (variable_global_exists("funcionario_1")) {
            nivel_funcionario = clamp(global.funcionario_1, 0, 3);
        }
        if (timer_atendimento >= tempos_atendimento[nivel_funcionario]) {
            estado_fila = 2;
        }
        break;

    //PROCURA FLIPERAMA LIVRE
    case 2:
	
		//ESPERA QUANDO TROCA DE TELA PRA EVITAR BUG DE MÁQUINA OCUPADA
        var pendente = false;
        with (object_index) {
            if (estado_fila >= 3 && estado_fila <= 4 && !instance_exists(fliperama_alvo)) { pendente = true; }
        }

		//BUSCA O FLIPERAMA CORRETO DO CLIENTE
        var fliperama_livre = noone;
        if (!pendente) {
            if (tipo == 0) {
                with (obj_Fliperama_Cube) { if (comprado && !ocupado) { fliperama_livre = id; break; } }
            } else if (tipo == 3) {
                with (obj_Fliperama_Alfredos) { if (comprado && !ocupado) { fliperama_livre = id; break; } }
            } else if (tipo == 4) {
                with (obj_Fliperama_Pocket) { if (comprado && !ocupado) { fliperama_livre = id; break; } }
            } else {
                with (obj_Fliperama_Cube) { if (comprado && !ocupado) { fliperama_livre = id; break; } }
                if (fliperama_livre == noone) { with (obj_Fliperama_Alfredos) { if (comprado && !ocupado) { fliperama_livre = id; break; } } }
                if (fliperama_livre == noone) { with (obj_Fliperama_Pocket) { if (comprado && !ocupado) { fliperama_livre = id; break; } } }
            }
        }

        if (fliperama_livre != noone) {
            fliperama_livre.ocupado = true;
            fliperama_alvo = fliperama_livre;
            tipo_fliperama = fliperama_livre.tipo_fl;


			//SALVA O FLIPERAMA DO CLIENTE PRA NÃO BUG QUANDO TROCAR DE TELA
            fliperama_x = fliperama_livre.x;
            fliperama_y = fliperama_livre.y;

            //LADO DO FLIPERAMA ONDE O CLIENTE FICA
            if (fliperama_livre.image_xscale > 0) {
                dentro_x = fliperama_livre.x + 35;
            } else {
                dentro_x = fliperama_livre.x - 35;
            }
            dentro_y = fliperama_livre.y;

            //CORREDOR DO LADO DO CLIENTE
			var corredor_alvo_cliente_x = corredor_esquerdo_x;
			if (dentro_x >= spawner_x) {
				corredor_alvo_cliente_x = corredor_direito_x;
			} else {
				corredor_alvo_cliente_x = corredor_esquerdo_x;
			}
            corredor_alvo_x = corredor_alvo_cliente_x;

            //ROTA
            rota = [];
            if (corredor_alvo_cliente_x == corredor_esquerdo_x) {
                if (balcao_num == 1) {
                    array_push(rota, [coluna_x, chegada_horizontal_y]);
                    array_push(rota, [fila_x_balcao, chegada_horizontal_y]);
                }
                array_push(rota, [fila_x_balcao, desvio_esquerdo_y]);
                array_push(rota, [corredor_esquerdo_x, desvio_esquerdo_y]);
            } else {
                array_push(rota, [coluna_x, chegada_horizontal_y]);
                array_push(rota, [corredor_direito_x, chegada_horizontal_y]);
            }
            array_push(rota, [corredor_alvo_cliente_x, dentro_y]);
            array_push(rota, [dentro_x, dentro_y]);

            //LIBERA O BALCÃO
            if (instance_exists(balcao_inst)) {
                if (balcao_num == 0) {
                    var remover = ds_list_find_index(balcao_inst.fila, id);
                    if (remover != -1) { ds_list_delete(balcao_inst.fila, remover); }
                    balcao_inst.ocupado = false;
                } else {
                    balcao_inst.ocupado_2 = false;
                }
            }
            fase_caminho = 0;
            estado_fila = 3;
        } else {
            x = coluna_x;
            y = fila_y_frente;
        }
        break;

    //CAMINHO ATÉ O FLIPERAMA ALVO
    case 3:
        if (!instance_exists(fliperama_alvo)) { break; }

        if (fase_caminho < array_length(rota)) {
            var percurso = rota[fase_caminho];
            if (andar_ate(percurso[0], percurso[1], velocidade_atual) <= 0.5) { fase_caminho += 1; }
        } else {
            x = dentro_x;
            y = dentro_y;
            estado_fila = 4;
            progresso_dentro = 0;
            fase_caminho = 0;
        }
        break;

    //JOGANDO NO FLIPERAMA
    case 4:
        if (!instance_exists(fliperama_alvo)) { break; }

    //CÁLCULO DO VALOR DO CLIQUE
	var progresso_clique = 0;
	if (clique > 0) {
		progresso_clique = 0.15;
		if (global.ms_superclique_tempo > 0) {
			progresso_clique += 0.50;
		}
	}

        //CÁLCULO DA INTERNET
        var velocidade_auto = 0;
        if (variable_global_exists("internet")) {
            if (global.internet == 1) { velocidade_auto = 1 / 7; }
            else if (global.internet == 2) { velocidade_auto = 1 / 5; }
            else if (global.internet == 3) { velocidade_auto = 1 / 3; }
        }
        progresso_dentro += (velocidade_auto / _fps) + progresso_clique;

        if (progresso_dentro >= 1) {
            if (instance_exists(fliperama_alvo)) {
                fliperama_alvo.ocupado = false;
            }
			
			//SISTEMA DE ESTÁTICA E MENU
            if (!variable_global_exists("moedas")) { global.moedas = 0; }
            if (!variable_global_exists("moedas_acumuladas")) { global.moedas_acumuladas = 0; }
            if (!variable_global_exists("experiencia_atual")) { global.experiencia_atual = 0; }
            var valor_moedas = 0;
            var valor_xp = 0;
            var moedas_base = 0;
            var xp_base = 0;

            //EVENTO DA MISSÃO - FLIPERAMA TURBO
            var turbo_ativo = variable_global_exists("ms_fliperama_tempo") && global.ms_fliperama_tempo > 0;
            var nivel_cube = global.fliperama_1;
            var nivel_alfredos = global.fliperama_2;
            var nivel_pocket = global.fliperama_3;

            if (turbo_ativo) {
                nivel_cube = 15;
                nivel_alfredos = 15;
                nivel_pocket = 15;
            }

      switch (tipo_fliperama) {
                case 0:
                    moedas_base = 600; xp_base = 50;
                    switch (nivel_cube) {
                        case 1: moedas_base = 600; xp_base = 50; break;
                        case 2: moedas_base = 600; xp_base = 70; break;
                        case 3: moedas_base = 600; xp_base = 70; break;
                        case 4: moedas_base = 900; xp_base = 70; break;
                        case 5: moedas_base = 900; xp_base = 95; break;
                        case 6: moedas_base = 900; xp_base = 95; break;
                        case 7: moedas_base = 1300; xp_base = 95; break;
                        case 8: moedas_base = 1300; xp_base = 125; break;
                        case 9: moedas_base = 1300; xp_base = 125; break;
                        case 10: moedas_base = 1800; xp_base = 125; break;
                        case 11: moedas_base = 1800; xp_base = 165; break;
                        case 12: moedas_base = 2400; xp_base = 165; break;
                        case 13: moedas_base = 2400; xp_base = 190; break;
                        case 14: moedas_base = 3400; xp_base = 190; break;
                        case 15: moedas_base = 3400; xp_base = 210; break;
                    }
					valor_moedas = moedas_base;
					valor_xp = xp_base;
                    break;

                case 1:
                    moedas_base = 1600; xp_base = 120;
                    switch (nivel_alfredos) {
                        case 1: moedas_base = 1600; xp_base = 120; break;
                        case 2: moedas_base = 1600; xp_base = 150; break;
                        case 3: moedas_base = 1600; xp_base = 150; break;
                        case 4: moedas_base = 2100; xp_base = 150; break;
                        case 5: moedas_base = 2100; xp_base = 185; break;
                        case 6: moedas_base = 2100; xp_base = 185; break;
                        case 7: moedas_base = 2700; xp_base = 185; break;
                        case 8: moedas_base = 2700; xp_base = 225; break;
                        case 9: moedas_base = 2700; xp_base = 225; break;
                        case 10: moedas_base = 3400; xp_base = 225; break;
                        case 11: moedas_base = 3400; xp_base = 270; break;
                        case 12: moedas_base = 4200; xp_base = 270; break;
                        case 13: moedas_base = 4200; xp_base = 300; break;
                        case 14: moedas_base = 5400; xp_base = 300; break;
                        case 15: moedas_base = 5400; xp_base = 320; break;
                    }
					valor_moedas = moedas_base;
					valor_xp = xp_base;
                    break;

                case 2:
                    moedas_base = 3000; xp_base = 220;
                    switch (nivel_pocket) {
                        case 1: moedas_base = 3000; xp_base = 220; break;
                        case 2: moedas_base = 3000; xp_base = 260; break;
                        case 3: moedas_base = 3000; xp_base = 260; break;
                        case 4: moedas_base = 3800; xp_base = 260; break;
                        case 5: moedas_base = 3800; xp_base = 310; break;
                        case 6: moedas_base = 3800; xp_base = 310; break;
                        case 7: moedas_base = 4800; xp_base = 310; break;
                        case 8: moedas_base = 4800; xp_base = 370; break;
                        case 9: moedas_base = 4800; xp_base = 370; break;
                        case 10: moedas_base = 6000; xp_base = 370; break;
                        case 11: moedas_base = 6000; xp_base = 440; break;
                        case 12: moedas_base = 7600; xp_base = 440; break;
                        case 13: moedas_base = 7600; xp_base = 495; break;
                        case 14: moedas_base = 9000; xp_base = 495; break;
                        case 15: moedas_base = 9000; xp_base = 520; break;
                    }
					valor_moedas = moedas_base;
					valor_xp = xp_base;
                    break;
            }

           	//ADICIONA NA CONTA E COM O MULTIPLICADOR
			var multiplicador_moedas_evento = 1;
			var multiplicador_xp_evento = 1;
			if (variable_global_exists("ms_taxacao_tempo") && global.ms_taxacao_tempo > 0) multiplicador_moedas_evento = 3;
			if (variable_global_exists("ms_chuva_tempo") && global.ms_chuva_tempo > 0) multiplicador_xp_evento = 3;

			//EVENTO DA MISSÃO - FREGUESIA VIP
			var multiplicador_cliente = multiplicador_pagamento;
			if (variable_global_exists("ms_vip_tempo") && global.ms_vip_tempo > 0) {
				multiplicador_cliente = 2.0;
			}

			//RECOMPENSA FINAL
			var recompensa_final = floor(
			valor_moedas *
			multiplicador_cliente *
			multiplicador_moedas_evento
			);
			var xp_final = floor(valor_xp * multiplicador_xp_evento);
			global.moedas += recompensa_final;
			global.moedas_acumuladas += recompensa_final;
			global.experiencia_atual += xp_final;
			if (!variable_global_exists("xp_acumulado")) global.xp_acumulado = 0;
			if (!variable_global_exists("ms_progressos")) global.ms_progressos = array_create(12, 0);
			global.xp_acumulado += xp_final;
			global.ms_progressos[0] = global.xp_acumulado;
			global.ms_progressos[2] = global.moedas_acumuladas;

			//EVENTO DE MISSÃO - CASA LOTADA
			if (!variable_global_exists("ms_casa_atendimentos")) {
			global.ms_casa_atendimentos = 0;
			}
			global.ms_casa_atendimentos += 1;
			global.ms_progressos[3] = global.ms_casa_atendimentos;

			//EVENTO DE MISSÃO - FREGUESIA VIP
			if (!variable_global_exists("ms_vip_atendimentos")) {
			global.ms_vip_atendimentos = 0;
			}
			global.ms_vip_atendimentos += 1;
			global.ms_progressos[5] = global.ms_vip_atendimentos;
			
			//SOM DE PAGAMENTO
            if (variable_global_exists("sc_ligado") && global.sc_ligado && asset_get_index("snd_Moeda") != -1) {
                audio_play_sound(snd_Moeda, 1, false);
            }
            fase_saida = 0;
            estado_fila = 5;
        }
        break;

    //CAMINHO DE SAÍDA
    case 5:
        if (fase_saida == 0) {
            if (andar_ate(corredor_x, y, velocidade_atual) <= 0.5) { fase_saida = 1; }
        }
        else if (fase_saida == 1) {
            if (andar_ate(corredor_x, saida_horizontal_y - 30, velocidade_atual) <= 0.5) { fase_saida = 2; }
        }
        else if (fase_saida == 2) {
            if (andar_ate(spawner_x, saida_horizontal_y - 30, velocidade_atual) <= 0.5) { fase_saida = 3; }
        }
        else if (fase_saida == 3) {
            var cenario = 0;
            if (variable_global_exists("cenario_1")) {
                cenario = global.cenario_1;
            }

            //MUDA O LUGAR DE SAIR SE O NÍVEL DO CÉNARIO FOR IGUAL 2 OU 3
            if (cenario >= 2) {
                if (andar_ate(spawner_x, spawner_y - 40, velocidade_atual) <= 0.5) { 
                    instance_destroy(); 
                }
            } 
            else {
                if (andar_ate(spawner_x, spawner_y, velocidade_atual) <= 0.5) { 
                    instance_destroy(); 
                }
            }
        }
        break;
}

//ANIMAÇÃO
var andando = (x != x_anterior || y != y_anterior);

if (andando) {
    var _dx = x - x_anterior;
    var _dy = y - y_anterior;
    var _frame_min = 0;
    var _frame_max = 7;
    
    if (abs(_dx) > abs(_dy)) {
        _frame_min = 16;
        _frame_max = 23;
        
        if (_dx > 0) {
            image_xscale = -abs(image_xscale);
        } else {
            image_xscale = abs(image_xscale);
        }
    } 
    else {
        image_xscale = abs(image_xscale);
        
        if (_dy > 0) {
            _frame_min = 8;
            _frame_max = 15;
        } else {
            _frame_min = 24;
            _frame_max = 31;
        }
    }
    
    image_speed = 0;
    image_index += 25 / _fps;
    
    if (image_index < _frame_min || image_index > _frame_max) {
        image_index = _frame_min;
    }
} 
else if (estado_fila == 4) {
    if (instance_exists(fliperama_alvo)) {
        if (fliperama_alvo.image_xscale > 0) {
            image_xscale = abs(image_xscale);
        } else {
            image_xscale = -abs(image_xscale);
        }
    }
    
    image_speed = 0;
    image_index += 20 / _fps;
    
    if (image_index < 32 || image_index > 39) {
        image_index = 32;
    }
}
else {
    image_xscale = abs(image_xscale);
    image_speed = 0;
    image_index += 5 / _fps;
    
    if (image_index < 0 || image_index > 7) {
        image_index = 0;
    }
}
x_anterior = x;
y_anterior = y;