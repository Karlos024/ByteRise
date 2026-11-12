audio_stop_sound(snd_Escrevendo_1);
audio_stop_sound(snd_Escrevendo_2);

if (global.ms_ligada) {
    if (!audio_is_playing(snd_Musica)) {
        audio_play_sound(snd_Musica, 10, true);
    }
}