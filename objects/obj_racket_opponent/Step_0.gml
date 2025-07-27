#region SISTEMA DE BOOST
velocidade_boost = clamp(velocidade_boost, 0, velocidade_boost_max);
velocidade = velocidade_base + velocidade_boost;

if (tempo_boost > 0) {
    tempo_boost -= 1;
} else {
    velocidade_boost = max(velocidade_boost - 0.2, 0);
}

pos_anterior_x = x;
pos_anterior_y = y;
#endregion

#region CONTROLE PLAYER 2 MANUAL
if (modo_controle == "player2") {
    if (variable_global_exists("controle_p2_cima") && 
        variable_global_exists("controle_p2_baixo") && 
        variable_global_exists("controle_p2_esquerda") && 
        variable_global_exists("controle_p2_direita")) {
        
        if keyboard_check(global.controle_p2_cima) y -= velocidade;
        if keyboard_check(global.controle_p2_baixo) y += velocidade;
        if keyboard_check(global.controle_p2_esquerda) x -= velocidade;
        if keyboard_check(global.controle_p2_direita) x += velocidade;
    } else {
        if keyboard_check(ord("I")) y -= velocidade;
        if keyboard_check(ord("K")) y += velocidade;
        if keyboard_check(ord("J")) x -= velocidade;
        if keyboard_check(ord("L")) x += velocidade;
    }
}
#endregion

#region CONTROLE IA
else if (modo_controle == "ia") {
    var bola = instance_find(obj_ball, 0);

    if (bola != noone) {
        if (place_meeting(x, y, obj_ball)) {
            acabou_de_bater = true;
            
            switch(dificuldade) {
                case 1: tempo_recuo = 20; break;
                case 2: tempo_recuo = 15; break;
                case 3: tempo_recuo = 10; break;
                case 4: tempo_recuo = 5; break;
            }
        }
        
        if (acabou_de_bater && tempo_recuo > 0) {
            tempo_recuo -= 1;
            
            var velocidade_recuo;
            switch(dificuldade) {
                case 1: velocidade_recuo = clamp(velocidade * 0.5, 0, 8); break;
                case 2: velocidade_recuo = clamp(velocidade * 0.7, 0, 10); break;
                case 3: velocidade_recuo = clamp(velocidade * 1.0, 0, 12); break;
                case 4: velocidade_recuo = clamp(velocidade * 2.0, 0, 15); break;
            }
            
            var posicao_defensiva_x = 1200;
            var posicao_defensiva_y = room_height / 2;
            var diferenca_x = posicao_defensiva_x - x;
            var diferenca_y = posicao_defensiva_y - y;
            
            if (abs(diferenca_x) > 5) x += sign(diferenca_x) * velocidade_recuo;
            if (abs(diferenca_y) > 5) y += sign(diferenca_y) * velocidade_recuo;
            
            if (tempo_recuo <= 0) acabou_de_bater = false;
        } else {
            var precisao;
            var velocidade_ia_atual;
            
            switch(dificuldade) {
                case 1:
                    velocidade_ia_atual = clamp(2 + (velocidade_boost * 0.5), 0, 6);
                    precisao = 25;
                    break;
                case 2:
                    velocidade_ia_atual = clamp(4 + (velocidade_boost * 0.5), 0, 8);
                    precisao = 10;
                    break;
                case 3:
                    velocidade_ia_atual = clamp(8 + (velocidade_boost * 0.5), 0, 12);
                    precisao = 0;
                    break;
                case 4:
                    velocidade_ia_atual = clamp(15 + (velocidade_boost * 0.5), 0, 18);
                    
                    if (bola.vel_x > 0) {
                        var tempo = max(abs((x - bola.x) / bola.vel_x), 0.1);
                        var pos_y = bola.y + (bola.vel_y * tempo);
                        
                        var rebotes = 0;
                        while ((pos_y < 0 || pos_y > room_height) && rebotes < 5) {
                            if (pos_y < 0) pos_y = abs(pos_y);
                            if (pos_y > room_height) pos_y = room_height - (pos_y - room_height);
                            rebotes++;
                        }
                        
                        var margem_seguranca = 30;
                        
                        if (pos_y - margem_seguranca < y && y < pos_y + margem_seguranca) {
                            // Já está na posição certa
                        } else {
                            var movimento_y = sign(pos_y - y) * velocidade_ia_atual;
                            y += clamp(movimento_y, -18, 18);
                        }
                        
                        if (abs(bola.x - x) > 10) {
                            var movimento_x = sign(bola.x - x) * (velocidade_ia_atual * 0.6);
                            x += clamp(movimento_x, -15, 15);
                        }
                    } else {
                        var pos_ideal_x = room_width - 100;
                        var pos_ideal_y = room_height / 2;
                        
                        if (abs(x - pos_ideal_x) > 5) {
                            var movimento_x = sign(pos_ideal_x - x) * (velocidade_ia_atual * 0.3);
                            x += clamp(movimento_x, -10, 10);
                        }
                        if (abs(y - pos_ideal_y) > 5) {
                            var movimento_y = sign(pos_ideal_y - y) * (velocidade_ia_atual * 0.3);
                            y += clamp(movimento_y, -10, 10);
                        }
                    }
                    break;
            }
            
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
                    
                    if (diferenca_y > precisao) {
                        y += clamp(velocidade_ia_atual, 0, 12);
                    } else if (diferenca_y < -precisao) {
                        y -= clamp(velocidade_ia_atual, 0, 12);
                    }
                    
                    if (diferenca_x > precisao) {
                        x += clamp(velocidade_ia_atual, 0, 12);
                    } else if (diferenca_x < -precisao) {
                        x -= clamp(velocidade_ia_atual, 0, 12);
                    }
                } else {
                    var centro_y = room_height / 2;
                    var centro_x = 1100;
                    
                    if (abs(centro_y - y) > 15) {
                        var movimento_y = sign(centro_y - y) * velocidade * 0.25;
                        y += clamp(movimento_y, -8, 8);
                    }
                    if (abs(centro_x - x) > 15) {
                        var movimento_x = sign(centro_x - x) * velocidade * 0.25;
                        x += clamp(movimento_x, -8, 8);
                    }
                }
            }
        }
    }
}
#endregion

#region VELOCIDADE INSTANTÂNEA E LIMITES
velocidade_instantanea_x = x - pos_anterior_x;
velocidade_instantanea_y = y - pos_anterior_y;

if (y <= 128) y = 128;
if (y >= 640) y = 640;
if (x <= 736) x = 736;
if (x >= 1248) x = 1248;
#endregion
