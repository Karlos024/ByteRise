//PARAR A MÚSICA AO DESTRUIR O CONTROLADOR
if (variable_instance_exists(id, "id_som_evento")) {
    if (id_som_evento != -1) {
        audio_stop_sound(id_som_evento);
        id_som_evento = -1;
    }
}

//RESTAURAR A MÚSICA PRINCIPAL
if (variable_instance_exists(id, "musica_interrompida")) {
    if (musica_interrompida) {
        if (variable_global_exists("sc_ligado") && global.sc_ligado) {
            if (!audio_is_playing(snd_Musica)) {
                audio_play_sound(snd_Musica, 1, true);
            }
        }
        musica_interrompida = false;
    }
}