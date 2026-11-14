if (room == rm_Tela_principal_3) {
    visible = false;
} else {
    visible = true;
}
if (room != rm_Tela_principal_2) { 
    exit; 
} 

if (variable_global_exists("cenario_2")) { 
    image_index = global.cenario_2; 
}