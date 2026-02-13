/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2710.gsc
*************************************************/

_id_AB6A(var_0) {
  foreach(var_2 in level._id_AB07) {
    self[[var_2]](var_0);
  }
}

_id_C289(var_0) {
  if(!isDefined(level._id_AB07)) {
    level._id_AB07 = [];
  }

  level._id_AB07[level._id_AB07.size] = var_0;
}