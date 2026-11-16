//CANCELA COM AS CONFIGURAÇÕES ABERTA
if (instance_exists(obj_ctld_Configuracoes) && obj_ctld_Configuracoes.exibir_config) {
    visible = false;
    exit;
}

visible = true;
image_speed = 0;
image_index = global.cenario_2;

//COR DO BOTAO DE COMPRA
var valor = [30000, 75000, 160000];
image_blend = c_white;
if (global.cenario_2 < array_length(valor)) {
    if (global.moedas >= valor[global.cenario_2]) image_blend = COR_COMPRA_DISPONIVEL;
}
