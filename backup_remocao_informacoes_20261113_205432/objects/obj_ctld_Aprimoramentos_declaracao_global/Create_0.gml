if (instance_number(object_index) > 1) { instance_destroy(); exit; }
//DECLARAÇÂO DE VARIÁVEIS DE APRIMORAMENTO
//GERAIS
if (!variable_global_exists("internet")) global.internet = 0;
if (!variable_global_exists("funcionario_1")) global.funcionario_1 = 0;
if (!variable_global_exists("cenario_1")) global.cenario_1 = 0;
if (!variable_global_exists("energia")) global.energia = 0;
if (!variable_global_exists("funcionario_2")) global.funcionario_2 = 0;
if (!variable_global_exists("cenario_2")) global.cenario_2 = 0;
if (!variable_global_exists("cafe")) global.cafe = 0;
if (!variable_global_exists("funcionario_3")) global.funcionario_3 = 0;
if (!variable_global_exists("transporte")) global.transporte = 0;

//ESPECÍFICOS
if (!variable_global_exists("fliperama_1")) global.fliperama_1 = 0;
if (!variable_global_exists("fliperama_2")) global.fliperama_2 = 0;
if (!variable_global_exists("fliperama_3")) global.fliperama_3 = 0;
if (!variable_global_exists("hd_ssd")) global.hd_ssd = 0;
if (!variable_global_exists("gpu")) global.gpu = 0;
if (!variable_global_exists("psu")) global.psu = 0;
if (!variable_global_exists("celular")) global.celular = 0;
if (!variable_global_exists("tablet")) global.tablet = 0;
if (!variable_global_exists("notebook")) global.notebook = 0;

//EXTRAS
if (!variable_global_exists("exibir_config")) global.exibir_config = false;
progresso_inicializar();
if (!variable_global_exists("save_carregado")) {
    global.save_carregado = true;
    carregar_progresso_local();
}
