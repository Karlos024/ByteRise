//CANCELA COM AS CONFIGURAÇÕES ABERTA
if (instance_exists(obj_ctld_Configuracoes) && obj_ctld_Configuracoes.exibir_config) {
    visible = false;
    exit;
}

visible = true;
image_speed = 0;
image_index = global.energia;

//COR DO BOTAO DE COMPRA
var valor = [20000, 55000, 120000];
image_blend = c_white;
if (global.energia < array_length(valor)) {
    if (global.moedas >= valor[global.energia]) image_blend = COR_COMPRA_DISPONIVEL;
}
