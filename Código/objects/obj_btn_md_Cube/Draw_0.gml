//FUNDO COLORIDO, MOEDA E SINAL COM AS CORES ORIGINAIS
if (image_blend != c_white) {
    shader_set(shd_Fundo_compra);
    shader_set_uniform_f(shader_get_uniform(shd_Fundo_compra, "cor_fundo"),
        color_get_red(image_blend) / 255, color_get_green(image_blend) / 255, color_get_blue(image_blend) / 255);
}
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, image_alpha);
if (image_blend != c_white) shader_reset();
