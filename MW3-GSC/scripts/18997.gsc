/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\18997.gsc
**************************************/

_id_4A24(var_0, var_1, var_2) {
  var_3 = var_1 * var_0._id_4A1F;
  var_4 = var_2 * var_0._id_4A20;
  var_5 = var_3 - var_0._id_4A1C;
  var_6 = var_4 - var_0._id_4A1D;
  var_7 = var_0._id_4A1E;

  if(var_0._id_4A23) {
    var_8 = var_0._id_4A1A;
    var_9 = var_0._id_4A1B;
    var_10 = var_0._id_1727;
    var_11 = (var_7 - var_4) * ((var_7 - var_3) * perlinnoise2d(var_5, var_6, var_8, var_9, var_10) + var_3 * perlinnoise2d(var_5 - var_7, var_6, var_8, var_9, var_10)) + var_4 * ((var_7 - var_3) * perlinnoise2d(var_5, var_6 - var_7, var_8, var_9, var_10) + var_3 * perlinnoise2d(var_5 - var_7, var_6 - var_7, var_8, var_9, var_10));
  } else {
    var_11 = perlinnoise2d(var_5, var_6, var_0._id_4A1A, var_0._id_4A1B, var_0._id_1727);

  }
  var_11 = var_11 - var_0._id_4A21;
  var_11 = var_11 * var_0._id_4A22;
  var_11 = var_11 + 127.0;

  if(var_11 < 0.0) {
    var_11 = 0.0;

  }
  if(var_11 > 255.0) {
    var_11 = 255.0;

  }
  return var_11;
}