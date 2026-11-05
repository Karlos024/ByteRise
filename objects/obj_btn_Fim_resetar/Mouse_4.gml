//SE TIVER DENTRO DAS ESTATÍSTICAS NÃO MOSTRAR O RESETAR
if (instance_exists(obj_ctld_Fim_estatisticas) && obj_ctld_Fim_estatisticas.exibir_estatisticas == true) {
    mouse_clear(mb_left);
    exit; 
}

image_xscale = 0.9;
image_yscale = 0.9;
audio_play_sound(snd_Screen_change, 1, false);