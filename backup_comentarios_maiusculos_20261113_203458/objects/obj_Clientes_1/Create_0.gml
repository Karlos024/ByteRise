//CONFIGURAÇÃO DOS ESTADOS, ROTAS E FRAMES
fase = 1;
estado_fila = 0;
velocidade_npc = 1.5; 
espaco_fila = 55;
timer_atendimento = 0;
progresso_dentro = 0;
inicializado = false;
fase_entrada = 0;
fase_caminho = 0;
fase_saida = 0;
alvo_x = x;
alvo_y = y;
x_anterior = x;
y_anterior = y;
na_fila_fliperama = false;
tempos_atendimento = [3.0, 2.0, 1.5, 1.5];

//CONTROLE DE VAGAS E ALVOS
balcao_inst = noone;
balcao_num = 0;
balcao_escolhido = -1;
fliperama_alvo = noone;
tipo_fliperama = -1;
dentro_x = 0;
dentro_y = 0;

//COORDENADAS ORIGINAIS DE NASCIMENTO
spawner_x = xstart;
spawner_y = ystart;

//SORTEIO DE COMPORTAMENTO
multiplicador_pagamento = 1.0;
tipo_cliente = 0;

//EVENTO DE MISSÃO - CASA LOTADA E FREGUESIA VIP
if (!variable_global_exists("ms_vip_tempo")) {
    global.ms_vip_tempo = 0;
}

if (!variable_global_exists("ms_vip_atendimentos")) {
    global.ms_vip_atendimentos = 0;
}

if (!variable_global_exists("ms_casa_atendimentos")) {
    global.ms_casa_atendimentos = 0;
}

//SORTEIO DE CLIENTES INCOMUNS
var sorteio_tipo = random(100);
// Durante o VIP, todos os novos clientes sao esbanjadores.
if (global.ms_vip_tempo > 0 || sorteio_tipo <= 5) {
    tipo_cliente = 3;
    sprite_index = spr_psn_Esbanjador_1;
    multiplicador_pagamento = 2.0;
} else if (sorteio_tipo <= 10) {
    tipo_cliente = 4;
    sprite_index = spr_psn_Pao_duro_1;
    multiplicador_pagamento = 0.50;
} else {
    tipo_cliente = 0;
}

//LISTA DINÂMICA DE UPGRADES
tipo = 0;
var fliperamas_disponiveis = ds_list_create();

if (variable_global_exists("fliperama_1") && global.fliperama_1 > 0) {
    ds_list_add(fliperamas_disponiveis, 0); 
}
if (variable_global_exists("fliperama_2") && global.fliperama_2 > 0) {
    ds_list_add(fliperamas_disponiveis, 1); 
}
if (variable_global_exists("fliperama_3") && global.fliperama_3 > 0) {
    ds_list_add(fliperamas_disponiveis, 2); 
}

//ESCOLHA DOS FLIPERAMAS
if (ds_list_size(fliperamas_disponiveis) > 0) {
    var indice_sorteado = irandom(ds_list_size(fliperamas_disponiveis) - 1);
    var fliperama_escolhido = ds_list_find_value(fliperamas_disponiveis, indice_sorteado);

    //SORTEIO ENTRE OS 54 PERSONAGENS
    var numero_personagem = irandom_range(1, 18);
    var nome_sprite = "";

    if (fliperama_escolhido == 0) {
        tipo = 0;

        if (tipo_cliente == 0) {
            nome_sprite = "spr_psn_Cube_World_" + string(numero_personagem);
        }

    } else if (fliperama_escolhido == 1) {
        tipo = 3;

        if (tipo_cliente == 0) {
            nome_sprite = "spr_psn_Alfredos_" + string(numero_personagem);
        }

    } else if (fliperama_escolhido == 2) {
        tipo = 4;

        if (tipo_cliente == 0) {
            nome_sprite = "spr_psn_Pocket_Mosters_" + string(numero_personagem);
        }
    }

    //APLICA A SPRITE SORTEADA
    if (tipo_cliente == 0) {
        var sprite_sorteada = asset_get_index(nome_sprite);

        if (sprite_sorteada != -1) {
            sprite_index = sprite_sorteada;
        }
    }
} else {
    ds_list_destroy(fliperamas_disponiveis);
    instance_destroy();
    exit;
}
ds_list_destroy(fliperamas_disponiveis);

image_xscale = 1.1;
image_yscale = 0.9;

//FUNÇÃO DO MOSTRADOR DE PROGRESSO
desenhar_mostrador = function(coordenada_x, coordenada_y, progresso, raio) {
    draw_set_color(c_black);
    draw_circle(coordenada_x, coordenada_y, raio * 20 / 14, false); 
    draw_set_color(make_color_rgb(60, 60, 60));
    draw_circle(coordenada_x, coordenada_y, raio, false); 

    var progresso_limpo = clamp(floor(progresso * 100), 0, 100); 
    if (progresso_limpo > 0) {
        if (progresso_limpo < 100) {
            draw_set_color(c_red);
        } else {
            draw_set_color(c_lime);
        }
        draw_primitive_begin(pr_trianglefan);
        draw_vertex(coordenada_x, coordenada_y);
        for (var i = 0; i <= (progresso_limpo / 100) * 360; i += 2) {
            draw_vertex(coordenada_x + lengthdir_x(raio, i - 90), coordenada_y + lengthdir_y(raio, i - 90));
        }
        draw_primitive_end();
    }
    draw_set_color(c_white);
};
