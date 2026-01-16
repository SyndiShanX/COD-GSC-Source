/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\_awards.gsc
********************************/

init() {
  initawards();
  level thread onplayerconnect();
}

checkforlevelprogressionchallenges() {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("spawned_player");
  maps\mp\_utility::gameflagwait("prematch_done");
  var_0 = undefined;

  while (!isdefined(var_0)) {
    if(!isdefined(self)) {
      return;
    }
    if(maps\mp\_utility::invirtuallobby()) {
      return;
    }
    var_0 = self.pers["rank"];
    wait 0.2;
  }

  var_1 = int((var_0 + 1) / 50);

  if(var_1 > 1) {
    for (var_2 = var_1; var_2 > 1; var_2--) {
      var_3 = var_2 * 50;
      var_4 = "ch_" + var_3 + "_paragon";
      var_5 = self.challengedata[var_4];

      if(isdefined(var_5) && var_5 == 1)
        maps\mp\gametypes\_missions::processchallenge(var_4);
    }
  }
}

onplayerconnect() {
  for (;;) {
    level waittill("connected", var_0);

    if(!isdefined(var_0.pers["stats"]))
      var_0.pers["stats"] = [];

    var_0.stats = var_0.pers["stats"];

    if(!var_0.stats.size) {
      foreach(var_3, var_2 in level.awards)
      var_0 maps\mp\_utility::initplayerstat(var_3, level.awards[var_3].defaultvalue);
    }

    var_0.recentawards[0] = "none";
    var_0.recentawards[1] = "none";
    var_0.recentawards[2] = "none";

    if(!maps\mp\_utility::invirtuallobby())
      var_0 thread checkforlevelprogressionchallenges();
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
  initstataward("doublekill", 0, ::highestwins);
  initstataward("triplekill", 0, ::highestwins);
  initstataward("fourkill", 0, ::highestwins);
  initstataward("fivekill", 0, ::highestwins);
  initstataward("sixkill", 0, ::highestwins);
  initstataward("sevenkill", 0, ::highestwins);
  initstataward("eightkill", 0, ::highestwins);
  initstataward("backstab", 0, ::highestwins);
  initstataward("killstreak5", 0, ::highestwins);
  initstataward("killstreak10", 0, ::highestwins);
  initstataward("killstreak15", 0, ::highestwins);
  initstataward("killstreak20", 0, ::highestwins);
  initstataward("killstreak25", 0, ::highestwins);
  initstataward("killstreak30", 0, ::highestwins);
  initstataward("killstreak30plus", 0, ::highestwins);
  initstataward("pointblank", 0, ::highestwins);
  initstataward("firstplacekill", 0, ::highestwins);
  initstataward("assault", 0, ::highestwins);
  initstataward("defends", 0, ::highestwins);
  initstataward("near_death_kill", 0, ::highestwins);
  initstataward("flash_kill", 0, ::highestwins);
  initstataward("multiKillOneBullet", 0, ::highestwins);
  initstataward("think_fast", 0, ::highestwins);
  initstataward("take_and_kill", 0, ::highestwins);
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
  initstataward("airstrike_mp_kill", 0, ::highestwins);
  initstataward("helicopter_mp_kill", 0, ::highestwins);
  initstataward("humiliation", 0, ::highestwins);
  initstataward("regicide", 0, ::highestwins);
  initstataward("gunslinger", 0, ::highestwins);
  initstataward("dejavu", 0, ::highestwins);
  initstataward("levelup", 0, ::highestwins);
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
  initstataward("killsconfirmed", 0, ::highestwins);
  initstataward("killsdenied", 0, ::highestwins);
  initstataward("kill_denied_retrieved", 0, ::highestwins);
  initstataward("tag_collector", 0, ::highestwins);
  initstataward("hqsdestroyed", 0, ::highestwins);
  initstataward("hqscaptured", 0, ::highestwins);
  initstataward("banked", 0, ::highestwins);
  initstataward("muggings", 0, ::highestwins);
  initstataward("helicopter_destroyed", 0, ::highestwins);
  initstataward("assist_killstreak_destroyed", 0, ::highestwins);
  initstataward("radar_mp_earned", 0, ::highestwins);
  initstataward("airstrike_mp_earned", 0, ::highestwins);
  initstataward("helicopter_mp_earned", 0, ::highestwins);
  initstataward("numMatchesRecorded", 0, ::highestwins);
}

initstataward(var_0, var_1, var_2, var_3, var_4) {
  level.awards[var_0] = spawnstruct();
  level.awards[var_0].defaultvalue = var_1;

  if(isdefined(var_2))
    level.awards[var_0].process = var_2;

  if(isdefined(var_3))
    level.awards[var_0].var1 = var_3;

  if(isdefined(var_4))
    level.awards[var_0].var2 = var_4;
}

setpersonalbestifgreater(var_0) {
  var_1 = self getplayerdata(common_scripts\utility::getstatsgroup_common(), "bests", var_0);
  var_2 = maps\mp\_utility::getplayerstat(var_0);
  var_2 = getformattedvalue(var_0, var_2);

  if(var_1 == 0 || var_2 > var_1)
    self setplayerdata(common_scripts\utility::getstatsgroup_common(), "bests", var_0, var_2);
}

setpersonalbestiflower(var_0) {
  var_1 = self getplayerdata(common_scripts\utility::getstatsgroup_common(), "bests", var_0);
  var_2 = maps\mp\_utility::getplayerstat(var_0);
  var_2 = getformattedvalue(var_0, var_2);

  if(var_1 == 0 || var_2 < var_1)
    self setplayerdata(common_scripts\utility::getstatsgroup_common(), "bests", var_0, var_2);
}

calculatekd(var_0) {
  var_1 = var_0 maps\mp\_utility::getplayerstat("kills");
  var_2 = var_0 maps\mp\_utility::getplayerstat("deaths");

  if(var_2 == 0)
    var_2 = 1;

  var_0 maps\mp\_utility::setplayerstat("kdratio", var_1 / var_2);
}

gettotalscore(var_0) {
  var_1 = var_0.score;

  if(!level.teambased)
    var_1 = var_0.extrascore0;

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
    if(!isdefined(level.awards[var_8].process)) {
      continue;
    }
    var_5 = level.awards[var_8].process;
    var_6 = level.awards[var_8].var1;
    var_7 = level.awards[var_8].var2;

    if(isdefined(var_6) && isdefined(var_7)) {
      [
        [var_5]
      ](var_8, var_6, var_7);
      continue;
    }

    if(isdefined(var_6)) {
      [
        [var_5]
      ](var_8, var_6);
      continue;
    }

    [
      [var_5]
    ](var_8);
  }
}

giveaward(var_0) {
  var_1 = maps\mp\_utility::getplayerstat(var_0);
  var_1 = getformattedvalue(var_0, var_1);
  self setplayerdata(common_scripts\utility::getstatsgroup_common(), "round", "awards", var_0, var_1);

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

  var_7 = 0;

  for (var_8 = 0; var_8 < 3; var_8++) {
    if(self.recentawards[var_8] == var_0)
      var_7 = 1;
  }

  var_9 = int(tablelookup("mp\awardTable.csv", 1, var_0, 0));

  if(var_7 == 0 && isdefined(var_9) && var_9 == 1 && var_1 != 0) {
    self.recentawards[2] = self.recentawards[1];
    self.recentawards[1] = self.recentawards[0];
    self.recentawards[0] = var_0;
    self setplayerdata(common_scripts\utility::getstatsgroup_common(), "recentAwards", 0, self.recentawards[0]);
    self setplayerdata(common_scripts\utility::getstatsgroup_common(), "recentAwards", 1, self.recentawards[1]);
    self setplayerdata(common_scripts\utility::getstatsgroup_common(), "recentAwards", 2, self.recentawards[2]);
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
  var_2 = tablelookup("mp\awardTable.csv", 1, var_0, 5);

  switch (var_2) {
    case "float":
      var_1 = maps\mp\_utility::limitdecimalplaces(var_1, 2);
      var_1 = var_1 * 100;
      break;
    case "ratio":
    case "multi":
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

highestwins(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(var_3 maps\mp\_utility::rankingenabled() && var_3 statvaluechanged(var_0) && (!isdefined(var_1) || var_3 maps\mp\_utility::getplayerstat(var_0) >= var_1)) {
      var_3 giveaward(var_0);
      var_3 setpersonalbestifgreater(var_0);
    }
  }
}

lowestwins(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(var_3 maps\mp\_utility::rankingenabled() && var_3 statvaluechanged(var_0) && (!isdefined(var_1) || var_3 maps\mp\_utility::getplayerstat(var_0) <= var_1)) {
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

  if(var_1 == var_2)
    return 0;
  else
    return 1;
}