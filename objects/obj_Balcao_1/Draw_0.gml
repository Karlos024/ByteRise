draw_self();
if (variable_global_exists("funcionario_1") && global.funcionario_1 >= 3) {
    draw_sprite_ext(sprite_index, image_index, x + balcao_x, y, -1.1,  0.9, 0, c_white, 1);
}