if (instance_number(obj_Tutorial_interativo_3) > 1) {
    instance_destroy();
    exit;
}

persistent = true;
depth = -15000;   
ativo = false;
etapa = 0;
espera = 0.2;
montados_inicio = 0;
pulsacao = 0;
//ALVOS
alvo_objeto = function() {
    switch (etapa) {
        case 1: return obj_btn_Tela_aprimoramentos_fora_3;
        case 2: return obj_btn_Tela_up_especificos_fora_3;
        case 3: return obj_btn_md_Celular;
        case 4: return obj_btn_md_Tablet;
        case 5: return obj_btn_md_Notebook;
        case 6: return obj_btn_Tela_principal_fora_3;
    }
    return noone;
};

avancar = function() {
    etapa++;
    if (etapa == 8) etapa = 9; 
    espera = 0.2;
    if (etapa == 7) {
        montados_inicio = global.f3_total_montados;
        global.cam3_y = 0;
    }
    if (etapa == 10) global.cam3_y = 360;
    if (etapa == 11) global.cam3_y = 640;
    
    if (etapa > 11) {
        ativo = false;
        global.tutorial_f3_concluido = true;
    }
};
//ÁREA DO ALVO
retangulo_alvo = function() {
    var _obj = alvo_objeto();
    if (_obj != noone && instance_exists(_obj)) {
        var _inst = instance_find(_obj, 0);
        return [max(2, _inst.bbox_left - 5), max(2, _inst.bbox_top - 5), min(358, _inst.bbox_right + 5), min(638, _inst.bbox_bottom + 5)];
    }
    switch (etapa) {
        case 7: return [42, 270, 315, 570];
        case 8: return [270, 260, 345, 570];
        case 9: return [15, 260, 345, 565];
        case 10: return [65, 265, 220, 440];
        case 11: return [10, 235, 350, 365];
    }
    return [35, 260, 325, 560];
};
//TÍTULOS
textos = [
    ["BEM-VINDO À FÁBRICA", "WELCOME TO THE FACTORY", "BIENVENIDO A LA FÁBRICA"],
    ["ABRA AS MELHORIAS", "OPEN UPGRADES", "ABRE LAS MEJORAS"],
    ["ESCOLHA ESPECÍFICOS", "CHOOSE SPECIFIC", "ELIGE ESPECÍFICAS"],
    ["LIBERE O CELULAR", "UNLOCK PHONES", "DESBLOQUEA CELULARES"],
    ["LIBERE O TABLET", "UNLOCK TABLETS", "DESBLOQUEA TABLETAS"],
    ["LIBERE O NOTEBOOK", "UNLOCK LAPTOPS", "DESBLOQUEA PORTÁTILES"],
    ["VOLTE À FÁBRICA", "BACK TO THE FACTORY", "VUELVE A LA FÁBRICA"],
    ["MONTE UM DISPOSITIVO", "ASSEMBLE A DEVICE", "MONTA UN DISPOSITIVO"],
    ["RECOLHIMENTO", "COLLECTION", "RECOGIDA"],
    ["EXPLORE A TELA", "EXPLORE THE SCREEN", "EXPLORA LA PANTALLA"],
    ["ESTEIRA AUTOMÁTICA", "AUTOMATIC CONVEYOR", "CINTA AUTOMÁTICA"],
    ["ENVIE OS PEDIDOS", "SHIP YOUR ORDERS", "ENVÍA LOS PEDIDOS"],
];
//DESCRIÇÕES
descricoes = [
    ["Vamos praticar: abrir bancadas, montar e acompanhar o envio. Toque apenas no alvo iluminado.", "Let's open workbenches, assemble and follow shipping. Tap the highlighted target.", "Abre bancos, monta y sigue el envío. Toca el objetivo iluminado."],
    ["Toque em Aprimoramentos na barra inferior.", "Tap Upgrades on the bottom bar.", "Toca Mejoras en la barra inferior."],
    ["Abra a aba de melhorias específicas dos dispositivos.", "Open the device-specific upgrades tab.", "Abre la pestaña de mejoras de dispositivos."],
    ["Toque no botão do celular. A primeira bancada é grátis e já vem com montador.", "Tap the phone button. The first workbench and assembler are free.", "Toca el celular. El primer banco con montador es gratis."],
    ["Agora libere a primeira bancada de tablets, também gratuita.", "Now unlock the first tablet workbench, also free.", "Desbloquea el primer banco de tabletas, también gratis."],
    ["Libere a bancada gratuita de notebooks. Cada tipo pode ter até três bancadas.", "Unlock the free laptop workbench. Each type can have three workbenches.", "Desbloquea el banco gratis de portátiles. Cada tipo puede tener tres bancos."],
    ["Toque em Principal para ver os seus montadores trabalhando.", "Tap Main to see your assemblers at work.", "Toca Principal para ver a los montadores."],
    ["Toque na área iluminada até completar uma montagem. Os toques ajudam todas as bancadas ativas.", "Tap the highlighted area to complete a device. Taps help all active workbenches.", "Toca el área iluminada hasta completar un dispositivo. Ayudas a todos los bancos activos."],
    ["O exportador recolhe dispositivos do mesmo tipo e leva à esteira. Café automatiza a equipe; toques aceleram as tarefas.", "The collector takes devices of one type to the belt. Coffee automates the team; taps speed up tasks.", "El recolector lleva dispositivos del mismo tipo a la cinta. El café automatiza al equipo."],
    ["Arraste a cena para cima para ver o estacionamento. No computador, também pode usar a roda do mouse.", "Drag the scene upward to see the parking area. You can also use the mouse wheel.", "Arrastra la escena hacia arriba para ver el aparcamiento. También puedes usar la rueda."],
    ["A esteira leva as caixas automaticamente. No nível máximo de Funcionários, ela entrega direto aos veículos.", "The conveyor moves boxes automatically. At the top Staff level, it delivers straight to vehicles.", "La cinta mueve cajas automáticamente. Con Personal al máximo, entrega directo a los vehículos."],
    ["O encomendador carrega os veículos. Quando estão cheios, saem e geram moedas e XP. Transporte amplia a frota.", "Loaders fill the vehicles. Full vehicles depart and earn coins and XP. Transport expands your fleet.", "Los cargadores llenan los vehículos. Al salir generan monedas y XP. Transporte amplía la flota."],
];