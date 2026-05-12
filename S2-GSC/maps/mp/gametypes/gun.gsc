/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\gun.gsc
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
    maps\mp\_utility::func_7BFA(level.var_3FDC, 10);
    maps\mp\_utility::func_7BF7(level.var_3FDC, 1);
    maps\mp\_utility::func_7C04(level.var_3FDC, 0);
    maps\mp\_utility::func_7BF1(level.var_3FDC, 0);
    maps\mp\_utility::func_7BE5(level.var_3FDC, 0);
    level.var_6031 = 0;
    level.var_6035 = 0;
    setdynamicdvar("scr_game_radarMode", 1);
  }

  level.gun_cyclecount = maps\mp\_utility::func_4529("scr_gun_cycleCount", 1);
  level.gun_weaponlist = maps\mp\_utility::func_4529("scr_gun_weaponList", 0);
  level.gun_weaponorder = maps\mp\_utility::func_4529("scr_gun_weaponOrder", 0);
  level.gun_weaponattachments = maps\mp\_utility::func_4529("scr_gun_weaponAttachments", 1);
  level.gun_weaponlistend = maps\mp\_utility::func_4529("scr_gun_weaponListEnd", 0);
  level.gun_usevariants = maps\mp\_utility::func_4529("scr_gun_useVariants", 0);
  func_869C();
  func_871C();
  func_872D(level.var_48D2[0]);
  maps\mp\_utility::func_873B(0);
  level.var_329D = 1;
  level.var_6BAF = ::func_6BAF;
  level.var_6BA7 = ::func_6BA7;
  level.var_6B7B = ::func_6B7B;
  level.var_6BB6 = ::func_6BB6;
  level.var_6B7F = ::func_6B7F;
  level.var_1DEA = ::func_48E5;
  level.var_80A8 = 1;
  level.var_2FAB = 1;
  level.disabledivisionstats = 1;
  level.var_2F8B = 1;
  level.disableallplayerstats = 1;
  level.disableweaponchallenges = 1;
  level.disabledivisionchallenges = 1;
  level.disablewinlossstats = 1;
  level.var_8637 = maps\mp\_utility::func_4529("scr_setback_levels", 1);
  level.var_5BA6 = 0;
  level.mgnestsdisabled = 1;
  level.disabledivisionpassives = 1;
  maps\mp\_utility::func_2F6D();
  if(level.var_6031) {
    level.var_62AD = ::maps\mp\gametypes\_damage::func_3FC8;
  }

  setteammode("ffa");
  setDvar("2693", 1);
  setdynamicdvar("scr_game_compassRadarUpdateTime", 9);
  game["dialog"]["gametype"] = "gg_intro";
  game["dialog"]["defense_obj"] = "gbl_start";
  game["dialog"]["offense_obj"] = "gbl_start";
  game["dialog"]["humiliation"] = "gg_humiliation";
  game["dialog"]["lastgun"] = "gg_lastgun";
  thread ongameexit();
}

ongameexit() {
  level waittill("exitLevel_called");
  setDvar("2693", 0);
}

func_5300() {
  maps\mp\_utility::func_8653(1);
  setdynamicdvar("scr_gun_winlimit", 1);
  maps\mp\_utility::func_7C04("gun", 1);
  setdynamicdvar("scr_gun_roundlimit", 1);
  maps\mp\_utility::func_7BF7("gun", 1);
  setdynamicdvar("scr_gun_halftime", 0);
  maps\mp\_utility::func_7BE5("gun", 0);
  setdynamicdvar("scr_gun_playerrespawndelay", 0);
  setdynamicdvar("scr_gun_waverespawndelay", 0);
  setdynamicdvar("scr_player_forcerespawn", 1);
  setdynamicdvar("scr_setback_levels", getmatchrulesdata("gunData", "setbackLevels"));
  setdynamicdvar("scr_gun_cycleCount", getmatchrulesdata("gunData", "cycleCount"));
  setdynamicdvar("scr_gun_weaponList", getmatchrulesdata("gunData", "weaponList"));
  setdynamicdvar("scr_gun_weaponOrder", getmatchrulesdata("gunData", "weaponOrder"));
  setdynamicdvar("scr_gun_weaponAttachments", getmatchrulesdata("gunData", "weaponAttachments"));
  setdynamicdvar("scr_gun_weaponListEnd", getmatchrulesdata("gunData", "weaponListEnd"));
  setdynamicdvar("scr_gun_useVariants", getmatchrulesdata("gunData", "useVariants"));
}

func_871C() {
  setdynamicdvar("scr_gun_scorelimit", level.gun_guns_raw.size * level.gun_cyclecount);
  maps\mp\_utility::func_7BF9(level.var_3FDC, level.gun_guns_raw.size * level.gun_cyclecount);
}

func_6BAF() {
  setclientnamemode("auto_change");
  maps\mp\_utility::func_86DC("allies", &"OBJECTIVES_DM");
  maps\mp\_utility::func_86DC("axis", &"OBJECTIVES_DM");
  if(level.var_910F) {
    maps\mp\_utility::func_86DB("allies", &"OBJECTIVES_DM");
    maps\mp\_utility::func_86DB("axis", &"OBJECTIVES_DM");
  } else {
    maps\mp\_utility::func_86DB("allies", &"OBJECTIVES_DM_SCORE");
    maps\mp\_utility::func_86DB("axis", &"OBJECTIVES_DM_SCORE");
  }

  maps\mp\_utility::func_86D8("allies", &"OBJECTIVES_DM_HINT");
  maps\mp\_utility::func_86D8("axis", &"OBJECTIVES_DM_HINT");
  lib_050D::func_10E4();
  var_00 = [];
  maps\mp\gametypes\_gameobjects::func_00F9(var_00);
  level.var_7895 = 1;
  level.var_17EF = 1;
  level thread func_6B6C();
}

func_6B6C() {
  for(;;) {
    level waittill("connected", var_00);
    var_00.var_48E6 = 0;
    var_00.var_48E7 = 0;
    var_00.var_9149 = 0;
    var_00.var_65ED = 0;
    var_00.var_5BB8 = 0;
    var_00.var_8C15 = 0;
    var_00 thread func_7B82();
    var_00 thread func_7B85();
  }
}

func_48E5(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 1;
  }

  self.var_012C["class"] = "gamemode";
  self.var_012C["lastClass"] = "";
  self.var_012C["gamemodeLoadout"] = level.var_48D4;
  self.var_2319 = self.var_012C["class"];
  self.var_5B84 = self.var_012C["lastClass"];
  maps\mp\gametypes\_class::func_4790(self.var_01A7, self.var_2319);
  if(param_00) {
    self method_8512(level.var_48D2[0]["builtWeaponName"]);
  }
}

func_6BA7() {
  maps\mp\_utility::func_47A2("specialty_longersprint");
  maps\mp\_utility::func_47A2("specialty_sprintfastrecovery");
  maps\mp\_utility::func_47A2("specialty_fastclimb");
  maps\mp\_utility::func_47A2("specialty_fastmantle");
  maps\mp\_utility::func_47A2("specialty_fastoffhand");
  maps\mp\_utility::func_47A2("specialty_sprintequipment");
  maps\mp\_utility::func_47A2("specialty_throwequipmentfarther");
  maps\mp\_utility::func_47A2("specialty_increasedmeleedamage");
  self method_8326();
  self method_8328();
  func_48E5(0);
  thread func_A6F3();
}

func_A6F3() {
  level endon("game_ended");
  self endon("disconnect");
  level waittill("player_spawned");
  func_479C(1);
  if(self.var_8C15) {
    self.var_8C15 = 0;
    self.var_5BB5 = undefined;
    thread maps\mp\_events::func_2B72();
  }
}

func_6B7F(param_00, param_01, param_02, param_03, param_04) {
  var_05 = maps\mp\gametypes\_rank::func_4671(param_00);
  param_01 maps\mp\_utility::func_867B(param_01.var_008F + var_05);
  param_01 maps\mp\gametypes\_gamescore::func_A161(param_01, var_05);
  if(param_00 == "gained_gun_score") {
    return 1;
  } else if(param_00 == "dropped_gun_score") {
    return level.var_8637 * -1;
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
    if(param_03 == "MOD_FALLING" || param_01 == self || (maps\mp\_utility::func_5755(param_03) && param_04 != "riotshield_mp") || param_04 == "boost_slam_mp") {
      self method_8615("mp_war_objective_lost");
      self.var_48E7 = self.var_48E6;
      self.var_48E6 = int(max(0, self.var_48E6 - level.var_8637));
      if(self.var_48E7 > self.var_48E6) {
        self.var_65ED++;
        maps\mp\_utility::func_867C(self.var_65ED);
        self.var_8C15 = 1;
        if(maps\mp\_utility::func_5755(param_03) || param_04 == "boost_slam_mp") {
          param_01.var_9149++;
          param_01.var_0021 = param_01.var_9149;
          param_01 thread maps\mp\_events::func_8634();
          if(self.var_48E7 == level.var_48D2.size * level.gun_cyclecount - 1) {
            param_01 thread maps\mp\_events::func_8635();
            maps\mp\_utility::func_5C43("humiliation", "status");
            return;
          }

          return;
        }

        return;
      }

      return;
    }

    if((param_03 == "MOD_PISTOL_BULLET" || param_03 == "MOD_RIFLE_BULLET" || param_03 == "MOD_HEAD_SHOT" || param_03 == "MOD_PROJECTILE" || param_03 == "MOD_PROJECTILE_SPLASH" || param_03 == "MOD_EXPLOSIVE" || param_03 == "MOD_IMPACT" || param_03 == "MOD_GRENADE" || param_03 == "MOD_GRENADE_SPLASH" || maps\mp\_utility::func_5697(param_03, param_04) || maps\mp\_utility::func_5755(param_03) && param_04 == "riotshield_mp") && param_04 != "v2_rocket_mp") {
      if(isDefined(param_01.var_5BB5) && param_01.var_5BB5 == param_04) {
        if((isDefined(param_01.lastkilllifeid) && param_01.lastkilllifeid == param_01.var_5CC6) || isDefined(param_01.var_5BB8) && param_01.var_5BB8 + 1000 > gettime()) {
          return;
        }
      }

      if(param_01.var_48CF != param_04 && (!maps\mp\_utility::func_5670(param_01.var_48CF) || param_01.var_48CF != "alt+" + param_04) && (!isDefined(param_01.lethalweapon) || param_01.lethalweapon != param_04) && !issubstr(param_04, "bipod")) {
        return;
      }

      param_01.var_5BB5 = param_04;
      param_01.lastkilllifeid = param_01.var_5CC6;
      if(param_01.var_5BB8 + 5000 > gettime()) {
        param_01 thread maps\mp\_events::func_7893();
      }

      param_01.var_5BB8 = gettime();
      param_01.var_48E7 = param_01.var_48E6;
      param_01.var_48E6++;
      param_01 thread maps\mp\_events::func_50ED();
      if(param_01.var_48E6 == level.var_48D2.size * level.gun_cyclecount - 1) {
        maps\mp\_utility::func_74D9("mp_enemy_obj_captured");
        level thread maps\mp\_utility::func_9863("callout_top_gun_rank", param_01);
        var_0A = gettime();
        if(level.var_5BA6 + 4500 < var_0A) {
          level thread maps\mp\_utility::func_5C46("lastgun", [param_01], "status");
          level.var_5BA6 = var_0A;
        }
      }

      if(param_01.var_48E6 < level.var_48D2.size * level.gun_cyclecount) {
        param_01 func_479C(0, param_04);
        return;
      }

      return;
    }
  }
}

func_479C(param_00, param_01) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self notify("giveNextGun");
  self endon("giveNextGun");
  waittillframeend;
  if(!isDefined(param_00)) {
    param_00 = 0;
  }

  var_02 = func_45A4();
  var_03 = var_02["builtWeaponName"];
  func_872D(var_02);
  self.var_48CF = var_03;
  while(!self method_8512(var_03)) {
    wait 0.05;
  }

  if(self playerisweaponplantenabled()) {
    common_scripts\_plant_weapon::forcedismountweapon();
  }

  self takeallweapons();
  maps\mp\_utility::func_0642(var_03);
  self givestartammo(var_03);
  if(param_00) {
    self switchtoweaponimmediate(var_03);
  } else {
    self switchtoweapon(var_03);
  }

  if(isDefined(param_00) && param_00 == 1) {
    self setspawnweapon(var_03);
  }

  var_04 = maps\mp\_utility::func_4431(var_03);
  self.var_012C["primaryWeapon"] = var_04;
  self.var_7704 = var_03;
  self.lethalweapon = undefined;
  if(var_02["forcedLethal"] != "") {
    self.lethalweapon = var_02["forcedLethal"];
    self method_8349(self.lethalweapon);
    self giveweapon(self.lethalweapon);
    self method_82FA(self.lethalweapon, 1);
  }

  var_05 = self.var_0079;
  maps\mp\_utility::func_06D4(var_05, var_02["division"]);
  self setclientomnvar("ui_show_division_sniper_ability_prompt", 0);
  if(maps\mp\_utility::isdivisionsglobaloverhaulenabled()) {
    maps\mp\gametypes\_division_change::func_8725(2, var_03);
    maps\mp\gametypes\_division_change::func_8725(3, var_03);
    maps\mp\gametypes\_division_change::func_8725(0, var_03);
  }

  if(maps\mp\_utility::func_4571() != "mp_sandbox_01") {
    var_06 = maps\mp\gametypes\_class::func_1F93(self.var_0079, "allies");
    self setrankedplayerdata(common_scripts\utility::func_46A9(), "activeCostume", var_06);
    self.var_267E = maps\mp\gametypes\_class::func_1F97(var_06);
    var_07 = maps\mp\gametypes\_class::func_1F95();
    self.var_267E[1] = var_07[1];
    maps\mp\gametypes\_class::func_21B9();
    maps\mp\gametypes\_teams::func_73CA();
  }

  self notify("applyLoadout");
  self.var_48E7 = self.var_48E6;
}

func_45A4() {
  var_00 = level.var_48D2;
  var_01 = [];
  var_02 = undefined;
  var_03 = var_00[self.var_48E6 % var_00.size];
  var_04 = var_03["builtWeaponName"];
  var_01[var_01.size] = var_04;
  if(self.var_48E6 + 1 < var_00.size * level.gun_cyclecount) {
    var_01[var_01.size] = var_00[self.var_48E6 + 1 % var_00.size]["builtWeaponName"];
  }

  if(self.var_48E6 > 0) {
    var_01[var_01.size] = var_00[self.var_48E6 - 1 % var_00.size]["builtWeaponName"];
  }

  self method_8512(var_01);
  return var_03;
}

func_6BB6() {
  level.var_3B5C = "none";
  var_00 = func_4509();
  if(!isDefined(var_00) || !var_00.size) {
    thread maps\mp\gametypes\_gamelogic::func_36B9("tie", game["end_reason"]["time_limit_reached"]);
    return;
  }

  if(var_00.size == 1) {
    thread maps\mp\gametypes\_gamelogic::func_36B9(var_00[0], game["end_reason"]["time_limit_reached"]);
    return;
  }

  if(var_00[var_00.size - 1].var_48E6 > var_00[var_00.size - 2].var_48E6) {
    thread maps\mp\gametypes\_gamelogic::func_36B9(var_00[var_00.size - 1], game["end_reason"]["time_limit_reached"]);
    return;
  }

  thread maps\mp\gametypes\_gamelogic::func_36B9("tie", game["end_reason"]["time_limit_reached"]);
}

func_4509() {
  var_00 = -1;
  var_01 = [];
  foreach(var_03 in level.var_744A) {
    if(isDefined(var_03.var_48E6) && var_03.var_48E6 >= var_00) {
      var_00 = var_03.var_48E6;
      var_01[var_01.size] = var_03;
    }
  }

  return var_01;
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
      } else {
        maps\mp\gametypes\_damagefeedback::func_A102("resupply_equipment");
      }
    }

    if(self.var_7704 == "killstreak_molotov_cocktail_mp") {
      self switchtoweaponimmediate(self.var_7704);
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

func_872D(param_00) {
  level.var_48D4 = maps\mp\gametypes\_class::func_44B4();
  level.var_48D4["loadoutDivision"] = param_00["division"];
  if(maps\mp\gametypes\_class::func_5835(param_00["builtWeaponName"])) {
    level.var_48D4["loadoutPrimaryWeaponStruct"] = maps\mp\_utility::func_473C(maps\mp\_utility::func_452A(param_00["builtWeaponName"]), 0);
  } else if(maps\mp\gametypes\_class::func_5839(param_00["builtWeaponName"], 0)) {
    level.var_48D4["loadoutSecondaryWeaponStruct"] = maps\mp\_utility::func_473C(maps\mp\_utility::func_452A(param_00["builtWeaponName"]), 0);
  }

  for(var_01 = 0; var_01 < 9; var_01++) {
    level.var_48D4["loadoutPerksGUID"][var_01] = 0;
  }

  if(param_00["forcedLethal"] != "") {
    level.var_48D4["loadoutEquipmentStruct"] = maps\mp\_utility::func_44CE(maps\mp\_utility::func_452A(param_00["forcedLethal"]), 0);
  }
}

addgun(param_00) {
  level.gun_guns_raw[level.gun_guns_raw.size] = param_00;
}

func_869C() {
  level.gun_guns_raw = [];
  switch (level.gun_weaponlist) {
    case 0:
    default:
      addgun("rand_smg");
      addgun("rand_rifle_auto");
      addgun("rand_smg");
      addgun("rand_shotgun");
      addgun("rand_rifle_auto");
      addgun("rand_smg_division");
      addgun("rand_rifle_single");
      addgun("rand_shotgun_division");
      addgun("rand_lmg");
      addgun("rand_sniper_4x");
      addgun("rand_rifle_division");
      addgun("rand_lmg_division");
      addgun("rand_sniper");
      addgun("rand_pistol");
      addgun("rand_launcher");
      addgun("rand_pistol_akimbo");
      addgun("rand_difficult_sniper");
      break;

    case 1:
      addgun("rand_shotgun_division");
      addgun("rand_smg_division");
      addgun("rand_rifle_division");
      addgun("rand_lmg_division");
      addgun("rand_sniper_division");
      break;

    case 2:
      addgun("rand_fire_shotgun");
      addgun("rand_launcher");
      addgun("rand_shotgun_division");
      addgun("rand_fire_molotov");
      addgun("rand_fire_flamethrower");
      addgun("rand_fire_shotgun");
      addgun("rand_launcher");
      addgun("rand_fire_shotgun");
      addgun("rand_fire_flamethrower");
      break;

    case 3:
      addgun("rand_pistol_akimbo");
      addgun("rand_shotgun");
      addgun("rand_smg");
      addgun("rand_shotgun");
      addgun("rand_smg");
      addgun("rand_shotgun_division");
      addgun("rand_smg");
      addgun("rand_smg");
      addgun("rand_rifle_auto");
      addgun("rand_smg");
      addgun("rand_rifle_auto");
      addgun("rand_smg");
      addgun("rand_smg_division");
      addgun("rand_rifle_auto");
      addgun("rand_pistol_akimbo");
      addgun("rand_launcher");
      break;

    case 4:
      addgun("rand_pistol");
      addgun("rand_rifle_auto");
      addgun("rand_rifle_single");
      addgun("rand_rifle_auto");
      addgun("rand_rifle_single");
      addgun("rand_lmg");
      addgun("rand_sniper_4x");
      addgun("rand_rifle_auto");
      addgun("rand_rifle_division");
      addgun("rand_lmg");
      addgun("rand_sniper");
      addgun("rand_lmg");
      addgun("rand_sniper");
      addgun("rand_pistol");
      addgun("rand_shotgun_sniper");
      break;

    case 5:
      addgun("rand_rifle_auto");
      addgun("rand_rifle_auto");
      addgun("rand_rifle_auto");
      addgun("rand_rifle_auto");
      addgun("rand_rifle_single");
      addgun("rand_rifle_single");
      addgun("rand_rifle_single");
      addgun("rand_rifle_division");
      break;

    case 6:
      addgun("rand_smg");
      addgun("rand_smg");
      addgun("rand_smg");
      addgun("rand_smg");
      addgun("rand_smg");
      addgun("rand_smg");
      addgun("rand_smg_division");
      break;

    case 7:
      addgun("rand_sniper");
      addgun("rand_sniper");
      addgun("rand_sniper");
      addgun("rand_sniper_division");
      break;

    case 8:
      addgun("rand_lmg");
      addgun("rand_lmg");
      addgun("rand_lmg");
      addgun("rand_lmg");
      addgun("rand_lmg_division");
      break;

    case 9:
      addgun("rand_shotgun");
      addgun("rand_shotgun");
      addgun("rand_shotgun");
      addgun("rand_shotgun_division");
      break;

    case 10:
      addgun("rand_pistol");
      addgun("rand_pistol");
      addgun("rand_pistol");
      break;

    case 11:
      addgun("rand_pistol_akimbo");
      addgun("rand_pistol_akimbo");
      addgun("rand_pistol_akimbo");
      break;

    case 12:
      addgun("rand_launcher");
      addgun("rand_launcher");
      break;
  }

  switch (level.gun_weaponorder) {
    case 0:
    default:
      break;

    case 1:
      level.gun_guns_raw = common_scripts\utility::func_0F92(level.gun_guns_raw);
      break;

    case 2:
      level.gun_guns_raw = common_scripts\utility::func_0FA2(level.gun_guns_raw);
      break;
  }

  switch (level.gun_weaponlistend) {
    case 0:
    default:
      addgun("rand_melee_end");
      break;

    case 1:
      addgun("rand_launcher");
      break;

    case 2:
      addgun("rand_pistol_akimbo");
      break;

    case 3:
      addgun("rand_shotgun_sniper");
      break;

    case 4:
      addgun("rand_sniper_iron");
      break;

    case 5:
      addgun("rand_fire_molotov");
      break;

    case 6:
      addgun("rand_fire_flamethrower");
      break;

    case 7:
      addgun("rand_satchel_end");
      break;

    case 8:
      break;
  }

  thread setgunsfinal();
}

setgunsfinal() {
  level.gungameweaponnamelist = [];
  buildrandomweapontable();
  var_00 = [];
  var_01 = function_027B("mp/attachmentcombos_mtx12.csv");
  for(var_02 = 0; var_02 < var_01; var_02++) {
    var_03 = tablelookupbyrow("mp/attachmentcombos_mtx12.csv", 0, var_02);
    var_00[var_03] = var_02;
  }

  if(!isDefined(level.var_1152)) {
    maps\mp\_utility::func_1D3E();
  }

  level.var_48D2 = [];
  for(var_04 = 0; var_04 < level.gun_guns_raw.size; var_04++) {
    var_05 = level.gun_guns_raw[var_04];
    if(maps\mp\_utility::func_57E5(var_05, "rand_")) {
      level.var_48D2[level.var_48D2.size] = getrandomweaponfromcategory(var_05, var_00);
      continue;
    }

    level.var_48D2[level.var_48D2.size]["builtWeaponName"] = var_05;
  }

  level.gungameweaponnamelist = undefined;
}

buildrandomweapontable() {
  level.gungameoptionstable = [];
  var_00 = function_027A("mp/gunGameTable.csv");
  for(var_01 = 1; var_01 < var_00; var_01++) {
    var_02 = tablelookupbyrow("mp/gunGameTable.csv", var_01, 0);
    if(var_02 == "") {
      break;
    }

    if(!isDefined(level.gungameoptionstable[var_02])) {
      level.gungameoptionstable[var_02] = [];
    }

    var_03 = [];
    var_03["categoryName"] = var_02;
    var_03["weaponName"] = tablelookupbyrow("mp/gunGameTable.csv", var_01, 1);
    var_03["minAttachments"] = int(tablelookupbyrow("mp/gunGameTable.csv", var_01, 5));
    var_03["maxAttachments"] = int(tablelookupbyrow("mp/gunGameTable.csv", var_01, 6));
    var_03["forcedAttachments"] = tablelookupbyrow("mp/gunGameTable.csv", var_01, 2);
    var_03["forcedAttachments"] = strtok(var_03["forcedAttachments"], "+");
    var_03["banOptic"] = 1 == int(tablelookupbyrow("mp/gunGameTable.csv", var_01, 4));
    var_03["forceAltMode"] = 1 == int(tablelookupbyrow("mp/gunGameTable.csv", var_01, 3));
    var_03["division"] = int(tablelookupbyrow("mp/gunGameTable.csv", var_01, 7));
    var_03["allowedVariants"] = tablelookupbyrow("mp/gunGameTable.csv", var_01, 8);
    var_03["allowedVariants"] = strtok(var_03["allowedVariants"], "+");
    var_03["forcedLethal"] = tablelookupbyrow("mp/gunGameTable.csv", var_01, 9);
    level.gungameoptionstable[var_02][level.gungameoptionstable[var_02].size] = var_03;
  }
}

getrandomweaponfromcategory(param_00, param_01) {
  var_02 = level.gungameoptionstable[param_00];
  if(isDefined(var_02) && var_02.size > 0) {
    var_02 = common_scripts\utility::func_0F92(var_02);
    var_03 = undefined;
    for(var_04 = 0; var_04 < var_02.size; var_04++) {
      var_03 = var_02[var_04];
      if(isDefined(level.gungameweaponnamelist[var_03["weaponName"]]) && level.gungameweaponnamelist[var_03["weaponName"]]) {
        continue;
      }

      if(!level.gun_usevariants || var_03["allowedVariants"].size > 0) {
        break;
      }
    }

    if(!isDefined(var_03)) {
      return undefined;
    }

    var_05 = var_03["weaponName"];
    level.gungameweaponnamelist[var_05] = 1;
    var_06 = 0;
    if(level.gun_usevariants) {
      if(var_03["allowedVariants"].size > 0) {
        var_07 = common_scripts\utility::func_7A33(var_03["allowedVariants"]);
        var_07 = strtok(var_07, ":");
        var_08 = int(var_07[0]) - 1;
        var_06 = int(var_07[1]);
        var_05 = function_0337(var_05, "_mp");
        var_05 = var_05 + "_loot" + var_08 + "_mp";
      } else if(var_05 != "killstreak_molotov_cocktail_mp" && var_05 != "flamethrower_mp" && var_05 != "flamethrower_german_mp" && param_00 != "rand_equipment") {
        return undefined;
      }
    }

    var_09 = [];
    if(level.gun_weaponattachments) {
      var_09 = var_03["forcedAttachments"];
      var_0A = randomintrange(var_03["minAttachments"], var_03["maxAttachments"] + 1);
      var_09 = common_scripts\utility::func_0F8C(var_09, getattachmentsforweapon(var_03, var_0A, param_01, var_09));
    }

    var_0B = [];
    for(var_04 = 0; var_04 < var_09.size; var_04++) {
      var_0B[var_04] = maps\mp\_utility::func_452A(var_09[var_04]);
    }

    for(var_04 = var_09.size; var_04 < 6; var_04++) {
      var_0B[var_04] = 0;
    }

    var_0C = maps\mp\gametypes\_class::func_1D66(var_05, var_0B[0], var_0B[1], var_0B[2], var_0B[3], var_0B[4], var_0B[5], var_06, 0, 0, 0, 0, undefined, 5);
    if(level.gun_weaponattachments && var_03["forceAltMode"]) {
      var_0C = "alt+" + var_0C;
    }

    var_03["builtWeaponName"] = var_0C;
    return var_03;
  }

  return undefined;
}

getattachmentsforweapon(param_00, param_01, param_02, param_03) {
  if(param_01 <= 0) {
    return [];
  }

  var_04 = param_00["weaponName"];
  var_05 = function_0060(var_04);
  var_05 = common_scripts\utility::func_0F92(var_05);
  var_06 = param_03;
  var_07 = [];
  for(var_08 = 0; var_08 < var_05.size; var_08++) {
    var_09 = 0;
    var_0A = var_05[var_08];
    if(maps\mp\gametypes\_division_change::func_56CA(var_04, var_0A)) {
      var_09 = 1;
    }

    if(!var_09 && param_00["banOptic"] && issubstr(var_0A, "iron_sight") || issubstr(var_0A, "telescopic_sight") || issubstr(var_0A, "lens_sight") || issubstr(var_0A, "aperture_sight")) {
      var_09 = 1;
    }

    if((!var_09 && issubstr(var_0A, "special_grip") || issubstr(var_0A, "akimbo") || issubstr(var_0A, "m30_rifle") || issubstr(var_0A, "tactical_knife") || issubstr(var_0A, "suppressor")) || issubstr(var_0A, "bipod") || issubstr(var_0A, "hold_breath") || issubstr(var_0A, "extended_mag") || issubstr(var_0A, "bayonet") || issubstr(var_0A, "grenade_launcher")) {
      var_09 = 1;
    }

    if(!var_09 && isDefined(var_06) && var_06.size > 0) {
      foreach(var_0C in var_06) {
        if(isDefined(param_02[var_0C])) {
          var_0D = tablelookup("mp/attachmentcombos_mtx12.csv", 0, var_0A, param_02[var_0C]);
          if(isDefined(var_0D) && var_0D != "") {
            var_09 = 1;
            break;
          }
        }
      }
    }

    if(!var_09) {
      var_06[var_06.size] = var_0A;
      var_07[var_07.size] = var_0A;
      if(var_07.size >= param_01) {
        break;
      }
    }
  }

  return var_07;
}