// O alvo pertence a uma room: ao sair, libera os controles sem marcar conclusao.
if (!melhoria_tela_ativa()) { ativo = false; alvo = noone; exit; }
if (ativo && !tutorial_melhoria_ativo()) { ativo = false; alvo = noone; }
if (tutorial_missoes_ativo()) exit;
pulsacao += min(delta_time / 1000000, 0.05);
espera = max(0, espera - min(delta_time / 1000000, 0.05));
if (instance_exists(obj_ctld_Configuracoes) && obj_ctld_Configuracoes.exibir_config) exit;
if (instance_exists(obj_ctld_Carreira) && obj_ctld_Carreira.exibir_progresso) exit;
if (instance_exists(obj_ctld_Troca) && obj_ctld_Troca.exibir_troca_fase) exit;

if (!ativo) {
    if (global.tutorial_melhoria_concluido) exit;
    // Seleciona apenas uma melhoria presente, permitida e com saldo suficiente.
    var _opcoes = [obj_btn_md_Cube,obj_btn_md_Alfredos,obj_btn_md_Pocket,
        obj_btn_md_HD_SSD,obj_btn_md_PSU,obj_btn_md_GPU,
        obj_btn_md_Celular,obj_btn_md_Tablet,obj_btn_md_Notebook,
        obj_btn_md_Internet,obj_btn_md_Funcionario_1,obj_btn_md_Cenario_1,
        obj_btn_md_Energia,obj_btn_md_Funcionario_2,obj_btn_md_Cenario_2,
        obj_btn_md_Cafe,obj_btn_md_Funcionario_3,obj_btn_md_Transporte];
    for (var _i = 0; _i < array_length(_opcoes); _i++) {
        var _botao = instance_find(_opcoes[_i], 0);
        if (_botao == noone || !melhoria_interacao_permitida(_botao)) continue;
        var _dados = melhoria_dados(_opcoes[_i]);
        var _nivel = variable_global_get(_dados.campo);
        var _precos = melhoria_precos(_opcoes[_i]);
        if (_nivel >= array_length(_precos) || global.moedas < _precos[_nivel]) continue;
        alvo = _botao;
        campo = _dados.campo;
        nivel_inicio = _nivel;
        leitura_demonstrada = false;
        // Um gesto iniciado antes do quadro nao pode atravessar o tutorial.
        alvo.md_pressionado = false;
        alvo.image_xscale = 1;
        alvo.image_yscale = 1;
        etapa = 0;
        espera = 0.2;
        ativo = true;
        tutorial_som();
        exit;
    }
    exit;
}

// Trocar de room ou importar um save nao deixa um alvo destruido prendendo o jogo.
if (!instance_exists(alvo)) { ativo = false; exit; }
if (espera > 0) exit;
var _x = device_mouse_x_to_gui(0), _y = device_mouse_y_to_gui(0);
if (device_mouse_check_button_released(0, mb_left) && point_in_rectangle(_x,_y,270,8,352,46)) {
    concluir();
    exit;
}
switch (etapa) {
    case 1:
        if (leitura_demonstrada && !device_mouse_check_button(0, mb_left)) {
            tutorial_som();
            avancar();
        }
        break;
    case 2:
        if (variable_global_get(campo) > nivel_inicio) {
            tutorial_som();
            avancar();
        }
        break;
    default:
        tutorial_continuar(id, _x, _y);
        break;
}
