//FUNDO
draw_sprite_ext(spr_Informacoes_fundo, 0, x + 68, y + 68, 3.4, 1.5, 0, c_white, 1);

//PADRÃO DOS CARACTERES
draw_set_font(font_Pequena);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);

//EXIBIR O TEXTO
if (variable_instance_exists(id, "Texto_exibido")) {
    draw_text_ext(x - 40, y + 40, Texto_exibido, 14, 210);
}