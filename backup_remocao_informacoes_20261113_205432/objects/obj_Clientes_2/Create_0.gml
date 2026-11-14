//CONFIGURAÇÃO DOS ESTADOS, ROTAS E FRAMES
estado_fila = 0;
velocidade = 1.5;
distancia_chegada = 4;
espaco_fila = 55;
tempo_atendimento = 5;
timer_atendimento = 0;
inicializado = false;
fase_entrada = 0;
fase_saida = 0;
alvo_x = x;
alvo_y = y;
x_anterior = x;
y_anterior = y;
multiplicador_pagamento = 1.0;

//SORTEIO DE CLIENTES
var sorteio_tipo = random(100);
if (sorteio_tipo <= 5) {
    tipo_cliente = 3;
    sprite_index = spr_psn_Esbanjador_2;
    multiplicador_pagamento = 2.0;
}
else if (sorteio_tipo <= 10) {
    tipo_cliente = 4;
    sprite_index = spr_psn_Pao_duro_2;
    multiplicador_pagamento = 0.50;
}
else {
    tipo_cliente = irandom(2);
    switch (tipo_cliente) {
        case 0:
            sprite_index = spr_psn_Programador;
            break;

        case 1:
            sprite_index = spr_psn_Idoso;
            break;

        case 2:
            sprite_index = spr_psn_Mae_filho;
            break;
    }
}

image_xscale = 1.1;
image_yscale = 0.90;
image_blend = c_white;

//DECLARAÇÃO
pedido_area = -1;
var mesas_disponiveis = ds_list_create();

//VERIFICA SE POSSUI CADA MESA
if (variable_global_exists("hd_ssd") && global.hd_ssd > 0) {
    ds_list_add(mesas_disponiveis, 0);
}
if (variable_global_exists("psu") && global.psu > 0) {
    ds_list_add(mesas_disponiveis, 1);
}
if (variable_global_exists("gpu") && global.gpu > 0) {
    ds_list_add(mesas_disponiveis, 2);
}


//SORTEIO DE PEDIDOS
if (ds_list_size(mesas_disponiveis) > 0) {
    var _indice_sorteado = irandom(ds_list_size(mesas_disponiveis) - 1);
    pedido_area = ds_list_find_value(mesas_disponiveis, _indice_sorteado);
} else {
    instance_destroy();
}

//DELETA PRA EVITAR BUGS
ds_list_destroy(mesas_disponiveis);