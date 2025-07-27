#region ANIMAÇÃO DE APARIÇÃO
if (aparecendo) {
    tempo_aparicao++;
    alpha_fundo = tempo_aparicao / duracao_aparicao;
    
    if (tempo_aparicao >= duracao_aparicao) {
        aparecendo = false;
        alpha_fundo = 1;
    }
    return;
}
#endregion

#region COOLDOWN DE NAVEGAÇÃO
if (cooldown_navegacao > 0) {
    cooldown_navegacao--;
    pode_navegar = false;
} else {
    pode_navegar = true;
}
#endregion

#region CONTROLE DE MOUSE
var mouse_x_gui = device_mouse_x_to_gui(0);
var mouse_y_gui = device_mouse_y_to_gui(0);
var mouse_clicou = mouse_check_button_pressed(mb_left);

var centro_x = display_get_gui_width() / 2;
var centro_y = display_get_gui_height() / 2;
var mouse_sobre_opcao = -1;

for (var i = 0; i < total_opcoes; i++) {
    var pos_y = centro_y + 80 + (i * 50);
    
    if (mouse_x_gui >= centro_x - 120 && 
        mouse_x_gui <= centro_x + 120 &&
        mouse_y_gui >= pos_y - 20 && 
        mouse_y_gui <= pos_y + 20) {
        
        mouse_sobre_opcao = i;
        
        if (opcao_selecionada != i) {
            opcao_selecionada = i;
            window_set_cursor(cr_handpoint);
        }
    }
}

if (mouse_sobre_opcao == -1) {
    window_set_cursor(cr_default);
}
#endregion

#region NAVEGAÇÃO POR TECLADO
if (pode_navegar) {
    if (keyboard_check_pressed(ord("W")) || keyboard_check_pressed(vk_up)) {
        opcao_selecionada = (opcao_selecionada - 1 + total_opcoes) % total_opcoes;
        cooldown_navegacao = 10;
    }
    
    if (keyboard_check_pressed(ord("S")) || keyboard_check_pressed(vk_down)) {
        opcao_selecionada = (opcao_selecionada + 1) % total_opcoes;
        cooldown_navegacao = 10;
    }
    
    if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space) || mouse_clicou) {
        switch(opcao_selecionada) {
            case 0:
                global.pontos_p1 = 0;
                global.pontos_p2 = 0;
                global.rodada_atual = 1;
                global.rodadas_vencidas_p1 = 0;
                global.rodadas_vencidas_p2 = 0;
                
                if (instance_exists(obj_game_controller)) {
                    obj_game_controller.partida_finalizada = false;
                    obj_game_controller.resetar_posicoes_raquetes();
                }
                
                instance_activate_all();
                room_restart();
                break;
                
            case 1:
                global.pontos_p1 = 0;
                global.pontos_p2 = 0;
                global.rodada_atual = 1;
                global.rodadas_vencidas_p1 = 0;
                global.rodadas_vencidas_p2 = 0;
                
                instance_activate_all();
                room_goto(rm_menu);
                break;
                
            case 2:
                game_end();
                break;
        }
    }
}
#endregion
