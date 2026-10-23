/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\_teams.gsc
************************************************/

init() {
  initscoreboard();
  level.teambalance = getdvarint("scr_teambalance");
  level.maxclients = getdvarint("2299");
  setplayermodels();
  level.freeplayers = [];

  if(level.teambased) {
    level thread onplayerconnect();
    level thread updateteambalance();
    wait 0.15;
    level thread updateplayertimes();
  } else {
    level thread onfreeplayerconnect();
    wait 0.15;
    level thread updatefreeplayertimes();
  }
}

initscoreboard() {
  setDvar("1202", getteamshortname("allies"));
  setDvar("3729", getteamicon("allies"));
  setDvar("4487", getteamicon("allies"));
  setDvar("942", getteamicon("allies"));
  var_0 = getteamcolor("allies");
  setDvar("1138", var_0[0] + " " + var_0[1] + " " + var_0[2]);
  setDvar("2991", getteamshortname("axis"));
  setDvar("5558", getteamicon("axis"));
  setDvar("675", getteamicon("axis"));
  setDvar("4622", getteamicon("axis"));
  var_0 = getteamcolor("axis");
  setDvar("1513", var_0[0] + " " + var_0[1] + " " + var_0[2]);
  setDvar("370", ".25 .25 .25");
  setDvar("2942", ".76 .78 .10");
  setDvar("1725", ".6 .8 .6");
  setDvar("4832", "1 .45 .5");
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread onjoinedteam();
    var_0 thread onjoinedspectators();
    var_0 thread _id_9BC3();
  }
}

onfreeplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread trackfreeplayedtime();
  }
}

onjoinedteam() {
  self endon("disconnect");

  for(;;) {
    self waittill("joined_team");
    updateteamtime();
  }
}

onjoinedspectators() {
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

  self.timeplayed["allies"] = 0;
  self.timeplayed["axis"] = 0;
  self.timeplayed["other"] = 0;
  maps\mp\_utility::gameflagwait("prematch_done");

  for(;;) {
    if(game["state"] == "playing") {
      if(self._id_0179 == "allies") {
        self.timeplayed["allies"]++;
        self.timeplayed["total"]++;
      } else if(self._id_0179 == "axis") {
        self.timeplayed["axis"]++;
        self.timeplayed["total"]++;
      } else if(self._id_0179 == "spectator")
        self.timeplayed["other"]++;
    }

    wait 1.0;
  }
}

updateplayertimes() {
  if(!level.rankedmatch) {
    return;
  }
  level endon("game_ended");

  for(;;) {
    maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();

    foreach(var_1 in level.players) {
      var_1 updateplayedtime();
    }

    wait 1.0;
  }
}

updateplayedtime() {
  if(_isai(self)) {
    return;
  }
  if(!maps\mp\_utility::rankingenabled()) {
    return;
  }
  if(self.timeplayed["allies"]) {
    maps\mp\gametypes\_persistence::stataddbuffered("timePlayedAllies", self.timeplayed["allies"]);
    maps\mp\gametypes\_persistence::stataddbuffered("timePlayedTotal", self.timeplayed["allies"]);
    maps\mp\gametypes\_persistence::stataddchildbuffered("round", "timePlayed", self.timeplayed["allies"]);
  }

  if(self.timeplayed["axis"]) {
    maps\mp\gametypes\_persistence::stataddbuffered("timePlayedOpfor", self.timeplayed["axis"]);
    maps\mp\gametypes\_persistence::stataddbuffered("timePlayedTotal", self.timeplayed["axis"]);
    maps\mp\gametypes\_persistence::stataddchildbuffered("round", "timePlayed", self.timeplayed["axis"]);
  }

  if(self.timeplayed["other"]) {
    maps\mp\gametypes\_persistence::stataddbuffered("timePlayedOther", self.timeplayed["other"]);
    maps\mp\gametypes\_persistence::stataddbuffered("timePlayedTotal", self.timeplayed["other"]);
    maps\mp\gametypes\_persistence::stataddchildbuffered("round", "timePlayed", self.timeplayed["other"]);
  }

  if(game["state"] == "postgame") {
    return;
  }
  self.timeplayed["allies"] = 0;
  self.timeplayed["axis"] = 0;
  self.timeplayed["other"] = 0;
}

updateteamtime() {
  if(game["state"] != "playing") {
    return;
  }
  self.pers["teamTime"] = gettime();
}

updateteambalancedvar() {
  for(;;) {
    var_0 = getdvarint("scr_teambalance");

    if(level.teambalance != var_0) {
      level.teambalance = getdvarint("scr_teambalance");
    }

    wait 1;
  }
}

updateteambalance() {
  if(_getteammode() == "hub") {
    level.teamlimit = level.maxclients;
  } else {
    level.teamlimit = level.maxclients / 2;
    level thread updateteambalancedvar();
    wait 0.15;

    if(level.teambalance && maps\mp\_utility::isroundbased()) {
      if(isDefined(game["BalanceTeamsNextRound"])) {
        _iprintlnbold(&"MP_AUTOBALANCE_NEXT_ROUND");
      }

      level waittill("restarting");

      if(isDefined(game["BalanceTeamsNextRound"])) {
        level balanceteams();
        game["BalanceTeamsNextRound"] = undefined;
        return;
      }

      if(!getteambalance()) {
        game["BalanceTeamsNextRound"] = 1;
        return;
      }

      return;
      return;
    }

    level endon("game_ended");

    for(;;) {
      if(level.teambalance) {
        if(!getteambalance()) {
          _iprintlnbold(&"MP_AUTOBALANCE_SECONDS", 15);
          wait 15.0;

          if(!getteambalance()) {
            level balanceteams();
          }
        }

        wait 59.0;
      }

      wait 1.0;
    }
  }
}

getteambalance() {
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

  if(level.team["allies"] > level.team["axis"] + level.teambalance || level.team["axis"] > level.team["allies"] + level.teambalance) {
    return 0;
  } else {
    return 1;
  }
}

balanceteams() {
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
        if(isDefined(var_0[var_5].dont_auto_balance)) {
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

      var_4[[level.onteamselection]]("axis");
    } else if(var_1.size > var_0.size + 1) {
      for(var_5 = 0; var_5 < var_1.size; var_5++) {
        if(isDefined(var_1[var_5].dont_auto_balance)) {
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

      var_4[[level.onteamselection]]("allies");
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

setghilliemodels(var_0) {}

setteammodels(var_0, var_1) {}

setplayermodels() {
  if(level.multiteambased) {
    for(var_0 = 0; var_0 < level.teamnamelist.size; var_0++) {
      setteammodels(level.teamnamelist[var_0], game[level.teamnamelist[var_0]]);
    }
  } else {
    setteammodels("allies", game["allies"]);
    setteammodels("axis", game["axis"]);
  }

  setghilliemodels(_getmapcustom("environment"));
}

playercostume() {
  if(_isagent(self) && !getdvarint("4017", 0)) {
    return 1;
  }

  if(!isDefined(self._id_5097) || !self._id_5097) {
    self set_grenadeammo(self.costume, undefined, 1, 1);
    self loadcustomizationplayerview(self);
  }

  self.voice = "american";
  self setclothtype("vestlight");
  return 1;
}

validcostume(var_0, var_1) {
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

getdefaultcostume() {
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

getpracticeroundcostume() {
  if(!isDefined(level.practice_round_costume)) {
    level.practice_round_max_costumes = _tablegetcolumncount(level.practiceroundcostumetablename) - 1;
    level.practice_round_costume = randomint(level.practice_round_max_costumes);
  }

  var_0 = 0;

  for(var_1 = 0; var_1 < level.players.size; var_1++) {
    if(level.players[var_1] == self) {
      var_0 = var_1;
      break;
    }
  }

  var_2 = (level.practice_round_costume + var_0) % level.practice_round_max_costumes;
  var_3 = _getcostumefromtable(level.practiceroundcostumetablename, var_2 + 1);
  return var_3;
}

gethardcorecostume() {
  var_0 = 2;

  if(self.pers["team"] == "axis") {
    var_0 = 1;
  }

  var_1 = _getcostumefromtable(level.hardcorecostumetablename, var_0);
  return var_1;
}

playermodelforweapon(var_0, var_1) {
  var_2 = self.team;
  var_3 = playercostume();
  self notify("player_model_set");
}

countplayers() {
  var_0 = [];

  for(var_1 = 0; var_1 < level.teamnamelist.size; var_1++) {
    var_0[level.teamnamelist[var_1]] = 0;
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

trackfreeplayedtime() {
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

  self.timeplayed["allies"] = 0;
  self.timeplayed["axis"] = 0;
  self.timeplayed["other"] = 0;

  for(;;) {
    if(game["state"] == "playing") {
      if(isDefined(self.pers["team"]) && self.pers["team"] == "allies" && self._id_0179 != "spectator") {
        self.timeplayed["allies"]++;
        self.timeplayed["total"]++;
      } else if(isDefined(self.pers["team"]) && self.pers["team"] == "axis" && self._id_0179 != "spectator") {
        self.timeplayed["axis"]++;
        self.timeplayed["total"]++;
      } else
        self.timeplayed["other"]++;
    }

    wait 1.0;
  }
}

updatefreeplayertimes() {
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
      level.players[var_0] updatefreeplayedtime();
    }

    wait 1.0;
  }
}

updatefreeplayedtime() {
  if(!maps\mp\_utility::rankingenabled()) {
    return;
  }
  if(_isai(self)) {
    return;
  }
  if(self.timeplayed["allies"]) {
    maps\mp\gametypes\_persistence::stataddbuffered("timePlayedAllies", self.timeplayed["allies"]);
    maps\mp\gametypes\_persistence::stataddbuffered("timePlayedTotal", self.timeplayed["allies"]);
    maps\mp\gametypes\_persistence::stataddchildbuffered("round", "timePlayed", self.timeplayed["allies"]);
  }

  if(self.timeplayed["axis"]) {
    maps\mp\gametypes\_persistence::stataddbuffered("timePlayedOpfor", self.timeplayed["axis"]);
    maps\mp\gametypes\_persistence::stataddbuffered("timePlayedTotal", self.timeplayed["axis"]);
    maps\mp\gametypes\_persistence::stataddchildbuffered("round", "timePlayed", self.timeplayed["axis"]);
  }

  if(self.timeplayed["other"]) {
    maps\mp\gametypes\_persistence::stataddbuffered("timePlayedOther", self.timeplayed["other"]);
    maps\mp\gametypes\_persistence::stataddbuffered("timePlayedTotal", self.timeplayed["other"]);
    maps\mp\gametypes\_persistence::stataddchildbuffered("round", "timePlayed", self.timeplayed["other"]);
  }

  if(game["state"] == "postgame") {
    return;
  }
  self.timeplayed["allies"] = 0;
  self.timeplayed["axis"] = 0;
  self.timeplayed["other"] = 0;
}

getjointeampermissions(var_0) {
  if(maps\mp\_utility::iscoop()) {
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

  if(var_1 < level.teamlimit) {
    return 1;
  } else {
    return 0;
  }
}

mt_getteamname(var_0) {
  return _tablelookupistring("mp/MTTable.csv", 0, var_0, 1);
}

mt_getteamicon(var_0) {
  return tablelookup("mp/MTTable.csv", 0, var_0, 2);
}

mt_getteamheadicon(var_0) {
  return tablelookup("mp/MTTable.csv", 0, var_0, 3);
}

getteamname(var_0) {
  return _tablelookupistring("mp/factionTable.csv", 0, game[var_0], 1);
}

getteamshortname(var_0) {
  return _tablelookupistring("mp/factionTable.csv", 0, game[var_0], 2);
}

getteamforfeitedstring(var_0) {
  return _tablelookupistring("mp/factionTable.csv", 0, game[var_0], 4);
}

getteameliminatedstring(var_0) {
  return _tablelookupistring("mp/factionTable.csv", 0, game[var_0], 3);
}

getteamicon(var_0) {
  return tablelookup("mp/factionTable.csv", 0, game[var_0], 5);
}

getteamhudicon(var_0) {
  return tablelookup("mp/factionTable.csv", 0, game[var_0], 6);
}

getteamheadicon(var_0) {
  return tablelookup("mp/factionTable.csv", 0, game[var_0], 17);
}

getteamvoiceprefix(var_0) {
  return tablelookup("mp/factionTable.csv", 0, game[var_0], 7);
}

getteamspawnmusic(var_0) {
  return tablelookup("mp/factionTable.csv", 0, game[var_0], 8);
}

getteamwinmusic(var_0) {
  return tablelookup("mp/factionTable.csv", 0, game[var_0], 9);
}

getteamflagmodel(var_0) {
  return tablelookup("mp/factionTable.csv", 0, game[var_0], 10);
}

getteamflagcarrymodel(var_0) {
  return tablelookup("mp/factionTable.csv", 0, game[var_0], 11);
}

getteamflagicon(var_0) {
  return tablelookup("mp/factionTable.csv", 0, game[var_0], 12);
}

getteamflagfx(var_0) {
  return tablelookup("mp/factionTable.csv", 0, game[var_0], 13);
}

getteamcolor(var_0) {
  return (common_scripts\utility::stringtofloat(tablelookup("mp/factionTable.csv", 0, game[var_0], 14)), common_scripts\utility::stringtofloat(tablelookup("mp/factionTable.csv", 0, game[var_0], 15)), common_scripts\utility::stringtofloat(tablelookup("mp/factionTable.csv", 0, game[var_0], 16)));
}

getteamcratemodel(var_0) {
  return tablelookup("mp/factionTable.csv", 0, game[var_0], 18);
}

getteamdeploymodel(var_0) {
  return tablelookup("mp/factionTable.csv", 0, game[var_0], 19);
}