//CANCELA COM AS CONFIGURAÇÕES ABERTA
if (instance_exists(obj_ctld_Configuracoes) && obj_ctld_Configuracoes.exibir_config) {
    visible = false;
    exit;
}

visible = true;
image_speed = 0; 
image_index = global.tablet;

//COR DO BOTAO DE COMPRA
var valor = [0, 12000, 30000, 60000, 95000, 145000, 210000, 290000, 390000, 510000, 650000, 810000, 990000, 1190000, 1420000];
image_blend = c_white;
if (global.tablet < array_length(valor)) {
    if (global.moedas >= valor[global.tablet]) image_blend = COR_COMPRA_DISPONIVEL;
}
