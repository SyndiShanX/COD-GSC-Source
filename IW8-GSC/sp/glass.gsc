/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\glass.gsc
***********************************************/

init_glass() {
  scripts\engine\utility::array_thread(getEntArray("window_poster", "targetname"), ::window_destroy);
}

window_destroy() {
  var_0 = getglass(self.target);

  if(!isDefined(var_0)) {
    return;
  }
  level waittillmatch("glass_destroyed", var_0);
  self delete();
}