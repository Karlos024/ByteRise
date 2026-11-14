if (tutorial_melhoria_ativo() || tutorial_missoes_ativo()) exit;
var _guia_f2_ativo = ativo;
var _abertura = _guia_f2_ativo && etapa == 0 && room == rm_Tela_principal_2;

//PERSONAGENS
with (obj_psn_Principal_2) visible = !_abertura;

pulsacao+=min(delta_time/1000000,0.05); espera=max(0,espera-min(delta_time/1000000,0.05)); var _x=device_mouse_x_to_gui(0),_y=device_mouse_y_to_gui(0);
if(!ativo) exit;
if(espera>0)exit;
if(mouse_check_button_released(mb_left)&&point_in_rectangle(_x,_y,270,8,352,46)){ativo=false;global.tutorial_f2_concluido=true;exit;}
switch(etapa){case 1:if(room==rm_up_Gerais_2)avancar();break;case 2:if(room==rm_up_Especificos_2)avancar();break;case 3:if(global.hd_ssd>0)avancar();break;case 4:if(room==rm_Tela_principal_2)avancar();break;case 6: tutorial_f2_pratica(id); break;default:tutorial_continuar(id,_x,_y);break;}
