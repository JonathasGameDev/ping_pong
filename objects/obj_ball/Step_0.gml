// Movimento da bola
x += vel_x;
y += vel_y;

// ===== COLISÃO COM RAQUETES (CÓDIGO UNIFICADO) =====
// RAQUETE PLAYER 1
if (place_meeting(x, y, obj_racket) && vel_x < 0) {
    // ✨ SOM COM VOLUME BASEADO NA VELOCIDADE
    var velocidade_total = sqrt(vel_x * vel_x + vel_y * vel_y);
    var volume_som = clamp(velocidade_total / 15, 0.3, 1.0);
    
    var som_id = audio_play_sound(snd_bola, 2, false);
    audio_sound_gain(som_id, volume_som, 0);
    
    // Lógica de rebote
    vel_x = -vel_x * 1.1;
    vel_y *= 1.05;
    
    // Sistema de boost
    if (instance_exists(obj_racket)) {
        obj_racket.velocidade_boost += 2;
        obj_racket.tempo_boost = 60;
    }
}

// RAQUETE PLAYER 2/IA
if (place_meeting(x, y, obj_racket_opponent) && vel_x > 0) {
    // ✨ SOM COM VOLUME BASEADO NA VELOCIDADE
    var velocidade_total = sqrt(vel_x * vel_x + vel_y * vel_y);
    var volume_som = clamp(velocidade_total / 15, 0.3, 1.0);
    
    var som_id = audio_play_sound(snd_bola, 2, false);
    audio_sound_gain(som_id, volume_som, 0);
    
    // Lógica de rebote
    vel_x = -vel_x * 1.1;
    vel_y *= 1.05;
    
    // Sistema de boost
    if (instance_exists(obj_racket_opponent)) {
        obj_racket_opponent.velocidade_boost += 2;
        obj_racket_opponent.tempo_boost = 60;
    }
}

// Colisão com paredes
if (y <= 0 || y >= room_height) {
    vel_y = -vel_y;
}

// PONTUAÇÃO CORRIGIDA - identifica pelo lado da tela
if (!ponto_ja_marcado) {
    if (x < 0) {
        // Bola saiu pelo lado esquerdo = obj_racket perdeu
        obj_game_controller.pontos_player2 += 1;
        obj_game_controller.ultimo_gol = "PLAYER 2";
        obj_game_controller.fazendo_animacao = true;
        ponto_ja_marcado = true;
        vel_x = 0;
        vel_y = 0;
    }
    
    if (x > room_width) {
        // Bola saiu pelo lado direito = obj_racket_opponent perdeu  
        obj_game_controller.pontos_player1 += 1;
        obj_game_controller.ultimo_gol = "PLAYER 1";
        obj_game_controller.fazendo_animacao = true;
        ponto_ja_marcado = true;
        vel_x = 0;
        vel_y = 0;
    }
}
