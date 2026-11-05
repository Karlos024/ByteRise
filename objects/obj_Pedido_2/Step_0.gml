//BOTÃO DE SAIR
if (mouse_check_button_released(mb_left)) {
    var spr_w = (sprite_get_width(spr_btn_Inicio_sobre_sair) / 2) * 0.5;
    var spr_h = (sprite_get_height(spr_btn_Inicio_sobre_sair) / 2) * 0.5;
    var btn_x = x;
    var btn_y = y + 70;

    if (mouse_x > btn_x - spr_w && mouse_x < btn_x + spr_w && mouse_y > btn_y - spr_h && mouse_y < btn_y + spr_h) {
        
        var consertador = instance_find(obj_psn_Consertador_2, 0);
        var funcionario = (variable_global_exists("funcionario_2") && global.funcionario_2 >= 1);

        //SE O CLIENTE EXISTIR E O CONSERTADOR ESTIVER DISPONÍVEL
        if (variable_instance_exists(id, "cliente_criador") && cliente_criador != noone && instance_exists(cliente_criador)) {
            cliente_criador.timer_atendimento = 0;
            
            if (funcionario && consertador != noone && instance_exists(consertador) && consertador.estado_func == 0) {
                var mesa_destino = noone;

                //IDENTIFICA A ÁREA DO PEDIDO DO CLIENTE
                if (cliente_criador.pedido_area == 0) mesa_destino = instance_find(obj_Mesa_HD_SSD, 0);
                if (cliente_criador.pedido_area == 1) mesa_destino = instance_find(obj_Mesa_PSU, 0);
                if (cliente_criador.pedido_area == 2) mesa_destino = instance_find(obj_Mesa_GPU, 0);

                if (mesa_destino != noone && mesa_destino.visible) {
                    consertador.mesa_alvo = mesa_destino;
                    consertador.pedido_alvo = cliente_criador.pedido_area;
                    consertador.cliente_alvo = cliente_criador;
                    consertador.tempo_trabalho = cliente_criador.tempo_atendimento;
                    consertador.timer_trabalho = 0;
                    consertador.fase_caminho = 0;
                    consertador.estado_func = 1;

                    //MANDA O PEDIDO PRA FILA DIREITA
                    var balcao = cliente_criador.balcao_id;
                    if (instance_exists(balcao)) {
                        var posicao = ds_list_find_index(balcao.fila, cliente_criador.id);
                        if (posicao != -1) {
                            ds_list_delete(balcao.fila, posicao);
                        }
                        balcao.ocupado = false;
                    }
                    cliente_criador.estado_fila = 3;
                }
            }
			
            //SEM UPGRADE
            else {
                var protagonista = instance_find(obj_psn_Principal_2, 0);
                if (protagonista != noone) {
                    protagonista.arrastando = false;
                    protagonista.voltando = false;
                }
            }
        }

        // EVITAR BUG DE DUPLICAÇÃO
        mouse_clear(mb_left);
        instance_destroy();
    }
}