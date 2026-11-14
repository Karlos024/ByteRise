//PROTEÇÃO
if (!variable_global_exists("comprada_2")) {
    global.comprada_2 = false; 
}
if (!variable_global_exists("comprada_3")) {
    global.comprada_3 = false;
}

exibir_troca_fase = false;
fase_para_comprar = 2;
Comprar           = noone;
Cancelar          = noone;
surf_blur = -1;

//GARANTE QUE O OBJETO NÃO DUPLIQUE
if (!instance_exists(obj_ctld_Troca)) {
    instance_create_layer(0, 0, "Instances", obj_ctld_Troca);
}