//DECLARAÇÂO DE VARIÁVEIS DAS CONFIGURAÇÕES
// OUTROS CONTROLADORES PODEM CONSULTAR ESTE OBJETO ANTES DO SEU ROOM START.
exibir_config = false;
depth = -15600;
btn_Final = noone;
btn_Musica = noone;
btn_Efeitos_sonoros = noone;
btn_Idiomas = noone;
btn_Exportar = noone;
btn_Importar = noone;
btn_Creditos = noone;
if (!variable_global_exists("ms_ligada")) global.ms_ligada = true;
if (!variable_global_exists("sc_ligado")) global.sc_ligado = true;

audio_sound_gain(snd_Musica, 0.30, 0);
audio_sound_gain(snd_Troca_de_tela, 1, 0);

//GARANTE QUE O OBJETO SOBRE NÃO DUPLIQUE
if (!instance_exists(obj_ctld_Configuracoes)) {
    instance_create_layer(0, 0, "Instances", obj_ctld_Configuracoes);
} 
