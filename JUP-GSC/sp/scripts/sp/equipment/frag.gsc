/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\equipment\frag.gsc
***********************************************/



#using scripts\sp\equipment\offhands;
#namespace frag;

function precache(offhand) {
  registeroffhandfirefunc(offhand, &fragfiremain);
}

function fragfiremain(grenade, weapon) {
  grenade endon("frag_deleted");
  addbattlechatternotify(self, undefined, "grenade_throw", "frag_grenade");
  grenade thread notifyondelete();
  grenade waittill("explode", origin);
  playrumbleonposition("grenade_rumble", origin);
  earthquake(0.38, 0.65, origin, 900);
}

function notifyondelete() {
  self endon("explode");

  while(isDefined(self)) {
    wait 0.05;
  }

  self notify("frag_deleted");
}