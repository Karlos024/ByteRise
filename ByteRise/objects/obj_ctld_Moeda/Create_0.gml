//GARANTE QUE SÓ EXISTA UM CONTROLADOR DE MOEDAS
if (instance_number(obj_ctld_Moeda) > 1) {
    instance_destroy();
    exit;
}

//DECLARAÇÃO
if (!variable_global_exists("moedas")) {
    global.moedas = 0;
}
if (!variable_global_exists("moedas_acumuladas")) {
    global.moedas_acumuladas = 0;
}
if (!variable_global_exists("ms_progressos")) {
    global.ms_progressos = array_create(12, 0);
}
if (!variable_global_exists("ms_taxacao_tempo")) {
    global.ms_taxacao_tempo = 0;
}
if (!variable_global_exists("ms_taxacao_nivel")) {
    global.ms_taxacao_nivel = 0;
}
if (!variable_global_exists("moedas_final")) {
    global.moedas_final = 0;
}

global.ms_progressos[2] = global.moedas_acumuladas;