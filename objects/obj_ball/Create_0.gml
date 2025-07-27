#region VELOCIDADES INICIAIS
vel_x = choose(-4, 4);
vel_y = random_range(-3, 3);

if (abs(vel_y) < 1) {
    vel_y = choose(-2, 2);
}
#endregion

#region CONTROLE DE PONTUAÇÃO
ponto_ja_marcado = false;
tempo_reset = 0;
esperando_reset = false;
#endregion
