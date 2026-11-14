if (global.nivel < 30) {

    //SE A EXPERIÊNCIA PASSOU OU IGUALOU O LIMITE DO NÍVEL
    if (global.experiencia_atual >= global.experiencia[global.nivel]) {

        //GUARDA O QUE SOBROU E COLOCA O NOVO NÍVEL E EXPERIÊNCIA
        global.experiencia_atual -= global.experiencia[global.nivel];
        global.nivel += 1;
        global.experiencia_maximo = global.experiencia[global.nivel];

        if (variable_global_exists("sc_ligado") && global.sc_ligado == true) {
            audio_play_sound(snd_Nivel, 1, false);
        }
    }
} else {

    //TRAVA SE CHEGAR NO NÍVEL MÁXIMO
    if (global.experiencia_atual > global.experiencia[30]) {
        global.experiencia_atual = global.experiencia[30];
    }
}

//EVENTO DA MISSÃO - CHUVA DE XP
if (global.ms_chuva_tempo > 0) {
    global.ms_chuva_tempo = max(0, global.ms_chuva_tempo - delta_time / 1000000);

    if (global.ms_chuva_tempo <= 0) {
        global.ms_chuva_nivel = 0;
    }
}