//REPRODUÇÃO
if (encerrando || !aberto) exit;
var _dt = min(delta_time / 1000000, 0.25);
var _status = video_get_status();
if (_status == video_status_playing) iniciado = true;
if (iniciado) tempo_reproducao += _dt;
else tempo_espera += _dt;

//PROTEÇÃO CONTRA FALHA DE REPRODUÇÃO
if (_status == video_status_closed || tempo_espera >= 10 || falhas_quadro >= 60) {
    finalizar();
    exit;
}
if (iniciado) {
    var _duracao = video_get_duration() / 1000;
    if (_duracao <= 0) _duracao = 4.54;
    if (tempo_reproducao >= _duracao + 3) finalizar();
}
