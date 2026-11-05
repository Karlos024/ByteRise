// CONFIGURAÇÃO COORDENADAS, ESTADOS E VARIÁVEIS DE CONTROLE DO FUNCIONÁRIO
if (!variable_instance_exists(id, "estado_func")) { estado_func = 0; }
if (!variable_instance_exists(id, "salvei_retorno")) { salvei_retorno = false; }
if (!variable_instance_exists(id, "timer_trabalho")) { timer_trabalho = 0; }
if (!variable_instance_exists(id, "pedido_alvo")) { pedido_alvo = -1; }
if (!variable_instance_exists(id, "fase_caminho")) { fase_caminho = 0; }
if (!variable_instance_exists(id, "cliente_alvo")) { cliente_alvo = noone; }
if (!variable_instance_exists(id, "mesa_alvo")) { mesa_alvo = noone; }
velocidade = 3;
distancia_chegada = 4;
x_posto = 224;  
y_posto = 384; 
tempo_trabalho = 5;
if (estado_func == 0) {
    x = x_posto;
    y = y_posto;
}