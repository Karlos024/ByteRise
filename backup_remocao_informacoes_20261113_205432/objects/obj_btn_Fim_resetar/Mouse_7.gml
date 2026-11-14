if (!tutorial_permite(object_index)) exit;
//DESATIVA A MÚSICA DO FIM
if (audio_is_playing(snd_Fim)) {
    audio_stop_sound(snd_Fim);
}
audio_stop_all();

//RESETA CONFIGURAÇÕES
global.idm        = 0;
global.ms_ligada  = true;
global.sc_ligado  = true;

//RESTAURA EFEITOS SONOROS
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
global.tutorial_f1_concluido = false;
global.tutorial_f1_iniciado = false;
global.tutorial_f2_concluido = false;
global.tutorial_f3_concluido = false;
global.tutorial_melhoria_concluido = false;
global.tutorial_missao_concluido = false;
global.tutorial_missao_pendente = -1;
f3_limpar_producao();
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

//DESTROI E RESETA EXPERIÊNCIA
global.nivel              = 1;
global.experiencia_atual  = 0;
global.experiencia_maximo = 100;
if (instance_exists(obj_ctld_Experiencia)) {
    instance_destroy(obj_ctld_Experiencia);
}

//RESETA CRÉDITOS
global.creditos = false;

//RESETA PATENTES E PROGRESSO DAS MISSÕES
global.ms_patentes = array_create(12, 0);
global.ms_progressos = array_create(12, 0);
global.ms_avisadas = array_create(12, 0);

//RESETA CONTADORES DAS MISSÕES
global.xp_acumulado = 0;
global.ms_superclique = 0;
global.ms_casa_atendimentos = 0;
global.ms_vip_atendimentos = 0;
global.ms_esbanjadora_atendimentos = 0;
global.ms_turbo_reparos = 0;
global.ms_f3_entregas = 0;
global.ms_f3_producao = 0;
global.ms_f3_superproducao = 0;

//RESETA SUPER CLIQUE
global.ms_superclique_nivel = 0;
global.ms_superclique_tempo = 0;
global.ms_superclique_bonus = 0;
global.ms_superclique_ultimo_clique = -1;

//RESETA CHUVA DE XP
global.ms_chuva_nivel = 0;
global.ms_chuva_tempo = 0;

//RESETA TAXAÇÃO
global.ms_taxacao_nivel = 0;
global.ms_taxacao_tempo = 0;

//RESETA CASA LOTADA
global.ms_casa_nivel = 0;
global.ms_casa_tempo = 0;

//RESETA FLIPERAMA TURBO
global.ms_fliperama_nivel = 0;
global.ms_fliperama_tempo = 0;

//RESETA FREGUESIA VIP
global.ms_vip_nivel = 0;
global.ms_vip_tempo = 0;

//RESETA INVASÃO ESBANJADORA
global.ms_esbanjadora_nivel = 0;
global.ms_esbanjadora_tempo = 0;

//RESETA OFICINA TURBO
global.ms_turbo_nivel = 0;
global.ms_turbo_tempo = 0;

//RESETA VIDENTE
global.ms_vidente_nivel = 0;
global.ms_vidente_tempo = 0;

//RESETA ENTREGA EXPRESSA
global.ms_entrega_nivel = 0;
global.ms_entrega_tempo = 0;

//RESETA PRODUÇÃO EM MASSA
global.ms_producao_nivel = 0;
global.ms_producao_tempo = 0;

//RESETA SUPERPRODUÇÃO
global.ms_superproducao_nivel = 0;
global.ms_superproducao_tempo = 0;

//RESETA INTERFACE DAS MISSÕES
if (instance_exists(obj_ctld_Missao)) {
    with (obj_ctld_Missao) {
        instance_destroy();
    }
}

//RESETA CONTROLADOR DOS EVENTOS
if (instance_exists(obj_ctld_Eventos)) {
    with (obj_ctld_Eventos) {
        instance_destroy();
    }
}

//RESETA VISUAL



// LIMPA O SALVAMENTO E O QUE NÃO PERTENCE À NOVA PARTIDA.
global.ms_vidente_atendimentos = 0;
global.moedas_final = 0;
global.bloquear_clique_celular = false;
global.exibir_config = false;
global.progresso_salvo = false;
global.save_carregado = true;
if (file_exists("save_backup.ini")) file_delete("save_backup.ini");
if (file_exists("save_importacao.tmp")) file_delete("save_importacao.tmp");
progresso_limpar_instancias();
progresso_aplicar_audio();
room_goto(rm_Tela_inicial);
