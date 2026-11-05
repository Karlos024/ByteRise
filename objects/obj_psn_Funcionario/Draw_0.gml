draw_self();
if (variable_global_exists("funcionario_1") && global.funcionario_1 >= 3) {        
        draw_sprite_ext(spr_psn_Atendedor_1, image_index, 325, 275, -1.1, 0.8, 0, c_white, 1);
    }