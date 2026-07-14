/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\equipment\flash.gsc
******************************************/

#using scripts\engine\math;
#using scripts\sp\equipment\offhands;
#namespace flash;

function private autoexec initflash() {
  offhands::registerprecachefunc("\xef\xd8\x94\x8d\xba", &precache);
}

function precache(offhand) {
  offhands::registeroffhandfirefunc(offhand, &flashfiremain);
  offhands::playeroffhandthread(&flashbangmonitor);
}

function flashfiremain(grenade, weapon) {
  if(isDefined(level.battlechatter)) {
    function_99e8e66d1969d7cb(self, undefined, "\x9e\x19\xa8K\xf6\xfc3<R\xc1\xd4\xbay", "i\t\x1f\xf0\xc6\xe9!\xd4t\xa1\xa8 ;");
  }
}

function flashbangmonitor() {
  self notify("Y\xdf\xe5NN\vn\xdf\x9bz\x83W\xc0\x06\xae}\xc3");
  self endon("Y\xdf\xe5NN\vn\xdf\x9bz\x83W\xc0\x06\xae}\xc3");

  while(true) {
    self waittill("f\x8d,nh\xc4\v\xb9\xb3", origin, percentdistance, percentangle, attacker, team);
    onscreenang = 0.8;
    offscreenang = 0.65;
    minanglepercent = 0.3;
    percentangle = math::normalize_value(offscreenang, onscreenang, percentangle);
    percentangle = math::factor_value(minanglepercent, 1, percentangle);
    factors = [percentdistance, percentangle];
    factor = percentangle * percentdistance;
    duration = factor * self.gs.maxflashbangtime;
    self.flashendtime = gettime() + int(duration * 1000);
    self shellshock("f\x8d,nh\xc4\v\xb9\xb3", duration);
    thread flashbangrumbleloop(duration * 0.45);
    thread flashbanginvulnerability(duration * 0.65);
  }
}

function flashbangrumbleloop(duration) {
  self endon("f\x8d,nh\xc4\v\xb9\xb3");
  starttime = gettime();
  durationmilliseconds = duration * 1000;
  goaltime = starttime + durationmilliseconds;

  while(gettime() < goaltime) {
    currenttime = gettime();
    timedifference = currenttime - starttime;
    pulsetime = math::factor_value(0.05, 0.15, timedifference / durationmilliseconds);
    self playRumbleOnEntity("\x8c\xc2[a\xec+_\xa1\xacX\xec\xe5");
    wait pulsetime;
  }

  self playRumbleOnEntity("Ab;p\xd6\x1b\xf5I\x9b\x89\x8f");
}

function flashbanginvulnerability(duration) {
  self endon("f\x8d,nh\xc4\v\xb9\xb3");
  self.flashinvul = 1;
  wait duration;
  self.flashinvul = undefined;
}