if (!tutorial_permite(object_index) || !f3_tutorial_permite(object_index)) exit;
if (instance_exists(obj_ctld_Configuracoes) && obj_ctld_Configuracoes.exibir_config) exit;
if (instance_exists(obj_ctld_Carreira) && obj_ctld_Carreira.exibir_progresso) exit;
if (instance_exists(obj_ctld_Troca) && obj_ctld_Troca.exibir_troca_fase) exit;
image_xscale = 0.9;
image_yscale = 0.9;
