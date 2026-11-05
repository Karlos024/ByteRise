//CANCELA COM AS CONFIGURAÇÕES ABERTA
if (instance_exists(obj_ctld_Configuracoes) && obj_ctld_Configuracoes.exibir_config) {
    exit;
}

draw_self();
var Idioma = global.idm; 
var Nivel  = global.fliperama_2;

//TÍTULO DO UPGRADE
var txt_Titulo = "FOUR DAYS AT\nALFREDO'S";
draw_set_font(font_Titulo_pequena);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_text(x + 44, y - 45, txt_Titulo); 

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
    ["Fliperama 0", "Arcade 0", "Arcade 0"][Idioma],
	["Fliperama 1", "Arcade 1", "Arcade 1"][Idioma], 
    "XP 150",
	["Fliperama 2", "Arcade 2", "Arcade 2"][Idioma],
	["Moedas 2100", "Coins 2100", "Monedas 2100"][Idioma],
	"XP 185",
	["Fliperama 3", "Arcade 3", "Arcade 3"][Idioma],
	["Moedas 2700", "Coins 2700", "Monedas 2700"][Idioma],
	"XP 225",
	["Fliperama 4", "Arcade 4", "Arcade 4"][Idioma],
	["Moedas 3400", "Coins 3400", "Monedas 3400"][Idioma],
	"XP 270",
	["Moedas 4200", "Coins 4200", "Monedas 4200"][Idioma],
	"XP 300",
	["Moedas 5400", "Coins 5400", "Monedas 5400"][Idioma],
	"XP 320"
];

var txt_Proximo = [
	["Fliperama 1", "Arcade 1", "Arcade 1"][Idioma], 
    "XP 150",
	["Fliperama 2", "Arcade 2", "Arcade 2"][Idioma],
	["Moedas 2100", "Coins 2100", "Monedas 2100"][Idioma],
	"XP 185",
	["Fliperama 3", "Arcade 3", "Arcade 3"][Idioma],
	["Moedas 2700", "Coins 2700", "Monedas 2700"][Idioma],
	"XP 225",
	["Fliperama 4", "Arcade 4", "Arcade 4"][Idioma],
	["Moedas 3400", "Coins 3400", "Monedas 3400"][Idioma],
	"XP 270",
	["Moedas 4200", "Coins 4200", "Monedas 4200"][Idioma],
	"XP 300",
	["Moedas 5400", "Coins 5400", "Monedas 5400"][Idioma],
	"XP 320"
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