/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\_awards.gsc
***************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

CONST_PRINT_AWARDS = false;

init() {
  initAwards();

  level thread onPlayerConnect();
}

onPlayerConnect() {
  for(;;) {
    level waittill("connected", player);

    if(!isDefined(player.pers["stats"])) {
      player.pers["stats"] = [];
    }

    player.stats = player.pers["stats"];

    if(!player.stats.size) {
      foreach(ref, award in level.awards) {
        player initPlayerStat(ref, level.awards[ref].defaultvalue);
      }
    }

  }
}

initAwards() {
  initStatAward("headshots", 0, ::highestWins);
  initStatAward("multikill", 0, ::highestWins);
  initStatAward("avengekills", 0, ::highestWins);
  initStatAward("comebacks", 0, ::highestWins);
  initStatAward("rescues", 0, ::highestWins);
  initStatAward("longshots", 0, ::highestWins);
  initStatAward("revengekills", 0, ::highestWins);
  initStatAward("bulletpenkills", 0, ::highestWins);
  initStatAward("throwback_kill", 0, ::highestWins);
  initStatAward("firstblood", 0, ::highestWins);
  initStatAward("posthumous", 0, ::highestWins);
  initStatAward("assistedsuicide", 0, ::highestWins);
  initStatAward("buzzkill", 0, ::highestWins);
  initStatAward("oneshotkill", 0, ::highestWins);
  initStatAward("air_to_air_kill", 0, ::highestWins);
  initStatAward("air_to_ground_kill", 0, ::highestWins);
  initStatAward("ground_to_air_kill", 0, ::highestWins);
  initStatAward("doublekill", 0, ::highestWins);
  initStatAward("triplekill", 0, ::highestWins);
  initStatAward("fourkill", 0, ::highestWins);
  initStatAward("fivekill", 0, ::highestWins);
  initStatAward("sixkill", 0, ::highestWins);
  initStatAward("sevenkill", 0, ::highestWins);
  initStatAward("eightkill", 0, ::highestWins);
  initStatAward("hijacker", 0, ::highestWins);
  initStatAward("backstab", 0, ::highestWins);
  initStatAward("5killstreak", 0, ::highestWins);
  initStatAward("10killstreak", 0, ::highestWins);
  initStatAward("15killstreak", 0, ::highestWins);
  initStatAward("20killstreak", 0, ::highestWins);
  initStatAward("25killstreak", 0, ::highestWins);
  initStatAward("30killstreak", 0, ::highestWins);
  initStatAward("30pluskillstreak", 0, ::highestWins);
  initStatAward("pointblank", 0, ::highestWins);
  initStatAward("firstplacekill", 0, ::highestWins);
  initStatAward("boostslamkill", 0, ::highestWins);
  initStatAward("assault", 0, ::highestWins);
  initStatAward("defends", 0, ::highestWins);
  initStatAward("exo_knife_kill", 0, ::highestWins);
  initStatAward("exo_knife_recall_kill", 0, ::highestWins);
  initStatAward("near_death_kill", 0, ::highestWins);
  initStatAward("slide_kill", 0, ::highestWins);
  initStatAward("flash_kill", 0, ::highestWins);
  initStatAward("riot_kill", 0, ::highestWins);
  initStatAward("melee_air_to_air", 0, ::highestWins);
  initStatAward("assist_riot_shield", 0, ::highestWins);
  initStatAward("semtex_stick", 0, ::highestWins);
  initStatAward("stuck_with_explosive", 0, ::highestWins);
  initStatAward("crossbow_stick", 0, ::highestWins);
  initStatAward("multiKillOneBullet", 0, ::highestWins);
  initStatAward("think_fast", 0, ::highestWins);
  initStatAward("take_and_kill", 0, ::highestWins);
  initStatAward("four_play", 0, ::highestWins);
  initStatAward("sharepackage", 0, ::highestWins);
  initStatAward("map_killstreak", 0, ::highestWins);
  initStatAward("killstreak_tag", 0, ::highestWins);
  initStatAward("killstreak_join", 0, ::highestWins);

  initStatAward("kills", 0, ::highestWins);
  initStatAward("longestkillstreak", 0, ::highestWins);
  initStatAward("knifekills", 0, ::highestWins);
  initStatAward("kdratio", 0, ::highestWins);
  initStatAward("deaths", 0, ::lowestWithHalfPlayedTime);
  initStatAward("assists", 0, ::highestWins);
  initStatAward("totalGameScore", 0, ::highestWins);
  initStatAward("scorePerMinute", 0, ::highestWins);
  initStatAward("mostScorePerLife", 0, ::highestWins);
  initStatAward("killStreaksUsed", 0, ::highestWins);

  initStatAward("humiliation", 0, ::highestWins);
  initStatAward("regicide", 0, ::highestWins);
  initStatAward("gunslinger", 0, ::highestWins);
  initStatAward("dejavu", 0, ::highestWins);
  initStatAward("levelup", 0, ::highestWins);

  initStatAward("omegaman", 0, ::highestWins);
  initStatAward("plague", 0, ::highestWins);
  initStatAward("patientzero", 0, ::highestWins);
  initStatAward("careless", 0, ::highestWins);
  initStatAward("survivor", 0, ::highestWins);
  initStatAward("contagious", 0, ::highestWins);

  initStatAward("flagscaptured", 0, ::highestWins);
  initStatAward("flagsreturned", 0, ::highestWins);
  initStatAward("flagcarrierkills", 0, ::highestWins);
  initStatAward("flagscarried", 0, ::highestWins);
  initStatAward("killsasflagcarrier", 0, ::highestWins);

  initStatAward("pointscaptured", 0, ::highestWins);
  initStatAward("kill_while_capture", 0, ::highestWins);
  initStatAward("opening_move", 0, ::highestWins);

  initStatAward("hp_secure", 0, ::highestWins);

  initStatAward("targetsdestroyed", 0, ::highestWins);
  initStatAward("bombsplanted", 0, ::highestWins);
  initStatAward("bombsdefused", 0, ::highestWins);
  initStatAward("ninja_defuse", 0, ::highestWins);
  initStatAward("last_man_defuse", 0, ::highestWins);
  initStatAward("elimination", 0, ::highestWins);
  initStatAward("last_man_standing", 0, ::highestWins);
  initStatAward("sr_tag_elimination", 0, ::highestWins);
  initStatAward("sr_tag_revive", 0, ::highestWins);

  initStatAward("killsconfirmed", 0, ::highestWins);
  initStatAward("killsdenied", 0, ::highestWins);
  initStatAward("kill_denied_retrieved", 0, ::highestWins);
  initStatAward("tag_collector", 0, ::highestWins);

  initStatAward("touchdown", 0, ::highestWins);
  initStatAward("fieldgoal", 0, ::highestWins);
  initStatAward("interception", 0, ::highestWins);
  initStatAward("kill_with_ball", 0, ::highestWins);
  initStatAward("ball_score_assist", 0, ::highestWins);
  initStatAward("pass_kill_pickup", 0, ::highestWins);
  initStatAward("killedBallCarrier", 0, ::highestWins);

  initStatAward("uav_destroyed", 0, ::highestWins);
  initStatAward("warbird_destroyed", 0, ::highestWins);
  initStatAward("paladin_destroyed", 0, ::highestWins);
  initStatAward("vulcan_destroyed", 0, ::highestWins);
  initStatAward("goliath_destroyed", 0, ::highestWins);
  initStatAward("missile_strike_destroyed", 0, ::highestWins);
  initStatAward("sentry_gun_destroyed", 0, ::highestWins);
  initStatAward("strafing_run_destroyed", 0, ::highestWins);
  initStatAward("assault_drone_destroyed", 0, ::highestWins);
  initStatAward("recon_drone_destroyed", 0, ::highestWins);
  initStatAward("map_killstreak_destroyed", 0, ::highestWins);
  initStatAward("assist_killstreak_destroyed", 0, ::highestWins);

  initStatAward("warbird_kill", 0, ::highestWins);
  initStatAward("paladin_kill", 0, ::highestWins);
  initStatAward("vulcan_kill", 0, ::highestWins);
  initStatAward("goliath_kill", 0, ::highestWins);
  initStatAward("airdrop_kill", 0, ::highestWins);
  initStatAward("airdrop_trap_kill", 0, ::highestWins);
  initStatAward("missile_strike_kill", 0, ::highestWins);
  initStatAward("sentry_gun_kill", 0, ::highestWins);
  initStatAward("strafing_run_kill", 0, ::highestWins);
  initStatAward("assault_drone_kill", 0, ::highestWins);
  initStatAward("map_killstreak_kill", 0, ::highestWins);
  initStatAward("coop_killstreak_kill", 0, ::highestWins);

  initStatAward("uav_earned", 0, ::highestWins);
  initStatAward("warbird_earned", 0, ::highestWins);
  initStatAward("orbitalsupport_earned", 0, ::highestWins);
  initStatAward("orbital_strike_laser_earned", 0, ::highestWins);
  initStatAward("orbital_carepackage_earned", 0, ::highestWins);
  initStatAward("heavy_exosuit_earned", 0, ::highestWins);
  initStatAward("missile_strike_earned", 0, ::highestWins);
  initStatAward("remote_mg_sentry_turret_earned", 0, ::highestWins);
  initStatAward("strafing_run_airstrike_earned", 0, ::highestWins);
  initStatAward("assault_ugv_earned", 0, ::highestWins);
  initStatAward("recon_ugv_earned", 0, ::highestWins);
  initStatAward("emp_earned", 0, ::highestWins);

  initStatAward("numMatchesRecorded", 0, ::highestWins);
}

initStatAward(ref, defaultvalue, process, var1, var2) {
  assert(isDefined(ref));

  level.awards[ref] = spawnStruct();
  level.awards[ref].defaultvalue = defaultvalue;

  if(isDefined(process)) {
    level.awards[ref].process = process;
  }

  if(isDefined(var1)) {
    level.awards[ref].var1 = var1;
  }

  if(isDefined(var2)) {
    level.awards[ref].var2 = var2;
  }
}

setPersonalBestIfGreater(ref) {
  recordValue = self getCommonPlayerData("bests", ref);
  playerValue = self getPlayerStat(ref);
  playerValue = getFormattedValue(ref, playerValue);

  if(recordValue == 0 || (playervalue > recordValue)) {
    self setCommonPlayerData("bests", ref, playerValue);
  }
}

setPersonalBestIfLower(ref) {
  recordvalue = self getCommonPlayerData("bests", ref);
  playervalue = self getPlayerStat(ref);
  playerValue = getFormattedValue(ref, playerValue);

  if(recordValue == 0 || (playervalue < recordvalue)) {
    self setCommonPlayerData("bests", ref, playerValue);
  }
}

calculateKD(player) {
  kills = player getPlayerStat("kills");
  deaths = player getPlayerStat("deaths");

  if(deaths == 0) {
    deaths = 1;
  }

  player setPlayerStat("kdratio", (kills / deaths));
}

getTotalScore(player) {
  totalScore = player.score;

  if(!level.teamBased) {
    totalScore = player.extrascore0;
  }

  return totalScore;
}

calculateSPM(player) {
  if(player.timePlayed["total"] < 1) {
    return;
  }

  totalScore = getTotalScore(player);
  secondsPlayed = player.timePlayed["total"];
  scorePerMinute = totalScore / (secondsPlayed / 60);

  player setPlayerStat("totalGameScore", totalScore);
  player setPlayerStat("scorePerMinute", scorePerMinute);
}

assignAwards() {
  foreach(player in level.players) {
    if(!player rankingEnabled()) {
      return;
    }

    player incPlayerStat("numMatchesRecorded", 1);

    calculateKD(player);
    calculateSPM(player);
  }

  foreach(ref, award in level.awards) {
    if(!isDefined(level.awards[ref].process)) {
      continue;
    }

    process = level.awards[ref].process;
    var1 = level.awards[ref].var1;
    var2 = level.awards[ref].var2;

    if(isDefined(var1) && isDefined(var2)) {
      [[process]](ref, var1, var2);
    } else if(isDefined(var1)) {
      [[process]](ref, var1);
    } else {
      [[process]](ref);
    }
  }

  if(CONST_PRINT_AWARDS) {
    printAwards();
  }

}

printAwards() {
  foreach(player in level.players) {
    if(IsAI(player)) {
      continue;
    }

    awardNames = GetArrayKeys(level.awards);

    for(i = 0; i < awardNames.size; i++) {
      value = player getCommonPlayerData("round", "awards", awardNames[i]);

      println("Awards: [", player.name, "][", awardNames[i], "]= ", value);
    }
  }
}

giveAward(ref) {
  value = self getPlayerStat(ref);
  value = getFormattedValue(ref, value);

  self setCommonPlayerData("round", "awards", ref, value);

  if(practiceRoundGame()) {
    return;
  }

  if(shouldAverageTotal(ref)) {
    numMatches = self getCommonPlayerData("awards", "numMatchesRecorded");
    oldAverage = self getCommonPlayerData("awards", ref);

    oldTotal = oldAverage * numMatches;
    newAverage = int((oldTotal + value) / (numMatches + 1));

    self setCommonPlayerData("awards", ref, newAverage);
  } else {
    recordValue = self getCommonPlayerData("awards", ref);
    self setCommonPlayerData("awards", ref, recordValue + value);
  }
}

shouldAverageTotal(ref) {
  switch (ref) {
    case "scorePerMinute":
    case "kdratio":
      return true;
  }

  return false;
}

getFormattedValue(ref, value) {
  awardFormat = tableLookup("mp/awardTable.csv", 1, ref, 5);
  switch (awardFormat) {
    case "float":
      value = limitDecimalPlaces(value, 2);
      value = value * 100;
      break;
    case "ratio":
    case "multi":
    case "count":
    case "time":
    case "distance":
    case "none":
    default:
      break;
  }

  value = int(value);
  return (value);
}

highestWins(ref, minAwardable) {
  foreach(player in level.players) {
    if(player rankingEnabled() && player statValueChanged(ref) && (!isDefined(minAwardable) || player getPlayerStat(ref) >= minAwardable)) {
      player giveAward(ref);
      player setPersonalBestIfGreater(ref);
    }
  }
}

lowestWins(ref, maxAwardable) {
  foreach(player in level.players) {
    if(player rankingEnabled() && player statValueChanged(ref) && (!isDefined(maxAwardable) || player getPlayerStat(ref) <= maxAwardable)) {
      player giveAward(ref);
      player setPersonalBestIfLower(ref);
    }
  }
}

lowestWithHalfPlayedTime(ref) {
  gameLength = getTimePassed() / 1000;
  halfGameLength = gameLength * 0.5;

  foreach(player in level.players) {
    if(player.hasSpawned && player.timePlayed["total"] >= halfGameLength) {
      player giveAward(ref);
      player setPersonalBestIfLower(ref);
    }
  }
}

statValueChanged(ref) {
  playervalue = self getPlayerStat(ref);
  defaultvalue = level.awards[ref].defaultvalue;

  if(playervalue == defaultvalue) {
    return false;
  } else {
    return true;
  }
}