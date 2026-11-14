var txt_Texto = ["", "", ""];
switch (floor(image_index)) {

    case 0:
        txt_Texto = ["                              E  pensar  que  tudo  começou  com  uma  pequena  lan  house...  agora,  a  Byte  Rise  está  conquistando  o  MUNDO!", "                              And  to  think  it  all  started  with  a  small  lan  house...  now,  Byte  Rise  is  conquering  the  WORLD!", "                              Y  pensar  que  todo  empezó  con  un  pequeño  ciber...  ¡ahora,  Byte  Rise  está  conquistando  el  MUNDO!"];
        break;

    case 2:
        txt_Texto = ["                              Caramba...  olha  só  até  onde  eu  cheguei.", "                              Wow...  just  look  how  far  I've  come.", "                              Caramba...  mira  hasta  dónde  he  llegado."];
        break;

    case 3:
        txt_Texto = ["                              Bom...  missão  cumprida!", "                              Well...  mission  accomplished!", "                              Bueno...  ¡misión  cumplida!"];
        break;

    case 4:
        txt_Texto = ["                              Valeu  a  pena  cada  esforço  para  chegar  até  aqui.", "                              Every  effort  to  get  this  far  was  worth  it.", "                              Valió  la  pena  cada  esfuerzo  para  llegar  hasta  aquí."];
        break;

    case 5:
        txt_Texto = ["                              Tudo  aquilo  que  parecia  impossível  um  dia...  hoje  é  realidade.", "                              Everything  that  seemed  impossible  one  day...  today  is  reality.", "                              Todo  lo  que  parecía  imposible  un  día...  hoy  es  realidad."];
        break;

    case 6:
        txt_Texto = ["                              E  assim,  uma  ideia  simples  se  tornou  um  grande  sonho.", "                              And  so,  a  simple  idea  became  a  big  dream.", "                              Y  así,  una  idea  simple  se  convirtió  en  un  gran  sueño."];
        break;

    case 7:
        txt_Texto = ["                              FIM", "                              THE  END", "                              FIN"];
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