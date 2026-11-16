if (ativo && !tutorial_missoes_ativo()) { ativo = false; exit; }
pulsacao += min(delta_time / 1000000, 0.05);
espera = max(0, espera - min(delta_time / 1000000, 0.05));
tutorial_missao_observar();
if (!ativo) { tutorial_missao_iniciar_pendente(); exit; }
if (!instance_exists(obj_btn_Carreira)) { ativo = false; exit; }
if (instance_exists(obj_ctld_Configuracoes) && obj_ctld_Configuracoes.exibir_config) exit;
if (espera > 0) exit;
var _x = device_mouse_x_to_gui(0), _y = device_mouse_y_to_gui(0);
if (device_mouse_check_button_released(0, mb_left) && point_in_rectangle(_x,_y,270,8,352,46)) {
    concluir();
    exit;
}
var _aberta = instance_exists(obj_ctld_Carreira) && obj_ctld_Carreira.exibir_progresso;
if (etapa >= 2 && etapa <= 3 && (!_aberta || !instance_exists(obj_ctld_Missao))) {
    etapa = 1;
    espera = 0.2;
    exit;
}
switch (etapa) {
    case 1:
        if (_aberta && instance_exists(obj_ctld_Missao)) { tutorial_som(); avancar(); }
        break;
    case 2:
        if (obj_ctld_Missao.categoria == 1) { tutorial_som(); avancar(); }
        break;
    case 3:
        if (obj_ctld_Missao.categoria != 1) { etapa = 2; espera = 0.2; exit; }
        if (global.ms_patentes[missao] > patente_inicio) { tutorial_som(); avancar(); }
        break;
    default:
        tutorial_continuar(id, _x, _y);
        break;
}
