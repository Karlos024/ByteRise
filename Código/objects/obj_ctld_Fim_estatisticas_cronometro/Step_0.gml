//ACUMULA OS SEGUNDOS
global.cronometro += (1 / game_get_speed(gamespeed_fps));

//SOMA DA FASE 1
if (room == rm_Tela_principal_1 || room == rm_up_Especificos_1 || room == rm_up_Gerais_1) {
    global.tempo_fase_1 += (1 / game_get_speed(gamespeed_fps));
}

//SOMA DA FASE 2
else if (room == rm_Tela_principal_2 || room == rm_up_Especificos_2 || room == rm_up_Gerais_2) {
    global.tempo_fase_2 += (1 / game_get_speed(gamespeed_fps));
}

//SOMA DA FASE 3
else if (room == rm_Tela_principal_3 || room == rm_up_Especificos_3 || room == rm_up_Gerais_3) {
    global.tempo_fase_3 += (1 / game_get_speed(gamespeed_fps));
}