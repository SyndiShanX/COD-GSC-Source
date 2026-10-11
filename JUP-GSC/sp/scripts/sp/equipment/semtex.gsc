/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\equipment\semtex.gsc
***********************************************/

#using scripts\common\ai;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\equipment\offhands;
#using scripts\sp\utility;
#namespace semtex;

function precache(offhand) {
  registeroffhandfirefunc(offhand, &semtexfiremain);
}

function semtexfiremain(grenade, weapon, fuse) {
  if(!isDefined(grenade)) {
    return;
  }

  if(isai(self)) {
    addbattlechatternotify(self, undefined, "grenade_throw", "frag_grenade");
    grenade setentityowner(self);
    grenade setotherent(self);
  }

  grenade makeunusable();
  grenade thread semtex_watch_beacon(self, fuse);
  grenade thread semtex_watch_stuck();
  grenade thread semtex_watch_fuse();
}

function semtex_watch_beacon(attacker, fuse) {
  currentstate = self getscriptablepartstate("state");
  self endon("entitydeleted");

  if(currentstate == "beacon_ai" || currentstate == "beacon") {
    return;
  }

  if(isai(attacker)) {
    semtex_fuse = 2;

    if(isDefined(fuse)) {
      semtex_fuse = fuse;
    }

    self setscriptablepartstate("state", "beacon_ai", 0);
    wait semtex_fuse;
  }

  self setscriptablepartstate("state", "beacon", 0);
}

function semtex_watch_stuck() {
  self endon("death");
  self waittill("missile_stuck", stuckto);

  if(isai(stuckto) && isalive(stuckto)) {
    addbattlechatternotify(stuckto, undefined, "semtex_stuck");
    function_60daa23100a2b874(self, stuckto);
  }

  if(isPlayer(stuckto) && isalive(stuckto)) {
    semtexstucktoplayer();
  }
}

function semtexstucktoplayer() {
  if(isDefined(level.func["semtex_player_stuck_workaround"])) {
    self thread[[level.func["semtex_player_stuck_workaround"]]]();
  }
}

function semtex_watch_fuse() {
  self waittill("explode", org);
  playrumbleonposition("grenade_rumble", org);
  earthquake(0.45, 0.7, org, 800);
}