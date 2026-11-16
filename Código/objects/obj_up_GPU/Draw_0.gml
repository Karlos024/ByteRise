//CANCELA COM AS CONFIGURAÇÕES ABERTA
if (instance_exists(obj_ctld_Configuracoes) && obj_ctld_Configuracoes.exibir_config) {
    exit;
}

draw_self();
var Idioma = global.idm; 
var Nivel  = global.gpu;

//TÍTULO DO UPGRADE
var txt_Titulo = "GPU";
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
    "GPU 0",
	"GPU 1",
    "XP 230",
	["Moedas 3750", "Coins 3750", "Monedas 3750"][Idioma],
	"XP 275",
	["Moedas 4650", "Coins 4650", "Monedas 4650"][Idioma],
	"XP 325",
	["Moedas 5700", "Coins 5700", "Monedas 5700"][Idioma],
	"XP 360",
	["Moedas 6600", "Coins 6600", "Monedas 6600"][Idioma],
	"XP 385",
	["Moedas 7350", "Coins 7350", "Monedas 7350"][Idioma],
	"XP 410",
	["Moedas 9000", "Coins 9000", "Monedas 9000"][Idioma],
	"XP 455",
	["Moedas 10800", "Coins 10800", "Monedas 10800"][Idioma]
];

var txt_Proximo = [
	"GPU 1",
    "XP 230",
	["Moedas 3750", "Coins 3750", "Monedas 3750"][Idioma],
	"XP 275",
	["Moedas 4650", "Coins 4650", "Monedas 4650"][Idioma],
	"XP 325",
	["Moedas 5700", "Coins 5700", "Monedas 5700"][Idioma],
	"XP 360",
	["Moedas 6600", "Coins 6600", "Monedas 6600"][Idioma],
	"XP 385",
	["Moedas 7350", "Coins 7350", "Monedas 7350"][Idioma],
	"XP 410",
	["Moedas 9000", "Coins 9000", "Monedas 9000"][Idioma],
	"XP 455",
	["Moedas 10800", "Coins 10800", "Monedas 10800"][Idioma]
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