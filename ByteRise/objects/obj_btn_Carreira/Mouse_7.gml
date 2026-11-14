if (!tutorial_permite(object_index)) exit;
///CANCELA COM AS CONFIGURAÇÕES ABERTA
if (instance_exists(obj_ctld_Configuracoes) && obj_ctld_Configuracoes.exibir_config) {
    exit;
}

//EVITA BUG DE REABERTURA NO MESMO CLIQUE
if (variable_global_exists("bloquear_clique_celular")) {

    if (global.bloquear_clique_celular) {

        global.bloquear_clique_celular = false;
        exit;
    }
}

//PARAR AVISO AO ABRIR O CELULAR
if (instance_exists(obj_ctld_Carreira)) {
    if (!obj_ctld_Carreira.exibir_progresso) {
        animando_missao = false;
        image_speed = 0;
        image_index = 0;

        if (som_missao != -1) {
            audio_stop_sound(som_missao);
            som_missao = -1;
        }
    }
}
image_xscale = 0.9;
image_yscale = 0.9;

//ALTERNA A CENTRAL DE PROGRESSO
if (instance_exists(obj_ctld_Carreira)) {
    with (obj_ctld_Carreira) {
        exibir_progresso = !exibir_progresso;

        if (exibir_progresso) {
            other.image_index = 1;

            //CRIA O CONTROLADOR
            if (!instance_exists(obj_ctld_Missao)) {
                ctld_Missoes = instance_create_depth(0, 0, -50, obj_ctld_Missao);
            }
        } else {
            other.image_index = 0;

            //REMOVE O CONTROLADOR
            if (instance_exists(ctld_Missoes)) {
                instance_destroy(ctld_Missoes);
            }

            ctld_Missoes = noone;
        }
    }
}