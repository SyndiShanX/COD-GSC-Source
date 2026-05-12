/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1330.gsc
*********************************************/

lib_0532::func_00D5() {
  level.var_6232 = 6;
  level.var_622E = 675;
  level.var_622F = 185;
  level.var_6230 = 0.95;
  level.var_6231 = 2;
  level.var_6233 = 0.42;
  level.var_6234 = 1.65;
  level.var_622C = 2.1;
  level.var_6225 = 4.3;
  level.var_6226 = 1;
  level.var_6227 = 0.85;
  level.var_6228 = 0.25;
  self.var_622D = [];
  self.var_4B78 = 0;
}

lib_0532::func_3662() {
  self.var_4B78 = 1;
  thread lib_0532::func_5FC7();
  thread lib_0532::func_5FC9();
}

lib_0532::func_622A(param_00, param_01) {
  var_02 = "airstrike_missile_mp";
  var_03 = "scorestreak_minimap_mortar_strike_damage";
  var_04 = "scorestreak_minimap_mortar_strike_kill";
  var_05 = 1;
  var_06 = 100;
  var_07 = 0;
  var_08 = 1;
  var_09 = getweaponexplosionradius(var_02);
  var_0A = var_09 * 2;
  self.var_29E1 = spawnplane("script_model", param_01);
  self.var_29E1 method_8351(param_00, var_03, var_0A, var_0A, var_08, var_07);
  self.var_29E1 method_8352(var_06, var_05);
  var_0B = 100;
  var_0C = 0;
  var_0D = getweaponexplosiondistancefordamage(var_02, var_0C, var_0B);
  var_0E = var_0D * 2;
  self.var_5A88 = spawnplane("script_model", param_01);
  self.var_5A88 method_8351(param_00, var_04, var_0E, var_0E, var_08, var_07);
  self.var_5A88 method_8352(var_06, var_05);
}

lib_0532::func_6229() {
  self waittill("death");
  var_00 = 80;
  var_01 = 0;
  self.var_29E1 method_8352(var_00, var_01);
  self.var_5A88 method_8352(var_00, var_01);
  wait(var_00 / 1000);
  self.var_29E1 delete();
  self.var_5A88 delete();
}

lib_0532::func_5FC7() {
  self endon("MisinformationDisabled");
  for(;;) {
    var_00 = lib_0532::func_464F();
    if(getpathdist(self.var_0116, var_00) > 0) {
      var_00 = var_00 - (0, 0, 500);
      lib_0532::func_622A(self, var_00);
      wait(randomfloat(level.var_6226) + level.var_6225);
      lib_0532::func_6229();
      wait(randomfloat(level.var_6228) + level.var_6227);
      continue;
    }

    wait 0.05;
  }
}

lib_0532::func_5FC8() {
  self endon("MisinformationDisabled");
  for(;;) {
    var_00 = lib_0532::func_464F();
    if(getpathdist(self.var_0116, var_00) > 0) {
      var_01 = randomint(10);
      if(var_01 >= 0 &var_01 < 6) {
        var_02 = "tabun_grenade_mp";
      } else if(var_02 >= 6 &var_02 < 9) {
        var_02 = "smoke_grenade_mp";
        if(isDefined(self.var_01A7) && self.var_01A7 == "axis") {
          var_02 = "smoke_grenade_axis_mp";
        }
      } else {
        var_02 = "killstreak_carepackage_grenade_mp";
      }

      magicgrenademanual(var_02, var_00, (0, 0, 0), 0.05, self);
      wait(level.var_622C);
      continue;
    }

    wait 0.05;
  }
}

lib_0532::func_5FC9() {
  self endon("MisinformationDisabled");
  for(;;) {
    var_00 = lib_0532::func_464F();
    if(getpathdist(self.var_0116, var_00) > 0) {
      thread lib_0532::func_2817(var_00);
      wait(level.var_6233 + randomfloat(level.var_6234));
      continue;
    }

    wait 0.05;
  }
}

lib_0532::func_2817(param_00) {
  self endon("MisinformationDisabled");
  var_01 = spawnStruct();
  if(isDefined(self.var_622D)) {
    self.var_622D = common_scripts\utility::func_0FA0(self.var_622D);
    if(self.var_622D.size >= level.var_6232) {
      maps\mp\_utility::func_068B(self.var_622D[0].var_3770);
      maps\mp\_utility::func_068B(self.var_622D[0].var_3EE2);
      self.var_622D[0] = undefined;
    }

    self.var_622D = common_scripts\utility::func_0FA0(self.var_622D);
  } else {
    self.var_622D = [];
  }

  self.var_622D[self.var_622D.size] = var_01;
  var_01.var_3EE2 = maps\mp\gametypes\_gameobjects::func_45A9();
  objective_add(var_01.var_3EE2, "invisible", (0, 0, 0));
  objective_position(var_01.var_3EE2, param_00);
  function_01D1(var_01.var_3EE2, "cb_compassping_minion_friend_mp");
  if(!level.var_984D) {
    objective_playerteam(var_01.var_3EE2, self getentitynumber());
  } else {
    objective_team(var_01.var_3EE2, self.var_01A7);
  }

  var_01.var_3770 = maps\mp\gametypes\_gameobjects::func_45A9();
  objective_add(var_01.var_3770, "invisible", (0, 0, 0));
  objective_position(var_01.var_3770, param_00);
  function_01D1(var_01.var_3770, "cb_compassping_enemy_objective");
  if(!level.var_984D) {
    objective_playerenemyteam(var_01.var_3770, self getentitynumber());
  } else {
    objective_team(var_01.var_3770, level.var_6C63[self.var_01A7]);
  }

  if(self.var_4B78) {
    thread lib_0532::func_63CF(var_01);
    return;
  }

  self.var_622D = common_scripts\utility::func_0F98(var_01, self.var_622D);
  maps\mp\_utility::func_068B(var_01.var_3770);
  maps\mp\_utility::func_068B(var_01.var_3EE2);
  var_01 = undefined;
}

lib_0532::func_63CF(param_00) {
  self endon("MisinformationDisabled");
  if(!isDefined(param_00) || !isDefined(param_00.var_3770) || !isDefined(param_00.var_3EE2)) {
    return;
  }

  objective_state(param_00.var_3770, "active");
  objective_state(param_00.var_3EE2, "active");
  wait(level.var_6230 + randomfloat(level.var_6231));
  if(!isDefined(param_00) || !isDefined(param_00.var_3770) || !isDefined(param_00.var_3EE2)) {
    return;
  }

  self.var_622D = common_scripts\utility::func_0F98(param_00, self.var_622D);
  maps\mp\_utility::func_068B(param_00.var_3770);
  maps\mp\_utility::func_068B(param_00.var_3EE2);
  param_00 = undefined;
}

lib_0532::func_2F9E() {
  self notify("MisinformationDisabled");
  if(isDefined(self.var_622B)) {
    self.var_622B delete();
  }

  if(isDefined(self.var_622D)) {
    self.var_622D = common_scripts\utility::func_0FA0(self.var_622D);
    for(var_00 = self.var_622D.size - 1; var_00 >= 0; var_00--) {
      maps\mp\_utility::func_068B(self.var_622D[var_00].var_3770);
      maps\mp\_utility::func_068B(self.var_622D[var_00].var_3EE2);
      self.var_622D[var_00] = undefined;
    }

    self.var_622D = [];
  }

  self.var_4B78 = 0;
}

lib_0532::func_464F() {
  var_00 = randomint(2) * 2 - 1;
  var_01 = randomint(2) * 2 - 1;
  var_02 = (var_00 * randomfloatrange(level.var_622F, level.var_622E), var_01 * randomfloatrange(level.var_622F, level.var_622E), 0);
  var_02 = self.var_0116 + var_02;
  var_02 = getgroundposition(var_02, 3);
  return var_02;
}