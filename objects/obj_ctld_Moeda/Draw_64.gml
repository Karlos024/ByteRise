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
var char_Moedas = string(floor(global.moedas));
var Conta = string_length(char_Moedas);
var txt_Final = "";

//DEIXA DE TRÁS PRA FRENTE
for (var i = Conta; i > 0; i--) {
    txt_Final = string_char_at(char_Moedas, i) + txt_Final;
	
    //A CADA 3 NÚMEROS COLOCA UM PONTO
    if ((Conta - i + 1) mod 3 == 0 && i != 1) {
        txt_Final = "." + txt_Final;
    }
}

draw_text_transformed(233, 7, txt_Final, 1.2, 0.7, 0);