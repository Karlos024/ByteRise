if (exibir_confirmacao == true) {
    if (mouse_check_button_pressed(mb_left)) {
        var Som_ativo = true;
        if (variable_global_exists("sc_ligado")) {
            Som_ativo = global.sc_ligado;
        }
		
		//SE PRESSIONAR O BOTÃO DE COMPRAR VAI PRO FINAL
        if (mouse_x >= 90 && mouse_x <= 150 && mouse_y >= 390 && mouse_y <= 430) {
            if (Som_ativo) {
                audio_play_sound(snd_Compra, 1, false);
            }

            instance_destroy();
            room_goto(rm_Cutscene_final);
        }
        
		//SE PRESSIONAR O BOTÃO DE CANCELAR SÓ APAGA O OBJETO
        if (mouse_x >= 210 && mouse_x <= 270 && mouse_y >= 390 && mouse_y <= 430) {
            if (Som_ativo) {
                audio_play_sound(snd_Recusado, 1, false);
            }            
            instance_destroy();
        }
    }
}