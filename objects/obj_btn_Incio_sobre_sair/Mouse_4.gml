if (!tutorial_permite(object_index)) exit;
image_xscale = 0.9;
image_yscale = 0.9;

audio_play_sound(snd_Screen_change, 1, false);

//SE TIVER DENTRO DO SOBRE MOSTRAR O SAIR
if (instance_exists(obj_ctld_Inicio_sobre)) {
    with (obj_ctld_Inicio_sobre) {
        exibir_sobre = false;
    }
}
instance_destroy();