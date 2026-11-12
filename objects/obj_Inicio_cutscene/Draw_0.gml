draw_self();

//PADRÃO DOS CARACTERES
draw_set_font(font_Pequena);
draw_set_halign(fa_center);
draw_set_color(c_white);
draw_set_valign(fa_top);

var texto_visivel = string_copy(texto_atual, 1, floor(caracteres_visiveis));

switch (floor(image_index)) {
    case 0:
    case 2:
    case 4:
    case 5:

        //FUNDO
        draw_sprite_ext(spr_Inicio_cutscene_fundo, 0, 180, 590, 1.5, 1.2, 0, c_white, 0.9);

        //PERSONAGEM
        draw_sprite_ext(spr_Inicio_cabeca, 0, 20, 565, 0.5, 0.5, 0, c_white, 0.9);

        //TEXTO
        draw_text_ext(180, 560, texto_visivel, 22, 340);
        break;
		
    case 3:
        draw_set_color(c_black);
        draw_set_font(font_Titulo_pequena);

        draw_text_ext(188, 168, texto_visivel, 22, 260);
        break;
}