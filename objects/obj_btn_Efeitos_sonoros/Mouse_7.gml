//SE TIVER DENTRO DA CONFIRMAÇÃO NÃO MOSTRAR O BOTÃO DE EFEITOS SONOROS
if (instance_exists(obj_ctld_Fim_confirmacao) && obj_ctld_Fim_confirmacao.exibir_confirmacao == true) {
    mouse_clear(mb_left);
    exit; 
}

image_xscale = 1;
image_yscale = 1;
 
global.sc_ligado = !global.sc_ligado;
image_index = !global.sc_ligado;
if (global.sc_ligado == true) {
    audio_sound_gain(snd_Botao, 1, 0);
	audio_sound_gain(snd_Compra, 1, 0);
	audio_sound_gain(snd_Nivel, 1, 0);
	audio_sound_gain(snd_Maximo, 1, 0);
	audio_sound_gain(snd_Moeda, 1, 0);
	audio_sound_gain(snd_Passando, 1, 0);
	audio_sound_gain(snd_Recusado, 1, 0);
	audio_sound_gain(snd_Troca_de_tela, 1, 0);
} else {
    audio_sound_gain(snd_Botao, 0, 0);
	audio_sound_gain(snd_Compra, 0, 0);
	audio_sound_gain(snd_Nivel, 0, 0);
	audio_sound_gain(snd_Maximo, 0, 0);
	audio_sound_gain(snd_Moeda, 0, 0);
	audio_sound_gain(snd_Passando, 0, 0);
	audio_sound_gain(snd_Recusado, 0, 0);
	audio_sound_gain(snd_Troca_de_tela, 0, 0);
}