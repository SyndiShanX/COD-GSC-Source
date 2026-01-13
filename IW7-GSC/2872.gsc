/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 2872.gsc
*********************************************/

func_9606() {
  scripts\engine\utility::array_thread(getEntArray("window_poster", "targetname"), ::func_13D55);
}

func_13D55() {
  var_0 = getglass(self.target);
  if(!isDefined(var_0)) {
    return;
  }

  level waittillmatch(var_0, "glass_destroyed");
  self delete();
}