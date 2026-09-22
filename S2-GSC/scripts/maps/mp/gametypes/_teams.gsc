/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\_teams.gsc
************************************************/

init() {
  _id_534C();
  level._id_984C = getdvarint("scr_teambalance");
  level._id_6079 = getdvarint("2299");
  _id_86FF();
  level._id_3E8B = [];

  if(level.teambased) {
    level thread onplayerconnect();
    level thread _id_A171();
    wait 0.15;
    level thread _id_A153();
  } else {
    level thread _id_6B3D();
    wait 0.15;
    level thread _id_A115();
  }
}

_id_534C() {
  setDvar("1202", _id_46D6("allies"));
  setDvar("3729", _id_46D3("allies"));
  setDvar("4487", _id_46D3("allies"));
  setDvar("942", _id_46D3("allies"));
  var_0 = _id_46C5("allies");
  setDvar("1138", var_0[0] + " " + var_0[1] + " " + var_0[2]);
  setDvar("2991", _id_46D6("axis"));
  setDvar("5558", _id_46D3("axis"));
  setDvar("675", _id_46D3("axis"));
  setDvar("4622", _id_46D3("axis"));
  var_0 = _id_46C5("axis");
  setDvar("1513", var_0[0] + " " + var_0[1] + " " + var_0[2]);
  setDvar("370", ".25 .25 .25");
  setDvar("2942", ".76 .78 .10");
  setDvar("1725", ".6 .8 .6");
  setDvar("4832", "1 .45 .5");
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread _id_6B49();
    var_0 thread _id_6B48();
    var_0 thread _id_9BC3();
  }
}

_id_6B3D() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread _id_9BA7();
  }
}

_id_6B49() {
  self endon("disconnect");

  for(;;) {
    self waittill("joined_team");
    _id_A176();
  }
}

_id_6B48() {
  self endon("disconnect");

  for(;;) {
    self waittill("joined_spectators");
    self.pers["teamTime"] = undefined;
  }
}

_id_9BC3() {
  self endon("disconnect");

  if(!_func_367()) {
    if(maps\mp\_utility::_id_585F()) {
      if(common_scripts\utility::_id_562E(level.zombie_game_was_restarted)) {
        wait 30;
      }
    }

    _lootservicestarttrackingplaytime(self._id_01D6);
    self.loot_service_started_tracking_playtime = 1;
  }

  self._id_9A06["allies"] = 0;
  self._id_9A06["axis"] = 0;
  self._id_9A06["other"] = 0;
  maps\mp\_utility::gameflagwait("prematch_done");

  for(;;) {
    if(game["state"] == "playing") {
      if(self._id_0179 == "allies") {
        self._id_9A06["allies"]++;
        self._id_9A06["total"]++;
      } else if(self._id_0179 == "axis") {
        self._id_9A06["axis"]++;
        self._id_9A06["total"]++;
      } else if(self._id_0179 == "spectator")
        self._id_9A06["other"]++;
    }

    wait 1.0;
  }
}

_id_A153() {
  if(!level.rankedmatch) {
    return;
  }
  level endon("game_ended");

  for(;;) {
    maps\mp\gametypes\_hostmigration::_id_A782();

    foreach(var_1 in level.players) {
      var_1 _id_A14E();
    }

    wait 1.0;
  }
}

_id_A14E() {
  if(_isai(self)) {
    return;
  }
  if(!maps\mp\_utility::rankingenabled()) {
    return;
  }
  if(self._id_9A06["allies"]) {
    maps\mp\gametypes\_persistence::stataddbuffered("timePlayedAllies", self._id_9A06["allies"]);
    maps\mp\gametypes\_persistence::stataddbuffered("timePlayedTotal", self._id_9A06["allies"]);
    maps\mp\gametypes\_persistence::stataddchildbuffered("round", "timePlayed", self._id_9A06["allies"]);
  }

  if(self._id_9A06["axis"]) {
    maps\mp\gametypes\_persistence::stataddbuffered("timePlayedOpfor", self._id_9A06["axis"]);
    maps\mp\gametypes\_persistence::stataddbuffered("timePlayedTotal", self._id_9A06["axis"]);
    maps\mp\gametypes\_persistence::stataddchildbuffered("round", "timePlayed", self._id_9A06["axis"]);
  }

  if(self._id_9A06["other"]) {
    maps\mp\gametypes\_persistence::stataddbuffered("timePlayedOther", self._id_9A06["other"]);
    maps\mp\gametypes\_persistence::stataddbuffered("timePlayedTotal", self._id_9A06["other"]);
    maps\mp\gametypes\_persistence::stataddchildbuffered("round", "timePlayed", self._id_9A06["other"]);
  }

  if(game["state"] == "postgame") {
    return;
  }
  self._id_9A06["allies"] = 0;
  self._id_9A06["axis"] = 0;
  self._id_9A06["other"] = 0;
}

_id_A176() {
  if(game["state"] != "playing") {
    return;
  }
  self.pers["teamTime"] = gettime();
}

_id_A172() {
  for(;;) {
    var_0 = getdvarint("scr_teambalance");

    if(level._id_984C != var_0) {
      level._id_984C = getdvarint("scr_teambalance");
    }

    wait 1;
  }
}

_id_A171() {
  if(_getteammode() == "hub") {
    level._id_9858 = level._id_6079;
  } else {
    level._id_9858 = level._id_6079 / 2;
    level thread _id_A172();
    wait 0.15;

    if(level._id_984C && maps\mp\_utility::isroundbased()) {
      if(isDefined(game["BalanceTeamsNextRound"])) {
        _iprintlnbold(&"MP_AUTOBALANCE_NEXT_ROUND");
      }

      level waittill("restarting");

      if(isDefined(game["BalanceTeamsNextRound"])) {
        level _id_1502();
        game["BalanceTeamsNextRound"] = undefined;
        return;
      }

      if(!_id_46C4()) {
        game["BalanceTeamsNextRound"] = 1;
        return;
      }

      return;
      return;
    }

    level endon("game_ended");

    for(;;) {
      if(level._id_984C) {
        if(!_id_46C4()) {
          _iprintlnbold(&"MP_AUTOBALANCE_SECONDS", 15);
          wait 15.0;

          if(!_id_46C4()) {
            level _id_1502();
          }
        }

        wait 59.0;
      }

      wait 1.0;
    }
  }
}

_id_46C4() {
  level.team["allies"] = 0;
  level.team["axis"] = 0;
  var_0 = level.players;

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(isDefined(var_0[var_1].pers["team"]) && var_0[var_1].pers["team"] == "allies") {
      level.team["allies"]++;
      continue;
    }

    if(isDefined(var_0[var_1].pers["team"]) && var_0[var_1].pers["team"] == "axis") {
      level.team["axis"]++;
    }
  }

  if(level.team["allies"] > level.team["axis"] + level._id_984C || level.team["axis"] > level.team["allies"] + level._id_984C) {
    return 0;
  } else {
    return 1;
  }
}

_id_1502() {
  _iprintlnbold(game["strings"]["autobalance"]);
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
        if(isDefined(var_0[var_5]._id_322F)) {
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

      var_4[[level._id_6BB4]]("axis");
    } else if(var_1.size > var_0.size + 1) {
      for(var_5 = 0; var_5 < var_1.size; var_5++) {
        if(isDefined(var_1[var_5]._id_322F)) {
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

      var_4[[level._id_6BB4]]("allies");
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

_id_8692(var_0) {}

_id_873E(var_0, var_1) {}

_id_86FF() {
  if(level._id_6520) {
    for(var_0 = 0; var_0 < level._id_985B.size; var_0++) {
      _id_873E(level._id_985B[var_0], game[level._id_985B[var_0]]);
    }
  } else {
    _id_873E("allies", game["allies"]);
    _id_873E("axis", game["axis"]);
  }

  _id_8692(_getmapcustom("environment"));
}

_id_73CA() {
  if(_isagent(self) && !getdvarint("4017", 0)) {
    return 1;
  }

  if(!isDefined(self._id_5097) || !self._id_5097) {
    self _meth_84C7(self._id_267E, undefined, 1, 1);
    self loadcustomizationplayerview(self);
  }

  self._id_A600 = "american";
  self setclothtype("vestlight");
  return 1;
}

_id_A27D(var_0, var_1) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_2 = _func_282(var_0, var_1);

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    if(var_0[var_3] != var_2[var_3]) {
      return 0;
    }
  }

  return 1;
}

_id_448C() {
  var_0 = _common_scripts / _bcs_location_trigs();
  return var_0;
}

_id_4430() {
  if(isDefined(self._id_0079)) {
    var_0 = _func_333(self._id_0079, 0);
  } else {
    var_0 = _func_332();
  }

  return var_0;
}

_id_4636() {
  if(!isDefined(level._id_7613)) {
    level._id_7614 = _tablegetcolumncount(level._id_761B) - 1;
    level._id_7613 = randomint(level._id_7614);
  }

  var_0 = 0;

  for(var_1 = 0; var_1 < level.players.size; var_1++) {
    if(level.players[var_1] == self) {
      var_0 = var_1;
      break;
    }
  }

  var_2 = (level._id_7613 + var_0) % level._id_7614;
  var_3 = _getcostumefromtable(level._id_761B, var_2 + 1);
  return var_3;
}

_id_4503() {
  var_0 = 2;

  if(self.pers["team"] == "axis") {
    var_0 = 1;
  }

  var_1 = _getcostumefromtable(level._id_4B16, var_0);
  return var_1;
}

_id_7427(var_0, var_1) {
  var_2 = self.team;
  var_3 = _id_73CA();
  self notify("player_model_set");
}

_id_2697() {
  var_0 = [];

  for(var_1 = 0; var_1 < level._id_985B.size; var_1++) {
    var_0[level._id_985B[var_1]] = 0;
  }

  for(var_1 = 0; var_1 < level.players.size; var_1++) {
    if(level.players[var_1] == self) {
      continue;
    }
    if(level.players[var_1].pers["team"] == "spectator") {
      continue;
    }
    if(isDefined(level.players[var_1].pers["team"])) {
      var_0[level.players[var_1].pers["team"]]++;
    }
  }

  return var_0;
}

_id_9BA7() {
  self endon("disconnect");

  if(!_func_367()) {
    if(maps\mp\_utility::_id_585F()) {
      if(common_scripts\utility::_id_562E(level.zombie_game_was_restarted)) {
        wait 30;
      }
    }

    _lootservicestarttrackingplaytime(self._id_01D6);
    self.loot_service_started_tracking_playtime = 1;
  }

  self._id_9A06["allies"] = 0;
  self._id_9A06["axis"] = 0;
  self._id_9A06["other"] = 0;

  for(;;) {
    if(game["state"] == "playing") {
      if(isDefined(self.pers["team"]) && self.pers["team"] == "allies" && self._id_0179 != "spectator") {
        self._id_9A06["allies"]++;
        self._id_9A06["total"]++;
      } else if(isDefined(self.pers["team"]) && self.pers["team"] == "axis" && self._id_0179 != "spectator") {
        self._id_9A06["axis"]++;
        self._id_9A06["total"]++;
      } else
        self._id_9A06["other"]++;
    }

    wait 1.0;
  }
}

_id_A115() {
  if(!level.rankedmatch) {
    return;
  }
  var_0 = 0;

  for(;;) {
    var_0++;

    if(var_0 >= level.players.size) {
      var_0 = 0;
    }

    if(isDefined(level.players[var_0])) {
      level.players[var_0] _id_A114();
    }

    wait 1.0;
  }
}

_id_A114() {
  if(!maps\mp\_utility::rankingenabled()) {
    return;
  }
  if(_isai(self)) {
    return;
  }
  if(self._id_9A06["allies"]) {
    maps\mp\gametypes\_persistence::stataddbuffered("timePlayedAllies", self._id_9A06["allies"]);
    maps\mp\gametypes\_persistence::stataddbuffered("timePlayedTotal", self._id_9A06["allies"]);
    maps\mp\gametypes\_persistence::stataddchildbuffered("round", "timePlayed", self._id_9A06["allies"]);
  }

  if(self._id_9A06["axis"]) {
    maps\mp\gametypes\_persistence::stataddbuffered("timePlayedOpfor", self._id_9A06["axis"]);
    maps\mp\gametypes\_persistence::stataddbuffered("timePlayedTotal", self._id_9A06["axis"]);
    maps\mp\gametypes\_persistence::stataddchildbuffered("round", "timePlayed", self._id_9A06["axis"]);
  }

  if(self._id_9A06["other"]) {
    maps\mp\gametypes\_persistence::stataddbuffered("timePlayedOther", self._id_9A06["other"]);
    maps\mp\gametypes\_persistence::stataddbuffered("timePlayedTotal", self._id_9A06["other"]);
    maps\mp\gametypes\_persistence::stataddchildbuffered("round", "timePlayed", self._id_9A06["other"]);
  }

  if(game["state"] == "postgame") {
    return;
  }
  self._id_9A06["allies"] = 0;
  self._id_9A06["axis"] = 0;
  self._id_9A06["other"] = 0;
}

_id_452D(var_0) {
  if(maps\mp\_utility::_id_56B9()) {
    return 1;
  }

  if(level.gametype == "infect") {
    return 1;
  }

  if(_getteammode() == "hub") {
    return 1;
  }

  var_1 = 0;
  var_2 = level.players;

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = var_2[var_3];

    if(isDefined(var_4.pers["team"]) && var_4.pers["team"] == var_0) {
      var_1++;

      if(isbot(var_4)) {
        return 1;
      }
    }
  }

  if(var_1 < level._id_9858) {
    return 1;
  } else {
    return 0;
  }
}

_id_650C(var_0) {
  return _tablelookupistring("mp/MTTable.csv", 0, var_0, 1);
}

_id_650B(var_0) {
  return tablelookup("mp/MTTable.csv", 0, var_0, 2);
}

_id_650A(var_0) {
  return tablelookup("mp/MTTable.csv", 0, var_0, 3);
}

_id_46D5(var_0) {
  return _tablelookupistring("mp/factionTable.csv", 0, game[var_0], 1);
}

_id_46D6(var_0) {
  return _tablelookupistring("mp/factionTable.csv", 0, game[var_0], 2);
}

_id_46D0(var_0) {
  return _tablelookupistring("mp/factionTable.csv", 0, game[var_0], 4);
}

_id_46C9(var_0) {
  return _tablelookupistring("mp/factionTable.csv", 0, game[var_0], 3);
}

_id_46D3(var_0) {
  return tablelookup("mp/factionTable.csv", 0, game[var_0], 5);
}

_id_46D2(var_0) {
  return tablelookup("mp/factionTable.csv", 0, game[var_0], 6);
}

_id_46D1(var_0) {
  return tablelookup("mp/factionTable.csv", 0, game[var_0], 17);
}

_id_46D9(var_0) {
  return tablelookup("mp/factionTable.csv", 0, game[var_0], 7);
}

_id_46D8(var_0) {
  return tablelookup("mp/factionTable.csv", 0, game[var_0], 8);
}

_id_46DA(var_0) {
  return tablelookup("mp/factionTable.csv", 0, game[var_0], 9);
}

_id_46CF(var_0) {
  return tablelookup("mp/factionTable.csv", 0, game[var_0], 10);
}

_id_46CB(var_0) {
  return tablelookup("mp/factionTable.csv", 0, game[var_0], 11);
}

_id_46CE(var_0) {
  return tablelookup("mp/factionTable.csv", 0, game[var_0], 12);
}

_id_46CD(var_0) {
  return tablelookup("mp/factionTable.csv", 0, game[var_0], 13);
}

_id_46C5(var_0) {
  return (common_scripts\utility::stringtofloat(tablelookup("mp/factionTable.csv", 0, game[var_0], 14)), common_scripts\utility::stringtofloat(tablelookup("mp/factionTable.csv", 0, game[var_0], 15)), common_scripts\utility::stringtofloat(tablelookup("mp/factionTable.csv", 0, game[var_0], 16)));
}

_id_46C6(var_0) {
  return tablelookup("mp/factionTable.csv", 0, game[var_0], 18);
}

_id_46C7(var_0) {
  return tablelookup("mp/factionTable.csv", 0, game[var_0], 19);
}