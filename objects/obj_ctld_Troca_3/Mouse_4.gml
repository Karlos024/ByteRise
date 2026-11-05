//SE TIVER DENTRO DAS CONFIGURAÇÕES NÃO MOSTRAR O BOTÃO TROCA DE FASE
if (instance_exists(obj_ctld_Configuracoes) && obj_ctld_Configuracoes.exibir_config == true) {
    mouse_clear(mb_left);
    exit; 
}

image_xscale = 0.4;
image_yscale = 0.4;
audio_play_sound(snd_Screen_change, 1, false);