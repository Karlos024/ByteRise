if (global.ms_ligada) {
    if (!audio_is_playing(snd_Fim)) {
        audio_play_sound(snd_Fim, 10, true);
    }
} else {
    if (audio_is_playing(snd_Fim)) {
        audio_stop_sound(snd_Fim);
    }
}