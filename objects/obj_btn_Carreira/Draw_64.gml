//CANCELA COM AS CONFIGURAÇÕES ABERTA
if (instance_exists(obj_ctld_Configuracoes)) {
    if (obj_ctld_Configuracoes.exibir_config) {
        exit;
    }
}

//SÍBOLOS DOS EVENTOS
var sprites_eventos = [spr_Missao_chuva, spr_Missao_clique, spr_Missao_taxacao, spr_Missao_lotado, spr_Missao_fliperama, spr_Missao_vip, spr_Missao_gastancao, spr_Missao_turbo, spr_Missao_vidente, spr_Missao_expressa, spr_Missao_massa, spr_Missao_superproducao];
var eventos_ativos = [];
var tempos_ativos = [];

//CHUVA DE XP
if (variable_global_exists("ms_chuva_tempo")) {
    if (global.ms_chuva_tempo > 0) {
        array_push(eventos_ativos, 1);
        array_push(tempos_ativos, global.ms_chuva_tempo);
    }
}

//SUPER CLIQUE
if (variable_global_exists("ms_superclique_tempo")) {
    if (global.ms_superclique_tempo > 0) {
        array_push(eventos_ativos, 2);
        array_push(tempos_ativos, global.ms_superclique_tempo);
    }
}

//TAXAÇÃO
if (variable_global_exists("ms_taxacao_tempo")) {
    if (global.ms_taxacao_tempo > 0) {
        array_push(eventos_ativos, 3);
        array_push(tempos_ativos, global.ms_taxacao_tempo);
    }
}

//CASA LOTADA
if (variable_global_exists("ms_casa_tempo")) {
    if (global.ms_casa_tempo > 0) {
        array_push(eventos_ativos, 4);
        array_push(tempos_ativos, global.ms_casa_tempo);
    }
}

//FLIPERAMA TURBO
if (variable_global_exists("ms_fliperama_tempo")) {
    if (global.ms_fliperama_tempo > 0) {
        array_push(eventos_ativos, 5);
        array_push(tempos_ativos, global.ms_fliperama_tempo);
    }
}

//FREGUESIA VIP
if (variable_global_exists("ms_vip_tempo")) {
    if (global.ms_vip_tempo > 0) {
        array_push(eventos_ativos, 6);
        array_push(tempos_ativos, global.ms_vip_tempo);
    }
}

//INVASÃO ESBANJADORA
if (variable_global_exists("ms_esbanjadora_tempo")) {
    if (global.ms_esbanjadora_tempo > 0) {
        array_push(eventos_ativos, 7);
        array_push(tempos_ativos, global.ms_esbanjadora_tempo);
    }
}

//OFICINA TURBO
if (variable_global_exists("ms_turbo_tempo")) {
    if (global.ms_turbo_tempo > 0) {
        array_push(eventos_ativos, 8);
        array_push(tempos_ativos, global.ms_turbo_tempo);
    }
}

//VIDENTE
if (variable_global_exists("ms_vidente_tempo")) {
    if (global.ms_vidente_tempo > 0) {
        array_push(eventos_ativos, 9);
        array_push(tempos_ativos, global.ms_vidente_tempo);
    }
}

//ENTREGA EXPRESSA
if (variable_global_exists("ms_entrega_tempo")) {
    if (global.ms_entrega_tempo > 0) {
        array_push(eventos_ativos, 10);
        array_push(tempos_ativos, global.ms_entrega_tempo);
    }
}

//PRODUÇÃO EM MASSA
if (variable_global_exists("ms_producao_tempo")) {
    if (global.ms_producao_tempo > 0) {
        array_push(eventos_ativos, 11);
        array_push(tempos_ativos, global.ms_producao_tempo);
    }
}

//SUPERPRODUÇÃO
if (variable_global_exists("ms_superproducao_tempo")) {
    if (global.ms_superproducao_tempo > 0) {
        array_push(eventos_ativos, 12);
        array_push(tempos_ativos, global.ms_superproducao_tempo);
    }
}

//DESENHA SÍMBOLOS E CRONÔMETROS
for (var i = 0; i < array_length(eventos_ativos); i++) {
    var evento = eventos_ativos[i];
    var sprite_evento = sprites_eventos[evento - 1];
    var pos_x = 34 + (i * 65);
    var pos_y = 92;
    draw_sprite_ext(sprite_evento, 1, pos_x, pos_y, 0.92, 0.92, 0, c_white, 1);

    //CRONÔMETRO
    var tempo = ceil(tempos_ativos[i]);
    var minutos = floor(tempo / 60);
    var segundos = tempo mod 60;
    var texto_tempo = string(minutos) + ":";
    if (segundos < 10) {
        texto_tempo += "0";
    }
    texto_tempo += string(segundos);
    var tempo_x = pos_x + 1;
    var tempo_y = 132;

	//PADRÃO DOS CARACTERES
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_alpha(1);
    draw_set_color(c_black);

    draw_text(tempo_x - 1, tempo_y, texto_tempo);
    draw_text(tempo_x + 1, tempo_y, texto_tempo);
    draw_text(tempo_x, tempo_y - 1, texto_tempo);
    draw_text(tempo_x, tempo_y + 1, texto_tempo);

    //TEXTO BRANCO
    draw_set_color(c_white);
    draw_text(tempo_x, tempo_y, texto_tempo);
}

//EASTER EGG FREGUESIA VIP
if (variable_global_exists("ms_vip_tempo") && global.ms_vip_tempo > 0) {
    var _frame_ritmatica = floor(current_time * 0.2 * game_get_speed(gamespeed_fps) / 1000) mod max(1, sprite_get_number(spr_Easteregg_RitMatica));
    draw_sprite_ext(spr_Easteregg_RitMatica, _frame_ritmatica, 150, 160, 0.5, 0.5, 0, c_white, 1);
}