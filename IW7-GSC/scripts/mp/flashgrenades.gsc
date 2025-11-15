/****************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\flashgrenades.gsc
****************************************/

main() {}

func_10DC6() {
  thread func_B9D9();
}

func_1107E(param_00) {
  self notify("stop_monitoring_flash");
}

func_6EDC(param_00) {
  self endon("stop_monitoring_flash");
  self endon("flash_rumble_loop");
  self notify("flash_rumble_loop");
  var_01 = gettime() + param_00 * 1000;
  while(gettime() < var_01) {
    self playrumbleonentity("damage_heavy");
    wait(0.05);
  }
}

func_B9D9() {
  self endon("death");
  self endon("disconnect");
  self notify("monitorFlash");
  self endon("monitorFlash");
  self.flashendtime = 0;
  var_00 = 1;
  for(;;) {
    self waittill("flashbang", var_01, var_02, var_03, var_04, var_05, var_06);
    if(!isalive(self)) {
      break;
    }

    if(isDefined(self.usingremote)) {
      continue;
    }

    if(isDefined(self.triggerportableradarping) && isDefined(var_04) && var_04 == self.triggerportableradarping) {
      continue;
    }

    if(!isDefined(var_06)) {
      var_06 = 0;
    }

    var_07 = 0;
    var_08 = 1;
    var_03 = 1;
    var_09 = var_02 * var_03 * var_00;
    var_09 = var_09 + var_06;
    var_09 = scripts\mp\perks\_perkfunctions::applystunresistence(var_04, self, var_09);
    if(var_09 < 0.25) {
      continue;
    }

    var_0A = undefined;
    if(var_09 > 2) {
      var_0A = 0.75;
    } else {
      var_0A = 0.25;
    }

    if(level.teambased && isDefined(var_04) && isDefined(var_04.team) && var_04.team == self.team && var_04 != self) {
      if(level.friendlyfire == 0) {
        continue;
      } else if(level.friendlyfire == 1) {} else if(level.friendlyfire == 2) {
        var_09 = var_09 * 0.5;
        var_0A = var_0A * 0.5;
        var_08 = 0;
        var_07 = 1;
      } else if(level.friendlyfire == 3) {
        var_09 = var_09 * 0.5;
        var_0A = var_0A * 0.5;
        var_07 = 1;
      }
    } else if(isDefined(var_04)) {
      var_04 notify("flash_hit");
      if(var_04 != self) {
        var_04 scripts\mp\missions::processchallenge("ch_indecentexposure");
      }
    }

    if(var_08 && isDefined(self)) {
      thread func_20CA(var_09, var_0A);
      if(isDefined(var_04) && var_04 != self) {
        var_04 thread scripts\mp\damagefeedback::updatedamagefeedback("flash");
        var_0B = self;
        if(isplayer(var_04) && var_04 isitemunlocked("specialty_paint", "perk") && var_04 scripts\mp\utility::_hasperk("specialty_paint")) {
          var_0B thread scripts\mp\perks\_perkfunctions::setpainted(var_04);
        }
      }
    }

    if(var_07 && isDefined(var_04)) {
      var_04 thread func_20CA(var_09, var_0A);
    }
  }
}

func_20CA(param_00, param_01) {
  self endon("disconnect");
  if(!isDefined(self.var_6EC8) || param_00 > self.var_6EC8) {
    self.var_6EC8 = param_00;
  }

  if(!isDefined(self.var_6EDB) || param_01 > self.var_6EDB) {
    self.var_6EDB = param_01;
  }

  wait(0.05);
  self.var_6EC8 = undefined;
  self.var_6EDB = undefined;
}

isflashbanged() {
  return isDefined(self.flashendtime) && gettime() < self.flashendtime;
}