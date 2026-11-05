//PADRÃO DOS CARACTERES
draw_set_halign(fa_center); 
draw_set_valign(fa_top);    
draw_set_color(c_white); 

//TITULO
draw_set_font(font_Titulo_grande);
var txt_Titulo = ["CRÉDITOS", "CREDITS", "CRÉDITOS"];
draw_text_ext(180, -5, txt_Titulo[global.idm], 22, 340);
draw_set_font(font_Sobre_titulo);
var txt_Sobre_titulo = ["EQUIPE DE DESENVOLVIMENTO", "DEVELOPMENT TEAM", "EQUIPO DE DESARROLLO"];
draw_text_ext(180, 60, txt_Sobre_titulo[global.idm], 22, 340);

//PROGRAMADORES
draw_set_halign(fa_left);
draw_set_font(font_Texto);
var txt_Texto = ["-PROGRAMADORES:", "-PROGRAMMERS:", "-PROGRAMADORES:"];
draw_text_ext(10, 105, txt_Texto[global.idm], 22, 340);
var txt_Nome = "Karlos  Eduardo                               Kauan  Saraiva";
draw_text(30, 135, txt_Nome);
draw_set_halign(fa_center);
var txt_Barra = "|\n|\n|\n";
draw_text(180, 135, txt_Barra);
draw_sprite_ext(spr_Creditos_Karlos, image_index, 115, 187, 0.9, 0.9, 0, c_white, 1);
draw_sprite_ext(spr_Creditos_Kauan, image_index, 300, 187, 0.9, 0.9, 0, c_white, 1);

//ARTISTAS DIGITAIS
draw_set_halign(fa_left);
txt_Texto = ["-ARTISTAS DIGITAIS:", "-DIGITAL ARTISTS:", "-ARTISTAS DIGITALES:"];
draw_text_ext(10, 215, txt_Texto[global.idm], 22, 340);
txt_Nome = "Lucas  Franco                                                  Vitor  Yuji";
draw_text(30, 245, txt_Nome);
draw_set_halign(fa_center);
txt_Barra = "|\n|\n|\n";
draw_text(180, 240, txt_Barra);
draw_sprite_ext(spr_Creditos_Lucas, image_index, 115, 295, 0.9, 0.9, 0, c_white, 1);
draw_sprite_ext(spr_Creditos_Vitor, image_index, 300, 295, 0.9, 0.9, 0, c_white, 1);

//COMPOSITOR MUSICAL
draw_set_halign(fa_left);
txt_Texto = ["-COMPOSITOR MUSICAL:", "-MUSIC COMPOSER:", "-COMPOSITOR DE MÚSICA:"];
draw_text_ext(10, 325, txt_Texto[global.idm], 22, 340);
txt_Nome = "Rafael  Cavalcanti";
draw_text(115, 355, txt_Nome);
draw_sprite_ext(spr_Creditos_Rafael, image_index, 215, 410, 0.9, 0.9, 0, c_white, 1);
	
//RECOMPENSA
draw_set_halign(fa_center);
draw_set_colour(c_yellow);
draw_set_font(font_Sobre_titulo);
txt_Texto = ["RECOMPENSA", "REWARD", "PREMIO"];
draw_text_ext(180, 440, txt_Texto[global.idm], 22, 340);
draw_set_font(font_Pequena);
var txt_Adicionais = ["Investigou   os   créditos   e   achou  que   ia   sair   de   mãos   vazias? \nAchou   errado.   Esse   bônus   foi   feito   só   para   mentes   afiadas   que   valorizam   os   Devs.", "Investigated   the   credits   and   thought   you   would   leave   empty-handed?   You   thought   wrong.   This   bonus   was   made   only   for   sharp   minds   who   value   the   Devs.", "¿Investigaste   los   créditos   y   pensaste   que   saldrías   con   las   manos   vacías?   Pensaste   mal.   Este   bono   fue   hecho   solo   para   mentes   afiladas   que   valoran   a   los   Devs."];
draw_text_ext(180, 475, txt_Adicionais[global.idm], 22, 340);