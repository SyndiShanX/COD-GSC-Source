/*************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_portable_radar.gsc
*************************************************/

func_2D49(param_00) {
  if(!isDefined(param_00)) {
    return;
  }

  foreach(var_02 in level.var_744A) {
    if(isDefined(var_02)) {
      var_02.var_5383 = undefined;
    }
  }

  param_00 notify("death");
  param_00 delete();
}

func_63C9() {
  self endon("disconnect");
  level endon("game_ended");
  self.var_757A = [];
  for(;;) {
    self waittill("grenade_fire", var_00, var_01);
    if(var_01 == "portabl_radar" || var_01 == "portable_radar_mp") {
      if(!isalive(self)) {
        var_00 delete();
        continue;
      }

      self.var_757A = common_scripts\utility::func_0FA0(self.var_757A);
      if(self.var_757A.size >= level.var_6092) {
        func_2D49(self.var_757A[0]);
      }

      var_00 waittill("missile_stuck");
      var_02 = var_00.var_0116;
      if(isDefined(var_00)) {
        var_00 delete();
      }

      var_03 = spawn("script_model", var_02);
      var_03.var_00BC = 100;
      var_03.var_01A7 = self.var_01A7;
      var_03.var_0117 = self;
      var_03 setCanDamage(1);
      var_03 makeportableradar(self);
      var_03 func_757E(self);
      var_03 thread maps\mp\gametypes\_weapons::func_27D0("weapon_radar_bombsquad", "tag_origin", self);
      var_03 thread func_757D();
      thread func_7580(var_03);
      self.var_757A[self.var_757A.size] = var_03;
    }
  }
}

func_757E(param_00) {
  self setModel("weapon_radar");
  if(level.var_984D) {
    maps\mp\_entityheadicons::func_873C(self.var_01A7, (0, 0, 20));
  } else {
    maps\mp\_entityheadicons::func_86FC(param_00, (0, 0, 20));
  }

  thread func_757C(param_00);
  thread func_757F(param_00);
  thread func_757B();
  thread maps\mp\_utility::func_6819(param_00);
}

func_7580(param_00) {
  param_00 endon("death");
  level endon("game_ended");
  common_scripts\utility::func_A70A("disconnect", "joined_team", "joined_spectators", "spawned_player");
  level thread func_2D49(param_00);
}

func_757B() {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    wait(2);
    self method_8617("sentry_gun_beep");
  }
}

func_757C(param_00) {
  self endon("death");
  self.var_00BC = 999999;
  self.var_00FB = 100;
  self.var_006A = 0;
  for(;;) {
    self waittill("damage", var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A);
    if(!maps\mp\gametypes\_weapons::func_3ECD(self.var_0117, var_02)) {
      continue;
    }

    if(isDefined(var_0A)) {
      switch (var_0A) {
        case "stun_grenade_mp":
        case "concussion_grenade_mp":
        case "flash_grenade_mp":
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
    self.var_006A = self.var_006A + var_01;
    if(isDefined(var_0A) && var_0A == "emp_grenade_mp" || var_0A == "emp_grenade_killstreak_mp") {
      self.var_006A = self.var_00FB + 1;
    }

    if(isPlayer(var_02)) {
      var_02 maps\mp\gametypes\_damagefeedback::func_A102("portable_radar");
    }

    if(self.var_006A >= self.var_00FB) {
      if(isDefined(param_00) && var_02 != param_00) {
        var_02 notify("destroyed_explosive");
      }

      self method_8617("sentry_explode");
      self.var_2AA1 = playFX(common_scripts\utility::func_44F5("equipment_explode"), self.var_0116);
      self freeentitysentient();
      var_02 thread func_2D49(self);
    }
  }
}

func_757F(param_00) {
  self endon("death");
  level endon("game_ended");
  param_00 endon("disconnect");
  self setcursorhint("HINT_NOICON");
  self sethintstring(&"MP_PATCH_PICKUP_PORTABLE_RADAR");
  maps\mp\_utility::func_871E(param_00);
  for(;;) {
    self waittill("trigger", param_00);
    var_01 = param_00 getweaponammostock("portable_radar_mp");
    if(var_01 < weaponmaxammo("portable_radar_mp")) {
      param_00 method_8615("scavenger_pack_pickup");
      param_00 setweaponammostock("portable_radar_mp", var_01 + 1);
      param_00 thread func_2D49(self);
    }
  }
}

func_757D() {
  self endon("death");
  level endon("game_ended");
  var_00 = 512;
  for(;;) {
    foreach(var_02 in level.var_744A) {
      if(!isDefined(var_02)) {
        continue;
      }

      if(level.var_984D && var_02.var_01A7 == self.var_01A7) {
        continue;
      }

      if(var_02 maps\mp\_utility::func_0649("specialty_radarimmune") || var_02 maps\mp\_utility::func_0649("specialty_uavhidden")) {
        continue;
      }

      var_03 = distancesquared(self.var_0116, var_02.var_0116);
      if(distancesquared(var_02.var_0116, self.var_0116) < var_00 * var_00) {
        var_02.var_5383 = self.var_0117;
        continue;
      }

      var_02.var_5383 = undefined;
    }

    wait 0.05;
  }
}