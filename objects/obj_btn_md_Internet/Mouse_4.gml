//CANCELA COM AS CONFIGURAÇÕES ABERTA
if (instance_exists(obj_ctld_Configuracoes) && obj_ctld_Configuracoes.exibir_config) {
    exit;
}

image_xscale = 0.9;
image_yscale = 0.9;

if (mouse_check_button_pressed(mb_left)) {
    
    //VERIFICA SE O SOM ESTÁ ATIVADO NAS CONFIGURAÇÕES
    var Ativado = true;
    if (variable_global_exists("sc_ligado")) {
        Ativado = global.sc_ligado;
    } else {
        Ativado = true;
    }

    //SE JÁ ATINGIU O MÁXIMO
    if (global.internet >= 3) {
        if (Ativado) {
            audio_play_sound(snd_Maximo, 1, false);
        }
    }
	
    //SE NÃO ATINGIU O MÁXIMO, COMPRA UTILIZANDO AS MOEDAS
    else {
        var valor =[5000, 15000, 35000];
        var valor_atual = valor[global.internet]; 
        
        //CASO TENHA MOEDAS SUFICIENTE
        if (global.moedas >= valor_atual) {
            global.moedas -= valor_atual;
            global.internet += 1;
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