/**********************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\sp\compass.gsc
**********************************/

setupminimap(param_00, param_01) {
  level.var_B7AE = param_00;
  if(!isDefined(level.var_1307) && !isDefined(param_01)) {}

  if(!isDefined(param_01)) {
    param_01 = "minimap_corner";
  }

  var_02 = getdvarfloat("scr_requiredMapAspectRatio", 1);
  var_03 = getEntArray(param_01, "targetname");
  if(var_03.size != 2) {
    return;
  }

  var_04 = (var_03[0].origin[0], var_03[0].origin[1], 0);
  var_05 = (var_03[1].origin[0], var_03[1].origin[1], 0);
  var_06 = var_05 - var_04;
  var_07 = (cos(getnorthyaw()), sin(getnorthyaw()), 0);
  var_08 = (0 - var_07[1], var_07[0], 0);
  if(vectordot(var_06, var_08) > 0) {
    if(vectordot(var_06, var_07) > 0) {
      var_09 = var_05;
      var_0A = var_04;
    } else {
      var_0B = vecscale(var_09, vectordot(var_08, var_09));
      var_09 = var_05 - var_0B;
      var_0A = var_04 + var_0B;
    }
  } else if(vectordot(var_08, var_09) > 0) {
    var_0B = vecscale(var_09, vectordot(var_08, var_09));
    var_09 = var_04 + var_0B;
    var_0A = var_05 - var_0B;
  } else {
    var_09 = var_06;
    var_0A = var_06;
  }

  if(var_02 > 0) {
    var_0C = vectordot(var_09 - var_0A, var_07);
    var_0D = vectordot(var_09 - var_0A, var_08);
    var_0E = var_0D / var_0C;
    if(var_0E < var_02) {
      var_0F = var_02 / var_0E;
      var_10 = vecscale(var_08, var_0D * var_0F - 1 * 0.5);
    } else {
      var_0F = var_10 / var_04;
      var_10 = vecscale(var_08, var_0D * var_10 - 1 * 0.5);
    }

    var_09 = var_09 + var_10;
    var_0A = var_0A - var_10;
  }

  level.var_B322 = [];
  level.var_B322["top"] = var_09[1];
  level.var_B322["left"] = var_0A[0];
  level.var_B322["bottom"] = var_0A[1];
  level.var_B322["right"] = var_09[0];
  level.var_B32B = level.var_B322["right"] - level.var_B322["left"];
  level.var_B325 = level.var_B322["top"] - level.var_B322["bottom"];
  level.mapsize = vectordot(var_09 - var_0A, var_07);
  setminimap(param_00, var_09[0], var_09[1], var_0A[0], var_0A[1]);
}

vecscale(param_00, param_01) {
  return (param_00[0] * param_01, param_00[1] * param_01, param_00[2] * param_01);
}