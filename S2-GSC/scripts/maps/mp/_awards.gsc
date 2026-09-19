/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_awards.gsc
***************************************/

init() {
  _id_5296();
  level thread onplayerconnect();
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);

    if(!isDefined(var_0.pers["stats"]))
      var_0.pers["stats"] = [];

    var_0.stats = var_0.pers["stats"];

    if(!var_0.stats.size) {
      foreach(var_3, var_2 in level._id_145B)
      var_0 maps\mp\_utility::initplayerstat(var_3, level._id_145B[var_3]._id_2BD8);
    }
  }
}

_id_5296() {
  _id_535A("headshots", 0, ::_id_4D40);
  _id_535A("multikill", 0, ::_id_4D40);
  _id_535A("avengekills", 0, ::_id_4D40);
  _id_535A("comebacks", 0, ::_id_4D40);
  _id_535A("rescues", 0, ::_id_4D40);
  _id_535A("longshots", 0, ::_id_4D40);
  _id_535A("revengekills", 0, ::_id_4D40);
  _id_535A("bulletpenkills", 0, ::_id_4D40);
  _id_535A("throwback_kill", 0, ::_id_4D40);
  _id_535A("firstblood", 0, ::_id_4D40);
  _id_535A("posthumous", 0, ::_id_4D40);
  _id_535A("assistedsuicide", 0, ::_id_4D40);
  _id_535A("buzzkill", 0, ::_id_4D40);
  _id_535A("oneshotkill", 0, ::_id_4D40);
  _id_535A("air_to_air_kill", 0, ::_id_4D40);
  _id_535A("air_to_ground_kill", 0, ::_id_4D40);
  _id_535A("ground_to_air_kill", 0, ::_id_4D40);
  _id_535A("doublekill", 0, ::_id_4D40);
  _id_535A("triplekill", 0, ::_id_4D40);
  _id_535A("fourkill", 0, ::_id_4D40);
  _id_535A("fivekill", 0, ::_id_4D40);
  _id_535A("sixkill", 0, ::_id_4D40);
  _id_535A("sevenkill", 0, ::_id_4D40);
  _id_535A("eightkill", 0, ::_id_4D40);
  _id_535A("hijacker", 0, ::_id_4D40);
  _id_535A("backstab", 0, ::_id_4D40);
  _id_535A("silentkill", 0, ::_id_4D40);
  _id_535A("killstreak5", 0, ::_id_4D40);
  _id_535A("killstreak10", 0, ::_id_4D40);
  _id_535A("killstreak15", 0, ::_id_4D40);
  _id_535A("killstreak20", 0, ::_id_4D40);
  _id_535A("killstreak25", 0, ::_id_4D40);
  _id_535A("killstreak30", 0, ::_id_4D40);
  _id_535A("killstreak30plus", 0, ::_id_4D40);
  _id_535A("pointblank", 0, ::_id_4D40);
  _id_535A("firstplacekill", 0, ::_id_4D40);
  _id_535A("boostslamkill", 0, ::_id_4D40);
  _id_535A("assault", 0, ::_id_4D40);
  _id_535A("defends", 0, ::_id_4D40);
  _id_535A("exo_knife_kill", 0, ::_id_4D40);
  _id_535A("exo_knife_recall_kill", 0, ::_id_4D40);
  _id_535A("near_death_kill", 0, ::_id_4D40);
  _id_535A("slide_kill", 0, ::_id_4D40);
  _id_535A("flash_kill", 0, ::_id_4D40);
  _id_535A("riot_kill", 0, ::_id_4D40);
  _id_535A("mg_nest_kill", 0, ::_id_4D40);
  _id_535A("divisions_infantry_kill", 0, ::_id_4D40);
  _id_535A("divisions_airborne_kill", 0, ::_id_4D40);
  _id_535A("divisions_armored_kill", 0, ::_id_4D40);
  _id_535A("divisions_cavalry_kill", 0, ::_id_4D40);
  _id_535A("divisions_mountain_kill", 0, ::_id_4D40);
  _id_535A("division_resistance_kill", 0, ::_id_4D40);
  _id_535A("division_grenadier_kill", 0, ::_id_4D40);
  _id_535A("division_commando_kill", 0, ::_id_4D40);
  _id_535A("division_scout_kill", 0, ::_id_4D40);
  _id_535A("division_artillery_kill", 0, ::_id_4D40);
  _id_535A("melee_air_to_air", 0, ::_id_4D40);
  _id_535A("assist_riot_shield", 0, ::_id_4D40);
  _id_535A("semtex_stick", 0, ::_id_4D40);
  _id_535A("stuck_with_explosive", 0, ::_id_4D40);
  _id_535A("crossbow_stick", 0, ::_id_4D40);
  _id_535A("multiKillOneBullet", 0, ::_id_4D40);
  _id_535A("think_fast", 0, ::_id_4D40);
  _id_535A("take_and_kill", 0, ::_id_4D40);
  _id_535A("four_play", 0, ::_id_4D40);
  _id_535A("sharepackage", 0, ::_id_4D40);
  _id_535A("kills", 0, ::_id_4D40);
  _id_535A("longestkillstreak", 0, ::_id_4D40);
  _id_535A("knifekills", 0, ::_id_4D40);
  _id_535A("kdratio", 0, ::_id_4D40);
  _id_535A("deaths", 0, ::_id_5F33);
  _id_535A("assists", 0, ::_id_4D40);
  _id_535A("totalGameScore", 0, ::_id_4D40);
  _id_535A("scorePerMinute", 0, ::_id_4D40);
  _id_535A("mostScorePerLife", 0, ::_id_4D40);
  _id_535A("killStreaksUsed", 0, ::_id_4D40);
  _id_535A("humiliation", 0, ::highestwinsalwaysset);
  _id_535A("regicide", 0, ::highestwinsalwaysset);
  _id_535A("gunslinger", 0, ::highestwinsalwaysset);
  _id_535A("dejavu", 0, ::highestwinsalwaysset);
  _id_535A("levelup", 0, ::highestwinsalwaysset);
  _id_535A("omegaman", 0, ::highestwinsalwaysset);
  _id_535A("plague", 0, ::highestwinsalwaysset);
  _id_535A("patientzero", 0, ::highestwinsalwaysset);
  _id_535A("careless", 0, ::highestwinsalwaysset);
  _id_535A("survivor", 0, ::highestwinsalwaysset);
  _id_535A("contagious", 0, ::highestwinsalwaysset);
  _id_535A("flagscaptured", 0, ::_id_4D40);
  _id_535A("flagsreturned", 0, ::_id_4D40);
  _id_535A("flagcarrierkills", 0, ::_id_4D40);
  _id_535A("flagscarried", 0, ::_id_4D40);
  _id_535A("killsasflagcarrier", 0, ::_id_4D40);
  _id_535A("pointscaptured", 0, ::_id_4D40);
  _id_535A("kill_while_capture", 0, ::_id_4D40);
  _id_535A("opening_move", 0, ::_id_4D40);
  _id_535A("hp_secure", 0, ::_id_4D40);
  _id_535A("targetsdestroyed", 0, ::_id_4D40);
  _id_535A("bombsplanted", 0, ::_id_4D40);
  _id_535A("bombsdefused", 0, ::_id_4D40);
  _id_535A("ninja_defuse", 0, ::_id_4D40);
  _id_535A("last_man_defuse", 0, ::_id_4D40);
  _id_535A("elimination", 0, ::_id_4D40);
  _id_535A("last_man_standing", 0, ::_id_4D40);
  _id_535A("sr_tag_elimination", 0, ::_id_4D40);
  _id_535A("sr_tag_revive", 0, ::_id_4D40);
  _id_535A("killsconfirmed", 0, ::_id_4D40);
  _id_535A("killsdenied", 0, ::_id_4D40);
  _id_535A("kill_denied_retrieved", 0, ::_id_4D40);
  _id_535A("tag_collector", 0, ::_id_4D40);
  _id_535A("touchdown", 0, ::_id_4D40);
  _id_535A("fieldgoal", 0, ::_id_4D40);
  _id_535A("interception", 0, ::_id_4D40);
  _id_535A("kill_with_ball", 0, ::_id_4D40);
  _id_535A("ball_score_assist", 0, ::_id_4D40);
  _id_535A("pass_kill_pickup", 0, ::_id_4D40);
  _id_535A("killedBallCarrier", 0, ::_id_4D40);
  _id_535A("uav_destroyed", 0, ::_id_4D40);
  _id_535A("counter_uav_destroyed", 0, ::_id_4D40);
  _id_535A("airstrike_destroyed", 0, ::_id_4D40);
  _id_535A("fire_bombing_run_destroyed", 0, ::_id_4D40);
  _id_535A("fighter_strike_destroyed", 0, ::_id_4D40);
  _id_535A("carepackage_plane_destroyed", 0, ::_id_4D40);
  _id_535A("emergency_carepackage_plane_destroyed", 0, ::_id_4D40);
  _id_535A("attack_dogs_destroyed", 0, ::_id_4D40);
  _id_535A("paratroopers_plane_destroyed", 0, ::_id_4D40);
  _id_535A("paratroopers_destroyed", 0, ::_id_4D40);
  _id_535A("fritzx_destroyed", 0, ::_id_4D40);
  _id_535A("assist_killstreak_destroyed", 0, ::_id_4D40);
  _id_535A("plane_gunner_destroyed", 0, ::_id_4D40);
  _id_535A("airdrop_kill", 0, ::_id_4D40);
  _id_535A("fritzx_kill", 0, ::_id_4D40);
  _id_535A("mortar_strike_kill", 0, ::_id_4D40);
  _id_535A("missile_strike_kill", 0, ::_id_4D40);
  _id_535A("airstrike_kill", 0, ::_id_4D40);
  _id_535A("firebomb_kill", 0, ::_id_4D40);
  _id_535A("attack_dogs_kill", 0, ::_id_4D40);
  _id_535A("plane_gunner_kill", 0, ::_id_4D40);
  _id_535A("fighter_strike_kill", 0, ::_id_4D40);
  _id_535A("flamethrower_kill", 0, ::_id_4D40);
  _id_535A("paratroopers_kill", 0, ::_id_4D40);
  _id_535A("molotovs_kill", 0, ::_id_4D40);
  _id_535A("v2_rocket_kill", 0, ::_id_4D40);
  _id_535A("uav_earned", 0, ::_id_4D40);
  _id_535A("carepackage_earned", 0, ::_id_4D40);
  _id_535A("missile_strike_earned", 0, ::_id_4D40);
  _id_535A("airstrike_earned", 0, ::_id_4D40);
  _id_535A("fritzx_earned", 0, ::_id_4D40);
  _id_535A("firebomb_earned", 0, ::_id_4D40);
  _id_535A("mortar_strike_earned", 0, ::_id_4D40);
  _id_535A("attack_dogs_earned", 0, ::_id_4D40);
  _id_535A("emergency_carepackage_earned", 0, ::_id_4D40);
  _id_535A("counter_uav_earned", 0, ::_id_4D40);
  _id_535A("flak_gun_earned", 0, ::_id_4D40);
  _id_535A("plane_gunner_earned", 0, ::_id_4D40);
  _id_535A("fighter_strike_earned", 0, ::_id_4D40);
  _id_535A("flamethrower_earned", 0, ::_id_4D40);
  _id_535A("paratroopers_earned", 0, ::_id_4D40);
  _id_535A("molotovs_earned", 0, ::_id_4D40);
  _id_535A("v2_rocket_earned", 0, ::_id_4D40);
  _id_535A("raid_flak_earned", 0, ::_id_4D40);
  _id_535A("raid_fighters_earned", 0, ::_id_4D40);
  _id_535A("dogfight_flak_earned", 0, ::_id_4D40);
  _id_535A("hub_psdWatch", 0, ::_id_4D40);
  _id_535A("hub_legendaryReveal", 0, ::_id_4D40);
  _id_535A("hub_1v1Win", 0, ::_id_4D40);
  _id_535A("hub_duelWin", 0, ::_id_4D40);
  _id_535A("hub_planeDestroyed", 0, ::_id_4D40);
  _id_535A("hub_skeetShooting", 0, ::_id_4D40);
  _id_535A("raids_construct", 0, ::_id_4D40);
  _id_535A("raids_destruct", 0, ::_id_4D40);
  _id_535A("raids_progress", 0, ::_id_4D40);
  _id_535A("raids_escort", 0, ::_id_4D40);
  _id_535A("raids_build_objective", 0, ::_id_4D40);
  _id_535A("raids_retreat", 0, ::_id_4D40);
  _id_535A("raids_hostage_release", 0, ::_id_4D40);
  _id_535A("raids_airdrop_secure", 0, ::_id_4D40);
  _id_535A("raids_flag_raise", 0, ::_id_4D40);
  _id_535A("numMatchesRecorded", 0, ::_id_4D40);
}

_id_535A(var_0, var_1, var_2, var_3, var_4) {
  level._id_145B[var_0] = spawnStruct();
  level._id_145B[var_0]._id_2BD8 = var_1;

  if(isDefined(var_2))
    level._id_145B[var_0]._id_7743 = var_2;

  if(isDefined(var_3))
    level._id_145B[var_0]._id_A2A6 = var_3;

  if(isDefined(var_4))
    level._id_145B[var_0]._id_A2A7 = var_4;
}

_id_86F2(var_0, var_1) {
  if((!isDefined(var_1) || !var_1) && isDefined(level.disableallplayerstats) && level.disableallplayerstats) {
    return;
  }
  var_2 = self getplayerdata(common_scripts\utility::_id_46A7(), "bests", var_0);
  var_3 = maps\mp\_utility::getplayerstat(var_0);
  var_3 = _id_44EC(var_0, var_3);

  if(var_2 == 0 || var_3 > var_2)
    self setplayerdata(common_scripts\utility::_id_46A7(), "bests", var_0, var_3);
}

_id_86F3(var_0) {
  if(isDefined(level.disableallplayerstats) && level.disableallplayerstats) {
    return;
  }
  var_1 = self getplayerdata(common_scripts\utility::_id_46A7(), "bests", var_0);
  var_2 = maps\mp\_utility::getplayerstat(var_0);
  var_2 = _id_44EC(var_0, var_2);

  if(var_1 == 0 || var_2 < var_1)
    self setplayerdata(common_scripts\utility::_id_46A7(), "bests", var_0, var_2);
}

_id_1E4F(var_0) {
  var_1 = var_0 maps\mp\_utility::getplayerstat("kills");
  var_2 = var_0 maps\mp\_utility::getplayerstat("deaths");

  if(var_2 == 0)
    var_2 = 1;

  var_0 maps\mp\_utility::setplayerstat("kdratio", var_1 / var_2);
}

_id_46EB(var_0) {
  var_1 = var_0.score;

  if(!level.teambased)
    var_1 = var_0._id_008F;

  return var_1;
}

_id_1E57(var_0) {
  if(var_0._id_9A06["total"] < 1) {
    return;
  }
  var_1 = _id_46EB(var_0);
  var_2 = var_0._id_9A06["total"];
  var_3 = var_1 / (var_2 / 60);
  var_0 maps\mp\_utility::setplayerstat("totalGameScore", var_1);
  var_0 maps\mp\_utility::setplayerstat("scorePerMinute", var_3);
}

_id_10DD() {
  if(_func_3AF()) {
    return;
  }
  foreach(var_1 in level.players) {
    if(!var_1 maps\mp\_utility::rankingenabled()) {
      return;
    }
    var_1 maps\mp\_utility::incplayerstat("numMatchesRecorded", 1);
    _id_1E4F(var_1);
    _id_1E57(var_1);
  }

  foreach(var_8, var_4 in level._id_145B) {
    if(!isDefined(level._id_145B[var_8]._id_7743)) {
      continue;
    }
    var_5 = level._id_145B[var_8]._id_7743;
    var_6 = level._id_145B[var_8]._id_A2A6;
    var_7 = level._id_145B[var_8]._id_A2A7;

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

_id_4776(var_0) {
  var_1 = maps\mp\_utility::getplayerstat(var_0);
  var_1 = _id_44EC(var_0, var_1);
  self setplayerdata(common_scripts\utility::_id_46A7(), "round", "awards", var_0, var_1);

  if(maps\mp\_utility::_id_761E()) {
    return;
  }
  _id_0485::_id_5EA1(var_0, var_1);

  if(_id_8B87(var_0)) {
    var_2 = self getplayerdata(common_scripts\utility::_id_46A7(), "awards", "numMatchesRecorded");
    var_3 = self getplayerdata(common_scripts\utility::_id_46A7(), "awards", var_0);
    var_4 = var_3 * var_2;
    var_5 = int((var_4 + var_1) / (var_2 + 1));
    self setplayerdata(common_scripts\utility::_id_46A7(), "awards", var_0, var_5);
  } else {
    var_6 = self getplayerdata(common_scripts\utility::_id_46A7(), "awards", var_0);
    self setplayerdata(common_scripts\utility::_id_46A7(), "awards", var_0, var_6 + var_1);
  }
}

_id_8B87(var_0) {
  switch (var_0) {
    case "scorePerMinute":
    case "kdratio":
      return 1;
  }

  return 0;
}

_id_44EC(var_0, var_1) {
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
    if(var_3 maps\mp\_utility::rankingenabled() && var_3 _id_933F(var_0) && (!isDefined(var_1) || var_3 maps\mp\_utility::getplayerstat(var_0) >= var_1)) {
      var_3 _id_4776(var_0);
      var_3 _id_86F2(var_0, 1);
    }
  }
}

_id_4D40(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(var_3 maps\mp\_utility::rankingenabled() && var_3 _id_933F(var_0) && (!isDefined(var_1) || var_3 maps\mp\_utility::getplayerstat(var_0) >= var_1)) {
      var_3 _id_4776(var_0);
      var_3 _id_86F2(var_0);
    }
  }
}

_id_5F32(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(var_3 maps\mp\_utility::rankingenabled() && var_3 _id_933F(var_0) && (!isDefined(var_1) || var_3 maps\mp\_utility::getplayerstat(var_0) <= var_1)) {
      var_3 _id_4776(var_0);
      var_3 _id_86F3(var_0);
    }
  }
}

_id_5F33(var_0) {
  var_1 = maps\mp\_utility::gettimepassed() / 1000;
  var_2 = var_1 * 0.5;

  foreach(var_4 in level.players) {
    if(var_4.hasspawned && var_4._id_9A06["total"] >= var_2) {
      var_4 _id_4776(var_0);
      var_4 _id_86F3(var_0);
    }
  }
}

_id_933F(var_0) {
  var_1 = maps\mp\_utility::getplayerstat(var_0);
  var_2 = level._id_145B[var_0]._id_2BD8;

  if(var_1 == var_2)
    return 0;
  else
    return 1;
}