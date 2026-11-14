layout();
if (bloqueio > 0) bloqueio--;
if (instance_exists(obj_ctld_Inicio_sobre) && obj_ctld_Inicio_sobre.exibir_sobre) {
    pressionado = 0; exit;
}
var _x = device_mouse_x_to_gui(0), _y = device_mouse_y_to_gui(0);
var _alvo = 0;
if (confirmando) {
    if (!point_in_rectangle(_x,_y,cx,cy,cx+cw,cy+ch)) _alvo = 4;
    if (point_in_rectangle(_x,_y,cx+12,cy+ch-54,cx+cw/2-6,cy+ch-12)) _alvo = 2;
    if (point_in_rectangle(_x,_y,cx+cw/2+6,cy+ch-54,cx+cw-12,cy+ch-12)) _alvo = 3;
} else if (point_in_rectangle(_x,_y,bx,by,bx+largura,by+altura)) _alvo = 1;
if (device_mouse_check_button_pressed(0, mb_left)) {
    pressionado = _alvo;
    if (_alvo > 0) audio_play_sound(snd_Botao,1,false);
}
if (device_mouse_check_button_released(0, mb_left)) {
    var _acao = (pressionado == _alvo) ? _alvo : 0;
    pressionado = 0;
    if (_acao == 1) {
        if (global.progresso_salvo) confirmando = true;
        else progresso_resetar_partida(true);
    } else if (_acao == 2) {
        progresso_resetar_partida(true);
    } else if (_acao == 3 || _acao == 4) {
        confirmando = false; bloqueio = 2;
    }
}
if (!device_mouse_check_button(0,mb_left)) pressionado = 0;