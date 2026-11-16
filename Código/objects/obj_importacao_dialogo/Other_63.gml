if (async_load[? "id"] != dialogo_id) exit;
var _confirmado = async_load[? "status"];
var codigo = async_load[? "result"];
if (!_confirmado || codigo == "") {
    instance_destroy();
    exit;
}
if (codigo != "") {
    var sucesso = importar_progresso(codigo);
    if (sucesso) {
        var txt_Sucesso = ["Progresso carregado com sucesso!", "Progress loaded successfully!", "¡Progreso cargado com éxito!"];
        show_message_async(txt_Sucesso[global.idm]);
        
        //CONFIGURAÇÕES
        if (instance_exists(obj_ctld_Configuracoes)) {
            with (obj_ctld_Configuracoes) {
                exibir_config = false;
                if (instance_exists(btn_Idiomas))         { instance_destroy(btn_Idiomas); }
                if (instance_exists(btn_Musica))          { instance_destroy(btn_Musica); }
                if (instance_exists(btn_Efeitos_sonoros)) { instance_destroy(btn_Efeitos_sonoros); }
                if (instance_exists(btn_Creditos))        { instance_destroy(btn_Creditos); }
                if (instance_exists(btn_Exportar))        { instance_destroy(btn_Exportar); }
                if (instance_exists(btn_Importar))        { instance_destroy(btn_Importar); }
                if (instance_exists(btn_Final))           { instance_destroy(btn_Final); }
            }
        }
        
		
        if (instance_exists(obj_Configuracoes)) {
            obj_Configuracoes.image_index = 0;
        }
        if (global.fase_atual == 3 && global.comprada_3) room_goto(rm_Tela_principal_3);
        else if (global.fase_atual == 2 && global.comprada_2) room_goto(rm_Tela_principal_2);
        else { global.fase_atual = 1; room_goto(rm_Tela_principal_1); }
    } else {
        var txt_Erro = ["Código inválido ou corrompido!", "Invalid or corrupted code!", "¡Código inválido o dañado!"];
        show_message_async(txt_Erro[global.idm]);
    }
}

instance_destroy();