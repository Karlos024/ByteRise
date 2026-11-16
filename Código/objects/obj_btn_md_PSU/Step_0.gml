//CANCELA COM AS CONFIGURAÇÕES ABERTA
if (instance_exists(obj_ctld_Configuracoes) && obj_ctld_Configuracoes.exibir_config) {
    visible = false;
    exit;
}

visible = true;
image_speed = 0;
image_index = global.psu;

//COR DO BOTAO DE COMPRA
var valor = [45000, 7000, 18000, 32000, 50000, 72000, 98000, 130000, 170000, 220000, 280000, 350000, 435000, 535000, 650000];
image_blend = c_white;
if (global.psu < array_length(valor)) {
    if (global.moedas >= valor[global.psu]) image_blend = COR_COMPRA_DISPONIVEL;
}
