segundos_decorridos = 0;
fase = 2;

if (!variable_global_exists("ms_esbanjadora_tempo")) {
    global.ms_esbanjadora_tempo = 0;
}

if (!variable_global_exists("ms_esbanjadora_nivel")) {
    global.ms_esbanjadora_nivel = 0;
}

alarm[0] = game_get_speed(gamespeed_fps);