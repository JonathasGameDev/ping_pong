var bola = instance_find(obj_ball, 0);

if (bola != noone) {
    var centro_x = xstart; // Onde o olho foi criado
    var centro_y = ystart;
    var limite = 26; // Raio máximo que a pupila pode se mover
    
    // Direção da bola
    var dir = point_direction(centro_x, centro_y, bola.x, bola.y);
    
    // Move a pupila apenas até o limite
    x = centro_x + lengthdir_x(limite, dir);
    y = centro_y + lengthdir_y(limite, dir);
}
