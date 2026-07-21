/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\compass.gsc
***********************************************/

setupminimap(var_0, var_1, var_2) {
  level.minimap_image = var_0;

  if(!isDefined(var_1))
    var_1 = "minimap_corner";

  var_3 = getdvarfloat("scr_requiredMapAspectRatio", 1);
  var_4 = getEntArray(var_1, "targetname");

  if(var_4.size != 2) {
    return;
  }
  var_5 = (var_4[0].origin[0], var_4[0].origin[1], 0);
  var_6 = (var_4[1].origin[0], var_4[1].origin[1], 0);
  var_7 = var_6 - var_5;
  var_8 = (cos(getnorthyaw()), sin(getnorthyaw()), 0);
  var_9 = (0 - var_8[1], var_8[0], 0);

  if(vectordot(var_7, var_9) > 0) {
    if(vectordot(var_7, var_8) > 0) {
      var_10 = var_6;
      var_11 = var_5;
    } else {
      var_12 = vecscale(var_8, vectordot(var_7, var_8));
      var_10 = var_6 - var_12;
      var_11 = var_5 + var_12;
    }
  } else if(vectordot(var_7, var_8) > 0) {
    var_12 = vecscale(var_8, vectordot(var_7, var_8));
    var_10 = var_5 + var_12;
    var_11 = var_6 - var_12;
  } else {
    var_10 = var_5;
    var_11 = var_6;
  }

  if(var_3 > 0) {
    var_13 = vectordot(var_10 - var_11, var_8);
    var_14 = vectordot(var_10 - var_11, var_9);
    var_15 = var_14 / var_13;

    if(var_15 < var_3) {
      var_16 = var_3 / var_15;
      var_17 = vecscale(var_9, var_14 * (var_16 - 1) * 0.5);
    } else {
      var_16 = var_15 / var_3;
      var_17 = vecscale(var_8, var_13 * (var_16 - 1) * 0.5);
    }

    var_10 = var_10 + var_17;
    var_11 = var_11 - var_17;
  }

  level.map_extents = [];
  level.map_extents["top"] = var_10[1];
  level.map_extents["left"] = var_11[0];
  level.map_extents["bottom"] = var_11[1];
  level.map_extents["right"] = var_10[0];
  level.map_width = level.map_extents["right"] - level.map_extents["left"];
  level.map_height = level.map_extents["top"] - level.map_extents["bottom"];
  level.mapsize = vectordot(var_10 - var_11, var_8);

  if(!isDefined(var_2) || var_2 < 1)
    var_2 = 1;

  setminimap(var_0, var_10[0], var_10[1], var_11[0], var_11[1], var_2);
}

vecscale(var_0, var_1) {
  return (var_0[0] * var_1, var_0[1] * var_1, var_0[2] * var_1);
}