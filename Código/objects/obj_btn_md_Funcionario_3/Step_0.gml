//CANCELA COM AS CONFIGURAÇÕES ABERTA
if (instance_exists(obj_ctld_Configuracoes) && obj_ctld_Configuracoes.exibir_config) {
    visible = false;
    exit;
}

visible = true;
image_speed = 0;
image_index = global.funcionario_3;

//COR DO BOTAO DE COMPRA
var valor = [100000, 250000, 600000];
image_blend = c_white;
if (global.funcionario_3 < array_length(valor)) {
    if (global.moedas >= valor[global.funcionario_3]) image_blend = COR_COMPRA_DISPONIVEL;
}
