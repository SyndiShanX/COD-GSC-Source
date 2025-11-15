/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2710.gsc
***************************************/

setupminimap(var_00) {
  var_01 = getdvarfloat("scr_RequiredMapAspectratio", 1);
  var_02 = getEntArray("minimap_corner", "targetname");

  if(var_2.size != 2) {
    return;
  }
  var_03 = (var_2[0].origin[0], var_2[0].origin[1], 0);
  var_04 = (var_2[1].origin[0], var_2[1].origin[1], 0);
  var_05 = var_04 - var_03;
  var_06 = (cos(getnorthyaw()), sin(getnorthyaw()), 0);
  var_07 = (0 - var_6[1], var_6[0], 0);

  if(vectordot(var_05, var_07) > 0) {
    if(vectordot(var_05, var_06) > 0) {
      var_08 = var_04;
      var_09 = var_03;
    } else {
      var_10 = vecscale(var_06, vectordot(var_05, var_06));
      var_08 = var_04 - var_10;
      var_09 = var_03 + var_10;
    }
  } else if(vectordot(var_05, var_06) > 0) {
    var_10 = vecscale(var_06, vectordot(var_05, var_06));
    var_08 = var_03 + var_10;
    var_09 = var_04 - var_10;
  } else {
    var_08 = var_03;
    var_09 = var_04;
  }

  if(getdvar("mapname") == "mp_boneyard_ns") {
    var_09 = var_09 - (220, 220, 0);
    var_08 = var_08 + (220, 220, 0);
  }

  if(var_01 > 0) {
    var_11 = vectordot(var_08 - var_09, var_06);
    var_12 = vectordot(var_08 - var_09, var_07);
    var_13 = var_12 / var_11;

    if(var_13 < var_01) {
      var_14 = var_01 / var_13;
      var_15 = vecscale(var_07, var_12 * (var_14 - 1) * 0.5);
    } else {
      var_14 = var_13 / var_01;
      var_15 = vecscale(var_06, var_11 * (var_14 - 1) * 0.5);
    }

    var_08 = var_08 + var_15;
    var_09 = var_09 - var_15;
  }

  level.mapsize = vectordot(var_08 - var_09, var_06);
  setminimap(var_00, var_8[0], var_8[1], var_9[0], var_9[1]);
}

vecscale(var_00, var_01) {
  return (var_0[0] * var_01, var_0[1] * var_01, var_0[2] * var_01);
}