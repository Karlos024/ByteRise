//DECLARAÇÃO DOS ATRIBUTOS E ESTADOS DO FLIPERMA
fase = 1;
tipo_fl = 2;
ocupado = false;
comprado = false;
slot_numero = 0;
depth = -12; 
sprite_index = spr_Fliperama_Pocket; 
image_yscale = 0.18;

//VERIFICA QUANTOS FLIPERAMAS TEM E ADICIONA OS OUTROS
if (instance_number(obj_Fliperama_Pocket) == 1) {
    slot_numero = 0;
    image_xscale = 0.18;
    var Posicoes_x = [154.5, 199.5, 327];
    var Escalas_x = [-0.18, 0.18, -0.18];
    for (var i = 0; i < 3; i++) {
        var Slot = i + 1;
        
		//CRIA E APLICA O ID
        var Novo = instance_create_depth(Posicoes_x[i], 538, -10, obj_Fliperama_Pocket);
        Novo.slot_numero = Slot;
        Novo.image_xscale = Escalas_x[i];
    }
}