//SE TIVER DENTRO DAS CONFIGURAÇÕES NÃO MOSTRAR O BOTÃO TROCA DE FASE
if (instance_exists(obj_ctld_Configuracoes) && obj_ctld_Configuracoes.exibir_config == true) {
    mouse_clear(mb_left);
    exit;
}

//MUDA O FRAME DO BOTÃO
if (instance_exists(obj_ctld_Troca_2)) {
    if (!global.comprada_2) {
        obj_ctld_Troca_2.image_index = 0;
    } else {
        if (room == rm_Tela_principal_2) obj_ctld_Troca_2.image_index = 1;
        else obj_ctld_Troca_2.image_index = 2;
    }
}

if (instance_exists(obj_ctld_Troca_3)) {
    if (!global.comprada_3) {
        obj_ctld_Troca_3.image_index = 0;
    } else {
        if (room == rm_Tela_principal_3) obj_ctld_Troca_3.image_index = 1;
        else obj_ctld_Troca_3.image_index = 2;
    }
}

if (exibir_troca_fase == true) {
    if (mouse_check_button_pressed(mb_left)) {
        
        //SE PRESSIONOU EM CIMA DO BOTÃO COMPRAR
        if (mouse_x >= 90 && mouse_x <= 150 && mouse_y >= 390 && mouse_y <= 430) {
            
            //CHECAGEM DE REQUISITOS
            if (fase_para_comprar == 2) {
                if (global.moedas >= 500000 && global.nivel >= 10) {
                    audio_play_sound(snd_Compra, 1, false);
                    
                    //REINICIA AS MOEDAS PARA ZERO APÓS A COMPRA
					//global.moedas = 0;
                    global.comprada_2 = true;
                    exibir_troca_fase = false;
                    global.fase_atual = 2;
                    room_goto(rm_Tutorial_2);
                } else {
                    audio_play_sound(snd_Recusado, 1, false);
                }
            } 
            else if (fase_para_comprar == 3) {
                if (global.moedas >= 3000000 && global.nivel >= 20) {
                    audio_play_sound(snd_Compra, 1, false);
                    
                    //REINICIA AS MOEDAS PARA ZERO APÓS A COMPRA
					//global.moedas = 0;
                    global.comprada_3 = true;
                    exibir_troca_fase = false;
                    global.fase_atual = 3;
                    room_goto(rm_Tutorial_3);
                } else {
                    audio_play_sound(snd_Recusado, 1, false);
                }
            }
        }
        
        //SE PRESSIONOU EM CIMA DO BOTÃO CANCELAR
        if (mouse_x >= 210 && mouse_x <= 270 && mouse_y >= 390 && mouse_y <= 430) {
            audio_play_sound(snd_Recusado, 1, false);
            exibir_troca_fase = false;
        }
    }
}