if (room_get_name(room) != "rm_Tela_principal_2") {
    var _fps = game_get_speed(gamespeed_fps);

	//SÓ FUNCIONA SE O JOGADOR TIVER NO MÍNIMO UMA MESA
    var Algum = false;
    if (variable_global_exists("hd_ssd") && global.hd_ssd > 0) { Algum = true; }
    if (variable_global_exists("psu") && global.psu > 0) { Algum = true; }
    if (variable_global_exists("gpu") && global.gpu > 0) { Algum = true; }
    if (!Algum) {
        timer_conserto_background = 0;
        exit;
    }

    var automacao_total = (variable_global_exists("funcionario_2") && global.funcionario_2 >= 3);
    if (automacao_total) {
        timer_conserto_background += (1 / _fps);
    }
    
    //REINICIA O TIMER SE O REPARO AUTOMÁTICO CHEGUE AO FIM
    if (automacao_total) {
        var tempo_total_processo = 5; 
        if (timer_conserto_background >= tempo_total_processo) {
            timer_conserto_background = 0; 
            
            //SORTEIA A MESA ESCOLHIDA
            var pedido = irandom(2);
            var moedas_base = 40;
            var xp_base = 90;
            
            //RECEBIMENTO
			if (pedido == 0 && variable_global_exists("hd_ssd")) {
                moedas_base = 1200; xp_base = 90;
                switch (global.hd_ssd) {
					case 1:  moedas_base = 1200; xp_base = 90; break;
                    case 2:  moedas_base = 1200; xp_base = 120; break; 
                    case 3:  moedas_base = 1650; xp_base = 120; break;
                    case 4:  moedas_base = 1650; xp_base = 155; break; 
                    case 5:  moedas_base = 2250; xp_base = 155; break;
                    case 6:  moedas_base = 2250; xp_base = 195; break; 
                    case 7:  moedas_base = 3000; xp_base = 195; break;
                    case 8:  moedas_base = 3000; xp_base = 240; break; 
                    case 9:  moedas_base = 3900; xp_base = 240; break;
                    case 10: moedas_base = 3900; xp_base = 260; break;
                    case 11: moedas_base = 4800; xp_base = 260; break;
                    case 12: moedas_base = 4800; xp_base = 280; break; 
                    case 13: moedas_base = 6000; xp_base = 280; break;
                    case 14: moedas_base = 6000; xp_base = 300; break; 
                    case 15: moedas_base = 6900; xp_base = 300; break;
                }
            }
            else if (pedido == 1 && variable_global_exists("psu")) {
                moedas_base = 2100; xp_base = 140;
                switch (global.psu) {
					case 1:  moedas_base = 2100; xp_base = 140; break;
                    case 2:  moedas_base = 2100; xp_base = 175; break; 
                    case 3:  moedas_base = 2700; xp_base = 175; break;
                    case 4:  moedas_base = 2700; xp_base = 215; break; 
                    case 5:  moedas_base = 3450; xp_base = 215; break;
                    case 6:  moedas_base = 3450; xp_base = 260; break; 
                    case 7:  moedas_base = 4350; xp_base = 260; break;
                    case 8:  moedas_base = 4350; xp_base = 285; break; 
                    case 9:  moedas_base = 5400; xp_base = 285; break;
                    case 10: moedas_base = 5400; xp_base = 315; break; 
                    case 11: moedas_base = 6750; xp_base = 315; break;
                    case 12: moedas_base = 6750; xp_base = 350; break; 
                    case 13: moedas_base = 7200; xp_base = 350; break;
                    case 14: moedas_base = 7200; xp_base = 380; break; 
                    case 15: moedas_base = 8700; xp_base = 380; break;
                }
            }
            else if (pedido == 2 && variable_global_exists("gpu")) {
                moedas_base = 3000; xp_base = 190;
                switch (global.gpu) {
					case 1:  moedas_base = 3000; xp_base = 190; break;
                    case 2:  moedas_base = 3000; xp_base = 230; break; 
                    case 3:  moedas_base = 3750; xp_base = 230; break;
                    case 4:  moedas_base = 3750; xp_base = 275; break; 
                    case 5:  moedas_base = 4650; xp_base = 275; break;
                    case 6:  moedas_base = 4650; xp_base = 325; break; 
                    case 7:  moedas_base = 5700; xp_base = 325; break;
                    case 8:  moedas_base = 5700; xp_base = 360; break; 
                    case 9:  moedas_base = 6600; xp_base = 360; break;
                    case 10: moedas_base = 6600; xp_base = 385; break; 
                    case 11: moedas_base = 7350; xp_base = 385; break;
                    case 12: moedas_base = 7350; xp_base = 410; break; 
                    case 13: moedas_base = 9000; xp_base = 410; break;
                    case 14: moedas_base = 9000; xp_base = 455; break; 
                    case 15: moedas_base = 10800; xp_base = 455; break;
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