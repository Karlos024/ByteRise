if (!tutorial_permite(object_index)) exit;
//SE TIVER DENTRO DA CONFIRMAÇÃO NÃO MOSTRAR O BOTÃO DE EXPORTAR
if (instance_exists(obj_ctld_Fim_confirmacao) && obj_ctld_Fim_confirmacao.exibir_confirmacao == true) {
    mouse_clear(mb_left);
    exit; 
}

image_xscale = 0.9;
image_yscale = 0.9;
audio_play_sound(snd_Screen_change, 1, false);

//GERA O BACKUP E SALVA
exportar_progresso();
var txt_Sucesso = ["Progresso exportado! O código foi copiado para sua área de transferência. Guarde-o com segurança.", "Progress exported! The code has been copied to your clipboard. Keep it safe.", "¡Progreso exportado! El código foi copiado a tu portapapeles. Guárdalo de forma segura."];
show_message_async(txt_Sucesso[global.idm]);