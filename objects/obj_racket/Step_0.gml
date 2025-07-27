#region SISTEMA DE BOOST
velocidade_boost = clamp(velocidade_boost, 0, velocidade_boost_max);
velocidade = velocidade_base + velocidade_boost;

if (instance_exists(obj_game_controller) && obj_game_controller.partida_finalizada) {
    exit;
}

pos_anterior_x = x;
pos_anterior_y = y;

if (tempo_boost > 0) {
    tempo_boost -= 1;
} else {
    velocidade_boost = max(velocidade_boost - 0.2, 0);
}
#endregion

#region CONTROLES DO PLAYER 1
var t_up    = (variable_global_exists("controle_p1_cima")     && global.controle_p1_cima    > 0) ? global.controle_p1_cima    : ord("W");
var t_down  = (variable_global_exists("controle_p1_baixo")    && global.controle_p1_baixo   > 0) ? global.controle_p1_baixo   : ord("S");
var t_left  = (variable_global_exists("controle_p1_esquerda") && global.controle_p1_esquerda> 0) ? global.controle_p1_esquerda: ord("A");
var t_right = (variable_global_exists("controle_p1_direita")  && global.controle_p1_direita > 0) ? global.controle_p1_direita : ord("D");

if (keyboard_check(t_up))    y -= velocidade;
if (keyboard_check(t_down))  y += velocidade;
if (keyboard_check(t_left))  x -= velocidade;
if (keyboard_check(t_right)) x += velocidade;
#endregion

#region VELOCIDADE INSTANTÂNEA E LIMITES
velocidade_instantanea_x = x - pos_anterior_x;
velocidade_instantanea_y = y - pos_anterior_y;

if (y <= 128) y = 128;
if (y >= 640) y = 640;
if (x <= 128) x = 128;
if (x >= 640) x = 640;
#endregion
