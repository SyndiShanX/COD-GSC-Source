/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_flak_gun.gsc
*********************************************/

func_00D5() {
  level.var_0611["flak_gun_explosion"] = loadfx("vfx/scorestreaks/ss_flak_explosion_01");
  level.var_5A61["flak_gun"] = ::func_9E2C;
  level.var_5A7D["killstreak_flak_gun_mp"] = "flak_gun";
}

func_9E2C(param_00) {
  return func_9E30("flak_gun");
}

func_9E25(param_00) {
  return func_9E30("counter_uav");
}

func_9E30(param_00) {
  if(level.var_984D && param_00 == "counter_uav" && level.var_9850[common_scripts\utility::func_416F(self.var_01A7)]) {
    self iclientprintlnbold(&"KILLSTREAKS_COUNTER_RECON_TEAM_ALREADY_HAS");
    return 0;
  }

  if(level.var_984D && level.var_9854[common_scripts\utility::func_416F(self.var_01A7)]) {
    self iclientprintlnbold(&"KILLSTREAKS_FLAK_GUN_TEAM_ALREADY_HAS");
    return 0;
  }

  if((!level.var_984D && isDefined(level.var_3CE0)) || level.var_984D && level.var_9854[self.var_01A7]) {
    self iclientprintlnbold(&"KILLSTREAKS_FLAK_GUN_ONE_AT_A_TIME");
    return 0;
  }

  maps\mp\_matchdata::func_5E9A(param_00, self.var_0116);
  thread func_A20C(param_00);
  return 1;
}

func_A20C(param_00) {
  thread func_6B75(self.var_01A7, param_00);
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  thread func_2DC2(self, param_00);
  var_01 = 0;
  if(param_00 == "flak_gun") {
    var_02 = maps\mp\_utility::func_0649("specialty_improvedstreaks");
    if(var_02) {
      var_01 = 45;
    } else {
      var_01 = 30;
    }

    if(level.var_984D) {
      level.var_9854[maps\mp\_utility::func_45DE(self.var_01A7)] = 1;
    }

    level.var_3CE0 = self;
  } else if(var_01 == "counter_uav") {
    var_02 = 30;
    if(level.var_984D) {
      level.var_9850[maps\mp\_utility::func_45DE(self.var_01A7)] = 1;
    } else {
      level.var_2694 = self;
    }
  }

  level thread lib_0528::func_A0E0();
  maps\mp\gametypes\_hostmigration::func_A6F5(var_02);
  level thread func_4AC0(self.var_01A7, var_01);
}

func_6B75(param_00, param_01) {
  level endon("flakGunsDisabled");
  common_scripts\utility::func_A70A("disconnect", "joined_team", "joined_spectators");
  level thread func_4AC0(param_00, param_01);
}

func_4AC0(param_00, param_01) {
  level notify("flakGunsDisabled");
  level.var_3CE2 = 0;
  if(param_01 == "flak_gun") {
    if(level.var_984D) {
      level.var_9854[maps\mp\_utility::func_45DE(param_00)] = 0;
    }

    level.var_3CE0 = undefined;
  } else if(param_01 == "counter_uav") {
    if(level.var_984D) {
      level.var_9850[maps\mp\_utility::func_45DE(param_00)] = 0;
    } else {
      level.var_2694 = undefined;
    }
  }

  level thread lib_0528::func_A0E0();
}

func_2DC2(param_00, param_01) {
  level endon("flakGunsDisabled");
  level.var_3CE2 = 0;
  wait(0.6);
  thread func_2DC1(param_00, param_01);
  if(param_01 == "flak_gun") {
    thread func_2DC0(param_00, param_01);
  }

  wait(0.4);
  level thread func_1129(param_00, param_01);
}

func_2DC0(param_00, param_01) {
  level endon("flakGunsDisabled");
  var_02 = [];
  for(;;) {
    var_03 = level.var_7043;
    foreach(var_05 in var_03) {
      var_06 = 0;
      for(var_07 = 0; var_07 < var_02.size; var_07++) {
        if(var_02[var_07] == var_05) {
          var_06 = 1;
        }
      }

      if(var_06 || (level.var_984D && isDefined(var_05.var_01A7) && var_05.var_01A7 == param_00.var_01A7) || !level.var_984D && isDefined(var_05.var_0117) && var_05.var_0117 == param_00) {
        continue;
      }

      if(isDefined(var_05.var_275E)) {
        var_05 = var_05.var_376E;
      }

      var_02[var_02.size] = var_05;
      thread func_2DDA(param_00, var_05, func_45BD(var_05.var_01C8), param_01);
      wait 0.05;
    }

    wait(0.1);
  }
}

func_2DC1(param_00, param_01) {
  level endon("flakGunsDisabled");
  var_02 = [];
  for(;;) {
    var_03 = level.var_9FDA;
    if(level.var_984D) {
      var_03 = level.var_9FDA[maps\mp\_utility::func_45DE(param_00.var_01A7)];
    }

    foreach(var_05 in var_03) {
      var_06 = 0;
      for(var_07 = 0; var_07 < var_02.size; var_07++) {
        if(var_02[var_07] == var_05) {
          var_06 = 1;
        }
      }

      if(var_06 || (level.var_984D && isDefined(var_05.var_01A7) && var_05.var_01A7 == param_00.var_01A7) || !level.var_984D && isDefined(var_05.var_0117) && var_05.var_0117 == param_00) {
        continue;
      }

      var_02[var_02.size] = var_05;
      thread func_2DDA(param_00, var_05, func_45BD(var_05.var_01C8), param_01);
      wait 0.05;
    }

    wait(0.1);
  }
}

func_2DDA(param_00, param_01, param_02, param_03) {
  level endon("flakGunsDisabled");
  level.var_3CE2++;
  level thread func_3BE7(param_00, param_01, param_02, param_03);
  param_01 waittill("death");
  level.var_3CE2--;
}

func_3BE7(param_00, param_01, param_02, param_03) {
  level endon("flakGunsDisabled");
  param_01 endon("death");
  var_04 = "MOD_EXPLOSIVE";
  var_05 = "killstreak_flak_gun_mp";
  var_06 = param_01.var_00FB / param_02;
  var_07 = param_01.var_0116;
  wait(0.4);
  while(param_01.var_00BC > 0 && param_01.var_006A < param_01.var_00FB) {
    var_08 = param_01.var_0116 - var_07;
    var_07 = param_01.var_0116;
    var_09 = 0;
    for(var_0A = 0; var_0A < 6 && isDefined(param_01) && param_01.var_00BC > 0 && param_01.var_006A < param_01.var_00FB; var_0A++) {
      var_0B = param_01.var_0116 + var_08;
      var_0B = (randomfloatrange(-600, 600) + var_0B[0], randomfloatrange(-600, 600) + var_0B[1], randomfloatrange(-200, 200) + var_0B[2]);
      thread func_3CDE(var_0B, param_03);
      wait 0.05;
    }

    param_01 dodamage(var_06, param_01.var_0116, param_00, param_00, var_04, var_05);
    wait(0.4);
  }
}

func_45BD(param_00) {
  switch (param_00) {
    case "plane_gunner":
      return 5;

    case "emergency_carepackage":
    case "carepackage":
    case "fighter_strike":
      return 2;

    case "firebomb":
    case "airstrike":
      return 3;

    case "advanced_uav":
    case "counter_uav":
    case "uav":
    default:
      return 1;
  }
}

func_1129(param_00, param_01) {
  level endon("flakGunsDisabled");
  level.var_3CE1 = 0;
  for(;;) {
    if(level.var_3CE2 == 0 && level.var_3CE1 < 30) {
      var_02 = lib_0527::func_4409();
      var_03 = (randomfloatrange(-3000, 3000) + level.var_5FEB[0], randomfloatrange(-3000, 3000) + level.var_5FEB[1], var_02);
      level.var_3CE1++;
      thread func_3CDE(var_03, param_01);
      wait 0.05;
      continue;
    }

    wait 0.05;
  }
}

func_3CDE(param_00, param_01) {
  var_02 = common_scripts\utility::func_8FFC();
  var_02.var_0116 = param_00;
  var_02 method_805B();
  wait 0.05;
  playFXOnTag(common_scripts\utility::func_44F5("flak_gun_explosion"), var_02, "tag_origin");
  lib_0378::func_8D74("ks_flak_cannon_explo", param_00);
  wait(4.5);
  var_02 delete();
  level.var_3CE1--;
}