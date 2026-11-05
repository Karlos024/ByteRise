//SE TIVER DENTRO DAS ESTATÍSTICAS NÃO MOSTRAR ESTATÍSTICAS
if (instance_exists(obj_ctld_Fim_estatisticas) && obj_ctld_Fim_estatisticas.exibir_estatisticas == true) {
    mouse_clear(mb_left);
    exit; 
}

image_xscale = 2.9;
image_yscale = 0.6;
audio_play_sound(snd_Screen_change, 1, false);