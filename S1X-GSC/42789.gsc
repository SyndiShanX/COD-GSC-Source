/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42789.gsc
**************************************/

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
  initstataward("headshots", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("multikill", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("avengekills", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("comebacks", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("rescues", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("longshots", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("revengekills", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("bulletpenkills", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("throwback_kill", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("firstblood", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("posthumous", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("assistedsuicide", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("buzzkill", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("oneshotkill", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("air_to_air_kill", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("air_to_ground_kill", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("ground_to_air_kill", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("doublekill", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("triplekill", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("fourkill", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("fivekill", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("sixkill", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("sevenkill", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("eightkill", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("hijacker", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("backstab", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("5killstreak", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("10killstreak", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("15killstreak", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("20killstreak", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("25killstreak", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("30killstreak", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("30pluskillstreak", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("pointblank", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("firstplacekill", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("boostslamkill", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("assault", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("defends", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("exo_knife_kill", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("exo_knife_recall_kill", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("near_death_kill", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("slide_kill", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("flash_kill", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("riot_kill", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("melee_air_to_air", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("assist_riot_shield", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("semtex_stick", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("stuck_with_explosive", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("crossbow_stick", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("multiKillOneBullet", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("think_fast", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("take_and_kill", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("four_play", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("sharepackage", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("map_killstreak", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("killstreak_tag", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("killstreak_join", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("kills", 0, 0, ::highestwins);
  initstataward("longestkillstreak", 0, 0, ::highestwins);
  initstataward("knifekills", 0, 0, ::highestwins);
  initstataward("kdratio", 0, 0, ::highestwins);
  initstataward("deaths", 0, 0, ::lowestwithhalfplayedtime);
  initstataward("assists", 0, 0, ::highestwins);
  initstataward("totalGameScore", 0, 0, ::highestwins);
  initstataward("scorePerMinute", 0, 0, ::highestwins);
  initstataward("mostScorePerLife", 0, 0, ::highestwins);
  initstataward("killStreaksUsed", 0, 0, ::highestwins);
  initstataward("humiliation", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("regicide", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("gunslinger", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("dejavu", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("levelup", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("omegaman", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("plague", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("patientzero", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("careless", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("survivor", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("contagious", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("flagscaptured", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("flagsreturned", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("flagcarrierkills", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("flagscarried", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("killsasflagcarrier", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("pointscaptured", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("kill_while_capture", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("opening_move", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("hp_secure", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("targetsdestroyed", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("bombsplanted", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("bombsdefused", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("ninja_defuse", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("last_man_defuse", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("elimination", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("last_man_standing", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("sr_tag_elimination", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("sr_tag_revive", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("killsconfirmed", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("killsdenied", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("kill_denied_retrieved", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("tag_collector", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("touchdown", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("fieldgoal", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("interception", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("kill_with_ball", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("ball_score_assist", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("pass_kill_pickup", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("killedBallCarrier", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("uav_destroyed", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("warbird_destroyed", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("paladin_destroyed", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("vulcan_destroyed", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("goliath_destroyed", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("missile_strike_destroyed", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("sentry_gun_destroyed", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("strafing_run_destroyed", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("assault_drone_destroyed", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("recon_drone_destroyed", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("map_killstreak_destroyed", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("assist_killstreak_destroyed", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("warbird_kill", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("paladin_kill", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("vulcan_kill", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("goliath_kill", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("airdrop_kill", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("airdrop_trap_kill", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("missile_strike_kill", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("sentry_gun_kill", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("strafing_run_kill", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("assault_drone_kill", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("map_killstreak_kill", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("coop_killstreak_kill", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("uav_earned", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("warbird_earned", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("orbitalsupport_earned", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("orbital_strike_laser_earned", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("orbital_carepackage_earned", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("heavy_exosuit_earned", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("missile_strike_earned", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("remote_mg_sentry_turret_earned", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("strafing_run_airstrike_earned", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("assault_ugv_earned", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("recon_ugv_earned", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("emp_earned", 0, 1, ::highesetwinsupdateplayerdata);
  initstataward("numMatchesRecorded", 0, 0, ::highestwins);
}

initstataward(var_0, var_1, var_2, var_3, var_4, var_5) {
  level.awards[var_0] = spawnStruct();
  level.awards[var_0].defaultvalue = var_1;

  if(isDefined(var_3)) {
    level.awards[var_0].process = var_3;
  }

  if(isDefined(var_2)) {
    level.awards[var_0].saveonupdate = var_2;
  }

  if(isDefined(var_4)) {
    level.awards[var_0].var1 = var_4;
  }

  if(isDefined(var_5)) {
    level.awards[var_0].var2 = var_5;
  }
}

setpersonalbestifgreater(var_0) {
  var_1 = self getcommonplayerdata("bests", var_0);
  var_2 = maps\mp\_utility::getplayerstat(var_0);
  var_2 = getformattedvalue(var_0, var_2);

  if(var_1 == 0 || var_2 > var_1) {
    self setcommonplayerdata("bests", var_0, var_2);
  }
}

setpersonalbestiflower(var_0) {
  var_1 = self getcommonplayerdata("bests", var_0);
  var_2 = maps\mp\_utility::getplayerstat(var_0);
  var_2 = getformattedvalue(var_0, var_2);

  if(var_1 == 0 || var_2 < var_1) {
    self setcommonplayerdata("bests", var_0, var_2);
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
    var_1 = var_0.extrascore0;
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
  foreach(var_1 in level.players) {
    if(!var_1 maps\mp\_utility::rankingenabled()) {
      return;
    }
    var_1 maps\mp\_utility::incplayerstat("numMatchesRecorded", 1);
    calculatekd(var_1);
    calculatespm(var_1);
  }

  foreach(var_8, var_4 in level.awards) {
    if(!isDefined(level.awards[var_8].process) || isDefined(level.awards[var_8].saveonupdate) && level.awards[var_8].saveonupdate) {
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

giveaward(var_0, var_1) {
  var_1 = getformattedvalue(var_0, var_1);
  var_2 = self getcommonplayerdata("round", "awards", var_0);
  self setcommonplayerdata("round", "awards", var_0, var_2 + var_1);

  if(maps\mp\_utility::practiceroundgame()) {
    return;
  }
  if(shouldaveragetotal(var_0)) {
    var_3 = self getcommonplayerdata("awards", "numMatchesRecorded");
    var_4 = self getcommonplayerdata("awards", var_0);
    var_5 = var_4 * var_3;
    var_6 = int((var_5 + var_1) / (var_3 + 1));
    self setcommonplayerdata("awards", var_0, var_6);
  } else {
    var_2 = self getcommonplayerdata("awards", var_0);
    self setcommonplayerdata("awards", var_0, var_2 + var_1);
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

highesetwinsupdateplayerdata(var_0, var_1) {
  if(maps\mp\_utility::rankingenabled()) {
    giveaward(var_0, var_1);
    setpersonalbestifgreater(var_0);
  }
}

lowestwinsupdateplayerdata(var_0, var_1) {
  if(maps\mp\_utility::rankingenabled()) {
    giveaward(var_0, var_1);
    setpersonalbestiflower(var_0);
  }
}

highestwins(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(var_3 maps\mp\_utility::rankingenabled() && var_3 statvaluechanged(var_0) && (!isDefined(var_1) || var_3 maps\mp\_utility::getplayerstat(var_0) >= var_1)) {
      var_4 = var_3 maps\mp\_utility::getplayerstat(var_0);
      var_3 highesetwinsupdateplayerdata(var_0, var_4);
    }
  }
}

lowestwins(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(var_3 maps\mp\_utility::rankingenabled() && var_3 statvaluechanged(var_0) && (!isDefined(var_1) || var_3 maps\mp\_utility::getplayerstat(var_0) <= var_1)) {
      var_4 = var_3 maps\mp\_utility::getplayerstat(var_0);
      var_3 lowestwinsupdateplayerdata(var_0, var_4);
    }
  }
}

lowestwithhalfplayedtime(var_0) {
  var_1 = maps\mp\_utility::gettimepassed() / 1000;
  var_2 = var_1 * 0.5;

  foreach(var_4 in level.players) {
    if(var_4.hasspawned && var_4.timeplayed["total"] >= var_2) {
      var_5 = var_4 maps\mp\_utility::getplayerstat(var_0);
      var_4 lowestwinsupdateplayerdata(var_0, var_5);
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