if (room == rm_Tela_principal_3) {
    visible = false;
} else {
    visible = true;
}
if (room != rm_Tela_principal_1) { 
    exit; 
} 

if (variable_global_exists("cenario_1")) { 
    image_index = global.cenario_1; 
}