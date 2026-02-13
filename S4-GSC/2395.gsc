/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2395.gsc
*************************************************/

_id_AB6B(var_0) {
  foreach(var_2 in level._id_AB09) {
    self[[var_2]](var_0);
  }
}

_id_C28A(var_0) {
  if(!isDefined(level._id_AB09)) {
    level._id_AB09 = [];
  }

  level._id_AB09[level._id_AB09.size] = var_0;
}