//VERIFICA SE AS CONFIGURAÇÕES ESTÁ ABERTA
var Config_Aberta = false;
if (instance_exists(obj_ctld_Configuracoes)) {
    Config_Aberta = obj_ctld_Configuracoes.exibir_config;
}

if (Config_Aberta == true) {
    if (instance_exists(Painel)) { instance_destroy(Painel); }
    Painel = noone;
    Botao  = noone;
    exit;
}

if (!variable_global_exists("es")) { global.es = true; }
	if (mouse_check_button_pressed(mb_left)) {
       var inst_Botao = instance_position(mouse_x, mouse_y, obj_btn_Informacao);
    
    if (inst_Botao != noone) {   
        //1 CASO CLICA NO BOTÃO É PRA FECHAR
        if (Botao == inst_Botao) {
            if (instance_exists(Painel)) { instance_destroy(Painel); }
            Painel = noone;
            Botao  = noone;
        } 
        
        //2 CASO CLICOU EM OUTRO BOTÃO É PRA FECHAR
        else {
            if (instance_exists(Painel)) {
                instance_destroy(Painel); }

            Botao = inst_Botao;
            
            //FUNDO DA INFORMAÇÃO
            Painel = instance_create_depth(inst_Botao.x + 40, inst_Botao.y, -10, obj_ctld_Tela_aprimoramentos_fundo);
            var txt_Final = ""; 
            var Upgrade = round((inst_Botao.y - 145) / 146);

      
            //GERAIS 1
            if (room == rm_up_Gerais_1) {
                var txt_Internet     = ["Aumente   a   velocidade   dos   fliperamas   para   realizar   ciclos   mais   rápidos   e   automatizar   o   jogo.", "Increase   arcade   speed   to   achieve   faster   cycles   and   automate   the   game.", "Aumenta   la   velocidad   de   los   arcades   para   realizar   ciclos   más   rápidos   y   automatizar   el   juego."];
                var txt_Funcionario1 = ["Contrate   funcionários   para   automatizar   o   atendimento   e   direcionar   os   clientes,   acelerando   o   fluxo   do   jogo.", "Hire   employees   to   automate   customer   service   and   direct   players,   speeding   up   the   game   flow.", "Contrata   empleados   para   automatizar   la   atención   y   dirigir   a   los   clientes,   acelerandod   el   flujo   del   juego."];
                var txt_Cenario1     = ["Melhore   o   cenário   da   Lan   House   para   deixá-la   mais   atrativa   e   atrair   mais   clientes.", "Upgrade   the   Lan   House   decor   to   make   it   more   attractive   and   draw   more   customers.", "Mejora   el   escenario   de   la   Lan   House   para   hacerla   más   atractiva   y   atraer   más   clientes."];
                if (Upgrade == 0) {
                    txt_Final = txt_Internet[global.idm];
                } else if (Upgrade == 1) {
                    txt_Final = txt_Funcionario1[global.idm];
                } else if (Upgrade == 2) {
                    txt_Final = txt_Cenario1[global.idm];
                }
            }
			
			//ESPECÍFICOS 1
            else if (room == rm_up_Especificos_1) {
                var txt_Cube     = ["Melhore   o   Cube   World   para   atualizar   seu   design   básico   e   aumentar   a   taxa   inicial      de   moedas   e   XP   por   cliente   atendido.", "Upgrade   Cube   World   to   update   its   basic   design   and   increase   the   initial   rate   of   coins   and   XP   per   customer   served.", "Mejora   Cube   World   para   actualizar   su   diseño   básico   y   aumentar   la   tasa   inicial   de   monedas   y   XP   por   cliente   atendido."];
                var txt_Alfredos = ["Aprimore   o   fliperama   Alfredo's   para   modernizar   o   design   do   gabinete   e   garantir   um   retorno   moderado   e   estável   de   moedas   e   XP.", "Upgrade   the   Alfredo's   arcade   to   modernize   the   cabinet   design   and   ensure   a   moderate   and   stable   return   of   coins   and   XP.", "Mejora    el    arcade    Alfredo's    para    modernizar    el    diseño    del    gabinete   y   garantizar   un   retorno   moderado   y   estable   de   monedas   y   XP."];
                var txt_Pocket   = ["Evolua   o   Pocket   Monsters   para   liberar   o   design   mais   robusto   e   alcançar   o   multiplicador   máximo   de   ganhos   em   moedas   e   XP.", "Evolve   Pocket   Monsters   to   unlock   the   most   robust   design   and   reach   the   maximum   multiplier   for   coin   and   XP   gains.", "Evoluciona   Pocket   Monsters   para   desbloquear   el   diseño   más   robusto   y   alcanzar   el   multiplicador   máximo   de   ganancias   en   monedas   y   XP."];
                if (Upgrade == 0) {
                    txt_Final = txt_Cube[global.idm];
                } else if (Upgrade == 1) {
                    txt_Final = txt_Alfredos[global.idm];
                } else if (Upgrade == 2) {
                    txt_Final = txt_Pocket[global.idm];
                }
            }
            
            //GERAIS 2
            else if (room == rm_up_Gerais_2) {
                var txt_Energia      = ["Aumente   a   rede   elétrica   para   ampliar   o   limite   de   potência   e   acelerar   os   equipamentos   de   conserto.", "Expand   the   power   grid   to   expand   the   power   limit   and   accelerate   the   repair   equipment.", "Aumenta   la   red   eléctrica   para   ampliar   el   límite   de   potencia   y   acelerar   los   equipos   de   reparación."];
                var txt_Funcionario2 = ["Contrate   funcionários   na   assistência   técnica   para   automatizar   o   atendimento   e   os   consertos   do   jogo.", "Hire   technical   assistance   staff   to   automate   game   customer   service   and   repairs.", "Contrata   empleados   en   asistencia   técnica   para   automatizar   la   atención   y   reparaciones   del   juego."];
                var txt_Cenario2     = ["Melhore   o   cenário   da   assistência   técnica   para   deixá-la   mais   moderna,   organizada   e   atrativa.", "Upgrade   the   technical   assistance   decor   to   make   it   more   modern,   organized,   and   attractive.", "Mejora   el   escenario   de   asistencia   técnica   para   hacerla   más   moderna,   organizada   y   atractiva."];
                if (Upgrade == 0) {
                    txt_Final = txt_Energia[global.idm];
                } else if (Upgrade == 1) {
                    txt_Final = txt_Funcionario2[global.idm];
                } else if (Upgrade == 2) {
                    txt_Final = txt_Cenario2[global.idm];
                }
            }
			
			//ESPECÍFICOS 2
            else if (room == rm_up_Especificos_2) {
                var txt_HD_SSD = ["Melhore   a   área   de   HD/SSD   para   atualizar   seus   equipamentos   básicos   e   agilizar   a   manutenção   dessas   memórias   secundárias   essenciais.", "Upgrade   the   HD/SSD   area   to   update   its   basic   equipment   and   speed   up   the   maintenance   of   these   essential   secondary   memories.", "Mejora   el   área   de   HD/SSD   para      actualizar   sus   equipos   básicos   y   agilizar   el   mantenimiento   de   estas   memorias   secundarias   esenciales"];
                var txt_PSU    = ["Aprimore   a   área   da   fonte   para   modernizar   as   ferramentas   de   teste   e   garantir   um   conserto   mais   estável   dos   conversores   de   energia.", "Upgrade   the   PSU   area   to   modernize   testing   tools   and   ensure   a   more   stable   repair   of   power   converters.", "Mejora   el   área   de   la   fuente   para   modernizar   las   herramientas   de   prueba   y   garantizar   una   reparación   más      estable   de   los   convertidores   de   energía."];
                var txt_GPU    = ["Evolua   a   área   da   placa   de   vídeo   para   liberar   equipamentos   avançados   e   alcançar   a   eficiência   máxima   no   reparo   dos   processadores   visuais.", "Evolve   the   GPU   area   to   unlock   advanced   equipment   and   reach   maximum   efficiency   in   repairing   visual   processors.", "Evoluciona   el   área   de   la   placa   de   video   para   desbloquear   equipos   avanzados   y   alcanzar   la   máxima   eficiencia   en   la   reparación   de   procesadores   visuales."];    
                if (Upgrade == 0) {
                    txt_Final = txt_HD_SSD[global.idm];
                } else if (Upgrade == 1) {
                    txt_Final = txt_PSU[global.idm];
                } else if (Upgrade == 2) {
                    txt_Final = txt_GPU[global.idm];
                }
            }
            
            //GERAIS 3
            else if (room == rm_up_Gerais_3) {
                var txt_Cafe         = ["Aumente   o   serviço   de   café   para   otimizar   a   velocidade   da   equipe   e   acelerar   todos   os   progressos.", "Boost   the   coffee   service   to   optimize   staff   speed   and   accelerate   all   game   progress.", "Aumenta   el   servicio   de   café   para   optimizar   la   velocidad   del   equipo   y   acelerar   todos   los   progresos."];
                var txt_Funcionario3 = ["Contrate   funcionários   de   carregamento   para   automatizar   o   transporte   de   caixas   e   acelerar   todos   os   processos.", "Hire   loading   staff   to   automate   box   transportation   and   speed   up   all   game   processes.", "Contrata   empleados   de   carga   para   automatizar   el   transporte   de   cajas   y   acelerar   todos   los   procesos."];
                var txt_Transporte   = ["Melhore   os   veículos   de   transporte   para   expandir   as   vagas,   carregar   mais   caixas   e   lucrar   mais   rápido.", "Upgrade   the   transport   vehicles   to   expand slots,   carry   more   boxes,   and   profit   faster.", "Mejora   los   vehículos   de   transporte   para   expandir   los   espacios,   cargar   más   cajas   y   ganar   más   rápido."];
                if (Upgrade == 0) {
                    txt_Final = txt_Cafe[global.idm];
                } else if (Upgrade == 1) {
                    txt_Final = txt_Funcionario3[global.idm];
                } else if (Upgrade == 2) {
                    txt_Final = txt_Transporte[global.idm];
                }
            }
			
			//ESPECÍFICOS 3
            else if (room == rm_up_Especificos_3) {
                var txt_Celular  = ["Melhore   a   bancada   de   celulares   para   evoluir   o   suporte   básico   do   montador   e   aumentar   os   lucros   iniciais   com   esses   dispositivos.", "Upgrade   the   cell   phone   bench   to   evolve   the   assembler's   basic   support   and   increase   initial   profits   with   these   devices.", "Mejora   el   banco   de   celulares   para   evolucionar   el   soporte   básico   del   montador   y   aumentar   las   ganancias   iniciales   con   estos   dispositivos."];
                var txt_Tablet   = ["Aprimore   a   bancada   de   tablets   para   modernizar   as   ferramentas   do   montador   e   garantir   uma   qualidade   serviço   mais   estável   e   lucrativa.", "Upgrade   tablet   bench   to   modernize   the   assembler's   tool   sand   ensure   a   more   stable   and   profitable   service   quality.", "Mejora   el   banco   de   tablets   para   modernizar   las   herramientas   del   montador   y   garantizar   una   calidad   de   servicio   más   estable   y   lucrativa."];
                var txt_Notebook = ["Evolua   a   bancada   de   notebooks   para   liberar   equipamentos   avançados   para   o   montador   e   alcançar   a   qualidade   máxima   e   lucros   extremos.", "Evolve   the   notebook   bench   to   unlock   advanced   equipment   for   the   assembler   and   reach   maximum   quality   and   extreme   profits.", "Evoluciona   el   banco   de   notebooks   para   desbloquear   equipos   avanzados   para   el   montador   y   alcanzar   la   máxima   calidad   y   ganancias   extremas."];
                if (Upgrade == 0) {
                    txt_Final = txt_Celular[global.idm];
                } else if (Upgrade == 1) {
                    txt_Final = txt_Tablet[global.idm];
                } else if (Upgrade == 2) {
                    txt_Final = txt_Notebook[global.idm];
                }
            }
            
            //MOSTRAR OS TEXTOS
            Painel.Texto_exibido = txt_Final;
        }
    }
}