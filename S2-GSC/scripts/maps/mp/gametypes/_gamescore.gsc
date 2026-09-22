/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\_gamescore.gsc
****************************************************/

_id_450A() {
  _id_A14D();

  if(!level.placement["all"].size) {
    return undefined;
  } else {
    return level.placement["all"][0];
  }
}

_id_450B(var_0) {
  var_1 = [];

  if(var_0 < 0) {
    return var_1;
  }

  _id_A14D();

  for(var_2 = 0; var_2 < var_0; var_2++) {
    if(level.placement["all"].size == var_2) {
      break;
    }

    var_1[var_2] = level.placement["all"][var_2];
  }

  return var_1;
}

gettiedplayerarray(var_0) {
  var_1 = level.placement["all"][var_0];
  var_2 = [];

  if(!isDefined(var_1)) {
    return var_2;
  }

  foreach(var_4 in level.placement["all"]) {
    if(var_4 != var_1) {
      if(var_4.score == var_1.score && var_4.deaths == var_1.deaths) {
        var_2[var_2.size] = var_4;
      }
    }
  }

  return var_2;
}

_id_4568() {
  _id_A14D();
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

_id_A161(var_0, var_1) {
  if(level.teambased) {
    return;
  }
  var_0 maps\mp\gametypes\_persistence::statsetchild("round", "score", var_0._id_008F);
  var_0 maps\mp\gametypes\_persistence::statadd("score", var_1);

  if(var_1 > 0) {
    var_0 maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_veteran", var_1);
  }
}

_id_47A7(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_1._id_0117)) {
    var_1 = var_1._id_0117;
  }

  if(!isPlayer(var_1)) {
    return;
  }
  if(issubstr(var_0, "assist") && isDefined(var_3)) {
    if(var_3 == "agent_raid_fighters_mp") {
      var_0 = "raid_fighters_assist";
    }

    if(var_3 == "killstreak_flak_gun_raids") {
      if(maps\mp\_utility::isdogfightgametype()) {
        var_0 = "dogfight_flak_assist";
      } else {
        var_0 = "raid_flak_assist";
      }
    }
  }

  if(!maps\mp\_utility::_id_579B() || getdvarint("raid_allow_scorestreaks", 0)) {
    var_1 _id_051E::_id_4770(var_0);
  }

  if(!maps\mp\_utility::_id_579B() && var_1 maps\mp\_utility::_hasperk("specialty_perkstreaks")) {
    var_1 _id_052C::processspecialistevent(var_0);
  }

  var_5 = var_1.pers["score"];
  _id_6B7F(var_0, var_1, var_2, var_3, var_4);
  var_6 = var_1.pers["score"] - var_5;

  if(var_6 == 0) {
    return;
  }
  if(var_1.pers["score"] < 65535) {
    var_1.score = var_1.pers["score"];
  }

  if(level.teambased) {
    var_1 maps\mp\gametypes\_persistence::statsetchild("round", "score", var_1.score);
    var_1 maps\mp\gametypes\_persistence::statadd("score", var_6);

    if(var_6 > 0) {
      var_1 maps\mp\gametypes\_missions::processchallenge("ch_" + level.gametype + "_veteran", var_6);
    }
  }

  if(!level.teambased) {
    level thread _id_83E2();
    var_1 maps\mp\gametypes\_gamelogic::_id_21D2();
    var_1 maps\mp\gametypes\_gamelogic::_id_21E3();
  }
}

_id_6B7F(var_0, var_1, var_2, var_3, var_4) {
  var_5 = undefined;

  if(isDefined(level._id_6B7F)) {
    var_5 = [[level._id_6B7F]](var_0, var_1, var_2, var_3, var_4);
  }

  if(!isDefined(var_5)) {
    if(var_1 maps\mp\_utility::_hasperk("specialty_killstreaks") && (var_0 == "airdrop_kill" || var_0 == "fritzx_kill" || var_0 == "mortar_strike_kill" || var_0 == "missile_strike_kill" || var_0 == "airstrike_kill" || var_0 == "firebomb_kill" || var_0 == "fighter_strike_kill" || var_0 == "plane_gunner_kill" || var_0 == "flamethrower_kill" || var_0 == "attack_dogs_kill" || var_0 == "paratroopers_kill" || var_0 == "molotovs_kill" || var_0 == "v2_rocket_kill")) {
      var_5 = maps\mp\gametypes\_rank::getscoreinfovalue("kill");
    } else {
      var_5 = maps\mp\gametypes\_rank::getscoreinfovalue(var_0);
    }
  }

  var_1.pers["score"] = var_1.pers["score"] + var_5 * level._id_696A;
}

_id_06D8(var_0, var_1) {
  if(var_1 == var_0.pers["score"]) {
    return;
  }
  var_0.pers["score"] = var_1;
  var_0.score = var_0.pers["score"];

  if(!level.teambased) {
    var_0 thread maps\mp\gametypes\_gamelogic::_id_21E3();
  }
}

_id_0638(var_0) {
  return var_0.pers["score"];
}

_id_47BD(var_0, var_1, var_2) {
  var_1 = var_1 * level._id_696A;
  _id_06DB(var_0, _id_063E(var_0) + var_1, var_2);
  level notify("update_team_score", var_0, _id_063E(var_0));
  _reconevent("script_mp_scoring: gameTime %d, team %s, score %d", gettime(), var_0, var_1);
  thread _id_47BE();
}

_id_47BE() {
  level endon("update_team_score");
  level endon("game_ended");
  waittillframeend;
  var_0 = _id_473F();

  if(!level.splitscreen && var_0 != "none" && var_0 != level._id_A87B && gettime() - level._id_5C00 > 5000 && maps\mp\_utility::getscorelimit() != 1 && level.gametype != "demo") {
    level._id_5C00 = gettime();
    maps\mp\_utility::leaderdialog("lead_taken", var_0, "status");

    if(level._id_A87B != "none") {
      maps\mp\_utility::leaderdialog("lead_lost", level._id_A87B, "status");
    }
  }

  if(var_0 != "none") {
    level._id_A87B = var_0;
    var_1 = _id_063E(var_0);
    var_2 = maps\mp\_utility::getwatcheddvar("scorelimit");

    if(maps\mp\_utility::_id_579B()) {
      return;
    }
    if(var_1 == 0 || var_2 == 0) {
      return;
    }
    var_3 = var_1 / var_2 * 100;

    if(var_3 > level._id_80AC) {
      _func_246(1);
    }
  }
}

_id_473F() {
  if(maps\mp\_utility::_id_761E()) {
    return "none";
  }

  var_0 = level._id_985B;
  var_1 = var_0[0];
  var_2 = game["teamScores"][var_0[0]];
  var_3 = 1;

  for(var_4 = 1; var_4 < var_0.size; var_4++) {
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

_id_06DB(var_0, var_1, var_2) {
  if(var_1 == game["teamScores"][var_0]) {
    return;
  }
  game["teamScores"][var_0] = var_1;
  _id_A174(var_0);

  if(maps\mp\_utility::inovertime() && !isDefined(level._id_6CD1) || isDefined(level._id_6CD1) && !level._id_6CD1) {
    thread maps\mp\gametypes\_gamelogic::_id_6B9B();
  } else {
    thread maps\mp\gametypes\_gamelogic::_id_21EA(var_0);

    if(var_2) {
      thread maps\mp\gametypes\_gamelogic::_id_21E3();
    }
  }
}

_id_A174(var_0) {
  var_1 = 0;

  if(!maps\mp\_utility::isroundbased() || !maps\mp\_utility::isobjectivebased()) {
    var_1 = _id_063E(var_0);
  } else {
    var_1 = game["roundsWon"][var_0];
  }

  _setteamscore(var_0, var_1);
}

_id_063E(var_0) {
  return game["teamScores"][var_0];
}

_id_83E3() {
  level notify("updating_scores");
  level endon("updating_scores");
  waitframe();
  maps\mp\_utility::waittillslowprocessallowed();

  foreach(var_1 in level.players) {
    var_1 updatescores();
  }
}

_id_83E2() {
  level notify("updating_dm_scores");
  level endon("updating_dm_scores");
  waitframe();
  maps\mp\_utility::waittillslowprocessallowed();

  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    level.players[var_0] updatedmscores();
    level.players[var_0]._id_A105 = 1;
  }
}

_id_7CD8() {
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

  if(level._id_6520) {
    _id_650D();
  }

  if(level.teambased) {
    _id_A173();
    return;
  }

  var_1 = level.placement["all"].size;

  for(var_3 = 0; var_3 < var_1; var_3++) {
    var_4 = level.placement["all"][var_3];
    var_4 notify("update_outcome");
  }
}

_id_A14D() {
  var_0 = [];

  foreach(var_2 in level.players) {
    if(isDefined(var_2._id_2583)) {
      continue;
    }
    if(var_2.pers["team"] == "spectator" || var_2.pers["team"] == "none") {
      continue;
    }
    var_0[var_0.size] = var_2;
  }

  for(var_4 = 1; var_4 < var_0.size; var_4++) {
    var_2 = var_0[var_4];
    var_5 = var_2.score;

    if(!level.teambased) {
      var_5 = var_2._id_008F;
    }

    for(var_6 = var_4 - 1; var_6 >= 0 && _id_4438(var_2, var_0[var_6]) == var_2; var_6--) {
      var_0[var_6 + 1] = var_0[var_6];
    }

    var_0[var_6 + 1] = var_2;
  }

  level.placement["all"] = var_0;

  if(level._id_6520) {
    _id_650D();
  } else if(level.teambased) {
    _id_A173();
  }
}

_id_4438(var_0, var_1) {
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

  if(common_scripts\utility::_id_24A6()) {
    return var_0;
  } else {
    return var_1;
  }
}

_id_A173() {
  var_0["allies"] = [];
  var_0["axis"] = [];
  var_0["spectator"] = [];
  var_1 = level.placement["all"];
  var_2 = var_1.size;

  for(var_3 = 0; var_3 < var_2; var_3++) {
    var_4 = var_1[var_3];
    var_5 = var_4.pers["team"];
    var_0[var_5][var_0[var_5].size] = var_4;
  }

  level.placement["allies"] = var_0["allies"];
  level.placement["axis"] = var_0["axis"];
}

_id_650D() {
  var_0["spectator"] = [];

  foreach(var_2 in level._id_985B) {
    var_0[var_2] = [];
  }

  var_4 = level.placement["all"];
  var_5 = var_4.size;

  for(var_6 = 0; var_6 < var_5; var_6++) {
    var_7 = var_4[var_6];
    var_8 = var_7.pers["team"];
    var_0[var_8][var_0[var_8].size] = var_7;
  }

  foreach(var_2 in level._id_985B) {
    level.placement[var_2] = var_0[var_2];
  }
}

_id_52DA() {
  wait 0.2;
  var_0 = 0;

  for(;;) {
    var_1 = 0;
    var_2 = level.players;

    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      var_4 = var_2[var_3];

      if(!isDefined(var_4)) {
        continue;
      }
      if(isDefined(var_4._id_A105)) {
        continue;
      }
      var_4._id_A105 = 1;
      var_4 updatedmscores();
      var_1 = 1;
      wait 0.5;
    }

    if(!var_1) {
      wait 3;
    }
  }
}