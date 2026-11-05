if (room == rm_Tela_principal_1) {
    draw_self();
    if (inicializado) {
        var raio_balcao = 9;
        var raio_fliperama = 8;
        var desenhar_progresso = function(coordenada_x, coordenada_y, raio, porcentagem) {
            
			//BORDA
			draw_set_color(c_black);
            draw_circle(coordenada_x, coordenada_y, raio + 4, false);
			
			//FUNDO
            draw_set_color(make_color_rgb(60, 60, 60));
            draw_circle(coordenada_x, coordenada_y, raio, false);
			
			//CIRCULO RADIAL
            if (porcentagem < 98) {
                draw_set_color(c_red);
            } else {
                draw_set_color(c_lime);
                porcentagem = 100;
            }
			
			//PROGRESSO
            draw_primitive_begin(pr_trianglefan);
            draw_vertex(coordenada_x, coordenada_y);
            for (var i = 0; i <= (porcentagem / 100) * 360; i += 2) {
                draw_vertex(coordenada_x + lengthdir_x(raio, i - 90), coordenada_y + lengthdir_y(raio, i - 90));
            }
            draw_primitive_end();
        };

		//LADO DO PROGRESSO NO BALCÃO
		if (estado_fila == 1 || estado_fila == 2) {
			var sentido_balcao = 1;
				if (balcao_num == 1) {
					sentido_balcao = -1.2;
				} else {
					sentido_balcao = 1;
				}
				var balcao_x = x + (sentido_balcao * 30);
				var balcao_y = y + 7;
				var porcentagem_balcao = 100;
            if (estado_fila == 1) {
                var nivel_funcionario = 0;
                if (variable_global_exists("funcionario_1")) {
                    nivel_funcionario = clamp(global.funcionario_1, 0, 3);
                }
                porcentagem_balcao = clamp(floor((timer_atendimento / tempos_atendimento[nivel_funcionario]) * 100), 0, 100);
            }
            if (porcentagem_balcao > 0) {
                desenhar_progresso(balcao_x, balcao_y, raio_balcao, porcentagem_balcao);
            }
        }

		//LADO DO PROGRESSO NO FLIPERAMA
        if (estado_fila == 4) {
            var sentido_fliperama = 1;
				if (instance_exists(fliperama_alvo)) {
					if (fliperama_alvo.image_xscale > 0) {
						sentido_fliperama = 1;
					} else {
						sentido_fliperama = -1;
					}
					var fliperama_x = x + (sentido_fliperama * 24);
					var fliperama_y = y + 14;
					var porcentagem_fliperama = clamp(floor(progresso_dentro * 100), 0, 100);
					if (porcentagem_fliperama > 0) {
						desenhar_progresso(fliperama_x, fliperama_y, raio_fliperama, porcentagem_fliperama);
				}
			}
        }
    }
}