#region ESTADO E NAVEGAÇÃO DO MENU
estado_menu = "principal";
opcao_selecionada = 0;
opcao_dificuldade = 1;
total_opcoes_principal = 4;
pode_navegar = true;
cooldown_navegacao = 0;
#endregion

#region CONFIGURAÇÕES DE PARTIDA
rodadas_para_vencer = 1;
pontos_por_rodada = 1;
opcao_config = 0;

min_rodadas = 1;
max_rodadas = 10;
min_pontos = 1;
max_pontos = 20;
#endregion

#region CONTROLE DE MOUSE
mouse_sobre_opcao = -1;
mouse_clicou = false;
cursor_visible = true;
cursor_sprite = -1;
window_set_cursor(cr_default);
#endregion

#region MODO DE JOGO
global.modo_jogo = "";
global.dificuldade_escolhida = 1;
#endregion

#region CONFIGURAÇÃO DE CONTROLES
configurando_tecla = false;
tecla_sendo_configurada = "";

if (!variable_global_exists("controle_p1_cima")) {
    global.controle_p1_cima = ord("W");
    global.controle_p1_baixo = ord("S");
    global.controle_p1_esquerda = ord("A");
    global.controle_p1_direita = ord("D");
    
    global.controle_p2_cima = ord("I");
    global.controle_p2_baixo = ord("K");
    global.controle_p2_esquerda = ord("J");
    global.controle_p2_direita = ord("L");
    
    global.controle_pausa = vk_escape;
}
#endregion

#region SISTEMA DE ÁUDIO
volume_musica = 0.7;
musica_ativa = true;

if (!audio_is_playing(snd_fundo)) {
    global.musica_id = audio_play_sound(snd_fundo, 1, true);
    audio_sound_gain(snd_fundo, 0.7, 0);
}
#endregion
