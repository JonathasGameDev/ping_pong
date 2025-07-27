// Configurações de texto
draw_set_font(-1);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// ===== FUNDO PRETO COMPLETO =====
draw_set_alpha(1);
draw_set_color(c_black);
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);

var centro_x = display_get_gui_width() / 2;
var centro_y = display_get_gui_height() / 2;

// ===== CORES DA PALETA =====
var cor_verde = make_color_rgb(20, 194, 80);    // #14C250
var cor_laranja = make_color_rgb(223, 77, 32);  // #DF4D20  
var cor_roxo = make_color_rgb(84, 9, 55);       // #540937

// ===== MENU PRINCIPAL =====
if (estado_menu == "principal") {
    // ✨ BACKGROUND DO TÍTULO
    draw_set_alpha(0.7);
    draw_rectangle_color(centro_x - 150, centro_y - 120, centro_x + 150, centro_y - 80,
                        c_black, c_black, c_black, c_black, false);
    draw_set_alpha(1);
    
    // Título com sombra na nova paleta
    draw_set_color(cor_roxo);
    draw_text_transformed(centro_x + 3, centro_y - 97, "PONG GAME", 2, 2, 0);
    draw_set_color(cor_verde);
    draw_text_transformed(centro_x, centro_y - 100, "PONG GAME", 2, 2, 0);
    
    // Array de opções com nova paleta
    var opcoes_menu = ["VS PLAYER 2", "VS COMPUTADOR", "CONTROLES", "SAIR"];
    var cores_opcoes = [cor_verde, cor_laranja, cor_roxo, make_color_rgb(180, 50, 50)];
    
    for (var i = 0; i < total_opcoes_principal; i++) {
        var pos_y = centro_y + (i * 50);
        
        // ✨ BACKGROUND DAS OPÇÕES
        if (opcao_selecionada == i) {
            // Fundo mais visível para opção selecionada
            draw_set_alpha(0.8);
            draw_rectangle_color(centro_x - 120, pos_y - 20, centro_x + 120, pos_y + 20,
                                c_black, c_black, c_black, c_black, false);
            draw_set_alpha(1);
        } else {
            // Fundo sutil para opções não selecionadas
            draw_set_alpha(0.4);
            draw_rectangle_color(centro_x - 100, pos_y - 15, centro_x + 100, pos_y + 15,
                                c_black, c_black, c_black, c_black, false);
            draw_set_alpha(1);
        }
        
        if (opcao_selecionada == i) {
            draw_set_color(cores_opcoes[i]);
            draw_text_transformed(centro_x, pos_y, "> " + opcoes_menu[i] + " <", 1.2, 1.2, 0);
        } else {
            draw_set_color(c_white); // Branco para melhor contraste
            draw_text(centro_x, pos_y, opcoes_menu[i]);
        }
    }
    
    // ✨ BACKGROUND DAS INSTRUÇÕES
    draw_set_alpha(0.5);
    draw_rectangle_color(centro_x - 200, centro_y + 215, centro_x + 200, centro_y + 245,
                        c_black, c_black, c_black, c_black, false);
    draw_set_alpha(1);
    
    // Instruções com cor mais visível
    draw_set_color(c_white);
    draw_text(centro_x, centro_y + 230, "Use W/S para navegar • ENTER para confirmar");
}

// ===== MENU DE DIFICULDADE =====
else if (estado_menu == "dificuldade") {
    // ✨ BACKGROUND DO TÍTULO
    draw_set_alpha(0.7);
    draw_rectangle_color(centro_x - 180, centro_y - 120, centro_x + 180, centro_y - 80,
                        c_black, c_black, c_black, c_black, false);
    draw_set_alpha(1);
    
    // Título com nova paleta
    draw_set_color(cor_roxo);
    draw_text_transformed(centro_x + 2, centro_y - 98, "ESCOLHA A DIFICULDADE", 1.5, 1.5, 0);
    draw_set_color(cor_verde);
    draw_text_transformed(centro_x, centro_y - 100, "ESCOLHA A DIFICULDADE", 1.5, 1.5, 0);
    
    // Opções de dificuldade
    var opcoes = ["FACIL", "MEDIO", "DIFICIL", "IMPOSSIVEL"];
    var descricoes = [
        "IA lenta e imprecisa", 
        "IA equilibrada", 
        "IA rápida e precisa",
        "🔥 PREPARE-SE PARA SOFRER 🔥"
    ];
    var cores = [cor_verde, make_color_rgb(180, 150, 30), cor_laranja, cor_roxo];
    
    for (var i = 0; i < 4; i++) {
        var pos_y = centro_y - 40 + (i * 50);
        
        // ✨ BACKGROUND DAS OPÇÕES DE DIFICULDADE
        if (opcao_dificuldade == i + 1) {
            // Fundo mais visível para opção selecionada
            draw_set_alpha(0.8);
            var largura = (i == 3) ? 160 : 120; // Impossível é maior
            draw_rectangle_color(centro_x - largura, pos_y - 25, centro_x + largura, pos_y + 30,
                                c_black, c_black, c_black, c_black, false);
            draw_set_alpha(1);
        } else {
            // Fundo sutil para opções não selecionadas
            draw_set_alpha(0.4);
            draw_rectangle_color(centro_x - 80, pos_y - 15, centro_x + 80, pos_y + 15,
                                c_black, c_black, c_black, c_black, false);
            draw_set_alpha(1);
        }
        
        if (opcao_dificuldade == i + 1) {
            // Opção selecionada
            draw_set_color(cores[i]);
            var escala = (i == 3) ? 1.5 : 1.3;
            draw_text_transformed(centro_x, pos_y, "> " + opcoes[i] + " <", escala, escala, 0);
            
            // Descrição da dificuldade selecionada
            draw_set_color(c_white); // Branco para melhor contraste
            var desc_escala = (i == 3) ? 1.0 : 0.9;
            draw_text_transformed(centro_x, pos_y + 25, descricoes[i], desc_escala, desc_escala, 0);
            
            // Efeito especial para IMPOSSÍVEL
            if (i == 3) {
                var alpha_pisca = sin(current_time / 200) * 0.3 + 0.7;
                draw_set_alpha(alpha_pisca);
                draw_set_color(cor_laranja);
                draw_text_transformed(centro_x, pos_y - 15, "⚠️ WARNING ⚠️", 0.8, 0.8, 0);
                draw_set_alpha(1);
            }
        } else {
            draw_set_color(c_white); // Branco para melhor contraste
            draw_text(centro_x, pos_y, opcoes[i]);
        }
    }
    
    // ✨ BACKGROUND DAS INSTRUÇÕES
    draw_set_alpha(0.5);
    draw_rectangle_color(centro_x - 250, centro_y + 155, centro_x + 250, centro_y + 185,
                        c_black, c_black, c_black, c_black, false);
    draw_set_alpha(1);
    
    // Instruções
    draw_set_color(c_white);
    draw_text(centro_x, centro_y + 170, "W/S para navegar • ENTER para confirmar • ESC para voltar");
}

// ===== MENU DE CONTROLES =====
else if (estado_menu == "controles") {
    // ✨ BACKGROUND DO TÍTULO
    draw_set_alpha(0.7);
    draw_rectangle_color(centro_x - 200, centro_y - 220, centro_x + 200, centro_y - 180,
                        c_black, c_black, c_black, c_black, false);
    draw_set_alpha(1);
    
    // Título com nova paleta
    draw_set_color(cor_roxo);
    draw_text_transformed(centro_x + 2, centro_y - 198, "CONFIGURAR CONTROLES", 1.8, 1.8, 0);
    draw_set_color(cor_verde);
    draw_text_transformed(centro_x, centro_y - 200, "CONFIGURAR CONTROLES", 1.8, 1.8, 0);
    
    if (!configurando_tecla) {
        var opcoes_controles = [
            "Player 1 - Cima: " + chr(global.controle_p1_cima),
            "Player 1 - Baixo: " + chr(global.controle_p1_baixo),
            "Player 1 - Esquerda: " + chr(global.controle_p1_esquerda),
            "Player 1 - Direita: " + chr(global.controle_p1_direita),
            "",
            "Player 2 - Cima: " + chr(global.controle_p2_cima),
            "Player 2 - Baixo: " + chr(global.controle_p2_baixo),
            "Player 2 - Esquerda: " + chr(global.controle_p2_esquerda),
            "Player 2 - Direita: " + chr(global.controle_p2_direita),
            "",
            "Pausa: ESC",
            "",
            "RESTAURAR PADRAO",
            "",
            "VOLTAR"
        ];
        
        var indices_selecionaveis = [0, 1, 2, 3, 5, 6, 7, 8, 10, 12, 14];
        var indice_real = indices_selecionaveis[opcao_selecionada];
        
        // ✨ BACKGROUND GERAL DAS OPÇÕES
        draw_set_alpha(0.6);
        draw_rectangle_color(centro_x - 220, centro_y - 150, centro_x + 220, centro_y + 140,
                            c_black, c_black, c_black, c_black, false);
        draw_set_alpha(1);
        
        for (var i = 0; i < array_length(opcoes_controles); i++) {
            if (opcoes_controles[i] != "") {
                var pos_y_ctrl = centro_y - 130 + (i * 18);
                
                // ✨ BACKGROUND DA OPÇÃO SELECIONADA
                if (i == indice_real) {
                    draw_set_alpha(0.8);
                    draw_rectangle_color(centro_x - 180, pos_y_ctrl - 10, centro_x + 180, pos_y_ctrl + 10,
                                        make_color_rgb(40, 40, 40), make_color_rgb(40, 40, 40), 
                                        make_color_rgb(40, 40, 40), make_color_rgb(40, 40, 40), false);
                    draw_set_alpha(1);
                }
                
                var cor = (i == indice_real) ? cor_laranja : c_white;
                var escala = (i == indice_real) ? 1.1 : 1;
                
                if (i == indice_real) {
                    draw_set_color(cor);
                    draw_text_transformed(centro_x, pos_y_ctrl, "> " + opcoes_controles[i] + " <", escala, escala, 0);
                } else {
                    draw_set_color(cor);
                    draw_text_transformed(centro_x, pos_y_ctrl, opcoes_controles[i], escala, escala, 0);
                }
            }
        }
        
        // ✨ BACKGROUND DAS INSTRUÇÕES
        draw_set_alpha(0.5);
        draw_rectangle_color(centro_x - 150, centro_y + 145, centro_x + 150, centro_y + 175,
                            c_black, c_black, c_black, c_black, false);
        draw_set_alpha(1);
        
        // Instruções
        draw_set_color(c_white);
        draw_text(centro_x, centro_y + 160, "ENTER para alterar • ESC para voltar");
    }
    else {
        // ✨ BACKGROUND DA CONFIGURAÇÃO DE TECLA
        draw_set_alpha(0.8);
        draw_rectangle_color(centro_x - 180, centro_y - 60, centro_x + 180, centro_y + 120,
                            c_black, c_black, c_black, c_black, false);
        draw_set_alpha(1);
        
        // CONFIGURANDO TECLA
        draw_set_color(cor_laranja);
        draw_text_transformed(centro_x, centro_y - 40, "Pressione a nova tecla para:", 1.5, 1.5, 0);
        
        var nome_acao = "";
        switch(tecla_sendo_configurada) {
            case "p1_cima": nome_acao = "Player 1 - Cima"; break;
            case "p1_baixo": nome_acao = "Player 1 - Baixo"; break;
            case "p1_esquerda": nome_acao = "Player 1 - Esquerda"; break;
            case "p1_direita": nome_acao = "Player 1 - Direita"; break;
            case "p2_cima": nome_acao = "Player 2 - Cima"; break;
            case "p2_baixo": nome_acao = "Player 2 - Baixo"; break;
            case "p2_esquerda": nome_acao = "Player 2 - Esquerda"; break;
            case "p2_direita": nome_acao = "Player 2 - Direita"; break;
            case "pausa": nome_acao = "Pausa"; break;
        }
        
        draw_set_color(cor_verde);
        draw_text_transformed(centro_x, centro_y + 20, nome_acao, 2, 2, 0);
        
        draw_set_color(c_white);
        draw_text(centro_x, centro_y + 80, "ESC para cancelar");
        
        // Efeito piscante com cor da paleta
        var alpha_pisca = sin(current_time / 300) * 0.3 + 0.7;
        draw_set_alpha(alpha_pisca);
        draw_set_color(cor_roxo);
        draw_text(centro_x, centro_y + 100, "Aguardando tecla...");
        draw_set_alpha(1);
    }
}

// Reset configurações
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
