audio_sound_gain(snd_Troca_de_tela, 1, 0);

//GARANTE QUE O OBJETO SOBRE NÃO DUPLIQUE
if (!instance_exists(obj_ctld_Inicio_sobre)) {
    instance_create_layer(0, 0, "Instances", obj_ctld_Inicio_sobre);
}