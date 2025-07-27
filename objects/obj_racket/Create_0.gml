velocidade = 5;
velocidade_base = 5;
velocidade_boost = 0;
tempo_boost = 0;

// ✨ FORÇA INICIALIZAÇÃO DOS CONTROLES DO PLAYER 1 (SEGURANÇA)
if (!variable_global_exists("controle_p1_cima") || global.controle_p1_cima <= 0) {
    global.controle_p1_cima = ord("W");
}
if (!variable_global_exists("controle_p1_baixo") || global.controle_p1_baixo <= 0) {
    global.controle_p1_baixo = ord("S");
}
if (!variable_global_exists("controle_p1_esquerda") || global.controle_p1_esquerda <= 0) {
    global.controle_p1_esquerda = ord("A");
}
if (!variable_global_exists("controle_p1_direita") || global.controle_p1_direita <= 0) {
    global.controle_p1_direita = ord("D");
}
