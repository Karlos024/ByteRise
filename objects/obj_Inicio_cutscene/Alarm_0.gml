if (image_index < image_number - 1) {
    image_index += 1;
    audio_play_sound(snd_Passando, 10, false);
    caracteres_visiveis = 0;
    texto_anterior = "";
    proximo_som = 1;
    palavras_contadas = 0;
    ultimo_caractere = 0;
    alarm[0] = round(game_get_speed(gamespeed_fps) * 14);
} else {
    room_goto(rm_Tutorial_1);
}