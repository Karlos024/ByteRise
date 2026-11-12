//PADRÃO DOS CARACTERES
draw_set_halign(fa_center); 
draw_set_valign(fa_top);    
draw_set_color(make_color_rgb(69, 75, 84));

//FUNDO
draw_sprite_ext(spr_Pedido_fundo, 0, 180, 320, 3, 3, 0, c_white, 1);

//NOME
draw_set_font(font_Sobre_titulo);
draw_text(x, y - 45, string_upper(txt_Cliente));

//TEXTO
draw_set_font(font_Texto);
draw_text_ext(x, y - 20, txt_Problema, 20, 160);

//BOTÃO DE SAIR
draw_sprite_ext(spr_btn_Inicio_sobre_sair, 0, x, y + 72, 0.5, 0.5, 0, c_white, 1);