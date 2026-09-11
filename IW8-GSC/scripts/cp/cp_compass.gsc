/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_compass.gsc
***********************************************/

function setupminimap(var_0, var_1) {
  var_2 = getdvarfloat("scr_RequiredMapAspectratio", 1);
  var_3 = [];
  var_4 = getEntArray("minimap_corner", "targetname");

  if(var_4.size < 1) {
    return;
  }

  var_3 = [var_4[0], var_4[1]];
  var_5 = getDvar("NSQLTTMRMP");

  switch (var_5) {
    case "cp_dntsk_raid":
      var_3[0].origin = (-65536, 86016, 0);
      var_3[1].origin = (81920, -61440, 0);
      break;
    case "cp_dwn_twn_2":
      var_3[0].origin = (44048, -32792, -152);
      var_3[1].origin = (-1008, 12264, -152);
      break;
    case "cp_arms_dealer":
      var_3[0].origin = (-33792, 23552, 0);
      var_3[1].origin = (-2048, -8192, 0);
      break;
    case "cp_armsdealer_2":
      var_3[0].origin = (-49152, -24576, 0);
      var_3[1].origin = (16384, 40960, 0);
      break;
    case "cp_smuggler":
      var_3[0].origin = (-24576, 65536, 0);
      var_3[1].origin = (45056, -4096, 0);
      break;
    case "cp_smuggler_2":
      var_3[0].origin = (14336, 53248, 0);
      var_3[1].origin = (47104, 20480, 0);
      break;
    case "cp_landlord":
      var_3[0].origin = (4096, 24576, 0);
      var_3[1].origin = (49152, -20480, 0);
      break;
    case "cp_landlord_2":
      var_3[0].origin = (-12288, 72704, 0);
      var_3[1].origin = (32768, 27648, 0);
      break;
    case "cp_raid_complex":
      var_6 = [var_4[0], var_4[1]];
      var_6[0].origin = (-2620, 8092, 0);
      var_6[1].origin = (3156, 3486, 0);
      ref_1325d("compass_map_cp_jugg_maze", var_6, var_2);
      var_3[0].origin = (-5508, 10395, 0);
      var_3[1].origin = (6044, 1183, 0);
      break;
  }

  var_7 = (var_3[0].origin[0], var_3[0].origin[1], 0);
  var_8 = (var_3[1].origin[0], var_3[1].origin[1], 0);
  var_9 = var_8 - var_7;
  var_10 = (cos(getnorthyaw()), sin(getnorthyaw()), 0);
  var_11 = (0 - var_10[1], var_10[0], 0);

  if(vectordot(var_9, var_11) > 0) {
    jumpiffalse(vectordot(var_9, var_10) > 0) LOC_00000320;
    var_12 = var_8;
    var_13 = var_7;
    goto LOC_0000033f;
  } else if(vectordot(var_13, var_12) > 0) {
    var_14 = vecscale(var_12, vectordot(var_13, var_12));
    var_12 = var_11 + var_14;
    var_13 = var_12 - var_14;
  } else {
    var_12 = var_13;
    var_13 = var_12;
  }

  if(var_9 > 0) {
    var_15 = vectordot(var_12 - var_13, var_12);
    var_16 = vectordot(var_12 - var_13, var_13);
    var_17 = var_16 / var_15;

    if(var_17 < var_9) {
      var_18 = var_9 / var_17;
      var_19 = vecscale(var_13, var_16 * (var_18 - 1) * 0.5);
    } else {
      var_18 = var_19 / var_11;
      var_19 = vecscale(var_12, var_17 * (var_18 - 1) * 0.5);
    }

    var_15 += var_19;
    var_16 -= var_19;
  }

  var_12[0].origin = var_15;
  var_12[1].origin = var_16;
  level.mapsize = vectordot(var_15 - var_16, var_12);
  level.mapcorners = var_12;
  level.mapcorners[0].angles = generateaxisanglesfromforwardvector(vectorNormalize(level.mapcorners[1].origin - level.mapcorners[0].origin), (0, 0, 1));
  level.mapcorners[0] addyaw(45);
  level.mapcorners[1].angles = generateaxisanglesfromforwardvector(vectorNormalize(level.mapcorners[0].origin - level.mapcorners[1].origin), (0, 0, 1));
  level.mapcorners[1] addyaw(45);

  if(!isDefined(var_10) || var_10 < 1) {
    var_10 = 1;
  }

  setminimap(var_9, var_15[0], var_15[1], var_16[0], var_16[1], var_10);
}

function ref_1325d(var_0, var_1, var_2) {
  var_3 = (var_1[0].origin[0], var_1[0].origin[1], 0);
  var_4 = (var_1[1].origin[0], var_1[1].origin[1], 0);
  var_5 = var_4 - var_3;
  var_6 = (cos(getnorthyaw()), sin(getnorthyaw()), 0);
  var_7 = (0 - var_6[1], var_6[0], 0);

  if(vectordot(var_5, var_7) > 0) {
    jumpiffalse(vectordot(var_5, var_6) > 0) LOC_0000007e;
    var_8 = var_4;
    var_9 = var_3;
    goto LOC_0000009d;
  } else if(vectordot(var_9, var_8) > 0) {
    var_10 = vecscale(var_8, vectordot(var_9, var_8));
    var_8 = var_7 + var_10;
    var_9 = var_8 - var_10;
  } else {
    var_8 = var_9;
    var_9 = var_8;
  }

  if(var_8 > 0) {
    var_11 = vectordot(var_8 - var_9, var_8);
    var_12 = vectordot(var_8 - var_9, var_9);
    var_13 = var_12 / var_11;

    if(var_13 < var_8) {
      var_14 = var_8 / var_13;
      var_15 = vecscale(var_9, var_12 * (var_14 - 1) * 0.5);
    } else {
      var_14 = var_15 / var_8;
      var_15 = vecscale(var_8, var_13 * (var_14 - 1) * 0.5);
    }

    var_11 += var_15;
    var_12 -= var_15;
  }

  brmatchstarted(var_8, var_11[0], var_11[1], var_12[0], var_12[1]);
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