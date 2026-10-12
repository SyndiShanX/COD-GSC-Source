/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\equipment\concussion.gsc
***********************************************/



#using scripts\anim\combat_utility;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\equipment\offhands;
#using scripts\sp\utility;
#namespace concussion;

function precache(offhand) {
  registeroffhandfirefunc(offhand, &function_3bfb7fadfa314540);
}

function function_3bfb7fadfa314540(grenade, weapon) {
  grenade endon("grenade_deleted");
  grenade thread notifyondelete();
  grenade waittill("explode", grenadeorigin);
  level thread function_f6e54a9834223cd3(grenadeorigin, weapon, self);
  var_9968317799becacb = distancesquared(level.player.origin, grenadeorigin);

  if(var_9968317799becacb <= 262144) {
    tracepassed = scripts\engine\trace::ray_trace_passed(grenadeorigin + (0, 0, 20), level.player getEye(), level.player);

    if(tracepassed) {
      level.player thread function_7857adf642da6884(var_9968317799becacb, weapon);
      return;
    }
  }
}

function function_f6e54a9834223cd3(var_e7b30db786a47b06, weapon, thrower) {
  guys = getaiarrayinradius(var_e7b30db786a47b06, 512);

  if(!guys.size) {
    return;
  }

  foreach(guy in guys) {
    guy function_f8d836a0568d26e0(var_e7b30db786a47b06, weapon, thrower);
  }
}

function function_f8d836a0568d26e0(grenadeorigin, weapon, thrower) {
  self endon("death");
  assertex(isDefined(thrower) && isDefined(thrower.team), "Need a valid ent/ai/player with a .team");

  if(!is_equal(self, thrower)) {
    thrower endon("death");
  }

  tracepassed = scripts\engine\trace::ray_trace_passed(grenadeorigin + (0, 0, 20), self getEye(), self);

  if(tracepassed) {
    attacker = thrower;
    attackerteam = thrower.team;
    var_321c9ba320abaad8 = distancesquared(self.origin, grenadeorigin);
    maxtime = 5;
    normalizeddist = math::normalize_value(1, 512, sqrt(var_321c9ba320abaad8));
    var_92af705d147100bf = math::factor_value(maxtime, 1, normalizeddist);
    var_92af705d147100bf = round(var_92af705d147100bf);
    self.flashingteam = attackerteam;
    scripts\anim\combat_utility::flashbangstart(var_92af705d147100bf);
    self notify("doFlashBanged", grenadeorigin, attacker);
  }
}

function function_7857adf642da6884(var_a2858e1f2b3b8f7d, weapon) {
  maxtime = level.player.gs.maxflashbangtime;
  normalizeddist = math::normalize_value(1, 512, sqrt(var_a2858e1f2b3b8f7d));
  var_92af705d147100bf = math::factor_value(maxtime, 1, normalizeddist);
  var_92af705d147100bf = round(var_92af705d147100bf);
  level.player thread player_gesture_combat("ges_frag_block");
  self.flashendtime = gettime() + int(var_92af705d147100bf * 1000);
  self shellshock("concussion_grenade_sp", var_92af705d147100bf);
  thread flashbangrumbleloop(var_92af705d147100bf * 0.45);
  thread flashbanginvulnerability(var_92af705d147100bf * 0.65);
}

function flashbangrumbleloop(duration) {
  self endon("flashbang");
  starttime = gettime();
  durationmilliseconds = duration * 1000;
  goaltime = starttime + durationmilliseconds;

  while(gettime() < goaltime) {
    currenttime = gettime();
    timedifference = currenttime - starttime;
    pulsetime = math::factor_value(0.05, 0.15, timedifference / durationmilliseconds);
    self playRumbleOnEntity("damage_heavy");
    wait pulsetime;
  }

  self playRumbleOnEntity("tank_rumble");
}

function flashbanginvulnerability(duration) {
  self endon("flashbang");
  self.flashinvul = 1;
  wait duration;
  self.flashinvul = undefined;
}

function notifyondelete() {
  self endon("explode");

  while(isDefined(self)) {
    wait 0.05;
  }

  self notify("grenade_deleted");
}