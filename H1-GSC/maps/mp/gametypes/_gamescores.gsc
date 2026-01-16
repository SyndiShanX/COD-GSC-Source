/*********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\gametypes\_gamescores.gsc
*********************************************/

gethighestscoringplayer() {
  updateplacement();

  if(!level.placement["all"].size)
    return undefined;
  else
    return level.placement["all"][0];
}

gethighestscoringplayersarray(var_0) {
  var_1 = [];

  if(var_0 < 0)
    return var_1;

  updateplacement();

  for (var_2 = 0; var_2 < var_0; var_2++) {
    if(level.placement["all"].size == var_2) {
      break;
    }

    var_1[var_2] = level.placement["all"][var_2];
  }

  return var_1;
}

getlosingplayers() {
  updateplacement();
  var_0 = level.placement["all"];
  var_1 = [];

  foreach(var_3 in var_0) {
    if(var_3 == level.placement["all"][0]) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

updatescorestatsffa(var_0, var_1) {
  if(level.teambased) {
    return;
  }
  var_0 maps\mp\gametypes\_persistence::statsetchild("round", "score", var_0.extrascore0);
  var_0 maps\mp\gametypes\_persistence::statadd("score", var_1);
}

displaypoints(var_0) {
  if(!level.hardcoremode) {
    var_1 = maps\mp\gametypes\_rank::getscoreinfovalue(var_0);
    thread maps\mp\gametypes\_rank::xppointspopup(var_0, var_1);
  }
}

giveplayerscore(var_0, var_1, var_2) {
  if(isdefined(var_1.owner))
    var_1 = var_1.owner;

  if(!isplayer(var_1)) {
    return;
  }
  var_1 displaypoints(var_0);
  var_3 = var_1.pers["score"];
  onplayerscore(var_0, var_1, var_2);
  var_4 = var_1.pers["score"] - var_3;

  if(var_4 == 0) {
    return;
  }
  if(var_1.pers["score"] < 65535)
    var_1.score = var_1.pers["score"];

  if(level.teambased) {
    var_1 maps\mp\gametypes\_persistence::statsetchild("round", "score", var_1.score);
    var_1 maps\mp\gametypes\_persistence::statadd("score", var_4);
  }

  if(!level.teambased) {
    level thread sendupdateddmscores();
    var_1 maps\mp\gametypes\_gamelogic::checkplayerscorelimitsoon();
  }

  var_1 maps\mp\gametypes\_gamelogic::checkscorelimit();
}

onplayerscore(var_0, var_1, var_2) {
  var_3 = undefined;

  if(isdefined(level.onplayerscore))
    var_3 = [
      [level.onplayerscore]
    ](var_0, var_1, var_2);

  if(!isdefined(var_3))
    var_3 = maps\mp\gametypes\_rank::getscoreinfovalue(var_0);

  var_1.pers["score"] = var_1.pers["score"] + var_3 * level.objectivepointsmod;
}

_setplayerscore(var_0, var_1) {
  if(var_1 == var_0.pers["score"]) {
    return;
  }
  var_0.pers["score"] = var_1;
  var_0.score = int(min(var_0.pers["score"], 65535));
  var_0 thread maps\mp\gametypes\_gamelogic::checkscorelimit();
}

_getplayerscore(var_0) {
  return var_0.pers["score"];
}

giveteamscoreforobjective(var_0, var_1) {
  var_1 = var_1 * level.objectivepointsmod;
  _setteamscore(var_0, _getteamscore(var_0) + var_1);
  level notify("update_team_score", var_0, _getteamscore(var_0));
  thread giveteamscoreforobjectiveendofframe();
}

giveteamscoreforobjectiveendofframe() {
  level endon("update_team_score");
  level endon("game_ended");
  waittillframeend;
  var_0 = getwinningteam();

  if(!level.splitscreen && var_0 != "none" && var_0 != level.waswinning && gettime() - level.laststatustime > 5000 && maps\mp\_utility::getscorelimit() != 1) {
    level.laststatustime = gettime();
    maps\mp\_utility::leaderdialog("lead_taken", var_0, "status");

    if(level.waswinning != "none")
      maps\mp\_utility::leaderdialog("lead_lost", level.waswinning, "status");
  }

  if(var_0 != "none") {
    level.waswinning = var_0;
    var_1 = _getteamscore(var_0);
    var_2 = maps\mp\_utility::getwatcheddvar("scorelimit");

    if(var_1 == 0 || var_2 == 0) {
      return;
    }
    var_3 = var_1 / var_2 * 100;

    if(var_3 > level.scorepercentagecutoff)
      setnojipscore(1);
  }
}

getwinningteam() {
  var_0 = level.teamnamelist;
  var_1 = var_0[0];
  var_2 = game["teamScores"][var_0[0]];
  var_3 = 1;

  for (var_4 = 1; var_4 < var_0.size; var_4++) {
    if(game["teamScores"][var_0[var_4]] > var_2) {
      var_1 = var_0[var_4];
      var_2 = game["teamScores"][var_0[var_4]];
      var_3 = 1;
      continue;
    }

    if(game["teamScores"][var_0[var_4]] == var_2) {
      var_3 = var_3 + 1;
      var_1 = "none";
    }
  }

  return var_1;
}

_setteamscore(var_0, var_1) {
  if(var_1 == game["teamScores"][var_0]) {
    return;
  }
  game["teamScores"][var_0] = var_1;
  updateteamscore(var_0);

  if(maps\mp\_utility::inovertime() && !isdefined(level.overtimescorewinoverride) || isdefined(level.overtimescorewinoverride) && !level.overtimescorewinoverride)
    thread maps\mp\gametypes\_gamelogic::onscorelimit();
  else {
    thread maps\mp\gametypes\_gamelogic::checkteamscorelimitsoon(var_0);
    thread maps\mp\gametypes\_gamelogic::checkscorelimit();
  }
}

updateteamscore(var_0) {
  var_1 = 0;

  if(!maps\mp\_utility::isroundbased() || !maps\mp\_utility::isobjectivebased())
    var_1 = _getteamscore(var_0);
  else
    var_1 = game["roundsWon"][var_0];

  setteamscore(var_0, var_1);
}

_getteamscore(var_0) {
  return game["teamScores"][var_0];
}

sendupdatedteamscores() {
  level notify("updating_scores");
  level endon("updating_scores");
  wait 0.05;
  maps\mp\_utility::waittillslowprocessallowed();

  foreach(var_1 in level.players)
  var_1 updatescores();
}

sendupdateddmscores() {
  level notify("updating_dm_scores");
  level endon("updating_dm_scores");
  wait 0.05;
  maps\mp\_utility::waittillslowprocessallowed();

  for (var_0 = 0; var_0 < level.players.size; var_0++) {
    level.players[var_0] updatedmscores();
    level.players[var_0].updateddmscores = 1;
  }
}

removedisconnectedplayerfromplacement() {
  var_0 = 0;
  var_1 = level.placement["all"].size;
  var_2 = 0;

  for (var_3 = 0; var_3 < var_1; var_3++) {
    if(level.placement["all"][var_3] == self)
      var_2 = 1;

    if(var_2)
      level.placement["all"][var_3] = level.placement["all"][var_3 + 1];
  }

  if(!var_2) {
    return;
  }
  level.placement["all"][var_1 - 1] = undefined;

  if(level.multiteambased)
    mtdm_updateteamplacement();

  if(level.teambased) {
    updateteamplacement();
    return;
  }

  var_1 = level.placement["all"].size;

  for (var_3 = 0; var_3 < var_1; var_3++) {
    var_4 = level.placement["all"][var_3];
    var_4 notify("update_outcome");
  }
}

updateplacement() {
  var_0 = [];

  foreach(var_2 in level.players) {
    if(isdefined(var_2.connectedpostgame)) {
      continue;
    }
    if(var_2.pers["team"] == "spectator" || var_2.pers["team"] == "none") {
      continue;
    }
    var_0[var_0.size] = var_2;
  }

  for (var_4 = 1; var_4 < var_0.size; var_4++) {
    var_2 = var_0[var_4];
    var_5 = var_2.score;

    if(!level.teambased)
      var_5 = var_2.extrascore0;

    for (var_6 = var_4 - 1; var_6 >= 0 && getbetterplayer(var_2, var_0[var_6]) == var_2; var_6--)
      var_0[var_6 + 1] = var_0[var_6];

    var_0[var_6 + 1] = var_2;
  }

  level.placement["all"] = var_0;

  if(level.multiteambased)
    mtdm_updateteamplacement();
  else if(level.teambased)
    updateteamplacement();
}

getbetterplayer(var_0, var_1) {
  if(var_0.score > var_1.score)
    return var_0;

  if(var_1.score > var_0.score)
    return var_1;

  if(var_0.deaths < var_1.deaths)
    return var_0;

  if(var_1.deaths < var_0.deaths)
    return var_1;

  if(common_scripts\utility::cointoss())
    return var_0;
  else
    return var_1;
}

updateteamplacement() {
  var_0["allies"] = [];
  var_0["axis"] = [];
  var_0["spectator"] = [];
  var_1 = level.placement["all"];
  var_2 = var_1.size;

  for (var_3 = 0; var_3 < var_2; var_3++) {
    var_4 = var_1[var_3];
    var_5 = var_4.pers["team"];
    var_0[var_5][var_0[var_5].size] = var_4;
  }

  level.placement["allies"] = var_0["allies"];
  level.placement["axis"] = var_0["axis"];
}

mtdm_updateteamplacement() {
  var_0["spectator"] = [];

  foreach(var_2 in level.teamnamelist)
  var_0[var_2] = [];

  var_4 = level.placement["all"];
  var_5 = var_4.size;

  for (var_6 = 0; var_6 < var_5; var_6++) {
    var_7 = var_4[var_6];
    var_8 = var_7.pers["team"];
    var_0[var_8][var_0[var_8].size] = var_7;
  }

  foreach(var_2 in level.teamnamelist)
  level.placement[var_2] = var_0[var_2];
}

initialdmscoreupdate() {
  wait 0.2;
  var_0 = 0;

  for (;;) {
    var_1 = 0;
    var_2 = level.players;

    for (var_3 = 0; var_3 < var_2.size; var_3++) {
      var_4 = var_2[var_3];

      if(!isdefined(var_4)) {
        continue;
      }
      if(isdefined(var_4.updateddmscores)) {
        continue;
      }
      var_4.updateddmscores = 1;
      var_4 updatedmscores();
      var_1 = 1;
      wait 0.5;
    }

    if(!var_1)
      wait 3;
  }
}