//CANCELA COM AS CONFIGURAÇÕES ABERTA
if (instance_exists(obj_ctld_Configuracoes) && obj_ctld_Configuracoes.exibir_config) {
    visible = false;
    exit;
}

visible = true;
image_speed = 0;
image_index = global.transporte;

//COR DO BOTAO DE COMPRA
var valor = [90000, 220000, 500000];
image_blend = c_white;
if (global.transporte < array_length(valor)) {
    if (global.moedas >= valor[global.transporte]) image_blend = COR_COMPRA_DISPONIVEL;
}
