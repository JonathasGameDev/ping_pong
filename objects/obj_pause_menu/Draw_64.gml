// Fundo semi-transparente
draw_set_alpha(0.7);
draw_rectangle_color(0, 0, display_get_gui_width(), display_get_gui_height(), 
                    c_black, c_black, c_black, c_black, false);
draw_set_alpha(1);

// Configurações de texto
draw_set_font(-1);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var centro_x = display_get_gui_width() / 2;
var centro_y = display_get_gui_height() / 2;

// ===== CORES DA PALETA =====
var cor_verde = make_color_rgb(20, 194, 80);    // #14C250
var cor_laranja = make_color_rgb(223, 77, 32);  // #DF4D20  
var cor_roxo = make_color_rgb(84, 9, 55);       // #540937

// ✨ BACKGROUND SOFISTICADO DO TÍTULO
draw_set_alpha(0.8);
draw_rectangle_color(centro_x - 120, centro_y - 100, centro_x + 120, centro_y - 60,
                    c_black, c_black, c_black, c_black, false);
draw_set_alpha(1);

// Título com sombra elegante
draw_set_color(cor_roxo);
draw_text_transformed(centro_x + 2, centro_y - 78, "JOGO PAUSADO", 2, 2, 0);
draw_set_color(cor_verde);
draw_text_transformed(centro_x, centro_y - 80, "JOGO PAUSADO", 2, 2, 0);

// ✨ Opção 1: Resumir
var pos_y_resumir = centro_y - 10;
if (opcao_selecionada == 0) {
    // Background para opção selecionada
    draw_set_alpha(0.8);
    draw_rectangle_color(centro_x - 80, pos_y_resumir - 18, centro_x + 80, pos_y_resumir + 18,
                        c_black, c_black, c_black, c_black, false);
    draw_set_alpha(1);
    
    // Sombra do texto
    draw_set_color(c_black);
    draw_text_transformed(centro_x + 2, pos_y_resumir + 2, "> RESUMIR <", 1.3, 1.3, 0);
    
    // Texto principal
    draw_set_color(cor_verde);
    draw_text_transformed(centro_x, pos_y_resumir, "> RESUMIR <", 1.3, 1.3, 0);
    
} else {
    // Background sutil para opção não selecionada
    draw_set_alpha(0.4);
    draw_rectangle_color(centro_x - 60, pos_y_resumir - 15, centro_x + 60, pos_y_resumir + 15,
                        c_black, c_black, c_black, c_black, false);
    draw_set_alpha(1);
    
    // Sombra sutil
    draw_set_color(make_color_rgb(80, 80, 80));
    draw_text_transformed(centro_x + 1, pos_y_resumir + 1, "RESUMIR", 1.1, 1.1, 0);
    
    draw_set_color(c_white);
    draw_text_transformed(centro_x, pos_y_resumir, "RESUMIR", 1.1, 1.1, 0);
}

// ✨ Opção 2: Menu Principal
var pos_y_menu = centro_y + 30;
if (opcao_selecionada == 1) {
    // Background para opção selecionada
    draw_set_alpha(0.8);
    draw_rectangle_color(centro_x - 100, pos_y_menu - 18, centro_x + 100, pos_y_menu + 18,
                        c_black, c_black, c_black, c_black, false);
    draw_set_alpha(1);
    
    // Sombra do texto
    draw_set_color(c_black);
    draw_text_transformed(centro_x + 2, pos_y_menu + 2, "> MENU PRINCIPAL <", 1.3, 1.3, 0);
    
    // Texto principal
    draw_set_color(cor_laranja);
    draw_text_transformed(centro_x, pos_y_menu, "> MENU PRINCIPAL <", 1.3, 1.3, 0);
    
  
} else {
    // Background sutil para opção não selecionada
    draw_set_alpha(0.4);
    draw_rectangle_color(centro_x - 80, pos_y_menu - 15, centro_x + 80, pos_y_menu + 15,
                        c_black, c_black, c_black, c_black, false);
    draw_set_alpha(1);
    
    // Sombra sutil
    draw_set_color(make_color_rgb(80, 80, 80));
    draw_text_transformed(centro_x + 1, pos_y_menu + 1, "MENU PRINCIPAL", 1.1, 1.1, 0);
    
    draw_set_color(c_white);
    draw_text_transformed(centro_x, pos_y_menu, "MENU PRINCIPAL", 1.1, 1.1, 0);
}

// ✨ BACKGROUND DAS INSTRUÇÕES
draw_set_alpha(0.6);
draw_rectangle_color(centro_x - 140, centro_y + 70, centro_x + 140, centro_y + 135,
                    c_black, c_black, c_black, c_black, false);
draw_set_alpha(1);

// Instruções elegantes
draw_set_color(c_white);
draw_text(centro_x, centro_y + 85, "Use W/S para navegar");
draw_text(centro_x, centro_y + 105, "ENTER para confirmar");

// Instrução especial para ESC
draw_set_color(cor_roxo);
draw_text_transformed(centro_x, centro_y + 125, "ESC para resumir", 1.1, 1.1, 0);

// Reset configurações
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
