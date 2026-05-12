/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\_flashgrenades.gsc
*********************************************/

func_00F9() {
  precacheshellshock("flashbang_mp");
}

func_92E8() {
  thread func_6394();
}

func_940E(param_00) {
  self notify("stop_monitoring_flash");
}

func_3D58(param_00) {
  self endon("stop_monitoring_flash");
  self endon("flash_rumble_loop");
  self notify("flash_rumble_loop");
  var_01 = gettime() + param_00 * 1000;
  while(gettime() < var_01) {
    self playrumbleonentity("damage_heavy");
    wait 0.05;
  }
}

func_6394() {
  self endon("disconnect");
  self notify("monitorFlash");
  self endon("monitorFlash");
  self.var_3D48 = 0;
  self.var_8C5E = 0;
  var_00 = 2.5;
  for(;;) {
    self waittill("flashbang", var_01, var_02, var_03, var_04, var_05, var_06);
    if(!isalive(self)) {
      break;
    }

    if(isDefined(self.var_A25C)) {
      continue;
    }

    if(!isDefined(var_06)) {
      var_06 = 0;
    }

    var_07 = 0;
    var_08 = 1;
    if(var_03 < 0.25) {
      var_03 = 0.25;
    } else if(var_03 > 0.8) {
      var_03 = 1;
    }

    var_09 = var_02 * var_03 * var_00;
    var_09 = var_09 + var_06;
    var_0A = 0;
    if(isDefined(self.var_94BE)) {
      var_09 = var_09 * self.var_94BE;
      if(self.var_94BE == 0.1) {
        var_0A = 1;
      }
    }

    if(var_09 < 0.25) {
      continue;
    }

    var_0B = undefined;
    if(var_09 > 2) {
      var_0B = 0.75;
    } else {
      var_0B = 0.25;
    }

    if(level.var_984D && isDefined(var_04) && isDefined(var_04.var_01A7) && var_04.var_01A7 == self.var_01A7 && var_04 != self) {
      if(level.var_3EC4 == 0) {
        continue;
      } else if(level.var_3EC4 == 1) {} else if(level.var_3EC4 == 2) {
        var_09 = var_09 * 0.5;
        var_0B = var_0B * 0.5;
        var_08 = 0;
        var_07 = 1;
      } else if(level.var_3EC4 == 3) {
        var_09 = var_09 * 0.5;
        var_0B = var_0B * 0.5;
        var_07 = 1;
      }
    } else if(isDefined(var_04)) {
      if(var_04 != self) {
        var_04 maps\mp\gametypes\_missions::func_7750("ch_indecentexposure");
      }
    }

    if(var_08 && isDefined(self)) {
      thread func_0F33(var_09, var_0B, var_0A);
      if(isDefined(var_04) && var_04 != self) {
        var_04 thread maps\mp\gametypes\_damagefeedback::func_A102("flash");
        var_0C = self;
        if(isPlayer(var_04) && var_04 maps\mp\_utility::func_0649("specialty_paint")) {
          var_0C thread maps\mp\perks\_perkfunctions::func_86ED(var_04, 0);
        }
      }
    }

    if(var_07 && isDefined(var_04)) {
      var_04 thread func_0F33(var_09, var_0B);
    }
  }
}

func_0F33(param_00, param_01, param_02) {
  if(!isDefined(self.var_3D46) || param_00 > self.var_3D46) {
    self.var_3D46 = param_00;
  }

  if(!isDefined(self.var_3D57) || param_01 > self.var_3D57) {
    self.var_3D57 = param_01;
  }

  wait 0.05;
  if(isDefined(self.var_3D46)) {
    self shellshock("flashbang_mp", self.var_3D46);
    self.var_3D48 = gettime() + self.var_3D46 * 1000;
    if(param_02) {
      self.var_8C5C = self.var_3D46 * 10;
      self.var_8C5E = gettime() + self.var_8C5C * 1000;
    }
  }

  if(isDefined(self.var_3D57)) {
    thread func_3D58(self.var_3D57);
  }

  self.var_3D46 = undefined;
  self.var_3D57 = undefined;
}

func_56F3() {
  return isDefined(self.var_3D48) && gettime() < self.var_3D48;
}