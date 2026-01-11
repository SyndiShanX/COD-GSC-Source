/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2837.gsc
***************************************/

setupminimap(var_00, var_01) {
  level.func_B7AE = var_00;

  if(!isDefined(level.func_1307) && !isDefined(var_01)) {}

  if(!isDefined(var_01)) {
    var_01 = "minimap_corner";
  }

  var_02 = getdvarfloat("scr_requiredMapAspectRatio", 1);
  var_03 = getEntArray(var_01, "targetname");

  if(var_3.size != 2) {
    return;
  }
  var_04 = (var_3[0].origin[0], var_3[0].origin[1], 0);
  var_05 = (var_3[1].origin[0], var_3[1].origin[1], 0);
  var_06 = var_05 - var_04;
  var_07 = (cos(getnorthyaw()), sin(getnorthyaw()), 0);
  var_08 = (0 - var_7[1], var_7[0], 0);

  if(vectordot(var_06, var_08) > 0) {
    if(vectordot(var_06, var_07) > 0) {
      var_09 = var_05;
      var_10 = var_04;
    } else {
      var_11 = vecscale(var_07, vectordot(var_06, var_07));
      var_09 = var_05 - var_11;
      var_10 = var_04 + var_11;
    }
  } else if(vectordot(var_06, var_07) > 0) {
    var_11 = vecscale(var_07, vectordot(var_06, var_07));
    var_09 = var_04 + var_11;
    var_10 = var_05 - var_11;
  } else {
    var_09 = var_04;
    var_10 = var_05;
  }

  if(var_02 > 0) {
    var_12 = vectordot(var_09 - var_10, var_07);
    var_13 = vectordot(var_09 - var_10, var_08);
    var_14 = var_13 / var_12;

    if(var_14 < var_02) {
      var_15 = var_02 / var_14;
      var_16 = vecscale(var_08, var_13 * (var_15 - 1) * 0.5);
    } else {
      var_15 = var_14 / var_02;
      var_16 = vecscale(var_07, var_12 * (var_15 - 1) * 0.5);
    }

    var_09 = var_09 + var_16;
    var_10 = var_10 - var_16;
  }

  level.func_B322 = [];
  level.func_B322["top"] = var_9[1];
  level.func_B322["left"] = var_10[0];
  level.func_B322["bottom"] = var_10[1];
  level.func_B322["right"] = var_9[0];
  level.func_B32B = level.func_B322["right"] - level.func_B322["left"];
  level.func_B325 = level.func_B322["top"] - level.func_B322["bottom"];
  level.mapsize = vectordot(var_09 - var_10, var_07);
  setminimap(var_00, var_9[0], var_9[1], var_10[0], var_10[1]);
}

vecscale(var_00, var_01) {
  return (var_0[0] * var_01, var_0[1] * var_01, var_0[2] * var_01);
}