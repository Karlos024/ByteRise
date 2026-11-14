//EVITA BUG DUPLICAÇÃO
if (instance_number(obj_ctld_Eventos) > 1) {
    instance_destroy();
    exit;
}

//DECLARAÇÃO DE VÁRIAVEIS
if (!variable_global_exists("ms_superclique")) {
    global.ms_superclique = 0;
}
if (!variable_global_exists("ms_superclique_nivel")) {
    global.ms_superclique_nivel = 0;
}
if (!variable_global_exists("ms_superclique_tempo")) {
    global.ms_superclique_tempo = 0;
}
if (!variable_global_exists("ms_superclique_bonus")) {
    global.ms_superclique_bonus = 0;
}
if (!variable_global_exists("ms_superclique_ultimo_clique")) {
    global.ms_superclique_ultimo_clique = -1;
}

//CONTROLE DA MÚSICA
id_som_evento = -1;
musica_interrompida = false;