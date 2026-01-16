/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\_flashgrenades.gsc
********************************/

main() {
  precacheshellshock("flashbang_mp");
}

startmonitoringflash() {
  thread monitorflash();
}

stopmonitoringflash(var_0) {
  self notify("stop_monitoring_flash");
}

flashrumbleloop(var_0) {
  self endon("stop_monitoring_flash");
  self endon("flash_rumble_loop");
  self notify("flash_rumble_loop");
  var_1 = gettime() + var_0 * 1000;

  while (gettime() < var_1) {
    self playrumbleonentity("damage_heavy");
    wait 0.05;
  }
}

monitorflash() {
  self endon("disconnect");
  self notify("monitorFlash");
  self endon("monitorFlash");
  self.flashendtime = 0;
  var_0 = 6;

  for (;;) {
    self waittill("flashbang", var_1, var_2, var_3, var_4, var_5, var_6);

    if(!isalive(self)) {
      continue;
    }
    if(isdefined(self.usingremote)) {
      continue;
    }
    if(!isdefined(var_6))
      var_6 = 0;

    var_7 = 0;
    var_8 = 1;

    if(var_3 < 0.5)
      var_3 = 0.5;
    else if(var_3 > 0.8)
      var_3 = 1;

    var_9 = var_2 * var_3 * var_0;
    var_9 = var_9 + var_6;

    if(isdefined(self.stunscaler))
      var_9 = var_9 * self.stunscaler;

    if(var_9 < 0.25) {
      continue;
    }
    var_10 = undefined;

    if(var_9 > 2)
      var_10 = 0.75;
    else
      var_10 = 0.25;

    if(level.teambased && isdefined(var_4) && isdefined(var_4.team) && var_4.team == self.team && var_4 != self) {
      if(level.friendlyfire == 0)
        continue;
      else if(level.friendlyfire == 1) {

      } else if(level.friendlyfire == 2) {
        var_9 = var_9 * 0.5;
        var_10 = var_10 * 0.5;
        var_8 = 0;
        var_7 = 1;
      } else if(level.friendlyfire == 3) {
        var_9 = var_9 * 0.5;
        var_10 = var_10 * 0.5;
        var_7 = 1;
      }
    } else if(isdefined(var_4)) {
      if(var_4 != self)
        var_4 maps\mp\gametypes\_missions::processchallenge("ch_flash");

      var_11 = maps\mp\_utility::getmapname();

      if(var_11 == "mp_crash_snow")
        var_4 maps\mp\gametypes\_missions::processchallenge("ch_wc_tactical");
      else if(var_11 == "mp_farm_spring")
        var_4 maps\mp\gametypes\_missions::processchallenge("ch_stpatty_tactical");
      else if(var_11 == "mp_bog_summer")
        var_4 maps\mp\gametypes\_missions::processchallenge("ch_summer_tactical");
    }

    if(var_8 && isdefined(self)) {
      thread applyflash(var_9, var_10);

      if(isdefined(var_4) && var_4 != self) {
        var_4 thread maps\mp\gametypes\_damagefeedback::updatedamagefeedback("flash");
        self.flashattacker = var_4;
        var_12 = self;

        if(isplayer(var_4) && var_4 isitemunlocked("specialty_paint") && var_4 maps\mp\_utility::_hasperk("specialty_paint"))
          var_12 thread maps\mp\perks\_perkfunctions::setpainted(var_4);
      } else
        self.flashattacker = undefined;
    }

    if(var_7 && isdefined(var_4))
      var_4 thread applyflash(var_9, var_10);
  }
}

applyflash(var_0, var_1) {
  if(!isdefined(self.flashduration) || var_0 > self.flashduration)
    self.flashduration = var_0;

  if(!isdefined(self.flashrumbleduration) || var_1 > self.flashrumbleduration)
    self.flashrumbleduration = var_1;

  wait 0.05;

  if(isdefined(self.flashduration)) {
    self shellshock("flashbang_mp", self.flashduration);
    self.flashendtime = gettime() + self.flashduration * 1000;
  }

  if(isdefined(self.flashrumbleduration))
    thread flashrumbleloop(self.flashrumbleduration);

  self.flashduration = undefined;
  self.flashrumbleduration = undefined;
}

isflashbanged() {
  return isdefined(self.flashendtime) && gettime() < self.flashendtime;
}

getlastflashbangattacker() {
  return self.flashattacker;
}