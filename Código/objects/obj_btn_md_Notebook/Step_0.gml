//CANCELA COM AS CONFIGURAÇÕES ABERTA
if (instance_exists(obj_ctld_Configuracoes) && obj_ctld_Configuracoes.exibir_config) {
    visible = false;
    exit;
}

visible = true;
image_speed = 0;
image_index = global.notebook;

//COR DO BOTAO DE COMPRA
var valor = [0, 18000, 45000, 85000, 130000, 190000, 270000, 370000, 490000, 630000, 790000, 980000, 1190000, 1430000, 1700000];
image_blend = c_white;
if (global.notebook < array_length(valor)) {
    if (global.moedas >= valor[global.notebook]) image_blend = COR_COMPRA_DISPONIVEL;
}
