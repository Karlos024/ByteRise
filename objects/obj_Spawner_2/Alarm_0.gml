if (room_get_name(room) != "rm_Tela_principal_2") {
    alarm[0] = game_get_speed(gamespeed_fps);
    exit;
}

//DECLARAÇÃO
var maximo = 3;
var total = 0;

//CONTA OS CLIENTES ATIVOS
if (instance_exists(obj_Clientes_2)) {
    with (obj_Clientes_2) {
        if (variable_instance_exists(id, "fase")) {
            if (fase == other.fase) total++;
        } else {
            total++;
        }
    }
}

//VERIFICA SE A FILA ESTÁ LOTADA
var fila_lotada = false;
if (instance_exists(obj_Balcao_2)) {
    if (ds_list_size(obj_Balcao_2.fila) >= maximo) {
        fila_lotada = true;
    }
}

//VERIFICA SE A FILA ESTÁ LOTADA
if (total >= maximo || fila_lotada) {
    segundos_decorridos = 0; 
    alarm[0] = game_get_speed(gamespeed_fps); 
    exit;
}

//CALCULA A CHANCE BASE POR TEMPO E APLICA O MULTIPLICADOR
segundos_decorridos += 1;
var nivel_cenario = 0;
if (variable_global_exists("cenario_2")) {
    nivel_cenario = global.cenario_2;
}
var multiplicador = 0.25 + (nivel_cenario * 0.25); 
multiplicador = clamp(multiplicador, 0.25, 1.00); 
var chance = 0.5 * (segundos_decorridos * segundos_decorridos);
chance = chance * multiplicador; 
chance = min(chance, 100);
var sorteio = random(100);

//CADA NÍVEL
var tempo_maximo = 8; 
switch (nivel_cenario) {
    case 0: tempo_maximo = 8; break;
    case 1: tempo_maximo = 6;  break;
    case 2: tempo_maximo = 4;  break;
    case 3: tempo_maximo = 2;  break;
}

//NASCIMENTO DO CLIENTE
if (sorteio <= chance || segundos_decorridos >= tempo_maximo) {
    var fase_atual = 2;
    if (variable_instance_exists(id, "fase")) {
        fase_atual = fase;
    }
    
    var cliente = instance_create_depth(x + 15, y, -100, obj_Clientes_2);
    
    //PROTEÇÃO
    if (instance_exists(cliente)) {
        cliente.fase = fase_atual;
    } 
    segundos_decorridos = 0;
}
alarm[0] = game_get_speed(gamespeed_fps);