//CANCELA COM AS CONFIGURAÇÕES ABERTA
if (instance_exists(obj_ctld_Configuracoes) && obj_ctld_Configuracoes.exibir_config) {
    visible = false;
    exit;
}

visible = true;
image_speed = 0;
image_index = global.funcionario_1;

//COR DO BOTAO DE COMPRA
var valor = [8000, 20000, 45000];
image_blend = c_white;
if (global.funcionario_1 < array_length(valor)) {
    if (global.moedas >= valor[global.funcionario_1]) image_blend = COR_COMPRA_DISPONIVEL;
}
