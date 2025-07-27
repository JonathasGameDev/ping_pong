// Estado do menu
estado_menu = "principal"; // "principal", "dificuldade" ou "controles"
opcao_selecionada = 0;
opcao_dificuldade = 1;
total_opcoes_principal = 4; // VS PLAYER, VS IA, CONTROLES, SAIR

// ✨ NOVAS VARIÁVEIS PARA MOUSE
mouse_sobre_opcao = -1; // Qual opção o mouse está sobre (-1 = nenhuma)
mouse_clicou = false;
cursor_visible = true;

// Mostra o cursor do mouse
cursor_sprite = -1; // Usa cursor padrão do sistema
window_set_cursor(cr_default);

// Variáveis de controle
pode_navegar = true;
cooldown_navegacao = 0;

// Tipo de jogo escolhido
global.modo_jogo = "";
global.dificuldade_escolhida = 1;

// ===== VARIÁVEIS DE CONTROLES =====
configurando_tecla = false;
tecla_sendo_configurada = "";



// Define controles padrão se não existirem
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

if (!audio_is_playing(snd_fundo)) {
    global.musica_id = audio_play_sound(snd_fundo, 1, true); // true = loop infinito
    audio_sound_gain(snd_fundo, 0.7, 0);
}

// Variáveis de controle
volume_musica = 0.7;
musica_ativa = true;

// ✨ VERIFICAÇÃO EXTRA NO STEP EVENT (opcional)
// Adicione isso no Step Event do mesmo objeto:
if (!audio_is_playing(snd_fundo) && musica_ativa) {
    global.musica_id = audio_play_sound(snd_fundo, 1, true);
    audio_sound_gain(snd_fundo, volume_musica, 0);
}

