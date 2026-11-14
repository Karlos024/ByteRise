// PRIMEIRA META CONCLUIDA - SOMENTE AS TRES MISSOES DA FASE 1.
function tutorial_missao_observar() {
    if (!variable_global_exists("tutorial_missao_concluido")) global.tutorial_missao_concluido = false;
    if (!variable_global_exists("tutorial_missao_pendente")) global.tutorial_missao_pendente = -1;
    if (global.tutorial_missao_concluido) return;
    var _pendente = global.tutorial_missao_pendente;
    if (_pendente == 3 || _pendente == 4 || _pendente == 5) return;
    global.tutorial_missao_pendente = -1;
    if (!variable_global_exists("ms_patentes")) return;
    var _casa = variable_global_exists("ms_casa_atendimentos") ? global.ms_casa_atendimentos : 0;
    var _vip = variable_global_exists("ms_vip_atendimentos") ? global.ms_vip_atendimentos : 0;
    var _fliperamas = ["fliperama_1","fliperama_2","fliperama_3"];
    var _turbo = 0;
    for (var _i = 0; _i < 3; _i++) {
        if (variable_global_exists(_fliperamas[_i])) _turbo += clamp(variable_global_get(_fliperamas[_i]), 0, 15);
    }
    var _progressos = [_casa, _turbo, _vip];
    var _metas = [[10,100,300],[5,15,30],[20,50,100]];
    for (var _i = 0; _i < 3; _i++) {
        var _patente = global.ms_patentes[3 + _i];
        if (_patente < 3 && _progressos[_i] >= _metas[_i][_patente]) {
            global.tutorial_missao_pendente = 3 + _i;
            return;
        }
    }
}

function tutorial_missoes_tela_ativa() {
    return instance_exists(obj_btn_Carreira)
        && (room == rm_Tela_principal_1 || room == rm_Tela_principal_2 || room == rm_Tela_principal_3);
}
function tutorial_missoes_ativo() {
    if (!instance_exists(obj_Tutorial_interativo_missoes)) return false;
    var _guia = instance_find(obj_Tutorial_interativo_missoes, 0);
    return _guia.ativo && _guia.visible && tutorial_missoes_tela_ativa();
}

function tutorial_missao_iniciar_pendente() {
    if (!tutorial_missoes_tela_ativa()) return;
    if (global.tutorial_missao_concluido || global.tutorial_missao_pendente < 3 || tutorial_missoes_ativo()) return;
    if (tutorial_melhoria_ativo() || f3_tutorial_ativo()) return;
    if (instance_exists(obj_Tutorial_interativo_1) && obj_Tutorial_interativo_1.ativo) return;
    if (instance_exists(obj_Tutorial_interativo_2) && obj_Tutorial_interativo_2.ativo) return;
    if (instance_exists(obj_ctld_Configuracoes) && obj_ctld_Configuracoes.exibir_config) return;
    if (instance_exists(obj_ctld_Troca) && obj_ctld_Troca.exibir_troca_fase) return;
    // A CENTRAL E SEU BOTAO ESTAO NAS TELAS PRINCIPAIS, NAO NAS TELAS DE COMPRA.
    if (!instance_exists(obj_btn_Carreira) || !instance_exists(obj_ctld_Carreira)) return;
    if (instance_exists(obj_Tutorial_interativo_missoes)) {
        var _guia = instance_find(obj_Tutorial_interativo_missoes, 0);
        _guia.iniciar();
    }
}

// O CONTROLADOR DE MISSOES USA AREAS CLICAVEIS, EM VEZ DE OBJETOS SEPARADOS.
function tutorial_missao_clique_permitido(_x, _y) {
    if (!tutorial_missoes_ativo()) return true;
    var _guia = instance_find(obj_Tutorial_interativo_missoes, 0);
    if (_guia.espera > 0) return false;
    if (_guia.etapa == 2) return point_in_rectangle(_x,_y,99,241,131,259);
    if (_guia.etapa == 3 && instance_exists(obj_ctld_Missao) && obj_ctld_Missao.categoria == 1) {
        var _my = 310 + (_guia.missao - 3) * 70;
        return point_in_rectangle(_x,_y,225,_my-10,265,_my+30);
    }
    return false;
}

// CHAMADO SO DEPOIS QUE O RESGATE ORIGINAL JA APLICOU O BONUS.
function tutorial_missao_resgatada(_indice) {
    if (_indice != 3 && _indice != 4 && _indice != 5) return;
    if (global.tutorial_missao_concluido || global.tutorial_missao_pendente != _indice) return;
    global.tutorial_missao_concluido = true;
    global.tutorial_missao_pendente = -1;
    exportar_progresso(false);
}
