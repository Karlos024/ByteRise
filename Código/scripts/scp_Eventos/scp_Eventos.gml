function scp_ms_superclique() {

    //INICIALIZA O CONTADOR
    if (!variable_global_exists("ms_superclique")) {
        global.ms_superclique = 0;
    }

    //EVITA BUG DE DUPLICAÇÃO DE CLIQUES
    if (!variable_global_exists("ms_superclique_ultimo_clique")) {
        global.ms_superclique_ultimo_clique = -1;
    }
    if (global.ms_superclique_ultimo_clique == current_time) {
        return;
    }
    global.ms_superclique_ultimo_clique = current_time;
    global.ms_superclique += 1;

    //ATUALIZA O PROGRESSO GLOBAL
    if (variable_global_exists("ms_progressos")) {
        global.ms_progressos[1] = global.ms_superclique;
    }

    //ATUALIZA A BARRA
    if (instance_exists(obj_ctld_Missao)) {
        with (obj_ctld_Missao) {
            progresso_missoes[1] = global.ms_superclique;
        }
    }
}