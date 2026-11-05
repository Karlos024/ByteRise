var gerais_max = (global.internet >= 3 && global.funcionario_1 >= 3 && global.cenario_1 >= 3 && global.energia >= 3 && global.funcionario_2 >= 3 && global.cenario_2 >= 3 && global.cafe >= 3 && global.funcionario_3 >= 3 && global.transporte >= 3);
var especificas_max = (global.fliperama_1 >= 15 && global.fliperama_2 >= 15 && global.fliperama_3 >= 15 && global.hd_ssd >= 15 && global.gpu >= 15 && global.psu >= 15 && global.celular >= 15 && global.tablet >= 15 && global.notebook >= 15);
var nivel_max = (global.nivel >= 30 && global.experiencia_atual >= global.experiencia[30]);

if (gerais_max && especificas_max && nivel_max) {
    image_index = 1;
} else {
    image_index = 0;
}