//CANCELA COM AS CONFIGURAÇÕES ABERTA
if (instance_exists(obj_ctld_Configuracoes) && obj_ctld_Configuracoes.exibir_config) {
    visible = false;
    exit;
}

visible = true;
image_speed = 0;
image_index = global.hd_ssd;

//COR DO BOTAO DE COMPRA
var valor = [0, 2500, 8000, 16000, 28000, 45000, 67000, 95000, 130000, 175000, 230000, 295000, 370000, 460000, 570000];
image_blend = c_white;
if (global.hd_ssd < array_length(valor)) {
    if (global.moedas >= valor[global.hd_ssd]) image_blend = COR_COMPRA_DISPONIVEL;
}
