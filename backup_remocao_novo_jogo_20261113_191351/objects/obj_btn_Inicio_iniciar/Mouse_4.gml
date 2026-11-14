if (novo_jogo_bloqueia()) exit;
if (!tutorial_permite(object_index)) exit;
//SE TIVER DENTRO DO SOBRE NÃO MOSTRAR O BOTÃO INICIAR
if (instance_exists(obj_ctld_Inicio_sobre) && obj_ctld_Inicio_sobre.exibir_sobre == true) {
    mouse_clear(mb_left);
    exit; 
}

image_xscale = 2.9;
image_yscale = 0.6;
audio_play_sound(snd_Screen_change, 1, false);