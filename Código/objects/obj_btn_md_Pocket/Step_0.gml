//CANCELA COM AS CONFIGURAÇÕES ABERTA
if (instance_exists(obj_ctld_Configuracoes) && obj_ctld_Configuracoes.exibir_config) {
    visible = false;
    exit;
}

visible = true;
image_speed = 0;
image_index = global.fliperama_3;

//COR DO BOTAO DE COMPRA
var valor = [65000, 12000, 22000, 36000, 52000, 71000, 93000, 118000, 146000, 177000, 211000, 248000, 288000, 331000, 377000];
image_blend = c_white;
if (global.fliperama_3 < array_length(valor)) {
    if (global.moedas >= valor[global.fliperama_3]) image_blend = COR_COMPRA_DISPONIVEL;
}
