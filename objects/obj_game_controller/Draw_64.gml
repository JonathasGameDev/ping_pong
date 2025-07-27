#region CONFIGURAÇÕES BÁSICAS
draw_set_font(-1);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
#endregion

#region INFORMAÇÕES DA PARTIDA
var centro_topo = room_width / 2;
var pos_info_y = 30;

draw_set_alpha(0.7);
draw_rectangle_color(centro_topo - 200, pos_info_y - 15, centro_topo + 200, pos_info_y + 15,
                    c_black, c_black, c_black, c_black, false);
draw_set_alpha(1);

draw_set_color(c_yellow);
draw_text_transformed(centro_topo, pos_info_y, 
    "RODADA " + string(global.rodada_atual) + " | MELHOR DE " + string(global.rodadas_para_vencer) + 
    " | " + string(global.pontos_por_rodada) + " PONTOS", 1.0, 1.0, 0);
#endregion

#region PLACAR DE RODADAS VENCIDAS
var pos_rodadas_y = 60;
draw_set_color(c_ltgray);
draw_text_transformed(centro_topo, pos_rodadas_y, 
    "RODADAS VENCIDAS: P1 [" + string(global.rodadas_vencidas_p1) + "] - [" + 
    string(global.rodadas_vencidas_p2) + "] P2", 0.9, 0.9, 0);
#endregion

#region PONTUAÇÃO DA RODADA ATUAL
var centro_x1 = room_width / 4;
var centro_x2 = room_width * 3/4;
var pos_y = 120;

draw_set_alpha(0.4);
draw_rectangle_color(centro_x1 - 120, pos_y - 40, centro_x1 + 120, pos_y + 40,
                    c_black, c_black, c_black, c_black, false);
draw_rectangle_color(centro_x2 - 120, pos_y - 40, centro_x2 + 120, pos_y + 40,
                    c_black, c_black, c_black, c_black, false);
draw_set_alpha(1);

draw_set_color(c_ltgray);
draw_text_transformed(centro_x1, pos_y - 25, "PLAYER 1", 0.8, 0.8, 0);
draw_text_transformed(centro_x2, pos_y - 25, "PLAYER 2", 0.8, 0.8, 0);

draw_set_color(c_white);
draw_text_transformed(centro_x1, pos_y, string(pontos_player1), 2.5, 2.5, 0);
draw_text_transformed(centro_x2, pos_y, string(pontos_player2), 2.5, 2.5, 0);

draw_set_color(c_ltgray);
draw_text_transformed(centro_x1, pos_y + 25, "/ " + string(global.pontos_por_rodada), 1.0, 1.0, 0);
draw_text_transformed(centro_x2, pos_y + 25, "/ " + string(global.pontos_por_rodada), 1.0, 1.0, 0);
#endregion

#region INDICADOR VISUAL DE RODADAS VENCIDAS
var spacing = 30;
var start_x1 = centro_x1 - ((global.rodadas_para_vencer - 1) * spacing / 2);
var start_x2 = centro_x2 - ((global.rodadas_para_vencer - 1) * spacing / 2);
var indicator_y = pos_y + 55;

for (var i = 0; i < global.rodadas_para_vencer; i++) {
    var x_pos = start_x1 + (i * spacing);
    if (i < global.rodadas_vencidas_p1) {
        draw_set_color(c_green);
        draw_circle(x_pos, indicator_y, 8, false);
        draw_set_color(c_white);
        draw_text_transformed(x_pos, indicator_y, "✓", 0.8, 0.8, 0);
    } else {
        draw_set_color(c_gray);
        draw_circle(x_pos, indicator_y, 8, true);
    }
}

for (var i = 0; i < global.rodadas_para_vencer; i++) {
    var x_pos = start_x2 + (i * spacing);
    if (i < global.rodadas_vencidas_p2) {
        draw_set_color(c_green);
        draw_circle(x_pos, indicator_y, 8, false);
        draw_set_color(c_white);
        draw_text_transformed(x_pos, indicator_y, "✓", 0.8, 0.8, 0);
    } else {
        draw_set_color(c_gray);
        draw_circle(x_pos, indicator_y, 8, true);
    }
}

draw_set_alpha(0.5);
draw_line_width_color(room_width/2, 90, room_width/2, 180, 3, c_white, c_white);
draw_set_alpha(1);
#endregion

#region FEEDBACK DE PONTOS E ANIMAÇÕES
if (fazendo_animacao || mostrando_ponto) {
    var gui_w = display_get_gui_width();
    var gui_h = display_get_gui_height();
    var centro_gui_x = gui_w / 2;
    var centro_gui_y = gui_h / 2;
    
    if (mostrando_ponto && !fazendo_animacao) {
        draw_set_alpha(0.4);
        draw_rectangle_color(0, 0, gui_w, gui_h, c_black, c_black, c_black, c_black, false);
        draw_set_alpha(1);
        
        var pulse = sin(current_time / 100) * 0.15 + 1;
        var scale_ponto = 1.5 * pulse;
        
        draw_set_color(c_black);
        draw_text_transformed(centro_gui_x + 2, centro_gui_y + 2, ultimo_gol, scale_ponto, scale_ponto, 0);
        draw_set_color(c_lime);
        draw_text_transformed(centro_gui_x, centro_gui_y, ultimo_gol, scale_ponto, scale_ponto, 0);
        
        draw_set_color(c_ltgray);
        draw_text_transformed(centro_gui_x, centro_gui_y + 40, 
            "P1: " + string(global.pontos_p1) + "  |  P2: " + string(global.pontos_p2), 1.0, 1.0, 0);
    }
    else if (fazendo_animacao) {
        var fade_progress = alpha_tela;
        
        draw_set_alpha(fade_progress * 0.8);
        
        for (var i = 0; i < gui_h; i += 10) {
            var intensity = sin((i / gui_h) * pi) * fade_progress;
            draw_set_alpha(intensity * 0.6);
            
            var cor_gradiente = c_navy;
            if (string_pos("RODADA", ultimo_gol) > 0) cor_gradiente = c_teal;
            if (string_pos("PARTIDA", ultimo_gol) > 0) cor_gradiente = c_purple;
            
            draw_line_width_color(0, i, gui_w, i, 10, cor_gradiente, c_black);
        }
        
        draw_set_alpha(1);
        
        var bounce = sin(current_time / 200) * 0.2 + 1;
        var scale_main = 2.0 * bounce * fade_progress;
        var scale_sub = 1.0 * fade_progress;
        
        draw_set_color(c_black);
        draw_text_transformed(centro_gui_x + 3, centro_gui_y + 3, ultimo_gol, 
                             scale_main, scale_main, 0);
        
        var cor_texto = c_yellow;
        if (string_pos("RODADA", ultimo_gol) > 0) cor_texto = c_aqua;
        if (string_pos("PARTIDA", ultimo_gol) > 0) cor_texto = make_color_rgb(255, 215, 0);
        
        draw_set_color(cor_texto);
        draw_text_transformed(centro_gui_x, centro_gui_y, ultimo_gol, 
                             scale_main, scale_main, 0);
        
        draw_set_alpha(fade_progress);
        draw_set_color(c_ltgray);
        var texto_secundario = (vencedor_partida != "") ? "Quer revanche?" : "Preparando proxima rodada...";
        draw_text_transformed(centro_gui_x, centro_gui_y + 60, texto_secundario, 
                             scale_sub, scale_sub, 0);
        
        if (vencedor_partida != "") {
            for (var p = 0; p < 12; p++) {
                var angle = (current_time / 8 + p * 30) % 360;
                var dist = 180 + sin(current_time / 80) * 30;
                var part_x = centro_gui_x + lengthdir_x(dist, angle);
                var part_y = centro_gui_y + lengthdir_y(dist, angle);
                
                draw_set_alpha(fade_progress * 0.8);
                draw_set_color(make_color_rgb(255, 215, 0));
                draw_circle(part_x, part_y, 6, false);
                draw_set_color(c_yellow);
                draw_circle(part_x, part_y, 3, false);
            }
        }
        else if (string_pos("RODADA", ultimo_gol) > 0) {
            for (var s = 0; s < 8; s++) {
                var star_angle = (current_time / 12 + s * 45) % 360;
                var star_dist = 120 + sin(current_time / 150) * 20;
                var star_x = centro_gui_x + lengthdir_x(star_dist, star_angle);
                var star_y = centro_gui_y + lengthdir_y(star_dist, star_angle);
                
                draw_set_alpha(fade_progress * 0.7);
                draw_set_color(c_aqua);
                
                var star_size = 8;
                draw_line_width(star_x - star_size, star_y, star_x + star_size, star_y, 3);
                draw_line_width(star_x, star_y - star_size, star_x, star_y + star_size, 3);
                draw_line_width(star_x - star_size*0.7, star_y - star_size*0.7, star_x + star_size*0.7, star_y + star_size*0.7, 2);
                draw_line_width(star_x - star_size*0.7, star_y + star_size*0.7, star_x + star_size*0.7, star_y - star_size*0.7, 2);
            }
        }
        
        draw_set_alpha(1);
    }
}
#endregion

#region RESET CONFIGURAÇÕES
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
#endregion
