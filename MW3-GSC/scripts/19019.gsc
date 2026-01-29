/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\19019.gsc
**************************************/

_id_4A25(var_0, var_1, var_2, var_3, var_4) {
  var_5[0] = 3;
  var_6[0] = 3;
  var_7[0] = 30;
  var_8[0] = 4;
  var_9[0] = 0;
  var_5[1] = 8;
  var_6[1] = 8;
  var_7[1] = 10;
  var_8[1] = 1.75;
  var_9[1] = 45;
  var_5[2] = 2;
  var_6[2] = 2;
  var_7[2] = 0;
  var_8[2] = 2;
  var_9[2] = 315;
  maps\ocean_perlin::_id_4A19(var_0);

  for(var_10 = 0; var_10 < 3; var_10++) {
    var_0._id_4A26[var_10] = 0.0001 * var_1 * var_5[var_10];
    var_0._id_4A27[var_10] = 0.0001 * var_2 * var_6[var_10];
    var_0._id_4A28[var_10] = var_3 * var_7[var_10];
    var_0._id_4A29[var_10] = cos(var_9[var_10]) * var_4 * var_8[var_10];
    var_0._id_4A2A[var_10] = sin(var_9[var_10]) * var_4 * var_8[var_10];
  }

  var_0._id_4A2B = -0.5;
  var_0._id_4A2C = -0.5;
  var_0._id_4A2D = 0.0;
  var_0._id_4A2E = 1.0;
}

_id_4A2F() {
  var_0 = 1;
  var_1 = 1;
  var_2 = 1;
  var_3 = 0.025;
  level._id_4A30["water_patch"] = spawnStruct();
  _id_4A25(level._id_4A30["water_patch"], var_0, var_1, var_2, var_3);
  level._id_4A30["water_patch_med"] = spawnStruct();
  _id_4A25(level._id_4A30["water_patch_med"], var_0, var_1, 0.5 * var_2, var_3);
  level._id_4A30["water_patch_calm"] = spawnStruct();
  _id_4A25(level._id_4A30["water_patch_calm"], var_0, var_1, 0, var_3);
}

_id_4A31(var_0, var_1, var_2, var_3) {
  var_4 = gettime();
  var_4 = var_4 / 43200000.0;
  var_4 = var_4 - int(var_4);
  var_4 = var_4 * 43200.0;
  var_4 = var_4 + var_0._id_4A2D;
  var_5 = (var_1[0] * var_0._id_4A26[var_2] * var_3, var_1[1] * var_0._id_4A27[var_2] * var_3, 0);
  var_5 = var_5 + (var_4 * var_0._id_4A29[var_2] * var_3, var_4 * var_0._id_4A2A[var_2] * var_3, 0);
  return var_5;
}

_id_4A32(var_0, var_1) {
  var_2 = animscripts\utility::_id_0D08(var_1[0], var_0.width);
  var_3 = animscripts\utility::_id_0D08(var_1[1], var_0.height);
  var_4 = var_0._id_405D[var_3][var_2];
  var_4 = var_4 / 255.0;
  return var_4;
}

_id_4A33(var_0, var_1) {
  var_2 = var_1[0] - floor(var_1[0]);
  var_3 = var_1[1] - floor(var_1[1]);
  var_4 = (var_2 * var_0.width, var_3 * var_0.height, 0);
  var_1 = (var_4[0] + var_0._id_4A2B, var_4[1] + var_0._id_4A2C, 0);
  var_5 = (floor(var_1[0]), floor(var_1[1]), 0);
  var_6 = var_1 - var_5;
  var_2 = animscripts\utility::_id_0D08(var_5[0], var_0.width);
  var_3 = animscripts\utility::_id_0D08(var_5[1], var_0.height);
  var_7 = (var_2, var_3, 0);
  var_8[0][0] = _id_4A32(var_0, var_7);
  var_8[0][1] = _id_4A32(var_0, var_7 + (0, 1, 0));
  var_8[1][0] = _id_4A32(var_0, var_7 + (1, 0, 0));
  var_8[1][1] = _id_4A32(var_0, var_7 + (1, 1, 0));
  var_9 = (var_8[0][0] * (1.0 - var_6[0]) + var_8[1][0] * var_6[0]) * (1.0 - var_6[1]);
  var_9 = var_9 + (var_8[0][1] * (1.0 - var_6[0]) + var_8[1][1] * var_6[0]) * var_6[1];
  return var_9;
}

_id_4A34(var_0, var_1) {
  var_2 = var_1[0] - floor(var_1[0]);
  var_3 = var_1[1] - floor(var_1[1]);
  var_4 = (var_2 * var_0.width, var_3 * var_0.height, 0);
  var_1 = (var_4[0] + var_0._id_4A2B, var_4[1] + var_0._id_4A2C, 0);
  var_5 = _id_4A35::_id_4A24(var_0, var_1[0], var_1[1]) / 255.0;
  return var_5;
}

_id_4A36(var_0, var_1) {
  var_2 = 0;

  for(var_3 = 0; var_3 < 3; var_3++) {
    if(var_0._id_4A28[var_3] > 0) {
      var_4 = _id_4A31(var_0, var_1, var_3, var_0._id_4A2E);
      var_5 = _id_4A34(var_0, var_4);
      var_2 = var_2 + (var_5 * 2.0 - 1.0) * var_0._id_4A28[var_3];
    }
  }

  return var_2;
}