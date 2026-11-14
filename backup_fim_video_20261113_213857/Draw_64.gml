//FUNDO
draw_set_alpha(1);
draw_set_color(c_black);
var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();
draw_rectangle(0, 0, _gui_w, _gui_h, false);
draw_set_color(c_white);
if (!aberto || encerrando) exit;

//VÍDEO
var _dados = video_draw();
if (!is_array(_dados) || array_length(_dados) < 1) exit;
if (_dados[0] == -2) {
    finalizar();
} else if (_dados[0] == 0 && array_length(_dados) > 1 && surface_exists(_dados[1])) {
    falhas_quadro = 0;
    var _superficie = _dados[1];
    var _largura = surface_get_width(_superficie);
    var _altura = surface_get_height(_superficie);
    if (_largura > 0 && _altura > 0) {
        var _escala = min(_gui_w / _largura, _gui_h / _altura);
        var _w = _largura * _escala;
        var _h = _altura * _escala;
        draw_surface_stretched(_superficie, (_gui_w - _w) / 2, (_gui_h - _h) / 2, _w, _h);
    }
} else if (iniciado && video_get_status() == video_status_playing) {
    falhas_quadro++;
}
