image_speed = 0.15;

if (!variable_global_exists("creditos")) {
    global.creditos = false;
}

// SE FOR A PRIMEIRA VEZ ENTRANDO
if (global.creditos == false) {
    global.moedas += 67000;
    global.moedas_acumuladas += 67000;
    global.creditos = true;
}