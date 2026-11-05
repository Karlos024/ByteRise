image_xscale = 1.9;
image_yscale = 0.9;

//ALTERNA A EXIBIÇÃO LIGA/DESLIGA DA TELA
if (instance_exists(obj_ctld_Configuracoes)) {
    with (obj_ctld_Configuracoes) {
        exibir_config = !exibir_config; 
        
        if (exibir_config == true) {
            other.image_index = 1;
			
            //LOCAL DOS BOTÕES
            btn_Idiomas         = instance_create_depth(179.461, 120, -10, obj_btn_Idioma);
            btn_Musica          = instance_create_depth(83.461,  200, -10, obj_btn_Musica);
            btn_Efeitos_sonoros = instance_create_depth(275.461, 200, -10, obj_btn_Efeitos_sonoros);
			btn_Creditos        = instance_create_depth(179.461, 320, -10, obj_btn_Creditos);
            btn_Creditos.image_xscale = 3;
            btn_Creditos.image_yscale = 1; 
            btn_Exportar        = instance_create_depth(83.461,  420, -10, obj_btn_Exportar);
            btn_Importar        = instance_create_depth(275.461, 420, -10, obj_btn_Importar);
			btn_Final           = instance_create_depth(179.461, 510, -10, obj_btn_Fim);
        } else {
            other.image_index = 0;
			
			if (instance_exists(btn_Idiomas))         { instance_destroy(btn_Idiomas); }
            if (instance_exists(btn_Musica))          { instance_destroy(btn_Musica); }
            if (instance_exists(btn_Efeitos_sonoros)) { instance_destroy(btn_Efeitos_sonoros); }
			if (instance_exists(btn_Creditos))        { instance_destroy(btn_Creditos); }
            if (instance_exists(btn_Exportar))        { instance_destroy(btn_Exportar); }
            if (instance_exists(btn_Importar))        { instance_destroy(btn_Importar); }
            if (instance_exists(btn_Final))           { instance_destroy(btn_Final); }
        }
    }
}