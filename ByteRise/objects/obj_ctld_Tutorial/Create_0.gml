atual = 0;

//CRONÔMETRO E FASE FAVORITA
if (!variable_global_exists("cronometro")) global.cronometro = 0;
if (!variable_global_exists("tempo_fase_1")) global.tempo_fase_1 = 0;
if (!variable_global_exists("tempo_fase_2")) global.tempo_fase_2 = 0;
if (!variable_global_exists("tempo_fase_3")) global.tempo_fase_3 = 0;

//PARA CRIAR CASO NÃO TENHA
if (!instance_exists(obj_ctld_Fim_estatisticas_cronometro)) {
    instance_create_layer(0, 0, "Instances", obj_ctld_Fim_estatisticas_cronometro);
}

if (!variable_global_exists("fase_atual")) {
    global.fase_atual = 1;
}
fase = global.fase_atual; 

//AJUSTE DE PÁGINAS
if (fase == 1) maximo = 3; 
else if (fase == 2) maximo = 3; 
else if (fase == 3) maximo = 3; 

if (!variable_global_exists("idm")) {
    global.idm = 0;
}
image_speed = 0.15;