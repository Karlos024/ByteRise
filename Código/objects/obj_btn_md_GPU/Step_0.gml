//CANCELA COM AS CONFIGURAÇÕES ABERTA
if (instance_exists(obj_ctld_Configuracoes) && obj_ctld_Configuracoes.exibir_config) {
    visible = false;
    exit;
}

visible = true;
image_speed = 0;
image_index = global.gpu;

//COR DO BOTAO DE COMPRA
var valor = [99000, 12000, 28000, 46000, 68000, 95000, 130000, 170000, 220000, 280000, 350000, 430000, 525000, 635000, 760000];
image_blend = c_white;
if (global.gpu < array_length(valor)) {
    if (global.moedas >= valor[global.gpu]) image_blend = COR_COMPRA_DISPONIVEL;
}
