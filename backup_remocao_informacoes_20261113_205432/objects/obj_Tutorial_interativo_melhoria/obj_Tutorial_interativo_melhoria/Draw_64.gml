// O CONTROLADOR COMUM DESENHA POR ULTIMO. MANTEM ESTE EVENTO COMO FALLBACK.
if (instance_exists(obj_ctld_Configuracoes)) exit;
if (!tutorial_melhoria_ativo()) exit;
ocultar_caixa = melhoria_descricao_alvo() == alvo;
tutorial_desenhar(id, 0);
// A DESCRICAO FICA ACIMA DO ESCURECIMENTO E NUNCA COBRE OUTRO QUADRO.
melhoria_desenhar_descricao();
