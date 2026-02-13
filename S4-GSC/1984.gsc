/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1984.gsc
*************************************************/

_id_D88B(var_0, var_1, var_2) {
  var_3 = getdvarfloat("#x3d853eac1ab480add", 1);

  if(!isDefined(var_1)) {
    var_1 = var_0;
  }

  var_4 = [];
  var_5 = getEntArray("minimap_corner", "targetname");

  if(isDefined(scripts\cp_mp\utility\game_utility::_id_6B18()) && scripts\mp\utility\game::getgametype() != "war" && scripts\cp_mp\utility\game_utility::_id_6B2D() != "mp_donetsk") {
    if(level._id_96CC != "locale_6") {
      var_4 = _id_6983(var_5, 1);

      if(var_4.size != 2) {
        var_4 = _id_6983(var_5, 0);
      }
    } else {
      var_4 = [];
      var_4[0] = spawn("script_origin", (-1040, 12288, -136));
      var_4[1] = spawn("script_origin", (44016, -32768, -136));
    }

    var_0 = var_0 + "_" + level._id_96CC;
    var_1 = var_1 + "_" + level._id_96CC;
  } else if(scripts\cp_mp\utility\game_utility::_id_6B2D() == "mp_donetsk" || scripts\cp_mp\utility\game_utility::_id_6B2D() == "mp_br_quarry") {
    var_4 = [];
    var_4[0] = spawn("script_origin", (-65536, 86016, 5400));
    var_4[1] = spawn("script_origin", (81920, -61440, -2048));
  } else
    var_4 = _id_6983(var_5, 0);

  if(var_4.size != 2) {
    return;
  }
  var_6 = (var_4[0].origin[0], var_4[0].origin[1], 0);
  var_7 = (var_4[1].origin[0], var_4[1].origin[1], 0);
  var_8 = var_7 - var_6;
  var_9 = (cos(_func_00B9()), sin(_func_00B9()), 0);
  var_10 = (0 - var_9[1], var_9[0], 0);

  if(vectordot(var_8, var_10) > 0) {
    if(vectordot(var_8, var_9) > 0) {
      var_11 = var_7;
      var_12 = var_6;
    } else {
      var_13 = _id_FFD7(var_9, vectordot(var_8, var_9));
      var_11 = var_7 - var_13;
      var_12 = var_6 + var_13;
    }
  } else if(vectordot(var_8, var_9) > 0) {
    var_13 = _id_FFD7(var_9, vectordot(var_8, var_9));
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
      var_18 = _id_FFD7(var_10, var_15 * (var_17 - 1) * 0.5);
    } else {
      var_17 = var_16 / var_3;
      var_18 = _id_FFD7(var_9, var_14 * (var_17 - 1) * 0.5);
    }

    var_11 = var_11 + var_18;
    var_12 = var_12 - var_18;
  }

  var_4[0].origin = var_11;
  var_4[1].origin = var_12;
  level._id_9AC7 = vectordot(var_11 - var_12, var_9);
  level._id_9AB1 = var_4;
  level._id_9AB1[0].angles = _func_030A(vectornormalize(level._id_9AB1[1].origin - level._id_9AB1[0].origin), (0, 0, 1));
  level._id_9AB1[0] _meth_8004(45.0);
  level._id_9AB1[1].angles = _func_030A(vectornormalize(level._id_9AB1[0].origin - level._id_9AB1[1].origin), (0, 0, 1));
  level._id_9AB1[1] _meth_8004(45.0);

  if(!isDefined(var_2) || var_2 < 1) {
    var_2 = 1;
  }

  _func_01E2(var_0, var_11[0], var_11[1], var_12[0], var_12[1], var_2, var_1);
}

_id_FFD7(var_0, var_1) {
  return (var_0[0] * var_1, var_0[1] * var_1, var_0[2] * var_1);
}

_id_6983(var_0, var_1) {
  var_2 = [];

  if(var_1) {
    foreach(var_4 in var_0) {
      if(isDefined(var_4._id_039B) && var_4._id_039B == level._id_96CC) {
        var_2[var_2.size] = var_4;
      }
    }
  } else {
    foreach(var_4 in var_0) {
      if(!isDefined(var_4._id_039B) || isDefined(var_4._id_039B) && !issubstr(var_4._id_039B, "locale")) {
        var_2[var_2.size] = var_4;
      }
    }
  }

  return var_2;
}