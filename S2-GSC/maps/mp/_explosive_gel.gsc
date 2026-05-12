/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\_explosive_gel.gsc
*********************************************/

func_A907() {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("death");
  self endon("faux_spawn");
  for(;;) {
    self waittill("grenade_fire", var_00, var_01);
    if(var_01 == "explosive_gel_mp") {
      if(!isalive(self)) {
        var_00 delete();
        return;
      }

      thread func_9E28(var_00);
    }
  }
}

func_00D5() {
  precachemodel("weapon_c4");
  precachemodel("weapon_c4_bombsquad");
  level.var_3960 = spawnStruct();
  level.var_3960.var_9489 = "weapon_c4";
  level.var_3960.var_4010 = "weapon_c4_bombsquad";
  level.var_3960.var_4011 = loadfx("vfx/explosion/frag_grenade_default");
  level.var_3960.var_16F1["enemy"] = loadfx("vfx/lights/light_c4_blink");
  level.var_3960.var_16F1["friendly"] = loadfx("vfx/lights/light_mine_blink_friendly");
}

func_9E28(param_00) {
  thread func_5C29(param_00);
  return 1;
}

func_5C29(param_00) {
  thread func_A906(param_00);
  var_01 = func_939D(param_00);
}

func_A906(param_00) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("change_owner");
  param_00 endon("missile_stuck");
  param_00 endon("death");
  var_01 = 0;
  for(;;) {
    if(self useButtonPressed()) {
      var_01 = 0;
      while(self useButtonPressed()) {
        var_01 = var_01 + 0.05;
        wait 0.05;
      }

      if(var_01 >= 0.5) {
        continue;
      }

      var_01 = 0;
      while(!self useButtonPressed() && var_01 < 0.5) {
        var_01 = var_01 + 0.05;
        wait 0.05;
      }

      if(var_01 >= 0.5) {
        continue;
      }

      thread func_3537(param_00);
    }

    wait 0.05;
  }
}

func_939D(param_00) {
  self endon("earlyNotify");
  param_00 waittill("missile_stuck");
  var_01 = bulletTrace(param_00.var_0116, param_00.var_0116 - (0, 0, 4), 0, param_00);
  var_02 = bulletTrace(param_00.var_0116, param_00.var_0116 + (0, 0, 4), 0, param_00);
  var_03 = anglesToForward(param_00.var_001D);
  var_04 = bulletTrace(param_00.var_0116 + (0, 0, 4), param_00.var_0116 + var_03 * 4, 0, param_00);
  var_05 = undefined;
  var_06 = 0;
  var_07 = 0;
  if(var_04["surfacetype"] != "none") {
    var_05 = var_04;
    var_07 = 1;
  } else if(var_02["surfacetype"] != "none") {
    var_05 = var_02;
    var_06 = 1;
  } else if(var_01["surfacetype"] != "none") {
    var_05 = var_01;
  } else {
    var_05 = var_01;
  }

  var_08 = var_05["position"];
  if(var_08 == var_02["position"]) {
    var_08 = var_08 + (0, 0, -5);
  }

  var_09 = spawn("script_model", var_08);
  var_09.var_5817 = var_06;
  var_09.var_56F9 = var_07;
  var_0A = vectornormalize(var_05["normal"]);
  var_0B = vectortoangles(var_0A);
  var_0B = var_0B + (90, 0, 0);
  var_09.var_001D = var_0B;
  var_09 setModel(level.var_3960.var_9489);
  var_09.var_0117 = self;
  var_09 setotherent(self);
  var_09.var_5A30 = (0, 0, 55);
  var_09.var_5A2C = spawn("script_model", var_09.var_0116 + var_09.var_5A30);
  var_09.var_94B9 = 0;
  var_09.var_A9E0 = "explosive_gel_mp";
  param_00 delete();
  level.var_61ED[level.var_61ED.size] = var_09;
  var_09 thread func_27D0(level.var_3960.var_4010, "tag_origin", self);
  var_09 thread func_61D0();
  var_09 thread func_8679(self.var_01A7);
  var_09 thread func_61DD();
  var_09 thread func_395F(self);
  return var_09;
}

func_27D0(param_00, param_01, param_02) {
  var_03 = spawn("script_model", (0, 0, 0));
  var_03 method_805C();
  wait 0.05;
  var_03 thread maps\mp\gametypes\_weapons::func_1908(param_02);
  var_03 setModel(param_00);
  var_03 linkto(self, param_01, (0, 0, 0), (0, 0, 0));
  var_03 method_80B1();
  self waittill("death");
  if(isDefined(self.var_9D65)) {
    self.var_9D65 delete();
  }

  var_03 delete();
}

func_61D0() {
  var_00["friendly"] = spawnfx(level.var_3960.var_16F1["friendly"], self gettagorigin("tag_fx"));
  var_00["enemy"] = spawnfx(level.var_3960.var_16F1["enemy"], self gettagorigin("tag_fx"));
  thread func_61D1(var_00);
  self waittill("death");
  var_00["friendly"] delete();
  var_00["enemy"] delete();
}

func_61D1(param_00, param_01) {
  self endon("death");
  var_02 = self.var_0117.var_01A7;
  wait 0.05;
  triggerfx(param_00["friendly"]);
  triggerfx(param_00["enemy"]);
  for(;;) {
    param_00["friendly"] method_805C();
    param_00["enemy"] method_805C();
    foreach(var_04 in level.var_744A) {
      if(level.var_984D) {
        if(var_04.var_01A7 == var_02) {
          param_00["friendly"] showtoclient(var_04);
        } else {
          param_00["enemy"] showtoclient(var_04);
        }

        continue;
      }

      if(var_04 == self.var_0117) {
        param_00["friendly"] showtoclient(var_04);
        continue;
      }

      param_00["enemy"] showtoclient(var_04);
    }

    level common_scripts\utility::func_A732("joined_team", "player_spawned");
  }
}

func_8679(param_00) {
  self endon("death");
  wait 0.05;
  if(level.var_984D) {
    if(self.var_5817 == 1 || self.var_56F9 == 1) {
      maps\mp\_entityheadicons::func_873C(param_00, (0, 0, 28), undefined, 1);
      return;
    }

    maps\mp\_entityheadicons::func_873C(param_00, (0, 0, 28));
    return;
  }

  if(isDefined(self.var_0117)) {
    if(self.var_5817 == 1) {
      maps\mp\_entityheadicons::func_86FC(self.var_0117, (28, 0, 28));
      return;
    }

    maps\mp\_entityheadicons::func_86FC(self.var_0117, (0, 0, 28));
    return;
  }
}

func_61DD() {
  self endon("mine_triggered");
  self endon("mine_selfdestruct");
  self endon("death");
  self setCanDamage(1);
  self.var_00FB = 100000;
  self.var_00BC = self.var_00FB;
  var_00 = undefined;
  for(;;) {
    self waittill("damage", var_01, var_00, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);
    if(!isPlayer(var_00)) {
      continue;
    }

    if(!maps\mp\gametypes\_weapons::func_3ECD(self.var_0117, var_00)) {
      continue;
    }

    if(isDefined(var_09)) {
      switch (var_09) {
        case "smoke_grenade_mp":
          break;
      }
    }

    break;
  }

  self notify("mine_destroyed");
  if(isDefined(var_04) && issubstr(var_04, "MOD_GRENADE") || issubstr(var_04, "MOD_EXPLOSIVE")) {
    self.var_A86B = 1;
  }

  if(isDefined(var_08) && var_08 &level.var_5039) {
    self.var_A86F = 1;
  }

  self.var_A86E = 1;
  if(isPlayer(var_00)) {
    var_00 maps\mp\gametypes\_damagefeedback::func_A102("bouncing_betty");
  }

  if(level.var_984D) {
    if(isDefined(var_00) && isDefined(var_00.var_012C["team"]) && isDefined(self.var_0117) && isDefined(self.var_0117.var_012C["team"])) {
      if(var_00.var_012C["team"] != self.var_0117.var_012C["team"]) {
        var_00 notify("destroyed_explosive");
      }
    }
  } else if(isDefined(self.var_0117) && isDefined(var_00) && var_00 != self.var_0117) {
    var_00 notify("destroyed_explosive");
  }

  thread func_61E3(var_00);
}

func_61E3(param_00) {
  if(!isDefined(self) || !isDefined(self.var_0117)) {
    return;
  }

  if(!isDefined(param_00)) {
    param_00 = self.var_0117;
  }

  self method_8617("null");
  var_01 = self gettagorigin("tag_fx");
  playFX(level.var_3960.var_4011, var_01);
  wait 0.05;
  if(!isDefined(self) || !isDefined(self.var_0117)) {
    return;
  }

  self method_805C();
  self entityradiusdamage(self.var_0116, 192, 100, 100, param_00, "MOD_EXPLOSIVE");
  if(isDefined(self.var_0117) && isDefined(level.var_5C44)) {
    self.var_0117 thread[[level.var_5C44]]("mine_destroyed", undefined, undefined, self.var_0116);
  }

  wait(0.2);
  if(!isDefined(self) || !isDefined(self.var_0117)) {
    return;
  }

  thread func_0F1B();
  self notify("death");
  if(isDefined(self.var_6FD8)) {
    self.var_6FD8 delete();
  }

  self method_805C();
}

func_3537(param_00) {
  self notify("earlyNotify");
  var_01 = param_00 gettagorigin("tag_fx");
  playFX(level.var_3960.var_4011, var_01);
  param_00 method_81D6();
}

func_0F1B() {
  wait(3);
  self.var_5A2C delete();
  self delete();
  level.var_61ED = common_scripts\utility::func_0FA0(level.var_61ED);
}

func_395F(param_00) {
  self endon("mine_destroyed");
  self endon("mine_selfdestruct");
  self endon("death");
  wait(3);
  self notify("mine_triggered");
  thread func_61E3();
}