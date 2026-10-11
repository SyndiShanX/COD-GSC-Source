/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\equipment\pipebomb.gsc
************************************************/

#using scripts\sp\equipment\offhands;
#namespace pipebomb;

function precache(offhand) {
  registeroffhandfirefunc(offhand, &pipebombfiremain);
}

function pipebombfiremain(grenade, weapon) {
  if(!isDefined(grenade)) {
    return;
  }

  addbattlechatternotify(self, undefined, "grenade_throw", "frag_grenade");
}