if (!tutorial_permite(object_index)) exit;
//CANCELA COM AS CONFIGURAÇÕES ABERTA
if (instance_exists(obj_ctld_Configuracoes) && obj_ctld_Configuracoes.exibir_config) {
    exit;
}

//PARAR AVISO AO CLICAR NO CELULAR
if (variable_instance_exists(id, "id_som_missao")) {
    if (id_som_missao != -1) {
        audio_stop_sound(id_som_missao);
        id_som_missao = -1;
    }
}

animando_missao = false;
image_speed = 0;
image_index = 0;
image_xscale = 0.8;
image_yscale = 0.8;
audio_play_sound(snd_Screen_change, 1, false);