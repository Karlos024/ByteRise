//CANCELA COM AS CONFIGURAÇÕES ABERTAS
if (instance_exists(obj_ctld_Configuracoes)) {
    if (obj_ctld_Configuracoes.exibir_config) {
        exit;
    }
}

if (!exibir_progresso) {
    exit;
}

//DESFOQUE MANUAL
if (surface_exists(application_surface)) {
    draw_set_alpha(0.25);
    
    //QUATRO DIREÇÕES
    draw_surface(application_surface, -2, -2);
    draw_surface(application_surface, 2, -2);
    draw_surface(application_surface, -2, 2);
    draw_surface(application_surface, 2, 2);
    draw_set_color(c_black);
    draw_set_alpha(0.3);
    draw_rectangle(0, 0, room_width, room_height, false);
    draw_set_alpha(1);
}

//FUNDO DO CELULAR
var idioma = clamp(global.idm, 0, 2);
var frame_celular = idioma;
draw_sprite_ext(spr_Carreira_celular_fundo, frame_celular, 179.461, 320, 1, 1, 0, c_white, 1);