/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gamescore.gsc
***********************************************/

function gethighestscoringteam() {
  var_0 = 0;
  var_1 = undefined;
  var_2 = 0;

  foreach(var_4 in level.teamnamelist) {
    var_5 = game["teamScores"][var_4];

    if(!isDefined(var_1) || var_5 > var_0) {
      var_0 = var_5;
      var_1 = var_4;
      var_2 = 0;
      continue;
    }

    if(var_5 == var_0) {
      var_2 = 1;
    }
  }

  if(var_2) {
    return "tie";
  }

  return var_1;
}

function remove_hunter_class(var_0) {
  var_1 = 0;
  var_2 = undefined;

  foreach(var_4 in level.teamnamelist) {
    if(isDefined(var_0) && var_4 == var_0) {
      continue;
    }

    var_5 = game["teamScores"][var_4];

    if(!isDefined(var_2) || var_5 > var_1) {
      var_1 = var_5;
      var_2 = var_4;
    }
  }

  return [var_2, game["teamScores"][var_2]];
}

function ref_14026() {
  level notify("updateTeamScorePlacement");
  level endon("updateTeamScorePlacement");
  waittillframeend();
  var_0 = setteamplacement(game["teamScores"], "down");
  var_1 = undefined;
  var_2 = 0;

  foreach(var_4 in var_0) {
    var_5 = game["teamScores"][var_4];

    if(!isDefined(var_1) || var_5 < var_1) {
      var_1 = var_5;
      var_2++;
    }

    game["teamPlacements"][var_4] = var_2;
  }
}

function run_common_functions_stealth() {
  return game["teamPlacements"];
}

function hidesafecircle(var_0, var_1) {
  return var_0.score > var_1.score;
}

function gethighestscoringplayer() {
  updateplacement();

  if(!level.placement["all"].size) {
    return undefined;
  }

  return level.placement["all"][0];
}

function ishighestscoringplayertied() {
  if(level.placement["all"].size > 1) {
    var_0 = _getplayerscore(level.placement["all"][0]);
    var_1 = _getplayerscore(level.placement["all"][1]);
    return (var_0 == var_1);
  }

  return false;
}

function getlosingplayers() {
  updateplacement();
  var_0 = level.placement["all"];
  var_1 = [];

  foreach(var_3 in var_0) {
    if(var_3 == level.placement["all"][0]) {
      continue;
    }

    var_1 = var_3;
  }

  return var_1;
}

function giveplayerscore(var_0, var_1, var_2) {
  if(istrue(level.ignorescoring) && !issubstr(var_0, "assist")) {
    var_3 = scripts\mp\utility\game::getgametype() == "br" && !scripts\mp\flags::gameflag("prematch_done");

    if(!var_3) {
      return;
    }
  }

  if(!level.teambased) {
    foreach(var_5 in level.players) {
      if(scripts\mp\utility\game::issimultaneouskillenabled()) {
        if(var_5 != self) {
          continue;
        }

        if(level.roundscorelimit > 1 && var_5.pers["score"] >= level.roundscorelimit) {
          return;
        }

        continue;
      }

      if(level.roundscorelimit > 1 && var_5.pers["score"] >= level.roundscorelimit) {
        return;
      }
    }
  }

  var_5 = self;

  if(isDefined(self.owner) && !isbot(self)) {
    var_5 = self.owner;
  }

  if(!isPlayer(var_5)) {
    return;
  }

  var_7 = var_1;

  if(isDefined(level.onplayerscore)) {
    var_1 = [[level.onplayerscore]](var_0, var_5, var_1, var_2);
  }

  if(var_1 == 0) {
    return;
  }

  var_5.pers["score"] = int(max(var_5.pers["score"] + var_1, 0));
  var_5 scripts\mp\playerstats_interface::addtoplayerstat(int(var_7), "matchStats", "score");

  if(var_5.pers["score"] >= 65000) {
    var_5.pers["score"] = 65000;
  }

  var_5.score = var_5.pers["score"];
  var_8 = var_5.score;
  var_5 scripts\mp\persistence::statsetchild("round", "score", var_8);
  var_5 scripts\mp\gamelogic::checkplayerscorelimitsoon();
  var_5 thread scripts\mp\gamelogic::checkscorelimit();
  var_5 scripts\mp\utility\script::bufferednotify("earned_score_buffered", var_1);
  scripts\mp\analyticslog::logevent_reportgamescore(var_1, gettime(), scripts\mp\rank::getscoreinfocategory(var_0, "eventID"));
  var_5 scripts\common\utility::ref_13e0a(level.ref_11b2f, var_0);
  var_5 scripts\cp_mp\pet_watch::addobjectivescorecharge(var_0, int(var_7));
}

function _setplayerscore(var_0, var_1) {
  if(var_1 == var_0.pers["score"]) {
    return;
  }

  if(var_1 < 0) {
    return;
  }

  var_0.pers["score"] = var_1;
  var_0.score = var_0.pers["score"];
  var_0 thread scripts\mp\gamelogic::checkscorelimit();
}

function _getplayerscore(var_0) {
  if(!isDefined(var_0)) {
    var_0 = self;
  }

  return var_0.pers["score"];
}

function checkffascorejip() {
  if(level.roundscorelimit > 0) {
    var_0 = self.score / level.roundscorelimit * 100;

    if(var_0 > level.scorepercentagecutoff) {
      setnojipscore(1, 1);
      level.nojip = 1;
      return;
    }

    return;
  }
}

function giveteamscoreforobjective(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(scripts\mp\utility\game::cantiebysimultaneouskill()) {
    var_2 = 1;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(istrue(level.gameended) && !var_2) {
    return;
  }

  if(istrue(level.ignorescoring)) {
    return;
  }

  if(istrue(level.dontendonscore) && _getteamscore(var_0) >= level.scorelimit) {
    return;
  }

  if(var_2) {
    if(level.roundscorelimit > 1 && game["teamScores"][var_0] >= level.roundscorelimit) {
      return;
    }
  } else if(level.roundscorelimit > 1 && !istrue(level.dontendonscore)) {
    foreach(var_7 in level.teamnamelist) {
      if(level scripts\mp\utility\game::vehicle_collision_ignorefuturemultievent(var_7)) {
        continue;
      }

      if(game["teamScores"][var_7] >= level.roundscorelimit) {
        return;
      }
    }
  }

  _setteamscore(var_0, _getteamscore(var_0) + var_1, var_2);
  level notify("update_team_score", var_0, _getteamscore(var_0));

  if(isDefined(level.onteamscore)) {
    [[level.onteamscore]](var_0, _getteamscore(var_0), var_3);
  }

  if(isDefined(var_5)) {
    var_9 = var_5;
  } else {
    var_9 = freight_lift_door_switch(var_3);
  }

  if(!istrue(var_5)) {
    ref_12762(var_9, var_3, level.waswinning);
  }

  if(var_9 != "none") {
    level.waswinning = var_9;
    var_10 = _getteamscore(var_9);
    var_11 = level.roundscorelimit;

    if(var_10 == 0 || var_11 == 0) {
      return;
    }

    var_12 = var_10 / var_11 * 100;

    if(!scripts\mp\utility\game::isroundbased() && isDefined(level.nojip) && !level.nojip) {
      if(var_12 > level.scorepercentagecutoff) {
        setnojipscore(1, 1);
        level.nojip = 1;
      }
    }
  }

  if(!level.onlinegame) {
    ref_119c1();
    return;
  }
}

function ref_12762(var_0, var_1, var_2) {
  if(!level.splitscreen && var_0 != "none" && var_0 != var_2 && gettime() - level.lastscorestatustime > 5000 && scripts\mp\utility\game::getscorelimit() != 1) {
    if(isDefined(level.delayleadtakendialog)) {
      thread playleadtakendialog(level);
      return;
    }

    level.lastscorestatustime = gettime();
    scripts\mp\utility\dialog::leaderdialog("lead_taken", var_0, "status");

    if(var_2 != "none") {
      scripts\mp\utility\dialog::leaderdialog("lead_lost", var_2, "status");
      return;
    }

    return;
  }
}

function playleadtakendialog(var_0) {
  wait level.delayleadtakendialog;
  level.lastscorestatustime = gettime();
  var_1 = freight_lift_door_switch(var_0);
  scripts\mp\utility\dialog::leaderdialog("lead_taken", var_1, "status");

  foreach(var_3 in level.teamnamelist) {
    if(var_3 != var_1) {
      scripts\mp\utility\dialog::leaderdialog("lead_lost", var_3, "status");
    }
  }
}

function freight_lift_door_switch(var_0) {
  var_1 = level.teamnamelist;

  if(!isDefined(level.waswinning)) {
    level.waswinning = "none";
  }

  var_2 = "none";
  var_3 = 0;

  if(level.waswinning != "none") {
    var_2 = level.waswinning;
    var_3 = game["teamScores"][level.waswinning];
  }

  var_4 = 1;

  foreach(var_6 in var_1) {
    if(var_6 == level.waswinning) {
      continue;
    }

    if(game["teamScores"][var_6] > var_3) {
      var_2 = var_6;
      var_3 = game["teamScores"][var_6];
      var_4 = 1;
      continue;
    }

    if(game["teamScores"][var_6] == var_3) {
      var_4 += 1;
      var_2 = "none";
    }
  }

  return var_2;
}

function _setteamscore(var_0, var_1, var_2) {
  if(var_1 < 0) {
    var_1 = 0;
  }

  if(var_1 == game["teamScores"][var_0]) {
    return;
  }

  game["teamScores"][var_0] = var_1;
  updateteamscore(var_0);

  if(!istrue(level.dontendonscore)) {
    thread scripts\mp\gamelogic::roundend_checkscorelimit(var_0, var_2);
    return;
  }
}

function updateteamscore(var_0) {
  if(scripts\mp\utility\game::vehicle_collision_ignorefuturemultievent(var_0)) {
    return;
  }

  var_1 = 0;

  if(!scripts\mp\utility\game::isroundbased() || !scripts\mp\utility\game::isobjectivebased() || scripts\mp\utility\game::ismoddedroundgame()) {
    var_1 = _getteamscore(var_0);
  } else {
    var_1 = game["roundsWon"][var_0];
  }

  setteamscore(var_0, int(var_1));
  thread ref_14026();
}

function updatetotalteamscore(var_0) {
  if(!isDefined(game["totalScore"])) {
    game["totalScore"] = [];

    foreach(var_2 in level.teamnamelist) {
      game["totalScore"][var_2] = 0;
    }
  }

  var_4 = scripts\mp\utility\game::getwingamebytype();

  switch (var_4) {
    case "roundsWon":
      game["teamScores"][var_0] = game["roundsWon"][var_0];
      break;
    case "teamScores":
      if(scripts\mp\utility\game::inovertime()) {
        game["teamScores"][var_0] = game["preOvertimeScore"][var_0] + game["overtimeScore"][var_0] + game["teamScores"][var_0];
      } else if(scripts\mp\utility\game::resetscoreonroundstart()) {
        game["totalScore"][var_0] = game["totalScore"][var_0] + game["teamScores"][var_0];
        game["teamScores"][var_0] = game["totalScore"][var_0];
      }

      break;
  }

  setteamscore(var_0, int(game["teamScores"][var_0]));
}

function updateovertimescore() {
  if(game["overtimeRoundsPlayed"] == 0) {
    if(!isDefined(game["preOvertimeScore"])) {
      game["preOvertimeScore"] = [];

      foreach(var_1 in level.teamnamelist) {
        game["preOvertimeScore"][var_1] = 0;
      }
    }

    foreach(var_1 in level.teamnamelist) {
      game["preOvertimeScore"][var_1] = game["teamScores"][var_1] + game["totalScore"][var_1];
    }
  }

  if(!isDefined(game["overtimeScore"])) {
    game["overtimeScore"] = [];

    foreach(var_1 in level.teamnamelist) {
      game["overtimeScore"][var_1] = 0;
    }
  }

  foreach(var_1 in level.teamnamelist) {
    game["overtimeScore"][var_1] = game["overtimeScore"][var_1] + game["teamScores"][var_1] - game["preOvertimeScore"][var_1];
  }

  if(!scripts\mp\utility\game::iswinbytworulegametype()) {
    game["teamScores"][game["attackers"]] = 0;
    setteamscore(game["attackers"], 0);
    game["teamScores"][game["defenders"]] = 0;
    setteamscore(game["defenders"], 0);

    if(scripts\mp\utility\game::istimetobeatvalid() && game["timeToBeatTeam"] == game["attackers"]) {
      game["teamScores"][game["attackers"]] = game["timeToBeatScore"];
      updateteamscore(game["attackers"]);
      game["overtimeScore"][game["attackers"]] = game["overtimeScore"][game["attackers"]] - game["timeToBeatScore"];
    }

    if(scripts\mp\utility\game::istimetobeatvalid() && game["timeToBeatTeam"] == game["defenders"]) {
      game["teamScores"][game["defenders"]] = game["timeToBeatScore"];
      updateteamscore(game["defenders"]);
      game["overtimeScore"][game["defenders"]] = game["overtimeScore"][game["defenders"]] - game["timeToBeatScore"];
      return;
    }

    return;
  }
}

function _getteamscore(var_0) {
  return int(game["teamScores"][var_0]);
}

function removedisconnectedplayerfromplacement() {
  if(!isDefined(level.placement) || !isDefined(level.placement["all"])) {
    return;
  }

  var_0 = 0;
  var_1 = level.placement["all"].size;
  var_2 = 0;

  for(var_3 = 0; var_3 < var_1; var_3++) {
    if(level.placement["all"][var_3] == self) {
      var_2 = 1;
    }

    if(var_2) {
      level.placement["all"][var_3] = level.placement["all"][var_3 + 1];
    }
  }

  if(!var_2) {
    return;
  }

  level.placement["all"][var_1 - 1] = undefined;

  if(level.teambased) {
    updateteamplacement();
    return;
  }
}

function updateplacement() {
  var_0 = [];

  foreach(var_2 in level.players) {
    if(isDefined(var_2.connectedpostgame)) {
      continue;
    }

    if(var_2.pers["team"] == "spectator" || var_2.pers["team"] == "follower" || var_2.pers["team"] == "none") {
      continue;
    }

    var_0 = var_2;
  }

  for(var_4 = 1; var_4 < var_0.size; var_4++) {
    var_2 = var_0[var_4];
    var_5 = var_2.score;

    for(var_6 = var_4 - 1; var_6 >= 0 && getbetterplayer(var_2, var_0[var_6]) == var_2; var_6--) {
      var_0 = var_0[var_6];
    }

    var_0 = var_2;
  }

  level.placement["all"] = var_0;

  if(level.teambased) {
    updateteamplacement();
    return;
  }
}

function getbetterplayer(var_0, var_1) {
  if(isDefined(level.lastplayerwins)) {
    return level.lastplayerwins;
  }

  if(var_0.score > var_1.score) {
    return var_0;
  }

  if(var_1.score > var_0.score) {
    return var_1;
  }

  if(var_0.deaths < var_1.deaths) {
    return var_0;
  }

  if(var_1.deaths < var_0.deaths) {
    return var_1;
  }

  if(scripts\engine\utility::cointoss()) {
    return var_0;
  }

  return var_1;
}

function updateteamplacement() {
  var_0 = level.placement["all"];
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = var_3.pers["team"];

    if(!isDefined(var_1[var_4])) {
      var_1 = [];
    }

    var_1[var_1[var_4].size] = var_3;
  }

  foreach(var_7 in level.teamnamelist) {
    if(isDefined(var_1[var_7])) {
      level.placement[var_7] = var_1[var_7];
      continue;
    }

    level.placement[var_7] = [];
  }
}

function processassist(var_0, var_1, var_2) {
  if(isDefined(level.assists_disabled)) {
    return;
  }

  processassist_regularmp(var_0, var_1, var_2);
}

function processassist_regularmp(var_0, var_1, var_2) {
  self endon("disconnect");
  var_0 endon("disconnect");

  if(isDefined(var_1) && var_1.basename == "white_phosphorus_proj_mp") {
    return;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;

  if(isDefined(var_0.ismarkedtarget)) {
    var_4 = var_0.attackers;
    var_3 = 1;
  }

  if(isDefined(var_0.markedbyboomperk)) {
    var_5 = var_0.markedbyboomperk;
  }

  wait 0.05;
  scripts\mp\utility\script::waittillslowprocessallowed();
  var_6 = self.pers["team"];

  if(!scripts\mp\utility\teams::isgameplayteam(var_6)) {
    return;
  }

  if(var_6 == var_0.pers["team"] && level.teambased) {
    return;
  }

  var_7 = undefined;
  var_8 = "assist";

  if(!level.teambased) {
    var_8 = "assist_ffa";
  }

  var_9 = scripts\mp\rank::getscoreinfovalue(var_8);

  if(!level.teambased) {
    var_7 = var_9 + var_9 * var_2;
    thread scripts\mp\utility\points::giveunifiedpoints("assist_ffa", var_1, var_7);
  } else if(isDefined(var_5) && scripts\engine\utility::array_contains_key(var_5, scripts\mp\utility\player::getuniqueid())) {
    thread scripts\mp\utility\points::givestreakpointswithtext("assist_ping", var_1, undefined);
  } else {
    var_7 = var_9 + var_9 * var_2;
    thread scripts\mp\utility\points::giveunifiedpoints("assist", var_1, var_7);
  }

  if(level.teambased) {
    var_10 = scripts\common\utility::playersinsphere(self.origin, 300);

    foreach(var_12 in var_10) {
      if(self.team != var_12.team || self == var_12) {
        continue;
      }

      if(!scripts\mp\utility\player::isreallyalive(var_12)) {
        continue;
      }

      self.modifiers["buddy_kill"] = 1;
      break;
    }
  }

  if(scripts\mp\utility\perk::_hasperk("specialty_hardline") && isDefined(self.hardlineactive)) {
    if(self.hardlineactive["assists"] == 1) {
      if(!scripts\mp\utility\weapon::iskillstreakweapon(var_1) && !scripts\mp\utility\weapon::issuperweapon(var_1)) {
        thread scripts\mp\utility\points::givestreakpointswithtext("assist_hardline", var_1, 1);
      }
    }

    self notify("assist_hardline");
  }

  scripts\mp\playerstats_interface::addtoplayerstat(1, "combatStats", "assists");

  if(isDefined(self.pers["assists"]) && self.pers["assists"] < 998) {
    scripts\mp\utility\stats::incpersstat("assists", 1);
    self.assists = scripts\mp\utility\stats::getpersstat("assists");
    scripts\mp\persistence::statsetchild("round", "assists", self.assists);
  }

  scripts\mp\utility\script::bufferednotify("assist_buffered", self.modifiers);
  thread scripts\cp\vehicles\vehicle_compass_cp::onplayerkillassist(var_0);
}

function processshieldassist(var_0) {
  if(isDefined(level.assists_disabled)) {
    return;
  }

  processshieldassist_regularmp(var_0);
}

function processshieldassist_regularmp(var_0) {
  self endon("disconnect");
  var_0 endon("disconnect");
  wait 0.05;
  scripts\mp\utility\script::waittillslowprocessallowed();

  if(!scripts\mp\utility\teams::isgameplayteam(self.pers["team"])) {
    return;
  }

  if(self.pers["team"] == var_0.pers["team"]) {
    return;
  }

  thread scripts\mp\utility\points::giveunifiedpoints("shield_assist");
  scripts\mp\playerstats_interface::addtoplayerstat(1, "combatStats", "assists");

  if(self.pers["assists"] < 998) {
    scripts\mp\utility\stats::incpersstat("assists", 1);
    self.assists = scripts\mp\utility\stats::getpersstat("assists");
    scripts\mp\persistence::statsetchild("round", "assists", self.assists);
  }

  thread scripts\cp\vehicles\vehicle_compass_cp::onplayerkillassist(var_0);
}

function initassisttrackers() {
  self notify("initAssistTrackers");
  self.buffedbyplayers = [];
  self.debuffedbyplayers = [];
}

function trackdebuffassist(var_0, var_1, var_2) {
  if(!isDefined(var_1.debuffedbyplayers[var_2])) {
    var_1.debuffedbyplayers[var_2] = [];
  }

  if(scripts\mp\utility\game::lpcfeaturegated() && var_1.debuffedbyplayers[var_2].size >= getdvarint("scr_br_maxTrackedBuffs", 4) && getdvarint("scr_br_maxTrackedBuffs", 4) > 0) {
    return false;
  }

  if(!isDefined(var_1.debuffedbyplayers[var_2][var_0 getentitynumber()])) {
    var_1.debuffedbyplayers[var_2][var_0 getentitynumber()] = 0;
  }

  var_1.debuffedbyplayers[var_2][var_0 getentitynumber()]++;
  return true;
}

function untrackdebuffassist(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    if(isDefined(var_1.debuffedbyplayers[var_2]) && isDefined(var_1.debuffedbyplayers[var_2][var_0 getentitynumber()])) {
      var_1.debuffedbyplayers[var_2][var_0 getentitynumber()]--;

      if(var_1.debuffedbyplayers[var_2][var_0 getentitynumber()] <= 0) {
        var_1.debuffedbyplayers[var_2][var_0 getentitynumber()] = undefined;
      }

      var_3 = 1;

      foreach(var_5 in var_1.debuffedbyplayers[var_2]) {
        if(var_5 > 0) {
          var_3 = 0;
          break;
        }
      }

      if(var_3 && isDefined(var_2) && isDefined(var_1.debuffedbyplayers)) {
        var_1.debuffedbyplayers[var_2] = undefined;
        return;
      }

      return;
    }

    return;
  }
}

function trackdebuffassistfortime(var_0, var_1, var_2, var_3, var_4) {
  var_1 endon("initAssistTrackers");
  var_1 endon("disconnect");
  var_0 endon("disconnect");
  level endon("game_ended");
  var_5 = trackdebuffassist(var_0, var_1, var_2);

  if(!var_5) {
    return;
  }

  if(isDefined(var_4) && isstring(var_4)) {
    var_1 scripts\engine\utility::waittill_notify_or_timeout(var_4, var_3);
  } else {
    wait var_3;
  }

  untrackdebuffassist(var_0, var_1, var_2);
}

function isdebuffedbyweapon(var_0, var_1) {
  if(scripts\mp\utility\game::runleanthreadmode()) {
    return false;
  }

  if(isDefined(var_0.debuffedbyplayers[var_1])) {
    foreach(var_3 in var_0.debuffedbyplayers[var_1]) {
      if(var_3 <= 0) {
        continue;
      }

      if(!isDefined(level.playersbyentitynumber[var_4])) {
        continue;
      }

      return true;
    }
  }

  return false;
}

function isdebuffedbyweaponandplayer(var_0, var_1, var_2) {
  if(scripts\mp\utility\game::runleanthreadmode()) {
    return false;
  }

  if(!isDefined(var_1.debuffedbyplayers[var_2])) {
    return false;
  }

  if(!isDefined(var_1.debuffedbyplayers[var_2][var_0 getentitynumber()])) {
    return false;
  }

  if(var_1.debuffedbyplayers[var_2][var_0 getentitynumber()] <= 0) {
    return false;
  }

  return true;
}

function getdebuffattackersbyweapon(var_0, var_1) {
  if(scripts\mp\utility\game::runleanthreadmode()) {
    return undefined;
  }

  var_2 = [];

  if(isPlayer(var_0)) {
    if(isDefined(var_0.debuffedbyplayers[var_1])) {
      foreach(var_4 in var_0.debuffedbyplayers[var_1]) {
        if(var_4 <= 0) {
          continue;
        }

        if(!isDefined(level.playersbyentitynumber[var_5])) {
          continue;
        }

        var_2 = level.playersbyentitynumber[var_5];
      }
    }
  }

  return var_2;
}

function trackbuffassist(var_0, var_1, var_2) {
  if(scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }

  if(var_0 != var_1) {
    if(!isDefined(var_1.buffedbyplayers[var_2])) {
      var_1.buffedbyplayers[var_2] = [];
    }

    if(scripts\mp\utility\game::lpcfeaturegated() && var_1.buffedbyplayers[var_2].size >= getdvarint("scr_br_maxTrackedBuffs", 4) && getdvarint("scr_br_maxTrackedBuffs", 4) > 0) {
      return 0;
    }

    if(!isDefined(var_1.buffedbyplayers[var_2][var_0 getentitynumber()])) {
      var_1.buffedbyplayers[var_2][var_0 getentitynumber()] = 0;
    }

    var_1.buffedbyplayers[var_2][var_0 getentitynumber()]++;
    return 1;
  }
}

function untrackbuffassist(var_0, var_1, var_2) {
  if(scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }

  if(isDefined(var_1)) {
    if(isDefined(var_1.buffedbyplayers[var_2]) && isDefined(var_1.buffedbyplayers[var_2][var_0 getentitynumber()])) {
      var_1.buffedbyplayers[var_2][var_0 getentitynumber()]--;

      if(var_1.buffedbyplayers[var_2][var_0 getentitynumber()] <= 0) {
        var_1.buffedbyplayers[var_2][var_0 getentitynumber()] = undefined;
        return;
      }

      return;
    }

    return;
  }
}

function trackbuffassistfortime(var_0, var_1, var_2, var_3, var_4) {
  if(scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }

  var_1 endon("initAssistTrackers");
  var_1 endon("disconnect");
  var_0 endon("disconnect");
  level endon("game_ended");
  var_5 = trackbuffassist(var_0, var_1, var_2);

  if(!var_5) {
    return;
  }

  if(isDefined(var_4) && isstring(var_4)) {
    var_1 scripts\engine\utility::waittill_notify_or_timeout(var_4, var_3);
  } else {
    wait var_3;
  }

  untrackbuffassist(var_0, var_1, var_2);
}

function awardbuffdebuffassists(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_1.debuffedbyplayers) {
    foreach(var_9, var_6 in var_4) {
      if(var_6 <= 0) {
        continue;
      }

      var_7 = level.playersbyentitynumber[var_9];

      if(isDefined(var_7) && var_7.team != "spectator" && var_7.team != "follower" && var_7 scripts\mp\utility\player::isenemy(var_1)) {
        var_8 = var_7.guid;

        if(!isDefined(var_2[var_8])) {
          var_2 = var_7;
        }
      }
    }
  }

  foreach(var_4 in var_0.buffedbyplayers) {
    foreach(var_13 in var_4) {
      if(var_13 <= 0) {
        continue;
      }

      var_7 = level.playersbyentitynumber[var_9];

      if(isDefined(var_7) && var_7.team != "spectator" && var_7.team != "follower" && var_7 scripts\mp\utility\player::isenemy(var_1)) {
        var_8 = var_7.guid;

        if(!isDefined(var_2[var_8])) {
          var_2 = var_7;
        }
      }
    }
  }

  foreach(var_8, var_7 in var_2) {
    if(!isDefined(var_1.attackerdata) || !isDefined(var_1.attackerdata[var_7.guid])) {
      scripts\mp\damage::addattacker(var_1, var_7, undefined, isundefinedweapon(), 0, undefined, undefined, undefined, undefined, undefined);
    }
  }
}

function gamemodeusesdeathmatchscoring(var_0) {
  return var_0 == "dm" || var_0 == "sotf_ffa";
}

function ref_119c1() {
  var_0 = level.teamnamelist[0];
  var_1 = level.teamnamelist[1];
  var_2 = getteamscore(var_0);
  var_3 = getteamscore(var_1);
  getentitylessscriptablearray("dlog_event_score_change", ["team_1_name", var_0, "team_2_name", var_1, "team_1_score", var_2, "team_2_score", var_3]);
}