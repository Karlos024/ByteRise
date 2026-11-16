if (exibir_config == true) {
    //ESTADO DO DESENHO DO PAINEL
    var _alpha_anterior = draw_get_alpha();
    var _cor_anterior = draw_get_color();
    var _fonte_anterior = draw_get_font();
    var _horizontal_anterior = draw_get_halign();
    var _vertical_anterior = draw_get_valign();
    draw_set_alpha(1);
    draw_set_color(c_white);
    //BOTÃO TELA PRINCIPAL
    draw_sprite_ext(spr_btn_Tela_principal_fora, 0, 61, 608, 1.9, 0.9, 0, c_white, 1);
    
    //BOTÃO APRIMORAMENTOS
    draw_sprite_ext(spr_btn_Tela_aprimoramentos_fora, 0, 182, 608, 1.9, 0.9, 0, c_white, 1);

    //FUNDO CONFIGURAÇÕES
	draw_sprite_ext(spr_Tela_configuracoes_fundo, global.idm, 0, 0, 5.63, 9, 0, c_white, 1);
	draw_sprite_ext(spr_Tela_configuracoes_fundo_superior, global.idm, 179.461, 30, 5.63, 1, 0, c_white, 1);

    //PADRÃO DOS CARACTERES
    draw_set_font(font_Principal);  
    draw_set_halign(fa_center); 
    draw_set_valign(fa_top);    
    draw_set_color(c_white);     
    
    //TROCA DE IDIOMA
	var txt_idioma          = ["Idioma", "Language", "Idioma"];
    var txt_musica          = ["Música", "Music", "Música"];
    var txt_efeitos_sonoros = ["Efeitos sonoros", "Sound effects", "Efectos de sonido"];
	var txt_final           = ["FIM DE JOGO", "GAME OVER", "FINAL DEL PARTIDO"];
    var txt_exportar        = ["Exportar", "Export", "Exportar"];
    var txt_importar        = ["Importar", "Import", "Importar"];
    var txt_creditos        = ["Créditos", "Credits", "Créditos"];
	
    //LOCAL DOS CARACTERES
	draw_text(179.461, 155, txt_idioma[global.idm]);
    draw_text(83.461,  235, txt_musica[global.idm]);
    draw_text(275.461, 235, txt_efeitos_sonoros[global.idm]);
	draw_text(179.461, 355, txt_creditos[global.idm]);
    draw_text(83.461,  455, txt_exportar[global.idm]);
    draw_text(275.461, 455, txt_importar[global.idm]);
	draw_text(179.461, 545, txt_final[global.idm]);

    draw_set_alpha(_alpha_anterior);
    draw_set_color(_cor_anterior);
    draw_set_font(_fonte_anterior);
    draw_set_halign(_horizontal_anterior);
    draw_set_valign(_vertical_anterior);
}
if (!exibir_config && tutorial_missoes_ativo()) {
    with (obj_Tutorial_interativo_missoes) tutorial_desenhar(id, 0);
}
