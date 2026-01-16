/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_compass.gsc
********************************/

setupminimap(var_0, var_1) {
  level.minimap_image = var_0;

  if(!isdefined(level._loadstarted) && !isdefined(var_1)) {}

  if(!isdefined(var_1))
    var_1 = "minimap_corner";

  var_2 = getdvarfloat("scr_requiredMapAspectRatio", 1);
  var_3 = getentarray(var_1, "targetname");

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
      var_10 = var_4;
    } else {
      var_11 = vecscale(var_7, vectordot(var_6, var_7));
      var_9 = var_5 - var_11;
      var_10 = var_4 + var_11;
    }
  } else if(vectordot(var_6, var_7) > 0) {
    var_11 = vecscale(var_7, vectordot(var_6, var_7));
    var_9 = var_4 + var_11;
    var_10 = var_5 - var_11;
  } else {
    var_9 = var_4;
    var_10 = var_5;
  }

  if(var_2 > 0) {
    var_12 = vectordot(var_9 - var_10, var_7);
    var_13 = vectordot(var_9 - var_10, var_8);
    var_14 = var_13 / var_12;

    if(var_14 < var_2) {
      var_15 = var_2 / var_14;
      var_16 = vecscale(var_8, var_13 * (var_15 - 1) * 0.5);
    } else {
      var_15 = var_14 / var_2;
      var_16 = vecscale(var_7, var_12 * (var_15 - 1) * 0.5);
    }

    var_9 = var_9 + var_16;
    var_10 = var_10 - var_16;
  }

  level.map_extents = [];
  level.map_extents["top"] = var_9[1];
  level.map_extents["left"] = var_10[0];
  level.map_extents["bottom"] = var_10[1];
  level.map_extents["right"] = var_9[0];
  level.map_width = level.map_extents["right"] - level.map_extents["left"];
  level.map_height = level.map_extents["top"] - level.map_extents["bottom"];
  level.mapsize = vectordot(var_9 - var_10, var_7);
  setminimap(var_0, var_9[0], var_9[1], var_10[0], var_10[1]);
}

vecscale(var_0, var_1) {
  return (var_0[0] * var_1, var_0[1] * var_1, var_0[2] * var_1);
}