/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_compass.gsc
****************************************/

_id_8A2F(var_0) {
  var_1 = level._id_7D23;
  var_2 = getEntArray("minimap_corner", "targetname");

  if(var_2.size != 2) {
    return;
  }
  var_3 = (var_2[0].origin[0], var_2[0].origin[1], 0);
  var_4 = (var_2[1].origin[0], var_2[1].origin[1], 0);
  var_5 = var_4 - var_3;
  var_6 = (_cos(_getnorthyaw()), _sin(_getnorthyaw()), 0);
  var_7 = (0 - var_6[1], var_6[0], 0);

  if(vectordot(var_5, var_7) > 0) {
    if(vectordot(var_5, var_6) > 0) {
      var_8 = var_4;
      var_9 = var_3;
    } else {
      var_10 = _id_A2B5(var_6, vectordot(var_5, var_6));
      var_8 = var_4 - var_10;
      var_9 = var_3 + var_10;
    }
  } else if(vectordot(var_5, var_6) > 0) {
    var_10 = _id_A2B5(var_6, vectordot(var_5, var_6));
    var_8 = var_3 + var_10;
    var_9 = var_4 - var_10;
  } else {
    var_8 = var_3;
    var_9 = var_4;
  }

  if(var_1 > 0) {
    var_11 = vectordot(var_8 - var_9, var_6);
    var_12 = vectordot(var_8 - var_9, var_7);
    var_13 = var_12 / var_11;

    if(var_13 < var_1) {
      var_14 = var_1 / var_13;
      var_15 = _id_A2B5(var_7, var_12 * (var_14 - 1) * 0.5);
    } else {
      var_14 = var_13 / var_1;
      var_15 = _id_A2B5(var_6, var_11 * (var_14 - 1) * 0.5);
    }

    var_8 = var_8 + var_15;
    var_9 = var_9 - var_15;
  }

  level._id_5FF0 = vectordot(var_8 - var_9, var_6);
  _setminimap(var_0, var_8[0], var_8[1], var_9[0], var_9[1]);
}

_id_A2B5(var_0, var_1) {
  return (var_0[0] * var_1, var_0[1] * var_1, var_0[2] * var_1);
}