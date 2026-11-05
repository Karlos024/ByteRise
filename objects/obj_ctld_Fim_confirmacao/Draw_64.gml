if (exibir_confirmacao == true) {
	
    //FUNDO DA CONFIRMAÇÃO
	draw_sprite_ext(spr_Informacoes_fundo, 0, 180, 320, 3.5, 3.5, 0, c_white, 1);

    //PADRÃO DOS CARACTERES
	draw_set_color(c_white);
	draw_set_halign(fa_center);
    draw_set_valign(fa_middle);       
    
    //TÍTULO
	draw_set_font(font_Titulo_pequena);
	var txt_Titulo = ["CONCLUIR JOGO", "FINISH GAME", "TERMINAR JUEGO"];
	draw_text_ext(180, 225, txt_Titulo[global.idm], 22, 230);
	
    //AVISO
	draw_set_color(c_red);
	draw_set_valign(fa_top);
	draw_set_font(font_Texto);
	var txt_Texto = ["ATENÇÃO\nSe   você   confirmar,   o   jogo   será   encerrado   e   todos   os   seus   dados   serão   perdidos   permanentemente!", "WARNING\nIf   you   confirm,   the   game   will   end   and   all   your   data   will   be   permanently   lost!", "¡ATENCIÓN\nSi   confirmas,   el   juego   terminará   y   ¡todos   tus   datos   se   perderán   permanentemente!"];
	draw_text_ext(180, 250, txt_Texto[global.idm], 20, 230);
	draw_sprite_ext(spr_Troca_atencao, 0, 120, 262, 0.7, 0.7, 0, c_white, 1);
	draw_sprite_ext(spr_Troca_atencao, 0, 240, 262, 0.7, 0.7, 0, c_white, 1);
	draw_set_color(c_white);
	txt_Texto = ["Tem  coragem  de  ver  a  sua  carreira?", "Dare  to  see  your  career?", "¿Te  atreves  a  ver  tu  carrera?"];
	draw_text_ext(180, 350, txt_Texto[global.idm], 22, 230);

    //COMPRAR E CANCELAR
    draw_sprite_ext(spr_btn_Troca_comprar, 0, 120, 410, 0.6, 0.6, 0, c_white, 1);
    draw_sprite_ext(spr_btn_Inicio_sobre_sair, 0, 240, 410, 0.6, 0.6, 0, c_white, 1);
}