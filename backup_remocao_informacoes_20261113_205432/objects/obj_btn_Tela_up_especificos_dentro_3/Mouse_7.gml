if (!tutorial_permite(object_index)) exit;
//SE TIVER DENTRO DAS CONFIGURAÇÕES NÃO MOSTRAR O BOTÃO ESPECÍFICOS
if (instance_exists(obj_ctld_Configuracoes) && obj_ctld_Configuracoes.exibir_config == true) {
    mouse_clear(mb_left);
    exit; 
}

image_xscale = 1.3;
image_yscale = 0.938;
room_goto(rm_up_Especificos_3);