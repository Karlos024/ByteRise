//CANCELA COM AS CONFIGURAÇÕES ABERTA
if (instance_exists(obj_ctld_Configuracoes) && obj_ctld_Configuracoes.exibir_config) {
    visible = false;
    exit;
}

visible = true;
image_speed = 0;
image_index = global.funcionario_2 ;

//COR DO BOTAO DE COMPRA
var valor = [80000, 180000, 340000];
image_blend = c_white;
if (global.funcionario_2 < array_length(valor)) {
    if (global.moedas >= valor[global.funcionario_2]) image_blend = COR_COMPRA_DISPONIVEL;
}
