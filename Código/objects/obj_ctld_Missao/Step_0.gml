//CANCELA COM AS CONFIGURAÇÕES ABERTA
if (instance_exists(obj_ctld_Configuracoes)) {
    if (obj_ctld_Configuracoes.exibir_config) {
        exit;
    }
}

//DECLARAÇÃO DE VÁRIAVEIS
if (!variable_global_exists("ms_patentes")) {
    global.ms_patentes = array_create(12, 0);
}
if (!variable_global_exists("ms_progressos")) {
    global.ms_progressos = array_create(12, 0);
}
if (!variable_global_exists("xp_acumulado")) {
    global.xp_acumulado = 0;
}
if (!variable_global_exists("moedas_acumuladas")) {
    global.moedas_acumuladas = 0;
}
if (!variable_global_exists("ms_chuva_tempo")) {
    global.ms_chuva_tempo = 0;
}
if (!variable_global_exists("ms_chuva_nivel")) {
    global.ms_chuva_nivel = 0;
}
if (!variable_global_exists("ms_taxacao_tempo")) {
    global.ms_taxacao_tempo = 0;
}
if (!variable_global_exists("ms_taxacao_nivel")) {
    global.ms_taxacao_nivel = 0;
}
if (!variable_global_exists("ms_fliperama_tempo")) {
    global.ms_fliperama_tempo = 0;
}
if (!variable_global_exists("ms_fliperama_nivel")) {
    global.ms_fliperama_nivel = 0;
}

//CASA LOTADA
if (!variable_global_exists("ms_casa_tempo")) {
    global.ms_casa_tempo = 0;
}
if (!variable_global_exists("ms_casa_nivel")) {
    global.ms_casa_nivel = 0;
}
if (!variable_global_exists("ms_casa_atendimentos")) {
    global.ms_casa_atendimentos = 0;
}

//FREGUESIA VIP
if (!variable_global_exists("ms_vip_tempo")) {
    global.ms_vip_tempo = 0;
}
if (!variable_global_exists("ms_vip_nivel")) {
    global.ms_vip_nivel = 0;
}
if (!variable_global_exists("ms_vip_atendimentos")) {
    global.ms_vip_atendimentos = 0;
}

//OFICINA TURBO
if (!variable_global_exists("ms_turbo_tempo")) global.ms_turbo_tempo = 0;
if (!variable_global_exists("ms_turbo_nivel")) global.ms_turbo_nivel = 0;
if (!variable_global_exists("ms_turbo_reparos")) global.ms_turbo_reparos = 0;

//INVASÃO ESBANJADORA
if (!variable_global_exists("ms_esbanjadora_tempo")) global.ms_esbanjadora_tempo = 0;
if (!variable_global_exists("ms_esbanjadora_nivel")) global.ms_esbanjadora_nivel = 0;
if (!variable_global_exists("ms_esbanjadora_atendimentos")) global.ms_esbanjadora_atendimentos = 0;

//VIDENTE
if (!variable_global_exists("ms_vidente_tempo")) global.ms_vidente_tempo = 0;
if (!variable_global_exists("ms_vidente_nivel")) global.ms_vidente_nivel = 0;

//RECUPERA AS PATENTES DA EXECUÇÃO ATUAL
for (var i = 0; i < 12; i++) {
    frame_recebimento[i] = global.ms_patentes[i];
}

global.ms_progressos[0] = global.xp_acumulado;
global.ms_progressos[2] = global.moedas_acumuladas;

//SUPER CLIQUE
if (!variable_global_exists("ms_superclique")) {
    global.ms_superclique = 0;
}
if (!variable_global_exists("ms_superclique_tempo")) {
    global.ms_superclique_tempo = 0;
}
if (!variable_global_exists("ms_superclique_bonus")) {
    global.ms_superclique_bonus = 0;
}
if (!variable_global_exists("ms_superclique_nivel")) {
    global.ms_superclique_nivel = 0;
}

//PROGRESSO DO SUPER CLIQUE
global.ms_progressos[1] = global.ms_superclique;

//SINCRONIZA CASA LOTADA E FREGUESIA VIP
global.ms_progressos[3] = global.ms_casa_atendimentos;
global.ms_progressos[5] = global.ms_vip_atendimentos;
global.ms_progressos[7] = global.ms_turbo_reparos;
global.ms_progressos[6] = global.ms_esbanjadora_atendimentos;

if (!variable_global_exists("ms_f3_entregas")) global.ms_f3_entregas = 0;
if (!variable_global_exists("ms_f3_producao")) global.ms_f3_producao = 0;
if (!variable_global_exists("ms_f3_superproducao")) global.ms_f3_superproducao = 0;
global.ms_progressos[9] = global.ms_f3_entregas;
global.ms_progressos[10] = global.ms_f3_producao;
global.ms_progressos[11] = global.celular + global.tablet + global.notebook;

//SINCRONIZA FLIPERAMA TURBO
if (!variable_global_exists("fliperama_1")) {
    global.fliperama_1 = 0;
}
if (!variable_global_exists("fliperama_2")) {
    global.fliperama_2 = 0;
}
if (!variable_global_exists("fliperama_3")) {
    global.fliperama_3 = 0;
}
global.ms_progressos[4] = clamp(global.fliperama_1, 0, 15) + clamp(global.fliperama_2, 0, 15) + clamp(global.fliperama_3, 0, 15);

//BARRAS DAS 12 MISSÕES
for (var i = 0; i < 12; i++) {
    progresso_missoes[i] = global.ms_progressos[i];
}
//SEM INTERACAO OU EFEITOS DURANTE O FINAL
if (room == rm_Cutscene_final || room == rm_Tela_final) exit;
tutorial_missao_observar();
tutorial_missao_iniciar_pendente();
if (!tutorial_permite(object_index)) exit;
if (mouse_check_button_pressed(mb_left)) {
    if (!tutorial_missao_clique_permitido(device_mouse_x(0), device_mouse_y(0))) exit;
	
    //FECHA INFORMAÇÕES DO DESAFIO
    if (exibir_desafio) {
        exibir_desafio = false;
        exibir_missao = -1;
        audio_play_sound(snd_Botao, 1, false);
        exit;
    }

    //VERIFICAR FASES DESBLOQUEADAS
    var tem_fase_2 = (variable_global_exists("comprada_2") && global.comprada_2) || (variable_instance_exists(id, "comprada_2") && comprada_2);
    var tem_fase_3 = (variable_global_exists("comprada_3") && global.comprada_3) || (variable_instance_exists(id, "comprada_3") && comprada_3);

    //CLIQUES NAS CATEGORIAS
    for (var i = 0; i < 4; i++) {
        var bx = categoria_x[i];
        var by = categoria_y[i];
        if (point_in_rectangle(mouse_x, mouse_y, bx - 16, by - 9, bx + 16, by + 9)) {

            //FASE 2 BLOQUEADA
            if (i == 2 && !tem_fase_2) {
                audio_play_sound(snd_Recusado, 1, false);
                exit;
            }

            //FASE 3 BLOQUEADA
            if (i == 3 && !tem_fase_3) {
                audio_play_sound(snd_Recusado, 1, false);
                exit;
            }
            audio_play_sound(snd_Botao, 1, false);
            categoria = i;
            exibir_desafio = false;
            exibir_missao = -1;
            exit;
        }
    }

    //BOTÃO DE INFORMAÇÕES
    for (var j = 0; j < 3; j++) {
        var pos_y = missao_y[j];
        if (point_in_rectangle(mouse_x, mouse_y, 85, pos_y - 40, 105, pos_y - 20)) {
            exibir_desafio = true;
            exibir_missao = j;
            audio_play_sound(snd_Botao, 1, false);
            exit;
        }
    }

    //BOTÃO DE RECEBIMENTO
    for (var j = 0; j < 3; j++) {
        var pos_y = missao_y[j];
        if (point_in_rectangle(mouse_x, mouse_y, 225, pos_y - 10, 265, pos_y + 30)) {

            var indice = categoria * 3 + j;
            var nivel_atual = global.ms_patentes[indice];

            //PATENTE MÁXIMA
            if (nivel_atual >= 3) {
                audio_play_sound(snd_Lotado, 1, false);
                exit;
            }

            //MISSÃO DE CHUVA DE XP E TAXAÇÃO
            if (indice == 0 || indice == 2) {
                var meta = metas_missoes[indice][nivel_atual];
                if (global.ms_progressos[indice] < meta) {
                    audio_play_sound(snd_Recusado, 1, false);
                    exit;
                }
                global.ms_patentes[indice] += 1;
                frame_recebimento[indice] =
                global.ms_patentes[indice];
                var nivel_bonus = global.ms_patentes[indice];

				//TEMPO DE EVENTO
                var duracao = 40;
                switch (nivel_bonus) {
                    case 1:
                        duracao = 40;
                    break;

                    case 2:
                        duracao = 90;
                    break;

                    case 3:
                        duracao = 180;
                    break;
                }

                if (indice == 0) {
                    global.ms_chuva_nivel = nivel_bonus;
                    global.ms_chuva_tempo = duracao;
                }

                if (indice == 2) {
                    global.ms_taxacao_nivel = nivel_bonus;
                    global.ms_taxacao_tempo = duracao;
                }
                audio_play_sound(snd_Recebimento, 1, false);
                exit;
            }

            //MISSÃO SUPER CLIQUE
            if (indice == 1) {
                var meta = metas_missoes[indice][nivel_atual];
                if (global.ms_superclique < meta) {
                    audio_play_sound(snd_Recusado, 1, false);
                    exit;
                }
                global.ms_patentes[indice] += 1;
                frame_recebimento[indice] =
				global.ms_patentes[indice];
                var nivel_bonus = global.ms_patentes[indice];
                global.ms_superclique_nivel = nivel_bonus;
                global.ms_superclique_bonus = 0.50;

                //TEMPO DE EVENTO
                switch (nivel_bonus) {
                    case 1:
                        global.ms_superclique_tempo = 40;
                    break;

                    case 2:
                        global.ms_superclique_tempo = 90;
                    break;

                    case 3:
                        global.ms_superclique_tempo = 180;
                    break;
                }
                audio_play_sound(snd_Recebimento, 1, false);
                exit;
            }

            //MISSÃO CASA LOTADA
            if (indice == 3) {
                var meta = metas_missoes[indice][nivel_atual];
                if (global.ms_progressos[indice] < meta) {
                    audio_play_sound(snd_Recusado, 1, false);
                    exit;
                }
                global.ms_patentes[indice] += 1;
                frame_recebimento[indice] =
                    global.ms_patentes[indice];
                global.ms_casa_nivel =
                    global.ms_patentes[indice];

                //TEMPO DE EVENTO
                switch (global.ms_casa_nivel) {
                    case 1:
                        global.ms_casa_tempo = 40;
                    break;
					
                    case 2:
                        global.ms_casa_tempo = 90;
                    break;
					
                    case 3:
                        global.ms_casa_tempo = 180;
                    break;
                }
                tutorial_missao_resgatada(indice);
                audio_play_sound(snd_Recebimento, 1, false);
                exit;
            }

            //MISSÃO FLIPERAMA TURBO
            if (indice == 4) {
                var meta = metas_missoes[indice][nivel_atual];
                if (global.ms_progressos[indice] < meta) {
                    audio_play_sound(snd_Recusado, 1, false);
                    exit;
                }
                global.ms_patentes[indice] += 1;
                frame_recebimento[indice] =
                    global.ms_patentes[indice];
                global.ms_fliperama_nivel =
                    global.ms_patentes[indice];

                //TEMPO DE EVENTO
                switch (global.ms_fliperama_nivel) {
                    case 1:
                        global.ms_fliperama_tempo = 40;
                    break;

                    case 2:
                        global.ms_fliperama_tempo = 90;
                    break;

                    case 3:
                        global.ms_fliperama_tempo = 180;
                    break;
                }

                tutorial_missao_resgatada(indice);
                audio_play_sound(snd_Recebimento, 1, false);
                exit;
            }

            //MISSÃO FREGUESIA VIP
            if (indice == 5) {
                var meta = metas_missoes[indice][nivel_atual];
                if (global.ms_progressos[indice] < meta) {
                    audio_play_sound(snd_Recusado, 1, false);
                    exit;
                }
                global.ms_patentes[indice] += 1;
                frame_recebimento[indice] =
                global.ms_patentes[indice];
                global.ms_vip_nivel =
				global.ms_patentes[indice];

                //TEMPO DE EVENTO
                switch (global.ms_vip_nivel) {
                    case 1:
                        global.ms_vip_tempo = 40;
                    break;

                    case 2:
                        global.ms_vip_tempo = 90;
                    break;

                    case 3:
                        global.ms_vip_tempo = 180;
                    break;
                }

                tutorial_missao_resgatada(indice);
                audio_play_sound(snd_Recebimento, 1, false);
                exit;
            }

            //MISSÃO GASTANÇA E INVASÃO ESBANJADORA
            if (indice == 6) {
                var meta = metas_missoes[indice][nivel_atual];
                if (global.ms_progressos[indice] < meta) {
                    audio_play_sound(snd_Recusado, 1, false);
                    exit;
                }
                global.ms_patentes[indice] += 1;
                frame_recebimento[indice] = global.ms_patentes[indice];
                global.ms_esbanjadora_nivel = global.ms_patentes[indice];
				
				//TEMPO DE EVENTO
                switch (global.ms_esbanjadora_nivel) {
                    case 1:
					global.ms_esbanjadora_tempo = 40;
					break;
					
                    case 2:
					global.ms_esbanjadora_tempo = 90;
					break;
					
                    case 3:
					global.ms_esbanjadora_tempo = 180;
					break;
                }
                audio_play_sound(snd_Recebimento, 1, false);
                exit;
            }
			
            //MISSÃO OFICINA TURBO
            if (indice == 7) {
                var meta = metas_missoes[indice][nivel_atual];
                if (global.ms_progressos[indice] < meta) {
                    audio_play_sound(snd_Recusado, 1, false);
                    exit;
                }
                global.ms_patentes[indice] += 1;
                frame_recebimento[indice] = global.ms_patentes[indice];
                global.ms_turbo_nivel = global.ms_patentes[indice];
				
				//TEMPO DE EVENTO
                switch (global.ms_turbo_nivel) {
                    case 1: global.ms_turbo_tempo = 40;
					break;
					
                    case 2:
					global.ms_turbo_tempo = 90;
					break;
					
                    case 3:
					global.ms_turbo_tempo = 180;
					break;
                }
                audio_play_sound(snd_Recebimento, 1, false);
                exit;
            }

            //MISSÃO VIDENTE
            if (indice == 8) {
                var meta = metas_missoes[indice][nivel_atual];
                if (global.ms_progressos[indice] < meta) {
                    audio_play_sound(snd_Recusado, 1, false);
                    exit;
                }
                global.ms_patentes[indice] += 1;
                frame_recebimento[indice] = global.ms_patentes[indice];
                global.ms_vidente_nivel = global.ms_patentes[indice];
                
				//TEMPO DE EVENTO
				switch (global.ms_vidente_nivel) {
                    case 1: global.ms_vidente_tempo = 40;
					break;
					
                    case 2:
					global.ms_vidente_tempo = 90;
					break;
					
                    case 3:
					global.ms_vidente_tempo = 180;
					break;
                }
                audio_play_sound(snd_Recebimento, 1, false);
                exit;
            }
			
            if (indice >= 9 && indice <= 11) {
                var meta = metas_missoes[indice][nivel_atual];
                if (global.ms_progressos[indice] < meta) {
                    audio_play_sound(snd_Recusado, 1, false);
                    exit;
                }
                global.ms_patentes[indice] += 1;
                frame_recebimento[indice] = global.ms_patentes[indice];
                var nivel_bonus = global.ms_patentes[indice];
                var duracao = [40, 90, 180][nivel_bonus - 1];
                if (indice == 9) {
                    global.ms_entrega_nivel = nivel_bonus;
                    global.ms_entrega_tempo = duracao;
                }
                if (indice == 10) {
                    global.ms_producao_nivel = nivel_bonus;
                    global.ms_producao_tempo = duracao;
                }
                if (indice == 11) {
                    global.ms_superproducao_nivel = nivel_bonus;
                    global.ms_superproducao_tempo = duracao;
                }
                audio_play_sound(snd_Recebimento, 1, false);
                exit;
            }

            global.ms_patentes[indice] += 1;
            frame_recebimento[indice] =
            global.ms_patentes[indice];

            audio_play_sound(snd_Recebimento, 1, false);
            exit;
        }
    }

    //SELEÇÃO RESTANTE DAS MISSÕES
    for (var j = 0; j < 3; j++) {
        var pos_y = missao_y[j];

        if (point_in_rectangle(mouse_x, mouse_y, 45, pos_y - 35, 315, pos_y + 35)) {
            exit;
        }
    }
}
