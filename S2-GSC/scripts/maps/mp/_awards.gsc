/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_awards.gsc
***************************************/

init() {
  initawards();
  level thread onplayerconnect();
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);

    if(!isDefined(var_0.pers["stats"])) {
      var_0.pers["stats"] = [];
    }

    var_0.stats = var_0.pers["stats"];

    if(!var_0.stats.size) {
      foreach(var_3, var_2 in level.awards) {
        var_0 maps\mp\_utility::initplayerstat(var_3, level.awards[var_3].defaultvalue);
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

initstataward(var_0, var_1, var_2, var_3, var_4) {
  level.awards[var_0] = spawnStruct();
  level.awards[var_0].defaultvalue = var_1;

  if(isDefined(var_2)) {
    level.awards[var_0].process = var_2;
  }

  if(isDefined(var_3)) {
    level.awards[var_0].var1 = var_3;
  }

  if(isDefined(var_4)) {
    level.awards[var_0].var2 = var_4;
  }
}

setpersonalbestifgreater(var_0, var_1) {
  if((!isDefined(var_1) || !var_1) && isDefined(level.disableallplayerstats) && level.disableallplayerstats) {
    return;
  }
  var_2 = self getplayerdata(common_scripts\utility::getstatsgroup_common(), "bests", var_0);
  var_3 = maps\mp\_utility::getplayerstat(var_0);
  var_3 = getformattedvalue(var_0, var_3);

  if(var_2 == 0 || var_3 > var_2) {
    self setplayerdata(common_scripts\utility::getstatsgroup_common(), "bests", var_0, var_3);
  }
}

setpersonalbestiflower(var_0) {
  if(isDefined(level.disableallplayerstats) && level.disableallplayerstats) {
    return;
  }
  var_1 = self getplayerdata(common_scripts\utility::getstatsgroup_common(), "bests", var_0);
  var_2 = maps\mp\_utility::getplayerstat(var_0);
  var_2 = getformattedvalue(var_0, var_2);

  if(var_1 == 0 || var_2 < var_1) {
    self setplayerdata(common_scripts\utility::getstatsgroup_common(), "bests", var_0, var_2);
  }
}

calculatekd(var_0) {
  var_1 = var_0 maps\mp\_utility::getplayerstat("kills");
  var_2 = var_0 maps\mp\_utility::getplayerstat("deaths");

  if(var_2 == 0) {
    var_2 = 1;
  }

  var_0 maps\mp\_utility::setplayerstat("kdratio", var_1 / var_2);
}

gettotalscore(var_0) {
  var_1 = var_0.score;

  if(!level.teambased) {
    var_1 = var_0._id_008F;
  }

  return var_1;
}

calculatespm(var_0) {
  if(var_0.timeplayed["total"] < 1) {
    return;
  }
  var_1 = gettotalscore(var_0);
  var_2 = var_0.timeplayed["total"];
  var_3 = var_1 / (var_2 / 60);
  var_0 maps\mp\_utility::setplayerstat("totalGameScore", var_1);
  var_0 maps\mp\_utility::setplayerstat("scorePerMinute", var_3);
}

assignawards() {
  if(xmodelalias/alias_ger_heads_scarf_for_muddy_cheap()) {
    return;
  }
  foreach(var_1 in level.players) {
    if(!var_1 maps\mp\_utility::rankingenabled()) {
      return;
    }
    var_1 maps\mp\_utility::incplayerstat("numMatchesRecorded", 1);
    calculatekd(var_1);
    calculatespm(var_1);
  }

  foreach(var_8, var_4 in level.awards) {
    if(!isDefined(level.awards[var_8].process)) {
      continue;
    }
    var_5 = level.awards[var_8].process;
    var_6 = level.awards[var_8].var1;
    var_7 = level.awards[var_8].var2;

    if(isDefined(var_6) && isDefined(var_7)) {
      [[var_5]](var_8, var_6, var_7);
      continue;
    }

    if(isDefined(var_6)) {
      [[var_5]](var_8, var_6);
      continue;
    }

    [[var_5]](var_8);
  }
}

giveaward(var_0) {
  var_1 = maps\mp\_utility::getplayerstat(var_0);
  var_1 = getformattedvalue(var_0, var_1);
  self setplayerdata(common_scripts\utility::getstatsgroup_common(), "round", "awards", var_0, var_1);

  if(maps\mp\_utility::practiceroundgame()) {
    return;
  }
  _id_0485::_id_5EA1(var_0, var_1);

  if(shouldaveragetotal(var_0)) {
    var_2 = self getplayerdata(common_scripts\utility::getstatsgroup_common(), "awards", "numMatchesRecorded");
    var_3 = self getplayerdata(common_scripts\utility::getstatsgroup_common(), "awards", var_0);
    var_4 = var_3 * var_2;
    var_5 = int((var_4 + var_1) / (var_2 + 1));
    self setplayerdata(common_scripts\utility::getstatsgroup_common(), "awards", var_0, var_5);
  } else {
    var_6 = self getplayerdata(common_scripts\utility::getstatsgroup_common(), "awards", var_0);
    self setplayerdata(common_scripts\utility::getstatsgroup_common(), "awards", var_0, var_6 + var_1);
  }
}

shouldaveragetotal(var_0) {
  switch (var_0) {
    case "scorePerMinute":
    case "kdratio":
      return 1;
  }

  return 0;
}

getformattedvalue(var_0, var_1) {
  var_2 = tablelookup("mp/awardTable.csv", 1, var_0, 5);

  switch (var_2) {
    case "float":
      var_1 = maps\mp\_utility::limitdecimalplaces(var_1, 2);
      var_1 = var_1 * 100;
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

  var_1 = int(var_1);
  return var_1;
}

highestwinsalwaysset(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(var_3 maps\mp\_utility::rankingenabled() && var_3 statvaluechanged(var_0) && (!isDefined(var_1) || var_3 maps\mp\_utility::getplayerstat(var_0) >= var_1)) {
      var_3 giveaward(var_0);
      var_3 setpersonalbestifgreater(var_0, 1);
    }
  }
}

highestwins(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(var_3 maps\mp\_utility::rankingenabled() && var_3 statvaluechanged(var_0) && (!isDefined(var_1) || var_3 maps\mp\_utility::getplayerstat(var_0) >= var_1)) {
      var_3 giveaward(var_0);
      var_3 setpersonalbestifgreater(var_0);
    }
  }
}

lowestwins(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(var_3 maps\mp\_utility::rankingenabled() && var_3 statvaluechanged(var_0) && (!isDefined(var_1) || var_3 maps\mp\_utility::getplayerstat(var_0) <= var_1)) {
      var_3 giveaward(var_0);
      var_3 setpersonalbestiflower(var_0);
    }
  }
}

lowestwithhalfplayedtime(var_0) {
  var_1 = maps\mp\_utility::gettimepassed() / 1000;
  var_2 = var_1 * 0.5;

  foreach(var_4 in level.players) {
    if(var_4.hasspawned && var_4.timeplayed["total"] >= var_2) {
      var_4 giveaward(var_0);
      var_4 setpersonalbestiflower(var_0);
    }
  }
}

statvaluechanged(var_0) {
  var_1 = maps\mp\_utility::getplayerstat(var_0);
  var_2 = level.awards[var_0].defaultvalue;

  if(var_1 == var_2) {
    return 0;
  } else {
    return 1;
  }
}