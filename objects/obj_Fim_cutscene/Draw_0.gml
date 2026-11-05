draw_self();

//PADRÃO DOS CARACTERES
draw_set_font(font_Pequena);
draw_set_halign(fa_center);
draw_set_color(c_white);
draw_set_valign(fa_top);

//DECLARAÇÃO DE VÁRIAVEIS
var txt_Texto = [""];

switch (image_index) {
    case 0:
		draw_sprite_ext(spr_Inicio_cutscene_fundo, 0, 180, 590, 1.5, 1.2, 0, c_white, 0.9);
		draw_sprite_ext(spr_Inicio_cabeca, 0, 20, 565, 0.5, 0.5, 0, c_white, 0.9);
		txt_Texto = ["                              E  pensar  que  tudo  começou  com  uma  pequena  lan  house...  agora,  a  Byte  Rise  está  conquistando  o  mundo!", "                              And  to  think  it  all  started  with  a  small  lan  house...  now,  Byte  Rise  is  conquering  the  world!", "                              Y  pensar  que  todo  empezó  con  un  pequeño  ciber...  ¡ahora,  Byte  Rise  está  conquistando  el  mundo!"];
		draw_text_ext(180, 560, txt_Texto[global.idm], 22, 340);
		break;
        
    case 1:
        txt_Texto = [""];
        break;
        
    case 2:
		draw_sprite_ext(spr_Inicio_cutscene_fundo, 0, 180, 590, 1.5, 1.2, 0, c_white, 0.9);
		draw_sprite_ext(spr_Inicio_cabeca, 0, 20, 565, 0.5, 0.5, 0, c_white, 0.9);
        txt_Texto = ["                              Caramba...  olha  só  até  onde  oi  cheguei.", "                              Wow...  just  look  how  far  I've  come.", "                              Caramba...  mira  hasta  dónde  he  llegado."];
        draw_text_ext(180, 560, txt_Texto[global.idm], 22, 340);
		break;
        
    case 3:
		draw_sprite_ext(spr_Inicio_cutscene_fundo, 0, 180, 590, 1.5, 1.2, 0, c_white, 0.9);
		draw_sprite_ext(spr_Inicio_cabeca, 0, 20, 565, 0.5, 0.5, 0, c_white, 0.9);
		txt_Texto = ["                              Bom...  missão  cumprida!", "                              Well...  mission  accomplished!", "                              Bueno...  ¡misión  cumplida!"];
        draw_text_ext(180, 560, txt_Texto[global.idm], 22, 340);
		break;
        
    case 4:
		draw_sprite_ext(spr_Inicio_cutscene_fundo, 0, 180, 590, 1.5, 1.2, 0, c_white, 0.9);
		draw_sprite_ext(spr_Inicio_cabeca, 0, 20, 565, 0.5, 0.5, 0, c_white, 0.9);
        txt_Texto = ["                              Valeu  a  pena  cada  esforço  para  chegar  até  aqui.", "                              Every  effort  to  get  this  far  was  worth  it.", "                              Valió  la  pena  cada  esfuerzo  para  llegar  hasta  aquí."];
        draw_text_ext(180, 560, txt_Texto[global.idm], 22, 340);
		break;
        
    case 5:
		draw_sprite_ext(spr_Inicio_cutscene_fundo, 0, 180, 590, 1.5, 1.2, 0, c_white, 0.9);
		draw_sprite_ext(spr_Inicio_cabeca, 0, 20, 565, 0.5, 0.5, 0, c_white, 0.9);
        txt_Texto = ["                              Tudo  aquilo  que  parecia  impossível  um  dia...  hoje  é  realidade.", "                              Everything  that  seemed  impossible  one  day...  today  is  reality.", "                              Todo  lo  que  parecía  imposible  un  día...  hoy  es  realidad."];
        draw_text_ext(180, 560, txt_Texto[global.idm], 22, 340);
		break;
		
	case 6:
		draw_sprite_ext(spr_Inicio_cutscene_fundo, 0, 180, 590, 1.5, 1.2, 0, c_white, 0.9);
		draw_sprite_ext(spr_Inicio_cabeca, 0, 20, 565, 0.5, 0.5, 0, c_white, 0.9);
        txt_Texto = ["                              E  assim,  uma  ideia  simples  se  tornou  um  grande  sonho.", "                              And  so,  a  simple  idea  became  a  big  dream.", "                              Y  así,  una  idea  simple  se  convirtió  en  un  gran  sueño."];
        draw_text_ext(180, 560, txt_Texto[global.idm], 22, 340);
		break;
		
	case 7:
		draw_sprite_ext(spr_Inicio_cutscene_fundo, 0, 180, 590, 1.5, 1.2, 0, c_white, 0.9);
		draw_sprite_ext(spr_Inicio_cabeca, 0, 20, 565, 0.5, 0.5, 0, c_white, 0.9);
        txt_Texto = ["                              FIM", "                              THE  END", "                              FIN"];
        draw_text_ext(180, 560, txt_Texto[global.idm], 22, 340);
		break;
}