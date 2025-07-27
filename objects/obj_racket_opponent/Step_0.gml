// ===== SISTEMA DE BOOST =====
velocidade = velocidade_base + velocidade_boost;

if (tempo_boost > 0) {
    tempo_boost -= 1;
} else {
    velocidade_boost = max(velocidade_boost - 0.1, 0);
}

// ===== CONTROLE POR MODO =====
if (modo_controle == "player2") {
    // CONTROLE MANUAL PLAYER 2 - COM FALLBACK SEGURO
    
    // ✨ VERIFICA SE AS VARIÁVEIS GLOBAIS EXISTEM
    if (variable_global_exists("controle_p2_cima") && 
        variable_global_exists("controle_p2_baixo") && 
        variable_global_exists("controle_p2_esquerda") && 
        variable_global_exists("controle_p2_direita")) {
        
        // USA CONTROLES PERSONALIZADOS
        if keyboard_check(global.controle_p2_cima) {
            y -= velocidade;
        }
        if keyboard_check(global.controle_p2_baixo) {
            y += velocidade;
        }
        if keyboard_check(global.controle_p2_esquerda) {
            x -= velocidade;
        }
        if keyboard_check(global.controle_p2_direita) {
            x += velocidade;
        }
    } else {
        // ✨ FALLBACK: USA CONTROLES PADRÃO I,J,K,L
        if keyboard_check(ord("I")) {
            y -= velocidade;
        }
        if keyboard_check(ord("K")) {
            y += velocidade;
        }
        if keyboard_check(ord("J")) {
            x -= velocidade;
        }
        if keyboard_check(ord("L")) {
            x += velocidade;
        }
    }
} 
else if (modo_controle == "ia") {
    var bola = instance_find(obj_ball, 0);

    if (bola != noone) {
        // Sistema de recuo após bater na bola
        if (place_meeting(x, y, obj_ball)) {
            acabou_de_bater = true;
            
            // TEMPO DE RECUO BASEADO NA DIFICULDADE
            switch(dificuldade) {
                case 1: tempo_recuo = 20; break;  // Fácil - recua por mais tempo
                case 2: tempo_recuo = 15; break;  // Médio
                case 3: tempo_recuo = 10; break;  // Difícil
                case 4: tempo_recuo = 5;  break;  // 🔥 IMPOSSÍVEL - recua quase nada
            }
        }
        
        if (acabou_de_bater && tempo_recuo > 0) {
            tempo_recuo -= 1;
            
            // VELOCIDADE DE RECUO BASEADA NA DIFICULDADE
            var velocidade_recuo;
            switch(dificuldade) {
                case 1: velocidade_recuo = velocidade * 0.5; break;  // Fácil
                case 2: velocidade_recuo = velocidade * 0.7; break;  // Médio  
                case 3: velocidade_recuo = velocidade * 1.0; break;  // Difícil
                case 4: velocidade_recuo = velocidade * 2.5; break;  // 🔥 IMPOSSÍVEL - MUITO RÁPIDO
            }
            
            // Posição defensiva
            var posicao_defensiva_x = 1200;
            var posicao_defensiva_y = room_height / 2;
            
            var diferenca_x = posicao_defensiva_x - x;
            var diferenca_y = posicao_defensiva_y - y;
            
            // MAIS SENSÍVEL E RÁPIDO
            if (abs(diferenca_x) > 5) {
                x += sign(diferenca_x) * velocidade_recuo;
            }
            if (abs(diferenca_y) > 5) {
                y += sign(diferenca_y) * velocidade_recuo;
            }
            
            if (tempo_recuo <= 0) {
                acabou_de_bater = false;
            }
        }
        else {
            var precisao;
            var velocidade_ia_atual;
            
            // ===== DIFICULDADES =====
            switch(dificuldade) {
                case 1: // Fácil
                    velocidade_ia_atual = 2 + (velocidade_boost * 0.5);
                    precisao = 25;
                    break;
                    
                case 2: // Médio
                    velocidade_ia_atual = 4 + (velocidade_boost * 0.5);
                    precisao = 10;
                    break;
                    
                case 3: // Difícil
                    velocidade_ia_atual = 8 + (velocidade_boost * 0.5);
                    precisao = 0;
                    break;
                    
                case 4: // IMPOSSÍVEL MELHORADO 🔥
                    velocidade_ia_atual = 25 + velocidade_boost;
                    
                    // MODO TROLLAGEM SUPREMA ATIVADO
                    if (bola.vel_x > 0) {
                        var tempo = max(abs((x - bola.x) / bola.vel_x), 0.1);
                        var pos_y = bola.y + (bola.vel_y * tempo);
                        
                        // Corrige rebotes múltiplos
                        var rebotes = 0;
                        while ((pos_y < 0 || pos_y > room_height) && rebotes < 5) {
                            if (pos_y < 0) pos_y = abs(pos_y);
                            if (pos_y > room_height) pos_y = room_height - (pos_y - room_height);
                            rebotes++;
                        }
                        
                        // MOVIMENTO INSTANTÂNEO + MARGEM DE SEGURANÇA
                        var margem_seguranca = 30;
                        
                        if (pos_y - margem_seguranca < y && y < pos_y + margem_seguranca) {
                            // Já está na posição certa - fica parado
                        } else {
                            // Move com velocidade absurda
                            y += sign(pos_y - y) * velocidade_ia_atual;
                        }
                        
                        // Movimento horizontal mais agressivo
                        if (abs(bola.x - x) > 10) {
                            x += sign(bola.x - x) * (velocidade_ia_atual * 0.8);
                        }
                    }
                    else {
                        // POSIÇÃO ULTRA DEFENSIVA
                        var pos_ideal_x = room_width - 100;
                        var pos_ideal_y = room_height / 2;
                        
                        if (abs(x - pos_ideal_x) > 5) x += sign(pos_ideal_x - x) * (velocidade_ia_atual * 0.3);
                        if (abs(y - pos_ideal_y) > 5) y += sign(pos_ideal_y - y) * (velocidade_ia_atual * 0.3);
                    }
                    break;
            }
            
            // LÓGICA NORMAL (para dificuldades 1-3)
            if (dificuldade != 4) {
                if (bola.vel_x > 0) {
                    var tempo_para_chegar = abs((x - bola.x) / bola.vel_x);
                    var posicao_prevista_y = bola.y + (bola.vel_y * tempo_para_chegar);
                    
                    while (posicao_prevista_y < 0 || posicao_prevista_y > room_height) {
                        if (posicao_prevista_y < 0) {
                            posicao_prevista_y = abs(posicao_prevista_y);
                        }
                        if (posicao_prevista_y > room_height) {
                            posicao_prevista_y = room_height - (posicao_prevista_y - room_height);
                        }
                    }
                    
                    var diferenca_y = posicao_prevista_y - y;
                    var diferenca_x = bola.x - x;
                    
                    if (diferenca_y > precisao) y += velocidade_ia_atual;
                    else if (diferenca_y < -precisao) y -= velocidade_ia_atual;
                    
                    if (diferenca_x > precisao) x += velocidade_ia_atual;
                    else if (diferenca_x < -precisao) x -= velocidade_ia_atual;
                }
                else {
                    // Posição defensiva
                    var centro_y = room_height / 2;
                    var centro_x = 1100;
                    
                    if (abs(centro_y - y) > 15) {
                        y += sign(centro_y - y) * velocidade * 0.25;
                    }
                    if (abs(centro_x - x) > 15) {
                        x += sign(centro_x - x) * velocidade * 0.25;
                    }
                }
            }
        }
    }
}

// LIMITES
if (y <= 128) y = 128;
if (y >= 640) y = 640;
if (x <= 736) x = 736;
if (x >= 1248) x = 1248;
