//GARANTE QUE SÓ EXISTA UM CONTROLADOR DE MOEDAS
if (instance_number(obj_ctld_Moeda) > 1) {
    instance_destroy();
    exit;
} 

//DECLARAÇÃO
if (!variable_global_exists("moedas")) {
    global.moedas = 9999999;
}
if (!variable_global_exists("moedas_acumuladas")) {
    global.moedas_acumuladas = 0;
}