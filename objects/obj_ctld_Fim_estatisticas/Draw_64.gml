if (exibir_estatisticas == true) {
    
    //PROTEÇÃO
    if (!variable_global_exists("cronometro")) global.cronometro = 0;
    if (!variable_global_exists("tempo_fase_1")) global.tempo_fase_1 = 0;
    if (!variable_global_exists("tempo_fase_2")) global.tempo_fase_2 = 0;
    if (!variable_global_exists("tempo_fase_3")) global.tempo_fase_3 = 0;
	
    //FUNDO ESTATÍSTICAS
    draw_sprite_stretched(spr_Inicio_sobre_fundo, 0, -20.54, 0, 400, 650);

	// DECLARAÇÃO DAS VARIÁVEIS
	var txt_Titulo = [];
	var txt_Sobre_titulo = [];
	var Total = 0;
	var Horas = 0;
	var Minutos = 0;
	var Segundos = 0;
	var txt_Horas = "";
	var txt_Minutos = "";
	var txt_Segundos = "";
	var txt_Tempo = "";
	var txt_Texto = "";
	var txt_1 = [];
	var txt_2 = [];
	var txt_3 = [];
	var char_Cliques = string(global.total_cliques);
    var Conta_cliques = string_length(char_Cliques);
    var txt_Cliques_Final = "";
	var char_Acumuladas = string(floor(global.moedas_acumuladas));
	var Conta = string_length(char_Acumuladas);
	var txt_Final = "";
	var txt_Favorita = "";
	var txt_Favorita_detalhe = "";
	var txt_Detalhe_1 = [];
	var txt_Detalhe_2 = [];
	var txt_Detalhe_3 = [];


    //PADRÃO DOS CARACTERES
    draw_set_valign(fa_top);    
    draw_set_color(c_white);
    draw_set_halign(fa_center);
	
    //TÍTULO
    draw_set_font(font_Titulo_grande); 
    txt_Titulo = ["ESTATÍSTICAS", "STATISTICS", "ESTADÍSTICAS"];
    draw_text_ext(180, -5, txt_Titulo[global.idm], 22, 340);
	
	//TEMPO
    draw_set_font(font_Sobre_titulo); 
    txt_Sobre_titulo = ["TEMPO JOGADO", "TIME PLAYED", "TIEMPO JUGADO"];
    draw_text_ext(180,  40, txt_Sobre_titulo[global.idm], 22, 340);
	draw_sprite_ext(spr_Fim_cronometro, 0, 275, 50, 0.5, 0.5, 0, c_white, 1);
    draw_sprite_ext(spr_Fim_cronometro, 0, 85, 50, 0.5, 0.5, 0, c_white, 1);
	
	//CONVERSÃO MATEMÁTICA
    Total = floor(global.cronometro); 
    Horas = Total div 3600;
    Minutos = (Total div 60) mod 60;
    Segundos = Total mod 60;
    txt_Horas = [" Horas ", " Hours ", " Horas "][global.idm];
    txt_Minutos = [" Minutos ", " Minutes ", " Minutos "][global.idm];
    txt_Segundos = [" Segundos", " Seconds", " Segundos"][global.idm];
    txt_Tempo = string(Horas) + txt_Horas + string(Minutos) + txt_Minutos + string(Segundos) + txt_Segundos;
	draw_set_color(c_yellow);
	draw_set_font(font_Titulo_pequena); 
    draw_text_ext(180, 65, txt_Tempo, 18, 340);
	
	draw_set_color(c_white);
	
	if (Total < 1800) { 
		txt_1 = ["Prodígio  da  velocidade:  Mal  começou  a  jornada  e  já  passou  da  fase  na  velocidade  da  luz!", "Speed  prodigy:  You  barely  started  the  journey  and  already  passed  the  stage  at  the  speed  of  light!", "Prodigio  de  la  velocidad:  ¡Apenas  comenzaste  el  viaje  y  ya  pasaste  la  fase  a  la  velocidad  de  la  luz!"];
		txt_Texto = txt_1[global.idm]; 
	} else if (Total >= 1800 && Total <= 3600) { 
		txt_2 = ["Passo  a  passo:  Demorou  um  pouco,  mas  com  paciência  o  trabalho  foi  entregue  no  tempo  certo.", "Step  by  step:  It  took  a  while,  but  with  patience  the  work  was  delivered  on  the  right  time.", "Paso  a  paso:  Tomó  un  tiempo,  pero  con  paciencia  el  trabajo  fue  entregado  a  tiempo."];
		txt_Texto = txt_2[global.idm]; 
	} else { 
		txt_3 = ["Criando  raízes:  Você  dedicou  tanto  tempo  que  quase  virou  um  esqueleto  esperando  os  processos.", "Taking  root:  You  dedicated  so  much  time  that  you  almost  turned  into  a  skeleton  waiting.", "Echando  raíces:  ¡Dedicaste  tanto  tiempo  que  casi  te  conviertes  en  un  esqueleto  esperando!"];
		txt_Texto = txt_3[global.idm]; 
	}
    draw_set_font(font_Texto); 
    draw_text_ext(180, 90, txt_Texto, 18, 320);
	
	//QUANTIDADE DE CLIQUES
    draw_set_font(font_Sobre_titulo);
    txt_Sobre_titulo = ["TOTAL DE CLIQUES", "TOTAL CLICKS", "TOTAL DE CLICS"];
    draw_text_ext(180, 160, txt_Sobre_titulo[global.idm], 22, 340);
    draw_sprite_ext(spr_Fim_clique, 0, 280, 170, 0.5, 0.5, 0, c_white, 1);
    draw_sprite_ext(spr_Fim_clique, 0, 80, 170, -0.5, 0.5, 0, c_white, 1);
	
	//DEIXA DE TRÁS PRA FRENTE
    for (var i = Conta_cliques; i > 0; i--) {
        txt_Cliques_Final = string_char_at(char_Cliques, i) + txt_Cliques_Final;
        
		//A CADA 3 NÚMEROS COLOCA UM PONTO
        if ((Conta_cliques - i + 1) mod 3 == 0 && i != 1) {
            txt_Cliques_Final = "." + txt_Cliques_Final;
        }
    }
    draw_set_color(c_yellow);
    draw_set_font(font_Titulo_pequena);
    draw_text(180, 195, txt_Cliques_Final);
    draw_set_color(c_white);

    if (global.total_cliques > 7999) {
		txt_3 = ["Teste  de  impacto:  A  maratona  de  batidas  repetidas  serviu  como  um  verdadeiro  teste  de  resistência  para  o  vidro  temperado.", "Impact  test:  The  marathon  of  repeated  tapping  served  as  a  true  endurance  test  for  the  tempered  glass.", "Prueba  de  impacto:  La  maratón  de  toques  repetidos  sirvió  como  una  verdadera  prueba  de  resistencia  para  el  vidro  templado."];
        txt_Texto = txt_3[global.idm];
    } else if (global.total_cliques >= 4000 && global.total_cliques <= 7998) {
		txt_2 = ["Dedo  de  ferro:  O  ritmo  constante  e  os  toques  certeiros  ajudaram  a  acelerar  todos  os  processos  no  tempo  certo.", "Iron  finger:  The  steady  pace  and  well-timed  taps  helped  speed  up  all  processes  at  the  right  time.", "Dedo  de  hierro:  El  ritmo  constante  y  los  toques  precisos  ayudaron  a  acelerar  todos  los  procesos  a  tiempo."];
        txt_Texto = txt_2[global.idm];
    } else {
		txt_1 = ["Modo  soneca:  Os  funcionários  fizeram  todo  o  trabalho  pesado  enquanto  o  dedo  descansava  tranquilamente  longe  do  vidro.", "Sleep  mode:  The  employees  did  all  the  heavy  lifting  while  the  finger  rested  peacefully  away  from  the  glass.", "Modo  siesta:  Los  empleados  hicieron  todo  el  trabajo  pesado  mientras  el  dedo  descansaba  tranquilamente  lejos  del  vidrio."];
        txt_Texto = txt_1[global.idm];
    }
    
    draw_set_font(font_Texto);
    draw_text_ext(180, 220, txt_Texto, 18, 320);
	
	//QUANTIDADE DE MOEDAS GANHAS
	draw_set_font(font_Sobre_titulo); 
    txt_Sobre_titulo = ["MOEDAS GANHAS", "COINS EARNED", "MONEDAS GANADAS"];
    draw_text_ext(180, 310, txt_Sobre_titulo[global.idm], 22, 340);
	draw_sprite_ext(spr_Menu_moeda, 0, 280, 305, 2.5, 2.5, 0, c_white, 1);
    draw_sprite_ext(spr_Menu_moeda, 0, 80, 305, 2.5, 2.5, 0, c_white, 1);
	
	//DEIXA DE TRÁS PRA FRENTE
	for (var i = Conta; i > 0; i--) {
	    txt_Final = string_char_at(char_Acumuladas, i) + txt_Final;
		
		//A CADA 3 NÚMEROS COLOCA UM PONTO
	    if ((Conta - i + 1) mod 3 == 0 && i != 1) {
	        txt_Final = "." + txt_Final;
	    }
	}
	draw_set_color(c_yellow);
	draw_set_font(font_Titulo_pequena);
	draw_text(180, 345, txt_Final);
	
	if (global.moedas_acumuladas < 18000000) {
	txt_1 =  ["Saldo  fantasma:  O  balancete  fechou  com  uma  conta  tão  magra  que  as  moedas  viraram  lenda  urbana!", "Ghost  balance:  The  ledger  closed  with  a  bank  account  so  thin  that  the  coins  became  an  urban  legend!", "Saldo  fantasma:  ¡El  balance  cerró  con  una  cuenta  tan  flaca  que  las  monedas  se  volvieron  leyenda  urbana!"];
	txt_Texto = txt_1[global.idm];
	} else if (global.moedas_acumuladas >= 18000000 && global.moedas_acumuladas <= 25000000) {
	txt_2 =["Gordura  financeira:  O  saldo  bancário  já  consegue  bancar  uma  memória  RAM  com  LED.", "Financial  cushion:  The  bank  balance  can  already  afford  a  RAM  with  LED.", "Colchón  financiero:  El  saldo  bancario  ya  puede  pagar  una  memoria  RAM  con  LED."];
	txt_Texto = txt_2[global.idm];
	} else {
	txt_3 = ["Efeito  ostentação:  O  cofre  transbordou  tanta  grana  que  já  dá  para  encher  uma  piscina  olímpica  e  nadar  nas  moedas!", "Luxury  effect:  The  vault  overflowed  with  so  much  cash  that  it  is  time  to  fill  an  olympic  pool  and  swim  in  coins!", "Efecto  ostentación:  ¡El  cofre  desbordó  tanto  dinero  que  ya  da  para  llenar  una  piscina  olímpica  y  nadar  en  monedas!"];
	txt_Texto = txt_3[global.idm];
	}
	draw_set_color(c_white);
	draw_set_font(font_Texto);
	draw_text_ext(180, 370, txt_Texto, 18, 320);
	
	//FASE FAVORITA
	draw_set_font(font_Sobre_titulo); 
    txt_Sobre_titulo = ["FASE FAVORITA", "FAVORITE STAGE", "FASE FAVORITA"];
    draw_text_ext(180, 440, txt_Sobre_titulo[global.idm], 22, 340);
	draw_sprite_ext(spr_Fim_favorito, 0, 275, 450, 0.5, 0.5, 0, c_white, 1);
    draw_sprite_ext(spr_Fim_favorito, 0, 85, 450, 0.5, 0.5, 0, c_white, 1);

	//COMPARA QUAL DAS 3 FASES TEM MAIS SEGUNDOS
    if (global.tempo_fase_1 >= global.tempo_fase_2 && global.tempo_fase_1 >= global.tempo_fase_3) {
        txt_1 = ["Lan House", "Internet Cafe", "Cibercafé"];
        txt_Favorita = txt_1[global.idm];
		txt_Detalhe_1 = ["Você  tem  a  alma  de  um  verdadeiro  pioneiro,  focado  nas  raízes  do  negócio  e  na  nostalgia  dos  cliques!", "You  have  the  soul  of  a  true  pioneer,  focused  on  the  business  roots  and  the  nostalgia  of  clicking!", "¡Tienes  el  alma  de  un  verdadero  pionero,  enfocado  en  las  raíces  del  negocio  y  la  nostalgia  de  los  clics!"];
        txt_Favorita_detalhe = txt_Detalhe_1[global.idm];
    } 
    else if (global.tempo_fase_2 >= global.tempo_fase_1 && global.tempo_fase_2 >= global.tempo_fase_3) {
        txt_2 = ["Assistência Técnica", "Technical Support", "Asistencia Técnica"];
        txt_Favorita = txt_2[global.idm];
		txt_Detalhe_2 = ["Você  tem  uma  mente  analítica  e  precisa,  adorando  decifrar  cada  desafio  e  colocar  a  mão  na  massa!", "You  have  an  analytical  and  precise  mind,  loving  to  solve  every  challenge  and  get  hands-on!", "¡Tienes  una  mente  analítica  y  precisa,  amando  descifrar  cada  desafío  y  poner  manos  a  la  obra!"];
        txt_Favorita_detalhe = txt_Detalhe_2[global.idm];
    } 
    else {
        txt_3 = ["Empresa de Tecnologia", "Technology Company", "Empresa de Tecnología"];
        txt_Favorita = txt_3[global.idm];
		txt_Detalhe_3 = ["Você  tem  uma  mente  empreendedora  e  de  liderança,  nascido  para  automatizar  processos  e  comandar  um  império!", "You  have  an  entrepreneurial  and  leadership  mind,  born  to  automate  processes  and  command  an  empire!", "¡Tienes  una  mente  emprendedora  y  de  lizerazgo,  nacido  para  automatizar  procesos  y  comandar  un  imperio!"];
        txt_Favorita_detalhe = txt_Detalhe_3[global.idm];
    }
    draw_set_font(font_Titulo_pequena);
    draw_set_color(c_yellow); 
    draw_text_ext(180, 475, txt_Favorita, 18, 340);
    draw_set_font(font_Texto);
    draw_set_color(c_white);
    draw_text_ext(180, 500, txt_Favorita_detalhe, 18, 320);
}