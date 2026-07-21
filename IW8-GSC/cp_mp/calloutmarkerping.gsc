/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\calloutmarkerping.gsc
***********************************************/

setupminimap(var_0, var_1) {
  var_2 = getdvarfloat("_encstr_9B831B9BC64EF5A42B2EEA2DC9AC23A685C1146EC1596C8EE485A3D2B7", 1);
  var_3 = [];
  var_4 = getEntArray("_encstr_A6BC0F4183703022A7E3EFDE40DB48380B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = getcornersfromarray(var_4, 0);

  if(var_3.size != 2) {
    return;
  }
  var_5 = (var_3[0].origin[0], var_3[0].origin[1], 0);
  var_6 = (var_3[1].origin[0], var_3[1].origin[1], 0);
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

  if(var_2 > 0) {
    var_13 = vectordot(var_10 - var_11, var_8);
    var_14 = vectordot(var_10 - var_11, var_9);
    var_15 = var_14 / var_13;

    if(var_15 < var_2) {
      var_16 = var_2 / var_15;
      var_17 = vecscale(var_9, var_14 * (var_16 - 1) * 0.5);
    } else {
      var_16 = var_15 / var_2;
      var_17 = vecscale(var_8, var_13 * (var_16 - 1) * 0.5);
    }

    var_10 = var_10 + var_17;
    var_11 = var_11 - var_17;
  }

  var_3[0].origin = var_10;
  var_3[1].origin = var_11;
  level.mapsize = vectordot(var_10 - var_11, var_8);
  level.mapcorners = var_3;
  level.mapcorners[0].angles = generateaxisanglesfromforwardvector(vectorNormalize(level.mapcorners[1].origin - level.mapcorners[0].origin), (0, 0, 1));
  level.mapcorners[0] addyaw(45.0);
  level.mapcorners[1].angles = generateaxisanglesfromforwardvector(vectorNormalize(level.mapcorners[0].origin - level.mapcorners[1].origin), (0, 0, 1));
  level.mapcorners[1] addyaw(45.0);

  if(!isDefined(var_1) || var_1 < 1)
    var_1 = 1;

  setminimap(var_0, var_10[0], var_10[1], var_11[0], var_11[1], var_1);
}

vecscale(var_0, var_1) {
  return (var_0[0] * var_1, var_0[1] * var_1, var_0[2] * var_1);
}

getcornersfromarray(var_0, var_1) {
  var_2 = [];

  if(var_1) {
    foreach(var_4 in var_0) {
      if(isDefined(var_4.script_noteworthy) && var_4.script_noteworthy == level.localeid)
        var_2[var_2.size] = var_4;
    }
  } else {
    foreach(var_4 in var_0) {
      if(!isDefined(var_4.script_noteworthy) || isDefined(var_4.script_noteworthy) && !issubstr(var_4.script_noteworthy, "_encstr_82E007C2104628C1CF"))
        var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}