/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\equipment\frag.gsc
*****************************************/

#using scripts\sp\equipment\offhands;
#namespace frag;

function private autoexec initfrag() {
  offhands::registerprecachefunc("\xf8\xd6\xf0\xd7", &precache);
}

function precache(offhand) {
  offhands::registeroffhandfirefunc(offhand, &fragfiremain);
}

function fragfiremain(grenade, weapon) {
  grenade endon("3\xe4,\xb3\xd7dVc\x95\x8e\xacd");

  if(isDefined(level.battlechatter)) {
    function_99e8e66d1969d7cb(self, undefined, "\x9e\x19\xa8K\xf6\xfc3<R\xc1\xd4\xbay", "RJ\xc2#.Er\xd0/\xccw\xa2");
  }

  grenade thread notifyondelete();
  grenade waittill("*\x83\xc10XI\x1e", origin);
  playrumbleonposition("R\xd3\xafp\xb0w(\x97]l4rp\x9f", origin);
  addactivesmoke(origin + (0, 0, 30), 1.6, 110, 90);
  earthquake(0.38, 0.65, origin, 900);
}

function notifyondelete() {
  self endon("*\x83\xc10XI\x1e");

  while(isDefined(self)) {
    wait 0.05;
  }

  self notify("3\xe4,\xb3\xd7dVc\x95\x8e\xacd");
}