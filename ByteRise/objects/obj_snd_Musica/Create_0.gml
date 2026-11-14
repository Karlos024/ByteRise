//GARANTE QUE SÓ EXISTA UM CONTROLADOR DE MÚSICA NO JOGO INTEIRO
if (instance_number(obj_snd_Musica) > 1) {
    instance_destroy();
    exit;
}

//PROTEÇÃO
if (!variable_global_exists("ms_ligada")) {
    global.ms_ligada = true;
}

//PRIMEIRA VEZ
if (!audio_is_playing(snd_Musica) && global.ms_ligada == true) {
    audio_play_sound(snd_Musica, 10, true);
}