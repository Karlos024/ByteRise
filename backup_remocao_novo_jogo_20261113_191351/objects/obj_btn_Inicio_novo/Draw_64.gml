if (instance_exists(obj_ctld_Inicio_sobre) && obj_ctld_Inicio_sobre.exibir_sobre) exit;
layout();
// A cópia mantém a moldura; o preenchimento cobre o texto gravado na imagem.
var _desenhar = function(_x,_y,_w,_h,_texto,_pressionado) {
    var _dx = _pressionado ? _w / 60 : 0;
    var _dy = _pressionado ? _h / 14 : 0;
    _x += _dx; _y += _dy; _w -= 2*_dx; _h -= 2*_dy;
    draw_set_color(c_white); draw_set_alpha(1);
    draw_sprite_stretched(spr_btn_Inicio_novo,0,_x,_y,_w,_h);
    draw_set_color(make_color_rgb(25,105,48));
    draw_rectangle(_x+_w*.16,_y+_h*.18,_x+_w*.84,_y+_h*.82,false);
    draw_set_color(c_white);
    draw_set_font(font_Texto); draw_set_halign(fa_center); draw_set_valign(fa_middle);
    var _s = min(1, (_w*.78)/max(1,string_width(_texto)));
    draw_text_transformed(_x+_w/2,_y+_h/2,_texto,_s,_s,0);
};
_desenhar(bx,by,largura,altura,"Novo",pressionado==1);
if (confirmando) {
    draw_set_color(c_black); draw_set_alpha(.75);
    draw_rectangle(0,0,display_get_gui_width(),display_get_gui_height(),false);
    draw_set_alpha(1); draw_set_color(make_color_rgb(25,36,30));
    draw_roundrect(cx,cy,cx+cw,cy+ch,false);
    draw_set_color(c_white); draw_set_font(font_Texto);
    draw_set_halign(fa_center); draw_set_valign(fa_top);
    draw_text_ext(cx+cw/2,cy+18,"Tem certeza? Todo o seu progresso será apagado.",20,cw-28);
    _desenhar(cx+12,cy+ch-54,cw/2-18,42,"Sim",pressionado==2);
    _desenhar(cx+cw/2+6,cy+ch-54,cw/2-18,42,"Cancelar",pressionado==3);
}
draw_set_alpha(1); draw_set_color(c_white);
draw_set_halign(fa_left); draw_set_valign(fa_top);