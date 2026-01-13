/**********************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\sp\compass.gsc
**********************************/

setupminimap(var_0, var_1) {
  level.var_B7AE = var_0;
  if(!isDefined(level.var_1307) && !isDefined(var_1)) {}

  if(!isDefined(var_1)) {
    var_1 = "minimap_corner";
  }

  var_2 = getdvarfloat("scr_requiredMapAspectRatio", 1);
  var_3 = getEntArray(var_1, "targetname");
  if(var_3.size != 2) {
    return;
  }

  var_4 = (var_3[0].origin[0], var_3[0].origin[1], 0);
  var_5 = (var_3[1].origin[0], var_3[1].origin[1], 0);
  var_6 = var_5 - var_4;
  var_7 = (cos(getnorthyaw()), sin(getnorthyaw()), 0);
  var_8 = (0 - var_7[1], var_7[0], 0);
  if(vectordot(var_6, var_8) > 0) {
    if(vectordot(var_6, var_7) > 0) {
      var_9 = var_5;
      var_0A = var_4;
    } else {
      var_0B = vecscale(var_9, vectordot(var_8, var_9));
      var_9 = var_5 - var_0B;
      var_0A = var_4 + var_0B;
    }
  } else if(vectordot(var_8, var_9) > 0) {
    var_0B = vecscale(var_9, vectordot(var_8, var_9));
    var_9 = var_4 + var_0B;
    var_0A = var_5 - var_0B;
  } else {
    var_9 = var_6;
    var_0A = var_6;
  }

  if(var_2 > 0) {
    var_0C = vectordot(var_9 - var_0A, var_7);
    var_0D = vectordot(var_9 - var_0A, var_8);
    var_0E = var_0D / var_0C;
    if(var_0E < var_2) {
      var_0F = var_2 / var_0E;
      var_10 = vecscale(var_8, var_0D * var_0F - 1 * 0.5);
    } else {
      var_0F = var_10 / var_4;
      var_10 = vecscale(var_8, var_0D * var_10 - 1 * 0.5);
    }

    var_9 = var_9 + var_10;
    var_0A = var_0A - var_10;
  }

  level.var_B322 = [];
  level.var_B322["top"] = var_9[1];
  level.var_B322["left"] = var_0A[0];
  level.var_B322["bottom"] = var_0A[1];
  level.var_B322["right"] = var_9[0];
  level.var_B32B = level.var_B322["right"] - level.var_B322["left"];
  level.var_B325 = level.var_B322["top"] - level.var_B322["bottom"];
  level.mapsize = vectordot(var_9 - var_0A, var_7);
  setminimap(var_0, var_9[0], var_9[1], var_0A[0], var_0A[1]);
}

vecscale(var_0, var_1) {
  return (var_0[0] * var_1, var_0[1] * var_1, var_0[2] * var_1);
}