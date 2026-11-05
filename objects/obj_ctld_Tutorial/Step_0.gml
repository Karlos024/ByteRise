//BOTÃO VOLTAR
if (instance_exists(obj_btn_Tutorial_voltar)) {
    obj_btn_Tutorial_voltar.visible = (atual > 0);
}

//BOTÃO PASSAR
if (instance_exists(obj_btn_Tutorial_passar)) {
    obj_btn_Tutorial_passar.visible = (atual < maximo);
}

//BOTÃO SAIR
if (instance_exists(obj_btn_Tutorial_sair)) {
    obj_btn_Tutorial_sair.visible = (atual == maximo);
}

//INDICADOR DE PÁGINAS
if (instance_exists(obj_Tutorial_pagina)) {
    obj_Tutorial_pagina.visible = (atual != -1);
}