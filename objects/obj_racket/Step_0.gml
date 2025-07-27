// ===== SISTEMA DE BOOST =====
// Calcula velocidade atual baseada no boost
velocidade = velocidade_base + velocidade_boost;

// Diminui boost ao longo do tempo
if (tempo_boost > 0) {
    tempo_boost -= 1;
} else {
    velocidade_boost = max(velocidade_boost - 0.1, 0); // Diminui gradualmente
}

// ===== MOVIMENTO COM FALLBACK SEGURO =====
// Obtém teclas ou usa padrão se não existirem/forem inválidas
var t_up    = (variable_global_exists("controle_p1_cima") && global.controle_p1_cima > 0) ? global.controle_p1_cima : ord("W");
var t_down  = (variable_global_exists("controle_p1_baixo") && global.controle_p1_baixo > 0) ? global.controle_p1_baixo : ord("S");
var t_left  = (variable_global_exists("controle_p1_esquerda") && global.controle_p1_esquerda > 0) ? global.controle_p1_esquerda : ord("A");
var t_right = (variable_global_exists("controle_p1_direita") && global.controle_p1_direita > 0) ? global.controle_p1_direita : ord("D");

// Movimento usando as teclas seguras
if keyboard_check(t_up) {
    y -= velocidade;
}
if keyboard_check(t_down) {
    y += velocidade;
}
if keyboard_check(t_left) {
    x -= velocidade;
}
if keyboard_check(t_right) {
    x += velocidade;
}

// ===== LIMITES CORRIGIDOS =====
// Limites verticais
if (y <= 128) {  // Limite superior
    y = 128;
}
if (y >= 640) {  // Limite inferior  
    y = 640;
}

// Limites horizontais
if (x <= 128) {   // Limite esquerdo
    x = 128;
}
if (x >= 640) {   // Limite direito
    x = 640;
}
