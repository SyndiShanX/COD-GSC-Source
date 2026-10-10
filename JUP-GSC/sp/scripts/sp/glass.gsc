/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\glass.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#namespace glass;

function init_glass() {
  array_thread(getEntArray("window_poster", "targetname"), &window_destroy);
}

function window_destroy() {
  assert(isDefined(self.target));
  glassid = getglass(self.target);

  if(!isDefined(glassid)) {
    println("<dev string:x1c>" + self.target + "<dev string:x4b>" + self.origin);
    return;
  }

  level waittillmatch("glass_destroyed", glassid);
  self delete();
}