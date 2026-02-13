/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1774.gsc
*************************************************/

_id_D88B(var_0, var_1) {
  var_2 = getdvarfloat("#x3d853eac1ab480add", 1);
  var_3 = [];
  var_4 = getEntArray("minimap_corner", "targetname");
  var_3 = _id_6983(var_4, 0);

  if(var_3.size != 2) {
    return;
  }
  var_5 = (var_3[0].origin[0], var_3[0].origin[1], 0);
  var_6 = (var_3[1].origin[0], var_3[1].origin[1], 0);
  var_7 = var_6 - var_5;
  var_8 = (cos(_func_00B9()), sin(_func_00B9()), 0);
  var_9 = (0 - var_8[1], var_8[0], 0);

  if(vectordot(var_7, var_9) > 0) {
    if(vectordot(var_7, var_8) > 0) {
      var_10 = var_6;
      var_11 = var_5;
    } else {
      var_12 = _id_FFD7(var_8, vectordot(var_7, var_8));
      var_10 = var_6 - var_12;
      var_11 = var_5 + var_12;
    }
  } else if(vectordot(var_7, var_8) > 0) {
    var_12 = _id_FFD7(var_8, vectordot(var_7, var_8));
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
      var_17 = _id_FFD7(var_9, var_14 * (var_16 - 1) * 0.5);
    } else {
      var_16 = var_15 / var_2;
      var_17 = _id_FFD7(var_8, var_13 * (var_16 - 1) * 0.5);
    }

    var_10 = var_10 + var_17;
    var_11 = var_11 - var_17;
  }

  var_3[0].origin = var_10;
  var_3[1].origin = var_11;
  level._id_9AC7 = vectordot(var_10 - var_11, var_8);
  level._id_9AB1 = var_3;
  level._id_9AB1[0].angles = _func_030A(vectornormalize(level._id_9AB1[1].origin - level._id_9AB1[0].origin), (0, 0, 1));
  level._id_9AB1[0] _meth_8004(45.0);
  level._id_9AB1[1].angles = _func_030A(vectornormalize(level._id_9AB1[0].origin - level._id_9AB1[1].origin), (0, 0, 1));
  level._id_9AB1[1] _meth_8004(45.0);

  if(!isDefined(var_1) || var_1 < 1) {
    var_1 = 1;
  }

  _func_01E2(var_0, var_10[0], var_10[1], var_11[0], var_11[1], var_1);
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