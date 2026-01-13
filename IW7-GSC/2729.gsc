/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2729.gsc
***************************************/

main() {}

func_10DC6() {
  thread func_B9D9();
}

func_1107E(var_0) {
  self notify("stop_monitoring_flash");
}

func_6EDC(var_0) {
  self endon("stop_monitoring_flash");
  self endon("flash_rumble_loop");
  self notify("flash_rumble_loop");
  var_1 = gettime() + var_0 * 1000;

  while(gettime() < var_1) {
    self playrumbleonentity("damage_heavy");
    wait 0.05;
  }
}

func_B9D9() {
  self endon("death");
  self endon("disconnect");
  self notify("monitorFlash");
  self endon("monitorFlash");
  self.flashendtime = 0;
  var_0 = 1;

  for(;;) {
    self waittill("flashbang", var_1, var_2, var_3, var_4, var_5, var_6);

    if(!isalive(self)) {
      break;
    }
    if(isDefined(self.usingremote)) {
      continue;
    }
    if(isDefined(self.owner) && isDefined(var_4) && var_4 == self.owner) {
      continue;
    }
    if(!isDefined(var_6)) {
      var_6 = 0;
    }

    var_7 = 0;
    var_8 = 1;
    var_3 = 1;
    var_9 = var_2 * var_3 * var_0;
    var_9 = var_9 + var_6;
    var_9 = scripts\mp\perks\perkfunctions::applystunresistence(var_4, self, var_9);

    if(var_9 < 0.25) {
      continue;
    }
    var_10 = undefined;

    if(var_9 > 2) {
      var_10 = 0.75;
    } else {
      var_10 = 0.25;
    }

    if(level.teambased && isDefined(var_4) && isDefined(var_4.team) && var_4.team == self.team && var_4 != self) {
      if(level.friendlyfire == 0) {
        continue;
      } else if(level.friendlyfire == 1) {} else if(level.friendlyfire == 2) {
        var_9 = var_9 * 0.5;
        var_10 = var_10 * 0.5;
        var_8 = 0;
        var_7 = 1;
      } else if(level.friendlyfire == 3) {
        var_9 = var_9 * 0.5;
        var_10 = var_10 * 0.5;
        var_7 = 1;
      }
    } else if(isDefined(var_4)) {
      var_4 notify("flash_hit");

      if(var_4 != self) {
        var_4 scripts\mp\missions::processchallenge("ch_indecentexposure");
      }
    }

    if(var_8 && isDefined(self)) {
      thread func_20CA(var_9, var_10);

      if(isDefined(var_4) && var_4 != self) {
        var_4 thread scripts\mp\damagefeedback::updatedamagefeedback("flash");
        var_11 = self;

        if(isplayer(var_4) && var_4 getteamdompoints("specialty_paint", "perk") && var_4 scripts\mp\utility\game::_hasperk("specialty_paint")) {
          var_11 thread scripts\mp\perks\perkfunctions::setpainted(var_4);
        }
      }
    }

    if(var_7 && isDefined(var_4)) {
      var_4 thread func_20CA(var_9, var_10);
    }
  }
}

func_20CA(var_0, var_1) {
  self endon("disconnect");

  if(!isDefined(self.var_6EC8) || var_0 > self.var_6EC8) {
    self.var_6EC8 = var_0;
  }

  if(!isDefined(self.var_6EDB) || var_1 > self.var_6EDB) {
    self.var_6EDB = var_1;
  }

  wait 0.05;
  self.var_6EC8 = undefined;
  self.var_6EDB = undefined;
}

isflashbanged() {
  return isDefined(self.flashendtime) && gettime() < self.flashendtime;
}