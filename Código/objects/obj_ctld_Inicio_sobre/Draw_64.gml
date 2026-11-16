if (exibir_sobre == true) {
    
    //FUNDO SOBRE
    draw_sprite_stretched(spr_Inicio_sobre_fundo, 0, -20.54, 0, 400, 650);

    //PADRÃO DOS CARACTERES
    draw_set_valign(fa_top);    
    draw_set_color(c_white);
    
    //INFORMAÇÕES
	draw_set_font(font_Titulo_grande);  
    draw_set_halign(fa_center);
    var txt_sobre = "BYTERISE";
    draw_text_ext(180, -5, txt_sobre, 18, 340);
   
    draw_set_font(font_Texto);  
    draw_set_halign(fa_left);
	txt_sobre = ["          Em  ByteRise,  as  rédeas  do  futuro  tecnológico  estão  nas  suas  mãos!  Você  aceita  o  desafio  de  transformar  uma  garagem  vazia  em  uma  empresa  de  alcance  global?  Cada  clique  seu  guia  a  jornada  desse  jovem  sonhador. \n          Aqui,  você  é  quem  comanda!  Será  preciso  tomar  decisões  inteligentes  para  administrar  3  grandes  negócios:  uma  Lan  House  divertida,  uma  Assistência  Técnica  cheia  de  problemas  e  uma  super  Empresa  de  Tecnologia!", "          In  ByteRise,  the  reins  of  the  technological  future  are  in  your  hands!  Do  you  accept  the  challenge  of  transforming  an  empty  garage  into  a  global  company?  Every  click  of  yours  guides  this  young  dreamer's  journey. \n          Here,  you  are  the  one  in  command!  You  will  need  to  make  smart  decisions  to  manage  3  major  businesses:  a  fun  LAN  House,  a  problem-filled  Technical  Support,  and  a  super  Tech  Company!", "          ¡En ByteRise,  las  riendas  del  futuro  tecnológico  están  en  tus  manos!  ¿Aceptas  el  desafío  de  transformar  un  garaje  vacío  en  una  empresa  de  alcance  global?  Cada  clic  tuyo  guía  el  viaje  de  este  joven  soñador. \n          ¡Aquí,  tú  eres  quien  manda!  Será  necesario  tomar  decisiones  inteligentes  para  administrar  3  grandes  negócios:  un  cybercafé  divertido,  un  servicio  técnico  lleno  of  problemas  ¡y  una  súper  empresa  de  tecnología!"];
    draw_text_ext(11.46, 35, txt_sobre[global.idm], 18, 340);

    draw_set_font(font_Titulo_pequena); 
    draw_set_halign(fa_center);
	txt_sobre = ["TRACE A SUA JORNADA", "TRACE YOUR JOURNEY", "TRAZA TU JUVENTUD"];
    draw_text_ext(180, 260, txt_sobre[global.idm], 18, 450);
	 
	draw_set_font(font_Texto);
    draw_set_halign(fa_left);
    txt_sobre = [" \n -- Escolher  os  Upgrades:  Decida  se  vai  investir  em  fliperamas  incríveis  ou  em  uma  internet  ultrarrápida. \n -- Gerenciar  sua  Equipe:  Contrate  ajudantes  e  distribua  tarefas  para  automatizar  o  seu  atendimento. \n -- Resolver  Desafios:  Atenda  clientes  curiosos,  resolva  problemas  e  faça  sua  reputação  subir!", " \n -- Choose  Upgrades:  Decide  whether  to  invest  in  awesome  arcades  or  ultra-fast  internet. \n -- Manage  your  Team:  Hire  helpers  and  distribute  tasks  to  automate  your  service. \n -- Solve  Challenges:  Serve  curious  customers,  fix  problems,  and  make  your  reputation  soar!", " \n -- Elegir  Upgrades:  Decide  si  vas  a  invertir  en  recreativas  increíbles  o  en  un  internet  ultrarrápido. \n -- Gestionar  tu  Equipo:  Contrata  ayudantes  y  distribuye  tareas  para  automatizar  tu  atención. \n -- Resolver  Desafíos:  ¡Atiende  a  clientes  curiosos,  resuelve  problemas  y  haz  que  tu  reputación  suba!"];
    draw_text_ext(11.46, 265, txt_sobre[global.idm], 18, 340);

    draw_set_font(font_Titulo_pequena);
    draw_set_halign(fa_center);
    draw_set_color(c_yellow);
	txt_sobre = ["DESAFIO", "CHALLENGE", "DESAFÍO"];
    draw_text_ext(180, 450, txt_sobre[global.idm], 18, 340);
	
	draw_set_font(font_Texto);
    draw_set_halign(fa_left); 
    txt_sobre = ["          Pense  rápido,  invista  com  sabedoria  e  guie  esse  império  até  o  topo  do  mundo.  Suas  escolhas  vão  ditar  o  sucesso. \n           Você  consegue  alcançar  o  nível  máximo  e  dominar  o  mercado  global?", "          Think  fast,  invest  wisely,  and  guide  this  empire  to  the  top  of  the  world.  Your  choices  will  dictate  success. \n           Can  you  reach  the  maximum  level  and  dominate  the  global  market?", "          Piensa  rápido,  invierte  con  sabiduría  y  guía  este  imperio  hasta  la  cima  del  mundo.  Tus  elecciones  dictarán  el  éxito. \n           ¿Puedes  alcanzar  el  nivel  máximo  y  dominar  el  mercado  global?"];
    draw_text_ext(11.46, 473, txt_sobre[global.idm], 15, 340);
}
