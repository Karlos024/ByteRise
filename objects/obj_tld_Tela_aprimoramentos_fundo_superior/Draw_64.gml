//SE O TUTORIAL ESTIVER ABERTO ISSO NÃO FUNCIONA
if (instance_exists(obj_ctld_Tutorial)) {
    if (obj_ctld_Tutorial.exibir_tutorial == true) {
        exit;
    }
}

//TROCA DE IDIOMA
if (instance_exists(obj_ctld_Configuracoes)) {
    if (obj_ctld_Configuracoes.exibir_config == true) {
        exit;
    }
}

draw_sprite_ext(spr_Tela_aprimoramentos_fundo_superior, global.idm, 180, 96, 5.63, 1, 0, c_white, 1);