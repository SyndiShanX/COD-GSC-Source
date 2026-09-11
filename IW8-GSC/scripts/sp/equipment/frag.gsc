/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\equipment\frag.gsc
***********************************************/

function precache(var_0) {
  scripts\sp\equipment\offhands::registeroffhandfirefunc(var_0, &fragfiremain);
}

function fragfiremain(var_0) {
  var_0 endon("frag_deleted");
  thread scripts\anim\battlechatter_ai::evaluateattackevent("frag");
  thread notifyondelete();
  var_0 waittill("explode", var_1);
  playrumbleonposition("grenade_rumble", var_1);
  earthquake(0.38, 0.65, var_1, 900);
}

function notifyondelete() {
  self endon("explode");

  while(isDefined(self)) {
    wait 0.05;
  }

  self notify("frag_deleted");
}