if (room_get_name(room) != "rm_Tela_principal_1") {
    alarm[0] = game_get_speed(gamespeed_fps);
    exit;
}

// DECLARAÇÃO DOS LIMITES
var limite_fila_balcao = 2;
var total_na_fila_1 = 0;
var total_na_fila_2 = 0;

//CONTABILIZAÇÃO EXATA DOS CLIENTES SEPARADOS POR FILA
if (instance_exists(obj_Clientes_1)) {
    with (obj_Clientes_1) {
        if (variable_instance_exists(id, "fase") && fase == other.fase) {
            if (estado_fila == 0 || estado_fila == 1 || estado_fila == 2) {
                if (variable_instance_exists(id, "balcao_num") && balcao_num == 1) {
                    total_na_fila_2++;
                } else {
                    total_na_fila_1++;
                }
            }
        }
    }
}

//VERIFICA SE ESTÁ NO NÍVEL 3
var Nivel_funcionario = 0;
if (variable_global_exists("funcionario_1")) {
    Nivel_funcionario = global.funcionario_1;
}

//VERIFICA SE A FILA ESTÁ LOTADA
var Cancela_nascimento = false;
if (Nivel_funcionario < 3) {
    if (total_na_fila_1 >= limite_fila_balcao) { Cancela_nascimento = true; }
} else {
    if (total_na_fila_1 >= limite_fila_balcao && total_na_fila_2 >= limite_fila_balcao) { Cancela_nascimento = true; }
}

if (Cancela_nascimento) {
    segundos_decorridos = 0;
    alarm[0] = game_get_speed(gamespeed_fps);
    exit;
}

//CALCULA A CHANCE BASE POR TEMPO E APLICA O MULTIPLICADOR
segundos_decorridos += 1;
var cenario_upgrade = 0;
if (variable_global_exists("cenario_1")) {
    cenario_upgrade = global.cenario_1;
}
var multiplicador = 0.25 + (cenario_upgrade * 0.25);
multiplicador = clamp(multiplicador, 0.25, 1.00);
var chance = 0.5 * (segundos_decorridos * segundos_decorridos);
chance = chance * multiplicador;
chance = min(chance, 100);
var sorteio = random(100);

//CADA NÍVEL
var tempo_maximo = 8;
switch (Nivel_funcionario) {
    case 0: tempo_maximo = 8; break;
    case 1: tempo_maximo = 6; break;
    case 2: tempo_maximo = 4; break;
    default: tempo_maximo = 2; break;
}

//NASCIMENTO DO CLIENTE
if (sorteio <= chance || segundos_decorridos >= tempo_maximo) {
    var fase_atual = 1;
    if (variable_instance_exists(id, "fase")) {
        fase_atual = fase;
    }
    
    //SÓ NASCE SE O JOGADOR TIVER NO MÍNIMO UM FLIPERAMA
    var Algum = false;
    if (variable_global_exists("fliperama_1") && global.fliperama_1 > 0) { Algum = true; }
    if (variable_global_exists("fliperama_2") && global.fliperama_2 > 0) { Algum = true; }
    if (variable_global_exists("fliperama_3") && global.fliperama_3 > 0) { Algum = true; }
    if (Algum) {
        var cliente = instance_create_depth(x, y, -100, obj_Clientes_1);
        if (instance_exists(cliente)) {
            cliente.fase = fase_atual;
        }
    }
    segundos_decorridos = 0;
}
alarm[0] = game_get_speed(gamespeed_fps);