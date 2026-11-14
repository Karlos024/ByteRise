if (tutorial_melhoria_ativo() || tutorial_missoes_ativo()) exit;
pulsacao += min(delta_time / 1000000, 0.05);
espera = max(0, espera - min(delta_time / 1000000, 0.05));
var _x = device_mouse_x_to_gui(0);
var _y = device_mouse_y_to_gui(0);

//TUTORIAL
if (!ativo) {
    if (!variable_global_exists("tutorial_f1_concluido")) global.tutorial_f1_concluido = false;
    if (!variable_global_exists("tutorial_f1_iniciado")) global.tutorial_f1_iniciado = false;

    
    if (room == rm_Tela_principal_1
        && !global.tutorial_f1_concluido
        && !global.tutorial_f1_iniciado) {
        global.tutorial_f1_iniciado = true;
        ativo = true;
        etapa = 0;
        espera = 0.2;
        exit;
    }

    exit;
}

if (espera > 0) exit;


if (mouse_check_button_released(mb_left)
    && point_in_rectangle(_x, _y, 270, 8, 352, 46)) {
    ativo = false;
    global.tutorial_f1_concluido = true;
    exit;
}

//ETAPAS
switch (etapa) {
    case 1:
        if (room == rm_up_Gerais_1) avancar();
        break;
    case 2:
        if (room == rm_up_Especificos_1) avancar();
        break;
    case 3:
        if (global.fliperama_1 > 0) avancar();
        break;
    case 4:
        if (room == rm_Tela_principal_1) avancar();
        break;
    default:
        
        tutorial_continuar(id, _x, _y);
        break;
}
