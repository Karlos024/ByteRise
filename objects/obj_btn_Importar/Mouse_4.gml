//SE TIVER DENTRO DA CONFIRMAÇÃO NÃO MOSTRAR O BOTÃO DE IMPORTAR
if (instance_exists(obj_ctld_Fim_confirmacao) && obj_ctld_Fim_confirmacao.exibir_confirmacao == true) {
    mouse_clear(mb_left);
    exit; 
}

image_xscale = 0.9;
image_yscale = 0.9;
audio_play_sound(snd_Screen_change, 1, false);

var txt_Pedido = ["Cole aqui o seu código de progresso exportado:", "Paste your exported progress code here:","Pega aquí tu código de progreso exportado:"];
var codigo = get_string(txt_Pedido[global.idm], "");

if (codigo != "") {
    var sucesso = importar_progresso(codigo);
    if (sucesso) {
        var txt_Sucesso = ["Progresso carregado com sucesso!", "Progress loaded successfully!", "¡Progreso cargado com éxito!"];
        show_message_async(txt_Sucesso[global.idm]);
        
        //LIMPEZA DO CONTROLADOR DE CONFIGURAÇÃO
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
        
		//EVITA BUGS DE DUPLICAÇÃO
        if (instance_exists(obj_ctld_Fim_estatisticas_cronometro)) instance_destroy(obj_ctld_Fim_estatisticas_cronometro);
        if (instance_exists(obj_ctld_Moeda)) instance_destroy(obj_ctld_Moeda);
        if (instance_exists(obj_ctld_Experiencia)) instance_destroy(obj_ctld_Experiencia);
        if (instance_exists(obj_Configuracoes)) {
            obj_Configuracoes.image_index = 0;
        }
        room_goto(rm_Tela_inicial);
    } else {
        var txt_Erro = ["Código inválido ou corrompido!", "Invalid or corrupted code!", "¡Código inválido o dañado!"];
        show_message_async(txt_Erro[global.idm]);
    }
}