//DECLARAÇÂO DE VARIÁVEIS DAS CONFIGURAÇÕES
global.ms_ligada     = true;  
global.sc_ligado     = true;

audio_sound_gain(snd_Musica, 0.30, 0);
audio_sound_gain(snd_Troca_de_tela, 1, 0);

//GARANTE QUE O OBJETO SOBRE NÃO DUPLIQUE
if (!instance_exists(obj_ctld_Configuracoes)) {
    instance_create_layer(0, 0, "Instances", obj_ctld_Configuracoes);
} 