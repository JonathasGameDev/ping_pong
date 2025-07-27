#region SISTEMA DE RODADAS E PONTOS
if (!variable_global_exists("rodadas_para_vencer")) {
    global.rodadas_para_vencer = 3;
    global.pontos_por_rodada = 5;
}

if (!variable_global_exists("rodada_atual")) {
    global.rodada_atual = 1;
    global.rodadas_vencidas_p1 = 0;
    global.rodadas_vencidas_p2 = 0;
}

if (!variable_global_exists("pontos_p1")) {
    global.pontos_p1 = 0;
    global.pontos_p2 = 0;
}

pontos_player1 = global.pontos_p1;
pontos_player2 = global.pontos_p2;
rodadas_p1 = global.rodadas_vencidas_p1;
rodadas_p2 = global.rodadas_vencidas_p2;
rodada_atual = global.rodada_atual;
#endregion

#region CONTROLE DE ANIMAÇÕES
fazendo_animacao = false;
alpha_tela = 0;
tempo_animacao = 0;
duracao_animacao = 240;
ultimo_gol = "";
fim_de_rodada = false;
vencedor_partida = "";
partida_finalizada = false;
#endregion

#region FEEDBACK DE PONTOS
ultimo_ponto_p1 = 0;
ultimo_ponto_p2 = 0;
mostrando_ponto = false;
tempo_ponto = 0;
#endregion

#region CONFIGURAÇÃO DO MODO DE JOGO
if (!variable_global_exists("modo_jogo")) {
    global.modo_jogo = "ia";
    global.dificuldade_escolhida = 2;
}
#endregion

#region CONTROLE DE PAUSA
pode_pausar = false;
frames_iniciais = 0;
jogo_pausado = false;
#endregion

#region FUNÇÃO DE RESET DAS RAQUETES
function resetar_posicoes_raquetes() {
    if (instance_exists(obj_racket)) {
        obj_racket.x = obj_racket.pos_inicial_x;
        obj_racket.y = obj_racket.pos_inicial_y;
        obj_racket.velocidade_boost = 0;
        obj_racket.tempo_boost = 0;
    }
    
    if (instance_exists(obj_racket_opponent)) {
        obj_racket_opponent.x = obj_racket_opponent.pos_inicial_x;
        obj_racket_opponent.y = obj_racket_opponent.pos_inicial_y;
        obj_racket_opponent.velocidade_boost = 0;
        obj_racket_opponent.tempo_boost = 0;
    }
}
#endregion
