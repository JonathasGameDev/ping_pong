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
#endregion

#region INICIALIZAÇÃO DOS CONTROLES
if (!variable_global_exists("controle_p1_cima")) {
    global.controle_p1_cima = ord("W");
    global.controle_p1_baixo = ord("S");
    global.controle_p1_esquerda = ord("A");
    global.controle_p1_direita = ord("D");
}
#endregion
