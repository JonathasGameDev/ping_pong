#region CONFIGURAÇÕES DO MENU
opcao_selecionada = 0;
total_opcoes = 3;
pode_navegar = true;
cooldown_navegacao = 0;
#endregion

#region EFEITOS VISUAIS
alpha_fundo = 0;
tempo_aparicao = 0;
duracao_aparicao = 60;
aparecendo = true;
#endregion

#region INFORMAÇÕES DA PARTIDA
vencedor = "";
placar_final_p1 = global.rodadas_vencidas_p1;
placar_final_p2 = global.rodadas_vencidas_p2;

if (global.rodadas_vencidas_p1 > global.rodadas_vencidas_p2) {
    vencedor = "PLAYER 1 VENCEU!";
} else {
    vencedor = "PLAYER 2 VENCEU!";
}
#endregion

#region CONTROLE DO JOGO
instance_deactivate_all(true);
instance_activate_object(obj_end_game_menu);
#endregion
