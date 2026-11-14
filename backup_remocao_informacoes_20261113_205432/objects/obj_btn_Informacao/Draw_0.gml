var Config_Aberta = false;
if (instance_exists(obj_ctld_Configuracoes)) {
    Config_Aberta = obj_ctld_Configuracoes.exibir_config;
}
if (Config_Aberta == true) {
    exit;
}
draw_self();