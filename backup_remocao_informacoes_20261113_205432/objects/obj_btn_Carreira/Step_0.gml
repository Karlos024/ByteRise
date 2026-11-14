
//DECLARAÇÃO DE VÁRIAVEIS
if (!variable_global_exists("ms_patentes")) global.ms_patentes = array_create(12, 0);
if (!variable_global_exists("ms_progressos")) global.ms_progressos = array_create(12, 0);
if (!variable_global_exists("ms_avisadas")) global.ms_avisadas = array_create(12, 0);
if (!variable_global_exists("ms_superclique")) global.ms_superclique = 0;
if (!variable_global_exists("xp_acumulado")) global.xp_acumulado = 0;
if (!variable_global_exists("moedas_acumuladas")) global.moedas_acumuladas = 0;
if (!variable_global_exists("fliperama_1")) global.fliperama_1 = 0;
if (!variable_global_exists("fliperama_2")) global.fliperama_2 = 0;
if (!variable_global_exists("fliperama_3")) global.fliperama_3 = 0;
if (!variable_global_exists("ms_casa_atendimentos")) global.ms_casa_atendimentos = 0;
if (!variable_global_exists("ms_vip_atendimentos")) global.ms_vip_atendimentos = 0;
if (!variable_global_exists("ms_esbanjadora_atendimentos")) global.ms_esbanjadora_atendimentos = 0;
if (!variable_global_exists("ms_turbo_reparos")) global.ms_turbo_reparos = 0;
if (!variable_global_exists("ms_f3_entregas")) global.ms_f3_entregas = 0;
if (!variable_global_exists("ms_f3_producao")) global.ms_f3_producao = 0;
if (!variable_global_exists("celular")) global.celular = 0;
if (!variable_global_exists("tablet")) global.tablet = 0;
if (!variable_global_exists("notebook")) global.notebook = 0;

//ATUALIZA PROGRESSO
global.ms_progressos[0] = global.xp_acumulado;
global.ms_progressos[1] = global.ms_superclique;
global.ms_progressos[2] = global.moedas_acumuladas;
global.ms_progressos[3] = global.ms_casa_atendimentos;
global.ms_progressos[4] = clamp(global.fliperama_1, 0, 15) + clamp(global.fliperama_2, 0, 15) + clamp(global.fliperama_3, 0, 15);
global.ms_progressos[5] = global.ms_vip_atendimentos;
global.ms_progressos[6] = global.ms_esbanjadora_atendimentos;
global.ms_progressos[7] = global.ms_turbo_reparos;
global.ms_progressos[9] = global.ms_f3_entregas;
global.ms_progressos[10] = global.ms_f3_producao;
global.ms_progressos[11] = global.celular + global.tablet + global.notebook;

//METAS DAS MISSÕES
var metas = [
    [5000, 15000, 40000],
    [500, 1500, 4000],
    [50000, 150000, 400000],

    [10, 100, 300],
    [5, 15, 30],
    [20, 50, 100],

    [15, 40, 80],
    [25, 75, 150],
    [5, 30, 100],

    [30, 80, 150],
    [50, 100, 400],
    [9, 27, 45]
];

///CANCELA COM AS CONFIGURAÇÕES ABERTA
var configuracoes_abertas = false;
if (instance_exists(obj_ctld_Configuracoes)) {
    configuracoes_abertas = obj_ctld_Configuracoes.exibir_config;
}

///CANCELA COM O CELULAR ABERTO
var celular_aberto = false;
if (instance_exists(obj_ctld_Carreira)) {
    celular_aberto = obj_ctld_Carreira.exibir_progresso;
}

//VERIFICAÇÃO DE MISSÕES DISPONÍVEIS
var notificacao = false;
for (var i = 0; i < 12; i++) {
    var nivel = global.ms_patentes[i];
    if (nivel < 3) {
        if (global.ms_progressos[i] >= metas[i][nivel]) {
            if (global.ms_avisadas[i] <= nivel) {
                notificacao = true;
            }
        }
    }
}

//MARCA MISSÕES
if (celular_aberto) {
    for (var i = 0; i < 12; i++) {
        var nivel = global.ms_patentes[i];
        if (nivel < 3) {
            if (global.ms_progressos[i] >= metas[i][nivel]) {
                global.ms_avisadas[i] = nivel + 1;
            }
        }
    }
    notificacao = false;
}

if (configuracoes_abertas || celular_aberto) {
    notificacao = false;
}

//ANIMAÇÃO E SOM
if (notificacao) {
    image_speed = 0.2;
    if (image_index > 8) {
        image_index = 0;
    }
    if (variable_global_exists("sc_ligado") && global.sc_ligado) {
        if (!audio_is_playing(snd_Missao)) {
            audio_play_sound(snd_Missao, 1, true);
        }
    }
} else {
    image_speed = 0;
    image_index = 0;
    if (audio_is_playing(snd_Missao)) {
        audio_stop_sound(snd_Missao);
    }
}