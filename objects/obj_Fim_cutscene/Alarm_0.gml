if (floor(image_index) < sprite_get_number(spr_Fim_cutscene) - 1) {
    image_index = floor(image_index) + 1;
    audio_play_sound(snd_Passando, 10, false);
    caracteres_visiveis = 0;
    texto_anterior = "";
    proximo_som = 1;
    palavras_contadas = 0;
    ultimo_caractere = 0;
    alarm[0] = round(game_get_speed(gamespeed_fps) * 9);
} else {
    room_goto(rm_Tela_final);
}