sprite_index = spr_Fim_cutscene;
image_speed = 0;
image_index = 0;
alarm[0] = round(game_get_speed(gamespeed_fps) * 9);

//CONFIGURAÇÃO DA ESCRITA
caracteres_visiveis = 0;
velocidade_escrita = 0.3;
texto_atual = "";
texto_anterior = "";
proximo_som = 1;
palavras_contadas = 0;
ultimo_caractere = 0;
som_atual = noone;

//PARAR AS MÚSICAS ATUAIS
audio_stop_sound(snd_Musica);
audio_stop_sound(snd_Evento);
audio_stop_sound(snd_Missao);