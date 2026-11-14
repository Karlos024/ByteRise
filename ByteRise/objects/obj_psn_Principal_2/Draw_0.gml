if (room_get_name(room) != "rm_Tela_principal_2") {
    exit;
}
draw_self();

//SÓ APARECE QUANDO O PERSONAGEM SAÍ DA ORIGEM
if (x != x_original || y != y_original) {
    
    //BORDA
    draw_set_color(c_black);
    draw_circle(x_original, y_original + 0, 20, false);
    
    //FUNDO
    draw_set_color(make_color_rgb(60, 60, 60)); 
    draw_circle(x_original, y_original + 0, 14, false);
    
    //PROGRESSO
    var progresso_limpo = 0;
    var balcao = instance_find(obj_Balcao_2, 0);
    if (balcao != noone && ds_list_size(balcao.fila) > 0) {
        var cliente_da_vez = balcao.fila[| 0];
        if (instance_exists(cliente_da_vez)) {
            
            //PROTEÇÃO CONTRA BUGS DE VÁRIAVEIS NÃO EXISTENTE
            var concluiu = false;
            if (variable_instance_exists(cliente_da_vez, "atendimento_concluido_posto")) {
                concluiu = cliente_da_vez.atendimento_concluido_posto;
            }
            if (concluiu) {
                progresso_limpo = 100;
            } else if (variable_instance_exists(cliente_da_vez, "timer_atendimento") && variable_instance_exists(cliente_da_vez, "tempo_atendimento")) {
                if (cliente_da_vez.tempo_atendimento > 0) {
                    progresso_limpo = clamp(floor((cliente_da_vez.timer_atendimento / cliente_da_vez.tempo_atendimento) * 100), 0, 100);
                }
            }
        }
    }
    
	//ACABOU
    if (voltando == true) {
        progresso_limpo = 100;
    }
    
    //CIRCULO RADIAL
    if (progresso_limpo > 0) {
        if (progresso_limpo < 98) {
            draw_set_color(c_red);
        } else {
            draw_set_color(c_lime);
            progresso_limpo = 100;  
        }
        
        //FATIAS
        draw_primitive_begin(pr_trianglefan);
        draw_vertex(x_original, y_original + 0);
        for (var i = 0; i <= (progresso_limpo / 100) * 360; i += 2) {
            draw_vertex(x_original + lengthdir_x(14, i - 90), (y_original + 0) + lengthdir_y(14, i - 90));
        }
        draw_primitive_end();
    }
}