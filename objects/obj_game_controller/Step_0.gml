#region CONTROLE DE PAUSA
frames_iniciais += 1;
if (frames_iniciais > 15) {
    pode_pausar = true;
}

if (keyboard_check_pressed(vk_escape) && pode_pausar && !fazendo_animacao && !partida_finalizada) {
    if (!jogo_pausado) {
        jogo_pausado = true;
        
        instance_deactivate_all(true);
        instance_activate_object(obj_game_controller);
        
        if (!instance_exists(obj_pause_menu)) {
            instance_create_depth(0, 0, -1000, obj_pause_menu);
            instance_activate_object(obj_pause_menu);
        }
    }
}

if (jogo_pausado) {
    exit;
}
#endregion

#region DETECÇÃO DE PONTOS
if (global.pontos_p1 > ultimo_ponto_p1) {
    ultimo_ponto_p1 = global.pontos_p1;
    mostrando_ponto = true;
    tempo_ponto = 0;
    ultimo_gol = "PLAYER 1 MARCOU!";
}
else if (global.pontos_p2 > ultimo_ponto_p2) {
    ultimo_ponto_p2 = global.pontos_p2;
    mostrando_ponto = true;
    tempo_ponto = 0;
    ultimo_gol = "PLAYER 2 MARCOU!";
}

if (mostrando_ponto && !fazendo_animacao) {
    tempo_ponto++;
    if (tempo_ponto >= 90) {
        mostrando_ponto = false;
        ultimo_gol = "";
        tempo_ponto = 0;
    }
}

global.pontos_p1 = pontos_player1;
global.pontos_p2 = pontos_player2;
#endregion

#region VERIFICAÇÃO DE VITÓRIA DE RODADA
if (!fim_de_rodada && !fazendo_animacao && !partida_finalizada) {
    if (pontos_player1 >= global.pontos_por_rodada) {
        global.rodadas_vencidas_p1++;
        fim_de_rodada = true;
        ultimo_gol = "PLAYER 1 VENCEU A RODADA " + string(global.rodada_atual) + "! 🎉";
        fazendo_animacao = true;
        tempo_animacao = 0;
        duracao_animacao = 180;
        mostrando_ponto = false;
        
        resetar_posicoes_raquetes();
    }
    else if (pontos_player2 >= global.pontos_por_rodada) {
        global.rodadas_vencidas_p2++;
        fim_de_rodada = true;
        ultimo_gol = "PLAYER 2 VENCEU A RODADA " + string(global.rodada_atual) + "! 🎉";
        fazendo_animacao = true;
        tempo_animacao = 0;
        duracao_animacao = 180;
        mostrando_ponto = false;
        
        resetar_posicoes_raquetes();
    }
}
#endregion

#region VERIFICAÇÃO DE VITÓRIA DE PARTIDA
if (!fazendo_animacao && !partida_finalizada && global.rodadas_vencidas_p1 >= global.rodadas_para_vencer) {
    vencedor_partida = "PLAYER 1 VENCEU A PARTIDA!";
    ultimo_gol = vencedor_partida;
    fazendo_animacao = true;
    tempo_animacao = 0;
    duracao_animacao = 180;
    mostrando_ponto = false;
    partida_finalizada = true;
    
    if (instance_exists(obj_ball)) {
        obj_ball.vel_x = 0;
        obj_ball.vel_y = 0;
    }
}
else if (!fazendo_animacao && !partida_finalizada && global.rodadas_vencidas_p2 >= global.rodadas_para_vencer) {
    vencedor_partida = "PLAYER 2 VENCEU A PARTIDA! ";
    ultimo_gol = vencedor_partida;
    fazendo_animacao = true;
    tempo_animacao = 0;
    duracao_animacao = 180;
    mostrando_ponto = false;
    partida_finalizada = true;
    
    if (instance_exists(obj_ball)) {
        obj_ball.vel_x = 0;
        obj_ball.vel_y = 0;
    }
}
#endregion

#region FUNÇÃO DE RESUMIR JOGO
function resumir_jogo() {
    jogo_pausado = false;
    
    instance_activate_all();
    
    if (instance_exists(obj_pause_menu)) {
        instance_destroy(obj_pause_menu);
    }
}
#endregion

#region ANIMAÇÃO DE TRANSIÇÃO
if (fazendo_animacao) {
    tempo_animacao += 1;
    alpha_tela = tempo_animacao / duracao_animacao;
    
    if (tempo_animacao >= duracao_animacao) {
        fazendo_animacao = false;
        alpha_tela = 0;
        tempo_animacao = 0;
        
        if (vencedor_partida != "") {
            if (!instance_exists(obj_end_game_menu)) {
                instance_create_depth(0, 0, -1000, obj_end_game_menu);
            }
            vencedor_partida = "";
        }
        else if (fim_de_rodada) {
            global.rodada_atual++;
            global.pontos_p1 = 0;
            global.pontos_p2 = 0;
            pontos_player1 = 0;
            pontos_player2 = 0;
            fim_de_rodada = false;
            ultimo_gol = "";
            
            resetar_posicoes_raquetes();
            
            ultimo_ponto_p1 = 0;
            ultimo_ponto_p2 = 0;
            mostrando_ponto = false;
            tempo_ponto = 0;
            
            room_restart();
        }
    }
}
#endregion
