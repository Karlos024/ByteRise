//EVITAR BUG DE DUPLICAÇÃO
if (instance_number(object_index) > 1) {
    instance_destroy();
    exit;
}

//CONFIGURAÇÃO DOS ESTADOS, MOVIMENTAÇÃO E SPRITE
velocidade = 3;
velocidade_atual = velocidade;
arrastando = false;
voltando = false;
mesa_atual = noone;
x_original = 115;
y_original = 360;
x = x_original;
y = y_original;
fase_volta_psn = 0; 
sprite_index = spr_psn_Principal_2;