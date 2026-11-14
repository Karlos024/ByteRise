if (!tutorial_permite(object_index)) exit;
image_xscale = 1;
image_yscale = 1;

if (instance_exists(obj_ctld_Carreira)) {
    with (obj_ctld_Carreira) {
        pagina = 1;

        //CRIA O CONTROLADOR
        if (!instance_exists(obj_ctld_Missao)) {
            ctld_Missoes = instance_create_depth(0, 0, -50, obj_ctld_Missao);
        }

        //REMOVE OS BOTÕES
        if (instance_exists(btn_Missoes))    { instance_destroy(btn_Missoes); }
        if (instance_exists(btn_Conquistas)) { instance_destroy(btn_Conquistas); }
        if (instance_exists(btn_Colecao))    { instance_destroy(btn_Colecao); }
        btn_Missoes    = noone;
        btn_Conquistas = noone;
        btn_Colecao    = noone;
    }
}