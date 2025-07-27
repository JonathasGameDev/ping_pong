// ✅ PROTEÇÃO: Contador para evitar pausa imediata
frames_iniciais += 1;
if (frames_iniciais > 15) {
    pode_pausar = true;
}

// ===== SISTEMA DE PAUSA CORRIGIDO =====
if (keyboard_check_pressed(vk_escape) && pode_pausar && !fazendo_animacao) {
    
    if (!jogo_pausado) {
        // ✨ PAUSAR O JOGO
        jogo_pausado = true;
        
        // Cria menu de pausa
        if (!instance_exists(obj_pause_menu)) {
            instance_create_layer(0, 0, "player", obj_pause_menu);
        }
        
        show_debug_message("PAUSADO - Estado: " + string(jogo_pausado));
    }
    // ✨ IMPORTANTE: Remove o else aqui para não despausar automaticamente
}

// ===== FUNÇÃO PARA RESUMIR (chame do menu de pausa) =====
function resumir_jogo() {
    jogo_pausado = false;
    
    // Destroi menu de pausa
    if (instance_exists(obj_pause_menu)) {
        instance_destroy(obj_pause_menu);
    }
    
    show_debug_message("RESUMIDO - Estado: " + string(jogo_pausado));
}

// Resto do código...
global.pontos_p1 = pontos_player1;
global.pontos_p2 = pontos_player2;

// Animação de fechamento
if (fazendo_animacao) {
    tempo_animacao += 1;
    alpha_tela = tempo_animacao / duracao_animacao;
    
    if (tempo_animacao >= duracao_animacao) {
        fazendo_animacao = false;
        alpha_tela = 0;
        tempo_animacao = 0;
        room_restart();
    }
}
