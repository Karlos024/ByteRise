//INICIALIZAÇÃO
aberto = false;
iniciado = false;
terminou = false;
encerrando = false;
falhou = false;
tempo_espera = 0;
display_set_gui_size(360, 640);

//TELA INICIAL
finalizar = function() {
    if (!terminou || encerrando) return;
    encerrando = true;
    room_goto(rm_Tela_inicial);
};

//REPRODUÇÃO
abrir_video = function() {
    if (aberto) video_close();
    aberto = false;
    iniciado = false;
    terminou = false;
    falhou = false;
    tempo_espera = 0;
    try {
        video_open("carregamento.mp4");
        aberto = true;
        video_enable_loop(false);
        video_set_volume(1);
    } catch (_erro) {
        falhou = true;
    }
};
abrir_video();
