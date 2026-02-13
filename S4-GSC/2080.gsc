/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2080.gsc
*************************************************/

init() {
  level._id_EF63 = getdvarint("#x39feabf2a3bf54078");
  level._id_9C5D = _func_0302();
  var_0 = ["free", "axis", "allies", "team_three", "team_four", "team_five", "team_six", "team_seven", "team_eight", "team_nine", "team_ten", "team_eleven", "team_twelve", "team_thirteen", "team_fourteen", "team_fifteen", "team_sixteen", "team_seventeen", "team_eighteen", "team_nineteen", "team_twenty", "team_twenty_one", "team_twenty_two", "team_twenty_three", "team_twenty_four", "team_twenty_five", "team_twenty_six", "team_twenty_seven", "team_twenty_eight", "team_twenty_nine", "team_thirty", "team_thirty_one", "team_thirty_two", "team_thirty_three", "team_thirty_four", "team_thirty_five", "team_thirty_six", "team_thirty_seven", "team_thirty_eight", "team_thirty_nine", "team_forty", "team_forty_one", "team_forty_two", "team_forty_three", "team_forty_four", "team_forty_five", "team_forty_six", "team_forty_seven", "team_forty_eight", "team_forty_nine", "team_fifty", "team_fifty_one", "team_fifty_two", "team_fifty_three", "team_fifty_four", "team_fifty_five", "team_fifty_six", "team_fifty_seven", "team_fifty_eight", "team_fifty_nine", "team_sixty", "team_sixty_one", "team_sixty_two", "team_sixty_three", "team_sixty_four", "team_sixty_five", "team_sixty_six", "team_sixty_seven", "team_sixty_eight", "team_sixty_nine", "team_seventy", "team_seventy_one", "team_seventy_two", "team_seventy_three", "team_seventy_four", "team_seventy_five", "team_seventy_six", "team_seventy_seven", "team_seventy_eight", "team_seventy_nine", "team_eighty", "team_eighty_one", "team_eighty_two", "team_eighty_three", "team_eighty_four", "team_eighty_five", "team_eighty_six", "team_eighty_seven", "team_eighty_eight", "team_eighty_nine", "team_ninety", "team_ninety_one", "team_ninety_two", "team_ninety_three", "team_ninety_four", "team_ninety_five", "team_ninety_six", "team_ninety_seven", "team_ninety_eight", "team_ninety_nine", "team_hundred", "team_hundred_one", "team_hundred_two", "team_hundred_three", "team_hundred_four", "team_hundred_five", "team_hundred_six", "team_hundred_seven", "team_hundred_eight", "team_hundred_nine", "team_hundred_ten", "team_hundred_eleven", "team_hundred_twelve", "team_hundred_thirteen", "team_hundred_fourteen", "team_hundred_fifteen", "team_hundred_sixteen", "team_hundred_seventeen", "team_hundred_eightteen", "team_hundred_nineteen", "team_hundred_twenty", "team_hundred_twenty_one", "team_hundred_twenty_two", "team_hundred_twenty_three", "team_hundred_twenty_four", "team_hundred_twenty_five", "team_hundred_twenty_six", "team_hundred_twenty_seven", "team_hundred_twenty_eight", "team_hundred_twenty_nine", "team_hundred_thirty", "team_hundred_thirty_one", "team_hundred_thirty_two", "team_hundred_thirty_three", "team_hundred_thirty_four", "team_hundred_thirty_five", "team_hundred_thirty_six", "team_hundred_thirty_seven", "team_hundred_thirty_eight", "team_hundred_thirty_nine", "team_hundred_forty", "team_hundred_forty_one", "team_hundred_forty_two", "team_hundred_forty_three", "team_hundred_forty_four", "team_hundred_forty_five", "team_hundred_forty_six", "team_hundred_forty_seven", "team_hundred_forty_eight", "team_hundred_forty_nine", "team_hundred_fifty", "team_hundred_fifty_one", "team_hundred_fifty_two", "spectator", "follower"];
  level._id_15F0 = var_0;
  var_1 = ["axis", "allies"];
  var_2 = ["free", "spectator", "follower"];

  if(getdvarint("#x3965a86c0b17996d3") == 1) {
    var_1 = ["axis", "allies", "team_nine"];
  }

  var_3 = ["SAS", "RUSF", "USMC", "SABF"];
  var_4 = scripts\mp\utility\teams::_id_69B8();
  var_4 = min(var_4, getdvarint(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_teamcount"), -1));

  if(!isDefined(level._id_EF88)) {
    level._id_EF88 = var_4 == 50;
  }

  level.maxteamsize = getdvarint(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_teamsize"), 0);
  level._id_9CA6 = getdvarint(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_squadsize"), 4);
  var_5 = 1;
  var_6 = -1;
  var_7 = 3;

  if(var_4 >= 3) {
    for(var_8 = var_7; var_8 < var_4 + var_5; var_8++) {
      var_1[var_1.size] = level._id_15F0[var_8];

      if(!isDefined(game[level._id_15F0[var_8]])) {
        game[level._id_15F0[var_8]] = var_3[(var_8 + var_6) % var_3.size];
      }
    }
  }

  level._id_EF89 = var_1;
  level._id_A2FC = level._id_EF89.size > 2;
  level._id_EF6A = [];

  foreach(var_10 in var_1) {
    initteamdata(var_10);
  }

  foreach(var_10 in var_2) {
    initteamdata(var_10);
  }

  foreach(var_10 in var_1) {
    scripts\mp\utility\teams::_id_6DCC(var_10);
    scripts\mp\utility\teams::_id_6DD3(var_10);
    scripts\mp\utility\teams::_id_6DDA(var_10);
    scripts\mp\utility\teams::_id_6DD0(var_10);
    scripts\mp\utility\teams::_id_6DCF(var_10);
    scripts\mp\utility\teams::_id_6DDF(var_10);
  }

  level.teambased = var_4 > 1;
  setDvar("#x385597f6e444ad681", level._id_EF89.size);

  if(getdvarint("#x3a93070affbb9fe0d") > 1 && level.teambased) {
    level thread _id_09BD::_id_D56A(undefined, 1);
  }

  _id_0AA3::_id_C28D(::onplayerspawned);
  _id_0A97::_id_C28A(::_id_AB05);
  level thread _id_AAF6();
  level thread _id_AB91();
  level thread onplayerconnect();
  level thread _id_F428();
  _id_824C();
  _id_823A();
  wait 0.15;
  level thread _id_FD06();
  level thread _id_5A9D();

  if(level.teambased) {
    level thread _id_FD54();
  }

  if(scripts\mp\utility\game::matchmakinggame() && !_func_0394() && !scripts\mp\utility\game::isanymlgmatchignoreafk() && !getdvarint("#x3156d8b13d11c9bb3", 0)) {
    level thread _id_10A85();
  }

  if(getdvarint("#x3bbe0dbc496f44c25", 0) == 1) {
    level thread _id_44F2();
  }
}

initteamdata(var_0) {
  level._id_EF6A[var_0] = [];
  level._id_EF6A[var_0]["players"] = [];
  level._id_EF6A[var_0]["alivePlayers"] = [];
  level._id_EF6A[var_0]["teamCount"] = 0;
  level._id_EF6A[var_0]["aliveCount"] = 0;
  level._id_EF6A[var_0]["livesCount"] = 0;
  level._id_EF6A[var_0]["hasSpawned"] = 0;
  level._id_EF6A[var_0]["oneLeftTime"] = 0;
  level._id_EF6A[var_0]["twoLeft"] = 0;
  level._id_EF6A[var_0]["oneLeft"] = 0;
  level._id_EF6A[var_0]["noRespawns"] = 0;
  level._id_EF6A[var_0]["playagainHostXuid"] = "0";

  if(level._id_A2FC) {
    level._id_EF6A[var_0]["deathEvent"] = 0;
  }
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0._id_F242 = [];
    var_0._id_F242["game"] = 0;
    var_0._id_F242["total"] = 0;
    var_0._id_F242["missionTeam"] = 0;
    var_0._id_F242["other"] = 0;
    var_0._id_F242["timeDead"] = 0;
    var_0._id_F242["gulag"] = 0;
    var_0._id_F242["arena_evo_buy_round"] = 0;
  }
}

_id_AB05(var_0) {
  var_0 _id_FD5E();
}

_id_AB04(var_0) {
  if(isDefined(var_0.pers)) {
    var_0.pers["teamTime"] = undefined;
  }
}

_id_F428() {
  level endon("game_ended");
  _id_07D1::_id_60C2("prematch_done");

  while(!level.gameended) {
    wait 1.0;

    foreach(var_1 in level.players) {
      var_1 _id_F429();
    }
  }
}

_id_F429() {
  if(isDefined(self._id_F242)) {
    var_0 = self.sessionteam;

    if(!isDefined(self._id_F242["game"])) {
      self._id_F242["game"] = 0;
    } else {
      self._id_F242["game"]++;
    }

    if(var_0 != "spectator" && var_0 != "follower") {
      self._id_F242["total"]++;
      self._id_F242["missionTeam"]++;

      if(!scripts\mp\utility\player::isreallyalive(self)) {
        self._id_F242["timeDead"]++;
      }
    }
  }
}

_id_FD06() {
  level endon("game_ended");

  for(;;) {
    var_0 = level.players.size;

    for(var_1 = 0; var_1 < var_0; var_1 = var_1 + 20) {
      scripts\mp\hostmigration::waittillhostmigrationdone();

      for(var_2 = 0; var_2 < 20; var_2++) {
        var_3 = var_1 + var_2;
        var_4 = level.players[var_3];

        if(isDefined(var_4)) {
          var_4 _id_FCF4();
        }
      }

      waitframe();
    }

    wait 10.0;
  }
}

_id_5A9D() {
  while(!level.gameended) {
    wait 2.0;
  }

  foreach(var_1 in level.players) {
    var_1 _id_FCF4();

    if(!scripts\mp\utility\game::_id_CA4B()) {
      var_1 scripts\mp\persistence::_id_10FC3();
      var_1 scripts\mp\persistence::_id_FD88();
    }
  }
}

_id_FCF4() {
  if(isai(self)) {
    return;
  }
  _id_0804::_id_116C(self._id_F242["game"], "matchStats", "timePlayedTotal");
  scripts\mp\persistence::_id_E745("round", "timePlayed", self._id_F242["game"], 1);

  if(scripts\mp\gametypes\br_public::_id_8990()) {
    self._id_F242["gulag"] = self._id_F242["gulag"] + self._id_F242["game"];
  }

  if(scripts\mp\gametypes\arena_evo_tourney_util::_id_8602(self.pers["team"]) || !istrue(level._id_BB9D)) {
    self._id_F242["arena_evo_buy_round"] = self._id_F242["arena_evo_buy_round"] + self._id_F242["game"];
  }

  if(game["state"] == "postgame") {
    return;
  }
  self._id_F242["game"] = 0;
  self._id_F242["missionTeam"] = 0;
}

_id_FD5E() {
  if(game["state"] != "playing") {
    return;
  }
  self.pers["teamTime"] = gettime();
}

_id_FD55() {
  for(;;) {
    var_0 = getdvarint("#x39feabf2a3bf54078");

    if(level._id_EF63 != var_0) {
      level._id_EF63 = getdvarint("#x39feabf2a3bf54078");
    }

    wait 1;
  }
}

_id_FD54() {
  level thread _id_FD55();
  wait 0.15;

  if(level._id_EF63 && scripts\mp\utility\game::isroundbased()) {
    if(isDefined(game["BalanceTeamsNextRound"])) {
      scripts\mp\hud_message::_id_DCA4("MP/AUTOBALANCE_NEXT_ROUND");
    }

    level waittill("restarting");

    if(isDefined(game["BalanceTeamsNextRound"])) {
      level _id_20FA();
      game["BalanceTeamsNextRound"] = undefined;
    } else if(!_id_6DC5())
      game["BalanceTeamsNextRound"] = 1;
  } else {
    level endon("game_ended");

    for(;;) {
      if(level._id_EF63) {
        if(!_id_6DC5()) {
          scripts\mp\hud_message::_id_DCA4("MP/AUTOBALANCE_SECONDS", 15);
          wait 15.0;

          if(!_id_6DC5()) {
            level _id_20FA();
          }
        }

        wait 59.0;
      }

      wait 1.0;
    }
  }
}

_id_6DC5() {
  var_0["allies"] = 0;
  var_0["axis"] = 0;
  var_1 = level.players;

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(isDefined(var_1[var_2].pers["team"]) && var_1[var_2].pers["team"] == "allies") {
      var_0["allies"]++;
      continue;
    }

    if(isDefined(var_1[var_2].pers["team"]) && var_1[var_2].pers["team"] == "axis") {
      var_0["axis"]++;
    }
  }

  if(var_0["allies"] > var_0["axis"] + level._id_EF63 || var_0["axis"] > var_0["allies"] + level._id_EF63) {
    return 0;
  } else {
    return 1;
  }
}

_id_20FA() {
  iprintlnbold(game["strings"]["autobalance"]);
  var_0 = [];
  var_1 = [];
  var_2 = level.players;

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(!isDefined(var_2[var_3].pers["teamTime"])) {
      continue;
    }
    if(isDefined(var_2[var_3].pers["team"]) && var_2[var_3].pers["team"] == "allies") {
      var_0[var_0.size] = var_2[var_3];
      continue;
    }

    if(isDefined(var_2[var_3].pers["team"]) && var_2[var_3].pers["team"] == "axis") {
      var_1[var_1.size] = var_2[var_3];
    }
  }

  var_4 = undefined;

  while(var_0.size > var_1.size + 1 || var_1.size > var_0.size + 1) {
    if(var_0.size > var_1.size + 1) {
      for(var_5 = 0; var_5 < var_0.size; var_5++) {
        if(isDefined(var_0[var_5]._id_4D77)) {
          continue;
        }
        if(!isDefined(var_4)) {
          var_4 = var_0[var_5];
          continue;
        }

        if(var_0[var_5].pers["teamTime"] > var_4.pers["teamTime"]) {
          var_4 = var_0[var_5];
        }
      }

      var_4[[level._id_ABBF]]("axis");
    } else if(var_1.size > var_0.size + 1) {
      for(var_5 = 0; var_5 < var_1.size; var_5++) {
        if(isDefined(var_1[var_5]._id_4D77)) {
          continue;
        }
        if(!isDefined(var_4)) {
          var_4 = var_1[var_5];
          continue;
        }

        if(var_1[var_5].pers["teamTime"] > var_4.pers["teamTime"]) {
          var_4 = var_1[var_5];
        }
      }

      var_4[[level._id_ABBF]]("allies");
    }

    var_4 = undefined;
    var_0 = [];
    var_1 = [];
    var_2 = level.players;

    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      if(isDefined(var_2[var_3].pers["team"]) && var_2[var_3].pers["team"] == "allies") {
        var_0[var_0.size] = var_2[var_3];
        continue;
      }

      if(isDefined(var_2[var_3].pers["team"]) && var_2[var_3].pers["team"] == "axis") {
        var_1[var_1.size] = var_2[var_3];
      }
    }
  }
}

_id_B71C(var_0, var_1) {}

_id_3DA8() {
  var_0 = [];

  for(var_1 = 0; var_1 < level._id_EF89.size; var_1++) {
    var_0[level._id_EF89[var_1]] = 0;
  }

  for(var_1 = 0; var_1 < level.players.size; var_1++) {
    if(level.players[var_1] == self) {
      continue;
    }
    if(level.players[var_1].pers["team"] == "spectator") {
      continue;
    }
    if(level.players[var_1].pers["team"] == "follower") {
      continue;
    }
    if(isDefined(level.players[var_1].pers["team"])) {
      var_0[level.players[var_1].pers["team"]]++;
    }
  }

  return var_0;
}

_id_D4BE(var_0, var_1, var_2) {
  if(isDefined(self._id_7611)) {
    self detach(self._id_7611);
  }

  var_0 = self _meth_8128();
  var_1 = self _meth_8129();
  var_2 = self _meth_812C();
  self setModel(var_0);
  self _meth_83AB(var_2);
  self attach(var_1, "", 1);
  self._id_7611 = var_1;
}

_id_5E82(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  var_3 = [];

  switch (var_0) {
    case 1:
      var_1 = "mp_warfighter_body_1_3";
      var_2 = "mp_warfighter_head_1_3";
      break;
    case 2:
      var_1 = "mp_body_heavy_1_2";
      var_2 = "mp_head_heavy_1_2";
      break;
    case 3:
      if(scripts\mp\utility\game::getgametype() == "infect") {
        var_1 = "mp_synaptic_body_1_4";
        var_2 = "mp_synaptic_head_1_4";
      } else {
        var_1 = "mp_synaptic_body_1_1";
        var_2 = "mp_synaptic_head_1_1";
      }

      break;
    case 4:
      var_1 = "mp_ftl_body_3_1";
      var_2 = "mp_ftl_head_5_1";
      break;
    case 5:
      var_1 = "mp_stryker_body_2_1";
      var_2 = "mp_stryker_head_3_1";
      break;
    case 6:
      var_1 = "mp_ghost_body_1_3";
      var_2 = "mp_ghost_head_1_1";
      break;
  }

  self _meth_8526(var_1, var_2);
  var_4 = self _meth_8128();
  var_5 = self _meth_8129();
  var_6 = self _meth_812C();
  _id_D4BE(var_4, var_5, var_6);
}

_id_69B9() {
  var_0 = [];

  if(isDefined(self._id_AC3D)) {
    var_0["body"] = self._id_AC3D._id_25CA;
    var_0["head"] = self._id_AC3D._id_75DA;
  } else {
    var_1 = _id_6BD1();
    var_0["body"] = var_1[0];
    var_0["head"] = var_1[1];
  }

  return var_0;
}

_id_D5FC() {
  var_0 = _id_69B9();
  self _meth_8526(var_0["body"], var_0["head"]);
  var_1 = self _meth_8128();
  var_2 = self _meth_8129();
  var_3 = self _meth_812C();
  _id_D4BE(var_1, var_2, var_3);
}

_id_6C48() {
  return _id_6BD1();
}

_id_6C43() {
  var_0 = _id_6BD1();
  return var_0[0];
}

_id_6C51() {
  var_0 = _id_6BD1();
  return var_0[1];
}

_id_6C6E(var_0) {
  var_1 = _func_0222("mp/cac/bodies.csv", 1, var_0, 3);

  if(!isDefined(var_1) || var_1 == "") {
    var_1 = "viewhands_mp_base_iw8";
  }

  return var_1;
}

_id_6C4C(var_0) {
  return _func_0222("mp/cac/bodies.csv", 1, var_0, 5);
}

_id_6C57(var_0) {
  return _func_0222("mp/cac/bodies.csv", 0, var_0, 1);
}

_id_D8A1() {
  var_0 = 1;

  if(istrue(var_0)) {
    var_1 = undefined;
    var_2 = undefined;

    if(!isDefined(self._id_AC3D) || self._id_AC3D._id_C0E0 == 1) {
      _id_4028();
    }

    _id_D4BE(self._id_AC3D._id_45A5, self._id_AC3D._id_45B5, self._id_AC3D._id_45CF);
    scripts\mp\utility\player::_id_0CF0(self._id_AC3D._id_EAF7);
    _id_0790::_id_0C12(self._id_AC3D._id_56F2);

    if(!isai(self)) {
      self _meth_8300(self._id_39FC);
    }

    setupultraoperatorskins(self._id_AC3D._id_DD7A);
    return;
  }

  if(isai(self)) {
    var_3 = _id_09F1::_id_6CF8(self._id_965F) + 1;
  } else if(isDefined(self._id_33DA)) {
    var_3 = _id_09F1::_id_6CF8(self._id_33DA._id_1A35) + 1;
  } else {
    var_3 = getdvarint("#x31e1da5f3b6583e72", 0);
  }

  if(scripts\mp\utility\game::getgametype() == "infect" && self.team == "axis") {
    var_3 = 3;
  }

  if(isPlayer(self) && var_3 == 0) {
    _id_D5FC();
  } else {
    _id_5E82(var_3);
  }

  if(!isai(self)) {
    var_4 = _id_6C43();
    var_5 = _id_6C4C(var_4);
  } else
    self _meth_8300("vestLight");

  self._id_10691 = "delta";

  if(scripts\mp\utility\game::isanymlgmatch() && !isai(self)) {
    var_6 = _id_6C43();

    if(issubstr(var_6, "fullbody_sniper")) {
      thread _id_5E8D();
    }
  }
}

setupultraoperatorskins(var_0) {
  if(!self _meth_86EE() || !self _meth_8679("ultra_operators")) {
    return;
  }
  var_1 = _func_0222("loot/operator_skin_ids.csv", 0, var_0, 32);

  if(isDefined(var_1) && var_1 != "") {
    if(self _meth_867A("ultra_operators", var_1)) {
      self setscriptablepartstate("ultra_operators", var_1);
    } else if(self _meth_867A("ultra_operators", var_1 + "_0")) {
      self setscriptablepartstate("ultra_operators", var_1 + "_0");
    } else {
      self setscriptablepartstate("ultra_operators", "neutral");
    }
  } else
    self setscriptablepartstate("ultra_operators", "neutral");

  var_2 = _func_0222("loot/operator_skin_ids.csv", 0, var_0, 37);

  if(isDefined(var_2) && var_2 != "") {
    scripts\mp\utility\player::_id_0CF0(var_2);
  }
}

setultraoperatorskinreactivestage(var_0, var_1) {
  if(!self _meth_86EE() || !self _meth_8679("ultra_operators")) {
    return;
  }
  if(!isDefined(var_1)) {
    var_1 = self;
  }

  var_2 = var_1 getoperatorultrascriptablestate();

  if(isDefined(var_2) && var_2 != "") {
    var_3 = var_2 + "_" + var_0;

    if(self _meth_867A("ultra_operators", var_3)) {
      self setscriptablepartstate("ultra_operators", var_3);
    } else {
      self setscriptablepartstate("ultra_operators", var_2);
    }
  }
}

_id_4028() {
  var_0 = _id_6BD1();
  var_1 = var_0[0];
  var_2 = var_0[1];
  var_3 = var_0[2];

  if(!isagent(self)) {
    self _meth_8526(var_1, var_2);
    var_4 = self _meth_8128();
    var_5 = self _meth_8129();
    var_6 = self _meth_812C();
    var_7 = _id_6C6E(var_1);
  } else {
    var_4 = "body_opforce_london_terrorist_1_2";
    var_5 = "head_male_bc_03";
    var_6 = "viewmodel_mp_base_iw8";
    var_7 = "viewmodel_mp_base_iw8";
  }

  var_8 = _id_9817(self.team);
  var_9 = _id_9818(self.team);

  if(scripts\mp\utility\game::getgametype() == "infect" && self.team == "axis") {
    var_8 = "roland";
    var_9 = 33585707;
  }

  var_10 = spawnStruct();
  var_10._id_AC41 = var_8;
  var_10._id_DD7A = var_9;
  var_10._id_25CA = var_1;
  var_10._id_45A5 = var_4;
  var_10._id_75DA = var_2;
  var_10._id_45B5 = var_5;
  var_10._id_10431 = var_7;
  var_10._id_45CF = var_6;
  var_10._id_6285 = _id_6BD4(var_8);
  var_10._id_10691 = _id_6BD9(var_8);
  var_10.voiceprefix = getoperatorvoiceprefix(var_8);
  var_10.bayovoice = getoperatorbayovoice(var_8);
  var_10._id_EB25 = _id_6BD7(var_8);
  var_10._id_56F2 = _id_6BD2(var_8);
  var_10.pomintro = getoperatorpomintro(var_8);
  var_10.highlight = getoperatorhighlightintro(var_8);
  var_10._id_EAF7 = var_3;
  var_10._id_C0E0 = 0;
  var_11 = spawnStruct();
  var_11._id_195C = _id_6E3E("apc");
  var_11._id_1E32 = _id_6E3E("atv");
  var_11._id_326F = _id_6E3E("cargo_truck");
  var_11._id_8BA5 = _id_6E3E("jeep");
  var_11._id_9556 = _id_6E3E("little_bird");
  var_11._id_ECBE = _id_6E3E("tac_rover");
  var_11._id_EDEC = _id_6E3E("tank");

  if(istrue(game["isLaunchChunk"])) {
    if(isbot(self)) {
      if(self.team == "allies") {
        var_10._id_10691 = "ukft1";
      } else {
        var_10._id_10691 = "ruft1";
      }
    }
  }

  self._id_AC3D = var_10;
  self._id_102F5 = var_11;
  thread _id_084D::set_operator_context(var_8);
}

_id_981A(var_0) {
  if(!isPlayer(self) && !isai(self)) {
    return "";
  }

  var_1 = scripts\engine\utility::ter_op(var_0 == "allies", 1, 0);
  var_2 = self getentitynumber();
  var_3 = "";
  var_0 = scripts\engine\utility::ter_op(var_0 == "allies", "axis", "allies");

  if(level.gametype != "br") {
    if(level.teambased && !isai(self)) {
      if(!isDefined(level._id_B687[var_2][var_0])) {
        var_4 = spawnStruct();
        var_4._id_AC41 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operators", var_1);
        level._id_B687[var_2][var_0] = var_4;
      }

      var_3 = level._id_B687[var_2][var_0]._id_AC41;
    }
  }

  return var_3;
}

_id_9817(var_0) {
  if(!isPlayer(self) && !isai(self)) {
    return "";
  }

  var_1 = scripts\engine\utility::ter_op(var_0 == "allies", 0, 1);
  var_2 = scripts\mp\utility\game::getgametype() == "br";

  if(!level.teambased || var_2) {
    var_3 = undefined;

    if(isai(self)) {
      var_3 = self._id_293B;
    } else {
      var_3 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "selectedOperatorIndex");
    }

    var_1 = var_3;

    if(!isai(self) && !isDefined(self._id_45BD)) {
      if(var_1 == 0) {
        self._id_45BD = "allies";
      } else {
        self._id_45BD = "axis";
      }
    }
  }

  if(!isDefined(level._id_B687)) {
    level._id_B687 = [];
  }

  var_4 = self getentitynumber();

  if(!isDefined(level._id_B687[var_4])) {
    level._id_B687[var_4] = [];
  }

  var_5 = undefined;

  if(level.gametype == "infect" && var_0 == "axis") {
    var_6 = spawnStruct();
    var_6._id_AC41 = "roland";
    level._id_B687[var_4][var_0] = var_6;
  } else if(!isDefined(level._id_B687[var_4][var_0])) {
    var_6 = spawnStruct();

    if(isai(self)) {
      var_6._id_AC41 = self._id_293A;
    } else {
      var_7 = 0;
      var_6._id_AC41 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operators", var_7);
    }

    level._id_B687[var_4][var_0] = var_6;
  }

  var_5 = level._id_B687[var_4][var_0]._id_AC41;

  if(getdvarint("#x315cfcaa3e774ac5c", 1) == 1 && self _meth_878F()) {
    var_8 = getarraykeys(level._id_AC3D);

    if(!isDefined(self._id_75FD)) {
      foreach(var_10 in var_8) {
        var_11 = getarraykeys(level._id_AC3D[var_10]);

        if(!isDefined(level._id_7603)) {
          level._id_7603 = [];
        }

        if(!isDefined(level._id_7603[var_10]) || level._id_7603[var_10] > var_11.size) {
          level._id_7603[var_10] = 0;
        }

        for(var_12 = var_11[level._id_7603[var_10]]; isDefined(var_12) && var_12 == "s4_default"; var_12 = var_11[level._id_7603[var_10]]) {
          level._id_7603[var_10] = level._id_7603[var_10] + 1;

          if(level._id_7603[var_10] > var_11.size) {
            level._id_7603[var_10] = 0;
          }
        }

        level._id_7603[var_10] = level._id_7603[var_10] + 1;
        level._id_B687[var_4][var_10] = spawnStruct();
        level._id_B687[var_4][var_10]._id_AC41 = var_12;
      }

      self._id_75FD = 1;
    }

    if(isDefined(level._id_AC3D[var_0])) {
      var_5 = level._id_B687[var_4][var_0]._id_AC41;
    } else {
      if(!isDefined(self._id_293B)) {
        self._id_293B = scripts\engine\utility::random(var_8);
      }

      var_5 = level._id_B687[var_4][self._id_293B]._id_AC41;
    }
  }

  if(isai(self) || !isDefined(var_5) || var_5 == "") {
    if(isai(self)) {
      if(isDefined(self._id_293A)) {
        if(isDefined(level._id_B687[var_4][var_0]._id_AC41)) {
          var_5 = level._id_B687[var_4][var_0]._id_AC41;
        } else {
          var_5 = self._id_293A;
        }
      } else {
        _id_824C();

        if(!isDefined(self._id_293B)) {
          self._id_293B = self.team;

          if(!isDefined(level._id_AC3D[self._id_293B])) {
            var_8 = getarraykeys(level._id_AC3D);
            self._id_293B = scripts\engine\utility::random(var_8);
          }
        }

        var_0 = self._id_293B;

        if(!isDefined(self.pers["operatorIndex"])) {
          var_21 = randomint(12);
          var_15 = 0;
          var_22 = 0;

          foreach(var_19, var_18 in level._id_AC3D[var_0]) {
            var_24 = int(_func_0222("operators.csv", 1, var_19, 6));

            if(var_24) {
              if(var_21 == var_22) {
                break;
              }

              var_22++;
            }

            var_15++;
          }

          var_3 = var_15;
          self.pers["operatorIndex"] = var_3;
        } else
          var_3 = self.pers["operatorIndex"];

        var_15 = 0;

        foreach(var_19, var_18 in level._id_AC3D[var_0]) {
          if(var_15 == var_3) {
            self._id_293A = var_19;
            var_5 = var_19;
            break;
          }

          var_15++;
        }
      }
    } else
      var_5 = "wade";
  }

  return var_5;
}

_id_9818(var_0) {
  var_1 = _id_9817(var_0);
  var_2 = undefined;
  var_3 = self getentitynumber();

  if(scripts\mp\utility\game::getgametype() == "infect" && var_0 == "axis") {
    var_4 = spawnStruct();
    var_4._id_AC41 = "roland";
    level._id_B687[var_3][var_0] = var_4;
    self.pers["operatorSkinIndex"] = 33585707;
    var_2 = 33585707;
  } else {
    if(getdvarint("#x315cfcaa3e774ac5c", 1) == 1 && self _meth_878F()) {
      if(!isDefined(level._id_B687[var_3][var_0]._id_AC45)) {
        if(!isDefined(level._id_7602)) {
          _id_81A8();
        }

        var_5 = level._id_7602[var_1]["curIndex"];
        level._id_B687[var_3][var_0]._id_AC45 = level._id_7602[var_1]["lootIDs"][var_5];
        level._id_7602[var_1]["curIndex"] = level._id_7602[var_1]["curIndex"] + 1;

        if(level._id_7602[var_1]["curIndex"] >= level._id_7602[var_1]["maxIndex"]) {
          level._id_7602[var_1]["curIndex"] = 0;
        }
      }
    } else if(!isDefined(level._id_B687[var_3][var_0]._id_AC45)) {
      if(isai(self)) {
        if(!isDefined(self._id_2950)) {
          _id_293C(var_1);
        }

        level._id_B687[var_3][var_0]._id_AC45 = self._id_2950;
      } else
        level._id_B687[var_3][var_0]._id_AC45 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorCustomization", var_1, "skin");
    }

    var_2 = level._id_B687[var_3][var_0]._id_AC45;

    if(isai(self) && (!isDefined(var_2) || var_2 == 0) || !isDefined(var_2) || var_2 == 0) {
      if(isai(self)) {
        if(isDefined(self._id_2950)) {
          var_2 = self._id_2950;
        } else {
          _id_293C(var_1);
        }
      } else
        var_2 = 1;
    }
  }

  return var_2;
}

_id_293C(var_0) {
  var_1 = self.team;

  if(isDefined(self._id_293B)) {
    var_1 = self._id_293B;
  }

  if(!isDefined(self.pers["operatorSkinIndex"])) {
    var_4 = 0;

    foreach(var_7, var_6 in level._id_AC3D[var_1][var_0]) {
      if(issubstr(var_7, "_basic")) {
        var_9 = int(_func_0222("loot/operator_skin_ids.csv", 1, var_7, 0));
        self._id_2950 = var_9;
        var_10 = var_9;
        break;
      }

      var_4++;
    }

    self.pers["operatorSkinIndex"] = var_4;
  } else {
    var_11 = self.pers["operatorSkinIndex"];
    var_4 = 0;

    foreach(var_7, var_6 in level._id_AC3D[var_1][var_0]) {
      if(var_4 == var_11) {
        var_9 = int(_func_0222("loot/operator_skin_ids.csv", 1, var_7, 0));
        self._id_2950 = var_9;
        var_10 = var_9;
        break;
      }

      var_4++;
    }
  }
}

_id_B06F(var_0) {
  if(!isDefined(level._id_90EF)) {
    level._id_90EF = [];
    level._id_90EF["allies"] = 0;
    level._id_90EF["axis"] = 0;
  }

  if(!isDefined(self._id_90ED)) {
    if(level._id_90EF[var_0] == 2) {
      level._id_90EF[var_0] = 0;
    }

    self._id_90ED = level._id_90EF[var_0];
    level._id_90EF[var_0]++;
  }

  return self._id_90ED;
}

_id_6BD1() {
  var_0 = _id_9817(self.team);
  var_1 = _id_9818(self.team);
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;

  if(istrue(game["isLaunchChunk"])) {
    _id_8209();

    if(!isDefined(self.pers["defaultOperatorSkinIndex"])) {
      self.pers["defaultOperatorSkinIndex"] = _id_B06F(self.team);
    }

    var_2 = level._id_45BC[self.team]["body"][self.pers["defaultOperatorSkinIndex"]];
    var_3 = level._id_45BC[self.team]["head"][self.pers["defaultOperatorSkinIndex"]];
    var_4 = level._id_45BC[self.team]["suit"][0];
    var_5 = [];
    var_5[0] = var_2;
    var_5[1] = var_3;
    var_5[2] = var_4;
    return var_5;
  }

  if(var_0 == "s4_default" && var_1 == 36) {
    _id_817D();
    var_6 = level.teambased && scripts\mp\utility\game::getgametype() != "br";

    if(!isDefined(self._id_45BD) || var_6 && self._id_45BD != self.team && (self.team == "allies" || self.team == "axis")) {
      self._id_45BD = self.team;

      if(self.team != "allies" && self.team != "axis") {
        self._id_45BD = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), "allies", "axis");
      }
    }

    if(!isDefined(self.pers["defaultOperatorSkinIndex"])) {
      self.pers["defaultOperatorSkinIndex"] = 0;
    }

    var_2 = level._id_45BC[self._id_45BD]["body"][self.pers["defaultOperatorSkinIndex"]];

    if(!isDefined(self.pers["defaultOperatorHeadIndex"])) {
      self.pers["defaultOperatorHeadIndex"] = ::scripts\engine\utility::random(level._id_45BC[self._id_45BD]["head"][self.pers["defaultOperatorSkinIndex"]]);
    }

    var_3 = self.pers["defaultOperatorHeadIndex"];
    var_4 = "s4_suit_mp_wade";
  } else {
    if(isbot(self) && getdvarint("#x3fac27956b234c8fd", 0) != 0) {
      var_7 = getdvarint("#x3fac27956b234c8fd", 0);
      var_2 = _func_0222("loot/operator_skin_ids.csv", 0, var_7, 13);
      var_3 = _func_0222("loot/operator_skin_ids.csv", 0, var_7, 12);
    } else if(getdvarint("#x31a62c84c9e4799d8", 0) == 1) {
      var_8 = ["c_s4_rus_polina_02_a", "c_s4_usa_wade_02", "c_s4_mp_eng_arthur_02", "c_s4_mp_aus_lucas_02", "c_s4_mp_ger_roland_01_larger", "c_s4_mp_usa_daniel_01"];
      var_9 = ["head_mp_f_l_bailey_01", "head_mp_d_phillips_01", "head_mp_c_okonkwo_01", "head_mp_m_copping_01", "head_mp_j_kostrey_01", "head_mp_k_shimada_01"];
      var_10 = ["polina", "wade", "arthur", "lucas", "roland", "daniel"];

      if(!isDefined(level._id_1F90)) {
        level._id_1F90 = [];
        level._id_1F90["allies"] = [0, 1, 2, 3, 4, 5];
        level._id_1F90["axis"] = [0, 1, 2, 3, 4, 5];
      }

      if(scripts\mp\utility\game::isroundbased() && game["roundsPlayed"] > 0) {
        var_2 = _func_0222("loot/operator_skin_ids.csv", 0, self.pers["defaultOperatorSkinIndex"], 13);

        if(isDefined(var_2)) {
          self._id_D05F = scripts\engine\utility::_id_1BAB(var_8, var_2);
        }
      }

      if(!isDefined(self._id_D05F)) {
        if(!isDefined(level._id_AC42)) {
          level._id_AC42 = 0;
        }

        if(!isDefined(self.team) || !isDefined(level._id_1F90[self.team])) {
          self._id_D05F = 0;
        } else {
          self._id_D05F = level._id_1F90[self.team][randomint(level._id_1F90[self.team].size)];
        }
      }

      var_2 = var_8[self._id_D05F];
      var_3 = var_9[self._id_D05F];
      var_11 = var_10[self._id_D05F];
      self _meth_8526(var_2, var_3);
      var_12 = self getentitynumber();
      level._id_B687[var_12][self.team]._id_AC41 = var_11;
      level._id_B687[var_12][self.team]._id_AC45 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorCustomization", var_11, "skin");

      if(scripts\mp\utility\game::isroundbased()) {
        self.pers["defaultOperatorSkinIndex"] = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorCustomization", var_11, "skin");
      }
    } else {
      var_2 = _func_0222("loot/operator_skin_ids.csv", 0, var_1, 13);
      var_3 = _func_0222("loot/operator_skin_ids.csv", 0, var_1, 12);
    }

    var_4 = _func_0222("operators.csv", 1, var_0, 21);
  }

  self._id_25E5 = var_2;
  self._id_20C6 = var_3;
  self._id_20C7 = var_4;
  var_5 = [];
  var_5[0] = var_2;
  var_5[1] = var_3;
  var_5[2] = var_4;
  return var_5;
}

_id_8209() {
  if(isDefined(level._id_45BC)) {
    return;
  }
  level._id_45BC = [];
  level._id_45BC["allies"] = [];
  level._id_45BC["allies"]["body"] = ["c_s4_rus_polina_02_a"];
  level._id_45BC["allies"]["head"] = ["head_mp_f_l_bailey_01"];
  level._id_45BC["allies"]["suit"] = ["s4_suit_mp_polina"];
  level._id_45BC["axis"] = [];
  level._id_45BC["axis"]["body"] = ["c_s4_usa_wade_02"];
  level._id_45BC["axis"]["head"] = ["head_mp_d_phillips_01"];
  level._id_45BC["axis"]["suit"] = ["s4_suit_mp_wade"];
}

_id_817D() {
  if(isDefined(level._id_45BC)) {
    return;
  }
  level._id_45BC = [];
  level._id_45BC["allies"] = [];
  level._id_45BC["axis"] = [];

  switch (game["allies_outfit"]) {
    case "urban":
      level._id_45BC["allies"]["body"] = ["c_s4_rus_polina_02_a", "c_s4_usa_wade_02", "c_s4_mp_eng_arthur_02", "c_s4_mp_aus_lucas_02", "c_s4_mp_ger_roland_01_larger", "c_s4_mp_usa_daniel_01"];
      level._id_45BC["allies"]["head"][0] = ["head_mp_f_l_bailey_01"];
      level._id_45BC["allies"]["head"][1] = ["head_mp_d_phillips_01"];
      level._id_45BC["allies"]["head"][2] = ["head_mp_c_okonkwo_01"];
      level._id_45BC["allies"]["head"][3] = ["head_mp_m_copping_01"];
      level._id_45BC["allies"]["head"][4] = ["head_mp_j_kostrey_01"];
      level._id_45BC["allies"]["head"][5] = ["head_mp_k_shimada_01"];
      break;
    case "desert":
      level._id_45BC["allies"]["body"] = ["c_s4_rus_polina_02_a", "c_s4_usa_wade_02", "c_s4_mp_eng_arthur_02", "c_s4_mp_aus_lucas_02", "c_s4_mp_ger_roland_01_larger", "c_s4_mp_usa_daniel_01"];
      level._id_45BC["allies"]["head"][0] = ["head_mp_f_l_bailey_01"];
      level._id_45BC["allies"]["head"][1] = ["head_mp_d_phillips_01"];
      level._id_45BC["allies"]["head"][2] = ["head_mp_c_okonkwo_01"];
      level._id_45BC["allies"]["head"][3] = ["head_mp_m_copping_01"];
      level._id_45BC["allies"]["head"][4] = ["head_mp_j_kostrey_01"];
      level._id_45BC["allies"]["head"][5] = ["head_mp_k_shimada_01"];
      break;
    case "woodland":
      level._id_45BC["allies"]["body"] = ["c_s4_rus_polina_02_a", "c_s4_usa_wade_02", "c_s4_mp_eng_arthur_02", "c_s4_mp_aus_lucas_02", "c_s4_mp_ger_roland_01_larger", "c_s4_mp_usa_daniel_01"];
      level._id_45BC["allies"]["head"][0] = ["head_mp_f_l_bailey_01"];
      level._id_45BC["allies"]["head"][1] = ["head_mp_d_phillips_01"];
      level._id_45BC["allies"]["head"][2] = ["head_mp_c_okonkwo_01"];
      level._id_45BC["allies"]["head"][3] = ["head_mp_m_copping_01"];
      level._id_45BC["allies"]["head"][4] = ["head_mp_j_kostrey_01"];
      level._id_45BC["allies"]["head"][5] = ["head_mp_k_shimada_01"];
      break;
    default:
      level._id_45BC["allies"]["body"] = ["c_s4_rus_polina_02_a", "c_s4_usa_wade_02", "c_s4_mp_eng_arthur_02", "c_s4_mp_aus_lucas_02", "c_s4_mp_ger_roland_01_larger", "c_s4_mp_usa_daniel_01"];
      level._id_45BC["allies"]["head"][0] = ["head_mp_f_l_bailey_01"];
      level._id_45BC["allies"]["head"][1] = ["head_mp_d_phillips_01"];
      level._id_45BC["allies"]["head"][2] = ["head_mp_c_okonkwo_01"];
      level._id_45BC["allies"]["head"][3] = ["head_mp_m_copping_01"];
      level._id_45BC["allies"]["head"][4] = ["head_mp_j_kostrey_01"];
      level._id_45BC["allies"]["head"][5] = ["head_mp_k_shimada_01"];
  }

  switch (game["axis_outfit"]) {
    case "urban":
      level._id_45BC["axis"]["body"] = ["c_s4_rus_polina_02_a", "c_s4_usa_wade_02", "c_s4_mp_eng_arthur_02", "c_s4_mp_aus_lucas_02", "c_s4_mp_ger_roland_01_larger", "c_s4_mp_usa_daniel_01"];
      level._id_45BC["axis"]["head"][0] = ["head_mp_f_l_bailey_01"];
      level._id_45BC["axis"]["head"][1] = ["head_mp_d_phillips_01"];
      level._id_45BC["axis"]["head"][2] = ["head_mp_c_okonkwo_01"];
      level._id_45BC["axis"]["head"][3] = ["head_mp_m_copping_01"];
      level._id_45BC["axis"]["head"][4] = ["head_mp_j_kostrey_01"];
      level._id_45BC["axis"]["head"][5] = ["head_mp_k_shimada_01"];
      break;
    case "desert":
      level._id_45BC["axis"]["body"] = ["c_s4_rus_polina_02_a", "c_s4_usa_wade_02", "c_s4_mp_eng_arthur_02", "c_s4_mp_aus_lucas_02", "c_s4_mp_ger_roland_01_larger", "c_s4_mp_usa_daniel_01"];
      level._id_45BC["axis"]["head"][0] = ["head_mp_f_l_bailey_01"];
      level._id_45BC["axis"]["head"][1] = ["head_mp_d_phillips_01"];
      level._id_45BC["axis"]["head"][2] = ["head_mp_c_okonkwo_01"];
      level._id_45BC["axis"]["head"][3] = ["head_mp_m_copping_01"];
      level._id_45BC["axis"]["head"][4] = ["head_mp_j_kostrey_01"];
      level._id_45BC["axis"]["head"][5] = ["head_mp_k_shimada_01"];
      break;
    case "woodland":
      level._id_45BC["axis"]["body"] = ["c_s4_rus_polina_02_a", "c_s4_usa_wade_02", "c_s4_mp_eng_arthur_02", "c_s4_mp_aus_lucas_02", "c_s4_mp_ger_roland_01_larger", "c_s4_mp_usa_daniel_01"];
      level._id_45BC["axis"]["head"][0] = ["head_mp_f_l_bailey_01"];
      level._id_45BC["axis"]["head"][1] = ["head_mp_d_phillips_01"];
      level._id_45BC["axis"]["head"][2] = ["head_mp_c_okonkwo_01"];
      level._id_45BC["axis"]["head"][3] = ["head_mp_m_copping_01"];
      level._id_45BC["axis"]["head"][4] = ["head_mp_j_kostrey_01"];
      level._id_45BC["axis"]["head"][5] = ["head_mp_k_shimada_01"];
      break;
    default:
      level._id_45BC["axis"]["body"] = ["c_s4_rus_polina_02_a", "c_s4_usa_wade_02", "c_s4_mp_eng_arthur_02", "c_s4_mp_aus_lucas_02", "c_s4_mp_ger_roland_01_larger", "c_s4_mp_usa_daniel_01"];
      level._id_45BC["axis"]["head"][0] = ["head_mp_f_l_bailey_01"];
      level._id_45BC["axis"]["head"][1] = ["head_mp_d_phillips_01"];
      level._id_45BC["axis"]["head"][2] = ["head_mp_c_okonkwo_01"];
      level._id_45BC["axis"]["head"][3] = ["head_mp_m_copping_01"];
      level._id_45BC["axis"]["head"][4] = ["head_mp_j_kostrey_01"];
      level._id_45BC["axis"]["head"][5] = ["head_mp_k_shimada_01"];
  }
}

_id_B068(var_0) {
  if(getdvarint("#x31a62c84c9e4799d8", 0) == 1) {
    if(!isDefined(level._id_1F90)) {
      level._id_1F90 = [];
      level._id_1F90["allies"] = [0, 1, 2, 3, 4, 5];
      level._id_1F90["axis"] = [0, 1, 2, 3, 4, 5];
      level._id_1F90["team_three"] = level._id_1F90["allies"];
      level._id_1F90["team_four"] = level._id_1F90["allies"];
      level._id_1F90["team_five"] = level._id_1F90["allies"];
      level._id_1F90["team_six"] = level._id_1F90["allies"];
      level._id_1F90["team_seven"] = level._id_1F90["allies"];
      level._id_1F90["team_eight"] = level._id_1F90["allies"];
    }

    if(!isDefined(self.team) || !isDefined(level._id_1F90[self.team])) {
      self._id_D05F = 0;
    } else {
      self._id_D05F = level._id_1F90[self.team][randomint(level._id_1F90[self.team].size)];
    }
  } else {
    var_1 = 0;

    if(isDefined(var_0)) {
      var_2 = scripts\mp\utility\weapon::getweapongroup(var_0);

      switch (var_2) {
        case "weapon_assault":
          var_1 = 0;
          break;
        case "weapon_smg":
          var_1 = 1;
          break;
        case "weapon_dmr":
        case "weapon_sniper":
          var_1 = 2;
          break;
        case "weapon_lmg":
          var_1 = 3;
          break;
        case "weapon_shotgun":
          var_1 = 4;
          break;
        default:
          var_1 = 1;
          break;
      }
    }
  }

  return self._id_D05F;
}

_id_6A6D() {
  var_0 = self._id_034C;
  var_1 = scripts\mp\utility\weapon::getweapongroup(var_0);
  var_2 = self._id_966A;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;

  if(var_2 == "equip_helmet") {
    var_5 = "_blstk";
  } else {
    var_5 = "";
  }

  switch (self.team) {
    case "allies":
      var_6 = "usmc";

      if(_id_07D1::_id_60BE("infil_will_run") && !_id_07D1::_id_60BE("prematch_done")) {
        var_7 = "_wind";
      } else {
        var_7 = "";
      }

      switch (var_1) {
        case "weapon_shotgun":
        case "weapon_smg":
          var_3 = "_cqc";
          var_4 = "_cqc";
          break;
        case "weapon_assault":
          var_3 = "_ar";
          var_4 = "_ar";
          break;
        case "weapon_lmg":
          var_3 = "_ar";
          var_4 = "_lmg";
          break;
        case "weapon_dmr":
        case "weapon_sniper":
          var_3 = "_cqc";
          var_4 = "_cqc";
          break;
        default:
          var_3 = "_ar";
          var_4 = "_ar";
          break;
      }

      break;
    case "axis":
      var_6 = "sa_militia";
      var_7 = "";

      switch (var_1) {
        case "weapon_shotgun":
        case "weapon_smg":
          var_3 = "_cqc";
          var_4 = "_cqc";
          break;
        case "weapon_assault":
          var_3 = "_ar";
          var_4 = "_ar";
          break;
        case "weapon_lmg":
          var_3 = "_lmg";
          var_4 = "_lmg";
          break;
        case "weapon_dmr":
        case "weapon_sniper":
          var_3 = "_ar";
          var_4 = "_ar";
          break;
        default:
          var_3 = "_ar";
          var_4 = "_ar";
          break;
      }

      break;
    default:
      var_6 = "usmc";
      var_7 = "";
      var_3 = "_ar";
      var_4 = "_ar";
      break;
  }

  var_8 = "body_" + var_6 + var_3 + var_7;
  var_9 = "head_" + var_6 + var_4 + var_5;
  self._id_20C6 = "head_" + var_6 + var_4;
  self._id_25E5 = "body_" + var_6 + var_3;
  var_10 = [];
  var_10[0] = var_8;
  var_10[1] = var_9;
  return var_10;
}

_id_6A6E() {
  var_0 = self._id_034C;
  var_1 = scripts\mp\utility\weapon::getweapongroup(var_0);
  var_2 = self._id_966A;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;

  if(var_2 == "equip_helmet") {
    var_5 = "_blstk";
  } else {
    var_5 = "";
  }

  switch (self.team) {
    case "allies":
      var_6 = "sas_urban";

      if(_id_07D1::_id_60BE("infil_will_run") && !_id_07D1::_id_60BE("prematch_done")) {
        var_7 = "";
      } else {
        var_7 = "_rain";
      }

      switch (var_1) {
        case "weapon_shotgun":
        case "weapon_smg":
          var_3 = "_cqc";
          var_4 = "_mp_cqc";
          break;
        case "weapon_assault":
          var_3 = "_ar";
          var_4 = "_ar";
          break;
        case "weapon_lmg":
          var_3 = "_lmg";
          var_4 = "_lmg";
          break;
        case "weapon_dmr":
        case "weapon_sniper":
          var_3 = "_dmr";
          var_4 = "_mp_dmr";
          break;
        default:
          var_3 = "_ar";
          var_4 = "_ar";
          break;
      }

      break;
    case "axis":
      var_6 = "al_qatala";
      var_7 = "";

      switch (var_1) {
        case "weapon_lmg":
        case "weapon_dmr":
        case "weapon_sniper":
        case "weapon_assault":
        case "weapon_shotgun":
        case "weapon_smg":
          var_3 = "_1_ar";
          var_4 = "_ar";
          break;
        default:
          var_3 = "_1_ar";
          var_4 = "_ar";
          break;
      }

      break;
    default:
      var_6 = "usmc";
      var_7 = "";
      var_3 = "_ar";
      var_4 = "_ar";
      break;
  }

  var_8 = "body_" + var_6 + var_3 + var_7;
  var_9 = "head_" + var_6 + var_4 + var_7;
  self._id_20C6 = "head_" + var_6 + var_4;
  self._id_25E5 = "body_" + var_6 + var_3;
  var_10 = [];
  var_10[0] = var_8;
  var_10[1] = var_9;
  return var_10;
}

_id_5E8D() {
  if(self.team == "axis") {
    self setModel("mp_fullbody_heavy");
    self _meth_83AB("viewmodel_mp_base_iw8");
  } else {
    self setModel("mp_body_infected_a");
    self _meth_83AB("viewmodel_mp_base_iw8");
  }

  if(isDefined(self._id_7611)) {
    self detach(self._id_7611, "");
    self._id_7611 = undefined;
  }

  self attach("head_mp_infected", "", 1);
  self._id_7611 = "head_mp_infected";
  self _meth_8300("cloth");
}

_id_10A85() {
  if(getdvarint("#x3d1c9984568884f80", 0) == 1) {
    return;
  }
  if(scripts\mp\utility\game::_id_875D() || scripts\mp\utility\game::isanymlgmatchignoreafk()) {
    return;
  }
  _id_07D1::_id_60C2("prematch_done");

  if(isDefined(level.watchafkwaitflag)) {
    _id_07D1::_id_60C2(level.watchafkwaitflag);
  }

  var_0 = 0;

  for(;;) {
    var_0++;

    if(var_0 >= level.players.size) {
      var_0 = 0;
    }

    if(isDefined(level.players[var_0])) {
      if(isai(level.players[var_0])) {
        waitframe();
        continue;
      }

      level.players[var_0] _id_3500();
    }

    waitframe();
    scripts\mp\hostmigration::waittillhostmigrationdone();
  }
}

_id_AB91() {
  level waittill("round_switch");
  closeallafkwarnings();
}

_id_AAF6() {
  while(!level.gameended) {
    wait 1;
  }

  closeallafkwarnings();
}

closeallafkwarnings() {
  var_0 = level.players;

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(var_2 _id_079F::_id_CF64("KickPlayerWarning")) {
      var_2 destroykickwarningwidget();
    }
  }
}

createkickwarningwidget() {
  if(!isDefined(level.widget_struct)) {
    level.widget_struct = spawnStruct();
    _id_079F::_id_CF62("KickPlayerWarning", "scripted_widget_afk_warning", level.widget_struct);
  }

  self setclientomnvar("ui_afk_player_kick_warning", 1);
}

destroykickwarningwidget() {
  if(isDefined(level.widget_struct)) {
    _id_079F::_id_CF63("KickPlayerWarning");
  }

  self setclientomnvar("ui_afk_player_kick_warning", 0);
}

_id_3500() {
  if(istrue(level.gameended) || !istrue(self._id_75B4)) {
    return;
  }
  var_0 = 0;
  var_1 = 0;
  var_2 = scripts\mp\persistence::_id_E761("round", "timePlayed", 0);
  var_2 = int(max(var_2 - self._id_F242["timeDead"], 0));

  if(istrue(self._id_2BF2)) {
    return;
  }
  if(scripts\mp\utility\game::getgametype() == "br") {
    if(self.sessionstate == "spectator" || self.sessionstate == "intermission") {
      return;
    }
    if(scripts\mp\gametypes\br_public::_id_8990()) {
      return;
    }
    var_2 = var_2 - self._id_F242["gulag"];
  }

  if(scripts\mp\utility\game::_id_875D()) {
    if(self.sessionstate == "spectator" || self.sessionstate == "intermission") {
      return;
    }
    if(scripts\mp\gametypes\arena_evo_tourney_util::_id_8602(self.pers["team"])) {
      return;
    }
    if(!istrue(level._id_BB9D)) {
      return;
    }
    var_2 = var_2 - self._id_F242["arena_evo_buy_round"];
  }

  if(scripts\mp\utility\game::isarmsracegametype()) {
    if(scripts\mp\gametypes\s4_base_util::is_player_active()) {
      return;
    }
  }

  if(istrue(self._id_75AA)) {
    return;
  }
  if(!isDefined(self._id_F243)) {
    return;
  }
  var_3 = self._id_F243;
  var_4 = self.pers["kills"];
  var_5 = self.pers["assists"];
  var_6 = var_4 == 0 && var_5 == 0;
  var_7 = var_2 - var_3;
  var_7 = var_7 - self.pers["afkResetTime"];
  var_8 = 60;

  if(scripts\mp\utility\game::getgametype() == "sd") {
    var_8 = 30;
  }

  if(scripts\mp\utility\game::_id_875E()) {
    var_8 = 15;
  }

  if(scripts\mp\utility\game::_id_875D()) {
    var_8 = scripts\mp\gametypes\arena_evo_tourney_util::arena_evo_getafkchecktime();
  }

  if(scripts\mp\utility\game::getgametype() == "base") {
    var_8 = scripts\mp\gametypes\s4_base_util::base_getafkchecktimeseconds();
  }

  if(scripts\mp\utility\game::getgametype() == "br" && istrue(self._id_2BD6)) {
    self._id_2BD6 = undefined;
    var_8 = 30;
  }

  if(scripts\mp\utility\game::isroundbased() && scripts\mp\utility\game::getgametype() != "ctf") {
    var_9 = var_6 || scripts\mp\utility\game::_id_875E();

    if(!scripts\mp\utility\game::_id_875E()) {
      if(var_6 && var_7 > 110 && istrue(level._id_8CDC)) {
        var_10 = var_7 > 120;

        switch (level.gametype) {
          case "gun":
            if(isDefined(self._id_8FB6)) {
              var_11 = gettime();
              var_12 = var_11 - self._id_8FB6;
              var_1 = 50000 < var_12;
              var_0 = var_10 && 60000 < var_12;
            } else {
              var_1 = 1;
              var_0 = var_10;
            }

            break;
        }
      }
    }

    if(var_9 && !isDefined(self.pers["distTrackingPassed"]) && var_7 >= var_8 - 10) {
      var_10 = var_7 >= var_8;

      if(scripts\mp\utility\game::getgametype() == "infect") {
        if(self.team == "axis") {
          var_1 = 1;
          var_0 = var_10;
        }
      } else if(isDefined(self._id_9055)) {
        var_11 = gettime();
        var_13 = var_11 - self._id_9055;
        var_1 = var_13 > 1000;
        var_0 = var_10 && var_13 > 11000;
      } else {
        var_1 = 1;
        var_0 = var_10;
      }
    }

    if(!isDefined(self.pers["roundsAFK"])) {
      self.pers["roundsAFK"] = 0;
    }

    if(!isgamebattlematch() && !scripts\mp\utility\game::isanymlgmatchignoreafk() && !istrue(self._id_11E5)) {
      if(var_1) {
        createkickwarningwidget();
      } else {
        destroykickwarningwidget();
      }

      if(var_0) {
        self._id_11E5 = 1;
        self.pers["roundsAFK"]++;

        if(self.pers["roundsAFK"] > 1) {
          level thread _id_8CE0(self);
        }
      }
    }

    return;
  } else {
    if(var_6 && var_7 >= var_8 - 10) {
      var_14 = isDefined(self.pers["distTrackingPassed"]);

      if(!var_14) {
        var_10 = var_7 >= var_8;

        if(scripts\mp\utility\game::getgametype() == "infect") {
          if(self.team == "axis") {
            var_0 = var_10;
            var_1 = 1;
          }
        } else {
          var_0 = var_10;
          var_1 = 1;
        }
      }
    }

    if(var_6 && var_7 > 110 && istrue(level._id_8CDC)) {
      var_10 = var_7 > 120;

      switch (level.gametype) {
        default:
          break;
      }
    }
  }

  if(!isgamebattlematch() && !scripts\mp\utility\game::isanymlgmatchignoreafk()) {
    if(var_1) {
      createkickwarningwidget();
    } else {
      destroykickwarningwidget();
    }

    if(var_0) {
      level thread _id_8CE0(self);
    }
  }
}

_id_8CE0(var_0) {
  var_0 endon("disconnect");
  var_0 notify("afk_disconnection_imminent");
  wait 1;
  kick(var_0 getentitynumber(), "EXE/PLAYERKICKED_INACTIVE", 1);
}

_id_6AD1(var_0) {
  var_1 = 0;
  var_2 = 0;
  var_3 = level.players;

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    var_5 = var_3[var_4];

    if(isDefined(var_5.pers["team"]) && var_5.pers["team"] == var_0) {
      var_1++;

      if(isbot(var_5)) {
        var_2++;
      }
    }
  }

  if(level.maxteamsize == 0 || var_1 < level.maxteamsize) {
    return 1;
  } else if(scripts\mp\utility\game::getgametype() == "vip" && istrue(isagent(self))) {
    return 1;
  } else if(var_2 > 0) {
    return 1;
  } else if(!scripts\mp\utility\game::matchmakinggame()) {
    return 1;
  } else if(scripts\mp\utility\game::getgametype() == "infect") {
    return 1;
  } else if(scripts\mp\utility\game::getgametype() == "br" && getDvar("#x3f59526763711edc4", "") == "dmz") {
    return 1;
  } else {
    _func_03BF("mp_exceeded_team_max_error", ["player_xuid", self getxuid(), "isHost", self ishost()]);

    if(self ishost()) {
      wait 1.5;
    }

    kick(self getentitynumber(), "EXE/PLAYERKICKED_INVALIDTEAM");
    return 0;
  }
}

onplayerspawned() {
  if(!isDefined(self._id_F243)) {
    self._id_F243 = scripts\mp\persistence::_id_E761("round", "timePlayed");
  }

  if(getdvarint("#x332850d13e69f8a26", 0) == 1 && !scripts\mp\utility\game::_id_CA4B()) {
    if(scripts\mp\utility\game::_id_8A5F()) {
      thread _id_ACFF();
    } else {
      thread _id_ACDA();
    }
  }

  if(getdvarint("#x378d71de0aa7d8bb3", 0) == 1) {
    thread outlineenemy_apply();
  }
}

_id_D5C3() {
  var_0 = "c_s4_usa_juggernaut_01";
  var_1 = undefined;
  var_2 = "viewhands_juggernaut";
  self _meth_8526(var_0, var_1);
  _id_D4BE(var_0, var_1, var_2);
}

outlineenemy_apply(var_0, var_1) {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(!level.teambased) {
    return;
  }
  if(getdvarint("#x378d71de0aa7d8bb3", 0) == 0) {
    return;
  }
  if(scripts\cp_mp\utility\game_utility::_id_89EC()) {
    return;
  }
  if(!isDefined(self) || _func_0458(self) || !isDefined(self.team)) {
    return;
  }
  if(_id_07D1::_id_60BE("infil_will_run") && !istrue(_id_07D1::_id_60BE("prematch_done"))) {
    level waittill("prematch_over");
  }

  if(istrue(var_0)) {
    wait 1;
  }

  var_2 = "outline_depth_red";
  var_3 = undefined;
  var_4 = scripts\mp\utility\teams::_id_6A01(self.team)[0];

  if(isDefined(var_1) && !_func_0107(var_1)) {
    var_3 = scripts\mp\utility\outline::_id_ACD2(self, var_4, var_2, "level_script", var_1);
  } else {
    var_3 = scripts\mp\utility\outline::_id_ACD2(self, var_4, var_2, "level_script");
  }

  self _meth_8804(0.5);

  if(isDefined(var_3)) {
    thread _id_ACDB(var_3);
  }
}

_id_ACDA(var_0, var_1) {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(!level.teambased) {
    return;
  }
  if(getdvarint("#x3e138924b10a94dfa", 1) == 0) {
    return;
  }
  if(scripts\cp_mp\utility\game_utility::_id_89EC()) {
    return;
  }
  if(!isDefined(self) || _func_0458(self) || !isDefined(self.team)) {
    return;
  }
  if(_id_07D1::_id_60BE("infil_will_run") && !istrue(_id_07D1::_id_60BE("prematch_done"))) {
    level waittill("prematch_over");
  }

  if(istrue(var_0)) {
    wait 1;
  }

  var_2 = "arms_race_ally";
  var_3 = undefined;

  if(isDefined(var_1) && _func_0107(var_1) && var_1.size > 0) {
    var_3 = scripts\mp\utility\outline::outlineenableforteam_vehicle(self, self.team, var_2, "level_script", var_1);
  } else if(isDefined(var_1) && !_func_0107(var_1)) {
    var_3 = scripts\mp\utility\outline::_id_ACD2(self, self.team, var_2, "level_script", var_1);
  } else {
    var_3 = scripts\mp\utility\outline::_id_ACD2(self, self.team, var_2, "level_script");
  }

  self _meth_8804(0.5);

  if(isDefined(var_3)) {
    thread _id_ACDB(var_3);
  }
}

outlinefriendlyvehicle_apply(var_0, var_1, var_2) {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(!level.teambased) {
    return;
  }
  if(getdvarint("#x3e138924b10a94dfa", 1) == 0) {
    return;
  }
  if(!isDefined(self) || !isDefined(self.team)) {
    return;
  }
  if(scripts\cp_mp\utility\game_utility::_id_89EC()) {
    return;
  }
  if(_id_07D1::_id_60BE("infil_will_run") && !istrue(_id_07D1::_id_60BE("prematch_done"))) {
    level waittill("prematch_over");
  }

  if(istrue(var_2)) {
    var_3 = self.vehicle._id_ADAE;
  } else {
    var_3 = self._id_ADAE;
  }

  var_4 = "arms_race_ally";
  var_5 = [];

  if(!isDefined(self._id_A924) && scripts\engine\utility::is_equal(var_1, "enter")) {
    var_5 = [var_0];
  } else if(isDefined(self._id_A924) && scripts\engine\utility::is_equal(var_1, "enter")) {
    var_5 = self._id_A924;

    if(!scripts\engine\utility::array_contains(var_5, var_0)) {
      var_5 = scripts\engine\utility::array_add(var_5, var_0);
    }
  } else if(isDefined(self._id_A924) && scripts\engine\utility::is_equal(var_1, "exit"))
    var_5 = scripts\engine\utility::array_remove(self._id_A924, var_0);

  var_6 = scripts\mp\utility\outline::outlineenableforteam_vehicle(self, var_3, var_4, "level_script", var_5);

  if(isDefined(var_6)) {
    if(istrue(var_2)) {
      outlinefriendlyvehicle_turret_remove(var_6);
    } else {
      thread outlinefriendlyvehicle_remove(var_6);
      self._id_ACE5 = var_6;
    }
  }
}

_id_ACDB(var_0) {
  level endon("game_ended");
  scripts\engine\utility::waittill_any_3("death_or_disconnect", "joined_team", "clear_outline");
  scripts\mp\utility\outline::outlinedisable(var_0, self);
}

outlinefriendlyvehicle_remove(var_0) {
  level endon("game_ended");
  scripts\engine\utility::waittill_any_2("death", "vehicle_enter_exit");
  scripts\mp\utility\outline::outlinedisable(var_0, self);
}

outlinefriendlyvehicle_occupantupdate(var_0, var_1) {
  var_2 = [];

  if(!isDefined(self._id_A924) && scripts\engine\utility::is_equal(var_1, "enter")) {
    return;
  } else if(isDefined(self._id_A924) && scripts\engine\utility::is_equal(var_1, "enter")) {
    var_2 = self._id_A924;

    if(!scripts\engine\utility::array_contains(var_2, var_0)) {
      var_2 = scripts\engine\utility::array_add(var_2, var_0);
    }
  } else if(isDefined(self._id_A924) && scripts\engine\utility::is_equal(var_1, "exit"))
    var_2 = scripts\engine\utility::array_remove(self._id_A924, var_0);

  foreach(var_4 in var_2) {
    var_4 notify("clear_outline");
    var_4 thread _id_ACDA(0, var_2);
  }

  if(scripts\engine\utility::is_equal(var_1, "exit")) {
    var_0 notify("clear_outline");
    var_0 thread _id_ACDA();

    if(var_2.size == 0) {
      self notify("vehicle_enter_exit");
    }
  }
}

outlinefriendlyvehicle_turret_remove(var_0) {
  level endon("game_ended");
  self.vehicle scripts\engine\utility::waittill_any_2("death_or_disconnect", "vehicle_enter_exit");
  scripts\mp\utility\outline::outlinedisable(var_0, self);
}

_id_ACFF() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(scripts\mp\utility\game::_id_CA4B()) {
    return;
  }
  if(!level.teambased) {
    return;
  }
  if(getdvarint("#x3498d92a640eb94fd", 1) == 0) {
    return;
  }
  if(scripts\cp_mp\utility\game_utility::_id_89EC()) {
    return;
  }
  if(_id_07D1::_id_60BE("infil_will_run") && !istrue(_id_07D1::_id_60BE("prematch_done"))) {
    level waittill("prematch_over");
  }

  var_0 = scripts\engine\utility::ter_op(scripts\cp_mp\utility\game_utility::isnightmap(), "outline_squad_night", "outline_squad");
  var_1 = scripts\mp\utility\outline::_id_ACD1(self, self.team, self._id_E496, var_0, "level_script");
  thread _id_AD00(var_1);
}

_id_AD00(var_0) {
  level endon("game_ended");
  scripts\engine\utility::waittill_any_3("death_or_disconnect", "joined_team", "joined_squad");
  scripts\mp\utility\outline::outlinedisable(var_0, self);
}

getoperatorpomintro(var_0) {
  if(isbot(self)) {
    var_1 = "34074435";
  } else {
    var_1 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorCustomization", var_0, "intro");
  }

  self.loadoutintro = _func_0222("loot/playofmatchintro_ids.csv", 0, var_1, 1);

  if(!isDefined(self.loadoutintro)) {
    self.loadoutintro = _func_0222("operators.csv", 1, var_0, 30);
  }

  self.loadoutintro = validateplayerloadoutpomintro();
  return self.loadoutintro;
}

getoperatorhighlightintro(var_0) {
  if(isbot(self)) {
    var_1 = "33684435";
  } else {
    var_1 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorCustomization", var_0, "taunt");
  }

  self.loadouthighlight = _func_0222("loot/fatality_ids.csv", 0, var_1, 1);

  if(!isDefined(self.loadouthighlight)) {
    self.loadouthighlight = _func_0222("operators.csv", 1, var_0, 31);
  }

  self.loadouthighlight = validateplayerloadouthighlight();
  return self.loadouthighlight;
}

validateplayerloadouthighlight() {
  var_0 = self.loadouthighlight;
  var_1 = _func_0222("postMatchFlowAnimations.csv", 0, var_0, 0) != "";

  if(!var_1) {
    return _id_0828::get_default_fatality_ref();
  }

  return var_0;
}

validateplayerloadoutpomintro() {
  var_0 = self.loadoutintro;
  var_1 = _func_0222("postMatchFlowAnimationsIntros.csv", 0, var_0, 0) != "";

  if(!var_1) {
    return _id_0828::get_default_pom_intro();
  }

  return var_0;
}

_id_6BD2(var_0) {
  var_1 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorCustomization", var_0, "execution");
  self._id_966C = _func_0222("loot/executions_ids.csv", 0, var_1, 1);

  if(!isDefined(self._id_966C)) {
    self._id_966C = _func_0222("operators.csv", 1, var_0, 26);
  }

  return self._id_966C;
}

_id_6BD7(var_0) {
  var_1 = _func_0222("operators.csv", 1, var_0, 3);
  return int(var_1);
}

_id_6BD9(var_0) {
  var_1 = _func_0222("operators.csv", 1, var_0, 10);
  return var_1;
}

getoperatorvoiceprefix(var_0) {
  var_1 = _func_0222("operators.csv", 1, var_0, 14);
  return "mp_" + var_1;
}

getoperatorbayovoice(var_0) {
  var_1 = _func_0222("operators.csv", 1, var_0, 33);
  return var_1;
}

_id_6BD4(var_0) {
  var_1 = scripts\engine\utility::ter_op(_func_0222("operators.csv", 1, var_0, 11) == "0", "male", "female");
  return var_1;
}

_id_6E3E(var_0) {
  var_1 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "vehicleCustomization", var_0, "camo");
  var_2 = _func_0222("mp_cp/vehiclecamos.csv", 6, var_1, 5);
  return var_2;
}

_id_823A() {
  if(!scripts\cp_mp\utility\game_utility::isnightmap()) {
    return;
  }
  level._id_A7BB = [];
  var_0 = 0;

  for(;;) {
    var_1 = tablelookupbyrow("loot/operator_skin_ids.csv", var_0, 12);
    var_2 = tablelookupbyrow("loot/operator_skin_ids.csv", var_0, 20);
    var_3 = tablelookupbyrow("loot/operator_skin_ids.csv", var_0, 19);

    if(!isDefined(var_1) || var_1 == "") {
      break;
    }

    if(var_2 != "") {
      level._id_A7BB[var_1]["up"] = var_2;
    }

    if(var_3 != "") {
      level._id_A7BB[var_1]["down"] = var_3;
    }

    var_0++;
  }

  level._id_A7BB["head_mp_eastern_fireteam_east_ar_1"]["up"] = "none";
  level._id_A7BB["head_mp_eastern_fireteam_east_ar_1_2"]["up"] = "none";
  level._id_A7BB["head_mp_eastern_fireteam_east_ar_1_3"]["up"] = "none";
  level._id_A7BB["head_mp_eastern_fireteam_east_ar_2"]["up"] = "none";
  level._id_A7BB["head_mp_eastern_fireteam_east_ar_2_2"]["up"] = "none";
  level._id_A7BB["head_mp_eastern_fireteam_east_ar_2_3"]["up"] = "none";
  level._id_A7BB["head_mp_eastern_fireteam_east_lmg"]["up"] = "none";
}

_id_81A8() {
  if(isDefined(level._id_7602)) {
    return;
  }
  level._id_7602 = [];
  var_0 = tablelookupgetnumrows("loot/operator_skin_ids.csv");

  for(var_1 = 0; var_1 < var_0; var_1++) {
    if(tablelookupbyrow("loot/operator_skin_ids.csv", var_1, 11) != "") {
      var_2 = tablelookupbyrow("loot/operator_skin_ids.csv", var_1, 16);
      var_3 = tablelookupbyrow("loot/operator_skin_ids.csv", var_1, 0);

      if(!isDefined(level._id_7602[var_2])) {
        level._id_7602[var_2]["lootIDs"] = [];
        level._id_7602[var_2]["curIndex"] = 0;
        level._id_7602[var_2]["maxIndex"] = 0;
      }

      level._id_7602[var_2]["lootIDs"][level._id_7602[var_2]["lootIDs"].size] = int(var_3);
      level._id_7602[var_2]["maxIndex"] = level._id_7602[var_2]["maxIndex"] + 1;
    }
  }
}

_id_824C() {
  if(isDefined(level._id_AC3D)) {
    return;
  }
  level._id_AC3D = [];
  setDvar("#x375dfc4b0b749d186", 1);
  var_8 = 0;

  for(;;) {
    var_9 = tablelookupbyrow("operators.csv", var_8, 1);
    var_10 = _id_6BD7(var_9);
    var_11 = scripts\engine\utility::ter_op(var_10 == 0, "allies", "axis");

    if(!isDefined(var_9) || var_9 == "") {
      break;
    }

    var_12 = int(tablelookupbyrow("operators.csv", var_8, 8));

    if(var_12) {
      if(!isDefined(level._id_AC3D[var_11])) {
        level._id_AC3D[var_11] = [];
      }

      level._id_AC3D[var_11][var_9] = [];
    }

    var_8++;
  }

  var_16 = 0;

  for(;;) {
    var_17 = int(tablelookupbyrow("loot/operator_skin_ids.csv", var_16, 25));
    var_18 = tablelookupbyrow("loot/operator_skin_ids.csv", var_16, 1);

    if(!isDefined(var_18) || var_18 == "") {
      break;
    }

    if(var_17) {
      var_9 = tablelookupbyrow("loot/operator_skin_ids.csv", var_16, 16);
      var_19 = tablelookupbyrow("loot/operator_skin_ids.csv", var_16, 13);
      var_20 = tablelookupbyrow("loot/operator_skin_ids.csv", var_16, 12);
      var_11 = _id_6BD8(var_9);

      if(!isDefined(var_11)) {
        var_16++;
        continue;
      }

      var_21 = [];
      var_21[0] = var_19;
      var_21[1] = var_20;
      level._id_AC3D[var_11][var_9][var_18] = var_21;
    }

    var_16++;
  }
}

_id_6BD8(var_0) {
  foreach(var_6, var_2 in level._id_AC3D) {
    foreach(var_5, var_4 in var_2) {
      if(var_5 == var_0) {
        return var_6;
      }
    }
  }

  return undefined;
}

_id_6B8A(var_0, var_1) {
  if(!var_1) {
    var_2 = 0;

    foreach(var_5, var_4 in level._id_AC3D[self.team]) {
      if(var_0 == var_5) {
        break;
      }

      var_2++;
    }

    var_6 = undefined;
    var_7 = var_2 + 1;

    if(var_7 == level._id_AC3D[self.team].size) {
      var_7 = 0;
    }

    return var_7;
  } else
    return randomint(level._id_AC3D[self.team].size);
}

_id_6B8F(var_0, var_1) {
  if(!var_1) {
    var_2 = self getentitynumber();

    if(!isDefined(level._id_B687)) {
      level._id_B687 = [];
    }

    var_3 = undefined;

    if(!isDefined(level._id_B687[var_2])) {
      level._id_B687[var_2] = [];
    }

    if(!isDefined(level._id_B687[var_2][self.team])) {
      var_4 = spawnStruct();
      var_4._id_AC41 = var_0;

      if(isai(self)) {
        var_4._id_AC45 = self._id_2950;
      } else {
        var_4._id_AC45 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorCustomization", var_0, "skin");
      }

      level._id_B687[var_2][self.team] = var_4;
    }

    var_3 = level._id_B687[var_2][self.team]._id_AC45;
    var_5 = _func_0222("loot/operator_skin_ids.csv", 0, var_3, 1);
    var_6 = 0;

    foreach(var_9, var_8 in level._id_AC3D[self.team][var_0]) {
      if(var_5 == var_9) {
        break;
      }

      var_6++;
    }

    var_10 = var_6 + 1;

    if(var_10 == level._id_AC3D[self.team][var_0].size) {
      var_10 = 0;
    }

    return var_10;
  } else
    return randomint(level._id_AC3D[self.team][var_0].size);
}

_id_6C55() {
  var_0 = self getEye();
  var_1 = self getplayerangles();
  var_2 = anglesToForward(var_1);
  var_3 = var_0 + var_2 * 10000;
  var_4 = ["physicscontents_characterproxy"];
  var_5 = physics_createcontents(var_4);
  var_6 = scripts\engine\trace::_id_E409(var_0, var_3, 5.0, self, var_5, 0);
  var_7 = var_6["entity"];

  if(isDefined(var_7) && isPlayer(var_7)) {
    return var_7;
  } else {
    return undefined;
  }
}

_id_48E7() {
  for(;;) {
    waitframe();
    var_0 = [];

    if(getdvarint("#x3e3f02243f62a6ea9", 0) != 0) {
      _id_824C();
      var_0 = level.players;
    }

    if(getdvarint("#x363220fe081d4ab3", 0) != 0) {
      _id_824C();
      var_1 = level.players[0] _id_6C55();

      if(!isDefined(var_1)) {
        continue;
      }
      var_0[0] = var_1;
    }

    if(var_0.size > 0) {
      foreach(var_3 in var_0) {
        var_3 _id_BD11();
      }
    }
  }
}

_id_BD11() {
  if(!scripts\mp\utility\teams::_id_8878(self.team)) {
    return;
  }
  var_0 = _id_6BD1();
}

_id_B010() {
  var_0 = undefined;
  var_1 = 1;

  if(istrue(level.onlinegame)) {
    var_2 = self _meth_8133();
    var_1 = var_2.size;

    if(isDefined(var_2) && var_2.size > 0) {
      foreach(var_4 in var_2) {
        if(isDefined(var_4) && scripts\mp\utility\teams::_id_8878(var_4.team)) {
          var_0 = var_4.team;
          self._id_EFB0 = var_4._id_EFB0;
          break;
        }
      }
    }
  }

  if(!isDefined(var_0)) {
    var_0 = _id_5ADE(var_1);
  }

  if(!isDefined(self._id_EFB0)) {
    self._id_EFB0 = gettime();
  }

  thread _id_07F2::_id_D70D(var_0);
}

_id_5ADE(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  var_1 = undefined;

  foreach(var_3 in level._id_EF89) {
    var_4 = scripts\mp\utility\teams::_id_6DC9(var_3);
    var_5 = level.maxteamsize - var_4;

    if(var_5 < var_0) {
      continue;
    }
    if(var_4 > 0) {
      var_6 = scripts\mp\utility\teams::_id_6DCA(var_3, "players");

      if(isDefined(var_6[0]._id_EFB0) && gettime() > var_6[0]._id_EFB0 + 300000) {
        continue;
      }
    }

    var_1 = var_3;
    break;
  }

  return var_1;
}

_id_44F2() {
  var_0 = 25;

  for(;;) {
    if(isDefined(level._id_EF6A)) {
      var_1 = 400;
      var_2 = 200;
      var_3 = 1;
      var_4 = 0;

      foreach(var_6 in level._id_EF89) {
        var_3 = 1;
        var_3++;

        foreach(var_8 in level._id_EF6A[var_6]["players"]) {
          var_9 = (1, 1, 1);

          if(istrue(var_8._id_E488)) {
            var_9 = (0, 1, 0);
          }

          var_3++;
        }

        var_2 = var_2 + 100;
        var_4++;

        if(var_4 > 6) {
          var_4 = 0;
          var_1 = var_1 + 200;
          var_2 = 200;
        }
      }
    }

    waitframe();
  }
}

localafkdebugenabled() {
  return getdvarint("scr_debug_local_afk_testing", 0);
}

getoperatorreactivestagesetdef() {
  var_0 = _id_9818(self.team);
  return _func_0222("loot/operator_skin_ids.csv", 0, var_0, 38);
}

getoperatorreactivesource() {
  var_0 = _id_9818(self.team);
  return _func_0222("loot/operator_skin_ids.csv", 0, var_0, 40);
}

getoperatorreactivepreviewstage() {
  var_0 = _id_9818(self.team);
  return int(_func_0222("loot/operator_skin_ids.csv", 0, var_0, 39));
}

getoperatorultrascriptablestate() {
  var_0 = _id_9818(self.team);
  return _func_0222("loot/operator_skin_ids.csv", 0, var_0, 32);
}