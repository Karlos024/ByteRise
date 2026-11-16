//REPRODUÇÃO
if (encerrando) exit;
if (falhou) {
    if (device_mouse_check_button_released(0, mb_left)) abrir_video();
    exit;
}
if (!aberto) exit;
var _status = video_get_status();
if (_status == video_status_playing) iniciado = true;
if (!iniciado) tempo_espera += min(delta_time / 1000000, 0.25);

//FALHA DE ABERTURA
if ((_status == video_status_closed && (iniciado || tempo_espera > 1)) || (!iniciado && tempo_espera >= 15)) {
    falhou = true;
}
