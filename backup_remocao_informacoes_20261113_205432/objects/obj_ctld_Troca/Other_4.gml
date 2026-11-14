//LIMPEZA
exibir_troca_fase = false;
Comprar           = noone;
Cancelar          = noone;
if (surface_exists(surf_blur)) {
    surface_free(surf_blur);
}
surf_blur = -1;