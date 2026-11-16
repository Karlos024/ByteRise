if (room_get_name(room) != "rm_Tela_principal_1") {
    var _fps = game_get_speed(gamespeed_fps);
    
    //SÓ FUNCIONA SE O JOGADOR TIVER NO MÍNIMO UM FLIPERAMA
    var Algum = false;
    if (variable_global_exists("fliperama_1") && global.fliperama_1 > 0) { Algum = true; }
    if (variable_global_exists("fliperama_2") && global.fliperama_2 > 0) { Algum = true; }
    if (variable_global_exists("fliperama_3") && global.fliperama_3 > 0) { Algum = true; }
    if (!Algum) {
        timer_fliperama_background = 0;
        exit;
    }

    var automacao_total = true;
    if (automacao_total) {
        if (!variable_instance_exists(id, "timer_fliperama_background")) {
            timer_fliperama_background = 0;
        }
        
        //RECUPERA O NÍVEL DO FUNCIONÁRIO
        var Nivel_funcionario = 0;
        if (variable_global_exists("funcionario_1")) {
            Nivel_funcionario = global.funcionario_1;
        }
        
		//SÓ FUNCIONA SE O JOGADOR TIVER COMPRADO UM FUNCIONÁRIO
		if (Nivel_funcionario <= 0) {
            timer_fliperama_background = 0;
            exit;
        }
		
        //CONFIGURA O TEMPO TOTAL DO PROCESSO EM SEGUNDOS POR NÍVEL
        var Processo = 8.0;
        switch (Nivel_funcionario) {
            case 0:  Processo = 6.0; break;
            case 1:  Processo = 5.0; break;
            case 2:  Processo = 4.0; break;
            default: Processo = 3.0; break;
        }
        timer_fliperama_background += (1 / _fps) / Processo;
        if (timer_fliperama_background >= 1) {
            timer_fliperama_background = 0; 
            
            //SORTEIA O FLIPERAMA ESCOLHIDO
            var Tipo = -1;
            var Procurando = true;
            while (Procurando) {
                var _sorteio_teste = irandom(2);
                if (_sorteio_teste == 0 && variable_global_exists("fliperama_1") && global.fliperama_1 > 0) {
                    Tipo = 0;
                    Procurando = false;
                }
                else if (_sorteio_teste == 1 && variable_global_exists("fliperama_2") && global.fliperama_2 > 0) {
                    Tipo = 1;
                    Procurando = false;
                }
                else if (_sorteio_teste == 2 && variable_global_exists("fliperama_3") && global.fliperama_3 > 0) {
                    Tipo = 2;
                    Procurando = false;
                }
            }
            var moedas_base = 30;
            var xp_base = 50;
            
			//RECEBIMENTO
			if (Tipo == 0) {
                switch (global.fliperama_1) {
                    case 1:  moedas_base = 600;  xp_base = 50;  break; 
                    case 2:  moedas_base = 600;  xp_base = 70;  break; 
                    case 3:  moedas_base = 600;  xp_base = 70;  break; 
                    case 4:  moedas_base = 900;  xp_base = 70;  break; 
                    case 5:  moedas_base = 900;  xp_base = 95;  break; 
                    case 6:  moedas_base = 900;  xp_base = 95;  break; 
                    case 7:  moedas_base = 1300; xp_base = 95;  break; 
                    case 8:  moedas_base = 1300; xp_base = 125; break; 
                    case 9:  moedas_base = 1300; xp_base = 125; break; 
                    case 10: moedas_base = 1800; xp_base = 125; break; 
                    case 11: moedas_base = 1800; xp_base = 165; break; 
                    case 12: moedas_base = 2400; xp_base = 165; break; 
                    case 13: moedas_base = 2400; xp_base = 190; break; 
                    case 14: moedas_base = 3400; xp_base = 190; break; 
                    case 15: moedas_base = 3400; xp_base = 210; break; 
                }
            }
            else if (Tipo == 1) {
                switch (global.fliperama_2) {
                    case 1:  moedas_base = 1600; xp_base = 120; break; 
                    case 2:  moedas_base = 1600; xp_base = 150; break; 
                    case 3:  moedas_base = 1600; xp_base = 150; break; 
                    case 4:  moedas_base = 2100; xp_base = 150; break; 
                    case 5:  moedas_base = 2100; xp_base = 185; break; 
                    case 6:  moedas_base = 2100; xp_base = 185; break; 
                    case 7:  moedas_base = 2700; xp_base = 185; break; 
                    case 8:  moedas_base = 2700; xp_base = 225; break; 
                    case 9:  moedas_base = 2700; xp_base = 225; break; 
                    case 10: moedas_base = 3400; xp_base = 225; break; 
                    case 11: moedas_base = 3400; xp_base = 270; break; 
                    case 12: moedas_base = 4200; xp_base = 270; break; 
                    case 13: moedas_base = 4200; xp_base = 300; break; 
                    case 14: moedas_base = 5400; xp_base = 300; break; 
                    case 15: moedas_base = 5400; xp_base = 320; break; 
                }
            }
            else if (Tipo == 2) {
                switch (global.fliperama_3) {
                    case 1:  moedas_base = 3000; xp_base = 220; break; 
                    case 2:  moedas_base = 3000; xp_base = 260; break; 
                    case 3:  moedas_base = 3000; xp_base = 260; break; 
                    case 4:  moedas_base = 3800; xp_base = 260; break; 
                    case 5:  moedas_base = 3800; xp_base = 310; break; 
                    case 6:  moedas_base = 3800; xp_base = 310; break; 
                    case 7:  moedas_base = 4800; xp_base = 310; break; 
                    case 8:  moedas_base = 4800; xp_base = 370; break; 
                    case 9:  moedas_base = 4800; xp_base = 370; break; 
                    case 10: moedas_base = 6000; xp_base = 370; break; 
                    case 11: moedas_base = 6000; xp_base = 440; break; 
                    case 12: moedas_base = 7600; xp_base = 440; break; 
                    case 13: moedas_base = 7600; xp_base = 495; break; 
                    case 14: moedas_base = 9000; xp_base = 495; break; 
                    case 15: moedas_base = 9000; xp_base = 520; break; 
                }
            }

			//SISTEMA DE ESTÁTISTICAS E MENU
            if (!variable_global_exists("moedas")) global.moedas = 0;
            if (!variable_global_exists("moedas_acumuladas")) global.moedas_acumuladas = 0;
            if (!variable_global_exists("experiencia_atual")) global.experiencia_atual = 0;
            global.moedas += moedas_base;
            global.moedas_acumuladas += moedas_base;
            global.experiencia_atual += xp_base;
        }
    }
} else {
    timer_conserto_background = 0;
} 