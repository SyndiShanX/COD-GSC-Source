/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\325.gsc
**************************************/

setupminimap(var_0, var_1) {
  level._id_1E6A = var_0;

  if(!isDefined(level._loadstarted) && !isDefined(var_1)) {}

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

  level._id_1E6C = [];
  level._id_1E6C["top"] = var_9[1];
  level._id_1E6C["left"] = var_10[0];
  level._id_1E6C["bottom"] = var_10[1];
  level._id_1E6C["right"] = var_9[0];
  level._id_1E6D = level._id_1E6C["right"] - level._id_1E6C["left"];
  level._id_1E6E = level._id_1E6C["top"] - level._id_1E6C["bottom"];
  level.mapsize = vectordot(var_9 - var_10, var_7);
  setminimap(var_0, var_9[0], var_9[1], var_10[0], var_10[1]);
}

vecscale(var_0, var_1) {
  return (var_0[0] * var_1, var_0[1] * var_1, var_0[2] * var_1);
}