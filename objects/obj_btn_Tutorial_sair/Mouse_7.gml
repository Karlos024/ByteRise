if (visible) {
    image_xscale = 0.5;
    image_yscale = 0.5;
    audio_play_sound(snd_Screen_change, 1, false);
    
    if (instance_exists(obj_ctld_Tutorial)) {
        var fases = obj_ctld_Tutorial.fase;
        
		//VERIFICA QUAL TUTORIAL FECHAR
        if (fases == 1) {
            global.tutorial_1 = false;
            room_goto(rm_Tela_principal_1);
        } 
		
		//FASE 2 COMPRADA
        else if (fases == 2) {
            global.tutorial_2 = false; 
            global.comprada_2 = true; 
            room_goto(rm_Tela_principal_2);
        }
		
		//FASE 3 COMPRADA
        else if (fases == 3) {
            global.tutorial_3 = false; 
            global.comprada_3 = true; 
            room_goto(rm_Tela_principal_3);
        }
    }
}