//CANCELA COM AS CONFIGURAÇÕES ABERTA
if (instance_exists(obj_ctld_Configuracoes) && obj_ctld_Configuracoes.exibir_config) {
    visible = false;
    exit;
}

visible = true;
image_speed = 0;
image_index = global.fliperama_1;

//COR DO BOTAO DE COMPRA
var valor = [0, 1000, 2500, 4500, 7000, 10000, 14000, 19000, 25000, 33000, 42000, 53000, 66000, 81000, 100000];
image_blend = c_white;
if (global.fliperama_1 < array_length(valor)) {
    if (global.moedas >= valor[global.fliperama_1]) image_blend = COR_COMPRA_DISPONIVEL;
}
