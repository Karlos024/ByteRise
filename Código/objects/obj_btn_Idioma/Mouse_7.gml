if (!tutorial_permite(object_index)) exit;
//SE TIVER DENTRO DO SOBRE MOSTRAR NÃO MOSTRAR O BOTÃO IDIOMA
if (instance_exists(obj_ctld_Inicio_sobre) && obj_ctld_Inicio_sobre.exibir_sobre == true) {
    mouse_clear(mb_left);
    exit; 
}

//SE TIVER DENTRO DA CONFIRMAÇÃO NÃO MOSTRAR O BOTÃO DE IDIOMA
if (instance_exists(obj_ctld_Fim_confirmacao) && obj_ctld_Fim_confirmacao.exibir_confirmacao == true) {
    mouse_clear(mb_left);
    exit; 
}

image_xscale = 1;
image_yscale = 1;
audio_play_sound(snd_Screen_change, 1, false);

global.idm += 1;
if (global.idm > 2) { 
	global.idm = 0; 
}
image_index = global.idm;