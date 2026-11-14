if (room_get_name(room) != "rm_Tela_principal_1") {
    alarm[0] = game_get_speed(gamespeed_fps);
    exit;
}

//EVENTO DE MISSÃO - CASA LOTADA
var casa_lotada_ativa = false;

if (variable_global_exists("ms_casa_tempo")) {
    casa_lotada_ativa = global.ms_casa_tempo > 0;
}
var limite_fila_balcao = 2;
if (casa_lotada_ativa) {
    limite_fila_balcao = 4;
}
var total_na_fila_1 = 0;
var total_na_fila_2 = 0;

//CONTABILIZAÇÃO DOS CLIENTES
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

//NÍVEL DO FUNCIONÁRIO
var Nivel_funcionario = 0;

if (variable_global_exists("funcionario_1")) {
    Nivel_funcionario = global.funcionario_1;
}

//VERIFICA SE A FILA ESTÁ LOTADA
var Cancela_nascimento = false;

if (Nivel_funcionario < 3) {
    if (total_na_fila_1 >= limite_fila_balcao) {
        Cancela_nascimento = true;
    }
} else {
    if (total_na_fila_1 >= limite_fila_balcao && total_na_fila_2 >= limite_fila_balcao) {
        Cancela_nascimento = true;
    }
}

//INTERVALO ENTRE TENTATIVAS
var intervalo = game_get_speed(gamespeed_fps);

if (casa_lotada_ativa) {
    intervalo = max(1, round(intervalo / 2));
}

if (Cancela_nascimento) {
    segundos_decorridos = 0;
    alarm[0] = intervalo;
    exit;
}


//CHANCE DE NASCIMENTO
segundos_decorridos += 1;
var cenario_upgrade = 0;
if (variable_global_exists("cenario_1")) {
    cenario_upgrade = global.cenario_1;
}

var multiplicador = 0.25 + (cenario_upgrade * 0.25);
multiplicador = clamp(multiplicador, 0.25, 1.00);

var chance = 0.5 * (segundos_decorridos * segundos_decorridos);
chance *= multiplicador;
chance = min(chance, 100);

var sorteio = random(100);

//TEMPO MÁXIMO DE NASCIMENTO
var tempo_maximo = 8;

switch (Nivel_funcionario) {
    case 0: tempo_maximo = 4; break;
    case 1: tempo_maximo = 3; break;
    case 2: tempo_maximo = 2; break;
    default: tempo_maximo = 1; break;
}

//NASCIMENTO DO CLIENTE
if (sorteio <= chance || segundos_decorridos >= tempo_maximo) {

    var fase_atual = 1;

    if (variable_instance_exists(id, "fase")) {
        fase_atual = fase;
    }

    var Algum = false;

    if (variable_global_exists("fliperama_1") && global.fliperama_1 > 0) {
        Algum = true;
    }

    if (variable_global_exists("fliperama_2") && global.fliperama_2 > 0) {
        Algum = true;
    }

    if (variable_global_exists("fliperama_3") && global.fliperama_3 > 0) {
        Algum = true;
    }

    if (Algum) {
        var cliente = instance_create_depth(x, y, -100, obj_Clientes_1);

        if (instance_exists(cliente)) {
            cliente.fase = fase_atual;
        }
    }

    segundos_decorridos = 0;
}

alarm[0] = intervalo;