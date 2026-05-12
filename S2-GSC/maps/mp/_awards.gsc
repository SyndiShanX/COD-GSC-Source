/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\_awards.gsc
*********************************************/

func_00D5() {
  func_5296();
  level thread func_6B6C();
}

func_6B6C() {
  for(;;) {
    level waittill("connected", var_00);
    if(!isDefined(var_00.var_012C["stats"])) {
      var_00.var_012C["stats"] = [];
    }

    var_00.var_9337 = var_00.var_012C["stats"];
    if(!var_00.var_9337.size) {
      foreach(var_03, var_02 in level.var_145B) {
        var_00 maps\mp\_utility::func_5335(var_03, level.var_145B[var_03].var_2BD8);
      }
    }
  }
}

func_5296() {
  func_535A("headshots", 0, ::func_4D40);
  func_535A("multikill", 0, ::func_4D40);
  func_535A("avengekills", 0, ::func_4D40);
  func_535A("comebacks", 0, ::func_4D40);
  func_535A("rescues", 0, ::func_4D40);
  func_535A("longshots", 0, ::func_4D40);
  func_535A("revengekills", 0, ::func_4D40);
  func_535A("bulletpenkills", 0, ::func_4D40);
  func_535A("throwback_kill", 0, ::func_4D40);
  func_535A("firstblood", 0, ::func_4D40);
  func_535A("posthumous", 0, ::func_4D40);
  func_535A("assistedsuicide", 0, ::func_4D40);
  func_535A("buzzkill", 0, ::func_4D40);
  func_535A("oneshotkill", 0, ::func_4D40);
  func_535A("air_to_air_kill", 0, ::func_4D40);
  func_535A("air_to_ground_kill", 0, ::func_4D40);
  func_535A("ground_to_air_kill", 0, ::func_4D40);
  func_535A("doublekill", 0, ::func_4D40);
  func_535A("triplekill", 0, ::func_4D40);
  func_535A("fourkill", 0, ::func_4D40);
  func_535A("fivekill", 0, ::func_4D40);
  func_535A("sixkill", 0, ::func_4D40);
  func_535A("sevenkill", 0, ::func_4D40);
  func_535A("eightkill", 0, ::func_4D40);
  func_535A("hijacker", 0, ::func_4D40);
  func_535A("backstab", 0, ::func_4D40);
  func_535A("silentkill", 0, ::func_4D40);
  func_535A("killstreak5", 0, ::func_4D40);
  func_535A("killstreak10", 0, ::func_4D40);
  func_535A("killstreak15", 0, ::func_4D40);
  func_535A("killstreak20", 0, ::func_4D40);
  func_535A("killstreak25", 0, ::func_4D40);
  func_535A("killstreak30", 0, ::func_4D40);
  func_535A("killstreak30plus", 0, ::func_4D40);
  func_535A("pointblank", 0, ::func_4D40);
  func_535A("firstplacekill", 0, ::func_4D40);
  func_535A("boostslamkill", 0, ::func_4D40);
  func_535A("assault", 0, ::func_4D40);
  func_535A("defends", 0, ::func_4D40);
  func_535A("exo_knife_kill", 0, ::func_4D40);
  func_535A("exo_knife_recall_kill", 0, ::func_4D40);
  func_535A("near_death_kill", 0, ::func_4D40);
  func_535A("slide_kill", 0, ::func_4D40);
  func_535A("flash_kill", 0, ::func_4D40);
  func_535A("riot_kill", 0, ::func_4D40);
  func_535A("mg_nest_kill", 0, ::func_4D40);
  func_535A("divisions_infantry_kill", 0, ::func_4D40);
  func_535A("divisions_airborne_kill", 0, ::func_4D40);
  func_535A("divisions_armored_kill", 0, ::func_4D40);
  func_535A("divisions_cavalry_kill", 0, ::func_4D40);
  func_535A("divisions_mountain_kill", 0, ::func_4D40);
  func_535A("division_resistance_kill", 0, ::func_4D40);
  func_535A("division_grenadier_kill", 0, ::func_4D40);
  func_535A("division_commando_kill", 0, ::func_4D40);
  func_535A("division_scout_kill", 0, ::func_4D40);
  func_535A("division_artillery_kill", 0, ::func_4D40);
  func_535A("melee_air_to_air", 0, ::func_4D40);
  func_535A("assist_riot_shield", 0, ::func_4D40);
  func_535A("semtex_stick", 0, ::func_4D40);
  func_535A("stuck_with_explosive", 0, ::func_4D40);
  func_535A("crossbow_stick", 0, ::func_4D40);
  func_535A("multiKillOneBullet", 0, ::func_4D40);
  func_535A("think_fast", 0, ::func_4D40);
  func_535A("take_and_kill", 0, ::func_4D40);
  func_535A("four_play", 0, ::func_4D40);
  func_535A("sharepackage", 0, ::func_4D40);
  func_535A("kills", 0, ::func_4D40);
  func_535A("longestkillstreak", 0, ::func_4D40);
  func_535A("knifekills", 0, ::func_4D40);
  func_535A("kdratio", 0, ::func_4D40);
  func_535A("deaths", 0, ::func_5F33);
  func_535A("assists", 0, ::func_4D40);
  func_535A("totalGameScore", 0, ::func_4D40);
  func_535A("scorePerMinute", 0, ::func_4D40);
  func_535A("mostScorePerLife", 0, ::func_4D40);
  func_535A("killStreaksUsed", 0, ::func_4D40);
  func_535A("humiliation", 0, ::highestwinsalwaysset);
  func_535A("regicide", 0, ::highestwinsalwaysset);
  func_535A("gunslinger", 0, ::highestwinsalwaysset);
  func_535A("dejavu", 0, ::highestwinsalwaysset);
  func_535A("levelup", 0, ::highestwinsalwaysset);
  func_535A("omegaman", 0, ::highestwinsalwaysset);
  func_535A("plague", 0, ::highestwinsalwaysset);
  func_535A("patientzero", 0, ::highestwinsalwaysset);
  func_535A("careless", 0, ::highestwinsalwaysset);
  func_535A("survivor", 0, ::highestwinsalwaysset);
  func_535A("contagious", 0, ::highestwinsalwaysset);
  func_535A("flagscaptured", 0, ::func_4D40);
  func_535A("flagsreturned", 0, ::func_4D40);
  func_535A("flagcarrierkills", 0, ::func_4D40);
  func_535A("flagscarried", 0, ::func_4D40);
  func_535A("killsasflagcarrier", 0, ::func_4D40);
  func_535A("pointscaptured", 0, ::func_4D40);
  func_535A("kill_while_capture", 0, ::func_4D40);
  func_535A("opening_move", 0, ::func_4D40);
  func_535A("hp_secure", 0, ::func_4D40);
  func_535A("targetsdestroyed", 0, ::func_4D40);
  func_535A("bombsplanted", 0, ::func_4D40);
  func_535A("bombsdefused", 0, ::func_4D40);
  func_535A("ninja_defuse", 0, ::func_4D40);
  func_535A("last_man_defuse", 0, ::func_4D40);
  func_535A("elimination", 0, ::func_4D40);
  func_535A("last_man_standing", 0, ::func_4D40);
  func_535A("sr_tag_elimination", 0, ::func_4D40);
  func_535A("sr_tag_revive", 0, ::func_4D40);
  func_535A("killsconfirmed", 0, ::func_4D40);
  func_535A("killsdenied", 0, ::func_4D40);
  func_535A("kill_denied_retrieved", 0, ::func_4D40);
  func_535A("tag_collector", 0, ::func_4D40);
  func_535A("touchdown", 0, ::func_4D40);
  func_535A("fieldgoal", 0, ::func_4D40);
  func_535A("interception", 0, ::func_4D40);
  func_535A("kill_with_ball", 0, ::func_4D40);
  func_535A("ball_score_assist", 0, ::func_4D40);
  func_535A("pass_kill_pickup", 0, ::func_4D40);
  func_535A("killedBallCarrier", 0, ::func_4D40);
  func_535A("uav_destroyed", 0, ::func_4D40);
  func_535A("counter_uav_destroyed", 0, ::func_4D40);
  func_535A("airstrike_destroyed", 0, ::func_4D40);
  func_535A("fire_bombing_run_destroyed", 0, ::func_4D40);
  func_535A("fighter_strike_destroyed", 0, ::func_4D40);
  func_535A("carepackage_plane_destroyed", 0, ::func_4D40);
  func_535A("emergency_carepackage_plane_destroyed", 0, ::func_4D40);
  func_535A("attack_dogs_destroyed", 0, ::func_4D40);
  func_535A("paratroopers_plane_destroyed", 0, ::func_4D40);
  func_535A("paratroopers_destroyed", 0, ::func_4D40);
  func_535A("fritzx_destroyed", 0, ::func_4D40);
  func_535A("assist_killstreak_destroyed", 0, ::func_4D40);
  func_535A("plane_gunner_destroyed", 0, ::func_4D40);
  func_535A("airdrop_kill", 0, ::func_4D40);
  func_535A("fritzx_kill", 0, ::func_4D40);
  func_535A("mortar_strike_kill", 0, ::func_4D40);
  func_535A("missile_strike_kill", 0, ::func_4D40);
  func_535A("airstrike_kill", 0, ::func_4D40);
  func_535A("firebomb_kill", 0, ::func_4D40);
  func_535A("attack_dogs_kill", 0, ::func_4D40);
  func_535A("plane_gunner_kill", 0, ::func_4D40);
  func_535A("fighter_strike_kill", 0, ::func_4D40);
  func_535A("flamethrower_kill", 0, ::func_4D40);
  func_535A("paratroopers_kill", 0, ::func_4D40);
  func_535A("molotovs_kill", 0, ::func_4D40);
  func_535A("v2_rocket_kill", 0, ::func_4D40);
  func_535A("uav_earned", 0, ::func_4D40);
  func_535A("carepackage_earned", 0, ::func_4D40);
  func_535A("missile_strike_earned", 0, ::func_4D40);
  func_535A("airstrike_earned", 0, ::func_4D40);
  func_535A("fritzx_earned", 0, ::func_4D40);
  func_535A("firebomb_earned", 0, ::func_4D40);
  func_535A("mortar_strike_earned", 0, ::func_4D40);
  func_535A("attack_dogs_earned", 0, ::func_4D40);
  func_535A("emergency_carepackage_earned", 0, ::func_4D40);
  func_535A("counter_uav_earned", 0, ::func_4D40);
  func_535A("flak_gun_earned", 0, ::func_4D40);
  func_535A("plane_gunner_earned", 0, ::func_4D40);
  func_535A("fighter_strike_earned", 0, ::func_4D40);
  func_535A("flamethrower_earned", 0, ::func_4D40);
  func_535A("paratroopers_earned", 0, ::func_4D40);
  func_535A("molotovs_earned", 0, ::func_4D40);
  func_535A("v2_rocket_earned", 0, ::func_4D40);
  func_535A("raid_flak_earned", 0, ::func_4D40);
  func_535A("raid_fighters_earned", 0, ::func_4D40);
  func_535A("dogfight_flak_earned", 0, ::func_4D40);
  func_535A("hub_psdWatch", 0, ::func_4D40);
  func_535A("hub_legendaryReveal", 0, ::func_4D40);
  func_535A("hub_1v1Win", 0, ::func_4D40);
  func_535A("hub_duelWin", 0, ::func_4D40);
  func_535A("hub_planeDestroyed", 0, ::func_4D40);
  func_535A("hub_skeetShooting", 0, ::func_4D40);
  func_535A("raids_construct", 0, ::func_4D40);
  func_535A("raids_destruct", 0, ::func_4D40);
  func_535A("raids_progress", 0, ::func_4D40);
  func_535A("raids_escort", 0, ::func_4D40);
  func_535A("raids_build_objective", 0, ::func_4D40);
  func_535A("raids_retreat", 0, ::func_4D40);
  func_535A("raids_hostage_release", 0, ::func_4D40);
  func_535A("raids_airdrop_secure", 0, ::func_4D40);
  func_535A("raids_flag_raise", 0, ::func_4D40);
  func_535A("numMatchesRecorded", 0, ::func_4D40);
}

func_535A(param_00, param_01, param_02, param_03, param_04) {
  level.var_145B[param_00] = spawnStruct();
  level.var_145B[param_00].var_2BD8 = param_01;
  if(isDefined(param_02)) {
    level.var_145B[param_00].var_7743 = param_02;
  }

  if(isDefined(param_03)) {
    level.var_145B[param_00].var_A2A6 = param_03;
  }

  if(isDefined(param_04)) {
    level.var_145B[param_00].var_A2A7 = param_04;
  }
}

func_86F2(param_00, param_01) {
  if((!isDefined(param_01) || !param_01) && isDefined(level.disableallplayerstats) && level.disableallplayerstats) {
    return;
  }

  var_02 = self getrankedplayerdata(common_scripts\utility::func_46A7(), "bests", param_00);
  var_03 = maps\mp\_utility::func_4628(param_00);
  var_03 = func_44EC(param_00, var_03);
  if(var_02 == 0 || var_03 > var_02) {
    self setrankedplayerdata(common_scripts\utility::func_46A7(), "bests", param_00, var_03);
  }
}

func_86F3(param_00) {
  if(isDefined(level.disableallplayerstats) && level.disableallplayerstats) {
    return;
  }

  var_01 = self getrankedplayerdata(common_scripts\utility::func_46A7(), "bests", param_00);
  var_02 = maps\mp\_utility::func_4628(param_00);
  var_02 = func_44EC(param_00, var_02);
  if(var_01 == 0 || var_02 < var_01) {
    self setrankedplayerdata(common_scripts\utility::func_46A7(), "bests", param_00, var_02);
  }
}

func_1E4F(param_00) {
  var_01 = param_00 maps\mp\_utility::func_4628("kills");
  var_02 = param_00 maps\mp\_utility::func_4628("deaths");
  if(var_02 == 0) {
    var_02 = 1;
  }

  param_00 maps\mp\_utility::func_8702("kdratio", var_01 / var_02);
}

func_46EB(param_00) {
  var_01 = param_00.var_015C;
  if(!level.var_984D) {
    var_01 = param_00.var_008F;
  }

  return var_01;
}

func_1E57(param_00) {
  if(param_00.var_9A06["total"] < 1) {
    return;
  }

  var_01 = func_46EB(param_00);
  var_02 = param_00.var_9A06["total"];
  var_03 = var_01 / var_02 / 60;
  param_00 maps\mp\_utility::func_8702("totalGameScore", var_01);
  param_00 maps\mp\_utility::func_8702("scorePerMinute", var_03);
}

func_10DD() {
  if(function_03AF()) {
    return;
  }

  foreach(var_01 in level.var_744A) {
    if(!var_01 maps\mp\_utility::func_7A69()) {
      return;
    }

    var_01 maps\mp\_utility::func_50EA("numMatchesRecorded", 1);
    func_1E4F(var_01);
    func_1E57(var_01);
  }

  foreach(var_08, var_04 in level.var_145B) {
    if(!isDefined(level.var_145B[var_08].var_7743)) {
      continue;
    }

    var_05 = level.var_145B[var_08].var_7743;
    var_06 = level.var_145B[var_08].var_A2A6;
    var_07 = level.var_145B[var_08].var_A2A7;
    if(isDefined(var_06) && isDefined(var_07)) {
      [[var_05]](var_08, var_06, var_07);
      continue;
    }

    if(isDefined(var_06)) {
      [[var_05]](var_08, var_06);
      continue;
    }

    [[var_05]](var_08);
  }
}

func_4776(param_00) {
  var_01 = maps\mp\_utility::func_4628(param_00);
  var_01 = func_44EC(param_00, var_01);
  self setrankedplayerdata(common_scripts\utility::func_46A7(), "round", "awards", param_00, var_01);
  if(maps\mp\_utility::func_761E()) {
    return;
  }

  maps\mp\_matchdata::func_5EA1(param_00, var_01);
  if(func_8B87(param_00)) {
    var_02 = self getrankedplayerdata(common_scripts\utility::func_46A7(), "awards", "numMatchesRecorded");
    var_03 = self getrankedplayerdata(common_scripts\utility::func_46A7(), "awards", param_00);
    var_04 = var_03 * var_02;
    var_05 = int(var_04 + var_01 / var_02 + 1);
    self setrankedplayerdata(common_scripts\utility::func_46A7(), "awards", param_00, var_05);
    return;
  }

  var_06 = self getrankedplayerdata(common_scripts\utility::func_46A7(), "awards", param_00);
  self setrankedplayerdata(common_scripts\utility::func_46A7(), "awards", param_00, var_06 + var_01);
}

func_8B87(param_00) {
  switch (param_00) {
    case "scorePerMinute":
    case "kdratio":
      return 1;
  }

  return 0;
}

func_44EC(param_00, param_01) {
  var_02 = tablelookup("mp/awardTable.csv", 1, param_00, 5);
  switch (var_02) {
    case "float":
      param_01 = maps\mp\_utility::func_5D7F(param_01, 2);
      param_01 = param_01 * 100;
      break;

    case "multi":
    case "ratio":
    case "time":
    case "count":
    case "distance":
    case "none":
    default:
      break;
  }

  param_01 = int(param_01);
  return param_01;
}

highestwinsalwaysset(param_00, param_01) {
  foreach(var_03 in level.var_744A) {
    if(var_03 maps\mp\_utility::func_7A69() && var_03 func_933F(param_00) && !isDefined(param_01) || var_03 maps\mp\_utility::func_4628(param_00) >= param_01) {
      var_03 func_4776(param_00);
      var_03 func_86F2(param_00, 1);
    }
  }
}

func_4D40(param_00, param_01) {
  foreach(var_03 in level.var_744A) {
    if(var_03 maps\mp\_utility::func_7A69() && var_03 func_933F(param_00) && !isDefined(param_01) || var_03 maps\mp\_utility::func_4628(param_00) >= param_01) {
      var_03 func_4776(param_00);
      var_03 func_86F2(param_00);
    }
  }
}

func_5F32(param_00, param_01) {
  foreach(var_03 in level.var_744A) {
    if(var_03 maps\mp\_utility::func_7A69() && var_03 func_933F(param_00) && !isDefined(param_01) || var_03 maps\mp\_utility::func_4628(param_00) <= param_01) {
      var_03 func_4776(param_00);
      var_03 func_86F3(param_00);
    }
  }
}

func_5F33(param_00) {
  var_01 = maps\mp\_utility::func_46E3() / 1000;
  var_02 = var_01 * 0.5;
  foreach(var_04 in level.var_744A) {
    if(var_04.var_4B96 && var_04.var_9A06["total"] >= var_02) {
      var_04 func_4776(param_00);
      var_04 func_86F3(param_00);
    }
  }
}

func_933F(param_00) {
  var_01 = maps\mp\_utility::func_4628(param_00);
  var_02 = level.var_145B[param_00].var_2BD8;
  if(var_01 == var_02) {
    return 0;
  }

  return 1;
}