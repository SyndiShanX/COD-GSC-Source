/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2401.gsc
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

onplayerspawned() {
  self endon("disconnect");

  for(;;) {
    scripts\engine\utility::waittill_any_2("loadout_given", "spawned_player");

    foreach(var_1 in level._id_AB77) {
      self[[var_1]]();
    }
  }
}