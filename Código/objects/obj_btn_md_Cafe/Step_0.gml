//CANCELA COM AS CONFIGURAÇÕES ABERTA
if (instance_exists(obj_ctld_Configuracoes) && obj_ctld_Configuracoes.exibir_config) {
    visible = false;
    exit;
}

visible = true;
image_speed = 0;
image_index = global.cafe;

//COR DO BOTAO DE COMPRA
var valor = [60000, 150000, 320000];
image_blend = c_white;
if (global.cafe < array_length(valor)) {
    if (global.moedas >= valor[global.cafe]) image_blend = COR_COMPRA_DISPONIVEL;
}
