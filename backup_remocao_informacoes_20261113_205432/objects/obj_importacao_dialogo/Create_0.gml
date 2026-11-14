persistent = true;
var txt_Pedido = ["Cole aqui o seu código de progresso exportado:", "Paste your exported progress code here:", "Pega aquí tu código de progreso exportado:"];
dialogo_id = get_string_async(txt_Pedido[clamp(global.idm, 0, 2)], "");