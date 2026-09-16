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
        var_01 hide();
      }

      var_01 waittill("missile_stuck");
      if(!isDefined(param_00) || param_00 == 0) {
        var_03 = 40;
        if(var_03 * var_03 < distancesquared(var_01.origin, self.origin)) {
          var_04 = bulletTrace(self.origin, self.origin - (0, 0, var_03), 0, self);
          if(var_04["fraction"] == 1) {
            var_01 delete();
            self setweaponammostock("trophy_mp", self getweaponammostock("trophy_mp") + 1);
            continue;
          }

          var_01.origin = var_04["position"];
        }

        var_01 show();
      }

      self.var_9DCF = common_scripts\utility::func_FA0(self.var_9DCF);
      if(self.var_9DCF.size >= level.var_6092) {
        self.var_9DCF[0] thread func_9DD0();
      }

      var_05 = spawn("script_model", var_01.origin);
      var_05 setModel("mp_trophy_system");
      var_05 thread maps\mp\gametypes\_weapons::func_27D0("mp_trophy_system_bombsquad", "tag_origin", self);
      var_05.angles = var_01.angles;
      self.var_9DCF[self.var_9DCF.size] = var_05;
      var_05.owner = self;
      var_05.team = self.team;
      var_05.var_A9E0 = var_02;
      var_05.var_94B9 = 0;
      level.var_9DCB[level.var_9DCB.size] = var_05;
      if(isDefined(self.var_9DD6) && self.var_9DD6 > 0) {
        var_05.var_D95 = self.var_9DD6;
      } else {
        var_05.var_D95 = 2;
      }

      var_05.var_9D65 = spawn("script_origin", var_05.origin);
      var_05 thread func_9DD2(self);
      var_05 thread func_9DCC(self);
      var_05 thread func_9DD3(self);
      var_05 thread func_9DD5(self);
      var_05 thread func_9DDB(self);
      var_05 thread maps\mp\gametypes\_weapons::func_1DF6();
      if(level.teambased) {
        var_05 maps\mp\_entityheadicons::func_873C(var_05.team, (0, 0, 65));
      } else {
        var_05 maps\mp\_entityheadicons::func_86FC(var_05.owner, (0, 0, 65));
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
  self.owner = param_00;
  self.team = param_00.team;
  param_00.var_9DCF[param_00.var_9DCF.size] = self;
  if(level.teambased) {
    maps\mp\_entityheadicons::func_873C(self.team, (0, 0, 65));
  } else {
    maps\mp\_entityheadicons::func_86FC(self.owner, (0, 0, 65));
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
  self.var_9D65 setCursorHint("HINT_NOICON");
  self.var_9D65 setHintString(&"MP_PICKUP_TROPHY");
  self.var_9D65 maps\mp\_utility::func_871E(param_00);
  self.var_9D65 thread maps\mp\_utility::func_6819(param_00);
  for(;;) {
    self.var_9D65 waittill("trigger", param_00);
    param_00 playlocalsound("scavenger_pack_pickup");
    var_01 = param_00 getweaponammoclip("trophy_mp");
    param_00 setweaponammoclip("trophy_mp", var_01 + 1);
    param_00.var_9DD6 = self.var_D95;
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

    var_05 = common_scripts\utility::func_F73(level.var_486C, level.var_6248);
    var_05 = common_scripts\utility::func_F73(var_05, level.var_9BB5);
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

      switch (var_07.model) {
        case "weapon_parabolic_knife":
        case "weapon_jammer":
        case "weapon_radar":
        case "mp_trophy_system":
          break;
      }

      if(!isDefined(var_07.owner)) {
        var_07.owner = function_01B3(var_07);
      }

      if(isDefined(var_07.owner) && level.teambased && var_07.owner.team == param_00.team) {
        continue;
      }

      if(isDefined(var_07.owner) && var_07.owner == param_00) {
        continue;
      }

      if(!func_9DDC(var_07)) {
        continue;
      }

      var_08 = distancesquared(var_07.origin, self.origin);
      if(var_08 < var_04) {
        if(bullettracepassed(var_07.origin, self.origin, 0, self)) {
          var_09 = self.origin + (0, 0, 32);
          if(isDefined(self.var_5B09)) {
            var_09 = self.var_5B09.origin;
          }

          playFX(common_scripts\utility::func_44F5("trophy_detonation"), var_09, var_07.origin - self.origin, anglestoup(self.angles));
          thread func_9DD4(param_00, var_07);
          self playSound("trophy_detect_projectile");
          if(isDefined(var_07.classname) && var_07.classname == "rocket" && isDefined(var_07.type) && var_07.type == "remote") {
            if(isDefined(var_07.type) && var_07.type == "remote") {
              level thread maps\mp\gametypes\_missions::vehiclekilled(var_07.owner, param_00, undefined, param_00, undefined, "MOD_EXPLOSIVE", param_03);
              level thread maps\mp\_utility::func_9863("callout_destroyed_predator_missile", param_00);
              level thread maps\mp\gametypes\_rank::giverankxp("kill", param_00, param_03, undefined, "MOD_EXPLOSIVE");
              param_00 notify("destroyed_killstreak", param_03);
            }

            playFX(common_scripts\utility::func_44F5("trophy_detonation"), var_07.origin);
            if(isDefined(level.var_15CA)) {
              var_07 playSound(level.var_15CA);
            }
          }

          param_00 thread func_776D(var_07, self);
          param_00 maps\mp\gametypes\_missions::processchallenge("ch_noboomforyou");
          if(!param_02) {
            self.var_D95--;
          }

          if(self.var_D95 <= 0) {
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

  var_01 = anglesToForward(self.angles + self.var_9DCE);
  var_02 = vectorNormalize(param_00.origin - self.origin);
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
  self.var_5B09.angles = vectortoangles(param_01.origin - self.var_5B09.origin);
  self.var_5B09 method_80A4("tracking_drone_laser");
  wait(0.7);
  self.var_5B09 method_80A5();
}

func_9DCD(param_00, param_01) {
  self.var_5B09 = spawn("script_model", self.origin);
  self.var_5B09 setModel("tag_laser");
  self.var_5B09.angles = self.angles;
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
    var_00 = anglesToForward(self.angles + self.var_5B09.var_5B0B);
    self.var_5B09.origin = self.origin + var_00 * self.var_5B09.var_5B0F;
    wait 0.05;
  }
}

func_776D(param_00, param_01) {
  self endon("death");
  var_02 = param_00.origin;
  var_03 = param_00.model;
  var_04 = param_00.angles;
  if(var_03 == "weapon_light_marker") {
    playFX(common_scripts\utility::func_44F5("trophy_detonation"), var_02, anglesToForward(var_04), anglestoup(var_04));
    param_01 thread func_9DD0();
    param_00 delete();
    return;
  }

  param_00 delete();
  param_01 playSound("trophy_fire");
  playFX(level.var_61C8, var_02, anglesToForward(var_04), anglestoup(var_04));
  radiusdamage(var_02, 128, 105, 10, self, "MOD_EXPLOSIVE", "trophy_mp");
}

func_9DD2(param_00) {
  self endon("death");
  param_00 endon("death");
  self endon("change_owner");
  self setCanDamage(1);
  self.health = 999999;
  self.maxhealth = 100;
  self.var_6A = 0;
  for(;;) {
    self waittill("damage", var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A);
    if(!isPlayer(var_02)) {
      continue;
    }

    if(!maps\mp\gametypes\_weapons::func_3ECD(self.owner, var_02)) {
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

    if(maps\mp\_utility::ismeleemod(var_05)) {
      self.var_6A = self.var_6A + self.maxhealth;
    }

    if(isDefined(var_09) && var_09 &level.var_5039) {
      self.var_A86F = 1;
    }

    self.var_A86E = 1;
    if(isDefined(var_0A) && var_0A == "emp_grenade_mp" || var_0A == "emp_grenade_killstreak_mp") {
      self.var_6A = self.var_6A + self.maxhealth;
    }

    self.var_6A = self.var_6A + var_01;
    if(isPlayer(var_02)) {
      var_02 maps\mp\gametypes\_damagefeedback::func_A102("trophy");
    }

    if(self.var_6A >= self.maxhealth) {
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
  self playSound("sentry_explode");
  self notify("death");
  var_00 = self.origin;
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