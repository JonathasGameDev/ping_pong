// Cooldown para navegação
if (cooldown_navegacao > 0) {
    cooldown_navegacao -= 1;
    pode_navegar = false;
} else {
    pode_navegar = true;
}

// ===== CONTROLE DO MOUSE =====
var mouse_x_gui = device_mouse_x_to_gui(0);
var mouse_y_gui = device_mouse_y_to_gui(0);
var mouse_clicou = mouse_check_button_pressed(mb_left);

// ===== MENU PRINCIPAL =====
if (estado_menu == "principal") {
    // ✨ DETECÇÃO DO MOUSE NAS OPÇÕES
    var mouse_sobre_opcao = -1;
    var centro_y = display_get_gui_height() / 2;
    var centro_x = display_get_gui_width() / 2;
    
    for (var i = 0; i < total_opcoes_principal; i++) {
        var pos_y = centro_y + (i * 50);
        
        // Área clicável da opção
        if (mouse_x_gui >= centro_x - 120 && 
            mouse_x_gui <= centro_x + 120 &&
            mouse_y_gui >= pos_y - 25 && 
            mouse_y_gui <= pos_y + 25) {
            
            mouse_sobre_opcao = i;
            
            // ✨ MOUSE MUDA A SELEÇÃO
            if (opcao_selecionada != i) {
                opcao_selecionada = i;
                window_set_cursor(cr_handpoint); // Cursor de mão
            }
        }
    }
    
    // Reset cursor se não está sobre nenhuma opção
    if (mouse_sobre_opcao == -1) {
        window_set_cursor(cr_default);
    }
    
    if (pode_navegar) {
        // Navegação para 4 opções
        if (keyboard_check_pressed(ord("W"))) {
            opcao_selecionada = (opcao_selecionada - 1 + total_opcoes_principal) % total_opcoes_principal;
            cooldown_navegacao = 10;
        }
        
        if (keyboard_check_pressed(ord("S"))) {
            opcao_selecionada = (opcao_selecionada + 1) % total_opcoes_principal;
            cooldown_navegacao = 10;
        }
        
        // ✨ CONFIRMAR COM ENTER, SPACE OU CLIQUE
        if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space) || mouse_clicou) {
            switch(opcao_selecionada) {
                case 0: // VS PLAYER 2
                    global.modo_jogo = "player";
                    room_goto(rm_game);
                    break;
                    
                case 1: // VS IA
                    estado_menu = "dificuldade";
                    opcao_selecionada = 0;
                    cooldown_navegacao = 10;
                    break;
                    
                case 2: // CONTROLES
                    estado_menu = "controles";
                    opcao_selecionada = 0;
                    cooldown_navegacao = 10;
                    break;
                    
                case 3: // SAIR
                    game_end();
                    break;
            }
        }
    }
}

// ===== MENU DE DIFICULDADE =====
else if (estado_menu == "dificuldade") {
    // ✨ DETECÇÃO DO MOUSE NAS DIFICULDADES
    var mouse_sobre_opcao = -1;
    var centro_y = display_get_gui_height() / 2;
    var centro_x = display_get_gui_width() / 2;
    
    for (var i = 0; i < 4; i++) {
        var pos_y = centro_y - 40 + (i * 50);
        var largura = (i == 3) ? 160 : 120; // Impossível é maior
        
        // Área clicável da dificuldade
        if (mouse_x_gui >= centro_x - largura && 
            mouse_x_gui <= centro_x + largura &&
            mouse_y_gui >= pos_y - 30 && 
            mouse_y_gui <= pos_y + 35) { // +35 para incluir descrição
            
            mouse_sobre_opcao = i;
            
            // ✨ MOUSE MUDA A SELEÇÃO
            if (opcao_dificuldade != i + 1) {
                opcao_dificuldade = i + 1;
                window_set_cursor(cr_handpoint);
            }
        }
    }
    
    // Reset cursor se não está sobre nenhuma opção
    if (mouse_sobre_opcao == -1) {
        window_set_cursor(cr_default);
    }
    
    if (pode_navegar) {
        // Navegação da dificuldade (4 opções: Fácil, Médio, Difícil, Impossível)
        if (keyboard_check_pressed(ord("W"))) {
            opcao_dificuldade -= 1;
            if (opcao_dificuldade < 1) opcao_dificuldade = 4;
            cooldown_navegacao = 10;
        }
        
        if (keyboard_check_pressed(ord("S"))) {
            opcao_dificuldade += 1;
            if (opcao_dificuldade > 4) opcao_dificuldade = 1;
            cooldown_navegacao = 10;
        }
        
        // ✨ CONFIRMAR COM ENTER, SPACE OU CLIQUE
        if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space) || mouse_clicou) {
            global.modo_jogo = "ia";
            global.dificuldade_escolhida = opcao_dificuldade;
            room_goto(rm_game);
        }
        
        // ✨ VOLTAR COM ESC OU BOTÃO DIREITO
        if (keyboard_check_pressed(vk_escape) || mouse_check_button_pressed(mb_right)) {
            estado_menu = "principal";
            opcao_selecionada = 1; // Volta para "VS COMPUTADOR"
            cooldown_navegacao = 10;
        }
    }
}

// ===== MENU DE CONTROLES =====
else if (estado_menu == "controles") {
    if (!configurando_tecla) {
        var opcoes_controles = [
            "Player 1 - Cima", "Player 1 - Baixo", "Player 1 - Esquerda", "Player 1 - Direita",
            "Player 2 - Cima", "Player 2 - Baixo", "Player 2 - Esquerda", "Player 2 - Direita",
            "Pausa", "RESTAURAR PADRÃO", "VOLTAR"
        ];
        var total_controles = array_length(opcoes_controles);
        var indices_selecionaveis = [0, 1, 2, 3, 5, 6, 7, 8, 10, 12, 14]; // Pula linhas vazias
        
        // ✨ DETECÇÃO DO MOUSE NOS CONTROLES
        var mouse_sobre_opcao = -1;
        var centro_y = display_get_gui_height() / 2;
        var centro_x = display_get_gui_width() / 2;
        
        for (var i = 0; i < array_length(indices_selecionaveis); i++) {
            var indice_real = indices_selecionaveis[i];
            var pos_y_ctrl = centro_y - 130 + (indice_real * 18);
            
            // Área clicável da opção
            if (mouse_x_gui >= centro_x - 180 && 
                mouse_x_gui <= centro_x + 180 &&
                mouse_y_gui >= pos_y_ctrl - 12 && 
                mouse_y_gui <= pos_y_ctrl + 12) {
                
                mouse_sobre_opcao = i;
                
                // ✨ MOUSE MUDA A SELEÇÃO
                if (opcao_selecionada != i) {
                    opcao_selecionada = i;
                    window_set_cursor(cr_handpoint);
                }
            }
        }
        
        // Reset cursor se não está sobre nenhuma opção
        if (mouse_sobre_opcao == -1) {
            window_set_cursor(cr_default);
        }
        
        if (pode_navegar) {
            if (keyboard_check_pressed(ord("W"))) {
                opcao_selecionada = (opcao_selecionada - 1 + total_controles) % total_controles;
                cooldown_navegacao = 10;
            }
            
            if (keyboard_check_pressed(ord("S"))) {
                opcao_selecionada = (opcao_selecionada + 1) % total_controles;
                cooldown_navegacao = 10;
            }
            
            // ✨ CONFIRMAR COM ENTER, SPACE OU CLIQUE
            if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space) || mouse_clicou) {
                switch(opcao_selecionada) {
                    case 0: tecla_sendo_configurada = "p1_cima"; configurando_tecla = true; break;
                    case 1: tecla_sendo_configurada = "p1_baixo"; configurando_tecla = true; break;
                    case 2: tecla_sendo_configurada = "p1_esquerda"; configurando_tecla = true; break;
                    case 3: tecla_sendo_configurada = "p1_direita"; configurando_tecla = true; break;
                    case 4: tecla_sendo_configurada = "p2_cima"; configurando_tecla = true; break;
                    case 5: tecla_sendo_configurada = "p2_baixo"; configurando_tecla = true; break;
                    case 6: tecla_sendo_configurada = "p2_esquerda"; configurando_tecla = true; break;
                    case 7: tecla_sendo_configurada = "p2_direita"; configurando_tecla = true; break;
                    case 8: tecla_sendo_configurada = "pausa"; configurando_tecla = true; break;
                    case 9: // RESTAURAR PADRÃO
                        global.controle_p1_cima = ord("W");
                        global.controle_p1_baixo = ord("S");
                        global.controle_p1_esquerda = ord("A");
                        global.controle_p1_direita = ord("D");
                        global.controle_p2_cima = ord("I");
                        global.controle_p2_baixo = ord("K");
                        global.controle_p2_esquerda = ord("J");
                        global.controle_p2_direita = ord("L");
                        global.controle_pausa = vk_escape;
                        cooldown_navegacao = 10;
                        break;
                    case 10: // VOLTAR
                        estado_menu = "principal";
                        opcao_selecionada = 2; // Volta para "CONTROLES"
                        cooldown_navegacao = 10;
                        break;
                }
            }
            
            // ✨ ESC OU BOTÃO DIREITO PARA VOLTAR
            if (keyboard_check_pressed(vk_escape) || mouse_check_button_pressed(mb_right)) {
                estado_menu = "principal";
                opcao_selecionada = 2; // Volta para "CONTROLES"
                cooldown_navegacao = 10;
            }
        }
    }
    else {
        // CONFIGURANDO UMA TECLA
        for (var i = 8; i < 256; i++) { // Começa do 8 para evitar teclas especiais
            if (keyboard_check_pressed(i)) {
                // Salva a nova tecla
                switch(tecla_sendo_configurada) {
                    case "p1_cima": global.controle_p1_cima = i; break;
                    case "p1_baixo": global.controle_p1_baixo = i; break;
                    case "p1_esquerda": global.controle_p1_esquerda = i; break;
                    case "p1_direita": global.controle_p1_direita = i; break;
                    case "p2_cima": global.controle_p2_cima = i; break;
                    case "p2_baixo": global.controle_p2_baixo = i; break;
                    case "p2_esquerda": global.controle_p2_esquerda = i; break;
                    case "p2_direita": global.controle_p2_direita = i; break;
                    case "pausa": global.controle_pausa = i; break;
                }
                
                configurando_tecla = false;
                tecla_sendo_configurada = "";
                cooldown_navegacao = 10;
                break;
            }
        }
        
        // ✨ ESC OU BOTÃO DIREITO PARA CANCELAR
        if (keyboard_check_pressed(vk_escape) || mouse_check_button_pressed(mb_right)) {
            configurando_tecla = false;
            tecla_sendo_configurada = "";
            cooldown_navegacao = 10;
        }
    }
}
