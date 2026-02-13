/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2396.gsc
*************************************************/

init() {
  level thread onplayerconnect();
}

onplayerconnect() {
  level._id_AB2C = [];

  for(;;) {
    level waittill("connected", var_0);
    var_0 thread _id_AB5D();
  }
}

_id_C287(var_0) {
  level._id_AB2C[level._id_AB2C.size] = var_0;
}

_id_AB5D() {
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);

    foreach(var_3 in level._id_AB2C) {
      self[[var_3]](var_0, var_1);
    }
  }
}