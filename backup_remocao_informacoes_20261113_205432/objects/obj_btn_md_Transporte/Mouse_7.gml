if (!melhoria_soltar_gesto(id)) exit;
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
    if (global.transporte >= 3) {
        if (Ativado) {
            audio_play_sound(snd_Maximo, 1, false);
        }
    }
	
    //SE NÃO ATINGIU O MÁXIMO, COMPRA UTILIZANDO AS MOEDAS
    else {
        var valor =[90000, 220000, 500000];
        var valor_atual = valor[global.transporte]; 
        
        //CASO TENHA MOEDAS SUFICIENTE
        if (global.moedas >= valor_atual) {
            global.moedas -= valor_atual;
            global.transporte += 1;
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
