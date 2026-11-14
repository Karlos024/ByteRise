//INICIALIZAÇÃO
aberto = false;
iniciado = false;
encerrando = false;
tempo_espera = 0;
tempo_reproducao = 0;
falhas_quadro = 0;
display_set_gui_size(360, 640);

//ENCERRAMENTO
finalizar = function() {
    if (encerrando) return;
    encerrando = true;
    room_goto(rm_Tela_inicial);
};

//REPRODUÇÃO
try {
    video_open("carregamento.mp4");
    aberto = true;
    video_enable_loop(false);
    video_set_volume(1);
} catch (_erro) {
    finalizar();
}
