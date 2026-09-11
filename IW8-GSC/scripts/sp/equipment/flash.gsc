/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\equipment\flash.gsc
***********************************************/

function precache(var0) {
  scripts\sp\equipment\offhands::registeroffhandfirefunc(var0, &flashfiremain);
  scripts\sp\equipment\offhands::playeroffhandthread(&flashbangmonitor);
}

function flashfiremain(var0) {}

function flashbangmonitor() {
  for(;;) {
    self waittill("flashbang", var0, var1, var2, var3, var4);
    var5 = 0.8;
    var6 = 0.65;
    var7 = 0.3;
    var2 = scripts\engine\math::normalize_value(var6, var5, var2);
    var2 = scripts\engine\math::factor_value(var7, 1, var2);
    var8 = [var1, var2];
    var9 = var2 * var1;
    var10 = var9 * self.gs.maxflashbangtime;
    self.flashendtime = gettime() + var10 * 1000;
    self shellshock("flashbang", var10);
    thread flashbangrumbleloop(var10 * 0.45);
    thread flashbanginvulnerability(var10 * 0.65);
  }
}

function flashbangrumbleloop(var0) {
  self endon("flashbang");
  var1 = gettime();
  var2 = var0 * 1000;
  var3 = var1 + var2;

  while(gettime() < var3) {
    var4 = gettime();
    var5 = var4 - var1;
    var6 = scripts\engine\math::factor_value(0.05, 0.15, var5 / var2);
    self playRumbleOnEntity("damage_heavy");
    wait var6;
  }

  self playRumbleOnEntity("tank_rumble");
}

function flashbanginvulnerability(var0) {
  self endon("flashbang");
  self.flashinvul = 1;
  wait var0;
  self.flashinvul = undefined;
}