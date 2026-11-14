//VERIFICAR SE O CELULAR ESTÁ ABERTO
if (!exibir_progresso) {
    exit;
}

//FUNDO
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);
var fundo_x = 180;
var fundo_y = 320;
var fundo_largura = 245;
var fundo_altura = 425;

//VERIFICAR CLIQUE FORA DO CELULAR
var fora = mx < fundo_x - fundo_largura / 2 || mx > fundo_x + fundo_largura / 2 || my < fundo_y - fundo_altura / 2 || my > fundo_y + fundo_altura / 2;

//VERIFICAR CLIQUE NO CELULAR
var clique = false;
var celular = instance_find(obj_btn_Carreira, 0);
if (celular != noone) {
    clique = point_in_rectangle(mx, my, celular.bbox_left, celular.bbox_top, celular.bbox_right, celular.bbox_bottom);
}

//APAGAR TUDO
if (fora || clique) {
    global.bloquear_clique_celular = true;
    exibir_progresso = false;
    if (instance_exists(ctld_Missoes)) {
        instance_destroy(ctld_Missoes);
    }
    ctld_Missoes = noone;
    exit;
}