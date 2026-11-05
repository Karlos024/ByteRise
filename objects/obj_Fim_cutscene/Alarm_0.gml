if (image_index < image_number - 1) {
    image_index += 1;
    audio_play_sound(snd_Passando, 10, false);
    alarm = game_get_speed(gamespeed_fps) * 4.5; 
} 
else {
    room_goto(rm_Tela_final);
}