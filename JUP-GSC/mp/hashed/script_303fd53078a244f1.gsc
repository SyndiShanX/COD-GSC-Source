/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_303fd53078a244f1.gsc
*************************************************/

#using script_19633385c373011d;
#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\rank;
#using scripts\mp\utility\teams;
#namespace namespace_4982e25cac00f32a;

function init() {
  level.var_55e0b414e3671f70 = spawnStruct();
  level.var_55e0b414e3671f70.overtimescore = getdvarint(@ "hash_18cbdeaaf429cff", 10000);
  level.var_55e0b414e3671f70.winningscore = getdvarint(@ "hash_f1341f4aa15134f6", 100000);
  level.var_55e0b414e3671f70.var_c2ac96535e5213ea = getdvarint(@ "hash_547eea684b2142d7", 2);
  level.var_55e0b414e3671f70.var_a5b0c4131fba9805 = getdvarint(@ "hash_edc7e18f90773acc", 0);
  level.var_51b3a6e65caff0b8 = [];
  level.var_a2b5c48f1d7712ff = [];
}

function gethighestscoringteam() {
  highestscore = 0;
  highestteam = undefined;

  foreach(entry in level.teamnamelist) {
    teamscore = _getteamscore(entry);

    if(!isDefined(highestteam) || teamscore > highestscore) {
      highestscore = teamscore;
      highestteam = entry;
      var_ca17acb9ea3fa61d = 0;
    }
  }

  return highestteam;
}

function _getteamscore(team) {
  level.var_51b3a6e65caff0b8[team] = default_to(level.var_51b3a6e65caff0b8[team], 0);
  return int(level.var_51b3a6e65caff0b8[team]);
}

function getplayerscore(player) {
  if(!isDefined(player.var_9356898b6a19a4ac)) {
    player.var_9356898b6a19a4ac = 0;
  }

  return int(player.var_9356898b6a19a4ac);
}

function updateteamscoreplacements() {
  teamssorted = tablesort(level.var_51b3a6e65caff0b8, "down");
  currentscore = undefined;
  var_87ab742859974d26 = 0;
  secondplacescore = 0;
  placement = 0;
  curplacement = 1;

  foreach(team in teamssorted) {
    score = level.var_51b3a6e65caff0b8[team];

    if(!isDefined(currentscore) || score < currentscore) {
      currentscore = score;
      placement = curplacement;
    }

    level.var_a2b5c48f1d7712ff[team] = placement;

    if(score <= currentscore) {
      curplacement++;
    }

    if(placement == 1) {
      var_87ab742859974d26 = _getteamscore(team);
    } else if(placement == 2) {
      secondplacescore = _getteamscore(team);
    }

    foreach(teammate in getteamdata(team, "players")) {
      teammate setclientomnvar("ui_champion_br_team_placement", placement);
      teammate setclientomnvar("ui_br_player_position", placement);
    }
  }

  setomnvar("ui_champion_br_team_score_second", int(secondplacescore));
  setomnvar("ui_champion_br_team_score_leader", int(var_87ab742859974d26));
}

function setplayerscore(player, score) {
  player setclientomnvar("ui_champion_br_player_score", score);
  player.var_9356898b6a19a4ac = score;
}

function _setteamscore(team, score) {
  level.var_51b3a6e65caff0b8[team] = score;
  updateteamscoreplacements();

  foreach(teammate in getteamdata(team, "players")) {
    teammate setclientomnvar("ui_champion_br_team_score", score);
  }

  if(!istrue(level.overtimestarted) && level.var_51b3a6e65caff0b8[team] >= level.var_55e0b414e3671f70.overtimescore) {
    namespace_2d0a106261b9b151::triggerovertime();
  }

  if(level.var_51b3a6e65caff0b8[team] >= level.var_55e0b414e3671f70.winningscore && !istrue(self.var_964721ca906c5421)) {
    namespace_2d0a106261b9b151::function_ec09c585da4071ed(game["end_reason"]["score_limit_reached"]);
  }
}

function function_8f3c16bf2d2412cb(eventref) {
  self endon("death_or_disconnect");

  if(!isDefined(self.var_2a44575989728111)) {
    self.var_2a44575989728111 = [];
  }

  foreach(event in self.var_2a44575989728111) {
    if(event.eventref == eventref) {
      return;
    }
  }

  taskid = scripts\mp\rank::function_b2425a8c88e4a460(eventref);

  if(!isDefined(taskid)) {
    if(istrue(self.var_cb773bb1ead7836)) {
      return;
    } else {
      self.var_cb773bb1ead7836 = 1;
    }
  }

  eventdata = spawnStruct();
  eventdata.eventref = eventref;
  eventdata.processedscoreevent = 0;
  eventdata.score = scripts\mp\rank::getscoreinfovalue(eventref);
  self.var_2a44575989728111[self.var_2a44575989728111.size] = eventdata;
  self notify("championEventPreProcess");
  self endon("championEventPreProcess");
  waitframe();

  if(!isDefined(self.var_488ed33e4875a0c1)) {
    self.var_488ed33e4875a0c1 = [];
  }

  foreach(event in self.var_2a44575989728111) {
    self.var_488ed33e4875a0c1[self.var_488ed33e4875a0c1.size] = event;
  }

  self.var_2a44575989728111 = undefined;
  thread function_3ced6a64b51063f9();
}

function function_3ced6a64b51063f9() {
  self notify("processChampionScoreQueue");
  self endon("processChampionScoreQueue");

  foreach(event in self.var_488ed33e4875a0c1) {
    if(event.processedscoreevent) {
      continue;
    }

    function_adb2f998089074a2(event.eventref, event.score);
    event.processedscoreevent = 1;
    wait getdvarfloat(@ "hash_1eb32d180bc7cff8", 0.3);
  }

  self.var_488ed33e4875a0c1 = undefined;
}

function function_c9a0784e88fcf18d(channel, val) {
  if(channel == "regular_champion_score_complete") {
    self.var_cb773bb1ead7836 = 0;
  }
}

function function_adb2f998089074a2(event, score) {
  taskid = scripts\mp\rank::function_b2425a8c88e4a460(event);

  if(isDefined(taskid)) {
    stars = score / 600;

    foreach(teammate in getteamdata(self.team, "players")) {
      if(!isDefined(teammate.var_569912475ded8c1c)) {
        teammate.var_569912475ded8c1c = 0;
      }

      if(!isDefined(teammate.var_6879bb88396f7ab7)) {
        teammate.var_6879bb88396f7ab7 = 0;
      }

      teammate setclientomnvar("ui_champion_score_event_list_" + teammate.var_569912475ded8c1c, int(stars));
      teammate setclientomnvar("ui_champion_score_event_control", teammate.var_6879bb88396f7ab7 % 5 * 2);
      teammate.var_569912475ded8c1c++;
      teammate.var_569912475ded8c1c %= 5;
      teammate.var_6879bb88396f7ab7++;
    }

    return;
  }

  if(!isDefined(self.var_569912475ded8c1c)) {
    self.var_569912475ded8c1c = 0;
  }

  if(!isDefined(self.var_6879bb88396f7ab7)) {
    self.var_6879bb88396f7ab7 = 0;
  }

  self setclientomnvar("ui_champion_score_event_list_" + self.var_569912475ded8c1c, 99);
  self setclientomnvar("ui_champion_score_event_control", self.var_6879bb88396f7ab7 % 5 * 2);
  self.var_569912475ded8c1c++;
  self.var_569912475ded8c1c %= 5;
  self.var_6879bb88396f7ab7++;
}

function doscoreevent(event) {
  var_e7a7e20ec68138e3 = scripts\cp_mp\utility\game_utility::isbrstylegametype() && !scripts\mp\flags::gameflag("prematch_done");

  if(istrue(level.gameended) || !isDefined(event) || var_e7a7e20ec68138e3) {
    return;
  }

  score = scripts\mp\rank::getscoreinfovalue(event);

  if(!isDefined(score)) {
    logstring("brChampion_doScoreEvent() with event \"" + getxhashhexname(event) + "\", but that event doesn't exist in the gametype's scoreeventlist asset");
    score = 0;
    return;
  }

  if(istrue(level.var_55e0b414e3671f70.var_a5b0c4131fba9805)) {
    logstring("<dev string:x1c>" + score + "<dev string:x32>" + getxhashsourcename(event));
  }

  if(istrue(level.overtimestarted)) {
    score *= level.var_55e0b414e3671f70.var_c2ac96535e5213ea;
  }

  if(!isgameplayteam(self.team)) {
    return;
  }

  setplayerscore(self, getplayerscore(self) + score);
  taskid = scripts\mp\rank::function_b2425a8c88e4a460(event);

  if(isDefined(taskid)) {
    foreach(task in level.teamdata[self.team]["taskInfo"].tasklist) {
      if(istrue(task.needprocess)) {
        _setteamscore(self.team, _getteamscore(self.team) + score);
        thread function_8f3c16bf2d2412cb(event);
        task.needprocess = 0;
      }
    }

    return;
  }

  _setteamscore(self.team, _getteamscore(self.team) + score);
  thread function_8f3c16bf2d2412cb(event);
}

function addscore() {
  team = "<dev string:x43>";
  _setteamscore(team, _getteamscore(team) + 100);
}

# /