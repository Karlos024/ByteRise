if (global.gpu == 0) {
    visible = false;
    atendente_aqui = false;
    image_blend = c_white;
    exit;
} else {
    visible = true;
}

//DECLARAÇÃO
var protagonista = instance_find(obj_psn_Principal_2, 0);
var consertador = instance_find(obj_psn_Consertador_2, 0);

//VERIFICA QUEM ESTÁ NA MESA
var protagonista_aqui = (protagonista != noone && !protagonista.arrastando && protagonista.x == x && protagonista.y == y + 10);
var consertador_aqui = (consertador != noone && consertador.mesa_alvo == id && consertador.estado_func == 2);
atendente_aqui = (protagonista_aqui || consertador_aqui);

//EVENTO DE MISSÃO - VIDENTE
image_blend = c_white;
if (variable_global_exists("ms_vidente_tempo") && global.ms_vidente_tempo > 0) {
    if (protagonista != noone && !consertador_aqui) {
        with (obj_Clientes_2) {
            if (estado_fila == 1 && pedido_area == 2) {
                other.image_blend = c_lime;
            }
        }
    }
}