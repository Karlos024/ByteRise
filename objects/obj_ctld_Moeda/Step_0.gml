//EVENTO DA MISSÃO - TAXAÇÃO
if (global.ms_taxacao_tempo > 0) {
    global.ms_taxacao_tempo = max(0, global.ms_taxacao_tempo - delta_time / 1000000);

    if (global.ms_taxacao_tempo <= 0) {
        global.ms_taxacao_nivel = 0;
    }
}