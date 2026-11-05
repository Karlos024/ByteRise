if (room_get_name(room) != "rm_Tela_principal_2") {
    visible = false;
    exit;
}
visible = true;

//SE TERMINAR O ATENDIMENTO VAI FAZER A FILA ANDAR
if (variable_instance_exists(id, "atendimento_concluido_posto") && atendimento_concluido_posto == true) {
    if (instance_exists(balcao_id)) {
        var remover = ds_list_find_index(balcao_id.fila, id);
        if (remover != -1) {
            ds_list_delete(balcao_id.fila, remover);
        }
        balcao_id.ocupado = false;
    }

    //SISTEMA DE ESTÁTICA E MENU
    if (!variable_global_exists("moedas")) global.moedas = 0;
    if (!variable_global_exists("moedas_acumuladas")) global.moedas_acumuladas = 0;
    if (!variable_global_exists("experiencia_atual")) global.experiencia_atual = 0;
    var valor_moedas = 0;
    var valor_xp = 0;

 //RECEBIMENTO EM MOEDAS E XP
 switch (pedido_area) {
        case 0:
            var moedas_base = 1200;
            var xp_base = 90;
            switch (global.hd_ssd) {
                case 1: moedas_base = 1200; xp_base = 90; break;
                case 2: moedas_base = 1200; xp_base = 120; break;
                case 3: moedas_base = 1650; xp_base = 120; break;
                case 4: moedas_base = 1650; xp_base = 155; break;
                case 5: moedas_base = 2250; xp_base = 155; break;
                case 6: moedas_base = 2250; xp_base = 195; break;
                case 7: moedas_base = 3000; xp_base = 195; break;
                case 8: moedas_base = 3000; xp_base = 240; break;
                case 9: moedas_base = 3900; xp_base = 240; break;
                case 10: moedas_base = 3900; xp_base = 260; break;
                case 11: moedas_base = 4700; xp_base = 260; break;
                case 12: moedas_base = 4700; xp_base = 280; break;
                case 13: moedas_base = 6000; xp_base = 280; break;
                case 14: moedas_base = 6000; xp_base = 300; break;
                case 15: moedas_base = 6900; xp_base = 300; break;
            }
            valor_moedas = moedas_base;
            valor_xp = xp_base;
            break;

        case 1:
            moedas_base = 2100;
            xp_base = 140;
            switch (global.psu) {
                case 1: moedas_base = 2100; xp_base = 140; break;
                case 2: moedas_base = 2100; xp_base = 175; break;
                case 3: moedas_base = 2700; xp_base = 175; break;
                case 4: moedas_base = 2700; xp_base = 215; break;
                case 5: moedas_base = 3450; xp_base = 215; break;
                case 6: moedas_base = 3450; xp_base = 260; break;
                case 7: moedas_base = 4350; xp_base = 260; break;
                case 8: moedas_base = 4350; xp_base = 285; break;
                case 9: moedas_base = 5400; xp_base = 285; break;
                case 10: moedas_base = 5400; xp_base = 315; break;
                case 11: moedas_base = 6750; xp_base = 315; break;
                case 12: moedas_base = 6750; xp_base = 350; break;
                case 13: moedas_base = 7200; xp_base = 350; break;
                case 14: moedas_base = 7200; xp_base = 380; break;
                case 15: moedas_base = 8700; xp_base = 380; break;
            }
            valor_moedas = moedas_base;
            valor_xp = xp_base;
            break;

        case 2:
            moedas_base = 3000;
            xp_base = 190;
            switch (global.gpu) {
                case 1: moedas_base = 3000; xp_base = 190; break;
                case 2: moedas_base = 3000; xp_base = 230; break;
                case 3: moedas_base = 3750; xp_base = 230; break;
                case 4: moedas_base = 3750; xp_base = 275; break;
                case 5: moedas_base = 4650; xp_base = 275; break;
                case 6: moedas_base = 4650; xp_base = 325; break;
                case 7: moedas_base = 5700; xp_base = 325; break;
                case 8: moedas_base = 5700; xp_base = 360; break;
                case 9: moedas_base = 6600; xp_base = 360; break;
                case 10: moedas_base = 6600; xp_base = 385; break;
                case 11: moedas_base = 7350; xp_base = 385; break;
                case 12: moedas_base = 7350; xp_base = 410; break;
                case 13: moedas_base = 9000; xp_base = 410; break;
                case 14: moedas_base = 9000; xp_base = 455; break;
                case 15: moedas_base = 10800; xp_base = 455; break;
            }
            valor_moedas = moedas_base;
            valor_xp = xp_base;
            break;
    }

	//ADICIONA NA CONTA E COM O MULTIPLICADOR
    var recompensa_final = floor(valor_moedas * multiplicador_pagamento);
    global.moedas += recompensa_final;
    global.moedas_acumuladas += recompensa_final;
    global.experiencia_atual += valor_xp;

    //SOM DE PAGAMENTO
    if (variable_global_exists("sc_ligado") && global.sc_ligado && asset_get_index("snd_Moeda") != -1) {
        audio_play_sound(snd_Moeda, 1, false);
    }

	//MANDA O CLIENTE PRO CAMINHO DE SAÍDA
    atendimento_concluido_posto = false;
    estado_fila = 2; 
    fase_saida = 0;
}

//LOCALIZA O BALCÃO E O SPAWNER PARA INICIALIZAR O CLIENTE E ENTRAR NA FILA
if (!inicializado) {
    var balcao = instance_find(obj_Balcao_2, 0);
    if (balcao != noone) {
        balcao_id = balcao;
        var spawner = instance_find(obj_Spawner_2, 0);
        if (spawner != noone) {
            spawner_x = spawner.x;
            spawner_y = spawner.y;
        } else {
            spawner_x = x;
            spawner_y = y;
        }
        if (ds_list_find_index(balcao.fila, id) == -1) {
            ds_list_add(balcao.fila, id);
        }
        inicializado = true;
    } else {
        exit;
    }
}

//CLIQUE
var _fps = max(1, game_get_speed(gamespeed_fps)); 
if (!variable_global_exists("tempo")) { 
    global.tempo = 1.0; 
} 

var clique = 0; 
if (mouse_check_button_pressed(mb_left)) { 
    if (mouse_y >= 64 && mouse_y <= 576) { 
        var ignorar = false;
        if (instance_exists(obj_ctld_Configuracoes)) { 
            if (obj_ctld_Configuracoes.exibir_config) { ignorar = true; } 
        } 
        if (instance_exists(obj_ctld_Troca)) { 
            if (obj_ctld_Troca.exibir_troca_fase) { ignorar = true; } 
        }      
        if (!ignorar) { 
            clique = global.tempo; 
        } 
    } 
}

switch (estado_fila) {
	
	//GERENCIA A MOVIMENTAÇÃO DO CLIENTE ATÉ A SUA POSIÇÃO NA FILA DO BALCÃO
    case 0:
        if (!instance_exists(balcao_id)) {
            break;
        }
        var idx = ds_list_find_index(balcao_id.fila, id);
        if (idx == -1) {
            ds_list_add(balcao_id.fila, id);
            idx = ds_list_find_index(balcao_id.fila, id);
        }
        var fila_x = balcao_id.x - 60;
        var fila_y = (balcao_id.y - 60) - (idx * espaco_fila);
        var alvo_entrada_x = fila_x;
        var alvo_entrada_y = fila_y;

        if (fase_entrada == 0) {
            alvo_entrada_x = spawner_x + 15;
            alvo_entrada_y = spawner_y + 40;
            if (point_distance(x, y, alvo_entrada_x, alvo_entrada_y) <= 8) {
                fase_entrada = 1;
            }
        } else if (fase_entrada == 1) {
            alvo_entrada_x = fila_x;
            alvo_entrada_y = spawner_y + 40;
            if (point_distance(x, y, alvo_entrada_x, alvo_entrada_y) <= 8) {
                fase_entrada = 2;
            }
        } else if (fase_entrada == 2) {
            alvo_entrada_x = fila_x;
            alvo_entrada_y = fila_y;
        }

		//CALCULA O DESLOCAMENTO ATÉ A PRÓXIMA VAGA OU ATIVA O ATENDIMENTO SE CHEGOU NO BALCÃO
        var dist = point_distance(x, y, alvo_entrada_x, alvo_entrada_y);
        if (dist > 4) {
            var dir = point_direction(x, y, alvo_entrada_x, alvo_entrada_y);
            x += lengthdir_x(min(velocidade, dist), dir);
            y += lengthdir_y(min(velocidade, dist), dir);
        } else if (fase_entrada == 2) {
            x = alvo_entrada_x;
            y = alvo_entrada_y;	
            if (idx == 0 && !balcao_id.ocupado) {
                balcao_id.ocupado = true;
                estado_fila = 1;
                timer_atendimento = 0;
            }
        }
        break;

    //ATENDIMENTO NO CAIXA E TRABALHO NA MESA
    case 1: 
        if (!instance_exists(balcao_id)) {
            break;
        }
        x = balcao_id.x - 60;
        y = balcao_id.y - 60;
		
		//ATENDEDOR
        var atendente_mesa_HD = (instance_exists(obj_Mesa_HD_SSD) && obj_Mesa_HD_SSD.atendente_aqui);
        var atendente_mesa_PSU = (instance_exists(obj_Mesa_PSU) && obj_Mesa_PSU.atendente_aqui);
        var atendente_mesa_GPU = (instance_exists(obj_Mesa_GPU) && obj_Mesa_GPU.atendente_aqui);
		
		//JOGADOR
        var protagonista = instance_find(obj_psn_Principal_2, 0);
        var jogador_mesa_HD = (protagonista != noone && protagonista.x == obj_Mesa_HD_SSD.x && protagonista.y == obj_Mesa_HD_SSD.y + 10);
        var jogador_mesa_PSU = (protagonista != noone && protagonista.x == obj_Mesa_PSU.x && protagonista.y == obj_Mesa_PSU.y + 10);
        var jogador_mesa_GPU = (protagonista != noone && protagonista.x == obj_Mesa_GPU.x && protagonista.y == obj_Mesa_GPU.y + 10);

		//SOM DE RECUSADO E MUDANÇA DE COR
		if ((pedido_area != 0 && jogador_mesa_HD) || (pedido_area != 1 && jogador_mesa_PSU) || (pedido_area != 2 && jogador_mesa_GPU)) {
			if (variable_global_exists("sc_ligado") && global.sc_ligado && asset_get_index("snd_Recusado") != -1) {
				audio_play_sound(snd_Recusado, 1, false);
			}
			if (instance_exists(obj_psn_Principal_2)) {
				obj_psn_Principal_2.voltando = true;
			}
			image_blend = make_color_rgb(255, 150, 150);

			//REMOVE O CLIENTE DA FILA E INICIA A SAÍDA
			var posicao = ds_list_find_index(balcao_id.fila, id);
			if (posicao != -1) ds_list_delete(balcao_id.fila, posicao);
			balcao_id.ocupado = false;
			estado_fila = 2;
			fase_saida = 0;
			break;
		}


        //VERIFICA SE O JOGADOR ESTÁ NA MESA CORRETA
        var jogador_correto = false;
        if (pedido_area == 0 && jogador_mesa_HD) jogador_correto = true;
        if (pedido_area == 1 && jogador_mesa_PSU) jogador_correto = true;
        if (pedido_area == 2 && jogador_mesa_GPU) jogador_correto = true;
        
        //GERENCIAMENTO DO PROGRESSO BASEADO EM NÍVEL
        if (jogador_correto) { 
            switch (global.funcionario_2) {
                case 0:
                    timer_atendimento += clique; 
                    break;
                    
                case 1:
                    timer_atendimento += (1 / _fps) + clique; 
                    break;
                    
                case 2:
                    timer_atendimento += (1.5 / _fps) + clique; 
                    break;
                    
                default:
                    timer_atendimento += (2.5 / _fps) + clique; 
                    break;
            }
        } 

		//VOLTA DO PROTAGONISTA
        if (timer_atendimento >= tempo_atendimento) {
            if (instance_exists(obj_psn_Principal_2)) {
                obj_psn_Principal_2.voltando = true;
            }
        }
        break;
		
	//ROTAS DE SAÍDA
    case 2:
        var alvo_porta_x = spawner_x + 15;
        var alvo_porta_y = spawner_y - 10;
        var linha_superior_y = spawner_y + 40;

		//SE O CLIENTA VEIO DA DIREITA
        var direita = false;
        if (instance_exists(balcao_id)) {
            if (x > balcao_id.x) {
                direita = true;
            }
        }
        if (direita) {
            var alvo_atual_x = x;
            var alvo_atual_y = y;

            if (fase_saida == 0) {
                alvo_atual_x = x;
                alvo_atual_y = linha_superior_y;
                if (point_distance(x, y, alvo_atual_x, alvo_atual_y) <= 4) {
                    fase_saida = 1;
                }
            } else if (fase_saida == 1) {
                alvo_atual_x = alvo_porta_x;
                alvo_atual_y = linha_superior_y;
                if (point_distance(x, y, alvo_atual_x, alvo_atual_y) <= 4) {
                    fase_saida = 2;
                }
            } else if (fase_saida == 2) {
                alvo_atual_x = alvo_porta_x;
                alvo_atual_y = alvo_porta_y;
            }
            var distancia_saida = point_distance(x, y, alvo_atual_x, alvo_atual_y);
            if (distancia_saida > 2) {
                var saida = point_direction(x, y, alvo_atual_x, alvo_atual_y);
                x += lengthdir_x(min(velocidade, distancia_saida), saida);
                y += lengthdir_y(min(velocidade, distancia_saida), saida);
            } else if (fase_saida == 2) {
                instance_destroy();
            }
        }
		
		//SE O CLIENTA VEIO DA ESQUERDA
        else {
            var alvo_rota_x = alvo_porta_x;
            var alvo_rota_y = alvo_porta_y;

            if (fase_saida == 0) {
                alvo_rota_x = alvo_porta_x;
                alvo_rota_y = y;
                if (point_distance(x, y, alvo_rota_x, alvo_rota_y) <= 8) {
                    fase_saida = 1;
                }
            } else {
                alvo_rota_x = alvo_porta_x;
                alvo_rota_y = alvo_porta_y;
            }
            var distancia_saida = point_distance(x, y, alvo_rota_x, alvo_rota_y);
            if (distancia_saida > 2) {
                var saida = point_direction(x, y, alvo_rota_x, alvo_rota_y);
                x += lengthdir_x(min(velocidade, distancia_saida), saida);
                y += lengthdir_y(min(velocidade, distancia_saida), saida);
            } else if (fase_saida == 1) {
                instance_destroy();
            }
        }
        break;

	//ÁREA DE ESPERA DO LADO DIREITO 
    case 3:
	
		//CANCELA SE O BALCÃO NÃO EXISTIR MAS SE ELE EXITIR MANDA O CLIENTE ATÉ O PONTO DE ESPERA DO ATENDIMENTO
        if (!instance_exists(balcao_id)) {
            break;
        }
        var espera_x = balcao_id.x + 55;
        var espera_y = balcao_id.y - 60;
        var distancia_espera = point_distance(x, y, espera_x, espera_y);
        if (distancia_espera > 4) {
            var espera = point_direction(x, y, espera_x, espera_y);
            x += lengthdir_x(velocidade, espera);
            y += lengthdir_y(velocidade, espera);
        } else {
            x = espera_x;
            y = espera_y;
        }
        break;
}

//SISTEMA DE DIÁLOGO
if (instance_exists(balcao_id)) {
    var idx_clique = ds_list_find_index(balcao_id.fila, id);
    if (idx_clique == 0 && estado_fila == 1) {
		
		//SÓ DEIXA CLICAR SE NÃO TIVER OUTRO PEDIDO E SÓ ABRE SE NÃO TIVER O NÍVEL 3 DOS FUNCIONÁRIOS
        if (!instance_exists(obj_Pedido_2)) {
            if (mouse_check_button_pressed(mb_left) && position_meeting(mouse_x, mouse_y, id) && global.funcionario_2 < 3) {
                var pedido = instance_create_depth(180, 320, -1000, obj_Pedido_2);
                pedido.cliente_criador = id;
                var idioma = global.idm;

				//DIÁLOGO DOS CLIENTES
				if (sprite_index == spr_psn_Programador) {
					pedido.txt_Cliente = ["Programador",  "Programmer",  "Programador"][idioma];
					switch (pedido_area) {
						case 0: pedido.txt_Problema = ["Meu  SSD  não  está  sendo  reconhecido",  "My  SSD  is  not  being  recognized",  "Mi  SSD  no  está  sendo  realizado"][idioma]; break;
						case 1: pedido.txt_Problema = ["A  fonte  queimou",  "The  power  supply  burned  out",  "La  fuente  de  alimentación  se  quemó"][idioma]; break;
						case 2: pedido.txt_Problema = ["A  placa  de  vídeo  não  está  dando  vídeo",  "The  video  card  is  not  outputting  video",  "La  tarjeta  de  video  no  está  dando  video"][idioma]; break;
					}
				} else if (sprite_index == spr_psn_Mae_filho) {
					pedido.txt_Cliente = ["Mãe  e  Filho",  "Mother  and  Son",  "Madre  e  Hijo"][idioma];
					switch (pedido_area) {
						case 0: pedido.txt_Problema = ["Quero  instalar  mais  joguinhos  para  ele,  mas  não  tem  mais  espaço",  "I  want  to  install  more  games  for  him,  but  there  is  no  more  space",  "Quiero  instalar  más  jueguitos  para  él,  pero  no  hay  mais  espaço"][idioma]; break;
						case 1: pedido.txt_Problema = ["Meu  filho  mexeu  no  computador  e  agora  ele  nem  liga",  "My  son  messed  with  the  computer  and  now  it  won't  even  turn  on",  "Mi  hijo  tocó  la  computadora  y  agora  ni  siquiera  enciende"][idioma]; break;
						case 2: pedido.txt_Problema = ["Os  jogos  do  meu  filho  estão  travando  bastante",  "My  son's  games  are  lagging  a  lot",  "Los  jogos  de  mi  hijo  se  estão  travando  mucho"][idioma]; break;
					}
				} else if (sprite_index == spr_psn_Idoso) {
					pedido.txt_Cliente = ["Idoso",  "Elderly",  "Anciano"][idioma];
					switch (pedido_area) {
						case 0: pedido.txt_Problema = ["Aparece  dizendo  que  não  tem  espaço  mais",  "It  says  there  is  no  more  space  left",  "Dice  que  ya  no  queda  espacio"][idioma]; break;
						case 1: pedido.txt_Problema = ["Aperto  o  botão  e  essa  caixinha  não  quer  ligar",  "I  press  the  button  and  this  little  box  won't  turn  on",  "Presiono  el  botón  y  esta  cajita  no  quiere  encender"][idioma]; break;
						case 2: pedido.txt_Problema = ["A  tela  fica  toda  estranha  quando  uso",  "The  screen  looks  all  weird  when  I  use  it",  "La  pantalla  se  ve  muy  rara  quando  la  uso"][idioma]; break;
					}
				} else if (sprite_index == spr_psn_Esbanjador_2) {
					pedido.txt_Cliente = ["Esbanjador",  "Big  Spender",  "Derrochador"][idioma];
					switch (pedido_area) {
						case 0: pedido.txt_Problema = ["Preciso  de  mais  espaço  para  meus  arquivos",  "I  need  more  space  for  my  files",  "Necesito  más  espacio  para  mis  archivos"][idioma]; break;
						case 1: pedido.txt_Problema = ["Meu  computador  simplesmente  não  liga  mais",  "My  computer  simply  won't  turn  on  anymore",  "Mi  computadora  simplemente  ya  no  enciende"][idioma]; break;
						case 2: pedido.txt_Problema = ["Os  programas  estão  com  gráficos  muito  ruins",  "The  programs  have  very  poor  graphics",  "Los  programas  tienen  gráficos  muy  malos"][idioma]; break;
					}
				} else if (sprite_index == spr_psn_Pao_duro_2) {
					pedido.txt_Cliente = ["Pão-Duro",  "Cheapskate",  "Tacaño"][idioma];
					switch (pedido_area) {
						case 0: pedido.txt_Problema = ["Não  consigo  instalar  mais  nada  because  acabou  o  espaço",  "I  can't  install  anything  else  because  I  ran  out  of  space",  "No  puedo  instalar  nada  más  porque  se  acabó  o  espaço"][idioma]; break;
						case 1: pedido.txt_Problema = ["Meu  computador  apagou  e  não  voltou  mais",  "My  computer  shut  off  and  never  came  back",  "Mi  computadora  se  apagó  y  no  volvió  a  encender"][idioma]; break;
						case 2: pedido.txt_Problema = ["Os  jogos  estão  rodando  muito  mal",  "The  games  are  running  very  poorly",  "Los  jogos  se  estão  executando  muito  mal"][idioma]; break;
					}
				}
				
                //EVITAR BUG DE DUPLICAÇÃO
                mouse_clear(mb_left);
            }
        }
    }
}

//ANIMAÇÃO
var andando = (x != x_anterior || y != y_anterior);
if (andando) {
    var _dx = x - x_anterior;
    var _dy = y - y_anterior;
    var _frame_min = 0;
    var _frame_max = 7;
    
    if (abs(_dx) > abs(_dy)) {
        _frame_min = 18;
        _frame_max = 25;
        
        if (_dx > 0) {
            image_xscale = -abs(image_xscale);
        } else {
            image_xscale = abs(image_xscale);
        }
    } else {
        image_xscale = abs(image_xscale);
        
        if (_dy > 0) {
            _frame_min = 8;
            _frame_max = 17;
        } else {
            _frame_min = 26;
            _frame_max = 33;
        }
    }  
    image_speed = 0;
    image_index += 35 / _fps;
    
    if (image_index < _frame_min || image_index > _frame_max) {
        image_index = _frame_min;
    }
} else {
    image_xscale = abs(image_xscale);
    image_speed = 0;
    image_index += 35 / _fps;
    
    if (image_index < 0 || image_index > 7) {
        image_index = 0;
    }
}
x_anterior = x;
y_anterior = y;