if (exibir_troca_fase == true) {
	
    //FUNDO
	draw_sprite_ext(spr_Informacoes_fundo, 0, 180, 320, 3.5, 3.5, 0, c_white, 1);

	//DECLARAÇÃO DAS VARIÁVEIS USADAS
	var txt_Titulo = [];
	var txt_Texto = [];

    //PADRÃO DOS CARACTERES 
	draw_set_color(c_white);
	draw_set_halign(fa_center);
    draw_set_valign(fa_middle);       
    
    //FASE 2
    if (fase_para_comprar == 2) {
	draw_set_font(font_Titulo_pequena);
	txt_Titulo = ["ASSISTÊNCIA TÉCNICA", "TECHNICAL SUPPORT", "ASISTENCIA TÉCNICA"];
	draw_text_ext(180,  230, txt_Titulo[global.idm], 22, 230);
	draw_set_font(font_Texto);
	draw_set_color(c_red);
	txt_Texto = ["ATENÇÃO\nSe   comprar,   suas   moedas   serão   resetadas!", "WARNING:\nIf  you   buy,   your   coins   will   be   reset!", "ATENCIÓN:\n¡Si   compras,   te   resetearán   las   monedas!"];
	draw_text_ext(180,  285, txt_Texto[global.idm], 22, 230);
	draw_sprite_ext(spr_Troca_atencao, 0, 120, 262, 0.5, 0.5, 0, c_white, 1);
	draw_sprite_ext(spr_Troca_atencao, 0, 240, 262, 0.5, 0.5, 0, c_white, 1);
	draw_set_color(c_white);
	txt_Titulo = ["CONDIÇÕES", "CONDITIONS", "CONDICIONES"];
	draw_text_ext(180,  335, txt_Titulo[global.idm], 22, 230);
	draw_set_halign(fa_left);
	txt_Texto = ["Preço:   500.000   Moedas", "Price:   500.000   Coins", "Precio:   500.000   Monedas"];
	draw_text_ext(95,  360, txt_Texto[global.idm], 22, 230);
	draw_sprite_ext(spr_Menu_moeda, 0, 85, 350, 1, 1, 0, c_white, 1);
	txt_Texto = ["Requer:   Nível   10", "Requires:   Level   10", "Requiere:   Nivel   10"];
	draw_text_ext(95,  380, txt_Texto[global.idm], 22, 230);
	draw_sprite_ext(spr_Menu_experiencia, 0, 85, 380, 1, 1, 0, c_white, 1);
	
	//FASE 3
    } else if (fase_para_comprar == 3) {
	draw_set_font(font_Titulo_pequena);
	txt_Titulo = ["EMPRESA DE TECNOLOGIA", "TECHNOLOGY COMPANY", "EMPRESA DE TECNOLOGÍA"];
	draw_text_ext(180,  230, txt_Titulo[global.idm], 22, 230);
	draw_set_font(font_Texto);
	draw_set_color(c_red);
	txt_Texto = ["ATENÇÃO\nSe   comprar,   suas   moedas   serão   resetadas!", "WARNING\nIf  you   buy,   your   coins   will   be   reset!", "ATENCIÓN\n¡Si   compras,   te   resetearán   las   monedas!"];
	draw_text_ext(180,  285, txt_Texto[global.idm], 22, 230);
	draw_sprite_ext(spr_Troca_atencao, 0, 120, 262, 0.5, 0.5, 0, c_white, 1);
	draw_sprite_ext(spr_Troca_atencao, 0, 240, 262, 0.5, 0.5, 0, c_white, 1);
	draw_set_color(c_white);
	txt_Titulo = ["CONDIÇÕES", "CONDITIONS", "CONDICIONES"];
	draw_text_ext(180,  335, txt_Titulo[global.idm], 22, 230);
	draw_set_halign(fa_left);
	txt_Texto = ["Preço:   3.000.000   Moedas", "Price:   3.000.000   Coins", "Precio: 3.000.000 Monedas"];
	draw_text_ext(95,  360, txt_Texto[global.idm], 22, 230);
	draw_sprite_ext(spr_Menu_moeda, 0, 85, 350, 1, 1, 0, c_white, 1);
	txt_Texto = ["Requer:   Nível   20", "Requires:   Level   20", "Requiere:   Nivel   20"];
	draw_text_ext(95,  380, txt_Texto[global.idm], 22, 230);
	draw_sprite_ext(spr_Menu_experiencia, 0, 85, 380, 1, 1, 0, c_white, 1);
    }

    //COMPRAR E CANCELAR
    draw_sprite_ext(spr_btn_Troca_comprar, 0, 120, 410, 0.6, 0.6, 0, c_white, 1);
    draw_sprite_ext(spr_btn_Inicio_sobre_sair, 0, 240, 410, 0.6, 0.6, 0, c_white, 1);
}