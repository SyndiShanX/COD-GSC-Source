/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\compass.gsc
***********************************************/

function setupminimap(var_0, var_1, var_2) {
  var_3 = getdvarfloat("scr_RequiredMapAspectratio", 1);

  if(!isDefined(var_1)) {
    var_1 = var_0;
  }

  var_4 = [];
  var_5 = getEntArray("minimap_corner", "targetname");

  if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()) && scripts\mp\utility\game::getgametype() != "war" && !scripts\cp_mp\utility\game_utility::unlink_on_ai_death()) {
    if(level.localeid != "locale_6") {
      var_4 = getcornersfromarray(var_5, 1);

      if(var_4.size != 2) {
        var_4 = getcornersfromarray(var_5, 0);
      }
    } else {
      var_4 = [];
      var_4 = spawn("script_origin", (-1040, 12288, -136));
      var_4 = spawn("script_origin", (44016, -32768, -136));
    }

    if(scripts\mp\utility\game::getgametype() == "arm") {
      var_0 = var_0 + "_" + level.localeid;
      var_1 = var_1 + "_" + level.localeid;
    }
  } else if(scripts\cp_mp\utility\game_utility::unlink_on_ai_death() || scripts\cp_mp\utility\game_utility::getmapname() == "mp_br_quarry") {
    var_4 = [];
    var_4 = spawn("script_origin", (-65536, 86016, 5400));
    var_4 = spawn("script_origin", (81920, -61440, -2048));
  } else {
    var_4 = getcornersfromarray(var_5, 0);
  }

  if(var_4.size != 2) {
    return;
  }

  var_6 = (var_4[0].origin[0], var_4[0].origin[1], 0);
  var_7 = (var_4[1].origin[0], var_4[1].origin[1], 0);
  var_8 = var_7 - var_6;
  var_9 = (cos(getnorthyaw()), sin(getnorthyaw()), 0);
  var_10 = (0 - var_9[1], var_9[0], 0);

  if(vectordot(var_8, var_10) > 0) {
    jumpiffalse(vectordot(var_8, var_9) > 0) LOC_000001b6;
    var_11 = var_7;
    var_12 = var_6;
    goto LOC_000001d5;
  } else if(vectordot(var_12, var_11) > 0) {
    var_13 = vecscale(var_11, vectordot(var_12, var_11));
    var_11 = var_10 + var_13;
    var_12 = var_11 - var_13;
  } else {
    var_11 = var_12;
    var_12 = var_11;
  }

  if(var_9 > 0) {
    var_14 = vectordot(var_11 - var_12, var_11);
    var_15 = vectordot(var_11 - var_12, var_12);
    var_16 = var_15 / var_14;

    if(var_16 < var_9) {
      var_17 = var_9 / var_16;
      var_18 = vecscale(var_12, var_15 * (var_17 - 1) * 0.5);
    } else {
      var_17 = var_18 / var_11;
      var_18 = vecscale(var_11, var_16 * (var_17 - 1) * 0.5);
    }

    var_14 += var_18;
    var_15 -= var_18;
  }

  var_12[0].origin = var_14;
  var_12[1].origin = var_15;
  level.mapsize = vectordot(var_14 - var_15, var_11);
  level.mapcorners = var_12;
  level.mapcorners[0].angles = generateaxisanglesfromforwardvector(vectorNormalize(level.mapcorners[1].origin - level.mapcorners[0].origin), (0, 0, 1));
  level.mapcorners[0] addyaw(45);
  level.mapcorners[1].angles = generateaxisanglesfromforwardvector(vectorNormalize(level.mapcorners[0].origin - level.mapcorners[1].origin), (0, 0, 1));
  level.mapcorners[1] addyaw(45);

  if(!isDefined(var_10) || var_10 < 1) {
    var_10 = 1;
  }

  setminimap(var_8, var_14[0], var_14[1], var_15[0], var_15[1], var_10, var_9);
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