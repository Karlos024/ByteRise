if (image_index < image_number - 1) {
    image_index += 1;
    audio_play_sound(snd_Passando, 10, false);
    caracteres_visiveis = 0;
    texto_anterior = "";
    proximo_som = 1;
    palavras_contadas = 0;
    ultimo_caractere = 0;
    var duracao_quadro = (image_index == 1) ? 11 : 14;
    alarm[0] = round(game_get_speed(gamespeed_fps) * duracao_quadro);
} else {
    room_goto(rm_Tutorial_1);
}
