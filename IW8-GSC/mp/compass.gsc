/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\compass.gsc
***********************************************/

setupminimap(var_0, var_1, var_2) {
  var_3 = getdvarfloat("_encstr_9B831B9BC64EF5A42B2EEA2DC9AC23A685C1146EC1596C8EE485A3D2B7", 1);

  if(!isDefined(var_1))
    var_1 = var_0;

  var_4 = [];
  var_5 = getEntArray("_encstr_A6BC0F4183703022A7E3EFDE40DB48380B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()) && scripts\mp\utility\game::getgametype() != "_encstr_B41904BB8593" && !scripts\cp_mp\utility\game_utility::unlink_on_ai_death()) {
    if(level.localeid != "_encstr_8A34097127C761890FA9D2") {
      var_4 = getcornersfromarray(var_5, 1);

      if(var_4.size != 2)
        var_4 = getcornersfromarray(var_5, 0);
    } else {
      var_4 = [];
      var_4[0] = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (-1040, 12288, -136));
      var_4[1] = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (44016, -32768, -136));
    }

    if(scripts\mp\utility\game::getgametype() == "_encstr_B81904B04E6B") {
      var_0 = var_0 + "_encstr_BA4C02DF" + level.localeid;
      var_1 = var_1 + "_encstr_BA4C02DF" + level.localeid;
    }
  } else if(scripts\cp_mp\utility\game_utility::unlink_on_ai_death() || scripts\cp_mp\utility\game_utility::getmapname() == "_encstr_84E70D78D34F41EDF1A24D5F7AFB23") {
    var_4 = [];
    var_4[0] = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (-65536, 86016, 5400));
    var_4[1] = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (81920, -61440, -2048));
  } else
    var_4 = getcornersfromarray(var_5, 0);

  if(var_4.size != 2) {
    return;
  }
  var_6 = (var_4[0].origin[0], var_4[0].origin[1], 0);
  var_7 = (var_4[1].origin[0], var_4[1].origin[1], 0);
  var_8 = var_7 - var_6;
  var_9 = (cos(getnorthyaw()), sin(getnorthyaw()), 0);
  var_10 = (0 - var_9[1], var_9[0], 0);

  if(vectordot(var_8, var_10) > 0) {
    if(vectordot(var_8, var_9) > 0) {
      var_11 = var_7;
      var_12 = var_6;
    } else {
      var_13 = vecscale(var_9, vectordot(var_8, var_9));
      var_11 = var_7 - var_13;
      var_12 = var_6 + var_13;
    }
  } else if(vectordot(var_8, var_9) > 0) {
    var_13 = vecscale(var_9, vectordot(var_8, var_9));
    var_11 = var_6 + var_13;
    var_12 = var_7 - var_13;
  } else {
    var_11 = var_6;
    var_12 = var_7;
  }

  if(var_3 > 0) {
    var_14 = vectordot(var_11 - var_12, var_9);
    var_15 = vectordot(var_11 - var_12, var_10);
    var_16 = var_15 / var_14;

    if(var_16 < var_3) {
      var_17 = var_3 / var_16;
      var_18 = vecscale(var_10, var_15 * (var_17 - 1) * 0.5);
    } else {
      var_17 = var_16 / var_3;
      var_18 = vecscale(var_9, var_14 * (var_17 - 1) * 0.5);
    }

    var_11 = var_11 + var_18;
    var_12 = var_12 - var_18;
  }

  var_4[0].origin = var_11;
  var_4[1].origin = var_12;
  level.mapsize = vectordot(var_11 - var_12, var_9);
  level.mapcorners = var_4;
  level.mapcorners[0].angles = generateaxisanglesfromforwardvector(vectorNormalize(level.mapcorners[1].origin - level.mapcorners[0].origin), (0, 0, 1));
  level.mapcorners[0] addyaw(45.0);
  level.mapcorners[1].angles = generateaxisanglesfromforwardvector(vectorNormalize(level.mapcorners[0].origin - level.mapcorners[1].origin), (0, 0, 1));
  level.mapcorners[1] addyaw(45.0);

  if(!isDefined(var_2) || var_2 < 1)
    var_2 = 1;

  setminimap(var_0, var_11[0], var_11[1], var_12[0], var_12[1], var_2, var_1);
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