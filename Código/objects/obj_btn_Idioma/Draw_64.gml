//SE TIVER DENTRO DO SOBRE MOSTRAR NÃO MOSTRAR O BOTÃO SOBRE
if (instance_exists(obj_ctld_Inicio_sobre) && obj_ctld_Inicio_sobre.exibir_sobre == true) {
    mouse_clear(mb_left);
    exit; 
}

draw_self();