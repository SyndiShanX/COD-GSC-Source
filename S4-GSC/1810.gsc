/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1810.gsc
*************************************************/

_id_D88B(var_0, var_1) {
  var_2 = getdvarfloat("#x3d853eac1ab480add", 1);
  var_3 = [];
  var_4 = getEntArray("minimap_corner", "targetname");

  if(var_4.size < 1) {
    return;
  }
  var_3 = [var_4[0], var_4[1]];
  var_5 = getDvar("#x36d16f02578d0ee10");

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
      _id_D88C("compass_map_cp_jugg_maze", var_6, var_2);
      var_3[0].origin = (-5508, 10395, 0);
      var_3[1].origin = (6044, 1183, 0);
      break;
  }

  var_7 = (var_3[0].origin[0], var_3[0].origin[1], 0);
  var_8 = (var_3[1].origin[0], var_3[1].origin[1], 0);
  var_9 = var_8 - var_7;
  var_10 = (cos(_func_00B9()), sin(_func_00B9()), 0);
  var_11 = (0 - var_10[1], var_10[0], 0);

  if(vectordot(var_9, var_11) > 0) {
    if(vectordot(var_9, var_10) > 0) {
      var_12 = var_8;
      var_13 = var_7;
    } else {
      var_14 = _id_FFD7(var_10, vectordot(var_9, var_10));
      var_12 = var_8 - var_14;
      var_13 = var_7 + var_14;
    }
  } else if(vectordot(var_9, var_10) > 0) {
    var_14 = _id_FFD7(var_10, vectordot(var_9, var_10));
    var_12 = var_7 + var_14;
    var_13 = var_8 - var_14;
  } else {
    var_12 = var_7;
    var_13 = var_8;
  }

  if(var_2 > 0) {
    var_15 = vectordot(var_12 - var_13, var_10);
    var_16 = vectordot(var_12 - var_13, var_11);
    var_17 = var_16 / var_15;

    if(var_17 < var_2) {
      var_18 = var_2 / var_17;
      var_19 = _id_FFD7(var_11, var_16 * (var_18 - 1) * 0.5);
    } else {
      var_18 = var_17 / var_2;
      var_19 = _id_FFD7(var_10, var_15 * (var_18 - 1) * 0.5);
    }

    var_12 = var_12 + var_19;
    var_13 = var_13 - var_19;
  }

  var_3[0].origin = var_12;
  var_3[1].origin = var_13;
  level._id_9AC7 = vectordot(var_12 - var_13, var_10);
  level._id_9AB1 = var_3;
  level._id_9AB1[0].angles = _func_030A(vectornormalize(level._id_9AB1[1].origin - level._id_9AB1[0].origin), (0, 0, 1));
  level._id_9AB1[0] _meth_8004(45.0);
  level._id_9AB1[1].angles = _func_030A(vectornormalize(level._id_9AB1[0].origin - level._id_9AB1[1].origin), (0, 0, 1));
  level._id_9AB1[1] _meth_8004(45.0);

  if(!isDefined(var_1) || var_1 < 1) {
    var_1 = 1;
  }

  _func_01E2(var_0, var_12[0], var_12[1], var_13[0], var_13[1], var_1);
}

_id_D88C(var_0, var_1, var_2) {
  var_3 = (var_1[0].origin[0], var_1[0].origin[1], 0);
  var_4 = (var_1[1].origin[0], var_1[1].origin[1], 0);
  var_5 = var_4 - var_3;
  var_6 = (cos(_func_00B9()), sin(_func_00B9()), 0);
  var_7 = (0 - var_6[1], var_6[0], 0);

  if(vectordot(var_5, var_7) > 0) {
    if(vectordot(var_5, var_6) > 0) {
      var_8 = var_4;
      var_9 = var_3;
    } else {
      var_10 = _id_FFD7(var_6, vectordot(var_5, var_6));
      var_8 = var_4 - var_10;
      var_9 = var_3 + var_10;
    }
  } else if(vectordot(var_5, var_6) > 0) {
    var_10 = _id_FFD7(var_6, vectordot(var_5, var_6));
    var_8 = var_3 + var_10;
    var_9 = var_4 - var_10;
  } else {
    var_8 = var_3;
    var_9 = var_4;
  }

  if(var_2 > 0) {
    var_11 = vectordot(var_8 - var_9, var_6);
    var_12 = vectordot(var_8 - var_9, var_7);
    var_13 = var_12 / var_11;

    if(var_13 < var_2) {
      var_14 = var_2 / var_13;
      var_15 = _id_FFD7(var_7, var_12 * (var_14 - 1) * 0.5);
    } else {
      var_14 = var_13 / var_2;
      var_15 = _id_FFD7(var_6, var_11 * (var_14 - 1) * 0.5);
    }

    var_8 = var_8 + var_15;
    var_9 = var_9 - var_15;
  }

  _func_0423(var_0, var_8[0], var_8[1], var_9[0], var_9[1]);
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