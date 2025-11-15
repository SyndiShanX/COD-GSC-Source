/**********************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\compass.gsc
**********************************/

setupminimap(param_00) {
  var_01 = getdvarfloat("scr_RequiredMapAspectratio", 1);
  var_02 = getEntArray("minimap_corner", "targetname");
  if(var_02.size != 2) {
    return;
  }

  var_03 = (var_02[0].origin[0], var_02[0].origin[1], 0);
  var_04 = (var_02[1].origin[0], var_02[1].origin[1], 0);
  var_05 = var_04 - var_03;
  var_06 = (cos(getnorthyaw()), sin(getnorthyaw()), 0);
  var_07 = (0 - var_06[1], var_06[0], 0);
  if(vectordot(var_05, var_07) > 0) {
    if(vectordot(var_05, var_06) > 0) {
      var_08 = var_04;
      var_09 = var_03;
    } else {
      var_0A = vecscale(var_08, vectordot(var_07, var_08));
      var_08 = var_04 - var_0A;
      var_09 = var_03 + var_0A;
    }
  } else if(vectordot(var_07, var_08) > 0) {
    var_0A = vecscale(var_08, vectordot(var_07, var_08));
    var_08 = var_03 + var_0A;
    var_09 = var_04 - var_0A;
  } else {
    var_08 = var_05;
    var_09 = var_05;
  }

  if(getdvar("mapname") == "mp_boneyard_ns") {
    var_09 = var_09 - (220, 220, 0);
    var_08 = var_08 + (220, 220, 0);
  }

  if(var_01 > 0) {
    var_0B = vectordot(var_08 - var_09, var_06);
    var_0C = vectordot(var_08 - var_09, var_07);
    var_0D = var_0C / var_0B;
    if(var_0D < var_01) {
      var_0E = var_01 / var_0D;
      var_0F = vecscale(var_07, var_0C * var_0E - 1 * 0.5);
    } else {
      var_0E = var_0F / var_03;
      var_0F = vecscale(var_07, var_0C * var_0F - 1 * 0.5);
    }

    var_08 = var_08 + var_0F;
    var_09 = var_09 - var_0F;
  }

  level.mapsize = vectordot(var_08 - var_09, var_06);
  setminimap(param_00, var_08[0], var_08[1], var_09[0], var_09[1]);
}

vecscale(param_00, param_01) {
  return (param_00[0] * param_01, param_00[1] * param_01, param_00[2] * param_01);
}