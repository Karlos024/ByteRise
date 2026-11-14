//CANCELA COM AS CONFIGURAÇÕES ABERTA
if (instance_exists(obj_ctld_Configuracoes) && obj_ctld_Configuracoes.exibir_config) {
    exit;
}

draw_self();
var Idioma = global.idm; 
var Nivel  = global.celular;

//TÍTULO DO UPGRADE
var txt_Titulo = ["CELULAR", "CELL PHONE", "MÓVIL"][Idioma];
draw_set_font(font_Titulo_pequena);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_text(x + 44, y - 35, txt_Titulo); 

//BARRA E O NÍVEL
draw_set_font(font_Principal);
draw_set_halign(fa_center);
draw_sprite_ext(spr_Especificos_barra, Nivel, x + 105, y + 20, 2, 0.8, 0, c_white, 1);

//TEXTO DO NÍVEL
var idm_Nivel = ["Nível: ", "Level: ", "Nivel: "];
var txt_Nivel = idm_Nivel[Idioma] + string(Nivel) + "/15";
draw_set_font(font_Pequena);
draw_set_color(c_white);
draw_text(x + 70, y, txt_Nivel);

//TEXTO DA MELHORIA
var txt_Maximo = ["Máximo", "Max", "Máximo"];
var txt_Atual = [
    ["Bancada 0", "Bench 0", "Banco 0"][Idioma],
    ["Bancada 1", "Bench 1", "Banco 1"][Idioma],
    "XP 420",
    ["Moedas 4400", "Coins 4400", "Monedas 4400"][Idioma],
    "XP 500",
    ["Bancada 2", "Bench 2", "Banco 2"][Idioma],
    ["Moedas 5400", "Coins 5400", "Monedas 5400"][Idioma],
    "XP 590",
    ["Moedas 6600", "Coins 6600", "Monedas 6600"][Idioma],
    "XP 690",
    ["Bancada 3", "Bench 3", "Banco 3"][Idioma],
    ["Moedas 8000", "Coins 8000", "Monedas 8000"][Idioma],
    "XP 745",
    ["Moedas 9600", "Coins 9600", "Monedas 9600"][Idioma],
    "XP 800",
    ["Moedas 12000", "Coins 12000", "Monedas 12000"][Idioma]
];

var txt_Proximo = [
    ["Bancada 1", "Bench 1", "Banco 1"][Idioma],
    "XP 420",
    ["Moedas 4400", "Coins 4400", "Monedas 4400"][Idioma],
    "XP 500",
    ["Bancada 2", "Bench 2", "Banco 2"][Idioma],
    ["Moedas 5400", "Coins 5400", "Monedas 5400"][Idioma],
    "XP 590",
    ["Moedas 6600", "Coins 6600", "Monedas 6600"][Idioma],
    "XP 690",
    ["Bancada 3", "Bench 3", "Banco 3"][Idioma],
    ["Moedas 8000", "Coins 8000", "Monedas 8000"][Idioma],
    "XP 745",
    ["Moedas 9600", "Coins 9600", "Monedas 9600"][Idioma],
    "XP 800",
    ["Moedas 12000", "Coins 12000", "Monedas 12000"][Idioma]
];

draw_set_font(font_Principal);

if (Nivel >= 15) {
	
    //MÁXIMO
    draw_set_color(c_lime);
    draw_text(x, y + 40, txt_Maximo[Idioma]); 
} else {
	
    //COR DA MELHORIA ATUAL
    var cor_Atual = c_lime;
    if (Nivel == 0) {
        cor_Atual = c_red;
    }
    
    //MELHORIA ATUAL E A PRÓXIMA
    draw_set_color(cor_Atual);
    draw_text(x, y + 40, txt_Atual[Nivel]);
    draw_sprite(spr_Tela_aprimoramentos_seta, 0, x + 115, y + 50);
    draw_set_color(c_gray);   
    draw_text(x + 225, y + 40, txt_Proximo[Nivel]);
}