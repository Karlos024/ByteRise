if (instance_number(object_index) > 1) { instance_destroy(); exit; }
persistent = true;
depth = -15400;
ativo = false;
etapa = 0;
etapa_final = 4;
espera = 0.2;
pulsacao = 0;
tutorial_extra = true;
ocultar_caixa = false;
missao = -1;
patente_inicio = 0;
if (!variable_global_exists("tutorial_missao_concluido")) global.tutorial_missao_concluido = false;
if (!variable_global_exists("tutorial_missao_pendente")) global.tutorial_missao_pendente = -1;

alvo_objeto = function() {
    if (etapa == 1) return obj_btn_Carreira;
    if (etapa == 2 || etapa == 3) return obj_ctld_Missao;
    return noone;
};
retangulo_alvo = function() {
    if (etapa == 2) return [92,232,138,268];
    if (etapa == 3 || etapa == 4) {
        var _y = 310 + (missao - 3) * 70;
        return [218,_y-17,272,_y+37];
    }
    if (instance_exists(obj_btn_Carreira)) {
        var _b = instance_find(obj_btn_Carreira, 0);
        return [max(2,_b.bbox_left-7),max(2,_b.bbox_top-7),min(358,_b.bbox_right+7),min(638,_b.bbox_bottom+7)];
    }
    return [8,68,58,128];
};
iniciar = function() {
    missao = global.tutorial_missao_pendente;
    patente_inicio = global.ms_patentes[missao];
    if (instance_exists(obj_ctld_Missao)) {
        obj_ctld_Missao.exibir_desafio = false;
        obj_ctld_Missao.exibir_missao = -1;
    }
    global.bloquear_clique_celular = false;
    etapa = 0;
    espera = 0.2;
    ativo = true;
    var _nomes = [["Casa Lotada","Crowded House","Casa Llena"],["Fliperama Turbo","Turbo Arcade","Recreativas Turbo"],["Freguesia VIP","VIP Customers","Clientes VIP"]];
    for (var _idm = 0; _idm < 3; _idm++) {
        descricoes[0][_idm] = ["Você completou ","You completed ","Completaste "][_idm] + _nomes[missao-3][_idm]
            + ["! Vamos resgatar a recompensa na central de missões.","! Let's claim its reward in the mission hub.",". Vamos a recoger su recompensa en la central de misiones."][_idm];
    }
    tutorial_som();
};
concluir = function() {
    ativo = false;
    global.tutorial_missao_concluido = true;
    global.tutorial_missao_pendente = -1;
    exportar_progresso(false);
};
avancar = function() {
    etapa++;
    espera = 0.2;
    if (etapa > etapa_final) concluir();
};
textos = [
    ["MISSÃO COMPLETA!","MISSION COMPLETE!","¡MISIÓN COMPLETA!"],
    ["ABRA AS MISSÕES","OPEN MISSIONS","ABRE LAS MISIONES"],
    ["ESCOLHA A FASE 1","CHOOSE PHASE 1","ELIGE LA FASE 1"],
    ["PEGUE SUA RECOMPENSA","CLAIM YOUR REWARD","RECOGE TU RECOMPENSA"],
    ["RECOMPENSA ATIVADA!","REWARD ACTIVATED!","¡RECOMPENSA ACTIVADA!"]
];
descricoes = [
    ["Vamos resgatar sua primeira recompensa.","Let's claim your first reward.","Vamos a recoger tu primera recompensa."],
    ["Toque no celular destacado para abrir a central de missões.","Tap the highlighted phone to open the mission hub.","Toca el teléfono destacado para abrir la central de misiones."],
    ["Toque na categoria da fase 1. Ela reúne Casa Lotada, Fliperama Turbo e Freguesia VIP.","Tap the phase 1 category. It contains Crowded House, Turbo Arcade and VIP Customers.","Toca la categoría de la fase 1. Contiene Casa Llena, Recreativas Turbo y Clientes VIP."],
    ["A meta está completa. Toque no botão de resgate destacado para ativar o bônus temporário desta missão.","The goal is complete. Tap the highlighted claim button to activate this mission's temporary bonus.","La meta está completa. Toca el botón destacado para activar el bono temporal de esta misión."],
    ["O bônus já está valendo! Resgate outras recompensas por esse mesmo caminho. Este tutorial não vai se repetir.","Your bonus is active! Claim other rewards through this same menu. This tutorial will not repeat.","¡El bono ya está activo! Recoge otras recompensas por este mismo camino. Este tutorial no se repetirá."]
];
