/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\compass.gsc
*********************************************/

setupminimap(var_0) {
  var_1 = getdvarfloat("scr_RequiredMapAspectratio", 1);
  var_2 = getEntArray("minimap_corner", "targetname");
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
      var_0A = vecscale(var_8, vectordot(var_7, var_8));
      var_8 = var_4 - var_0A;
      var_9 = var_3 + var_0A;
    }
  } else if(vectordot(var_7, var_8) > 0) {
    var_0A = vecscale(var_8, vectordot(var_7, var_8));
    var_8 = var_3 + var_0A;
    var_9 = var_4 - var_0A;
  } else {
    var_8 = var_5;
    var_9 = var_5;
  }

  if(getdvar("mapname") == "mp_boneyard_ns") {
    var_9 = var_9 - (220, 220, 0);
    var_8 = var_8 + (220, 220, 0);
  }

  if(var_1 > 0) {
    var_0B = vectordot(var_8 - var_9, var_6);
    var_0C = vectordot(var_8 - var_9, var_7);
    var_0D = var_0C / var_0B;
    if(var_0D < var_1) {
      var_0E = var_1 / var_0D;
      var_0F = vecscale(var_7, var_0C * var_0E - 1 * 0.5);
    } else {
      var_0E = var_0F / var_3;
      var_0F = vecscale(var_7, var_0C * var_0F - 1 * 0.5);
    }

    var_8 = var_8 + var_0F;
    var_9 = var_9 - var_0F;
  }

  level.mapsize = vectordot(var_8 - var_9, var_6);
  setminimap(var_0, var_8[0], var_8[1], var_9[0], var_9[1]);
}

vecscale(var_0, var_1) {
  return (var_0[0] * var_1, var_0[1] * var_1, var_0[2] * var_1);
}