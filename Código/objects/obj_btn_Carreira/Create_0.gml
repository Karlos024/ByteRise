image_speed = 0;
image_index = 0;
image_xscale = 0.7;
image_yscale = 0.7;
animando_missao = false;
som_missao = -1;

//IDENTIFICA RECOMPENSAS JÁ NOTIFICADAS
if (!variable_global_exists("ms_avisadas")) {
    global.ms_avisadas = array_create(12, -1);
}
if (!variable_global_exists("bloquear_clique_celular")) {
    global.bloquear_clique_celular = false;
}