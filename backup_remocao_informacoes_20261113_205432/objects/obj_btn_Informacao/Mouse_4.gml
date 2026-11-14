if (!tutorial_permite(object_index)) exit;
//SE ESTIVER ABERTO IGNORA O CLIQUE
var Config_Aberta = false;
if (instance_exists(obj_ctld_Configuracoes)) {
    Config_Aberta = obj_ctld_Configuracoes.exibir_config;
}
if (Config_Aberta == true) {
    exit;
}

image_xscale = 0.4;
image_yscale = 0.4;
audio_play_sound(snd_Screen_change, 1, false);