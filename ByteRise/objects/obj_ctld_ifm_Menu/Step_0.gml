if (mouse_check_button_pressed(mb_left)) {
	
    //IDENTIFICA O BOTÃO CLICADO
    var inst_Botao = instance_position(mouse_x, mouse_y, obj_Tela_menu_moeda);
    var xp = false;
    
    if (inst_Botao == noone) {
        inst_Botao = instance_position(mouse_x, mouse_y, obj_Tela_menu_experiencia);
        if (inst_Botao != noone) { xp = true; }
    }
    
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
            Painel = instance_create_depth(200, 10, -10, obj_ctld_Menu_fundo);
            var txt_Final = "";
			
            if (xp == false) {
				
                //MOEDAS
                var txt_Explicacao = ["Ganhe  moedas  atendendo  clientes  e  use  elas  para  comprar  upgrades!", "Earn  coins  by  serving  customers  and  use  them  to  buy  upgrades!", "Ganando  por  atender  bien,  úsalas  para  comprar  mejoras."];
                txt_Final = txt_Explicacao[global.idm];
            } else {
				
                //EXPERIÊNCIA
                var txt_XP = ["Ganhe  experiência  ao  concluir  serviços  para  subir  de  nível  e  evoluir!", "Earn  experience  by  completing  services  to  level  up  and  evolve!", "¡Gana  experiencia  al  completar  servicios  para  subir  de  nivel!"];
                txt_Final = txt_XP[global.idm];
            }
            
            //MOSTRAR OS TEXTOS
            if (instance_exists(Painel)) {
                Painel.Texto_exibido = txt_Final; 
            }
        }
    } 
}