//CANCELA COM AS CONFIGURAÇÕES ABERTA
if (instance_exists(obj_ctld_Configuracoes) && obj_ctld_Configuracoes.exibir_config) {
    visible = false;
    exit;
}

visible = true;
image_speed = 0;
image_index = global.celular;

//COR DO BOTAO DE COMPRA
var valor = [0, 8000, 22000, 45000, 75000, 120000, 180000, 250000, 340000, 450000, 580000, 730000, 900000, 1090000, 1300000];
image_blend = c_white;
if (global.celular < array_length(valor)) {
    if (global.moedas >= valor[global.celular]) image_blend = COR_COMPRA_DISPONIVEL;
}
