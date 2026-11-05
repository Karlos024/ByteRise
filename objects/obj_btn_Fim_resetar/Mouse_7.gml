 //DESATIVA A MÚSICA DO FIM
if (audio_is_playing(snd_Fim)) {
    audio_stop_sound(snd_Fim);
}
audio_stop_all();

//RESETA CONFIGURAÇÕES
global.idm        = 0;
global.ms_ligada  = true;
global.sc_ligado  = true;

//RESTAURA EFEITOS SONORS
audio_sound_gain(snd_Musica, 1, 0);
audio_sound_gain(snd_Botao, 1, 0);
audio_sound_gain(snd_Compra, 1, 0);
audio_sound_gain(snd_Maximo, 1, 0);
audio_sound_gain(snd_Troca_de_tela, 1, 0);
audio_sound_gain(snd_Recusado, 1, 0);

//RESETA GERAIS DE APRIMORAMENTO
global.internet      = 0;
global.funcionario_1 = 0;
global.cenario_1     = 0;
global.energia       = 0;
global.funcionario_2 = 0;
global.cenario_2     = 0;
global.cafe          = 0;
global.funcionario_3 = 0;
global.transporte    = 0;

//RESETA ESPECÍFICAS DE APRIMORAMENTO
global.fliperama_1   = 0;
global.fliperama_2   = 0;
global.fliperama_3   = 0;
global.hd_ssd        = 0;
global.gpu           = 0;
global.psu           = 0;
global.celular       = 0;
global.tablet        = 0;
global.notebook      = 0;

//RESETA TROCA E COMPRA DE FASES
global.comprada_2 = false; 
global.comprada_3 = false;
global.fase_atual = 1;

//RESETA CRONÔMETRO E ESTATÍSTICAS DO JOGO
global.cronometro    = 0;
global.tempo_fase_1  = 0;
global.tempo_fase_2  = 0;
global.tempo_fase_3  = 0;

//RESETA OS CLIQUES
global.total_cliques = 0;

//DESTROI CRONÔMETRO
if (instance_exists(obj_ctld_Fim_estatisticas_cronometro)) {
    instance_destroy(obj_ctld_Fim_estatisticas_cronometro);
}

//RESTAURA A MÚSICA
if (global.ms_ligada == true) {
    if (!audio_is_playing(snd_Musica)) {
        audio_play_sound(snd_Musica, 10, true);
    }
}

//FECHA CONFIGURAÇÕES
if (instance_exists(obj_ctld_Configuracoes)) {
    obj_ctld_Configuracoes.exibir_config = false;
}

//DESTROI E RESETA MOEDAS
global.moedas             = 0;
global.moedas_acumuladas  = 0;
if (instance_exists(obj_ctld_Moeda)) {
    instance_destroy(obj_ctld_Moeda);
}

//DESTROI E RESETA MOEDAS
global.nivel              = 1;
global.experiencia_atual  = 0;
global.experiencia_maximo = 250;
if (instance_exists(obj_ctld_Experiencia)) {
    instance_destroy(obj_ctld_Experiencia);
}

//RESETA CRÉDITOS
global.creditos = false;

image_xscale = 1;
image_yscale = 1;
room_goto(rm_Tela_inicial);