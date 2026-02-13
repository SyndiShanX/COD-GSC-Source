/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2723.gsc
*************************************************/

init() {
  level thread onplayerconnect();
}

onplayerconnect() {
  level._id_AB77 = [];

  for(;;) {
    level waittill("connected", var_0);
    var_0 thread onplayerspawned();
  }
}

_id_C28D(var_0) {
  level._id_AB77[level._id_AB77.size] = var_0;
}

_id_4804(var_0) {
  level._id_AB77 = scripts\engine\utility::array_remove(level._id_AB77, var_0);
}

onplayerspawned() {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned_player");

    foreach(var_1 in level._id_AB77) {
      self[[var_1]]();
    }
  }
}