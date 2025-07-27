#region CONTROLE DE PARTIDA FINALIZADA
if (instance_exists(obj_game_controller) && obj_game_controller.partida_finalizada) {
    vel_x = 0;
    vel_y = 0;
    exit;
}
#endregion

#region CONTROLE DE RESET DA BOLA
if (esperando_reset) {
    tempo_reset++;
    if (tempo_reset >= 90) {
        x = room_width / 2;
        y = room_height / 2;
        
        vel_x = choose(-4, 4);
        vel_y = random_range(-2, 2);
        
        if (abs(vel_y) < 1) {
            vel_y = choose(-2, 2);
        }
        
        ponto_ja_marcado = false;
        esperando_reset = false;
        tempo_reset = 0;
    }
    return;
}
#endregion

#region MOVIMENTO DA BOLA
x += vel_x;
y += vel_y;

if (abs(vel_x) < 0.5 && abs(vel_y) < 0.5 && !esperando_reset && !ponto_ja_marcado) {
    vel_x = choose(-4, 4);
    vel_y = random_range(-3, 3);
    if (abs(vel_y) < 1) vel_y = choose(-2, 2);
}
#endregion

#region COLISÃO COM RAQUETES
// RAQUETE PLAYER 1
if (place_meeting(x, y, obj_racket) && vel_x < 0) {
    var velocidade_total = sqrt(vel_x * vel_x + vel_y * vel_y);
    var volume_som = clamp(velocidade_total / 15, 0.3, 1.0);
    
    var som_id = audio_play_sound(snd_bola, 2, false);
    audio_sound_gain(som_id, volume_som, 0);
    
    var vel_raquete_x = obj_racket.velocidade_instantanea_x;
    var vel_raquete_y = obj_racket.velocidade_instantanea_y;
    var velocidade_raquete_total = sqrt(vel_raquete_x * vel_raquete_x + vel_raquete_y * vel_raquete_y);
    
    vel_x = -vel_x * 1.1;
    vel_y *= 1.05;
    
    var fator_impacto = 0.8;
    vel_x += vel_raquete_x * fator_impacto;
    vel_y += vel_raquete_y * fator_impacto;
    
    if (velocidade_raquete_total > 3) {
        var multiplicador_smash = 1 + (velocidade_raquete_total / 15);
        vel_x *= multiplicador_smash;
        vel_y *= multiplicador_smash;
    }
    
    if (abs(vel_x) < 2) vel_x = sign(vel_x) * 2;
    if (abs(vel_y) < 1) vel_y = sign(vel_y) * 1;
    
    vel_x = clamp(vel_x, -15, 15);
    vel_y = clamp(vel_y, -15, 15);
    
    if (instance_exists(obj_racket)) {
        obj_racket.velocidade_boost += 2 + (velocidade_raquete_total * 0.5);
        obj_racket.tempo_boost = 60;
    }
}

// RAQUETE PLAYER 2/IA
if (place_meeting(x, y, obj_racket_opponent) && vel_x > 0) {
    var velocidade_total = sqrt(vel_x * vel_x + vel_y * vel_y);
    var volume_som = clamp(velocidade_total / 15, 0.3, 1.0);
    
    var som_id = audio_play_sound(snd_bola, 2, false);
    audio_sound_gain(som_id, volume_som, 0);
    
    var vel_raquete_x = obj_racket_opponent.velocidade_instantanea_x;
    var vel_raquete_y = obj_racket_opponent.velocidade_instantanea_y;
    var velocidade_raquete_total = sqrt(vel_raquete_x * vel_raquete_x + vel_raquete_y * vel_raquete_y);
    
    vel_x = -vel_x * 1.1;
    vel_y *= 1.05;
    
    var fator_impacto = 0.8;
    vel_x += vel_raquete_x * fator_impacto;
    vel_y += vel_raquete_y * fator_impacto;
    
    if (velocidade_raquete_total > 3) {
        var multiplicador_smash = 1 + (velocidade_raquete_total / 15);
        vel_x *= multiplicador_smash;
        vel_y *= multiplicador_smash;
    }
    
    if (abs(vel_x) < 2) vel_x = sign(vel_x) * 2;
    if (abs(vel_y) < 1) vel_y = sign(vel_y) * 1;
    
    vel_x = clamp(vel_x, -15, 15);
    vel_y = clamp(vel_y, -15, 15);
    
    if (instance_exists(obj_racket_opponent)) {
        obj_racket_opponent.velocidade_boost += 2 + (velocidade_raquete_total * 0.5);
        obj_racket_opponent.tempo_boost = 60;
    }
}
#endregion

#region COLISÃO COM PAREDES
if (y <= 0 || y >= room_height) {
    vel_y = -vel_y;
    
    var som_parede = audio_play_sound(snd_bola, 1, false);
    audio_sound_gain(som_parede, 0.5, 0);
}
#endregion

#region SISTEMA DE PONTUAÇÃO
if (!ponto_ja_marcado && !obj_game_controller.fazendo_animacao) {
    if (x < -10) {
        obj_game_controller.pontos_player2 += 1;
        global.pontos_p2 = obj_game_controller.pontos_player2;
        
        ponto_ja_marcado = true;
        esperando_reset = true;
        tempo_reset = 0;
        
        vel_x = 0;
        vel_y = 0;
    }
    
    if (x > room_width + 10) {
        obj_game_controller.pontos_player1 += 1;
        global.pontos_p1 = obj_game_controller.pontos_player1;
        
        ponto_ja_marcado = true;
        esperando_reset = true;
        tempo_reset = 0;
        
        vel_x = 0;
        vel_y = 0;
    }
}
#endregion

#region LIMITES E CONTROLES DE EMERGÊNCIA
x = clamp(x, -50, room_width + 50);
y = clamp(y, -10, room_height + 10);

if (keyboard_check_pressed(ord("R"))) {
    vel_x = choose(-6, 6);
    vel_y = choose(-4, 4);
    esperando_reset = false;
    ponto_ja_marcado = false;
    x = room_width / 2;
    y = room_height / 2;
}
#endregion
