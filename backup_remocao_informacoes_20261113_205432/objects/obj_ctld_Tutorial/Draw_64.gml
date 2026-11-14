//DECLARAÇÃO DAS VARIÁVEIS USADAS
var txt_Titulo = "";
var txt_Sobre_titulo = [];
var txt_Texto = [];
var txt_Adicionais = [];

//PADRÃO DOS CARACTERES
draw_set_halign(fa_center); 
draw_set_valign(fa_top);    
draw_set_color(c_white);

//FASE 1
if (fase == 1) {
	
    //PÁGINA 0
    if (atual == 0) {
        draw_set_font(font_Titulo_grande);
        txt_Titulo = "TUTORIAL";
        draw_text(180, -5, txt_Titulo);
        draw_set_font(font_Sobre_titulo);
        txt_Sobre_titulo = ["FASE 1: A LAN HOUSE DO BAIRRO", "PHASE 1: THE NEIGHBORHOOD INTERNET CAFÉ", "FASE 1: EL CIBERCAFÉ DEL BARRIO"];
        draw_text_ext(180, 60, txt_Sobre_titulo[global.idm], 22, 340);
        draw_sprite_ext(spr_Tutorial_logo_ByteRise, 0, 180, 260, 0.3, 0.3, 0, c_white, 1);
        draw_set_font(font_Texto);
        txt_Texto = ["Tudo  começa  aqui!  Uma  garagem  vazia,  um  fliperama  velho  e  um  grande  sonho.",  "Everything  begins  here!  An  empty  garage,  an  old  arcade  and  a  big  dream.",  "¡Todo  começa  aquí!  Un  garaje  vacío,  un  arcade  viejo  y  un  gran  sueño."];
		draw_text_ext(180, 435, txt_Texto[global.idm], 22, 340);
        draw_set_font(font_Pequena);
        txt_Adicionais = ["Toque  nas  setas  para  ver  o  tutorial  completo  e  assim  avançando  em  sua  jornada!",  "Tap  the  arrows  to  view  the  full  tutorial  and  advance  on  your  journey!",  "¡Toca  las  flechas  para  ver  el  tutorial  completo  y  avanzar  en  tu  viaje!"];
		draw_text_ext(180, 545, txt_Adicionais[global.idm], 22, 340);
    } 
	
    //PÁGINA 1
	else if (atual == 1) {
        draw_set_font(font_Titulo_grande);
        txt_Titulo = ["COMO JOGAR: FASE 1",  "HOW TO PLAY: PHASE 1",  "CÓMO JUGAR: FASE 1"];
        draw_text_ext(180, -5, txt_Titulo[global.idm], 22, 360);
        draw_set_halign(fa_left);
        draw_set_font(font_Texto);
        txt_Texto = ["O  cliente  vai  entrar  e  pedir  um  fliperama  específico  no  balão.  Atenda-o  no  balcão  e  leve-o  \n  até  a  máquina!",  "The  customer  will  enter  and  request  a  specific  arcade  in  the  bubble.  Serve  them  at  the  counter  and  take  them  to  the  machine!",  "El  cliente  entrará  y  pedirá  un  arcade  específico  en  el  \n  bocadillo.  ¡Atiéndelo  en  el  mostrador  y  llévalo  a  la  \n  máquina!"];
        draw_text_ext(15, 85, txt_Texto[global.idm], 22, 250);
        draw_sprite_ext(spr_Tutorial_cenario_1, 0, 300, 125, 0.2, 0.2, 0, c_white, 1);
		txt_Texto = ["Cada  fliperama  pertence  a  uma  classe:  ruim,  bom  ou  perfeito.  \n  As  melhores  máquinas  geram  muito  mais  moedas  e  experiência.",  "Each  arcade  belongs  to  a  class:  bad,  good,  or  perfect.  The  best  machines  generate  much  more  coins  and  experience.",  "Cada  fliperama  pertenece  a  una  clase:  malo,  bueno  o  perfecto.  Las  mejores  máquinas  generan  muchas  más  monedas  y  experiencia."];
        draw_text_ext(100, 255, txt_Texto[global.idm], 22, 250);
        draw_sprite_ext(spr_Tutorial_fliperama, 0, 50, 300, 1.3, 1.3, 0, c_white, 1);		
		txt_Texto = ["Existem  diversos  tipos  de  clientes  frequentando  a  sua  Lan  House.  Cada  um  deles  tem  seu  próprio  gosto  para  jogar  e  pode  pagar  valores  diferentes.",  "There  are  several  types  of  customers  visiting  your  Lan  House.  Each  one  has  their  own  taste  in  gaming  and  can  pay  different  amounts.",  "Existen  diversos  tipos  de  clientes  que  visitan  tu  Lan  House.  Cada  uno  tiene  su  propio  gusto  para  jogar  y  puede  pagar  valores  diferentes."];
        draw_text_ext(15, 420, txt_Texto[global.idm], 22, 250);
        draw_sprite_ext(spr_Tutorial_personagem_1, image_index, 305, 460, 1.6, 1.6, 0, c_white, 1);
    } 
	
    //PÁGINA 2
    else if (atual == 2) {
        draw_set_halign(fa_center);
        draw_set_font(font_Titulo_grande);
        txt_Titulo = ["MISSÃO INICIAL", "INITIAL MISSION", "MISIÓN INICIAL"];
        draw_text_ext(180, -5, txt_Titulo[global.idm], 22, 360);
        draw_set_font(font_Texto);
        txt_Texto = ["Sua   missão   principal   é   atender   todos   os   clientes   com   extrema   rapidez   para   maximizar   os   seus   lucros   e   acumular   experiência.   Junte   uma   boa   fortuna,   alcance   o   nível   necessário   e   desbloqueie   a   próxima   grande   fase   do   seu   império   tecnológico,   saindo   da   garagem   para   abrir   uma   assistência   técnica!", "Your   main   mission   is   to   serve   all   customers extremely   quickly   to   maximize   your   profits   and   accumulate   experience.   Build   a   good   fortune,   reach   the   required   level,   and   unlock   the   next   big   stage   of   your   technological   empire,   leaving   the   garage   to   open   a   computer   repair   shop!", "Tu   misión   principal   es   atender   a   todos   los   clientes   con   extrema   rapidez   para   maximizar   tus   ganancias   y   acumular   experiencia.   Acumula   una   buena   fortuna,   alcanza   el   nivel   necesario   y   desbloquea   la   siguiente   gran   fase   de   tu   imperio   tecnológico,   ¡sal del   garaje   para   abrir   un   taller   de   reparación!"];
        draw_text_ext(180, 60, txt_Texto[global.idm], 22, 330);
        draw_set_font(font_Sobre_titulo);
        txt_Sobre_titulo = ["DICA EXTRA", "EXTRA TIP", "CONSEJO EXTRA"];
        draw_text_ext(180, 290, txt_Sobre_titulo[global.idm], 22, 360);
        draw_sprite_ext(spr_Tutorial_dica_extra, 0, 260, 300, 1, 1, 0, c_white, 1);
        draw_sprite_ext(spr_Tutorial_dica_extra, 0, 100, 300, 1, 1, 0, c_white, 1);
        draw_set_font(font_Texto);
        txt_Texto = ["No   início   da   sua   jornada,   a   velocidade   de   atendimento   depende   totalmente   da   sua   agilidade   ao   tocar   na   tela.   Invista   suas   primeiras   moedas   no   upgrade   de   Internet   para   automatizar   os   processos   e   fazer   as   máquinas   trabalharem   sozinhas   enquanto   você   gerencia   o   negócio.", "At   the   beginning   of   your   journey,   the   service   speed   depends   entirely   on   your   agility   when   tapping   the   screen.   Invest   your   first   coins   in   the   Internet   upgrade   to   automate   processes   and   make   the   machines   work   by   themselves   while   you   manage   the   business.", "Al   inicio   de   tu   viaje,   la   velocidade   de   atención   depende   totalmente   de   tu   agilidad   al   tocar   la   pantalla.   Invierte   tus   primeras   monedas   en   la   mejora   de   Internet   para   automatizar   los   procesos   y   hacer   que   las   máquinas   trabajen   solas   mientras   tú   gesionas   el   negocio."];
        draw_text_ext(180, 355, txt_Texto[global.idm], 22, 330);
    }
	
    //PÁGINA 3
    else if (atual == 3) {
        draw_set_font(font_Titulo_grande);
        txt_Titulo = ["TUDO PRONTO!", "READY TO GO!", "¡TODO LISTO!"];
        draw_text_ext(180, -5, txt_Titulo[global.idm], 22, 360);
        draw_set_font(font_Sobre_titulo);
        txt_Sobre_titulo = ["CHEGA DE PAPO E BORA PRO JOGO!", "ENOUGH TALK, LET'S PLAY!", "¡MENOS CHARLA Y A JUGAR!"];
        draw_text_ext(180, 60, txt_Sobre_titulo[global.idm], 22, 340);
        draw_sprite_ext(spr_Tutorial_fases, 0, 180, 260, 2, 2, 0, c_white, 1);
        draw_set_font(font_Texto);
		txt_Texto = ["Agora  você  já  sabe  o  necessário  para  gerenciar  seu  negócio.  Toque  na  seta  abaixo  para  abrir  a  sua  Lan  House  e  começar  sua  jornada!", "Now  you  know  what  it  takes  to  manage  your  business.  Tap  the  arrow  below  to  open  your  Lan  House  and  start  your  journey!", "Ahora  ya  sabes  lo  necesario  para  gestionar  tu  negocio.  Toca  la  flecha  abajo  para  abrir  tu  Lan  House  y  ¡comenzar  tu  viaje!"];
        draw_text_ext(180, 435, txt_Texto[global.idm], 22, 330);
    }
}

//FASE 2
else if (fase == 2) {
	
	//PÁGINA 0
    if (atual == 0) {
        draw_set_font(font_Titulo_grande);
        txt_Titulo = "TUTORIAL";
        draw_text(180, -5, txt_Titulo);
        draw_set_font(font_Sobre_titulo);
        txt_Sobre_titulo = ["FASE 2: A ASSISTÊNCIA TÉCNICA DO CENTRO", "PHASE 2: THE DOWNTOWN TECH SUPPORT", "FASE 2: LA ASISTENCIA TÉCNICA DEL CENTRO"];
        draw_text_ext(180, 60, txt_Sobre_titulo[global.idm], 22, 340);
        draw_sprite_ext(spr_Tutorial_logo_ByteRise, 0, 180, 260, 0.3, 0.3, 0, c_white, 1);
        draw_set_font(font_Texto);
		txt_Texto = ["O  negócio  cresceu,  a  garagem  ficou  pequena  e  agora  o  desafio  é  real  no  coração  da  cidade.", "The  business  has  grown,  the  garage  got  too  small,  and  now  the  real  challenge  begins  in  the  heart  of  the  city.", "El  negocio  creció,  la  cochera  se  ficou  pequeña  e  agora  o  desafío  es  real  no  coração  da  cidade."];
        draw_text_ext(180, 435, txt_Texto[global.idm], 22, 340);
        draw_set_font(font_Pequena);
        txt_Adicionais = ["Toque  nas  setas  para  ver  o  tutorial  completo  e  assim  avançando  em  sua  jornada!", "Tap  the  arrows  to  see  the  full  tutorial  and  advance  on  your  journey!", "¡Toca  las  flechas  para  ver  el  tutorial  completo  y  avanzar  en  tu  viaje!"];
        draw_text_ext(180, 545, txt_Adicionais[global.idm], 22, 340);
    }
	
	//PÁGINA 1
    else if (atual == 1) {
        draw_set_font(font_Titulo_grande);
        txt_Titulo = ["COMO JOGAR: FASE 2",  "HOW TO PLAY: PHASE 2",  "CÓMO JUGAR: FASE 2"];
        draw_text_ext(180, -5, txt_Titulo[global.idm], 22, 360);
        draw_set_halign(fa_left);
        draw_set_font(font_Texto);
		txt_Texto = ["O  cliente  vai  entrar  com  o  computador  e  explicar  o  problema.  Interprete  o  pedido \ne  leve-o  até  a  área  de  conserto  correta!", "The  customer  will  enter  with  their  computer  and  explain  the  problem.  Interpret  the  request  and  take  it  to  the  correct  repair  area!", "El  cliente  entrará  con  su  computadora  y  explicará  el  problema.  ¡Interpreta  el  pedido  y  llévalo  a  la  zona  de  reparación  correcta!"];
        draw_text_ext(15, 85, txt_Texto[global.idm], 22, 250);
        draw_sprite_ext(spr_Tutorial_cenario_2, 0, 300, 125, 0.2, 0.2, 0, c_white, 1);
		txt_Texto = ["Cada  área  de  conserto  pertence  a  uma  classe:  ruim,  bom  ou  perfeito.  \n  As  melhores  bancadas  geram  muito  mais  moedas  e  experiência.", "Each  repair  area  belongs  to  a  class:  bad,  good,  or  perfect.  \n  The  best  benches  generate  much  more  coins  and  experience.", "Cada  área  de  reparación  pertenece  a  una  clase:  malo,  bueno  o  perfecto.  \n  Las  mejores  bancas  generan  muchas  más  monedas  y  experiencia."];
        draw_text_ext(100, 255, txt_Texto[global.idm], 22, 250);
        draw_sprite_ext(spr_Tutorial_mesa, 0, 50, 315, 1.3, 1.3, 0, c_white, 1);		
		txt_Texto = ["Existem  diversos  tipos  de  clientes  frequentando  a  sua  Assistência  Técnica.  Cada  um  deles  tem  sua  forma  de  explicar  o  problema  e  pode  pagar  valores  diferentes.", "There  are  several  types  of  customers  visiting  your  Technical  Support.  Each  one  has  their  own  way  of  explaining  the  problem  and  can  pay  different  amounts.", "Existen  diversos  tipos  de  clientes  que  visitan  tu  Asistencia  Técnica.  Cada  uno  tiene  su  propia  forma  de  explicar  el  problema  y  puede  pagar  valores  diferentes."];
        draw_text_ext(15, 420, txt_Texto[global.idm], 22, 250);
        draw_sprite_ext(spr_Tutorial_personagem_2, image_index, 365, 475, 1.6, 1.6, 0, c_white, 1);

    }
	
	//PÁGINA 2
    else if (atual == 2) {
		draw_set_halign(fa_center);
        draw_set_font(font_Titulo_grande);
		txt_Titulo = ["MISSÃO INTERMEDIÁRIA", "INTERMEDIARY MISSION", "MISIÓN INTERMEDIA"];
        draw_text_ext(180, -5, txt_Titulo[global.idm], 22, 500);
        draw_set_font(font_Texto);
        txt_Texto = ["Sua  missão  principal  é  identificar  o  problema  dos  computadores  com  rapidez  para  maximizar  seus  lucros  e  acumular  experiência.  Junte  uma  boa  fortuna,  alcance  o  nível  necessário  e  desbloqueie  a  próxima  fase  do  seu  império  tecnológico,  saindo  do  centro  para  fundar  uma  grande  Empresa  de  Tecnologia!", "Your  main  mission  is  to  quickly  identify  the  computer  problems  to  maximize  your  profits  and  accumulate  experience.  Gather  a  good  fortune,  reach  the  required  level,  and  unlock  the  next  stage  of  your  tech  empire,  leaving  downtown  to  found  a  large  Tech  Company!", "¡Tu  misión  principal  es  identificar  el  problema  de  las  computadoras  con  rapidez  para  maximizar  tus  ganancias  y  acumular  experiencia.  Junta  una  buena  fortuna,  alcanza  el  nivel  necesario  y  desbloquea  la  siguiente  fase  de  tu  imperio  tecnológico,  ¡saliendo  del  centro  para  fundar  una  gran  Empresa  de  Tecnología!"];
        draw_text_ext(180, 60, txt_Texto[global.idm], 22, 330);
        draw_set_font(font_Sobre_titulo);
        txt_Sobre_titulo = ["DICA EXTRA", "EXTRA TIP", "CONSEJO EXTRA"];
        draw_text_ext(180, 290, txt_Sobre_titulo[global.idm], 22, 360);
        draw_sprite_ext(spr_Tutorial_dica_extra, 0, 260, 300, 1, 1, 0, c_white, 1);
        draw_sprite_ext(spr_Tutorial_dica_extra, 0, 100, 300, 1, 1, 0, c_white, 1);
        draw_set_font(font_Texto);
        txt_Texto = ["Fique  atento  ao  perfil  de  cada  cliente!  Idosos,  programadores  e  mães  explicam  o  mesmo  defeito  de  formas  diferentes.  Interprete  a  fala  com  cuidado:  se  reclamarem  de  falta  de  espaço,  leve  o  PC  para  a  bancada  de  HD/SSD;  se  a  tela  estiver  estranha,  o  problema  é  na  Placa  de  Vídeo!", "Pay  attention  to  each  customer's  profile!  Seniors,  programmers,  and  mothers  explain  the  same  issue  in  different  ways.  Interpret  their  words  carefully:  if  they  complain  about  storage,  take  it  to  the  HD/SSD  bench;  if  the  screen  looks  weird,  the  issue  is  the  Video  Card!", "¡Presta  atención  al  perfil  de  cada  cliente!  Los  ancianos,  programadores  y  madres  explican  el  mismo  defecto  de  formas  diferentes.  Interpreta  sus  palabras  con  cuidado:  si  se  quejan  de  falta  de  espacio,  lleva  la  PC  al  banco  de  HD/SSD;  si  la  pantalla  se  ve  rara,  ¡el  problema  es  la  Tarjeta  de  Video!"];
        draw_text_ext(180, 355, txt_Texto[global.idm], 22, 330);
    }
	
	//PÁGINA 3
    else if (atual == 3) {
        draw_set_font(font_Titulo_grande);
        txt_Titulo = ["TUDO PRONTO!", "READY TO GO!", "¡TODO LISTO!"];
        draw_text_ext(180, -5, txt_Titulo[global.idm], 22, 360);
        draw_set_font(font_Sobre_titulo);
        txt_Sobre_titulo = ["CHEGA DE PAPO E BORA PRO JOGAR!", "ENOUGH TALK, LET'S PLAY!", "¡MENOS CHARLA Y A JUGAR!"];
        draw_text_ext(180, 60, txt_Sobre_titulo[global.idm], 22, 340);
        draw_sprite_ext(spr_Tutorial_fases, 1, 180, 260, 2, 2, 0, c_white, 1);
        draw_set_font(font_Texto);
		txt_Texto = ["Agora  você  já  sabe  o  necessário  para  gerenciar  seu  negócio.  Toque  na  seta  abaixo  para  abrir  a  sua  Assistência  Técnica  e  começar  sua  jornada!", "Now  you  know  what  it  takes  to  manage  your  business.  Tap  the  arrow  below  to  open  your  Technical  Support  and  start  your  journey!", "Ahora  ya  sabes  lo  necesario  para  gestionar  tu  negocio.  Toca  la  flecha  abajo  para  abrir  tu  Asistencia  Técnica  y  ¡comenzar  tu  viaje!"];
        draw_text_ext(180, 435, txt_Texto[global.idm], 22, 330);
    }
}

//FASE 3
else if (fase == 3) {
	
	//PÁGINA 0
    if (atual == 0) {
        draw_set_font(font_Titulo_grande);
        txt_Titulo = "TUTORIAL";
        draw_text(180, -5, txt_Titulo);
        draw_set_font(font_Sobre_titulo);
        txt_Sobre_titulo = ["FASE 3: A EMPRESA DE TECNOLOGIA GLOBAL", "PHASE 3: THE GLOBAL TECH COMPANY", "FASE 3: LA EMPRESA DE TECNOLOGÍA GLOBAL"];
        draw_text_ext(180, 60, txt_Sobre_titulo[global.idm], 22, 340);
        draw_sprite_ext(spr_Tutorial_logo_ByteRise, 0, 180, 260, 0.3, 0.3, 0, c_white, 1);
        draw_set_font(font_Texto);
        txt_Texto = ["Deixando  a  oficina  para  gerenciar  uma  grande  corporação,  produzir  dispositivos  e  dominar  o  mercado  mundial.", "Leaving  the  workshop  to  manage  a  large  corporation,  produce  devices,  and  dominate  the  global  market.", "Dejando  el  taller  para  gestionar  una  gran  corporación,  producir  dispositivos  y  dominar  el  mercado  mundial."];
		draw_text_ext(180, 435, txt_Texto[global.idm], 22, 340);
        draw_set_font(font_Pequena);
        txt_Adicionais = ["Toque  nas  setas  para  ver  o  tutorial  completo  e  assim  avançando  em  sua  jornada!", "Tap  the  arrows  to  view  the  full  tutorial  and  advance  on  your  journey!", "¡Toca  las  flechas  para  ver  el  tutorial  completo  y  avanzar  en  tu  viaje!"];
		draw_text_ext(180, 545, txt_Adicionais[global.idm], 22, 340);
    }
	
	//PÁGINA 1
    else if (atual == 1) {
		draw_set_font(font_Titulo_grande);
        txt_Titulo = ["COMO JOGAR: FASE 3",  "HOW TO PLAY: PHASE 3",  "CÓMO JUGAR: FASE 3"];
		draw_text_ext(180, -5, txt_Titulo[global.idm], 22, 360);
        draw_set_halign(fa_left);
        draw_set_font(font_Texto);
        txt_Texto = ["O  Montador  vai  fabricar  o  dispositivo  móvel.  Depois,  o  Exportador  recolhe  os  itens  \n  e  leva  até  a  esteira  para  empacotamento!", "The  Assembler  will  manufacture  the  mobile  device.  Then,  the  Exporter  collects  the  items  \n  and  takes  them  to  the  conveyor  belt  for  packaging!", "¡El  Montador  fabricará  el  dispositivo  móvel.  Después,  el  Exportador  recoge  los  ítems  \n  y  los  lleva  a  la  cinta  transportadora  para  su  empaque!"];
        draw_text_ext(15, 85, txt_Texto[global.idm], 22, 250);
		draw_sprite_ext(spr_Tutorial_personagem_3, image_index, 345, 125, 1.6, 1.5, 0, c_white, 1);
		txt_Texto = ["Cada  dispositivo  pertence  a  uma  classe:  ruim,  bom  ou  perfeito.  \n  Os  melhores  aparelhos  geram  muito  mais  lucro.", "Each  device  belongs  to  a  class:  bad,  good,  or  perfect.  \n  The  best  devices  generate  much  more  profit.", "Cada  dispositivo  pertenece  a  una  clase:  malo,  bueno  o  perfecto.  \n  Los  mejores  aparatos  generan  muchas  más  ganancias."];
        draw_text_ext(100, 255, txt_Texto[global.idm], 22, 250);
        draw_sprite_ext(spr_Tutorial_bancada, 0, 50, 300, 1.3, 1.3, 0, c_white, 1);		
		txt_Texto = ["Nesta  fase,  não  há  clientes.  Você  administra  seus  trabalhadores  para  colocar  as  caixas  nos  veículos  e  enviar  os  pedidos  ao  mercado  mundial.", "In  this  phase,  there  are  no  customers.  You  manage  your  workers  to  load  the  boxes  onto  the  vehicles  and  ship  the  orders  to  the  global  market.", "En  esta  fase,  no  hay  clientes.  Administras  a  tus  trabajadores  para  cargar  las  cajas  en  los  vehículos  y  enviar  los  pedidos  al  mercado  mundial."];
        draw_text_ext(15, 420, txt_Texto[global.idm], 22, 250);
        draw_sprite_ext(spr_Tutorial_transporte, image_index, 360, 480, 1.8, 1.8, 0, c_white, 1);
    }
	
	//PÁGINA 2
    else if (atual == 2) {
		draw_set_halign(fa_center);
        draw_set_font(font_Titulo_grande);
        txt_Titulo = ["MISSÃO FINAL", "FINAL MISSION", "MISIÓN FINAL"];
		draw_text_ext(180, -5, txt_Titulo[global.idm], 22, 360);
        draw_set_font(font_Texto);
        txt_Texto = ["Sua  missão  principal  é  coordenar  sua  equipe  de  produção  com  eficiência  para  maximizar  os  lucros  da  corporação.  Gerencie  a  montagem,  o  empacotamento  e  o  carregamento  dos  dispositivos  móveis  nos  veículos  de  transporte  para  enviar  seus  pedidos  e  conquistar  o  mercado  mundial!", "Your  main  mission  is  to  coordinate  your  production  team  efficiently  to  maximize  the  corporation's  profits.  Manage  the  assembly,  packaging,  and  loading  of  mobile  devices  onto  transport  vehicles  to  ship  your  orders  and  conquer  the  global  market!", "¡Tu  misión  principal  es  coordinar  a  tu  equipo  de  producción  con  eficiencia  para  maximizar  las  ganancias  de  la  corporación.  Gestiona  el  ensamblaje,  empaque  y  carga  de  los  dispositivos  móviles  en  los  vehículos  de  transporte  para  enviar  tus  pedidos  y  ¡conquistar  el  mercado  mundial!"];
        draw_text_ext(180, 60, txt_Texto[global.idm], 22, 330);
        draw_set_font(font_Sobre_titulo);
        txt_Sobre_titulo = ["DICA EXTRA", "EXTRA TIP", "CONSEJO EXTRA"];
        draw_text_ext(180, 290, txt_Sobre_titulo[global.idm], 22, 360);
        draw_sprite_ext(spr_Tutorial_dica_extra, 0, 260, 300, 1, 1, 0, c_white, 1);
        draw_sprite_ext(spr_Tutorial_dica_extra, 0, 100, 300, 1, 1, 0, c_white, 1);
        draw_set_font(font_Texto);
        txt_Texto = ["Fique  atento  à  tela  móvel!  Como  vários  processos  ocorrem  ao  mesmo  tempo  nas  áreas  interna  e  externa,  use  os  cliques  para  agilizar  as  tarefas.  Invista  no  upgrade  de  Café  para  estimular  seus  funcionários,  reduzindo  o  tempo  de  execução  base  e  automatizando  o  ritmo  da  fábrica!", "Keep  an  eye  on  the  moving  screen!  Since  multiple  processes  happen  at  the  same  time  indoors  and  outdoors,  use  clicks  to  speed  up  tasks.  Invest  in  the  Coffee  upgrade  to  boost  your  employees,  reducing  base  execution  time  and  automating  the  factory  pace!", "¡Presta  atención  a  la  pantalla  móvil!  Como  varios  procesos  ocurren  al  mismo  tiempo  en  las  áreas  interna  y  externa,  usa  los  clics  para  agilizar  las  tareas.  ¡Invierte  en  la  mejora  de  Café  para  estimular  a  tus  empleados,  reduciendo  el  tiempo  de  ejecución  base  y  automatizando  el  ritmo  de  la  fábrica!"];
        draw_text_ext(180, 355, txt_Texto[global.idm], 22, 330);
    }
	
	//PÁGINA 3
    else if (atual == 3) {
        draw_set_font(font_Titulo_grande);
        txt_Titulo = ["TUDO PRONTO!", "READY TO GO!", "¡TODO LISTO!"];
        draw_text_ext(180, -5, txt_Titulo[global.idm], 22, 360);
        draw_set_font(font_Sobre_titulo);
        txt_Sobre_titulo = ["CHEGA DE PAPO E BORA PRO JOGAR!", "ENOUGH TALK, LET'S PLAY!", "¡MENOS CHARLA Y A JUGAR!"];
        draw_text_ext(180, 60, txt_Sobre_titulo[global.idm], 22, 340);
        draw_sprite_ext(spr_Tutorial_fases, 2, 180, 260, 2, 2, 0, c_white, 1);
        draw_set_font(font_Texto);
		txt_Texto = ["Agora  você  já  sabe  o  necessário  para  gerenciar  seu  negócio.  Toque  na  seta  abaixo  para  abrir  a  sua  Empresa  de  Tecnologia  e  começar  sua  jornada!", "Now  you  know  what  it  takes  to  manage  your  business.  Tap  the  arrow  below  to  open  your  Tech  Company  and  start  your  journey!", "Ahora  ya  sabes  lo  necesario  para  gestionar  tu  negocio.  Toca  la  flecha  abajo  para  abrir  tu  Empresa  de  Tecnología  y  ¡comenzar  tu  viaje!"];
        draw_text_ext(180, 435, txt_Texto[global.idm], 22, 330);
    }
}
