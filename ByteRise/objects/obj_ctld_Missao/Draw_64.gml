//CANCELA COM AS CONFIGURAÇÕES ABERTA
if (instance_exists(obj_ctld_Configuracoes) && obj_ctld_Configuracoes.exibir_config) {
    exit;
}

draw_sprite_ext(spr_Missao, 0, 100, 188, 0.5, 0.5, 0, c_white, 1);
draw_sprite_ext(spr_Missao, 0, 260, 188, 0.5, 0.5, 0, c_white, 1);

//PADRÃO DOS CARACTERES
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(font_Pequena);
draw_set_color(c_white);

//CATEGORIAS
var idioma = clamp(global.idm, 0, 2);
var tem_fase_2 = (variable_global_exists("comprada_2") && global.comprada_2) || (variable_instance_exists(id, "comprada_2") && comprada_2);
var tem_fase_3 = (variable_global_exists("comprada_3") && global.comprada_3) || (variable_instance_exists(id, "comprada_3") && comprada_3);

for (var i = 0; i < 4; i++) {
    var bx = categoria_x[i];
    var by = categoria_y[i];
    var spr_botao = -1;
    var frame_botao = 0;

    switch (i) {
        case 0:
            spr_botao = spr_btn_Missao_todos;
            frame_botao = idioma;
        break;

        case 1:
            spr_botao = spr_btn_Missao_fase_1;
            frame_botao = idioma;
        break;

        case 2:
            spr_botao = spr_btn_Missao_fase_2;
            if (tem_fase_2) {
                frame_botao = 1 + idioma;
            } else {
                frame_botao = 0;
            }
        break;

        case 3:
            spr_botao = spr_btn_Missao_fase_3;
            if (tem_fase_3) {
                frame_botao = 1 + idioma;
            } else {
                frame_botao = 0;
            }
        break;
    }
    draw_sprite_ext(spr_botao, frame_botao, bx, by, 0.5, 0.5, 0, c_white, 1);
}

//LISTA DE MISSÕES
for (var j = 0; j < 3; j++) {
    var my = missao_y[j];

    //IDENTIFICA A MISSÃO ENTRE AS 12
    var indice = categoria * 3 + j;
    var nivel = frame_recebimento[indice];

    //FUNDO
    draw_sprite_ext(spr_Carreira_fundo, 0, 180, my, 3, 1, 0, c_white, 1);

    //SÍMBOLO
    draw_sprite_ext(missoes[categoria][j][1], 0, 115, my, 0.7, 0.7, 0, c_white, 1);

    // NOME DA MISSÃO
    draw_set_color(c_white);
    draw_set_font(font_Pequena);
	draw_set_halign(fa_left);
    var nome_traduzido = missoes[categoria][j][0][idioma];
    draw_text(145, my - 14, nome_traduzido);
	draw_set_halign(fa_center);
    
    //POSIÇÃO
    var barra_x = 143;
    var barra_y = my + 10;
    var barra_largura = 70;
    var barra_altura = 10;
    var progresso = progresso_missoes[indice];
    var meta = metas_missoes[indice][min(nivel, 2)];

    //PORCENTAGEM
    var porcentagem = clamp(progresso / max(1, meta), 0, 1);
    draw_set_color(c_black);

    draw_roundrect(barra_x, barra_y, barra_x + barra_largura, barra_y + barra_altura, false);

    //PREENCHIMENTO
    if (porcentagem > 0) {
        draw_set_color(make_color_rgb(50, 200, 90));
        var largura_preenchida = barra_largura * porcentagem;
        draw_roundrect(barra_x, barra_y, barra_x + largura_preenchida, barra_y + barra_altura, false);
    }

    //TEXTO DO PROGRESSO
    draw_set_color(c_white);
    draw_set_font(font_Pequena);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    draw_text(180, my + 5, string(min(progresso, meta)) + "/" + string(meta));

    //BOTÃO DE RECEBER
    draw_sprite_ext(spr_Misao_recebimento, nivel, 245, my + 10, 0.7, 1, 0, c_white, 1);

    //SÍMBOLO DA PATENTE
    draw_sprite_ext(spr_Missao_dominio, nivel, 235, my - 25, 0.3, 0.3, 0, c_white, 1);

    //INFORMAÇÕES DO DESAFIO
    if (exibir_desafio && exibir_missao == j) {
        draw_sprite_ext(spr_Carreira_fundo, 1, 180, my, 3, 1, 0, c_white, 1);
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
        var texto_exibido = "";
        var cor_texto = c_white;
        var fonte_texto = font_Pequena;
        var nivel_atual = nivel;
        if (nivel_atual >= 3) {
            cor_texto = c_lime;
            fonte_texto = font_Titulo_pequena;

            switch (idioma) {
                case 0:
                    texto_exibido = "Missão   concluída!";
                break;

                case 1:
                    texto_exibido = "Mission   completed!";
                break;

                case 2:
                    texto_exibido = "¡Misión   completada!";
                break;
            }
        }
        else {
            var bloco_nivel = missoes[categoria][j][2 + nivel_atual];
            texto_exibido = bloco_nivel[idioma];
        }
        draw_set_font(fonte_texto);
        draw_set_color(cor_texto);
        draw_text_ext(110, my - 15, texto_exibido, 11, 150);
        draw_set_font(font_Pequena);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
    }

    //BANDEIRA DO DESAFIO
    draw_sprite_ext(spr_Missao_desafio, 0, 95, my - 30, 0.3, 0.3, 0, c_white, 1);
}