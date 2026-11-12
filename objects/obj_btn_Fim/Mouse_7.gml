if (!tutorial_permite(object_index)) exit;
var gerais_max = (global.internet >= 3 && global.funcionario_1 >= 3 && global.cenario_1 >= 3 && global.energia >= 3 && global.funcionario_2 >= 3 && global.cenario_2 >= 3 && global.cafe >= 3 && global.funcionario_3 >= 3 && global.transporte >= 3);
var especificas_max = (global.fliperama_1 >= 15 && global.fliperama_2 >= 15 && global.fliperama_3 >= 15 && global.hd_ssd >= 15 && global.gpu >= 15 && global.psu >= 15 && global.celular >= 15 && global.tablet >= 15 && global.notebook >= 15);
var nivel_max = (global.nivel >= 30);

var Som_ativo = true;
if (variable_global_exists("sc_ligado")) { 
    Som_ativo = global.sc_ligado; 
}

if (gerais_max && especificas_max && nivel_max) { 
    if (Som_ativo) { 
        audio_play_sound(snd_Botao, 1, false); 
    }
    if (!instance_exists(obj_ctld_Fim_confirmacao)) { 
        instance_create_depth(0, 0, -20, obj_ctld_Fim_confirmacao); 
    }
} else {
    if (Som_ativo) { 
        audio_play_sound(snd_Recusado, 1, false); 
    }
}