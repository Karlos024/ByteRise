if (!tutorial_permite(object_index)) exit;
//SE TIVER DENTRO DAS ESTATÍSTICAS NÃO MOSTRAR ESTATÍSTICAS
if (instance_exists(obj_ctld_Fim_estatisticas) && obj_ctld_Fim_estatisticas.exibir_estatisticas == true) {
    mouse_clear(mb_left);
    exit; 
}

image_xscale = 3;
image_yscale = 0.7;

//DESATIVA O CRONÔMETRO
if (instance_exists(obj_ctld_Fim_estatisticas_cronometro)) {
    instance_destroy(obj_ctld_Fim_estatisticas_cronometro);
}

//SE TIVER DENTRO DO SOBRE MOSTRAR
if (instance_exists(obj_ctld_Fim_estatisticas)) {
    with (obj_ctld_Fim_estatisticas) {
        if (exibir_estatisticas == false) {
            exibir_estatisticas = true; 
            btn_sair = instance_create_depth(180, 600, -10, obj_btn_Fim_estatisticas_sair);
        }
    }
}