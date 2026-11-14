//TROCA O FRAME
var Aprimoramento = 0;
if (variable_global_exists("fliperama_2")) {
    Aprimoramento = global.fliperama_2;
    if (Aprimoramento >= 9) {
        image_index = 3; 
    } else if (Aprimoramento >= 6) {
        image_index = 2; 
    } else if (Aprimoramento >= 3) {
        image_index = 1; 
    } else if (Aprimoramento >= 1) {
        image_index = 0; 
    } else {
        image_index = 0;
    }
}

//QUANTOS FLIPERAMAS ESTÃO LIBERADOS
var Liberado = 0;
if (Aprimoramento >= 9) { Liberado = 4; }
else if (Aprimoramento >= 6) { Liberado = 3; }
else if (Aprimoramento >= 3) { Liberado = 2; }
else if (Aprimoramento >= 1) { Liberado = 1; }

//ATIVA OU DESATIVA A VISIBILIDADE
var Conquistado = (slot_numero < Liberado);

if (Conquistado != comprado) {
    comprado = Conquistado;
    
    //FAZ O CLIENTE ACHA O FLIPERAMA
    with (obj_Clientes_1) {
        caminho_tx = -9999;
    }
}
if (!comprado) {
    visible = false;
    ocupado = false;
    exit;
} else {
    visible = true; 
}