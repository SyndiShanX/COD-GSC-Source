/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\glass.gsc
***********************************************/

function init_glass() {
  scripts\engine\utility::array_thread(getEntArray("window_poster", "targetname"), &window_destroy);
}

function window_destroy() {
  var0 = getglass(self.target);

  if(!isDefined(var0)) {
    return;
  }

  level waittillmatch("glass_destroyed", var0);
  self delete();
}