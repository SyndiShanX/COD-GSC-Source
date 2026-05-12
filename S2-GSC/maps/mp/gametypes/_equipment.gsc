/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_equipment.gsc
*********************************************/

func_A956(param_00) {
  self endon("spawned_player");
  self endon("disconnect");
  self.var_9DCF = [];
  for(;;) {
    self waittill("grenade_fire", var_01, var_02);
    if(var_02 == "trophy" || var_02 == "trophy_mp") {
      if(!isalive(self)) {
        var_01 delete();
        return;
      }

      if(!isDefined(param_00) || param_00 == 0) {
        var_01 method_805C();
      }

      var_01 waittill("missile_stuck");
      if(!isDefined(param_00) || param_00 == 0) {
        var_03 = 40;
        if(var_03 * var_03 < distancesquared(var_01.var_0116, self.var_0116)) {
          var_04 = bulletTrace(self.var_0116, self.var_0116 - (0, 0, var_03), 0, self);
          if(var_04["fraction"] == 1) {
            var_01 delete();
            self setweaponammostock("trophy_mp", self getweaponammostock("trophy_mp") + 1);
            continue;
          }

          var_01.var_0116 = var_04["position"];
        }

        var_01 method_805B();
      }

      self.var_9DCF = common_scripts\utility::func_0FA0(self.var_9DCF);
      if(self.var_9DCF.size >= level.var_6092) {
        self.var_9DCF[0] thread func_9DD0();
      }

      var_05 = spawn("script_model", var_01.var_0116);
      var_05 setModel("mp_trophy_system");
      var_05 thread maps\mp\gametypes\_weapons::func_27D0("mp_trophy_system_bombsquad", "tag_origin", self);
      var_05.var_001D = var_01.var_001D;
      self.var_9DCF[self.var_9DCF.size] = var_05;
      var_05.var_0117 = self;
      var_05.var_01A7 = self.var_01A7;
      var_05.var_A9E0 = var_02;
      var_05.var_94B9 = 0;
      level.var_9DCB[level.var_9DCB.size] = var_05;
      if(isDefined(self.var_9DD6) && self.var_9DD6 > 0) {
        var_05.var_0D95 = self.var_9DD6;
      } else {
        var_05.var_0D95 = 2;
      }

      var_05.var_9D65 = spawn("script_origin", var_05.var_0116);
      var_05 thread func_9DD2(self);
      var_05 thread func_9DCC(self);
      var_05 thread func_9DD3(self);
      var_05 thread func_9DD5(self);
      var_05 thread func_9DDB(self);
      var_05 thread maps\mp\gametypes\_weapons::func_1DF6();
      if(level.var_984D) {
        var_05 maps\mp\_entityheadicons::func_873C(var_05.var_01A7, (0, 0, 65));
      } else {
        var_05 maps\mp\_entityheadicons::func_86FC(var_05.var_0117, (0, 0, 65));
      }

      wait 0.05;
      if(isDefined(var_01)) {
        var_01 delete();
      }
    }
  }
}

func_9DD8() {
  if(self.var_94B9) {
    return;
  }

  self.var_94B9 = 1;
  playFXOnTag(common_scripts\utility::func_44F5("mine_stunned"), self, "tag_origin");
}

func_9DD9() {
  self.var_94B9 = 0;
  stopFXOnTag(common_scripts\utility::func_44F5("mine_stunned"), self, "tag_origin");
}

func_9DD1(param_00) {
  if(isDefined(self.var_37D3)) {
    self.var_37D3 destroy();
  }

  self notify("change_owner");
  self.var_0117 = param_00;
  self.var_01A7 = param_00.var_01A7;
  param_00.var_9DCF[param_00.var_9DCF.size] = self;
  if(level.var_984D) {
    maps\mp\_entityheadicons::func_873C(self.var_01A7, (0, 0, 65));
  } else {
    maps\mp\_entityheadicons::func_86FC(self.var_0117, (0, 0, 65));
  }

  thread func_9DD2(param_00);
  thread func_9DCC(param_00);
  thread func_9DD3(param_00);
  thread func_9DD5(param_00);
}

func_9DDB(param_00) {
  self endon("death");
  level endon("game_ended");
  param_00 endon("disconnect");
  param_00 endon("death");
  self.var_9D65 setcursorhint("HINT_NOICON");
  self.var_9D65 sethintstring(&"MP_PICKUP_TROPHY");
  self.var_9D65 maps\mp\_utility::func_871E(param_00);
  self.var_9D65 thread maps\mp\_utility::func_6819(param_00);
  for(;;) {
    self.var_9D65 waittill("trigger", param_00);
    param_00 method_8615("scavenger_pack_pickup");
    var_01 = param_00 getweaponammoclip("trophy_mp");
    param_00 method_82FA("trophy_mp", var_01 + 1);
    param_00.var_9DD6 = self.var_0D95;
    self.var_9D65 delete();
    self delete();
    self notify("death");
  }
}

func_9DD5(param_00) {
  self endon("disconnect");
  self endon("death");
  self endon("change_owner");
  param_00 waittill("spawned");
  thread func_9DD0();
}

func_9DD3(param_00) {
  self endon("death");
  self endon("change_owner");
  param_00 waittill("disconnect");
  thread func_9DD0();
}

func_9DCC(param_00, param_01, param_02, param_03) {
  param_00 endon("disconnect");
  self endon("death");
  self endon("change_owner");
  self endon("trophyDisabled");
  if(!isDefined(param_01)) {
    param_01 = 384;
  }

  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  if(!isDefined(param_03)) {
    param_03 = "trophy_mp";
  }

  var_04 = param_01 * param_01;
  for(;;) {
    if(!isDefined(level.var_486C) || (level.var_486C.size < 1 && level.var_6248.size < 1 && level.var_9BB5.size < 1) || isDefined(self.var_2F74) || self.var_94B9 == 1) {
      wait 0.05;
      continue;
    }

    var_05 = common_scripts\utility::func_0F73(level.var_486C, level.var_6248);
    var_05 = common_scripts\utility::func_0F73(var_05, level.var_9BB5);
    if(var_05.size < 1) {
      wait 0.05;
      continue;
    }

    foreach(var_07 in var_05) {
      wait 0.05;
      if(!isDefined(var_07)) {
        continue;
      }

      if(var_07 == self) {
        continue;
      }

      if(isDefined(var_07.var_A9E0)) {
        switch (var_07.var_A9E0) {
          case "claymore_mp":
          case "carepackage_crate_mp":
            break;
        }
      }

      switch (var_07.var_0106) {
        case "weapon_parabolic_knife":
        case "weapon_jammer":
        case "weapon_radar":
        case "mp_trophy_system":
          break;
      }

      if(!isDefined(var_07.var_0117)) {
        var_07.var_0117 = function_01B3(var_07);
      }

      if(isDefined(var_07.var_0117) && level.var_984D && var_07.var_0117.var_01A7 == param_00.var_01A7) {
        continue;
      }

      if(isDefined(var_07.var_0117) && var_07.var_0117 == param_00) {
        continue;
      }

      if(!func_9DDC(var_07)) {
        continue;
      }

      var_08 = distancesquared(var_07.var_0116, self.var_0116);
      if(var_08 < var_04) {
        if(bullettracepassed(var_07.var_0116, self.var_0116, 0, self)) {
          var_09 = self.var_0116 + (0, 0, 32);
          if(isDefined(self.var_5B09)) {
            var_09 = self.var_5B09.var_0116;
          }

          playFX(common_scripts\utility::func_44F5("trophy_detonation"), var_09, var_07.var_0116 - self.var_0116, anglestoup(self.var_001D));
          thread func_9DD4(param_00, var_07);
          self method_8617("trophy_detect_projectile");
          if(isDefined(var_07.var_003A) && var_07.var_003A == "rocket" && isDefined(var_07.var_01B9) && var_07.var_01B9 == "remote") {
            if(isDefined(var_07.var_01B9) && var_07.var_01B9 == "remote") {
              level thread maps\mp\gametypes\_missions::func_A3F7(var_07.var_0117, param_00, undefined, param_00, undefined, "MOD_EXPLOSIVE", param_03);
              level thread maps\mp\_utility::func_9863("callout_destroyed_predator_missile", param_00);
              level thread maps\mp\gametypes\_rank::func_1457("kill", param_00, param_03, undefined, "MOD_EXPLOSIVE");
              param_00 notify("destroyed_killstreak", param_03);
            }

            playFX(common_scripts\utility::func_44F5("trophy_detonation"), var_07.var_0116);
            if(isDefined(level.var_15CA)) {
              var_07 method_8617(level.var_15CA);
            }
          }

          param_00 thread func_776D(var_07, self);
          param_00 maps\mp\gametypes\_missions::func_7750("ch_noboomforyou");
          if(!param_02) {
            self.var_0D95--;
          }

          if(self.var_0D95 <= 0) {
            thread func_9DD0();
          }
        }
      }
    }
  }
}

func_9DD7(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = (0, 0, 0);
  }

  self.var_61C0 = param_00;
  self.var_9DCE = param_01;
}

func_9DDC(param_00) {
  if(!isDefined(self.var_61C0)) {
    return 1;
  }

  var_01 = anglesToForward(self.var_001D + self.var_9DCE);
  var_02 = vectornormalize(param_00.var_0116 - self.var_0116);
  var_03 = vectordot(var_01, var_02);
  return var_03 > self.var_61C0;
}

func_9DD4(param_00, param_01) {
  if(!isDefined(self.var_5B09)) {
    return;
  }

  param_00 endon("disconnect");
  self endon("death");
  self endon("change_owner");
  self endon("trophyDisabled");
  self.var_5B09 endon("death");
  self notify("trophyDelayClearLaser");
  self endon("trophyDelayClearLaser");
  self.var_5B09.var_001D = vectortoangles(param_01.var_0116 - self.var_5B09.var_0116);
  self.var_5B09 method_80A4("tracking_drone_laser");
  wait(0.7);
  self.var_5B09 method_80A5();
}

func_9DCD(param_00, param_01) {
  self.var_5B09 = spawn("script_model", self.var_0116);
  self.var_5B09 setModel("tag_laser");
  self.var_5B09.var_001D = self.var_001D;
  self.var_5B09.var_5B0F = param_00;
  self.var_5B09.var_5B0B = param_01;
  thread func_9DDA();
}

func_9DDA() {
  self endon("death");
  self endon("change_owner");
  self endon("trophyDisabled");
  self.var_5B09 endon("death");
  for(;;) {
    var_00 = anglesToForward(self.var_001D + self.var_5B09.var_5B0B);
    self.var_5B09.var_0116 = self.var_0116 + var_00 * self.var_5B09.var_5B0F;
    wait 0.05;
  }
}

func_776D(param_00, param_01) {
  self endon("death");
  var_02 = param_00.var_0116;
  var_03 = param_00.var_0106;
  var_04 = param_00.var_001D;
  if(var_03 == "weapon_light_marker") {
    playFX(common_scripts\utility::func_44F5("trophy_detonation"), var_02, anglesToForward(var_04), anglestoup(var_04));
    param_01 thread func_9DD0();
    param_00 delete();
    return;
  }

  param_00 delete();
  param_01 method_8617("trophy_fire");
  playFX(level.var_61C8, var_02, anglesToForward(var_04), anglestoup(var_04));
  radiusdamage(var_02, 128, 105, 10, self, "MOD_EXPLOSIVE", "trophy_mp");
}

func_9DD2(param_00) {
  self endon("death");
  param_00 endon("death");
  self endon("change_owner");
  self setCanDamage(1);
  self.var_00BC = 999999;
  self.var_00FB = 100;
  self.var_006A = 0;
  for(;;) {
    self waittill("damage", var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A);
    if(!isPlayer(var_02)) {
      continue;
    }

    if(!maps\mp\gametypes\_weapons::func_3ECD(self.var_0117, var_02)) {
      continue;
    }

    if(isDefined(var_0A)) {
      switch (var_0A) {
        case "signal_flare_expeditionary_mp":
        case "signal_flare_mp":
        case "stun_grenade_mp":
        case "concussion_grenade_mp":
        case "flash_grenade_mp":
        case "smoke_grenade_axis_expeditionary_mp":
        case "smoke_grenade_expeditionary_mp":
        case "smoke_grenade_axis_mp":
        case "smoke_grenade_mp":
          break;
      }
    }

    if(!isDefined(self)) {
      return;
    }

    if(maps\mp\_utility::func_5755(var_05)) {
      self.var_006A = self.var_006A + self.var_00FB;
    }

    if(isDefined(var_09) && var_09 &level.var_5039) {
      self.var_A86F = 1;
    }

    self.var_A86E = 1;
    if(isDefined(var_0A) && var_0A == "emp_grenade_mp" || var_0A == "emp_grenade_killstreak_mp") {
      self.var_006A = self.var_006A + self.var_00FB;
    }

    self.var_006A = self.var_006A + var_01;
    if(isPlayer(var_02)) {
      var_02 maps\mp\gametypes\_damagefeedback::func_A102("trophy");
    }

    if(self.var_006A >= self.var_00FB) {
      if(isDefined(param_00) && var_02 != param_00) {
        var_02 notify("destroyed_explosive");
      }

      thread func_9DD0();
    }
  }
}

func_9DD0() {
  playFXOnTag(common_scripts\utility::func_44F5("sentry_explode_mp"), self, "tag_origin");
  playFXOnTag(common_scripts\utility::func_44F5("sentry_smoke_mp"), self, "tag_origin");
  self method_8617("sentry_explode");
  self notify("death");
  var_00 = self.var_0116;
  self.var_9D65 makeunusable();
  if(isDefined(self.var_5B09)) {
    self.var_5B09 delete();
  }

  wait(3);
  if(isDefined(self.var_9D65)) {
    self.var_9D65 delete();
  }

  if(isDefined(self)) {
    self delete();
  }
}