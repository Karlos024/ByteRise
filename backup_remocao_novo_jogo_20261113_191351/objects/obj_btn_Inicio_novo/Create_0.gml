depth = -20000;
confirmando = false;
bloqueio = 0;
pressionado = 0;
layout = function() {
    var _w = display_get_gui_width(), _h = display_get_gui_height();
    margem = max(4, min(_w, _h) * 0.025);
    largura = min(192, _w * 0.54);
    altura = min(44.8, _h * 0.075);
    bx = margem; by = _h - margem - altura;
    cw = min(320, _w - margem * 2); ch = min(190, _h - margem * 2);
    cx = (_w - cw) / 2; cy = (_h - ch) / 2;
};
layout();