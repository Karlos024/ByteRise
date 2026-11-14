//GERA O BACKUP CRIPTOGRAFADO EM TEXTO E COPIA
function exportar_progresso(_copiar = true) {
    progresso_inicializar();
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
        "ms_vidente_atendimentos",
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

    // INI corta JSON nas aspas internas. Base64 preserva o estado inteiro.
    ini_key_delete("Fabrica", "estado");
    ini_write_string("Fabrica", "estado_b64", progresso_codificar_texto(f3_exportar_estado()));
    var _tutoriais = ["tutorial_f1_concluido", "tutorial_f1_iniciado", "tutorial_f2_concluido", "tutorial_f3_concluido", "tutorial_melhoria_concluido", "tutorial_missao_concluido", "tutorial_missao_pendente"];
    for (var _t = 0; _t < array_length(_tutoriais); _t++) {
        var _nome = _tutoriais[_t];
        ini_write_real("Tutoriais", _nome, variable_global_exists(_nome) ? variable_global_get(_nome) : (_nome == "tutorial_missao_pendente" ? -1 : false));
    }
    ini_write_real("Save", "versao", 2);
    ini_close();
    global.progresso_salvo = true;

    //CONVERTE O ARQUIVO INI GERADO EM UMA STRING CODIFICADA EM BASE64
    var buffer = buffer_load("save_backup.ini");
    var char_exportar = buffer_base64_encode(buffer, 0, buffer_get_size(buffer));
    buffer_delete(buffer);
    if (_copiar) clipboard_set_text(char_exportar);
    return char_exportar;
}

//RECEBE O TEXTO BASE64 DO BACKUP E RECONVERTE PARA O ARQUIVO INI ORIGINAL
function importar_progresso(char_importada) {
    if (!is_string(char_importada) || string_length(char_importada) == 0 || string_length(char_importada) > 2000000) return false;
    var _buffer = -1;
    var _fabrica = "";
    try {
        _buffer = buffer_base64_decode(char_importada);
        if (_buffer == -1 || buffer_get_size(_buffer) == 0) return false;
        buffer_save(_buffer, "save_importacao.tmp");
        buffer_delete(_buffer);
        _buffer = -1;
        ini_open("save_importacao.tmp");
        var _valido = ini_key_exists("Progresso", "moedas") && ini_key_exists("Fases", "fase_atual")
            && ini_key_exists("Upgrades", "internet") && ini_key_exists("Progresso", "nivel");
        var _fase = ini_read_real("Fases", "fase_atual", -1);
        var _moedas = ini_read_real("Progresso", "moedas", -1);
        var _nivel = ini_read_real("Progresso", "nivel", -1);
        _valido = _valido && f3_numero_valido(_fase, 1, 3) && floor(_fase) == _fase
            && f3_numero_valido(_moedas, 0, 1000000000000000) && f3_numero_valido(_nivel, 1, 30);
        var _gerais = ["internet", "funcionario_1", "cenario_1", "energia", "funcionario_2", "cenario_2", "cafe", "funcionario_3", "transporte"];
        var _especificos = ["fliperama_1", "fliperama_2", "fliperama_3", "hd_ssd", "gpu", "psu", "celular", "tablet", "notebook"];
        for (var _grupo = 0; _grupo < 2; _grupo++) {
            var _campos = (_grupo == 0) ? _gerais : _especificos;
            var _secao = (_grupo == 0) ? "Upgrades" : "Upgrades_Esp";
            for (var _i = 0; _i < array_length(_campos); _i++) {
                var _valor = ini_read_real(_secao, _campos[_i], 0);
                if (!f3_numero_valido(_valor, 0, (_grupo == 0) ? 3 : 15) || floor(_valor) != _valor) _valido = false;
            }
        }
        _fabrica = ini_read_string("Fabrica", "estado", "");
        var _fabrica_b64 = ini_read_string("Fabrica", "estado_b64", "");
        if (_fabrica_b64 != "") _fabrica = progresso_decodificar_texto(_fabrica_b64);
        ini_close();
        if (_fabrica != "" && !f3_restaurar_estado(_fabrica, true)) _valido = false;
        if (!_valido) { file_delete("save_importacao.tmp"); return false; }
    } catch (_erro) {
        if (_buffer != -1 && buffer_exists(_buffer)) buffer_delete(_buffer);
        if (file_exists("save_importacao.tmp")) file_delete("save_importacao.tmp");
        return false;
    }
    progresso_limpar_instancias();
    f3_limpar_producao();
    ini_open("save_importacao.tmp");
    global.idm        = clamp(floor(ini_read_real("Config", "idm", 0)), 0, 2);
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
        "ms_vidente_atendimentos",
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
    global.ms_progressos[8] = global.ms_vidente_atendimentos;
    global.ms_progressos[9] = global.ms_f3_entregas;
    global.ms_progressos[10] = global.ms_f3_producao;
    global.ms_progressos[11] = global.celular + global.tablet + global.notebook;

    var _tutoriais = ["tutorial_f1_concluido", "tutorial_f1_iniciado", "tutorial_f2_concluido", "tutorial_f3_concluido", "tutorial_melhoria_concluido", "tutorial_missao_concluido", "tutorial_missao_pendente"];
    for (var _t = 0; _t < array_length(_tutoriais); _t++) {
        var _nome = _tutoriais[_t];
        variable_global_set(_nome, ini_read_real("Tutoriais", _nome, _nome == "tutorial_missao_pendente" ? -1 : false));
    }
    ini_close();
    // Um tutorial interrompido recomeça; um concluído permanece concluído.
    global.tutorial_f1_iniciado = global.tutorial_f1_concluido;
    if (_fabrica != "") f3_restaurar_estado(_fabrica);
    // Só substitui o arquivo válido depois de validar e restaurar o código.
    var _salvo = buffer_load("save_importacao.tmp");
    buffer_save(_salvo, "save_backup.ini");
    buffer_delete(_salvo);
    file_delete("save_importacao.tmp");
    global.progresso_salvo = true;
    global.bloquear_clique_celular = false;
    progresso_aplicar_audio();
    return true;
}
// Inicializa apenas campos ausentes, inclusive antes do primeiro salvamento.
function progresso_inicializar() {
    var _zeros = ["internet","funcionario_1","cenario_1","energia","funcionario_2","cenario_2","cafe","funcionario_3","transporte","fliperama_1","fliperama_2","fliperama_3","hd_ssd","gpu","psu","celular","tablet","notebook","comprada_2","comprada_3","cronometro","tempo_fase_1","tempo_fase_2","tempo_fase_3","total_cliques","creditos","moedas","moedas_acumuladas","experiencia_atual","ms_vidente_atendimentos","moedas_final","bloquear_clique_celular"];
    for (var _i = 0; _i < array_length(_zeros); _i++) if (!variable_global_exists(_zeros[_i])) variable_global_set(_zeros[_i], 0);
    if (!variable_global_exists("idm")) global.idm = 0;
    if (!variable_global_exists("ms_ligada")) global.ms_ligada = true;
    if (!variable_global_exists("sc_ligado")) global.sc_ligado = true;
    if (!variable_global_exists("nivel")) global.nivel = 1;
    if (!variable_global_exists("fase_atual")) global.fase_atual = 1;
    if (!variable_global_exists("experiencia_maximo")) global.experiencia_maximo = 100;
    if (!variable_global_exists("progresso_salvo")) global.progresso_salvo = false;
    if (!variable_global_exists("tutorial_melhoria_concluido")) global.tutorial_melhoria_concluido = false;
    if (!variable_global_exists("tutorial_missao_concluido")) global.tutorial_missao_concluido = false;
    if (!variable_global_exists("tutorial_missao_pendente")) global.tutorial_missao_pendente = -1;
}
function progresso_limpar_instancias() {
    var _origem = id;
    with (all) {
        if (persistent && id != _origem && object_index != obj_ctld_Aprimoramentos_declaracao_global
            && object_index != obj_snd_Musica) instance_destroy();
    }
}
function progresso_aplicar_audio() {
    audio_stop_all();
    audio_sound_gain(snd_Musica, global.ms_ligada ? 0.3 : 0, 0);
    audio_sound_gain(snd_Evento, global.ms_ligada ? 1 : 0, 0);
    var _sons = [snd_Botao, snd_Compra, snd_Maximo, snd_Troca_de_tela, snd_Recusado, snd_Moeda, snd_Recebimento];
    for (var _i = 0; _i < array_length(_sons); _i++) audio_sound_gain(_sons[_i], global.sc_ligado ? 1 : 0, 0);
    if (global.ms_ligada) audio_play_sound(snd_Musica, 10, true);
}
function carregar_progresso_local() {
    if (!file_exists("save_backup.ini")) return false;
    var _buf = buffer_load("save_backup.ini");
    if (_buf == -1) return false;
    var _codigo = buffer_base64_encode(_buf, 0, buffer_get_size(_buf));
    buffer_delete(_buf);
    return importar_progresso(_codigo);
}
function progresso_ir_para_fase() {
    if (global.fase_atual == 3 && global.comprada_3) room_goto(rm_Tela_principal_3);
    else if (global.fase_atual == 2 && global.comprada_2) room_goto(rm_Tela_principal_2);
    else { global.fase_atual = 1; room_goto(rm_Tela_principal_1); }
}

// Reconstroi a interface tambem quando o save pula os tutoriais e a fase 1.
function progresso_garantir_controladores() {
    var _tela_jogo = room == rm_Tela_principal_1 || room == rm_Tela_principal_2 || room == rm_Tela_principal_3
        || room == rm_up_Gerais_1 || room == rm_up_Gerais_2 || room == rm_up_Gerais_3
        || room == rm_up_Especificos_1 || room == rm_up_Especificos_2 || room == rm_up_Especificos_3;
    if (!_tela_jogo) return;

    var _objetos = [obj_ctld_Moeda, obj_ctld_Experiencia, obj_ctld_Troca,
        obj_ctld_ifm_aprimoramentos, obj_ctld_ifm_Menu, obj_ctld_Configuracoes,
        obj_ctld_Carreira, obj_ctld_Eventos, obj_ctld_Fim_aviso,
        obj_ctld_Fim_estatisticas_clique, obj_ctld_Fim_estatisticas_cronometro,
        obj_Tutorial_interativo_melhoria, obj_Tutorial_interativo_missoes];
    for (var _i = 0; _i < array_length(_objetos); _i++) {
        var _objeto = _objetos[_i];
        // A fase 1 tambem possui instancias destes controladores na room.
        // A destruicao pode ser adiada ate o fim do evento: nunca espera a contagem diminuir.
        var _quantidade = instance_number(_objeto);
        for (var _duplicada = _quantidade - 1; _duplicada > 0; _duplicada--) {
            var _instancia_duplicada = instance_find(_objeto, _duplicada);
            if (_instancia_duplicada != noone) instance_destroy(_instancia_duplicada);
        }
        if (!instance_exists(_objeto)) {
            var _instancia = instance_create_depth(0, 0, 0, _objeto);
            // Garante que os quadros fiquem acima de toda a interface apos a criacao.
            if (_objeto == obj_Tutorial_interativo_melhoria) _instancia.depth = -16000;
            if (_objeto == obj_Tutorial_interativo_missoes) _instancia.depth = -17000;
            // Configuracoes inicializa seus botoes no Room Start.
            with (_instancia) event_perform(ev_other, ev_room_start);
            if (_objeto == obj_ctld_Configuracoes) {
                _instancia.depth = -18000;
                audio_sound_gain(snd_Musica, global.ms_ligada ? 0.3 : 0, 0);
                audio_sound_gain(snd_Troca_de_tela, global.sc_ligado ? 1 : 0, 0);
            }
        }
    }
}

function progresso_codificar_texto(_texto) {
    var _buf = buffer_create(1, buffer_grow, 1);
    buffer_write(_buf, buffer_string, _texto);
    var _resultado = buffer_base64_encode(_buf, 0, buffer_tell(_buf));
    buffer_delete(_buf);
    return _resultado;
}

function progresso_decodificar_texto(_texto) {
    var _buf = buffer_base64_decode(_texto);
    if (_buf == -1) return "!invalido";
    var _resultado = buffer_read(_buf, buffer_string);
    buffer_delete(_buf);
    return _resultado;
}
