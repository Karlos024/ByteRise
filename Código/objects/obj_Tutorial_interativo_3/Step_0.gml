if (tutorial_missoes_ativo()) exit;
//TUTORIAL
pulsacao += min(delta_time / 1000000, 0.05);
espera = max(0, espera - min(delta_time / 1000000, 0.05));
var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);

if (!ativo) exit;

if (etapa < 0 || etapa >= array_length(textos) || etapa >= array_length(descricoes)) {
    ativo = false;
    global.tutorial_f3_concluido = true;
    exit;
}

if (espera > 0) exit;

if (mouse_check_button_released(mb_left) && point_in_rectangle(_mx, _my, 270, 8, 352, 46)) {
    ativo = false;
    global.tutorial_f3_concluido = true;
    exit;
}

switch (etapa) {
    case 1: if (room == rm_up_Gerais_3) avancar(); break;
    case 2: if (room == rm_up_Especificos_3) avancar(); break;
    case 3: if (global.celular > 0) avancar(); break;
    case 4: if (global.tablet > 0) avancar(); break;
    case 5: if (global.notebook > 0) avancar(); break;
    case 6: if (room == rm_Tela_principal_3) avancar(); break;
    case 7: if (global.f3_total_montados > montados_inicio) avancar(); break;
    case 9: if (global.cam3_y >= 350) avancar(); break;
    default:
        tutorial_continuar(id, _mx, _my);
        break;
}
