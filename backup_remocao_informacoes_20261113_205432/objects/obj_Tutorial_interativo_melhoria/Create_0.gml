if (instance_number(object_index) > 1) { instance_destroy(); exit; }
persistent = true;
depth = -15200;
ativo = false;
etapa = 0;
espera = 0.2;
pulsacao = 0;
tutorial_extra = true;
ocultar_caixa = false;
alvo = noone;
campo = "";
nivel_inicio = 0;
leitura_demonstrada = false;
if (!variable_global_exists("tutorial_melhoria_concluido")) global.tutorial_melhoria_concluido = false;

alvo_objeto = function() {
    if ((etapa == 1 || etapa == 2) && instance_exists(alvo)) return alvo.object_index;
    return noone;
};
retangulo_alvo = function() {
    if (instance_exists(alvo)) return [max(2,alvo.bbox_left-7),max(2,alvo.bbox_top-7),min(358,alvo.bbox_right+7),min(638,alvo.bbox_bottom+7)];
    return [35,230,325,540];
};
concluir = function() {
    ativo = false;
    if (instance_exists(alvo)) {
        alvo.md_pressionado = false;
        alvo.image_xscale = 1;
        alvo.image_yscale = 1;
    }
    global.tutorial_melhoria_concluido = true;
    exportar_progresso(false);
};
avancar = function() {
    etapa++;
    espera = 0.2;
    if (etapa > 3) concluir();
};
textos = [
    ["VER O QUE A MELHORIA FAZ","SEE WHAT AN UPGRADE DOES","DESCUBRE QUÉ HACE LA MEJORA"],
    ["TOQUE E SEGURE","PRESS AND HOLD","TOCA Y MANTÉN"],
    ["AGORA COMPRE","NOW BUY THE UPGRADE","AHORA COMPRA"],
    ["PRONTO!","DONE!","¡LISTO!"]
];
descricoes = [
    ["Segure um botão de compra para ler seu efeito antes de gastar moedas. Vamos experimentar no botão destacado.","Hold a buy button to read its effect before spending coins. Let's try the highlighted button.","Mantén pulsado un botón de compra para leer su efecto antes de gastar monedas. Prueba el botón destacado."],
    ["Segure o botão por um instante até aparecer a descrição. Depois solte. A compra está bloqueada nesta etapa.","Hold the button until its description appears. Then release it. Purchasing is locked during this step.","Mantén el botón hasta que aparezca la descripción. Después suéltalo. La compra está bloqueada en este paso."],
    ["A descrição sumiu ao soltar. Agora dê um toque rápido no mesmo botão para comprar uma vez.","The description disappeared on release. Now give the same button a quick tap to buy once.","La descripción desapareció al soltar. Ahora toca brevemente el mismo botón para comprar una vez."],
    ["Use esse gesto em qualquer melhoria: segurar explica; um toque rápido compra. Toque Continuar para voltar ao jogo.","Use this gesture on any upgrade: hold to read; tap quickly to buy. Tap Continue to return to the game.","Usa este gesto en cualquier mejora: mantén para leer; toca brevemente para comprar. Toca Continuar para volver al juego."]
];
