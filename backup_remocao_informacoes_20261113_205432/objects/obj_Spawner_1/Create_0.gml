//DECLARAÇÃO DE VARIÁVEIS CASO NÃO EXISTAM AINDA
if (!variable_global_exists("tempo")) {
    global.tempo = 1.0;
}
if (!variable_global_exists("escala_fase1")) {
    global.escala_fase1 = 0.5;
}
if (!variable_global_exists("moedas")) {
    global.moedas = 0;
}
if (!variable_global_exists("moedas_acumuladas")) {
    global.moedas_acumuladas = 0;
}
if (!variable_global_exists("experiencia_atual")) {
    global.experiencia_atual = 0;
}

fase = 1;

//EVITA BUG DE DUPLICAÇÃO
var duplicado = false;
with (obj_Spawner_1) {
    if (id != other.id && variable_instance_exists(id, "fase") && fase == other.fase) {
        other.duplicado = true;
    }
}
if (duplicado) {
    instance_destroy();
    exit;
}
segundos_decorridos = 0;
alarm = game_get_speed(gamespeed_fps);