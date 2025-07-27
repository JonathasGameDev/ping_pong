#region COOLDOWN DE NAVEGAÇÃO
if (cooldown_navegacao > 0) {
    cooldown_navegacao -= 1;
    pode_navegar = false;
} else {
    pode_navegar = true;
}
#endregion

#region CONTROLES DE TECLADO
if (pode_navegar) {
    if (keyboard_check_pressed(ord("W"))) {
        opcao_selecionada = (opcao_selecionada - 1 + total_opcoes) % total_opcoes;
        cooldown_navegacao = 10;
    }
    
    if (keyboard_check_pressed(ord("S"))) {
        opcao_selecionada = (opcao_selecionada + 1) % total_opcoes;
        cooldown_navegacao = 10;
    }
    
    if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)) {
        switch(opcao_selecionada) {
            case 0:
                if (instance_exists(obj_game_controller)) {
                    obj_game_controller.resumir_jogo();
                }
                break;
                
            case 1:
                if (instance_exists(obj_game_controller)) {
                    obj_game_controller.jogo_pausado = false;
                }
                room_goto(rm_menu);
                break;
        }
        cooldown_navegacao = 10;
    }
    
    if (keyboard_check_pressed(vk_escape)) {
        if (instance_exists(obj_game_controller)) {
            obj_game_controller.resumir_jogo();
        }
    }
}
#endregion

#region CONTROLE DE MOUSE
var mouse_x_gui = device_mouse_x_to_gui(0);
var mouse_y_gui = device_mouse_y_to_gui(0);

var pos_y_resumir = (display_get_gui_height() / 2) - 10;
var pos_y_menu = (display_get_gui_height() / 2) + 30;

if (mouse_x_gui >= (display_get_gui_width() / 2) - 100 && 
    mouse_x_gui <= (display_get_gui_width() / 2) + 100) {
    
    if (mouse_y_gui >= pos_y_resumir - 20 && mouse_y_gui <= pos_y_resumir + 20) {
        opcao_selecionada = 0;
        window_set_cursor(cr_handpoint);
        
        if (mouse_check_button_pressed(mb_left)) {
            obj_game_controller.resumir_jogo();
        }
    }
    else if (mouse_y_gui >= pos_y_menu - 20 && mouse_y_gui <= pos_y_menu + 20) {
        opcao_selecionada = 1;
        window_set_cursor(cr_handpoint);
        
        if (mouse_check_button_pressed(mb_left)) {
            obj_game_controller.jogo_pausado = false;
            room_goto(rm_menu);
        }
    }
    else {
        window_set_cursor(cr_default);
    }
} else {
    window_set_cursor(cr_default);
}
#endregion
