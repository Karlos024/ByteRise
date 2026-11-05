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
    ini_write_real("Progresso", "moedas", global.moedas);
    ini_write_real("Progresso", "moedas_acumuladas", global.moedas_acumuladas);
    ini_write_real("Progresso", "nivel", global.nivel);
    ini_write_real("Progresso", "experiencia_atual", global.experiencia_atual);
    ini_write_real("Progresso", "experiencia_maximo", global.experiencia_maximo);
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
    global.moedas            = ini_read_real("Progresso", "moedas", 0);
    global.moedas_acumuladas = ini_read_real("Progresso", "moedas_acumuladas", 0);
    global.nivel             = ini_read_real("Progresso", "nivel", 1);
    global.experiencia_atual = ini_read_real("Progresso", "experiencia_atual", 0);
    global.experiencia_maximo= ini_read_real("Progresso", "experiencia_maximo", 250);
    ini_close();
    return true;
}