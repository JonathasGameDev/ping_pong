#region CONFIGURAÇÕES BÁSICAS
draw_set_font(-1);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();
var centro_x = gui_w / 2;
var centro_y = gui_h / 2;

var cor_verde = make_color_rgb(20, 194, 80);
var cor_laranja = make_color_rgb(223, 77, 32);
var cor_roxo = make_color_rgb(84, 9, 55);
var cor_dourado = make_color_rgb(255, 215, 0);
var cor_vermelho = make_color_rgb(180, 50, 50);
#endregion

#region FUNDO E EFEITOS VISUAIS
draw_set_alpha(alpha_fundo * 0.85);
draw_rectangle_color(0, 0, gui_w, gui_h, c_black, c_black, c_black, c_black, false);
draw_set_alpha(1);

if (!aparecendo) {
    for (var p = 0; p < 15; p++) {
        var angle = (current_time / 10 + p * 24) % 360;
        var dist = 200 + sin(current_time / 80 + p) * 40;
        var part_x = centro_x + lengthdir_x(dist, angle);
        var part_y = centro_y - 50 + lengthdir_y(dist * 0.6, angle);
        
        draw_set_alpha(alpha_fundo * 0.7);
        draw_set_color(cor_dourado);
        draw_circle(part_x, part_y, 4, false);
        draw_set_color(c_yellow);
        draw_circle(part_x, part_y, 2, false);
    }
    draw_set_alpha(1);
}

draw_set_alpha(alpha_fundo * 0.9);
draw_rectangle_color(centro_x - 250, centro_y - 150, centro_x + 250, centro_y + 200,
                    c_black, c_black, c_black, c_black, false);
draw_set_alpha(1);
#endregion

#region TÍTULO DE VITÓRIA
draw_set_alpha(alpha_fundo);

draw_set_color(c_black);
draw_text_transformed(centro_x + 3, centro_y - 103, "🏆 FIM DE PARTIDA 🏆", 1.8, 1.8, 0);

draw_set_color(cor_dourado);
draw_text_transformed(centro_x, centro_y - 100, "🏆 FIM DE PARTIDA 🏆", 1.8, 1.8, 0);
#endregion

#region INFORMAÇÕES DO VENCEDOR
draw_set_color(c_black);
draw_text_transformed(centro_x + 2, centro_y - 52, vencedor, 2.2, 2.2, 0);

var cor_vencedor = (global.rodadas_vencidas_p1 > global.rodadas_vencidas_p2) ? cor_verde : cor_laranja;
draw_set_color(cor_vencedor);
draw_text_transformed(centro_x, centro_y - 50, vencedor, 2.2, 2.2, 0);
#endregion

#region PLACAR FINAL
draw_set_color(c_ltgray);
draw_text_transformed(centro_x, centro_y - 10, 
    "PLACAR FINAL: " + string(placar_final_p1) + " x " + string(placar_final_p2), 1.2, 1.2, 0);

draw_text_transformed(centro_x, centro_y + 15, 
    "Melhor de " + string(global.rodadas_para_vencer) + " rodadas", 0.9, 0.9, 0);
#endregion

#region OPÇÕES DO MENU
draw_set_color(c_white);
draw_text_transformed(centro_x, centro_y + 45, "O que você gostaria de fazer?", 1.3, 1.3, 0);

var opcoes = ["🔄 COMECAR NOVAMENTE", "🏠 MENU PRINCIPAL", "❌ SAIR DO JOGO"];
var cores_opcoes = [cor_verde, cor_roxo, cor_vermelho];

for (var i = 0; i < total_opcoes; i++) {
    var pos_y = centro_y + 80 + (i * 50);
    
    if (opcao_selecionada == i) {
        draw_set_alpha(alpha_fundo * 0.8);
        draw_rectangle_color(centro_x - 140, pos_y - 20, centro_x + 140, pos_y + 20,
                            make_color_rgb(40, 40, 40), make_color_rgb(40, 40, 40),
                            make_color_rgb(40, 40, 40), make_color_rgb(40, 40, 40), false);
        draw_set_alpha(alpha_fundo);
    }
    
    if (opcao_selecionada == i) {
        draw_set_color(cores_opcoes[i]);
        draw_text_transformed(centro_x, pos_y, "> " + opcoes[i] + " <", 1.3, 1.3, 0);
    } else {
        draw_set_alpha(alpha_fundo * 0.7);
        draw_set_color(c_white);
        draw_text_transformed(centro_x, pos_y, opcoes[i], 1.1, 1.1, 0);
        draw_set_alpha(alpha_fundo);
    }
}
#endregion

#region DESCRIÇÕES E INSTRUÇÕES
var descricoes = [
    "Nova partida com as mesmas configurações",
    "Voltar para escolher modo e configurações",
    "Fechar o jogo completamente"
];

draw_set_alpha(alpha_fundo * 0.6);
draw_set_color(c_ltgray);
draw_text_transformed(centro_x, centro_y + 240, descricoes[opcao_selecionada], 0.8, 0.8, 0);
draw_set_alpha(alpha_fundo);

draw_set_alpha(alpha_fundo * 0.8);
draw_set_color(c_ltgray);
draw_text_transformed(centro_x, centro_y + 270, "W/S para navegar • ENTER para confirmar", 0.8, 0.8, 0);
#endregion

#region RESET CONFIGURAÇÕES
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
#endregion
