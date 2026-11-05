if (global.psu == 0) {
    visible = false;
    atendente_aqui = false;
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