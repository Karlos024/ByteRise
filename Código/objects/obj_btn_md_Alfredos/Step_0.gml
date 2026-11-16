//CANCELA COM AS CONFIGURAÇÕES ABERTA
if (instance_exists(obj_ctld_Configuracoes) && obj_ctld_Configuracoes.exibir_config) {
    visible = false;
    exit;
}

visible = true;
image_speed = 0;
image_index = global.fliperama_2;

//COR DO BOTAO DE COMPRA
var valor = [25000, 5000, 17000, 26000, 37000, 50000, 65000, 82000, 101000, 122000, 145000, 170000, 197000, 227000, 255000];
image_blend = c_white;
if (global.fliperama_2 < array_length(valor)) {
    if (global.moedas >= valor[global.fliperama_2]) image_blend = COR_COMPRA_DISPONIVEL;
}
