//SE TIVER DENTRO DA CONFIRMAÇÃO NÃO MOSTRAR O BOTÃO DE CRÉDITOS
if (instance_exists(obj_ctld_Fim_confirmacao) && obj_ctld_Fim_confirmacao.exibir_confirmacao == true) {
    mouse_clear(mb_left);
    exit; 
}

image_xscale = 2.9;
image_yscale = 0.9;
audio_play_sound(snd_Screen_change, 1, false);