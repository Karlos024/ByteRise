// GESTO DE COMPRA - mouse e primeiro toque usam o mesmo ciclo.
// Usa o controlador de GUI presente em todas as telas para os dois tutoriais.
function tutorial_extras_desenhar() {
    var _guia = noone;
    if (tutorial_missoes_ativo()) _guia = instance_find(obj_Tutorial_interativo_missoes,0);
    else if (tutorial_melhoria_ativo()) _guia = instance_find(obj_Tutorial_interativo_melhoria,0);
    if (_guia == noone) { melhoria_desenhar_descricao(); return; }
    with (_guia) {
        if (object_index == obj_Tutorial_interativo_melhoria) ocultar_caixa = melhoria_descricao_alvo() == alvo;
        tutorial_desenhar(id,0);
        if (object_index == obj_Tutorial_interativo_melhoria) melhoria_desenhar_descricao();
        if (!variable_instance_exists(id,"diagnostico_gui_registrado") || !diagnostico_gui_registrado) {
            diagnostico_gui_registrado = true;
            melhoria_diagnosticar("GUI tutorial desenhado");
        }
    }
}
// Diagnostico temporario: registra o estado real sem alterar o save.
function melhoria_diagnosticar(_ponto) {
    var _ler = function(_instancia, _campo) {
        if (!variable_instance_exists(_instancia, _campo)) return "nao inicializado";
        return string(variable_instance_get(_instancia, _campo));
    };
    if (!variable_global_exists("md_diagnostico_iniciado")) {
        global.md_diagnostico_iniciado = true;
        var _novo = file_text_open_write("diagnostico_melhorias.txt");
        file_text_close(_novo);
    }
    var _linha = string(current_time) + " " + _ponto + " room=" + room_get_name(room);
    var _guias = [obj_Tutorial_interativo_1,obj_Tutorial_interativo_2,obj_Tutorial_interativo_3,
        obj_Tutorial_interativo_melhoria,obj_Tutorial_interativo_missoes];
    for (var _n = 0; _n < array_length(_guias); _n++) {
        var _g = instance_find(_guias[_n],0);
        if (_g == noone) continue;
        _linha += " | " + object_get_name(_guias[_n]) + " ativo=" + _ler(_g,"ativo")
            + " etapa=" + _ler(_g,"etapa") + " visible=" + _ler(_g,"visible") + " depth=" + _ler(_g,"depth");
    }
    if (instance_exists(obj_ctld_Configuracoes)) _linha += " config=" + _ler(instance_find(obj_ctld_Configuracoes,0),"exibir_config");
    if (instance_exists(obj_ctld_Carreira)) _linha += " carreira=" + _ler(instance_find(obj_ctld_Carreira,0),"exibir_progresso");
    if (instance_exists(obj_ctld_Troca)) _linha += " troca=" + _ler(instance_find(obj_ctld_Troca,0),"exibir_troca_fase");
    _linha += " mouse=" + string(device_mouse_x(0)) + "," + string(device_mouse_y(0))
        + " press=" + string(device_mouse_check_button_pressed(0,mb_left))
        + " release=" + string(device_mouse_check_button_released(0,mb_left));
    show_debug_message(_linha);
    var _arquivo = file_text_open_append("diagnostico_melhorias.txt");
    file_text_write_string(_arquivo,_linha); file_text_writeln(_arquivo); file_text_close(_arquivo);
}
function melhoria_diagnosticar_step() {
    if (!melhoria_tela_ativa()) return;
    if (!variable_instance_exists(id,"md_diagnostico_room") || md_diagnostico_room != room) {
        md_diagnostico_room = room; md_diagnostico_linhas = 0; md_diagnostico_tempo = 0;
    }
    if (md_diagnostico_linhas >= 30) return;
    if (current_time < md_diagnostico_tempo && !device_mouse_check_button_pressed(0,mb_left)
        && !device_mouse_check_button_released(0,mb_left)) return;
    md_diagnostico_tempo = current_time + 1000; md_diagnostico_linhas++;
    melhoria_diagnosticar("Step");
}
function melhoria_interacao_permitida(_botao) {
    if (instance_exists(obj_ctld_Configuracoes) && obj_ctld_Configuracoes.exibir_config) return false;
    if (instance_exists(obj_ctld_Carreira) && obj_ctld_Carreira.exibir_progresso) return false;
    if (instance_exists(obj_ctld_Troca) && obj_ctld_Troca.exibir_troca_fase) return false;
    return _botao.visible && tutorial_permite(_botao.object_index) && f3_tutorial_permite(_botao.object_index);
}

function melhoria_iniciar_gesto(_botao) {
    if (!melhoria_interacao_permitida(_botao)) return;
    _botao.md_pressionado = true;
    _botao.md_inicio = current_time;
    _botao.md_cancelado = false;
    _botao.md_compra_bloqueada = !tutorial_melhoria_compra_permitida(_botao);
    _botao.md_x = device_mouse_x(0);
    _botao.md_y = device_mouse_y(0);
    _botao.md_retangulo = [_botao.bbox_left, _botao.bbox_top, _botao.bbox_right, _botao.bbox_bottom];
    _botao.image_xscale = 0.9;
    _botao.image_yscale = 0.9;
    global.melhoria_gesto_alvo = _botao;
}

function melhoria_gesto_dentro(_botao) {
    var _x = device_mouse_x(0), _y = device_mouse_y(0);
    var _r = _botao.md_retangulo;
    return point_in_rectangle(_x, _y, _r[0], _r[1], _r[2], _r[3])
        && point_distance(_x, _y, _botao.md_x, _botao.md_y) <= 12;
}

function melhoria_atualizar_gesto(_botao) {
    if (!variable_instance_exists(_botao, "md_pressionado") || !_botao.md_pressionado) return;
    if (!melhoria_interacao_permitida(_botao) || !melhoria_gesto_dentro(_botao)) _botao.md_cancelado = true;
    if (device_mouse_check_button_released(0, mb_left)) {
        // Inclui a borda original do botao, mesmo com a animacao de pressionado.
        with (_botao) event_perform(ev_mouse, ev_left_release);
    } else if (!device_mouse_check_button(0, mb_left)) {
        _botao.md_pressionado = false;
        _botao.image_xscale = 1;
        _botao.image_yscale = 1;
    }
}

function melhoria_soltar_gesto(_botao) {
    _botao.image_xscale = 1;
    _botao.image_yscale = 1;
    if (!variable_instance_exists(_botao, "md_pressionado") || !_botao.md_pressionado) return false;
    _botao.md_pressionado = false;
    // Verifica a duracao tambem aqui: segurar nunca vira compra ao soltar.
    return !_botao.md_cancelado && !_botao.md_compra_bloqueada
        && tutorial_melhoria_compra_permitida(_botao) && current_time - _botao.md_inicio < 350
        && melhoria_gesto_dentro(_botao) && melhoria_interacao_permitida(_botao);
}

// IDENTIFICACAO DAS 18 MELHORIAS.
function melhoria_dados(_objeto) {
    var _idm = clamp(global.idm, 0, 2);
    switch (_objeto) {
        case obj_btn_md_Internet: return {titulo:"Internet", campo:"internet", grupo:0};
        case obj_btn_md_Funcionario_1: return {titulo:["Funcionários - Lan House","Staff - Internet café","Personal - Cibercafé"][_idm], campo:"funcionario_1", grupo:0};
        case obj_btn_md_Cenario_1: return {titulo:["Cenário - Lan House","Decor - Internet café","Decoración - Cibercafé"][_idm], campo:"cenario_1", grupo:0};
        case obj_btn_md_Energia: return {titulo:["Energia","Power","Energía"][_idm], campo:"energia", grupo:0};
        case obj_btn_md_Funcionario_2: return {titulo:["Funcionários - Assistência","Staff - Workshop","Personal - Taller"][_idm], campo:"funcionario_2", grupo:0};
        case obj_btn_md_Cenario_2: return {titulo:["Cenário - Assistência","Decor - Workshop","Decoración - Taller"][_idm], campo:"cenario_2", grupo:0};
        case obj_btn_md_Cafe: return {titulo:["Café","Coffee","Café"][_idm], campo:"cafe", grupo:0};
        case obj_btn_md_Funcionario_3: return {titulo:["Funcionários de carga","Loading staff","Personal de carga"][_idm], campo:"funcionario_3", grupo:0};
        case obj_btn_md_Transporte: return {titulo:["Transporte","Transport","Transporte"][_idm], campo:"transporte", grupo:0};
        case obj_btn_md_Cube: return {titulo:"Cube World", campo:"fliperama_1", grupo:1};
        case obj_btn_md_Alfredos: return {titulo:"Four Days at Alfredo's", campo:"fliperama_2", grupo:1};
        case obj_btn_md_Pocket: return {titulo:"Pocket Monsters", campo:"fliperama_3", grupo:1};
        case obj_btn_md_HD_SSD: return {titulo:"HD/SSD", campo:"hd_ssd", grupo:2};
        case obj_btn_md_PSU: return {titulo:"PSU", campo:"psu", grupo:2};
        case obj_btn_md_GPU: return {titulo:"GPU", campo:"gpu", grupo:2};
        case obj_btn_md_Celular: return {titulo:["Celular","Phone","Celular"][_idm], campo:"celular", grupo:3};
        case obj_btn_md_Tablet: return {titulo:"Tablet", campo:"tablet", grupo:3};
        case obj_btn_md_Notebook: return {titulo:"Notebook", campo:"notebook", grupo:3};
    }
    return undefined;
}

// EFEITO DO PROXIMO NIVEL, CONFORME AS REGRAS DE ATENDIMENTO E PRODUCAO.
function melhoria_descricao(_dados) {
    var _idm = clamp(global.idm, 0, 2);
    var _nivel = variable_global_get(_dados.campo);
    var _maximo = (_dados.grupo == 0) ? 3 : 15;
    if (_nivel >= _maximo) return ["Esta melhoria já está no nível máximo. Não há outra compra disponível.","This upgrade is already at its maximum level. No further purchase is available.","Esta mejora ya está al nivel máximo. No hay otra compra disponible."][_idm];
    var _proximo = _nivel + 1;
    if (_dados.grupo == 1) {
        if (_proximo == 1) return ["Libera o primeiro fliperama deste tipo para receber clientes e ganhar moedas e XP.","Unlocks the first arcade of this type to serve customers and earn coins and XP.","Desbloquea la primera arcade de este tipo para atender clientes y ganar monedas y XP."][_idm];
        if (_proximo == 3 || _proximo == 6 || _proximo == 9) return ["Libera mais um fliperama deste tipo para atender outro cliente ao mesmo tempo.","Unlocks one more arcade of this type to serve another customer at the same time.","Desbloquea otra arcade de este tipo para atender a otro cliente al mismo tiempo."][_idm];
        var _xp = _proximo == 2 || _proximo == 5 || _proximo == 8 || _proximo == 11 || _proximo == 13 || _proximo == 15;
        return _xp ? ["Aumenta o XP recebido por cliente que termina de usar este tipo de fliperama.","Increases XP earned per customer who finishes using this type of arcade.","Aumenta el XP recibido por cliente que termina de usar este tipo de arcade."][_idm]
            : ["Aumenta as moedas recebidas por cliente que termina de usar este tipo de fliperama.","Increases coins earned per customer who finishes using this type of arcade.","Aumenta las monedas recibidas por cliente que termina de usar este tipo de arcade."][_idm];
    }
    if (_dados.grupo == 2) {
        if (_proximo == 1) return ["Libera esta área de conserto e os pedidos correspondentes. Consertos corretos geram moedas e XP.","Unlocks this repair area and its matching requests. Correct repairs earn coins and XP.","Desbloquea esta área de reparación y sus pedidos. Las reparaciones correctas dan monedas y XP."][_idm];
        return (_proximo mod 2 == 0) ? ["Aumenta o XP recebido por conserto correto nesta área. Não altera a velocidade do conserto.","Increases XP earned per correct repair in this area. Repair speed stays the same.","Aumenta el XP recibido por reparación correcta en esta área. No cambia la velocidad de reparación."][_idm]
            : ["Aumenta as moedas recebidas por conserto correto nesta área. Não altera a velocidade do conserto.","Increases coins earned per correct repair in this area. Repair speed stays the same.","Aumenta las monedas recibidas por reparación correcta en esta área. No cambia la velocidad de reparación."][_idm];
    }
    if (_dados.grupo == 3) {
        if (_proximo == 1 || _proximo == 5 || _proximo == 10) return ["Libera uma bancada deste dispositivo com seu montador, aumentando a produção simultânea.","Unlocks a bench for this device with its assembler, increasing simultaneous production.","Desbloquea un banco para este dispositivo con su ensamblador y aumenta la producción simultánea."][_idm];
        var _xp = _proximo == 2 || _proximo == 4 || _proximo == 7 || _proximo == 9 || _proximo == 12 || _proximo == 14;
        return _xp ? ["Aumenta o XP de cada dispositivo deste tipo entregue pelos veículos. O ganho ocorre na entrega.","Increases XP for each device of this type delivered by vehicles. Rewards are earned on delivery.","Aumenta el XP de cada dispositivo de este tipo entregado por los vehículos. Se cobra al entregar."][_idm]
            : ["Aumenta as moedas de cada dispositivo deste tipo entregue pelos veículos. O ganho ocorre na entrega.","Increases coins for each device of this type delivered by vehicles. Rewards are earned on delivery.","Aumenta las monedas de cada dispositivo de este tipo entregado por los vehículos. Se cobra al entregar."][_idm];
    }
    switch (_dados.campo) {
        case "internet":
            var _segundos = string([7, 5, 3][_nivel]);
            return ["Automatiza o uso dos fliperamas. O ciclo base passa para "+_segundos+" segundos; cliques continuam acelerando.","Automates arcade sessions. Base duration becomes "+_segundos+" seconds; clicks still speed them up.","Automatiza el uso de las arcades. El ciclo base pasa a "+_segundos+" segundos; los clics siguen acelerándolo."][_idm];
        case "funcionario_1":
            return [["Reduz o atendimento no balcão para 2 segundos e permite ganhos da Lan House enquanto você visita outras telas.","Reduces counter service to 2 seconds and enables Internet café earnings while visiting other screens.","Reduce la atención en el mostrador a 2 segundos y permite ganancias del cibercafé en otras pantallas."],
                ["Reduz o atendimento no balcão para 1,5 segundo e acelera os ganhos da Lan House em outras telas.","Reduces counter service to 1.5 seconds and speeds up Internet café earnings on other screens.","Reduce la atención en el mostrador a 1,5 segundos y acelera las ganancias del cibercafé en otras pantallas."],
                ["Libera um segundo atendente e uma segunda fila no balcão da Lan House.","Unlocks a second attendant and a second counter queue at the Internet café.","Desbloquea un segundo empleado y una segunda fila en el mostrador del cibercafé."]][_nivel][_idm];
        case "cenario_1": case "cenario_2":
            return ["Melhora o visual deste estabelecimento e aumenta a frequência de chegada de clientes.","Improves this business's appearance and increases how frequently customers arrive.","Mejora el aspecto de este negocio y aumenta la frecuencia de llegada de clientes."][_idm];
        case "energia":
            return ["Este nível de Energia ainda não altera a velocidade dos consertos no jogo atual. A automação é controlada pelos funcionários.","This Power level does not yet change repair speed in the current game. Staff upgrades control automation.","Este nivel de Energía todavía no cambia la velocidad de reparación en el juego actual. El personal controla la automatización."][_idm];
        case "funcionario_2":
            return [["Contrata um técnico que faz os consertos. Você continua escolhendo a área correta de cada pedido.","Hires a technician to perform repairs. You still choose the correct area for each request.","Contrata un técnico para reparar. Sigues eligiendo el área correcta de cada pedido."],
                ["Dobra a velocidade de deslocamento do técnico e do protagonista.","Doubles the movement speed of the technician and protagonist.","Duplica la velocidad de movimiento del técnico y del protagonista."],
                ["Automatiza o atendimento e a escolha da área de conserto. Permite ganhos da assistência em outras telas.","Automates customer service and repair-area selection. Enables workshop earnings on other screens.","Automatiza la atención y la elección del área de reparación. Permite ganancias del taller en otras pantallas."]][_nivel][_idm];
        case "cafe":
            var _segundos_cafe = string([10, 7, 5][_nivel]);
            return ["Ativa a montagem automática e acelera a produção e o transporte. O ciclo base de montagem passa para "+_segundos_cafe+" segundos.","Enables automatic assembly and speeds up production and transport. Base assembly duration becomes "+_segundos_cafe+" seconds.","Activa el ensamblaje automático y acelera la producción y el transporte. El ciclo base pasa a "+_segundos_cafe+" segundos."][_idm];
        case "funcionario_3":
            return [["Aumenta de 2 para 4 a capacidade de carga de cada exportador e encomendador.","Increases each exporter's and loader's carrying capacity from 2 to 4.","Aumenta de 2 a 4 la capacidad de carga de cada exportador y cargador."],
                ["Adiciona um segundo exportador e encomendador. A capacidade de cada um aumenta para 6.","Adds a second exporter and loader. Each worker's carrying capacity increases to 6.","Añade un segundo exportador y cargador. La capacidad de cada uno aumenta a 6."],
                ["Expande a esteira para enviar caixas aos veículos automaticamente. A capacidade de carga dos funcionários passa para 9.","Expands the conveyor to send boxes to vehicles automatically. Workers' carrying capacity increases to 9.","Amplía la cinta para enviar cajas a los vehículos automáticamente. La capacidad de los trabajadores aumenta a 9."]][_nivel][_idm];
        case "transporte":
            var _quantidade = string([2, 3, 4][_nivel]);
            var _capacidade = string([6, 8, 10][_nivel]);
            return ["Amplia a frota para "+_quantidade+" veículos. Cada veículo leva "+_capacidade+" caixas por viagem; o pagamento ocorre na entrega.","Expands the fleet to "+_quantidade+" vehicles. Each carries "+_capacidade+" boxes per trip; rewards are earned on delivery.","Amplía la flota a "+_quantidade+" vehículos. Cada uno lleva "+_capacidade+" cajas por viaje; se cobra al entregar."][_idm];
    }
    return "";
}

// DESCRICAO VISIVEL SOMENTE ENQUANTO O BOTAO CONTINUA SEGURADO.
function melhoria_descricao_alvo() {
    if (!variable_global_exists("melhoria_gesto_alvo")) return noone;
    var _botao = global.melhoria_gesto_alvo;
    if (!instance_exists(_botao) || !device_mouse_check_button(0, mb_left)) return noone;
    if (!variable_instance_exists(_botao, "md_pressionado") || !_botao.md_pressionado || _botao.md_cancelado) return noone;
    if (current_time - _botao.md_inicio < 350 || !melhoria_gesto_dentro(_botao) || !melhoria_interacao_permitida(_botao)) return noone;
    return _botao;
}

function melhoria_desenhar_descricao() {
    var _botao = melhoria_descricao_alvo();
    if (_botao == noone) return;
    var _dados = melhoria_dados(_botao.object_index);
    if (is_undefined(_dados)) return;
    draw_set_font(font_Pequena);
    draw_set_halign(fa_left); draw_set_valign(fa_top);
    var _escala = 1.2;
    var _texto = melhoria_descricao(_dados);
    var _titulo_h = string_height_ext(_dados.titulo, 17, 304 / _escala) * _escala;
    var _texto_h = string_height_ext(_texto, 17, 304 / _escala) * _escala;
    var _altura = _titulo_h + _texto_h + 36;
    var _y = (_botao.y < 320) ? min(390, 570 - _altura) : 72;
    draw_set_alpha(1); draw_set_color(make_color_rgb(20,29,46));
    draw_roundrect(12, _y, 348, _y + _altura, false);
    draw_set_color(make_color_rgb(255,210,75));
    draw_text_ext_transformed(28, _y + 12, _dados.titulo, 17, 304 / _escala, _escala, _escala, 0);
    draw_set_color(c_white);
    draw_text_ext_transformed(28, _y + 20 + _titulo_h, _texto, 17, 304 / _escala, _escala, _escala, 0);
    draw_set_halign(fa_left); draw_set_valign(fa_top);
    if (tutorial_melhoria_ativo()) {
        var _guia = instance_find(obj_Tutorial_interativo_melhoria, 0);
        if (_guia.etapa == 1 && _guia.alvo == _botao) _guia.leitura_demonstrada = true;
    }
}

// TUTORIAL DA DESCRICAO - a consulta continua liberada na etapa sem compra.
function melhoria_tela_ativa() {
    return room == rm_up_Gerais_1 || room == rm_up_Especificos_1
        || room == rm_up_Gerais_2 || room == rm_up_Especificos_2
        || room == rm_up_Gerais_3 || room == rm_up_Especificos_3;
}
function tutorial_melhoria_ativo() {
    if (!instance_exists(obj_Tutorial_interativo_melhoria)) return false;
    var _guia = instance_find(obj_Tutorial_interativo_melhoria, 0);
    return _guia.ativo && _guia.visible && instance_exists(_guia.alvo) && melhoria_tela_ativa();
}

function tutorial_melhoria_compra_permitida(_botao) {
    if (!tutorial_melhoria_ativo()) return true;
    var _guia = instance_find(obj_Tutorial_interativo_melhoria, 0);
    return _guia.etapa == 2 && _guia.espera <= 0 && _guia.alvo == _botao;
}

// Precos consultados pelo tutorial sem executar uma compra.
function melhoria_precos(_objeto) {
    switch (_objeto) {
        case obj_btn_md_Alfredos: return [25000, 5000, 17000, 26000, 37000, 50000, 65000, 82000, 101000, 122000, 145000, 170000, 197000, 227000, 255000];
        case obj_btn_md_Cafe: return [60000, 150000, 320000];
        case obj_btn_md_Celular: return [0, 8000, 22000, 45000, 75000, 120000, 180000, 250000, 340000, 450000, 580000, 730000, 900000, 1090000, 1300000];
        case obj_btn_md_Cenario_1: return [5000, 25000, 55000];
        case obj_btn_md_Cenario_2: return [30000, 75000, 160000];
        case obj_btn_md_Cube: return [0, 1000, 2500, 4500, 7000, 10000, 14000, 19000, 25000, 33000, 42000, 53000, 66000, 81000, 100000];
        case obj_btn_md_Energia: return [20000, 55000, 120000];
        case obj_btn_md_Funcionario_1: return [8000, 20000, 45000];
        case obj_btn_md_Funcionario_2: return [80000, 180000, 340000];
        case obj_btn_md_Funcionario_3: return [100000, 250000, 600000];
        case obj_btn_md_GPU: return [99000, 12000, 28000, 46000, 68000, 95000, 130000, 170000, 220000, 280000, 350000, 430000, 525000, 635000, 760000];
        case obj_btn_md_HD_SSD: return [0, 2500, 8000, 16000, 28000, 45000, 67000, 95000, 130000, 175000, 230000, 295000, 370000, 460000, 570000];
        case obj_btn_md_Internet: return [5000, 15000, 35000];
        case obj_btn_md_Notebook: return [0, 18000, 45000, 85000, 130000, 190000, 270000, 370000, 490000, 630000, 790000, 980000, 1190000, 1430000, 1700000];
        case obj_btn_md_Pocket: return [65000, 12000, 22000, 36000, 52000, 71000, 93000, 118000, 146000, 177000, 211000, 248000, 288000, 331000, 377000];
        case obj_btn_md_PSU: return [45000, 7000, 18000, 32000, 50000, 72000, 98000, 130000, 170000, 220000, 280000, 350000, 435000, 535000, 650000];
        case obj_btn_md_Tablet: return [0, 12000, 30000, 60000, 95000, 145000, 210000, 290000, 390000, 510000, 650000, 810000, 990000, 1190000, 1420000];
        case obj_btn_md_Transporte: return [90000, 220000, 500000];
    }
    return [];
}
