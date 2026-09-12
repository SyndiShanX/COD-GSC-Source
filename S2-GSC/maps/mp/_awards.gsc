/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\_awards.gsc
*********************************************/

init() {
  initawards();
  level thread onplayerconnect();
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_00);
    if(!isDefined(var_00.pers["stats"])) {
      var_00.pers["stats"] = [];
    }

    var_00.stats = var_00.pers["stats"];
    if(!var_00.stats.size) {
      foreach(var_03, var_02 in level.awards) {
        var_00 maps\mp\_utility::initplayerstat(var_03, level.awards[var_03].defaultvalue);
      }
    }
  }
}

initawards() {
  initstataward("headshots", 0, ::highestwins);
  initstataward("multikill", 0, ::highestwins);
  initstataward("avengekills", 0, ::highestwins);
  initstataward("comebacks", 0, ::highestwins);
  initstataward("rescues", 0, ::highestwins);
  initstataward("longshots", 0, ::highestwins);
  initstataward("revengekills", 0, ::highestwins);
  initstataward("bulletpenkills", 0, ::highestwins);
  initstataward("throwback_kill", 0, ::highestwins);
  initstataward("firstblood", 0, ::highestwins);
  initstataward("posthumous", 0, ::highestwins);
  initstataward("assistedsuicide", 0, ::highestwins);
  initstataward("buzzkill", 0, ::highestwins);
  initstataward("oneshotkill", 0, ::highestwins);
  initstataward("air_to_air_kill", 0, ::highestwins);
  initstataward("air_to_ground_kill", 0, ::highestwins);
  initstataward("ground_to_air_kill", 0, ::highestwins);
  initstataward("doublekill", 0, ::highestwins);
  initstataward("triplekill", 0, ::highestwins);
  initstataward("fourkill", 0, ::highestwins);
  initstataward("fivekill", 0, ::highestwins);
  initstataward("sixkill", 0, ::highestwins);
  initstataward("sevenkill", 0, ::highestwins);
  initstataward("eightkill", 0, ::highestwins);
  initstataward("hijacker", 0, ::highestwins);
  initstataward("backstab", 0, ::highestwins);
  initstataward("silentkill", 0, ::highestwins);
  initstataward("killstreak5", 0, ::highestwins);
  initstataward("killstreak10", 0, ::highestwins);
  initstataward("killstreak15", 0, ::highestwins);
  initstataward("killstreak20", 0, ::highestwins);
  initstataward("killstreak25", 0, ::highestwins);
  initstataward("killstreak30", 0, ::highestwins);
  initstataward("killstreak30plus", 0, ::highestwins);
  initstataward("pointblank", 0, ::highestwins);
  initstataward("firstplacekill", 0, ::highestwins);
  initstataward("boostslamkill", 0, ::highestwins);
  initstataward("assault", 0, ::highestwins);
  initstataward("defends", 0, ::highestwins);
  initstataward("exo_knife_kill", 0, ::highestwins);
  initstataward("exo_knife_recall_kill", 0, ::highestwins);
  initstataward("near_death_kill", 0, ::highestwins);
  initstataward("slide_kill", 0, ::highestwins);
  initstataward("flash_kill", 0, ::highestwins);
  initstataward("riot_kill", 0, ::highestwins);
  initstataward("mg_nest_kill", 0, ::highestwins);
  initstataward("divisions_infantry_kill", 0, ::highestwins);
  initstataward("divisions_airborne_kill", 0, ::highestwins);
  initstataward("divisions_armored_kill", 0, ::highestwins);
  initstataward("divisions_cavalry_kill", 0, ::highestwins);
  initstataward("divisions_mountain_kill", 0, ::highestwins);
  initstataward("division_resistance_kill", 0, ::highestwins);
  initstataward("division_grenadier_kill", 0, ::highestwins);
  initstataward("division_commando_kill", 0, ::highestwins);
  initstataward("division_scout_kill", 0, ::highestwins);
  initstataward("division_artillery_kill", 0, ::highestwins);
  initstataward("melee_air_to_air", 0, ::highestwins);
  initstataward("assist_riot_shield", 0, ::highestwins);
  initstataward("semtex_stick", 0, ::highestwins);
  initstataward("stuck_with_explosive", 0, ::highestwins);
  initstataward("crossbow_stick", 0, ::highestwins);
  initstataward("multiKillOneBullet", 0, ::highestwins);
  initstataward("think_fast", 0, ::highestwins);
  initstataward("take_and_kill", 0, ::highestwins);
  initstataward("four_play", 0, ::highestwins);
  initstataward("sharepackage", 0, ::highestwins);
  initstataward("kills", 0, ::highestwins);
  initstataward("longestkillstreak", 0, ::highestwins);
  initstataward("knifekills", 0, ::highestwins);
  initstataward("kdratio", 0, ::highestwins);
  initstataward("deaths", 0, ::lowestwithhalfplayedtime);
  initstataward("assists", 0, ::highestwins);
  initstataward("totalGameScore", 0, ::highestwins);
  initstataward("scorePerMinute", 0, ::highestwins);
  initstataward("mostScorePerLife", 0, ::highestwins);
  initstataward("killStreaksUsed", 0, ::highestwins);
  initstataward("humiliation", 0, ::highestwinsalwaysset);
  initstataward("regicide", 0, ::highestwinsalwaysset);
  initstataward("gunslinger", 0, ::highestwinsalwaysset);
  initstataward("dejavu", 0, ::highestwinsalwaysset);
  initstataward("levelup", 0, ::highestwinsalwaysset);
  initstataward("omegaman", 0, ::highestwinsalwaysset);
  initstataward("plague", 0, ::highestwinsalwaysset);
  initstataward("patientzero", 0, ::highestwinsalwaysset);
  initstataward("careless", 0, ::highestwinsalwaysset);
  initstataward("survivor", 0, ::highestwinsalwaysset);
  initstataward("contagious", 0, ::highestwinsalwaysset);
  initstataward("flagscaptured", 0, ::highestwins);
  initstataward("flagsreturned", 0, ::highestwins);
  initstataward("flagcarrierkills", 0, ::highestwins);
  initstataward("flagscarried", 0, ::highestwins);
  initstataward("killsasflagcarrier", 0, ::highestwins);
  initstataward("pointscaptured", 0, ::highestwins);
  initstataward("kill_while_capture", 0, ::highestwins);
  initstataward("opening_move", 0, ::highestwins);
  initstataward("hp_secure", 0, ::highestwins);
  initstataward("targetsdestroyed", 0, ::highestwins);
  initstataward("bombsplanted", 0, ::highestwins);
  initstataward("bombsdefused", 0, ::highestwins);
  initstataward("ninja_defuse", 0, ::highestwins);
  initstataward("last_man_defuse", 0, ::highestwins);
  initstataward("elimination", 0, ::highestwins);
  initstataward("last_man_standing", 0, ::highestwins);
  initstataward("sr_tag_elimination", 0, ::highestwins);
  initstataward("sr_tag_revive", 0, ::highestwins);
  initstataward("killsconfirmed", 0, ::highestwins);
  initstataward("killsdenied", 0, ::highestwins);
  initstataward("kill_denied_retrieved", 0, ::highestwins);
  initstataward("tag_collector", 0, ::highestwins);
  initstataward("touchdown", 0, ::highestwins);
  initstataward("fieldgoal", 0, ::highestwins);
  initstataward("interception", 0, ::highestwins);
  initstataward("kill_with_ball", 0, ::highestwins);
  initstataward("ball_score_assist", 0, ::highestwins);
  initstataward("pass_kill_pickup", 0, ::highestwins);
  initstataward("killedBallCarrier", 0, ::highestwins);
  initstataward("uav_destroyed", 0, ::highestwins);
  initstataward("counter_uav_destroyed", 0, ::highestwins);
  initstataward("airstrike_destroyed", 0, ::highestwins);
  initstataward("fire_bombing_run_destroyed", 0, ::highestwins);
  initstataward("fighter_strike_destroyed", 0, ::highestwins);
  initstataward("carepackage_plane_destroyed", 0, ::highestwins);
  initstataward("emergency_carepackage_plane_destroyed", 0, ::highestwins);
  initstataward("attack_dogs_destroyed", 0, ::highestwins);
  initstataward("paratroopers_plane_destroyed", 0, ::highestwins);
  initstataward("paratroopers_destroyed", 0, ::highestwins);
  initstataward("fritzx_destroyed", 0, ::highestwins);
  initstataward("assist_killstreak_destroyed", 0, ::highestwins);
  initstataward("plane_gunner_destroyed", 0, ::highestwins);
  initstataward("airdrop_kill", 0, ::highestwins);
  initstataward("fritzx_kill", 0, ::highestwins);
  initstataward("mortar_strike_kill", 0, ::highestwins);
  initstataward("missile_strike_kill", 0, ::highestwins);
  initstataward("airstrike_kill", 0, ::highestwins);
  initstataward("firebomb_kill", 0, ::highestwins);
  initstataward("attack_dogs_kill", 0, ::highestwins);
  initstataward("plane_gunner_kill", 0, ::highestwins);
  initstataward("fighter_strike_kill", 0, ::highestwins);
  initstataward("flamethrower_kill", 0, ::highestwins);
  initstataward("paratroopers_kill", 0, ::highestwins);
  initstataward("molotovs_kill", 0, ::highestwins);
  initstataward("v2_rocket_kill", 0, ::highestwins);
  initstataward("uav_earned", 0, ::highestwins);
  initstataward("carepackage_earned", 0, ::highestwins);
  initstataward("missile_strike_earned", 0, ::highestwins);
  initstataward("airstrike_earned", 0, ::highestwins);
  initstataward("fritzx_earned", 0, ::highestwins);
  initstataward("firebomb_earned", 0, ::highestwins);
  initstataward("mortar_strike_earned", 0, ::highestwins);
  initstataward("attack_dogs_earned", 0, ::highestwins);
  initstataward("emergency_carepackage_earned", 0, ::highestwins);
  initstataward("counter_uav_earned", 0, ::highestwins);
  initstataward("flak_gun_earned", 0, ::highestwins);
  initstataward("plane_gunner_earned", 0, ::highestwins);
  initstataward("fighter_strike_earned", 0, ::highestwins);
  initstataward("flamethrower_earned", 0, ::highestwins);
  initstataward("paratroopers_earned", 0, ::highestwins);
  initstataward("molotovs_earned", 0, ::highestwins);
  initstataward("v2_rocket_earned", 0, ::highestwins);
  initstataward("raid_flak_earned", 0, ::highestwins);
  initstataward("raid_fighters_earned", 0, ::highestwins);
  initstataward("dogfight_flak_earned", 0, ::highestwins);
  initstataward("hub_psdWatch", 0, ::highestwins);
  initstataward("hub_legendaryReveal", 0, ::highestwins);
  initstataward("hub_1v1Win", 0, ::highestwins);
  initstataward("hub_duelWin", 0, ::highestwins);
  initstataward("hub_planeDestroyed", 0, ::highestwins);
  initstataward("hub_skeetShooting", 0, ::highestwins);
  initstataward("raids_construct", 0, ::highestwins);
  initstataward("raids_destruct", 0, ::highestwins);
  initstataward("raids_progress", 0, ::highestwins);
  initstataward("raids_escort", 0, ::highestwins);
  initstataward("raids_build_objective", 0, ::highestwins);
  initstataward("raids_retreat", 0, ::highestwins);
  initstataward("raids_hostage_release", 0, ::highestwins);
  initstataward("raids_airdrop_secure", 0, ::highestwins);
  initstataward("raids_flag_raise", 0, ::highestwins);
  initstataward("numMatchesRecorded", 0, ::highestwins);
}

initstataward(param_00, param_01, param_02, param_03, param_04) {
  level.awards[param_00] = spawnStruct();
  level.awards[param_00].defaultvalue = param_01;
  if(isDefined(param_02)) {
    level.awards[param_00].process = param_02;
  }

  if(isDefined(param_03)) {
    level.awards[param_00].var1 = param_03;
  }

  if(isDefined(param_04)) {
    level.awards[param_00].var2 = param_04;
  }
}

setpersonalbestifgreater(param_00, param_01) {
  if((!isDefined(param_01) || !param_01) && isDefined(level.disableallplayerstats) && level.disableallplayerstats) {
    return;
  }

  var_02 = self getrankedplayerdata(common_scripts\utility::getstatgamemode(), "bests", param_00);
  var_03 = maps\mp\_utility::getplayerstat(param_00);
  var_03 = getformattedvalue(param_00, var_03);
  if(var_02 == 0 || var_03 > var_02) {
    self setrankedplayerdata(common_scripts\utility::getstatgamemode(), "bests", param_00, var_03);
  }
}

setpersonalbestiflower(param_00) {
  if(isDefined(level.disableallplayerstats) && level.disableallplayerstats) {
    return;
  }

  var_01 = self getrankedplayerdata(common_scripts\utility::getstatgamemode(), "bests", param_00);
  var_02 = maps\mp\_utility::getplayerstat(param_00);
  var_02 = getformattedvalue(param_00, var_02);
  if(var_01 == 0 || var_02 < var_01) {
    self setrankedplayerdata(common_scripts\utility::getstatgamemode(), "bests", param_00, var_02);
  }
}

calculatekd(param_00) {
  var_01 = param_00 maps\mp\_utility::getplayerstat("kills");
  var_02 = param_00 maps\mp\_utility::getplayerstat("deaths");
  if(var_02 == 0) {
    var_02 = 1;
  }

  param_00 maps\mp\_utility::setplayerstat("kdratio", var_01 / var_02);
}

gettotalscore(param_00) {
  var_01 = param_00.score;
  if(!level.teambased) {
    var_01 = param_00.extrascore0;
  }

  return var_01;
}

calculatespm(param_00) {
  if(param_00.timeplayed["total"] < 1) {
    return;
  }

  var_01 = gettotalscore(param_00);
  var_02 = param_00.timeplayed["total"];
  var_03 = var_01 / var_02 / 60;
  param_00 maps\mp\_utility::setplayerstat("totalGameScore", var_01);
  param_00 maps\mp\_utility::setplayerstat("scorePerMinute", var_03);
}

assignawards() {
  if(function_03AF()) {
    return;
  }

  foreach(var_01 in level.players) {
    if(!var_01 maps\mp\_utility::rankingenabled()) {
      return;
    }

    var_01 maps\mp\_utility::incplayerstat("numMatchesRecorded", 1);
    calculatekd(var_01);
    calculatespm(var_01);
  }

  foreach(var_08, var_04 in level.awards) {
    if(!isDefined(level.awards[var_08].process)) {
      continue;
    }

    var_05 = level.awards[var_08].process;
    var_06 = level.awards[var_08].var1;
    var_07 = level.awards[var_08].var2;
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

giveaward(param_00) {
  var_01 = maps\mp\_utility::getplayerstat(param_00);
  var_01 = getformattedvalue(param_00, var_01);
  self setrankedplayerdata(common_scripts\utility::getstatgamemode(), "round", "awards", param_00, var_01);
  if(maps\mp\_utility::practiceroundgame()) {
    return;
  }

  maps\mp\_matchdata::func_5EA1(param_00, var_01);
  if(shouldaveragetotal(param_00)) {
    var_02 = self getrankedplayerdata(common_scripts\utility::getstatgamemode(), "awards", "numMatchesRecorded");
    var_03 = self getrankedplayerdata(common_scripts\utility::getstatgamemode(), "awards", param_00);
    var_04 = var_03 * var_02;
    var_05 = int(var_04 + var_01 / var_02 + 1);
    self setrankedplayerdata(common_scripts\utility::getstatgamemode(), "awards", param_00, var_05);
    return;
  }

  var_06 = self getrankedplayerdata(common_scripts\utility::getstatgamemode(), "awards", param_00);
  self setrankedplayerdata(common_scripts\utility::getstatgamemode(), "awards", param_00, var_06 + var_01);
}

shouldaveragetotal(param_00) {
  switch (param_00) {
    case "scorePerMinute":
    case "kdratio":
      return 1;
  }

  return 0;
}

getformattedvalue(param_00, param_01) {
  var_02 = tablelookup("mp/awardTable.csv", 1, param_00, 5);
  switch (var_02) {
    case "float":
      param_01 = maps\mp\_utility::limitdecimalplaces(param_01, 2);
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
  foreach(var_03 in level.players) {
    if(var_03 maps\mp\_utility::rankingenabled() && var_03 statvaluechanged(param_00) && !isDefined(param_01) || var_03 maps\mp\_utility::getplayerstat(param_00) >= param_01) {
      var_03 giveaward(param_00);
      var_03 setpersonalbestifgreater(param_00, 1);
    }
  }
}

highestwins(param_00, param_01) {
  foreach(var_03 in level.players) {
    if(var_03 maps\mp\_utility::rankingenabled() && var_03 statvaluechanged(param_00) && !isDefined(param_01) || var_03 maps\mp\_utility::getplayerstat(param_00) >= param_01) {
      var_03 giveaward(param_00);
      var_03 setpersonalbestifgreater(param_00);
    }
  }
}

lowestwins(param_00, param_01) {
  foreach(var_03 in level.players) {
    if(var_03 maps\mp\_utility::rankingenabled() && var_03 statvaluechanged(param_00) && !isDefined(param_01) || var_03 maps\mp\_utility::getplayerstat(param_00) <= param_01) {
      var_03 giveaward(param_00);
      var_03 setpersonalbestiflower(param_00);
    }
  }
}

lowestwithhalfplayedtime(param_00) {
  var_01 = maps\mp\_utility::gettimepassed() / 1000;
  var_02 = var_01 * 0.5;
  foreach(var_04 in level.players) {
    if(var_04.hasspawned && var_04.timeplayed["total"] >= var_02) {
      var_04 giveaward(param_00);
      var_04 setpersonalbestiflower(param_00);
    }
  }
}

statvaluechanged(param_00) {
  var_01 = maps\mp\_utility::getplayerstat(param_00);
  var_02 = level.awards[param_00].defaultvalue;
  if(var_01 == var_02) {
    return 0;
  }

  return 1;
}