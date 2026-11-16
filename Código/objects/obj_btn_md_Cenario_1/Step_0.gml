//CANCELA COM AS CONFIGURAÇÕES ABERTA
if (instance_exists(obj_ctld_Configuracoes) && obj_ctld_Configuracoes.exibir_config) {
    visible = false;
    exit;
}

visible = true;
image_speed = 0;
image_index = global.cenario_1;

//COR DO BOTAO DE COMPRA
var valor = [5000, 25000, 55000];
image_blend = c_white;
if (global.cenario_1 < array_length(valor)) {
    if (global.moedas >= valor[global.cenario_1]) image_blend = COR_COMPRA_DISPONIVEL;
}
