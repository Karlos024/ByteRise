//EVENTOS DO VÍDEO
if (!ds_map_exists(async_load, "type")) exit;
var _tipo = async_load[? "type"];
if (_tipo == "video_start") iniciado = true;
else if (_tipo == "video_end") finalizar();
