//GARANTE QUE SÓ EXISTA UM CONTROLADOR DE EXPERIÊNCIA
if (instance_number(obj_ctld_Experiencia) > 1) {
    instance_destroy();
    exit;
}

//DECLARAÇÃO
if (!variable_global_exists("nivel")) {
    global.nivel = 30; 
}
if (!variable_global_exists("experiencia_atual")) {
    global.experiencia_atual = 0; 
}
global.experiencia = [0, 100, 250, 450, 700, 1000, 1400, 1900, 2500, 3200, 4000, 5000, 6200, 7600, 9200, 11000, 13000, 15300, 17900, 20800, 24000, 27500, 31300, 35400, 39800, 44500, 49600, 55100, 61000, 67000, 74000];

//DEFINE O XP MÁXIMO DO NÍVEL
global.experiencia_maximo = global.experiencia[global.nivel];