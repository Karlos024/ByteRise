if (!f3_tutorial_permite(object_index)) exit;
if (instance_exists(obj_ctld_Carreira) && obj_ctld_Carreira.exibir_progresso) exit;
if (instance_exists(obj_ctld_Troca) && obj_ctld_Troca.exibir_troca_fase) exit;
if (!tutorial_permite(object_index)) exit;
//CANCELA COM AS CONFIGURAÇÕES ABERTA
if (instance_exists(obj_ctld_Configuracoes) && obj_ctld_Configuracoes.exibir_config) {
    exit;
}

image_xscale = 1;
image_yscale = 1;

if (device_mouse_check_button_released(0, mb_left)) {
    
    //VERIFICA SE O SOM ESTÁ ATIVADO NAS CONFIGURAÇÕES
    var Ativado = true;
    if (variable_global_exists("sc_ligado")) {
        Ativado = global.sc_ligado;
    } else {
        Ativado = true;
    }

    //SE JÁ ATINGIU O MÁXIMO
    if (global.hd_ssd >= 15) {
        if (Ativado) {
            audio_play_sound(snd_Maximo, 1, false);
        }
    }
	
    //SE NÃO ATINGIU O MÁXIMO, COMPRA UTILIZANDO AS MOEDAS
    else {
        var valor = [0, 2500, 8000, 16000, 28000, 45000, 67000, 95000, 130000, 175000, 230000, 295000, 370000, 460000, 570000];
        var valor_atual = valor[global.hd_ssd]; 
        
        //CASO TENHA MOEDAS SUFICIENTE
        if (global.moedas >= valor_atual) {
            global.moedas -= valor_atual;
            global.hd_ssd += 1;
            if (Ativado) {
                audio_play_sound(snd_Compra, 1, false);
            }
        }
		
        //CASO NÃO TENHA MOEDAS SUFICIENTES
        else {
            if (Ativado) {
                audio_play_sound(snd_Recusado, 1, false);
            }
        }
    }
}
