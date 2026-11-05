//SE TIVER DENTRO DA CONFIRMAÇÃO NÃO MOSTRAR O BOTÃO CRÉDITOS
if (instance_exists(obj_ctld_Fim_confirmacao) && obj_ctld_Fim_confirmacao.exibir_confirmacao == true) {
    mouse_clear(mb_left);
    exit; 
}

image_xscale = 3;
image_yscale = 1;
room_goto(rm_Creditos);