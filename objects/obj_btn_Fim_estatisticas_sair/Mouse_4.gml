image_xscale = 0.9;
image_yscale = 0.9;

audio_play_sound(snd_Screen_change, 1, false);

//SE TIVER DENTRO DAS ESTATÍSTICAS MOSTRAR O SAIR
if (instance_exists(obj_ctld_Fim_estatisticas)) {
    with (obj_ctld_Fim_estatisticas) {
        exibir_estatisticas = false;
    }
}
instance_destroy();