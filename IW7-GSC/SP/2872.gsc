/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2872.gsc
**************************************/

_id_9606() {
  scripts\engine\utility::array_thread(getEntArray("window_poster", "targetname"), ::_id_13D55);
}

_id_13D55() {
  var_0 = getglass(self.target);

  if(!isDefined(var_0)) {
    return;
  }
  level waittillmatch("glass_destroyed", var_0);
  self delete();
}