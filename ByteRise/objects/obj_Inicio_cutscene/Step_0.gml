var txt_Texto = ["", "", ""];
switch (floor(image_index)) {
    case 0:
        txt_Texto = ["                              Parece  que  as  coisas  estão  ficando  cada  vez  mais  difíceis...  O  dinheiro  mal  dá  pra  pagar  as  contas.  Preciso  pensar  em  alguma  coisa  pra  mudar  essa  situação...  mas  o  quê?", "                              It  feels  like  things  get  harder  and  harder...  Money  is  barely  enough  to  pay  the  bills.  I  need  to  think  of  something  to  change  this  situation...  but  what?", "                              Parece  que  las  cosas  se  están  complicando  cada  vez  más...  El  dinero  apenas  alcanza  para  pagar  las  cuentas.  Necesito  pensar  en  algo  para  cambiar  esta  situación...  ¿pero  qué?"];
        break;

    case 2:
        txt_Texto = ["                              Quem  será  que  deixou  isso  aqui?  Uma  máquina  dessas  não  aparece  na  rua  todo  dia...", "                              Who  could  have  left  this  here?  An  arcade  machine  like  this  doesn't  just  show  up  on  the  street  every  day...", "                              ¿Quién  habrá  dejado  esto  aquí?  Una  máquina  de  arcade  como  esta  no  aparece  en  la  calle  todos  los  días..."];
        break;

    case 3:
        txt_Texto = ["Cobrar por partida nessa máquina? Espera... e se eu abrir uma lan house? Começo pequeno e vou crescendo!", "Charge per play on this machine? Wait... what if I open a LAN house? Start small and grow!", "¿Cobrar por partida en esta máquina? Espera... ¿y si abro un ciber? ¡Empiezo pequeño y voy creciendo!"];
        break;

    case 4:
        txt_Texto = ["                              Não  tenho  muito  a  perder.  Vou  levar  essa  máquina  pra  garagem  e  descobrir  se  consigo  fazer  isso  dar  certo!", "                              I  don't  have  much  to  lose.  I'll  take  this  machine  to  the  garage  and  find  out  if  I  can  make  this  work!", "                              No  tengo  mucho  que  perder.  ¡Llevaré  esta  máquina  al  garaje  y  averiguaré  si  puedo  hacer  que  esto  funcione!"];
        break;

    case 5:
        txt_Texto = ["                              É  só  o  primeiro  passo...  Quem  sabe  isso  não  seja  o  começo  de  uma  vida  completamente  diferente?", "                              It's  just  the  first  step...  Who  knows,  maybe  this  is  the  beginning  of  a  completely  different  life?", "                              Es  solo  el  primer  paso...  ¿Quién  sabe  si  este  no  sea  el  comienzo  de  una  vida  completamente  diferente?"];
        break;
}
texto_atual = txt_Texto[global.idm];

//REINICIAR QUANDO O TEXTO MUDAR
if (texto_atual != texto_anterior) {
    caracteres_visiveis = 0;
    texto_anterior = texto_atual;
    proximo_som = 1;
    palavras_contadas = 0;
    ultimo_caractere = 0;

    if (som_atual != noone) {
        audio_stop_sound(som_atual);
        som_atual = noone;
    }
}

//ESCREVE PROGRESSIVAMENTE
if (caracteres_visiveis < string_length(texto_atual)) {
    caracteres_visiveis += velocidade_escrita;
    caracteres_visiveis = min(caracteres_visiveis, string_length(texto_atual));

    var caractere_atual = floor(caracteres_visiveis);

    for (var i = ultimo_caractere + 1; i <= caractere_atual; i++) {

        //IDENTIFICAR CARACTERE
        var letra = string_char_at(texto_atual, i);
        var anterior = "";

        if (i > 1) {
            anterior = string_char_at(texto_atual, i - 1);
        }

        if (letra == " ") {
            if (anterior != " " && anterior != "\n" && anterior != "") {
                if (som_atual != noone) {
                    audio_stop_sound(som_atual);
                }

                som_atual = audio_play_sound(snd_Escrevendo_2, 10, false);
            }
        } else if (letra != "\n" && letra != "") {
            if (som_atual != noone) {
                audio_stop_sound(som_atual);
            }

            som_atual = audio_play_sound(snd_Escrevendo_1, 10, false);
        }
    }

    ultimo_caractere = caractere_atual;
}