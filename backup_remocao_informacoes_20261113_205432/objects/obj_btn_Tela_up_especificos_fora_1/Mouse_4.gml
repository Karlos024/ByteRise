if (!tutorial_permite(object_index)) exit;
//SE TIVER DENTRO DAS CONFIGURAÇÕES NÃO MOSTRAR O BOTÃO ESPECÍFICOS
if (instance_exists(obj_ctld_Configuracoes) && obj_ctld_Configuracoes.exibir_config == true) {
    mouse_clear(mb_left);
    exit; 
}

image_xscale = 1.2;
image_yscale = 0.838;
audio_play_sound(snd_Screen_change, 1, false);