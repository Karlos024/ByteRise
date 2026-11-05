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
		txt_Texto = ["                              Parece  que  as  coisas  estão  ficando  cada  vez  mais  difíceis...  O  dinheiro  mal  dá  pra  pagar  as  contas.  Preciso  pensar  em  alguma  coisa  pra  mudar  essa  situação...  mas  o  quê?", "                              It  feels  like  things  get  harder  and  harder...  Money  is  barely  enough  to  pay  the  bills.  I  need  to  think  of  something  to  change  this  situation...  but  what?", "                              Parece  que  las  cosas  se  están  complicando  cada  vez  más...  El  dinheiro  apenas  alcanza  para  pagar  las  cuentas.  Necesito  pensar  en  algo  para  cambiar  esta  situación...  ¿pero  qué?"];
		draw_text_ext(180, 560, txt_Texto[global.idm], 22, 340);
		break;
        
    case 1:
        txt_Texto = [""];
        break;
        
    case 2:
		draw_sprite_ext(spr_Inicio_cutscene_fundo, 0, 180, 590, 1.5, 1.2, 0, c_white, 0.9);
		draw_sprite_ext(spr_Inicio_cabeca, 0, 20, 565, 0.5, 0.5, 0, c_white, 0.9);
        txt_Texto = ["                              Quem  será  que  deixou  isso  aqui?  Uma  máquina  dessas  não  aparece  na  rua  todo  dia...", "                              Who  could  have  left  this  here?  An  arcade  machine  like  this  doesn't  just  show  up  on  the  street  every  day...", "                              ¿Quién  habrá  dejado  esto  aquí?  Una  máquina  de  arcade  como  esta  no  aparece  en  la  calle  todos  los  días..."];
        draw_text_ext(180, 560, txt_Texto[global.idm], 22, 340);
		break;
        
    case 3:
		draw_set_color(c_black);
		draw_set_font(font_Titulo_pequena);
		txt_Texto = ["Cobrar por partida nessa máquina? Espera... e se eu abrir uma lan house? Começo pequeno e vou crescendo!", "Charge per play on this machine? Wait... what if I open a LAN house? Start small and grow!",  "¿Cobrar por partida en esta máquina? Espera... ¿y si abro un ciber? ¡Empiezo pequeño y voy creciendo!"];
		draw_text_ext(188, 168, txt_Texto[global.idm], 22, 260);
		break;
        
    case 4:
		draw_sprite_ext(spr_Inicio_cutscene_fundo, 0, 180, 590, 1.5, 1.2, 0, c_white, 0.9);
		draw_sprite_ext(spr_Inicio_cabeca, 0, 20, 565, 0.5, 0.5, 0, c_white, 0.9);
        txt_Texto = ["                              Não  tenho  muito  a  perder.  Vou  levar  essa  máquina  pra  garagem  e  descobrir  si  consigo  fazer  isso  dar  certo!", "                              I  don't  have  much  to  lose.  I  ll  take  this  machine  to  the  garage  and  find  out  if  I  can  make  this  work!", "                              No  tengo  mucho  que  perder.  ¡Llevaré  esta  máquina  al  garaje  y  averiguaré  si  puedo  hacer  que  esto  funcione!"];
        draw_text_ext(180, 560, txt_Texto[global.idm], 22, 340);
		break;
        
    case 5:
		draw_sprite_ext(spr_Inicio_cutscene_fundo, 0, 180, 590, 1.5, 1.2, 0, c_white, 0.9);
		draw_sprite_ext(spr_Inicio_cabeca, 0, 20, 565, 0.5, 0.5, 0, c_white, 0.9);
        txt_Texto = ["                              É  só  o  primeiro  passo...  Quem  sabe  isso  não  seja  o  começo  de  uma  vida  completamente  diferente?", "                              It's  just  the  first  step...  Who  knows,  maybe  this  is  the  beginning  of  a  completely  different  life?", "                              Es  solo  el  primer  paso...  ¿Quién  sabe  si  este  no  sea  el  comienzo  de  uma  vida  completamente  diferente?"];
        draw_text_ext(180, 560, txt_Texto[global.idm], 22, 340);
		break;
}