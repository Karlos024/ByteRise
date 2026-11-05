//SE TIVER DENTRO DO SOBRE NÃO MOSTRAR O BOTÃO SOBRE
if (instance_exists(obj_ctld_Inicio_sobre) && obj_ctld_Inicio_sobre.exibir_sobre == true) {
    mouse_clear(mb_left);
    exit; 
}

image_xscale = 2;
image_yscale = 0.7;

//SE TIVER DENTRO DO SOBRE MOSTRAR
if (instance_exists(obj_ctld_Inicio_sobre)) {
    with (obj_ctld_Inicio_sobre) {
        if (exibir_sobre == false) {
            exibir_sobre = true; 
            btn_sair = instance_create_depth(180, 600, -10, obj_btn_Incio_sobre_sair);
        }
    }
}