//INICIALIZAÇÃO DOS EVENTOS
if (!variable_global_exists("ms_superclique_tempo")) {
    global.ms_superclique_tempo = 0;
}
if (!variable_global_exists("ms_superclique_nivel")) {
    global.ms_superclique_nivel = 0;
}
if (!variable_global_exists("ms_superclique_bonus")) {
    global.ms_superclique_bonus = 0;
}
if (!variable_global_exists("ms_fliperama_tempo")) {
    global.ms_fliperama_tempo = 0;
}
if (!variable_global_exists("ms_fliperama_nivel")) {
    global.ms_fliperama_nivel = 0;
}
if (!variable_global_exists("ms_casa_tempo")) {
    global.ms_casa_tempo = 0;
}
if (!variable_global_exists("ms_casa_nivel")) {
    global.ms_casa_nivel = 0;
}
if (!variable_global_exists("ms_vip_tempo")) {
    global.ms_vip_tempo = 0;
}
if (!variable_global_exists("ms_vip_nivel")) {
    global.ms_vip_nivel = 0;
}
if (!variable_global_exists("ms_turbo_tempo")) {
    global.ms_turbo_tempo = 0;
}
if (!variable_global_exists("ms_turbo_nivel")) {
    global.ms_turbo_nivel = 0;
}
if (!variable_global_exists("ms_esbanjadora_tempo")) {
    global.ms_esbanjadora_tempo = 0;
}
if (!variable_global_exists("ms_esbanjadora_nivel")) {
    global.ms_esbanjadora_nivel = 0;
}
if (!variable_global_exists("ms_vidente_tempo")) {
    global.ms_vidente_tempo = 0;
}
if (!variable_global_exists("ms_vidente_nivel")) {
    global.ms_vidente_nivel = 0;
}
if (!variable_global_exists("ms_entrega_tempo")) {
    global.ms_entrega_tempo = 0;
}
if (!variable_global_exists("ms_entrega_nivel")) {
    global.ms_entrega_nivel = 0;
}
if (!variable_global_exists("ms_producao_tempo")) {
    global.ms_producao_tempo = 0;
}
if (!variable_global_exists("ms_producao_nivel")) {
    global.ms_producao_nivel = 0;
}
if (!variable_global_exists("ms_superproducao_tempo")) {
    global.ms_superproducao_tempo = 0;
}
if (!variable_global_exists("ms_superproducao_nivel")) {
    global.ms_superproducao_nivel = 0;
}

//TEMPO DECORRIDO
var tempo_decorrido = delta_time / 1000000;

//SUPER CLIQUE
if (global.ms_superclique_tempo > 0) {
    global.ms_superclique_tempo -= tempo_decorrido;
    if (global.ms_superclique_tempo <= 0) {
        global.ms_superclique_tempo = 0;
        global.ms_superclique_nivel = 0;
        global.ms_superclique_bonus = 0;
    }
}

//FLIPERAMA TURBO
if (global.ms_fliperama_tempo > 0) {
    global.ms_fliperama_tempo -= tempo_decorrido;
    if (global.ms_fliperama_tempo <= 0) {
        global.ms_fliperama_tempo = 0;
        global.ms_fliperama_nivel = 0;
    }
}

//CASA LOTADA
if (global.ms_casa_tempo > 0) {
    global.ms_casa_tempo -= tempo_decorrido;
    if (global.ms_casa_tempo <= 0) {
        global.ms_casa_tempo = 0;
        global.ms_casa_nivel = 0;
    }
}

//FREGUESIA VIP
if (global.ms_vip_tempo > 0) {
    global.ms_vip_tempo -= tempo_decorrido;
    if (global.ms_vip_tempo <= 0) {
        global.ms_vip_tempo = 0;
        global.ms_vip_nivel = 0;
    }
}

//OFICINA TURBO
if (global.ms_turbo_tempo > 0) {
    global.ms_turbo_tempo -= tempo_decorrido;
    if (global.ms_turbo_tempo <= 0) {
        global.ms_turbo_tempo = 0;
        global.ms_turbo_nivel = 0;
    }
}

//INVASÃO ESBANJADORA
if (global.ms_esbanjadora_tempo > 0) {
    global.ms_esbanjadora_tempo -= tempo_decorrido;
    if (global.ms_esbanjadora_tempo <= 0) {
        global.ms_esbanjadora_tempo = 0;
        global.ms_esbanjadora_nivel = 0;
    }
}

//VIDENTE
if (global.ms_vidente_tempo > 0) {
    global.ms_vidente_tempo -= tempo_decorrido;
    if (global.ms_vidente_tempo <= 0) {
        global.ms_vidente_tempo = 0;
        global.ms_vidente_nivel = 0;
    }
}

//ENTREGA EXPRESSA
if (global.ms_entrega_tempo > 0) {
    global.ms_entrega_tempo -= tempo_decorrido;
    if (global.ms_entrega_tempo <= 0) {
        global.ms_entrega_tempo = 0;
        global.ms_entrega_nivel = 0;
    }
}

//PRODUÇÃO EM MASSA
if (global.ms_producao_tempo > 0) {
    global.ms_producao_tempo -= tempo_decorrido;
    if (global.ms_producao_tempo <= 0) {
        global.ms_producao_tempo = 0;
        global.ms_producao_nivel = 0;
    }
}

//SUPERPRODUÇÃO
if (global.ms_superproducao_tempo > 0) {
    global.ms_superproducao_tempo -= tempo_decorrido;
    if (global.ms_superproducao_tempo <= 0) {
        global.ms_superproducao_tempo = 0;
        global.ms_superproducao_nivel = 0;
    }
}

// VERIFICA SE O EVENTO ESTA ATIVO
var evento_ativo = (global.ms_superclique_tempo > 0 || global.ms_fliperama_tempo > 0 || global.ms_casa_tempo > 0 || global.ms_vip_tempo > 0 || global.ms_turbo_tempo > 0 || global.ms_esbanjadora_tempo > 0 || global.ms_vidente_tempo > 0 || global.ms_entrega_tempo > 0 || global.ms_producao_tempo > 0 || global.ms_superproducao_tempo > 0);

//CONTROLE DA MÚSICA
var som_ligado = (variable_global_exists("sc_ligado") && global.sc_ligado);

if (evento_ativo && som_ligado) {
    if (audio_is_playing(snd_Musica)) {
        audio_stop_sound(snd_Musica);
        musica_interrompida = true;
    }
    if (!audio_is_playing(id_som_evento)) {
        id_som_evento = audio_play_sound(snd_Evento, 1, true);
    }
} else {

    //DESATIVA A MÚSICA DO EVENTO
    if (id_som_evento != -1) {
        audio_stop_sound(id_som_evento);
        id_som_evento = -1;
    }

    //VOLTA A MÚSICA PRINCIPAL
    if (!evento_ativo && som_ligado && musica_interrompida) {

        if (!audio_is_playing(snd_Musica)) {
            audio_play_sound(snd_Musica, 1, true);
        }

        musica_interrompida = false;
    }
}