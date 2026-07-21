/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\equipment\frag.gsc
***********************************************/

precache(var_0) {
  scripts\sp\equipment\offhands::registeroffhandfirefunc(var_0, ::fragfiremain);
}

fragfiremain(var_0) {
  var_0 endon("frag_deleted");
  thread scripts\anim\battlechatter_ai.gsc::evaluateattackevent("frag");
  var_0 thread notifyondelete();
  var_0 waittill("explode", var_1);
  playrumbleonposition("grenade_rumble", var_1);
  earthquake(0.38, 0.65, var_1, 900);
}

notifyondelete() {
  self endon("explode");

  while(isDefined(self))
    wait 0.05;

  self notify("frag_deleted");
}