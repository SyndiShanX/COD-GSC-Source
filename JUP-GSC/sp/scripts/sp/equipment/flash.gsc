/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\equipment\flash.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\equipment\offhands;
#using scripts\sp\utility;
#namespace flash;

function precache(offhand) {
  registeroffhandfirefunc(offhand, &flashfiremain);
  playeroffhandthread(&flashbangmonitor);
}

function flashfiremain(grenade, weapon) {
  function_216c67ab6749137a(self, undefined, "grenade_throw", "flash_grenade");
}

function flashbangmonitor() {
  self notify("_flashBangMonitor");
  self endon("_flashBangMonitor");

  while(true) {
    self waittill("flashbang", origin, percentdistance, percentangle, attacker, team);
    var_232b4f4d5ac19b58 = 0.8;
    offscreenang = 0.65;
    var_1bd7bb5d30fe89cb = 0.3;
    percentangle = math::normalize_value(offscreenang, var_232b4f4d5ac19b58, percentangle);
    percentangle = factor_value(var_1bd7bb5d30fe89cb, 1, percentangle);
    factors = [percentdistance, percentangle];
    factor = percentangle * percentdistance;
    duration = factor * self.gs.maxflashbangtime;
    self.flashendtime = gettime() + int(duration * 1000);
    self shellshock("flashbang", duration);
    thread flashbangrumbleloop(duration * 0.45);
    thread flashbanginvulnerability(duration * 0.65);
  }
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