if (!tutorial_permite(object_index)) exit;
//SE TIVER DENTRO DA CONFIRMAÇÃO NÃO MOSTRAR O BOTÃO DE IMPORTAR
if (instance_exists(obj_ctld_Fim_confirmacao) && obj_ctld_Fim_confirmacao.exibir_confirmacao == true) {
    mouse_clear(mb_left);
    exit; 
}

image_xscale = 0.9;
image_yscale = 0.9;
audio_play_sound(snd_Troca_de_tela, 1, false);

if (!instance_exists(obj_importacao_dialogo)) instance_create_depth(0, 0, -20000, obj_importacao_dialogo);
