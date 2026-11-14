// O controlador comum desenha por ultimo. Mantem este evento como fallback.
if (instance_exists(obj_ctld_Configuracoes)) exit;
if (!tutorial_melhoria_ativo()) exit;
ocultar_caixa = melhoria_descricao_alvo() == alvo;
tutorial_desenhar(id, 0);
// A descricao fica acima do escurecimento e nunca cobre outro quadro.
melhoria_desenhar_descricao();
