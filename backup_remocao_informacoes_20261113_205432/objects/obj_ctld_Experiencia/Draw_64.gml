//CANCELA COM OS TUTORIAIS, CRÉDITOS INICIAR E FINAL ABERTO
if (room == rm_Tutorial_1 || room == rm_Tutorial_2 || room == rm_Tutorial_3 || room == rm_Creditos || room == rm_Cutscene_inicial || room == rm_Cutscene_final || room == rm_Tela_inicial || room == rm_Tela_final) {
    exit;
}

//CANCELA COM AS CONFIGURAÇÕES ABERTA
if (instance_exists(obj_ctld_Configuracoes) && obj_ctld_Configuracoes.exibir_config) {
    exit;
}

//PADRÃO DOS CARACTERES
draw_set_valign(fa_top);
draw_set_halign(fa_left);
draw_set_color(c_white);
draw_set_font(font_Titulo_pequena);

//DECLARAÇÃO DAS VARIÁVEIS
var txt_Nivel = [];
var txt_Texto = [];
var txt_Nivel_final = [];
var txt_Complemento = [];
var char_Atual = "";
var char_Maxima = "";
var Maximo = 0;
var Acumulado = 0;

//NÍVEL
if (global.nivel < 30) {
	
    //NÍVEL NORMAL
    txt_Nivel = ["NÍVEL ", "LEVEL ", "NIVEL "][global.idm];
    txt_Nivel_final = txt_Nivel + string(global.nivel);
    draw_text_transformed(265, 27, txt_Nivel_final, 0.7, 0.7, 0);
} 
else {
	
    //NÍVEL MÁXIMO
    txt_Nivel = ["NÍVEL ", "LEVEL ", "NIVEL "][global.idm];
    txt_Complemento = [" 30 (MÁXIMO)", " 30 (MAXIMUM)", " 30 (MÁXIMO)"][global.idm];
    txt_Nivel_final = txt_Nivel + txt_Complemento;
    draw_text_transformed(235, 27, txt_Nivel_final, 0.7, 0.7, 0);
}

//BARRA DE EXPERIÊNCIA
//FUNDO PRETO DA BARRA
draw_set_color(c_black);
draw_rectangle(235, 45, 345, 55, false);

//ATUALIZA O MÁXIMO DE EXPERIÊNCIA
global.experiencia_maximo = global.experiencia[global.nivel];

//PORCENTAGEM DE BARRA COMPLETA
if (global.experiencia_atual > 0) {
    draw_set_color(c_aqua);
    draw_rectangle(235, 45, 235 + (110 * clamp(global.experiencia_atual / global.experiencia_maximo, 0, 1)), 55, false);
}

//BORDA BRANCA DA BARRA
draw_set_color(c_white);
draw_rectangle(235, 45, 345, 55, true);

//PADRÃO DOS CARACTERES
draw_set_font(font_Destacada);
draw_set_color(c_white);
draw_set_valign(fa_middle); 
draw_set_halign(fa_center);

//CONVERTE OS VALORES NUMÉRICOS EM TEXTO
char_Atual = string(floor(global.experiencia_atual));
char_Maxima = string(global.experiencia_maximo);

//SE A EXPERIÊNCIA MÁXIMA PASSAR DE MIL, COLOCA UM PONTO
if (global.experiencia_maximo >= 1000) {
    Maximo = string_length(char_Maxima);
    char_Maxima = string_copy(char_Maxima, 1, Maximo - 3) + "." + string_copy(char_Maxima, Maximo - 2, 3);
    
	//SE A EXPERIÊNCIA ACUMULADA PASSAR DE MIL, COLOCA UM PONTO
    if (global.experiencia_atual >= 1000) {
        Acumulado = string_length(char_Atual);
        char_Atual = string_copy(char_Atual, 1, Acumulado - 3) + "." + string_copy(char_Atual, Acumulado - 2, 3);
    }
}

draw_text_transformed(295, 50, char_Atual + "/" + char_Maxima, 0.8, 0.6, 0);