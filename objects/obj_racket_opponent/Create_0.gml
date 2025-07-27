velocidade = 5;
velocidade_base = 5;
velocidade_boost = 0;
tempo_boost = 0;

// ✨ INICIALIZAÇÃO FORÇADA DOS CONTROLES (SEGURANÇA)
if (!variable_global_exists("controle_p2_cima")) {
    global.controle_p2_cima = ord("I");
    global.controle_p2_baixo = ord("K");
    global.controle_p2_esquerda = ord("J");
    global.controle_p2_direita = ord("L");
}

// Resto das suas variáveis existentes...
if (variable_global_exists("modo_jogo") && global.modo_jogo == "ia") {
    velocidade_ia = 2;
    dificuldade = global.dificuldade_escolhida;
    acabou_de_bater = false;
    tempo_recuo = 0;
    posicao_inicial_x = x;
    posicao_inicial_y = y;
    modo_controle = "ia";
} 
else {
    modo_controle = "player2";
}
