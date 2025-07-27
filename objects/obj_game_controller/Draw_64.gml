// ===== CONFIGURAÇÕES BÁSICAS =====
draw_set_font(-1);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// ===== PONTUAÇÃO ESTILIZADA =====
var centro_x1 = room_width / 4;
var centro_x2 = room_width * 3/4;
var pos_y = 80;

// Fundo da pontuação (opcional)
draw_set_alpha(0.3);
draw_rectangle_color(centro_x1 - 100, pos_y - 30, centro_x1 + 100, pos_y + 30,
                    c_black, c_black, c_black, c_black, false);
draw_rectangle_color(centro_x2 - 100, pos_y - 30, centro_x2 + 100, pos_y + 30,
                    c_black, c_black, c_black, c_black, false);
draw_set_alpha(1);

// Texto "Player 1" e "Player 2" menores
draw_set_color(c_ltgray);
draw_text_transformed(centro_x1, pos_y - 20, "PLAYER 1", 0.8, 0.8, 0);
draw_text_transformed(centro_x2, pos_y - 20, "PLAYER 2", 0.8, 0.8, 0);

// Pontuação grande e destacada
draw_set_color(c_white);
draw_text_transformed(centro_x1, pos_y + 10, string(pontos_player1), 2.5, 2.5, 0);
draw_text_transformed(centro_x2, pos_y + 10, string(pontos_player2), 2.5, 2.5, 0);

// Separador no meio (opcional)
draw_set_alpha(0.5);
draw_line_width_color(room_width/2, 20, room_width/2, 140, 3, c_white, c_white);
draw_set_alpha(1);

// ===== ANIMAÇÃO MELHORADA =====
if (fazendo_animacao) {
    // Efeito de fade in/out
    var fade_progress = alpha_tela;
    
    // Fundo com gradiente
    draw_set_alpha(fade_progress * 0.8);
    var gui_w = display_get_gui_width();
    var gui_h = display_get_gui_height();
    
    // Gradiente do centro para as bordas
    for (var i = 0; i < gui_h; i += 10) {
        var intensity = sin((i / gui_h) * pi) * fade_progress;
        draw_set_alpha(intensity * 0.6);
        draw_line_width_color(0, i, gui_w, i, 10, c_navy, c_black);
    }
    
    draw_set_alpha(1);
    
    // ===== TEXTO DE PONTUAÇÃO ANIMADO =====
    var centro_gui_x = gui_w / 2;
    var centro_gui_y = gui_h / 2;
    
    // Efeito de bounce na escala
    var bounce = sin(current_time / 200) * 0.2 + 1;
    var scale_main = 2.5 * bounce * fade_progress;
    var scale_sub = 1.2 * fade_progress;
    
    // Sombra do texto principal
    draw_set_color(c_black);
    draw_text_transformed(centro_gui_x + 3, centro_gui_y + 3, ultimo_gol + " MARCOU!", 
                         scale_main, scale_main, sin(current_time / 150) * 2);
    
    // Texto principal com gradiente (simulado)
    draw_set_color(c_yellow);
    draw_text_transformed(centro_gui_x, centro_gui_y, ultimo_gol + " MARCOU!", 
                         scale_main, scale_main, sin(current_time / 150) * 2);
    
    
    // Texto secundário
    draw_set_alpha(fade_progress);
    draw_set_color(c_ltgray);
    draw_text_transformed(centro_gui_x, centro_gui_y + 80, "Preparando próxima rodada...", 
                         scale_sub, scale_sub, 0);
    
    // Partículas decorativas (opcional)
    for (var p = 0; p < 8; p++) {
        var angle = (current_time / 10 + p * 45) % 360;
        var dist = 150 + sin(current_time / 100) * 20;
        var part_x = centro_gui_x + lengthdir_x(dist, angle);
        var part_y = centro_gui_y + lengthdir_y(dist, angle);
        
        draw_set_alpha(fade_progress * 0.7);
        draw_set_color(c_yellow);
        draw_circle(part_x, part_y, 4, false);
    }
}

// ===== RESET CONFIGURAÇÕES =====
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
