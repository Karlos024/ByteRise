//SE TIVER DENTRO DA CONFIRMAÇÃO NÃO MOSTRAR O BOTÃO DE MÚSICA
if (instance_exists(obj_ctld_Fim_confirmacao) && obj_ctld_Fim_confirmacao.exibir_confirmacao == true) {
    mouse_clear(mb_left);
    exit; 
}

image_xscale = 1;
image_yscale = 1;
audio_play_sound(snd_Screen_change, 1, false);

global.ms_ligada = !global.ms_ligada;
image_index = !global.ms_ligada;
if (global.ms_ligada) { 
    audio_sound_gain(snd_Musica, 1, 0); 
} else { 
    audio_sound_gain(snd_Musica, 0, 0); 
}