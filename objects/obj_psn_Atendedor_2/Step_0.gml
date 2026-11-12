if (tutorial_f2_ativo()) { visible = false; exit; }
if (variable_global_exists("funcionario_2") && global.funcionario_2 >= 3) {
    visible = true;
} else {
    visible = false;
    exit; 
}

//DECLARAÇÃO
var balcao = instance_find(obj_Balcao_2, 0);

//BUSCA O PRIMEIRO CLIENTE
if (balcao != noone && instance_exists(balcao) && ds_list_size(balcao.fila) > 0) {
    var cliente = ds_list_find_value(balcao.fila, 0)
    var cliente_espera = false;
    if (instance_exists(obj_Clientes_2)) {
        with (obj_Clientes_2) {
            if (estado_fila == 3) {
                cliente_espera = true;
            }
        }
    }
    
	//MOVE O CLIENTE PRA FILA DA DIREITA SE ESTIVER LIVRE E FAZ O PROCESSO
    if (instance_exists(cliente) && cliente.estado_fila == 1 && !cliente_espera) {
        var mesa_destino = noone;
        if (cliente.pedido_area == 0) mesa_destino = instance_find(obj_Mesa_HD_SSD, 0);
        if (cliente.pedido_area == 1) mesa_destino = instance_find(obj_Mesa_PSU, 0);
        if (cliente.pedido_area == 2) mesa_destino = instance_find(obj_Mesa_GPU, 0);
        if (mesa_destino != noone && instance_exists(mesa_destino) && mesa_destino.visible) {
            var posicao = ds_list_find_index(balcao.fila, cliente.id);
            if (posicao != -1) { ds_list_delete(balcao.fila, posicao); }
            balcao.ocupado = false;
            cliente.timer_atendimento = 0;
            cliente.atendimento_concluido_posto = false;
            cliente.estado_fila = 3; 
        }
    }
}