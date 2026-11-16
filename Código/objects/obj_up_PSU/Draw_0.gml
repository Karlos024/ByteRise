//CANCELA COM AS CONFIGURAÇÕES ABERTA
if (instance_exists(obj_ctld_Configuracoes) && obj_ctld_Configuracoes.exibir_config) {
    exit;
}

draw_self();
var Idioma = global.idm; 
var Nivel  = global.psu;

//TÍTULO DO UPGRADE
var txt_Titulo = "PSU";
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
    "PSR 0",
	"PSU 1",
    "XP 175",
	["Moedas 2700", "Coins 2700", "Monedas 2700"][Idioma],
	"XP 215",
	["Moedas 3450", "Coins 3450", "Monedas 3450"][Idioma],
	"XP 260",
	["Moedas 4350", "Coins 4350", "Monedas 4350"][Idioma],
	"XP 285",
	["Moedas 5400", "Coins 5400", "Monedas 5400"][Idioma],
	"XP 315",
	["Moedas 6750", "Coins 6750", "Monedas 6750"][Idioma],
	"XP 350",
	["Moedas 7200", "Coins 7200", "Monedas 7200"][Idioma],
	"XP 380",
	["Moedas 8700", "Coins 8700", "Monedas 8700"][Idioma]
];

var txt_Proximo = [
	"PSU 1",
    "XP 175",
	["Moedas 2700", "Coins 2700", "Monedas 2700"][Idioma],
	"XP 215",
	["Moedas 3450", "Coins 3450", "Monedas 3450"][Idioma],
	"XP 260",
	["Moedas 4350", "Coins 4350", "Monedas 4350"][Idioma],
	"XP 285",
	["Moedas 5400", "Coins 5400", "Monedas 5400"][Idioma],
	"XP 315",
	["Moedas 6750", "Coins 6750", "Monedas 6750"][Idioma],
	"XP 350",
	["Moedas 7200", "Coins 7200", "Monedas 7200"][Idioma],
	"XP 380",
	["Moedas 8700", "Coins 8700", "Monedas 8700"][Idioma]
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