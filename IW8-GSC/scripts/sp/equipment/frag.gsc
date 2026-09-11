/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\equipment\frag.gsc
***********************************************/

function precache(var0) {
  scripts\sp\equipment\offhands::registeroffhandfirefunc(var0, &fragfiremain);
}

function fragfiremain(var0) {
  var0 endon("frag_deleted");
  thread scripts\anim\battlechatter_ai::evaluateattackevent("frag");
  thread notifyondelete();
  var0 waittill("explode", var1);
  playrumbleonposition("grenade_rumble", var1);
  earthquake(0.38, 0.65, var1, 900);
}

function notifyondelete() {
  self endon("explode");

  while(isDefined(self)) {
    wait 0.05;
  }

  self notify("frag_deleted");
}