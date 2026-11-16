if (!fim_liberado) {
    exit;
}
if (room == rm_Cutscene_final || room == rm_Tela_final) {
    exit;
}
draw_sprite_ext(spr_Fim_aviso, floor(frame_aviso), 268, 595, 0.3, 0.3, 0, c_white, 1);