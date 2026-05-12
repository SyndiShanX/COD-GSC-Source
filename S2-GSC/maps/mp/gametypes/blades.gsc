/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\blades.gsc
*********************************************/

func_00F9() {
  maps\mp\gametypes\_globallogic::func_00D5();
  lib_01DD::func_8A0C();
  maps\mp\gametypes\_globallogic::func_8A0C();
  if(isusingmatchrulesdata()) {
    level.var_5300 = ::func_5300;
    [[level.var_5300]]();
    level thread maps\mp\_utility::func_7C13();
  } else {
    maps\mp\_utility::func_7BFA(level.var_3FDC, 5);
    maps\mp\_utility::func_7BF9(level.var_3FDC, 0);
    maps\mp\_utility::func_7C04(level.var_3FDC, 1);
    maps\mp\_utility::func_7BF7(level.var_3FDC, 1);
    maps\mp\_utility::func_7BF1(level.var_3FDC, 0);
    maps\mp\_utility::func_7BE5(level.var_3FDC, 0);
    level.var_6031 = 0;
    level.var_6035 = 0;
    setdynamicdvar("scr_game_radarMode", 1);
  }

  setdvarifuninitialized("blades_score_riflebullet", 10);
  setdvarifuninitialized("blades_score_defectivegrenade", 6);
  setdvarifuninitialized("blades_score_melee", 3);
  setdvarifuninitialized("blades_score_throwingknife", 0);
  func_872E();
  maps\mp\_utility::func_873B(0);
  level.var_2F85 = 1;
  level.var_6BA7 = ::func_6BA7;
  level.var_6B7B = ::func_6B7B;
  level.var_6BAF = ::func_6BAF;
  level.var_6B5C = ::func_6B5C;
  level.var_6B7F = ::func_6B7F;
  level.var_1DEA = ::func_1785;
  level.var_80A8 = 1;
  level.var_2FAB = 1;
  level.disabledivisionstats = 1;
  level.var_2F8B = 1;
  level.disableallplayerstats = 1;
  level.disableweaponchallenges = 1;
  level.disabledivisionchallenges = 1;
  level.disablewinlossstats = 1;
  level.mgnestsdisabled = 1;
  level.disabledivisionpassives = 1;
  level.disabledivisionskills = 1;
  if(level.var_6031 || level.var_6035) {
    level.var_62AD = ::maps\mp\gametypes\_damage::func_3FC8;
  }

  setteammode("ffa");
  setdynamicdvar("scr_game_compassRadarUpdateTime", 9);
  game["dialog"]["gametype"] = "ffa_intro";
  game["dialog"]["defense_obj"] = "gbl_start";
  game["dialog"]["offense_obj"] = "gbl_start";
  if(getdvarint("2043")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  }
}

func_5300() {
  maps\mp\_utility::func_8653(1);
  setdynamicdvar("scr_blades_winlimit", 1);
  maps\mp\_utility::func_7C04("blades", 1);
  setdynamicdvar("scr_blades_roundlimit", 1);
  maps\mp\_utility::func_7BF7("blades", 1);
  setdynamicdvar("scr_blades_halftime", 0);
  maps\mp\_utility::func_7BE5("blades", 0);
}

func_6BAF() {
  setclientnamemode("auto_change");
  maps\mp\_utility::func_86DC("allies", &"OBJECTIVES_BLADES");
  maps\mp\_utility::func_86DC("axis", &"OBJECTIVES_BLADES");
  if(level.var_910F) {
    maps\mp\_utility::func_86DB("allies", &"OBJECTIVES_BLADES");
    maps\mp\_utility::func_86DB("axis", &"OBJECTIVES_BLADES");
  } else {
    maps\mp\_utility::func_86DB("allies", &"OBJECTIVES_BLADES_SCORE");
    maps\mp\_utility::func_86DB("axis", &"OBJECTIVES_BLADES_SCORE");
  }

  maps\mp\_utility::func_86D8("allies", &"OBJECTIVES_BLADES_HINT");
  maps\mp\_utility::func_86D8("axis", &"OBJECTIVES_BLADES_HINT");
  lib_050D::func_10E4();
  level.var_A239 = 0;
  var_00[0] = "blades";
  maps\mp\gametypes\_gameobjects::func_00F9(var_00);
  foreach(var_02 in level.var_744A) {
    var_02.var_012C["gamemodeLoadout"] = level.var_1784;
    var_02 maps\mp\gametypes\_class::func_4773(var_02.var_01A7, "gamemode");
  }

  level.var_7895 = 1;
  level.var_17EF = 1;
  level thread func_6B6C();
}

func_6B5C(param_00, param_01, param_02) {
  var_03 = 0;
  foreach(var_05 in level.var_744A) {
    if(isDefined(var_05.var_015C) && var_05.var_015C > var_03) {
      var_03 = var_05.var_015C;
    }
  }

  if(game["state"] == "postgame" && param_01.var_015C >= var_03) {
    param_01.var_3B4B = 1;
  }
}

func_6B7F(param_00, param_01, param_02, param_03, param_04) {
  var_05 = 0;
  if(func_57BE(param_00, param_03, param_04)) {
    if(isriflebulletkill(param_03, param_04)) {
      var_05 = getdvarint("blades_score_riflebullet", 10);
    } else if(isdefectivegrenadekill(param_03, param_04)) {
      var_05 = getdvarint("blades_score_defectivegrenade", 6);
    } else if(func_5754(param_03, param_04)) {
      var_05 = getdvarint("blades_score_melee", 3);
    } else if(func_5806(param_03, param_04)) {
      var_05 = getdvarint("blades_score_throwingknife", 0);
    }

    param_01 maps\mp\gametypes\_gamescore::func_A161(param_01, var_05);
  }

  return var_05;
}

func_57BE(param_00, param_01, param_02) {
  switch (param_00) {
    case "kill":
      return isriflebulletkill(param_01, param_02) || isdefectivegrenadekill(param_01, param_02) || func_5806(param_01, param_02) || func_5754(param_01, param_02);
  }

  return 0;
}

func_6B7B(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  if(!isDefined(param_01)) {
    return;
  }

  if(param_03 == "MOD_TRIGGER_HURT" && !isPlayer(param_01)) {
    param_01 = self;
  }

  if(param_03 == "MOD_FALLING" || isPlayer(param_01)) {
    if(param_03 == "MOD_FALLING" || param_01 == self || func_5806(param_04, param_03)) {
      self method_8615("mp_war_objective_lost");
      self.var_8C15 = 1;
      self.setbackduetosuicide = param_03 == "MOD_FALLING" || param_01 == self;
      self.var_65ED++;
      self.var_0021 = self.var_65ED;
      var_0A = self.var_015C;
      self.var_012C["score"] = 0;
      self.var_015C = 0;
      maps\mp\_utility::func_867B(0);
      maps\mp\gametypes\_gamescore::func_A161(self, var_0A * -1);
      if(func_5806(param_04, param_03) && isDefined(param_01)) {
        param_01.var_9149++;
        param_01 maps\mp\_utility::func_867C(param_01.var_9149);
        param_01 thread maps\mp\_events::bankruptenemybladesscoreevent();
        var_0B = getleadingplayer();
        if(isDefined(var_0B) && self == var_0B) {
          param_01 thread maps\mp\_events::bankruptfirstplayerbladesscoreevent();
          maps\mp\_utility::func_5C43("humiliation", "status");
          return;
        }

        return;
      }

      return;
    }

    if(func_57BE("kill", param_04, param_03) && !func_5806(param_04, param_03)) {
      if(param_01.lastscoretime + 3000 > gettime()) {
        param_01 thread maps\mp\_events::quickbladesscoreevent();
      }

      param_01.lastscoretime = gettime();
      if(isriflebulletkill(param_04, param_03)) {
        param_01 thread maps\mp\_events::increasedbladesscoreriflebulletevent();
        return;
      }

      if(isdefectivegrenadekill(param_04, param_03)) {
        param_01 thread maps\mp\_events::increasedbladesscoredefectivegrenadeevent();
        return;
      }

      if(func_5754(param_04, param_03)) {
        param_01 thread maps\mp\_events::increasedbladesscoremeleeevent();
        return;
      }

      return;
    }
  }
}

getleadingplayer() {
  var_00 = 0;
  var_01 = undefined;
  foreach(var_03 in level.var_744A) {
    if(isDefined(var_03.var_015C) && var_03.var_015C > var_00) {
      var_00 = var_03.var_015C;
      var_01 = var_03;
      continue;
    }

    if(isDefined(var_03.var_015C) && var_03.var_015C == var_00) {
      var_01 = undefined;
    }
  }

  return var_01;
}

func_5806(param_00, param_01) {
  return param_00 == "throwingknife_mp" && param_01 == "MOD_IMPACT";
}

func_5754(param_00, param_01) {
  return param_01 == "MOD_MELEE";
}

isdefectivegrenadekill(param_00, param_01) {
  return param_00 == "alt+m1garand_blades_mp+grenade_launcher_blades" && param_01 != "MOD_MELEE";
}

isriflebulletkill(param_00, param_01) {
  return param_00 == "alt+m30_blades_mp+m30_rifle_blades" && param_01 != "MOD_MELEE";
}

func_872E() {
  level.var_1784 = maps\mp\gametypes\_class::func_44B4();
  level.var_1784["loadoutDivision"] = 6;
  level.var_1784["loadoutPrimaryWeaponStruct"] = maps\mp\_utility::func_473C(16846848, 0);
  level.var_1784["loadoutSecondaryWeaponStruct"] = maps\mp\_utility::func_473C(16920576, 0);
  level.var_1784["loadoutEquipmentStruct"] = maps\mp\_utility::func_44CE(16818176, 0);
}

func_6B6C() {
  for(;;) {
    level waittill("connected", var_00);
    var_00.var_9149 = 0;
    var_00.var_65ED = 0;
    var_00.lastscoretime = 0;
    var_00.var_8C15 = 0;
    var_00.setbackduetosuicide = 0;
  }
}

func_7B82() {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    self waittill("reload");
    self givestartammo(self.var_7704);
    if(isDefined(self.lethalweapon)) {
      self givestartammo(self.lethalweapon);
      if(self.lethalweapon == "throwingknife_mp") {
        maps\mp\gametypes\_damagefeedback::func_A102("resupply_throwingknife");
        continue;
      }

      maps\mp\gametypes\_damagefeedback::func_A102("resupply_equipment");
    }
  }
}

func_7B85() {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    if(maps\mp\_utility::func_57A0(self) && self.var_01A7 != "spectator" && (isDefined(self.var_7704) && function_01A9(self.var_7704) != "melee" && self method_817F(self.var_7704) == 0) || isDefined(self.lethalweapon) && self method_817F(self.lethalweapon) == 0) {
      wait(2);
      self notify("reload");
      wait(1);
      continue;
    }

    wait 0.05;
  }
}

func_1785() {
  self.var_012C["class"] = "gamemode";
  self.var_012C["lastClass"] = "";
  self.var_012C["gamemodeLoadout"] = level.var_1784;
  self.var_2319 = self.var_012C["class"];
  self.var_5B84 = self.var_012C["lastClass"];
  maps\mp\gametypes\_class::func_4790(self.var_01A7, self.var_2319);
}

func_6BA7() {
  self method_8328();
  func_1785();
  thread func_A6F3();
}

func_A6F3() {
  level endon("game_ended");
  self endon("disconnect");
  level waittill("player_spawned");
  givesticksnstonesloadout();
  if(self.var_8C15) {
    if(self.setbackduetosuicide) {
      thread maps\mp\_events::bankruptedbladesscoresuicideevent();
    } else {
      thread maps\mp\_events::bankruptedbladesscoreevent();
    }

    self.var_8C15 = 0;
    self.setbackduetosuicide = 0;
  }
}

givesticksnstonesloadout() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self notify("giveRifleBulletGun");
  self endon("giveRifleBulletGun");
  waittillframeend;
  maps\mp\_utility::func_47A2("specialty_longersprint");
  maps\mp\_utility::func_47A2("specialty_sprintfastrecovery");
  maps\mp\_utility::func_47A2("specialty_fastclimb");
  maps\mp\_utility::func_47A2("specialty_fastmantle");
  maps\mp\_utility::func_47A2("specialty_sprintreload");
  maps\mp\_utility::func_47A2("specialty_fastreload");
  maps\mp\_utility::func_47A2("specialty_increasedmeleedamage");
  self takeallweapons();
  self.lethalweapon = "throwingknife_mp";
  self method_8349(self.lethalweapon);
  self giveweapon(self.lethalweapon);
  self method_82FA(self.lethalweapon, 1);
  var_00 = "alt+m30_blades_mp+m30_rifle_blades";
  maps\mp\_utility::func_0642(var_00);
  self givestartammo(var_00);
  var_01 = maps\mp\_utility::func_4431(var_00);
  self.var_012C["secondaryWeapon"] = var_01;
  self.var_835A = var_00;
  var_02 = "alt+m1garand_blades_mp+grenade_launcher_blades";
  maps\mp\_utility::func_0642(var_02);
  self givestartammo(var_02);
  self switchtoweapon(var_02);
  self setspawnweapon(var_02);
  var_01 = maps\mp\_utility::func_4431(var_02);
  self.var_012C["primaryWeapon"] = var_01;
  self.var_7704 = var_02;
}