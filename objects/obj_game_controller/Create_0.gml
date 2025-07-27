// Inicializa variáveis globais de pontuação se não existirem
if (!variable_global_exists("pontos_p1")) {
    global.pontos_p1 = 0;
    global.pontos_p2 = 0;
}

// Usa as variáveis globais
pontos_player1 = global.pontos_p1;
pontos_player2 = global.pontos_p2;

// Variáveis para animação (sempre resetam)
fazendo_animacao = false;
alpha_tela = 0;
tempo_animacao = 0;
duracao_animacao = 240;
ultimo_gol = "";

// Configura baseado no modo escolhido
if (!variable_global_exists("modo_jogo")) {
    global.modo_jogo = "ia";
    global.dificuldade_escolhida = 2;
}

pode_pausar = false;
frames_iniciais = 0;
jogo_pausado = false;
