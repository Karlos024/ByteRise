melhoria_diagnosticar_step();
if (!variable_instance_exists(id, "tempo_salvamento_auto")) tempo_salvamento_auto = 0;
tempo_salvamento_auto += max(0, delta_time);

// No Android executa antes de o runner suspender o jogo.
var _pausando = os_is_paused();
if (tempo_salvamento_auto >= 3000000 || _pausando) {
    tempo_salvamento_auto = 0;

    // Evita recriar o arquivo logo depois de um reset; salva qualquer progresso real.
    var _tem_progresso = global.progresso_salvo
        || global.moedas > 0
        || global.experiencia_atual > 0
        || global.nivel > 1
        || global.total_cliques > 0
        || global.comprada_2
        || global.comprada_3
        || global.internet > 0
        || global.funcionario_1 > 0
        || global.cenario_1 > 0
        || global.energia > 0
        || global.funcionario_2 > 0
        || global.cenario_2 > 0
        || global.cafe > 0
        || global.funcionario_3 > 0
        || global.transporte > 0
        || global.fliperama_1 > 0
        || global.fliperama_2 > 0
        || global.fliperama_3 > 0
        || global.hd_ssd > 0
        || global.gpu > 0
        || global.psu > 0
        || global.celular > 0
        || global.tablet > 0
        || global.notebook > 0;

    if (_tem_progresso) exportar_progresso(false);
}
