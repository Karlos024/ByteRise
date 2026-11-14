if (room == rm_Tela_principal_3) {
    visible = false;
} else {
    visible = true;
}
if (room != rm_Tela_principal_1) { 
    exit; 
} 

//SE MUDAR O NÍVEL VAI ATUALIZAR O FRAME
if (global.funcionario_1 != nivel) {
    nivel = global.funcionario_1;
    if (nivel <= 1) {
        sprite_index = spr_psn_Principal_1;
		image_xscale = -1;
    } 
    else if (nivel >= 2) {
        sprite_index = spr_psn_Atendedor_1;
		image_xscale = 1;
    }
    image_index = 0;
	image_yscale = 0.8;
}