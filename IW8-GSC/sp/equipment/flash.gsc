/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\equipment\flash.gsc
***********************************************/

precache(var_0) {
  scripts\sp\equipment\offhands::registeroffhandfirefunc(var_0, ::flashfiremain);
  scripts\sp\equipment\offhands::playeroffhandthread(::flashbangmonitor);
}

flashfiremain(var_0) {}

flashbangmonitor() {
  for(;;) {
    self waittill("flashbang", var_0, var_1, var_2, var_3, var_4);
    var_5 = 0.8;
    var_6 = 0.65;
    var_7 = 0.3;
    var_2 = scripts\engine\math::normalize_value(var_6, var_5, var_2);
    var_2 = scripts\engine\math::factor_value(var_7, 1, var_2);
    var_8 = [var_1, var_2];
    var_9 = var_2 * var_1;
    var_10 = var_9 * self.gs.maxflashbangtime;
    self.flashendtime = gettime() + var_10 * 1000;
    self shellshock("flashbang", var_10);
    thread flashbangrumbleloop(var_10 * 0.45);
    thread flashbanginvulnerability(var_10 * 0.65);
  }
}

flashbangrumbleloop(var_0) {
  self endon("flashbang");
  var_1 = gettime();
  var_2 = var_0 * 1000;
  var_3 = var_1 + var_2;

  while(gettime() < var_3) {
    var_4 = gettime();
    var_5 = var_4 - var_1;
    var_6 = scripts\engine\math::factor_value(0.05, 0.15, var_5 / var_2);
    self playRumbleOnEntity("damage_heavy");
    wait(var_6);
  }

  self playRumbleOnEntity("tank_rumble");
}

flashbanginvulnerability(var_0) {
  self endon("flashbang");
  self.flashinvul = 1;
  wait(var_0);
  self.flashinvul = undefined;
}