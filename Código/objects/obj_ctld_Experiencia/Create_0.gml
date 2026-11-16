//GARANTE QUE SÓ EXISTA UM CONTROLADOR DE EXPERIÊNCIA
if (instance_number(obj_ctld_Experiencia) > 1) {
    instance_destroy();
    exit;
}

//DECLARAÇÃO
if (!variable_global_exists("nivel")) {
    global.nivel = 1;
}
if (!variable_global_exists("experiencia_atual")) {
    global.experiencia_atual = 0;
}
if (!variable_global_exists("xp_acumulado")) {
    global.xp_acumulado = 0;
}
if (!variable_global_exists("ms_progressos")) {
    global.ms_progressos = array_create(12, 0);
}
if (!variable_global_exists("ms_chuva_tempo")) {
    global.ms_chuva_tempo = 0;
}
if (!variable_global_exists("ms_chuva_nivel")) {
    global.ms_chuva_nivel = 0;
}

global.experiencia = [0, 100, 500, 700, 1000, 15000, 2000, 2750, 3500, 4800, 5900, 7000, 8000, 9000, 10500, 12000, 15000, 18300, 21900, 25800, 29000, 34500, 40300, 46400, 50800, 53500, 56300, 60100, 67000, 74000, 80000];

//DEFINE O XP MÁXIMO DO NÍVEL
global.experiencia_maximo = global.experiencia[global.nivel];

global.ms_progressos[0] = global.xp_acumulado;