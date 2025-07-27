#region MOVIMENTO DOS OLHOS SEGUINDO A BOLA
var bola = instance_find(obj_ball, 0);

if (bola != noone) {
    var centro_x = xstart;
    var centro_y = ystart;
    var limite = 26;
    
    var dir = point_direction(centro_x, centro_y, bola.x, bola.y);
    
    x = centro_x + lengthdir_x(limite, dir);
    y = centro_y + lengthdir_y(limite, dir);
}
#endregion
