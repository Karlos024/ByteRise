//GERA O BACKUP CRIPTOGRAFADO EM TEXTO E COPIA
function exportar_progresso() {
    ini_open("save_backup.ini");
    ini_write_real("Config", "idm", global.idm);
    ini_write_real("Config", "ms_ligada", global.ms_ligada);
    ini_write_real("Config", "sc_ligado", global.sc_ligado);
    ini_write_real("Upgrades", "internet", global.internet);
    ini_write_real("Upgrades", "funcionario_1", global.funcionario_1);
    ini_write_real("Upgrades", "cenario_1", global.cenario_1);
    ini_write_real("Upgrades", "energia", global.energia);
    ini_write_real("Upgrades", "funcionario_2", global.funcionario_2);
    ini_write_real("Upgrades", "cenario_2", global.cenario_2);
    ini_write_real("Upgrades", "cafe", global.cafe);
    ini_write_real("Upgrades", "funcionario_3", global.funcionario_3);
    ini_write_real("Upgrades", "transporte", global.transporte);
    ini_write_real("Upgrades_Esp", "fliperama_1", global.fliperama_1);
    ini_write_real("Upgrades_Esp", "fliperama_2", global.fliperama_2);
    ini_write_real("Upgrades_Esp", "fliperama_3", global.fliperama_3);
    ini_write_real("Upgrades_Esp", "hd_ssd", global.hd_ssd);
    ini_write_real("Upgrades_Esp", "gpu", global.gpu);
    ini_write_real("Upgrades_Esp", "psu", global.psu);
    ini_write_real("Upgrades_Esp", "celular", global.celular);
    ini_write_real("Upgrades_Esp", "tablet", global.tablet);
    ini_write_real("Upgrades_Esp", "notebook", global.notebook);
    ini_write_real("Fases", "comprada_2", global.comprada_2);
    ini_write_real("Fases", "comprada_3", global.comprada_3);
    ini_write_real("Fases", "fase_atual", global.fase_atual);
    ini_write_real("Stats", "cronometro", global.cronometro);
    ini_write_real("Stats", "tempo_fase_1", global.tempo_fase_1);
    ini_write_real("Stats", "tempo_fase_2", global.tempo_fase_2);
    ini_write_real("Stats", "tempo_fase_3", global.tempo_fase_3);
    ini_write_real("Stats", "total_cliques", global.total_cliques);
    ini_write_real("Progresso", "creditos", global.creditos);
    ini_write_real("Progresso", "moedas", global.moedas);
    ini_write_real("Progresso", "moedas_acumuladas", global.moedas_acumuladas);
    ini_write_real("Progresso", "nivel", global.nivel);
    ini_write_real("Progresso", "experiencia_atual", global.experiencia_atual);
    ini_write_real("Progresso", "experiencia_maximo", global.experiencia_maximo);

    //MISSÕES - PATENTES E NOTIFICAÇÕES
    if (!variable_global_exists("ms_patentes")) global.ms_patentes = array_create(12, 0);
    if (!variable_global_exists("ms_progressos")) global.ms_progressos = array_create(12, 0);
    if (!variable_global_exists("ms_avisadas")) global.ms_avisadas = array_create(12, 0);

    for (var i = 0; i < 12; i++) {
        ini_write_real("Missoes_Patentes", string(i), global.ms_patentes[i]);
        ini_write_real("Missoes_Avisadas", string(i), global.ms_avisadas[i]);
    }

    //MISSÕES - CONTADORES
    var contadores_missoes = [
        "xp_acumulado",
        "ms_superclique",
        "ms_casa_atendimentos",
        "ms_vip_atendimentos",
        "ms_esbanjadora_atendimentos",
        "ms_turbo_reparos",
        "ms_f3_entregas",
        "ms_f3_producao",
        "ms_f3_superproducao"
    ];

    for (var i = 0; i < array_length(contadores_missoes); i++) {
        var nome = contadores_missoes[i];
        var valor = variable_global_exists(nome) ? variable_global_get(nome) : 0;
        ini_write_real("Missoes_Contadores", nome, valor);
    }

    //EVENTOS - TEMPO E NÍVEL DOS BÔNUS
    var eventos_missoes = [
        "ms_chuva",
        "ms_superclique",
        "ms_taxacao",
        "ms_casa",
        "ms_fliperama",
        "ms_vip",
        "ms_esbanjadora",
        "ms_turbo",
        "ms_vidente",
        "ms_entrega",
        "ms_producao",
        "ms_superproducao"
    ];

    for (var i = 0; i < array_length(eventos_missoes); i++) {
        var nome = eventos_missoes[i];
        var nome_tempo = nome + "_tempo";
        var nome_nivel = nome + "_nivel";

        var tempo = variable_global_exists(nome_tempo) ? variable_global_get(nome_tempo) : 0;
        var nivel = variable_global_exists(nome_nivel) ? variable_global_get(nome_nivel) : 0;

        ini_write_real("Eventos_Tempo", nome, tempo);
        ini_write_real("Eventos_Nivel", nome, nivel);
    }

    //SUPER CLIQUE - CONTROLE DO BÔNUS
    ini_write_real("Eventos_Extras", "ms_superclique_bonus", variable_global_exists("ms_superclique_bonus") ? global.ms_superclique_bonus : 0);

    ini_close();

    //CONVERTE O ARQUIVO INI GERADO EM UMA STRING CODIFICADA EM BASE64
    var buffer = buffer_load("save_backup.ini");
    var char_exportar = buffer_base64_encode(buffer, 0, buffer_get_size(buffer));
    buffer_delete(buffer);
    clipboard_set_text(char_exportar);
    return char_exportar;
}

//RECEBE O TEXTO BASE64 DO BACKUP E RECONVERTE PARA O ARQUIVO INI ORIGINAL
function importar_progresso(char_importada) {
    if (char_importada == "") return false;
    var buffer = buffer_base64_decode(char_importada);
    if (buffer == -1) return false;
    buffer_save(buffer, "save_backup.ini");
    buffer_delete(buffer);

    //ATUALIZA TODAS AS VARIÁVEIS GLOBAIS
    ini_open("save_backup.ini");
    global.idm        = ini_read_real("Config", "idm", 0);
    global.ms_ligada  = ini_read_real("Config", "ms_ligada", true);
    global.sc_ligado  = ini_read_real("Config", "sc_ligado", true);
    global.internet      = ini_read_real("Upgrades", "internet", 0);
    global.funcionario_1 = ini_read_real("Upgrades", "funcionario_1", 0);
    global.cenario_1     = ini_read_real("Upgrades", "cenario_1", 0);
    global.energia       = ini_read_real("Upgrades", "energia", 0);
    global.funcionario_2 = ini_read_real("Upgrades", "funcionario_2", 0);
    global.cenario_2     = ini_read_real("Upgrades", "cenario_2", 0);
    global.cafe          = ini_read_real("Upgrades", "cafe", 0);
    global.funcionario_3 = ini_read_real("Upgrades", "funcionario_3", 0);
    global.transporte    = ini_read_real("Upgrades", "transporte", 0);
    global.fliperama_1   = ini_read_real("Upgrades_Esp", "fliperama_1", 0);
    global.fliperama_2   = ini_read_real("Upgrades_Esp", "fliperama_2", 0);
    global.fliperama_3   = ini_read_real("Upgrades_Esp", "fliperama_3", 0);
    global.hd_ssd        = ini_read_real("Upgrades_Esp", "hd_ssd", 0);
    global.gpu           = ini_read_real("Upgrades_Esp", "gpu", 0);
    global.psu           = ini_read_real("Upgrades_Esp", "psu", 0);
    global.celular       = ini_read_real("Upgrades_Esp", "celular", 0);
    global.tablet        = ini_read_real("Upgrades_Esp", "tablet", 0);
    global.notebook      = ini_read_real("Upgrades_Esp", "notebook", 0);
    global.comprada_2 = ini_read_real("Fases", "comprada_2", false);
    global.comprada_3 = ini_read_real("Fases", "comprada_3", false);
    global.fase_atual = ini_read_real("Fases", "fase_atual", 1);
    global.cronometro    = ini_read_real("Stats", "cronometro", 0);
    global.tempo_fase_1  = ini_read_real("Stats", "tempo_fase_1", 0);
    global.tempo_fase_2  = ini_read_real("Stats", "tempo_fase_2", 0);
    global.tempo_fase_3  = ini_read_real("Stats", "tempo_fase_3", 0);
    global.total_cliques = ini_read_real("Stats", "total_cliques", 0);
    global.creditos          = ini_read_real("Progresso", "creditos", 0);
    global.moedas            = ini_read_real("Progresso", "moedas", 0);
    global.moedas_acumuladas = ini_read_real("Progresso", "moedas_acumuladas", 0);
    global.nivel             = ini_read_real("Progresso", "nivel", 1);
    global.experiencia_atual = ini_read_real("Progresso", "experiencia_atual", 0);
    global.experiencia_maximo= ini_read_real("Progresso", "experiencia_maximo", 250);

    //MISSÕES - PATENTES E NOTIFICAÇÕES
    global.ms_patentes = array_create(12, 0);
    global.ms_progressos = array_create(12, 0);
    global.ms_avisadas = array_create(12, 0);

    for (var i = 0; i < 12; i++) {
        global.ms_patentes[i] = ini_read_real("Missoes_Patentes", string(i), 0);
        global.ms_avisadas[i] = ini_read_real("Missoes_Avisadas", string(i), 0);
    }

    //MISSÕES - CONTADORES
    var contadores_missoes = [
        "xp_acumulado",
        "ms_superclique",
        "ms_casa_atendimentos",
        "ms_vip_atendimentos",
        "ms_esbanjadora_atendimentos",
        "ms_turbo_reparos",
        "ms_f3_entregas",
        "ms_f3_producao",
        "ms_f3_superproducao"
    ];

    for (var i = 0; i < array_length(contadores_missoes); i++) {
        var nome = contadores_missoes[i];
        variable_global_set(nome, ini_read_real("Missoes_Contadores", nome, 0));
    }

    //EVENTOS - TEMPO E NÍVEL DOS BÔNUS
    var eventos_missoes = [
        "ms_chuva",
        "ms_superclique",
        "ms_taxacao",
        "ms_casa",
        "ms_fliperama",
        "ms_vip",
        "ms_esbanjadora",
        "ms_turbo",
        "ms_vidente",
        "ms_entrega",
        "ms_producao",
        "ms_superproducao"
    ];

    for (var i = 0; i < array_length(eventos_missoes); i++) {
        var nome = eventos_missoes[i];
        var nome_tempo = nome + "_tempo";
        var nome_nivel = nome + "_nivel";

        var tempo = ini_read_real("Eventos_Tempo", nome, 0);
        var nivel = ini_read_real("Eventos_Nivel", nome, 0);

        variable_global_set(nome_tempo, tempo);
        variable_global_set(nome_nivel, nivel);
    }

    //SUPER CLIQUE - CONTROLE DO BÔNUS
    global.ms_superclique_bonus = ini_read_real("Eventos_Extras", "ms_superclique_bonus", 0);
    global.ms_superclique_ultimo_clique = -1;

    //RECONSTRÓI O PROGRESSO DAS MISSÕES
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

    ini_close();
    return true;
}