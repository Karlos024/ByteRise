if (room_get_name(room) != "rm_Tela_principal_2") {
    exit;
}
draw_self();

//SÓ APARECE QUANDO O PERSONAGEM SAÍ DA ORIGEM
if (estado_func > 0) {
    
    //BORDA
    draw_set_color(c_black);
    draw_circle(x_posto, y_posto + 0, 20, false);
    
    //FUNDO
    draw_set_color(make_color_rgb(60, 60, 60)); 
    draw_circle(x_posto, y_posto + 0, 14, false);
    
    //PROGESSO
    var progresso_limpo = clamp(floor((timer_trabalho / tempo_trabalho) * 100), 0, 100);
    
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
        draw_vertex(x_posto, y_posto + 0);
        for (var i = 0; i <= (progresso_limpo / 100) * 360; i += 2) {
            draw_vertex(x_posto + lengthdir_x(14, i - 90), (y_posto + 0) + lengthdir_y(14, i - 90));
        }
        draw_primitive_end();
    }
}