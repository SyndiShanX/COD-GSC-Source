/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\calloutmarkerping.gsc
***********************************************/

function setupminimap(var_0, var_1) {
  var_2 = getdvarfloat("scr_RequiredMapAspectratio", 1);
  var_3 = [];
  var_4 = getEntArray("minimap_corner", "targetname");
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
    jumpiffalse(vectordot(var_7, var_8) > 0) LOC_000000ad;
    var_10 = var_6;
    var_11 = var_5;
    goto LOC_000000cc;
  } else if(vectordot(var_11, var_10) > 0) {
    var_12 = vecscale(var_10, vectordot(var_11, var_10));
    var_10 = var_9 + var_12;
    var_11 = var_10 - var_12;
  } else {
    var_10 = var_11;
    var_11 = var_10;
  }

  if(var_8 > 0) {
    var_13 = vectordot(var_10 - var_11, var_10);
    var_14 = vectordot(var_10 - var_11, var_11);
    var_15 = var_14 / var_13;

    if(var_15 < var_8) {
      var_16 = var_8 / var_15;
      var_17 = vecscale(var_11, var_14 * (var_16 - 1) * 0.5);
    } else {
      var_16 = var_17 / var_10;
      var_17 = vecscale(var_10, var_15 * (var_16 - 1) * 0.5);
    }

    var_13 += var_17;
    var_14 -= var_17;
  }

  var_11[0].origin = var_13;
  var_11[1].origin = var_14;
  level.mapsize = vectordot(var_13 - var_14, var_10);
  level.mapcorners = var_11;
  level.mapcorners[0].angles = generateaxisanglesfromforwardvector(vectorNormalize(level.mapcorners[1].origin - level.mapcorners[0].origin), (0, 0, 1));
  level.mapcorners[0] addyaw(45);
  level.mapcorners[1].angles = generateaxisanglesfromforwardvector(vectorNormalize(level.mapcorners[0].origin - level.mapcorners[1].origin), (0, 0, 1));
  level.mapcorners[1] addyaw(45);

  if(!isDefined(var_9) || var_9 < 1) {
    var_9 = 1;
  }

  setminimap(var_8, var_13[0], var_13[1], var_14[0], var_14[1], var_9);
}

function vecscale(var_0, var_1) {
  return (var_0[0] * var_1, var_0[1] * var_1, var_0[2] * var_1);
}

function getcornersfromarray(var_0, var_1) {
  var_2 = [];
  jumpiffalse(var_1) LOC_00000054;

  foreach(var_4 in var_0) {
    if(isDefined(var_4.script_noteworthy) && var_4.script_noteworthy == level.localeid) {
      var_2 = var_4;
    }
  }

  goto LOC_000000a8;
}