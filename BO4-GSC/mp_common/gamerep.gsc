/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gamerep.gsc
***********************************************/

#include scripts\core_common\bots\bot;
#include scripts\core_common\rank_shared;

#namespace gamerep;

init() {
  if(!isgamerepenabled()) {
    return;
  }

  if(isgamerepinitialized()) {
    return;
  }

  game.gamerepinitialized = 1;
  game.gamerep[#"players"] = [];
  game.gamerep[#"playernames"] = [];
  game.gamerep[#"max"] = [];
  game.gamerep[#"playercount"] = 0;
  gamerepinitializeparams();
}

isgamerepinitialized() {
  if(!isDefined(game.gamerepinitialized) || !game.gamerepinitialized) {
    return false;
  }

  return true;
}

isgamerepenabled() {
  if(bot::is_bot_ranked_match()) {
    return false;
  }

  if(!level.rankedmatch) {
    return false;
  }

  return true;
}

gamerepinitializeparams() {
  threshold_exceeded_score = 0;
  threshold_exceeded_score_per_min = 1;
  threshold_exceeded_kills = 2;
  threshold_exceeded_deaths = 3;
  threshold_exceeded_kd_ratio = 4;
  threshold_exceeded_kills_per_min = 5;
  threshold_exceeded_plants = 6;
  threshold_exceeded_defuses = 7;
  threshold_exceeded_captures = 8;
  threshold_exceeded_defends = 9;
  threshold_exceeded_total_time_played = 10;
  threshold_exceeded_tactical_insertion_use = 11;
  threshold_exceeded_join_attempts = 12;
  threshold_exceeded_xp = 13;
  threshold_exceeded_splitscreen = 14;
  game.gamerep[#"params"] = [];
  game.gamerep[#"params"][0] = "score";
  game.gamerep[#"params"][1] = "scorePerMin";
  game.gamerep[#"params"][2] = "kills";
  game.gamerep[#"params"][3] = "deaths";
  game.gamerep[#"params"][4] = "killDeathRatio";
  game.gamerep[#"params"][5] = "killsPerMin";
  game.gamerep[#"params"][6] = "plants";
  game.gamerep[#"params"][7] = "defuses";
  game.gamerep[#"params"][8] = "captures";
  game.gamerep[#"params"][9] = "defends";
  game.gamerep[#"params"][10] = "totalTimePlayed";
  game.gamerep[#"params"][11] = "tacticalInsertions";
  game.gamerep[#"params"][12] = "joinAttempts";
  game.gamerep[#"params"][13] = "xp";
  game.gamerep[#"ignoreparams"] = [];
  game.gamerep[#"ignoreparams"][0] = "totalTimePlayed";
  game.gamerep[#"gamelimit"] = [];
  game.gamerep[#"gamelimit"][#"default"] = [];
  game.gamerep[#"gamelimit"][#"tdm"] = [];
  game.gamerep[#"gamelimit"][#"dm"] = [];
  game.gamerep[#"gamelimit"][#"dom"] = [];
  game.gamerep[#"gamelimit"][#"hq"] = [];
  game.gamerep[#"gamelimit"][#"sd"] = [];
  game.gamerep[#"gamelimit"][#"dem"] = [];
  game.gamerep[#"gamelimit"][#"ctf"] = [];
  game.gamerep[#"gamelimit"][#"koth"] = [];
  game.gamerep[#"gamelimit"][#"conf"] = [];
  game.gamerep[#"gamelimit"][#"id"][#"score"] = threshold_exceeded_score;
  game.gamerep[#"gamelimit"][#"default"][#"score"] = 20000;
  game.gamerep[#"gamelimit"][#"id"][#"scorepermin"] = threshold_exceeded_score_per_min;
  game.gamerep[#"gamelimit"][#"default"][#"scorepermin"] = 250;
  game.gamerep[#"gamelimit"][#"dem"][#"scorepermin"] = 1000;
  game.gamerep[#"gamelimit"][#"tdm"][#"scorepermin"] = 700;
  game.gamerep[#"gamelimit"][#"dm"][#"scorepermin"] = 950;
  game.gamerep[#"gamelimit"][#"dom"][#"scorepermin"] = 1000;
  game.gamerep[#"gamelimit"][#"sd"][#"scorepermin"] = 200;
  game.gamerep[#"gamelimit"][#"ctf"][#"scorepermin"] = 600;
  game.gamerep[#"gamelimit"][#"hq"][#"scorepermin"] = 1000;
  game.gamerep[#"gamelimit"][#"koth"][#"scorepermin"] = 1000;
  game.gamerep[#"gamelimit"][#"conf"][#"scorepermin"] = 1000;
  game.gamerep[#"gamelimit"][#"id"][#"kills"] = threshold_exceeded_kills;
  game.gamerep[#"gamelimit"][#"default"][#"kills"] = 75;
  game.gamerep[#"gamelimit"][#"tdm"][#"kills"] = 40;
  game.gamerep[#"gamelimit"][#"sd"][#"kills"] = 15;
  game.gamerep[#"gamelimit"][#"dm"][#"kills"] = 31;
  game.gamerep[#"gamelimit"][#"id"][#"deaths"] = threshold_exceeded_deaths;
  game.gamerep[#"gamelimit"][#"default"][#"deaths"] = 50;
  game.gamerep[#"gamelimit"][#"dm"][#"deaths"] = 15;
  game.gamerep[#"gamelimit"][#"tdm"][#"deaths"] = 40;
  game.gamerep[#"gamelimit"][#"id"][#"killdeathratio"] = threshold_exceeded_kd_ratio;
  game.gamerep[#"gamelimit"][#"default"][#"killdeathratio"] = 30;
  game.gamerep[#"gamelimit"][#"tdm"][#"killdeathratio"] = 50;
  game.gamerep[#"gamelimit"][#"sd"][#"killdeathratio"] = 20;
  game.gamerep[#"gamelimit"][#"id"][#"killspermin"] = threshold_exceeded_kills_per_min;
  game.gamerep[#"gamelimit"][#"default"][#"killspermin"] = 15;
  game.gamerep[#"gamelimit"][#"id"][#"plants"] = threshold_exceeded_plants;
  game.gamerep[#"gamelimit"][#"default"][#"plants"] = 10;
  game.gamerep[#"gamelimit"][#"id"][#"defuses"] = threshold_exceeded_defuses;
  game.gamerep[#"gamelimit"][#"default"][#"defuses"] = 10;
  game.gamerep[#"gamelimit"][#"id"][#"captures"] = threshold_exceeded_captures;
  game.gamerep[#"gamelimit"][#"default"][#"captures"] = 30;
  game.gamerep[#"gamelimit"][#"id"][#"defends"] = threshold_exceeded_defends;
  game.gamerep[#"gamelimit"][#"default"][#"defends"] = 50;
  game.gamerep[#"gamelimit"][#"id"][#"totaltimeplayed"] = threshold_exceeded_total_time_played;
  game.gamerep[#"gamelimit"][#"default"][#"totaltimeplayed"] = 600;
  game.gamerep[#"gamelimit"][#"dom"][#"totaltimeplayed"] = 600;
  game.gamerep[#"gamelimit"][#"dem"][#"totaltimeplayed"] = 1140;
  game.gamerep[#"gamelimit"][#"id"][#"tacticalinsertions"] = threshold_exceeded_tactical_insertion_use;
  game.gamerep[#"gamelimit"][#"default"][#"tacticalinsertions"] = 20;
  game.gamerep[#"gamelimit"][#"id"][#"joinattempts"] = threshold_exceeded_join_attempts;
  game.gamerep[#"gamelimit"][#"default"][#"joinattempts"] = 3;
  game.gamerep[#"gamelimit"][#"id"][#"xp"] = threshold_exceeded_xp;
  game.gamerep[#"gamelimit"][#"default"][#"xp"] = 25000;
  game.gamerep[#"gamelimit"][#"id"][#"splitscreen"] = threshold_exceeded_splitscreen;
  game.gamerep[#"gamelimit"][#"default"][#"splitscreen"] = 8;
}

gamerepplayerconnected() {
  if(!isgamerepenabled()) {
    return;
  }

  name = self.name;

    if(!isDefined(game.gamerep[#"players"][name])) {
      game.gamerep[#"players"][name] = [];

      for(j = 0; j < game.gamerep[#"params"].size; j++) {
        paramname = game.gamerep[#"params"][j];
        game.gamerep[#"players"][name][paramname] = 0;
      }

      game.gamerep[#"players"][name][#"splitscreen"] = self issplitscreen();
      game.gamerep[#"players"][name][#"joinattempts"] = 1;
      game.gamerep[#"players"][name][#"connected"] = 1;
      game.gamerep[#"players"][name][#"xpstart"] = self rank::getrankxpstat();
      game.gamerep[#"playernames"][game.gamerep[#"playercount"]] = name;
      game.gamerep[#"playercount"]++;
      return;
    }

  if(!game.gamerep[#"players"][name][#"connected"]) {
    game.gamerep[#"players"][name][#"joinattempts"]++;
    game.gamerep[#"players"][name][#"connected"] = 1;
    game.gamerep[#"players"][name][#"xpstart"] = self rank::getrankxpstat();
  }
}

gamerepplayerdisconnected() {
  if(!isgamerepenabled()) {
    return;
  }

  name = self.name;

  if(!isDefined(game.gamerep[#"players"][name]) || !isDefined(self.pers[#"summary"])) {
    return;
  }

    self gamerepupdatenonpersistentplayerinformation();
  self gamerepupdatepersistentplayerinformation();
  game.gamerep[#"players"][name][#"connected"] = 0;
}

gamerepupdatenonpersistentplayerinformation() {
  name = self.name;

  if(!isDefined(game.gamerep[#"players"][name])) {
    return;
  }

  if(isDefined(self.timeplayed) && isDefined(self.timeplayed[#"total"])) {
    if(!isDefined(game.gamerep[#"players"][name][#"totaltimeplayed"])) {
      game.gamerep[#"players"][name][#"totaltimeplayed"] = 0;
    }

    game.gamerep[#"players"][name][#"totaltimeplayed"] += self.timeplayed[#"total"];
  }

  if(isDefined(self.tacticalinsertioncount)) {
    game.gamerep[#"players"][name][#"tacticalinsertions"] += self.tacticalinsertioncount;
  }
}

gamerepupdatepersistentplayerinformation() {
  name = self.name;

  if(!isDefined(game.gamerep[#"players"][name])) {
    return;
  }

  if(game.gamerep[#"players"][name][#"totaltimeplayed"] != 0) {
    timeplayed = game.gamerep[#"players"][name][#"totaltimeplayed"];
  } else {
    timeplayed = 1;
  }

  game.gamerep[#"players"][name][#"score"] = self.score;
  game.gamerep[#"players"][name][#"scorepermin"] = int(game.gamerep[#"players"][name][#"score"] / timeplayed / 60);
  game.gamerep[#"players"][name][#"kills"] = self.kills;
  game.gamerep[#"players"][name][#"deaths"] = self.deaths;

  if(game.gamerep[#"players"][name][#"deaths"] != 0) {
    game.gamerep[#"players"][name][#"killdeathratio"] = int(game.gamerep[#"players"][name][#"kills"] / game.gamerep[#"players"][name][#"deaths"] * 100);
  } else {
    game.gamerep[#"players"][name][#"killdeathratio"] = game.gamerep[#"players"][name][#"kills"] * 100;
  }

  game.gamerep[#"players"][name][#"killspermin"] = int(game.gamerep[#"players"][name][#"kills"] / timeplayed / 60);
  game.gamerep[#"players"][name][#"plants"] = self.plants;
  game.gamerep[#"players"][name][#"defuses"] = self.defuses;
  game.gamerep[#"players"][name][#"captures"] = self.captures;
  game.gamerep[#"players"][name][#"defends"] = self.defends;
  game.gamerep[#"players"][name][#"xp"] = self rank::getrankxpstat() - game.gamerep[#"players"][name][#"xpstart"];
  game.gamerep[#"players"][name][#"xpstart"] = self rank::getrankxpstat();
}

getparamvalueforplayer(playername, paramname) {
  if(isDefined(game.gamerep[#"players"][playername][paramname])) {
    return game.gamerep[#"players"][playername][paramname];
  }

  assertmsg("<dev string:x38>" + paramname + "<dev string:x4d>");
}

isgamerepparamvalid(paramname) {
  gametype = level.gametype;

  if(!isDefined(game.gamerep)) {
    return false;
  }

  if(!isDefined(game.gamerep[#"gamelimit"])) {
    return false;
  }

  if(!isDefined(game.gamerep[#"gamelimit"][gametype])) {
    return false;
  }

  if(!isDefined(game.gamerep[#"gamelimit"][gametype][paramname])) {
    return false;
  }

  if(!isDefined(game.gamerep[#"gamelimit"][gametype][paramname]) && !isDefined(game.gamerep[#"gamelimit"][#"default"][paramname])) {
    return false;
  }

  return true;
}

isgamerepparamignoredforreporting(paramname) {
  if(isDefined(game.gamerep[#"ignoreparams"][paramname])) {
    return true;
  }

  return false;
}

getgamerepparamlimit(paramname) {
  gametype = level.gametype;

  if(isDefined(game.gamerep[#"gamelimit"][gametype])) {
    if(isDefined(game.gamerep[#"gamelimit"][gametype][paramname])) {
      return game.gamerep[#"gamelimit"][gametype][paramname];
    }
  }

  if(isDefined(game.gamerep[#"gamelimit"][#"default"][paramname])) {
    return game.gamerep[#"gamelimit"][#"default"][paramname];
  }

  assertmsg("<dev string:x65>" + paramname + "<dev string:x85>");
}

setmaximumparamvalueforcurrentgame(paramname, value) {
  if(!isDefined(game.gamerep[#"max"][paramname])) {
    game.gamerep[#"max"][paramname] = value;
    return;
  }

  if(game.gamerep[#"max"][paramname] < value) {
    game.gamerep[#"max"][paramname] = value;
  }
}

gamerepupdateinformationforround() {
  if(!isgamerepenabled()) {
    return;
  }

  players = getplayers();

  for(i = 0; i < players.size; i++) {
    player = players[i];
    player gamerepupdatenonpersistentplayerinformation();
  }
}

gamerepanalyzeandreport() {
  if(!isgamerepenabled()) {
    return;
  }

  players = getplayers();

  for(i = 0; i < players.size; i++) {
    player = players[i];
    player gamerepupdatepersistentplayerinformation();
  }

  splitscreenplayercount = 0;

  for(i = 0; i < game.gamerep[#"playernames"].size; i++) {
    playername = game.gamerep[#"playernames"][i];

    for(j = 0; j < game.gamerep[#"params"].size; j++) {
      paramname = game.gamerep[#"params"][j];

      if(isgamerepparamvalid(paramname)) {
        setmaximumparamvalueforcurrentgame(paramname, getparamvalueforplayer(playername, paramname));
      }
    }

    paramname = "splitscreen";
    splitscreenplayercount += getparamvalueforplayer(playername, paramname);
  }

  setmaximumparamvalueforcurrentgame(paramname, splitscreenplayercount);

  for(j = 0; j < game.gamerep[#"params"].size; j++) {
    paramname = game.gamerep[#"params"][j];

    if(isgamerepparamvalid(paramname) && game.gamerep[#"max"][paramname] >= getgamerepparamlimit(paramname)) {
      gamerepprepareandreport(paramname);
    }
  }

  paramname = "splitscreen";

  if(game.gamerep[#"max"][paramname] >= getgamerepparamlimit(paramname)) {
    gamerepprepareandreport(paramname);
  }
}

gamerepprepareandreport(paramname) {
  if(!isDefined(game.gamerep[#"gamelimit"][#"id"][paramname])) {
    return;
  }

  if(isgamerepparamignoredforreporting(paramname)) {
    return;
  }

  gamerepthresholdexceeded(game.gamerep[#"gamelimit"][#"id"][paramname]);
}