draw_sprite_ext(spr_Informacoes_fundo, 0, x + 100, y + 17, 2.2, 1, 0, c_white, 1);

//PADRÃO DOS CARACTERES
draw_set_font(font_Pequena);
draw_set_valign(fa_top);  
draw_set_halign(fa_left);
draw_set_color(c_white);

//EXIBIR O TEXTO
if (variable_instance_exists(id, "Texto_exibido")) {
    draw_text_ext(x + 45, y - 10, Texto_exibido, 14, 100);
}