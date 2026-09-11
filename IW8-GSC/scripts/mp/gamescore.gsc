/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gamescore.gsc
***********************************************/

function gethighestscoringteam() {
  var0 = 0;
  var1 = undefined;
  var2 = 0;

  foreach(var4 in level.teamnamelist) {
    var5 = game["teamScores"][var4];

    if(!isDefined(var1) || var5 > var0) {
      var0 = var5;
      var1 = var4;
      var2 = 0;
      continue;
    }

    if(var5 == var0) {
      var2 = 1;
    }
  }

  if(var2) {
    return "tie";
  }

  return var1;
}

function remove_hunter_class(var0) {
  var1 = 0;
  var2 = undefined;

  foreach(var4 in level.teamnamelist) {
    if(isDefined(var0) && var4 == var0) {
      continue;
    }

    var5 = game["teamScores"][var4];

    if(!isDefined(var2) || var5 > var1) {
      var1 = var5;
      var2 = var4;
    }
  }

  return [var2, game["teamScores"][var2]];
}

function ref_14026() {
  level notify("updateTeamScorePlacement");
  level endon("updateTeamScorePlacement");
  waittillframeend();
  var0 = setteamplacement(game["teamScores"], "down");
  var1 = undefined;
  var2 = 0;

  foreach(var4 in var0) {
    var5 = game["teamScores"][var4];

    if(!isDefined(var1) || var5 < var1) {
      var1 = var5;
      var2++;
    }

    game["teamPlacements"][var4] = var2;
  }
}

function run_common_functions_stealth() {
  return game["teamPlacements"];
}

function hidesafecircle(var0, var1) {
  return var0.score > var1.score;
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
    var0 = _getplayerscore(level.placement["all"][0]);
    var1 = _getplayerscore(level.placement["all"][1]);
    return (var0 == var1);
  }

  return false;
}

function getlosingplayers() {
  updateplacement();
  var0 = level.placement["all"];
  var1 = [];

  foreach(var3 in var0) {
    if(var3 == level.placement["all"][0]) {
      continue;
    }

    var1 = var3;
  }

  return var1;
}

function giveplayerscore(var0, var1, var2) {
  if(istrue(level.ignorescoring) && !issubstr(var0, "assist")) {
    var3 = scripts\mp\utility\game::getgametype() == "br" && !scripts\mp\flags::gameflag("prematch_done");

    if(!var3) {
      return;
    }
  }

  if(!level.teambased) {
    foreach(var5 in level.players) {
      if(scripts\mp\utility\game::issimultaneouskillenabled()) {
        if(var5 != self) {
          continue;
        }

        if(level.roundscorelimit > 1 && var5.pers["score"] >= level.roundscorelimit) {
          return;
        }

        continue;
      }

      if(level.roundscorelimit > 1 && var5.pers["score"] >= level.roundscorelimit) {
        return;
      }
    }
  }

  var5 = self;

  if(isDefined(self.owner) && !isbot(self)) {
    var5 = self.owner;
  }

  if(!isPlayer(var5)) {
    return;
  }

  var7 = var1;

  if(isDefined(level.onplayerscore)) {
    var1 = [[level.onplayerscore]](var0, var5, var1, var2);
  }

  if(var1 == 0) {
    return;
  }

  var5.pers["score"] = int(max(var5.pers["score"] + var1, 0));
  var5 scripts\mp\playerstats_interface::addtoplayerstat(int(var7), "matchStats", "score");

  if(var5.pers["score"] >= 65000) {
    var5.pers["score"] = 65000;
  }

  var5.score = var5.pers["score"];
  var8 = var5.score;
  var5 scripts\mp\persistence::statsetchild("round", "score", var8);
  var5 scripts\mp\gamelogic::checkplayerscorelimitsoon();
  var5 thread scripts\mp\gamelogic::checkscorelimit();
  var5 scripts\mp\utility\script::bufferednotify("earned_score_buffered", var1);
  scripts\mp\analyticslog::logevent_reportgamescore(var1, gettime(), scripts\mp\rank::getscoreinfocategory(var0, "eventID"));
  var5 scripts\common\utility::ref_13e0a(level.ref_11b2f, var0);
  var5 scripts\cp_mp\pet_watch::addobjectivescorecharge(var0, int(var7));
}

function _setplayerscore(var0, var1) {
  if(var1 == var0.pers["score"]) {
    return;
  }

  if(var1 < 0) {
    return;
  }

  var0.pers["score"] = var1;
  var0.score = var0.pers["score"];
  var0 thread scripts\mp\gamelogic::checkscorelimit();
}

function _getplayerscore(var0) {
  if(!isDefined(var0)) {
    var0 = self;
  }

  return var0.pers["score"];
}

function checkffascorejip() {
  if(level.roundscorelimit > 0) {
    var0 = self.score / level.roundscorelimit * 100;

    if(var0 > level.scorepercentagecutoff) {
      setnojipscore(1, 1);
      level.nojip = 1;
      return;
    }

    return;
  }
}

function giveteamscoreforobjective(var0, var1, var2, var3, var4, var5) {
  if(scripts\mp\utility\game::cantiebysimultaneouskill()) {
    var2 = 1;
  }

  if(!isDefined(var2)) {
    var2 = 0;
  }

  if(istrue(level.gameended) && !var2) {
    return;
  }

  if(istrue(level.ignorescoring)) {
    return;
  }

  if(istrue(level.dontendonscore) && _getteamscore(var0) >= level.scorelimit) {
    return;
  }

  if(var2) {
    if(level.roundscorelimit > 1 && game["teamScores"][var0] >= level.roundscorelimit) {
      return;
    }
  } else if(level.roundscorelimit > 1 && !istrue(level.dontendonscore)) {
    foreach(var7 in level.teamnamelist) {
      if(level scripts\mp\utility\game::vehicle_collision_ignorefuturemultievent(var7)) {
        continue;
      }

      if(game["teamScores"][var7] >= level.roundscorelimit) {
        return;
      }
    }
  }

  _setteamscore(var0, _getteamscore(var0) + var1, var2);
  level notify("update_team_score", var0, _getteamscore(var0));

  if(isDefined(level.onteamscore)) {
    [[level.onteamscore]](var0, _getteamscore(var0), var3);
  }

  if(isDefined(var5)) {
    var9 = var5;
  } else {
    var9 = freight_lift_door_switch(var3);
  }

  if(!istrue(var5)) {
    ref_12762(var9, var3, level.waswinning);
  }

  if(var9 != "none") {
    level.waswinning = var9;
    var10 = _getteamscore(var9);
    var11 = level.roundscorelimit;

    if(var10 == 0 || var11 == 0) {
      return;
    }

    var12 = var10 / var11 * 100;

    if(!scripts\mp\utility\game::isroundbased() && isDefined(level.nojip) && !level.nojip) {
      if(var12 > level.scorepercentagecutoff) {
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

function ref_12762(var0, var1, var2) {
  if(!level.splitscreen && var0 != "none" && var0 != var2 && gettime() - level.lastscorestatustime > 5000 && scripts\mp\utility\game::getscorelimit() != 1) {
    if(isDefined(level.delayleadtakendialog)) {
      thread playleadtakendialog(level);
      return;
    }

    level.lastscorestatustime = gettime();
    scripts\mp\utility\dialog::leaderdialog("lead_taken", var0, "status");

    if(var2 != "none") {
      scripts\mp\utility\dialog::leaderdialog("lead_lost", var2, "status");
      return;
    }

    return;
  }
}

function playleadtakendialog(var0) {
  wait level.delayleadtakendialog;
  level.lastscorestatustime = gettime();
  var1 = freight_lift_door_switch(var0);
  scripts\mp\utility\dialog::leaderdialog("lead_taken", var1, "status");

  foreach(var3 in level.teamnamelist) {
    if(var3 != var1) {
      scripts\mp\utility\dialog::leaderdialog("lead_lost", var3, "status");
    }
  }
}

function freight_lift_door_switch(var0) {
  var1 = level.teamnamelist;

  if(!isDefined(level.waswinning)) {
    level.waswinning = "none";
  }

  var2 = "none";
  var3 = 0;

  if(level.waswinning != "none") {
    var2 = level.waswinning;
    var3 = game["teamScores"][level.waswinning];
  }

  var4 = 1;

  foreach(var6 in var1) {
    if(var6 == level.waswinning) {
      continue;
    }

    if(game["teamScores"][var6] > var3) {
      var2 = var6;
      var3 = game["teamScores"][var6];
      var4 = 1;
      continue;
    }

    if(game["teamScores"][var6] == var3) {
      var4 += 1;
      var2 = "none";
    }
  }

  return var2;
}

function _setteamscore(var0, var1, var2) {
  if(var1 < 0) {
    var1 = 0;
  }

  if(var1 == game["teamScores"][var0]) {
    return;
  }

  game["teamScores"][var0] = var1;
  updateteamscore(var0);

  if(!istrue(level.dontendonscore)) {
    thread scripts\mp\gamelogic::roundend_checkscorelimit(var0, var2);
    return;
  }
}

function updateteamscore(var0) {
  if(scripts\mp\utility\game::vehicle_collision_ignorefuturemultievent(var0)) {
    return;
  }

  var1 = 0;

  if(!scripts\mp\utility\game::isroundbased() || !scripts\mp\utility\game::isobjectivebased() || scripts\mp\utility\game::ismoddedroundgame()) {
    var1 = _getteamscore(var0);
  } else {
    var1 = game["roundsWon"][var0];
  }

  setteamscore(var0, int(var1));
  thread ref_14026();
}

function updatetotalteamscore(var0) {
  if(!isDefined(game["totalScore"])) {
    game["totalScore"] = [];

    foreach(var2 in level.teamnamelist) {
      game["totalScore"][var2] = 0;
    }
  }

  var4 = scripts\mp\utility\game::getwingamebytype();

  switch (var4) {
    case "roundsWon":
      game["teamScores"][var0] = game["roundsWon"][var0];
      break;
    case "teamScores":
      if(scripts\mp\utility\game::inovertime()) {
        game["teamScores"][var0] = game["preOvertimeScore"][var0] + game["overtimeScore"][var0] + game["teamScores"][var0];
      } else if(scripts\mp\utility\game::resetscoreonroundstart()) {
        game["totalScore"][var0] = game["totalScore"][var0] + game["teamScores"][var0];
        game["teamScores"][var0] = game["totalScore"][var0];
      }

      break;
  }

  setteamscore(var0, int(game["teamScores"][var0]));
}

function updateovertimescore() {
  if(game["overtimeRoundsPlayed"] == 0) {
    if(!isDefined(game["preOvertimeScore"])) {
      game["preOvertimeScore"] = [];

      foreach(var1 in level.teamnamelist) {
        game["preOvertimeScore"][var1] = 0;
      }
    }

    foreach(var1 in level.teamnamelist) {
      game["preOvertimeScore"][var1] = game["teamScores"][var1] + game["totalScore"][var1];
    }
  }

  if(!isDefined(game["overtimeScore"])) {
    game["overtimeScore"] = [];

    foreach(var1 in level.teamnamelist) {
      game["overtimeScore"][var1] = 0;
    }
  }

  foreach(var1 in level.teamnamelist) {
    game["overtimeScore"][var1] = game["overtimeScore"][var1] + game["teamScores"][var1] - game["preOvertimeScore"][var1];
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

function _getteamscore(var0) {
  return int(game["teamScores"][var0]);
}

function removedisconnectedplayerfromplacement() {
  if(!isDefined(level.placement) || !isDefined(level.placement["all"])) {
    return;
  }

  var0 = 0;
  var1 = level.placement["all"].size;
  var2 = 0;

  for(var3 = 0; var3 < var1; var3++) {
    if(level.placement["all"][var3] == self) {
      var2 = 1;
    }

    if(var2) {
      level.placement["all"][var3] = level.placement["all"][var3 + 1];
    }
  }

  if(!var2) {
    return;
  }

  level.placement["all"][var1 - 1] = undefined;

  if(level.teambased) {
    updateteamplacement();
    return;
  }
}

function updateplacement() {
  var0 = [];

  foreach(var2 in level.players) {
    if(isDefined(var2.connectedpostgame)) {
      continue;
    }

    if(var2.pers["team"] == "spectator" || var2.pers["team"] == "follower" || var2.pers["team"] == "none") {
      continue;
    }

    var0 = var2;
  }

  for(var4 = 1; var4 < var0.size; var4++) {
    var2 = var0[var4];
    var5 = var2.score;

    for(var6 = var4 - 1; var6 >= 0 && getbetterplayer(var2, var0[var6]) == var2; var6--) {
      var0 = var0[var6];
    }

    var0 = var2;
  }

  level.placement["all"] = var0;

  if(level.teambased) {
    updateteamplacement();
    return;
  }
}

function getbetterplayer(var0, var1) {
  if(isDefined(level.lastplayerwins)) {
    return level.lastplayerwins;
  }

  if(var0.score > var1.score) {
    return var0;
  }

  if(var1.score > var0.score) {
    return var1;
  }

  if(var0.deaths < var1.deaths) {
    return var0;
  }

  if(var1.deaths < var0.deaths) {
    return var1;
  }

  if(scripts\engine\utility::cointoss()) {
    return var0;
  }

  return var1;
}

function updateteamplacement() {
  var0 = level.placement["all"];
  var1 = [];

  foreach(var3 in var0) {
    var4 = var3.pers["team"];

    if(!isDefined(var1[var4])) {
      var1 = [];
    }

    var1[var1[var4].size] = var3;
  }

  foreach(var7 in level.teamnamelist) {
    if(isDefined(var1[var7])) {
      level.placement[var7] = var1[var7];
      continue;
    }

    level.placement[var7] = [];
  }
}

function processassist(var0, var1, var2) {
  if(isDefined(level.assists_disabled)) {
    return;
  }

  processassist_regularmp(var0, var1, var2);
}

function processassist_regularmp(var0, var1, var2) {
  self endon("disconnect");
  var0 endon("disconnect");

  if(isDefined(var1) && var1.basename == "white_phosphorus_proj_mp") {
    return;
  }

  if(!isDefined(var2)) {
    var2 = 0;
  }

  var3 = undefined;
  var4 = undefined;
  var5 = undefined;

  if(isDefined(var0.ismarkedtarget)) {
    var4 = var0.attackers;
    var3 = 1;
  }

  if(isDefined(var0.markedbyboomperk)) {
    var5 = var0.markedbyboomperk;
  }

  wait 0.05;
  scripts\mp\utility\script::waittillslowprocessallowed();
  var6 = self.pers["team"];

  if(!scripts\mp\utility\teams::isgameplayteam(var6)) {
    return;
  }

  if(var6 == var0.pers["team"] && level.teambased) {
    return;
  }

  var7 = undefined;
  var8 = "assist";

  if(!level.teambased) {
    var8 = "assist_ffa";
  }

  var9 = scripts\mp\rank::getscoreinfovalue(var8);

  if(!level.teambased) {
    var7 = var9 + var9 * var2;
    thread scripts\mp\utility\points::giveunifiedpoints("assist_ffa", var1, var7);
  } else if(isDefined(var5) && scripts\engine\utility::array_contains_key(var5, scripts\mp\utility\player::getuniqueid())) {
    thread scripts\mp\utility\points::givestreakpointswithtext("assist_ping", var1, undefined);
  } else {
    var7 = var9 + var9 * var2;
    thread scripts\mp\utility\points::giveunifiedpoints("assist", var1, var7);
  }

  if(level.teambased) {
    var10 = scripts\common\utility::playersinsphere(self.origin, 300);

    foreach(var12 in var10) {
      if(self.team != var12.team || self == var12) {
        continue;
      }

      if(!scripts\mp\utility\player::isreallyalive(var12)) {
        continue;
      }

      self.modifiers["buddy_kill"] = 1;
      break;
    }
  }

  if(scripts\mp\utility\perk::_hasperk("specialty_hardline") && isDefined(self.hardlineactive)) {
    if(self.hardlineactive["assists"] == 1) {
      if(!scripts\mp\utility\weapon::iskillstreakweapon(var1) && !scripts\mp\utility\weapon::issuperweapon(var1)) {
        thread scripts\mp\utility\points::givestreakpointswithtext("assist_hardline", var1, 1);
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
  thread scripts\cp\vehicles\vehicle_compass_cp::onplayerkillassist(var0);
}

function processshieldassist(var0) {
  if(isDefined(level.assists_disabled)) {
    return;
  }

  processshieldassist_regularmp(var0);
}

function processshieldassist_regularmp(var0) {
  self endon("disconnect");
  var0 endon("disconnect");
  wait 0.05;
  scripts\mp\utility\script::waittillslowprocessallowed();

  if(!scripts\mp\utility\teams::isgameplayteam(self.pers["team"])) {
    return;
  }

  if(self.pers["team"] == var0.pers["team"]) {
    return;
  }

  thread scripts\mp\utility\points::giveunifiedpoints("shield_assist");
  scripts\mp\playerstats_interface::addtoplayerstat(1, "combatStats", "assists");

  if(self.pers["assists"] < 998) {
    scripts\mp\utility\stats::incpersstat("assists", 1);
    self.assists = scripts\mp\utility\stats::getpersstat("assists");
    scripts\mp\persistence::statsetchild("round", "assists", self.assists);
  }

  thread scripts\cp\vehicles\vehicle_compass_cp::onplayerkillassist(var0);
}

function initassisttrackers() {
  self notify("initAssistTrackers");
  self.buffedbyplayers = [];
  self.debuffedbyplayers = [];
}

function trackdebuffassist(var0, var1, var2) {
  if(!isDefined(var1.debuffedbyplayers[var2])) {
    var1.debuffedbyplayers[var2] = [];
  }

  if(scripts\mp\utility\game::lpcfeaturegated() && var1.debuffedbyplayers[var2].size >= getdvarint("scr_br_maxTrackedBuffs", 4) && getdvarint("scr_br_maxTrackedBuffs", 4) > 0) {
    return false;
  }

  if(!isDefined(var1.debuffedbyplayers[var2][var0 getentitynumber()])) {
    var1.debuffedbyplayers[var2][var0 getentitynumber()] = 0;
  }

  var1.debuffedbyplayers[var2][var0 getentitynumber()]++;
  return true;
}

function untrackdebuffassist(var0, var1, var2) {
  if(isDefined(var0)) {
    if(isDefined(var1.debuffedbyplayers[var2]) && isDefined(var1.debuffedbyplayers[var2][var0 getentitynumber()])) {
      var1.debuffedbyplayers[var2][var0 getentitynumber()]--;

      if(var1.debuffedbyplayers[var2][var0 getentitynumber()] <= 0) {
        var1.debuffedbyplayers[var2][var0 getentitynumber()] = undefined;
      }

      var3 = 1;

      foreach(var5 in var1.debuffedbyplayers[var2]) {
        if(var5 > 0) {
          var3 = 0;
          break;
        }
      }

      if(var3 && isDefined(var2) && isDefined(var1.debuffedbyplayers)) {
        var1.debuffedbyplayers[var2] = undefined;
        return;
      }

      return;
    }

    return;
  }
}

function trackdebuffassistfortime(var0, var1, var2, var3, var4) {
  var1 endon("initAssistTrackers");
  var1 endon("disconnect");
  var0 endon("disconnect");
  level endon("game_ended");
  var5 = trackdebuffassist(var0, var1, var2);

  if(!var5) {
    return;
  }

  if(isDefined(var4) && isstring(var4)) {
    var1 scripts\engine\utility::waittill_notify_or_timeout(var4, var3);
  } else {
    wait var3;
  }

  untrackdebuffassist(var0, var1, var2);
}

function isdebuffedbyweapon(var0, var1) {
  if(scripts\mp\utility\game::runleanthreadmode()) {
    return false;
  }

  if(isDefined(var0.debuffedbyplayers[var1])) {
    foreach(var3 in var0.debuffedbyplayers[var1]) {
      if(var3 <= 0) {
        continue;
      }

      if(!isDefined(level.playersbyentitynumber[var4])) {
        continue;
      }

      return true;
    }
  }

  return false;
}

function isdebuffedbyweaponandplayer(var0, var1, var2) {
  if(scripts\mp\utility\game::runleanthreadmode()) {
    return false;
  }

  if(!isDefined(var1.debuffedbyplayers[var2])) {
    return false;
  }

  if(!isDefined(var1.debuffedbyplayers[var2][var0 getentitynumber()])) {
    return false;
  }

  if(var1.debuffedbyplayers[var2][var0 getentitynumber()] <= 0) {
    return false;
  }

  return true;
}

function getdebuffattackersbyweapon(var0, var1) {
  if(scripts\mp\utility\game::runleanthreadmode()) {
    return undefined;
  }

  var2 = [];

  if(isPlayer(var0)) {
    if(isDefined(var0.debuffedbyplayers[var1])) {
      foreach(var4 in var0.debuffedbyplayers[var1]) {
        if(var4 <= 0) {
          continue;
        }

        if(!isDefined(level.playersbyentitynumber[var5])) {
          continue;
        }

        var2 = level.playersbyentitynumber[var5];
      }
    }
  }

  return var2;
}

function trackbuffassist(var0, var1, var2) {
  if(scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }

  if(var0 != var1) {
    if(!isDefined(var1.buffedbyplayers[var2])) {
      var1.buffedbyplayers[var2] = [];
    }

    if(scripts\mp\utility\game::lpcfeaturegated() && var1.buffedbyplayers[var2].size >= getdvarint("scr_br_maxTrackedBuffs", 4) && getdvarint("scr_br_maxTrackedBuffs", 4) > 0) {
      return 0;
    }

    if(!isDefined(var1.buffedbyplayers[var2][var0 getentitynumber()])) {
      var1.buffedbyplayers[var2][var0 getentitynumber()] = 0;
    }

    var1.buffedbyplayers[var2][var0 getentitynumber()]++;
    return 1;
  }
}

function untrackbuffassist(var0, var1, var2) {
  if(scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }

  if(isDefined(var1)) {
    if(isDefined(var1.buffedbyplayers[var2]) && isDefined(var1.buffedbyplayers[var2][var0 getentitynumber()])) {
      var1.buffedbyplayers[var2][var0 getentitynumber()]--;

      if(var1.buffedbyplayers[var2][var0 getentitynumber()] <= 0) {
        var1.buffedbyplayers[var2][var0 getentitynumber()] = undefined;
        return;
      }

      return;
    }

    return;
  }
}

function trackbuffassistfortime(var0, var1, var2, var3, var4) {
  if(scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }

  var1 endon("initAssistTrackers");
  var1 endon("disconnect");
  var0 endon("disconnect");
  level endon("game_ended");
  var5 = trackbuffassist(var0, var1, var2);

  if(!var5) {
    return;
  }

  if(isDefined(var4) && isstring(var4)) {
    var1 scripts\engine\utility::waittill_notify_or_timeout(var4, var3);
  } else {
    wait var3;
  }

  untrackbuffassist(var0, var1, var2);
}

function awardbuffdebuffassists(var0, var1) {
  var2 = [];

  foreach(var4 in var1.debuffedbyplayers) {
    foreach(var9, var6 in var4) {
      if(var6 <= 0) {
        continue;
      }

      var7 = level.playersbyentitynumber[var9];

      if(isDefined(var7) && var7.team != "spectator" && var7.team != "follower" && var7 scripts\mp\utility\player::isenemy(var1)) {
        var8 = var7.guid;

        if(!isDefined(var2[var8])) {
          var2 = var7;
        }
      }
    }
  }

  foreach(var4 in var0.buffedbyplayers) {
    foreach(var13 in var4) {
      if(var13 <= 0) {
        continue;
      }

      var7 = level.playersbyentitynumber[var9];

      if(isDefined(var7) && var7.team != "spectator" && var7.team != "follower" && var7 scripts\mp\utility\player::isenemy(var1)) {
        var8 = var7.guid;

        if(!isDefined(var2[var8])) {
          var2 = var7;
        }
      }
    }
  }

  foreach(var8, var7 in var2) {
    if(!isDefined(var1.attackerdata) || !isDefined(var1.attackerdata[var7.guid])) {
      scripts\mp\damage::addattacker(var1, var7, undefined, isundefinedweapon(), 0, undefined, undefined, undefined, undefined, undefined);
    }
  }
}

function gamemodeusesdeathmatchscoring(var0) {
  return var0 == "dm" || var0 == "sotf_ffa";
}

function ref_119c1() {
  var0 = level.teamnamelist[0];
  var1 = level.teamnamelist[1];
  var2 = getteamscore(var0);
  var3 = getteamscore(var1);
  getentitylessscriptablearray("dlog_event_score_change", ["team_1_name", var0, "team_2_name", var1, "team_1_score", var2, "team_2_score", var3]);
}