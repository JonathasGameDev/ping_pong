#region CONFIGURAÇÕES BÁSICAS
velocidade = 5;
velocidade_base = 5;
velocidade_boost = 0;
tempo_boost = 0;
velocidade_boost_max = 8;
#endregion

#region POSICIONAMENTO E CONTROLE DE ESTADO
pos_inicial_x = x;
pos_inicial_y = y;
pos_anterior_x = x;
pos_anterior_y = y;
velocidade_instantanea_x = 0;
velocidade_instantanea_y = 0;
pausado = false;
#endregion

#region INICIALIZAÇÃO DOS CONTROLES
if (!variable_global_exists("controle_p2_cima")) {
    global.controle_p2_cima = ord("I");
    global.controle_p2_baixo = ord("K");
    global.controle_p2_esquerda = ord("J");
    global.controle_p2_direita = ord("L");
}
#endregion

#region CONFIGURAÇÃO DO MODO DE JOGO
if (variable_global_exists("modo_jogo") && global.modo_jogo == "ia") {
    velocidade_ia = 2;
    dificuldade = global.dificuldade_escolhida;
    acabou_de_bater = false;
    tempo_recuo = 0;
    modo_controle = "ia";
    
    switch(dificuldade) {
        case 1:
            velocidade_ia = 1.5;
            velocidade_base = 4;
            break;
        case 2:
            velocidade_ia = 2;
            velocidade_base = 5;
            break;
        case 3:
            velocidade_ia = 3;
            velocidade_base = 6;
            break;
        case 4:
            velocidade_ia = 4;
            velocidade_base = 7;
            break;
        default:
            velocidade_ia = 2;
            velocidade_base = 5;
            break;
    }
    
    target_y = y;
    erro_ia = 0;
    tempo_reacao = 0;
    ultima_pos_bola_y = 0;
} else {
    modo_controle = "player2";
}
#endregion
