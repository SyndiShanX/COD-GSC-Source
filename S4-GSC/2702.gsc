/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2702.gsc
*************************************************/

init() {
  level._id_AAB7 = [];
}

_id_CA31(var_0) {
  foreach(var_2 in level._id_AAB7) {
    level[[var_2]](var_0);
  }
}

_id_C285(var_0) {
  level._id_AAB7[level._id_AAB7.size] = var_0;
}