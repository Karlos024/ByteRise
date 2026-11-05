if (!variable_global_exists("funcionario_2") || global.funcionario_2 < 1) { 
    visible = false; 
    exit; 
} else { 
    visible = true; 
} 

if (!variable_instance_exists(id, "x_anterior")) {
    x_anterior = x;
    y_anterior = y;
}

var _fps = game_get_speed(gamespeed_fps); 

if (!variable_global_exists("tempo")) { 
    global.tempo = 1.0; 
} 

var clique = 0; 
if (mouse_check_button_pressed(mb_left)) { 
    clique = global.tempo; 
} 

//VELOCIDADE ACELERADA 
var velocidade_atual = velocidade; 
if (global.funcionario_2 >= 2) { 
    velocidade_atual = velocidade * 2; 
} 

switch (estado_func) { 
    
    //PARADO ESPERANDO ORDENS 
    case 0: 
	
        //NÃO DEIXA MUDAR A POSIÇÃO
        if (cliente_alvo != noone && instance_exists(cliente_alvo) && timer_trabalho > 0) {
            if (instance_exists(mesa_alvo)) {
                x = (mesa_alvo.bbox_left + mesa_alvo.bbox_right) / 2; 
                y = (mesa_alvo.bbox_top + mesa_alvo.bbox_bottom) / 2; 
            }
            estado_func = 2; 
            fase_caminho = 0;
            break;
        }
		
        x = x_posto; 
        y = y_posto; 
        fase_caminho = 0; 
        
        //ANIMAÇÃO PARADO NO BALCÃO
        image_speed = 0; 
        image_index = 0; 
        
        //BUSCA POR UM CLIENTE NA FILA QUE ESTEJA AGUARDANDO O ATENDIMENTO 
        if (instance_exists(obj_Clientes_2)) { 
            var cliente_direita = noone; 
            for (var i = 0; i < instance_number(obj_Clientes_2); i++) { 
                var cliente = instance_find(obj_Clientes_2, i); 
                if (cliente != noone && cliente.estado_fila == 3 && cliente.timer_atendimento < cliente.tempo_atendimento) { 
                    cliente_direita = cliente; 
                    break; 
                } 
            } 
            
            //LOCALIZA A MESA DE DESTINO CORRESPONDENTE À ÁREA DO PEDIDO DESSE CLIENTE 
            if (cliente_direita != noone && instance_exists(cliente_direita)) { 
                var mesa_destino = noone; 
                if (cliente_direita.pedido_area == 0) { mesa_destino = instance_find(obj_Mesa_HD_SSD, 0); } 
                if (cliente_direita.pedido_area == 1) { mesa_destino = instance_find(obj_Mesa_PSU, 0); } 
                if (cliente_direita.pedido_area == 2) { mesa_destino = instance_find(obj_Mesa_GPU, 0); } 
                
                if (mesa_destino != noone && instance_exists(mesa_destino) && mesa_destino.visible) { 
                    mesa_alvo = mesa_destino; 
                    pedido_alvo = cliente_direita.pedido_area; 
                    cliente_alvo = cliente_direita; 
                    tempo_trabalho = cliente_direita.tempo_atendimento; 
                    timer_trabalho = cliente_direita.timer_atendimento; 
                    
                    //SE O JOGADOR MUDOU DE ROOM NO MEIO DO CONSERTO 
                    if (timer_trabalho > 0) { 
                        x = (mesa_alvo.bbox_left + mesa_alvo.bbox_right) / 2; 
                        y = (mesa_alvo.bbox_top + mesa_alvo.bbox_bottom) / 2; 
                        estado_func = 2; 
                    } else { 
                        estado_func = 1; 
                    } 
                    fase_caminho = 0; 
                } 
            } 
        } 
        break;
 

    //CAMINHANDO ATÉ A MESA 
    case 1: 
        if (!instance_exists(mesa_alvo)) { 
            estado_func = 3; 
            break; 
        } 
        
        var alvo_final_x = (mesa_alvo.bbox_left + mesa_alvo.bbox_right) / 2; 
        var alvo_final_y = (mesa_alvo.bbox_top + mesa_alvo.bbox_bottom) / 2; 
        var linha_horizontal_baixo_y = y_posto + 150; 
        var alvo_atual_x = x; 
        var alvo_atual_y = y; 
        
        if (fase_caminho == 0) { 
            alvo_atual_x = x_posto + 20; 
            alvo_atual_y = linha_horizontal_baixo_y; 
            if (point_distance(x, y, alvo_atual_x, alvo_atual_y) <= 4) { fase_caminho = 1; } 
        } else if (fase_caminho == 1) { 
            alvo_atual_x = alvo_final_x; 
            alvo_atual_y = linha_horizontal_baixo_y; 
            if (point_distance(x, y, alvo_atual_x, alvo_atual_y) <= 4) { fase_caminho = 2; } 
        } else if (fase_caminho == 2) { 
            alvo_atual_x = alvo_final_x; 
            alvo_atual_y = alvo_final_y; 
        } 
        
        var distancia = point_distance(x, y, alvo_atual_x, alvo_atual_y); 
        if (distancia > distancia_chegada) { 
            var dist = point_direction(x, y, alvo_atual_x, alvo_atual_y); 
            x += lengthdir_x(min(velocidade_atual, distancia), dist); 
            y += lengthdir_y(min(velocidade_atual, distancia), dist); 
        } else if (fase_caminho == 2) { 
            x = alvo_final_x; 
            y = alvo_final_y; 
            estado_func = 2; 
            fase_caminho = 0; 
        } 
        break; 

    //TRABALHANDO 
    case 2: 
        if (!instance_exists(mesa_alvo)) { 
            x = x_posto; 
            y = y_posto; 
            estado_func = 0; 
            fase_caminho = 0; 
            break; 
        } 
        
        //ANIMAÇÃO TRABALHANDO
        image_speed = 0;
        image_index += 0.35;
        if (image_index < 25 || image_index >= 32) {
            image_index = 25;
        }
        
        mesa_alvo.atendente_aqui = true; 
        timer_trabalho += (1 / _fps) + clique; 
        
        if (instance_exists(cliente_alvo)) { 
            cliente_alvo.timer_atendimento = timer_trabalho; 
        } 
        
        if (timer_trabalho >= tempo_trabalho) { 
            mesa_alvo.atendente_aqui = false; 
            estado_func = 3; 
            fase_caminho = 0; 
        } 
        break; 

    //VOLTANDO PELO PERCURSO REVERSO 
    case 3: 
        var linha_horizontal_volta_y = y_posto + 150; 
        var alvo_volta_x = x; 
        var alvo_volta_y = y; 
        
        var origem_x = x_posto; 
        if (instance_exists(mesa_alvo)) { 
            origem_x = (mesa_alvo.bbox_left + mesa_alvo.bbox_right) / 2; 
        } 
        
        if (fase_caminho == 0) { 
            alvo_volta_x = origem_x; 
            alvo_volta_y = linha_horizontal_volta_y; 
            if (point_distance(x, y, alvo_volta_x, alvo_volta_y) <= 4) { fase_caminho = 1; } 
        } else if (fase_caminho == 1) { 
            alvo_volta_x = x_posto + 20; 
            alvo_volta_y = linha_horizontal_volta_y; 
            if (point_distance(x, y, alvo_volta_x, alvo_volta_y) <= 4) { fase_caminho = 2; } 
        } else if (fase_caminho == 2) { 
            alvo_volta_x = x_posto + 20; 
            alvo_volta_y = y_posto; 
            if (point_distance(x, y, alvo_volta_x, alvo_volta_y) <= 4) { fase_caminho = 3; } 
        } else if (fase_caminho == 3) { 
            alvo_volta_x = x_posto; 
            alvo_volta_y = y_posto; 
        } 
        
        var distancia_volta = point_distance(x, y, alvo_volta_x, alvo_volta_y); 
        var margem_chegada = distancia_chegada; 
        if (fase_caminho == 3) { margem_chegada = 2; } 
        
        if (distancia_volta > margem_chegada) { 
            var volta = point_direction(x, y, alvo_volta_x, alvo_volta_y); 
            x += lengthdir_x(min(velocidade_atual, distancia_volta), volta); 
            y += lengthdir_y(min(velocidade_atual, distancia_volta), volta); 
        } else if (fase_caminho == 3) { 
            x = x_posto; 
            y = y_posto; 
            estado_func = 0; 
            timer_trabalho = 0; 
            
            //CONCLUI DIRETO NO SEU CLIENTE ALVO DA DIREITA
            if (instance_exists(cliente_alvo)) { 
                cliente_alvo.atendimento_concluido_posto = true; 
            } 
            cliente_alvo = noone; 
        } 
	break; 
}

//ANIMAÇÃO
var andando = (x != x_anterior || y != y_anterior);
if (andando) {
    var _dx = x - x_anterior;
    var _dy = y - y_anterior;
    var _frame_min = 10;
    var _frame_max = 17;
    
    if (abs(_dx) > abs(_dy)) {
        _frame_min = 18;
        _frame_max = 25;
        if (_dx > 0) {
            image_xscale = -abs(image_xscale);
        } else {
            image_xscale = abs(image_xscale);
        }
    } else {
        image_xscale = abs(image_xscale);
        if (_dy > 0) {
            _frame_min = 10;
            _frame_max = 17;
        } else {
            _frame_min = 26;
            _frame_max = 33;
        }
    }
    image_speed = 0;
    image_index += 0.35;
    if (image_index < _frame_min || image_index > _frame_max) {
        image_index = _frame_min;
    }
} 
else if (estado_func == 2) {
    image_speed = 0;
    image_index += 0.35;
    if (image_index < 34 || image_index > 41) {
        image_index = 34;
    }
} 
else {
    image_xscale = abs(image_xscale);
    image_speed = 0;
    image_index += 0.35;
    if (image_index < 0 || image_index > 9) {
        image_index = 0;
    }
}
x_anterior = x;
y_anterior = y;