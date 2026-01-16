/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\_compass.gsc
********************************/

setupminimap(var_0) {
  var_1 = level.requiredmapaspectratio;
  var_2 = getentarray("minimap_corner", "targetname");

  if(var_2.size != 2) {
    return;
  }
  var_3 = (var_2[0].origin[0], var_2[0].origin[1], 0);
  var_4 = (var_2[1].origin[0], var_2[1].origin[1], 0);
  var_5 = var_4 - var_3;
  var_6 = (cos(getnorthyaw()), sin(getnorthyaw()), 0);
  var_7 = (0 - var_6[1], var_6[0], 0);

  if(vectordot(var_5, var_7) > 0) {
    if(vectordot(var_5, var_6) > 0) {
      var_8 = var_4;
      var_9 = var_3;
    } else {
      var_10 = vecscale(var_6, vectordot(var_5, var_6));
      var_8 = var_4 - var_10;
      var_9 = var_3 + var_10;
    }
  } else if(vectordot(var_5, var_6) > 0) {
    var_10 = vecscale(var_6, vectordot(var_5, var_6));
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
      var_15 = vecscale(var_7, var_12 * (var_14 - 1) * 0.5);
    } else {
      var_14 = var_13 / var_1;
      var_15 = vecscale(var_6, var_11 * (var_14 - 1) * 0.5);
    }

    var_8 = var_8 + var_15;
    var_9 = var_9 - var_15;
  }

  level.mapsize = vectordot(var_8 - var_9, var_6);
  setminimap(var_0, var_8[0], var_8[1], var_9[0], var_9[1]);
}

vecscale(var_0, var_1) {
  return (var_0[0] * var_1, var_0[1] * var_1, var_0[2] * var_1);
}