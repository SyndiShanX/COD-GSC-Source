/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2046.gsc
*************************************************/

init() {
  level._id_B015 = [];
  level thread _id_FC1C();
  level thread _id_FC1D();
  level thread _id_FD9E();
  level thread _id_10FC5();
}

_id_8158() {
  self._id_2CA1 = [];
  self._id_E49E = [];

  if(scripts\mp\utility\game::onlinestatsenabled()) {
    self._id_2CA1["totalShots"] = self getplayerdata(level.progressiongroup, "totalShots");
    self._id_2CA1["accuracy"] = self getplayerdata(level.progressiongroup, "accuracy");
    self._id_2CA1["misses"] = self getplayerdata(level.progressiongroup, "misses");
    self._id_2CA1["hits"] = self getplayerdata(level.progressiongroup, "hits");
  }

  self._id_2CA1["timePlayedAllies"] = self getplayerdata(level.progressiongroup, "timePlayedAllies");
  self._id_2CA1["timePlayedOpfor"] = self getplayerdata(level.progressiongroup, "timePlayedOpfor");
  self._id_2CA1["timePlayedOther"] = self getplayerdata(level.progressiongroup, "timePlayedOther");
  self._id_2CA1["timePlayedTotal"] = self getplayerdata(level.progressiongroup, "timePlayedTotal");
  self._id_2C9C = [];
  self._id_2C9C["round"] = [];
  self._id_2C9C["round"]["timePlayed"] = self getplayerdata("common", "round", "timePlayed");

  if(scripts\mp\utility\game::onlinestatsenabled()) {
    self._id_2C9C["xpMultiplierTimePlayed"] = [];
    self._id_2C9C["xpMultiplierTimePlayed"][0] = self getplayerdata(level.progressiongroup, "xpMultiplierTimePlayed", 0);
    self._id_2C9C["xpMultiplierTimePlayed"][1] = self getplayerdata(level.progressiongroup, "xpMultiplierTimePlayed", 1);
    self._id_2C9C["xpMultiplierTimePlayed"][2] = self getplayerdata(level.progressiongroup, "xpMultiplierTimePlayed", 2);
    self._id_2C9D["xpMaxMultiplierTimePlayed"] = [];
    self._id_2C9D["xpMaxMultiplierTimePlayed"][0] = self getplayerdata(level.progressiongroup, "xpMaxMultiplierTimePlayed", 0);
    self._id_2C9D["xpMaxMultiplierTimePlayed"][1] = self getplayerdata(level.progressiongroup, "xpMaxMultiplierTimePlayed", 1);
    self._id_2C9D["xpMaxMultiplierTimePlayed"][2] = self getplayerdata(level.progressiongroup, "xpMaxMultiplierTimePlayed", 2);
    self._id_2C9C["challengeXPMultiplierTimePlayed"] = [];
    self._id_2C9C["challengeXPMultiplierTimePlayed"][0] = self getplayerdata(level.progressiongroup, "challengeXPMultiplierTimePlayed", 0);
    self._id_2C9D["challengeXPMaxMultiplierTimePlayed"] = [];
    self._id_2C9D["challengeXPMaxMultiplierTimePlayed"][0] = self getplayerdata(level.progressiongroup, "challengeXPMaxMultiplierTimePlayed", 0);
    self._id_2C9C["weaponXPMultiplierTimePlayed"] = [];
    self._id_2C9C["weaponXPMultiplierTimePlayed"][0] = self getplayerdata(level.progressiongroup, "weaponXPMultiplierTimePlayed", 0);
    self._id_2C9D["weaponXPMaxMultiplierTimePlayed"] = [];
    self._id_2C9D["weaponXPMaxMultiplierTimePlayed"][0] = self getplayerdata(level.progressiongroup, "weaponXPMaxMultiplierTimePlayed", 0);
    self._id_2CA1["prestigeDoubleWeaponXp"] = self getplayerdata(level.progressiongroup, "prestigeDoubleWeaponXp");
    self._id_2CA1["prestigeDoubleWeaponXpTimePlayed"] = self getplayerdata(level.progressiongroup, "prestigeDoubleWeaponXpTimePlayed");
    self._id_2CA2["prestigeDoubleWeaponXpMaxTimePlayed"] = self getplayerdata(level.progressiongroup, "prestigeDoubleWeaponXpMaxTimePlayed");
  }

  _id_814E();
}

_id_814E() {
  var_0 = "mp/bestscorestatsTable.csv";
  self._id_24D3 = [];
  self._id_2C9B = [];
  var_1 = 0;

  for(;;) {
    var_2 = tablelookupbyrow(var_0, var_1, 0);

    if(var_2 == "") {
      break;
    }

    self._id_24D3[var_2] = self getplayerdata(level.progressiongroup, "bestScores", var_2);
    var_1++;
  }
}

_id_E760(var_0, var_1) {
  if(var_0 == "round") {
    return self getplayerdata("common", var_0, var_1);
  } else {
    return self getplayerdata(level.progressiongroup, var_0, var_1);
  }
}

_id_E770(var_0, var_1, var_2, var_3) {
  if(isagent(self)) {
    return;
  }
  if(istrue(game["practiceRound"])) {
    return;
  }
  if(isDefined(var_3) || !scripts\mp\utility\game::onlinestatsenabled()) {
    return;
  }
  if(var_0 == "round") {
    self setplayerdata("common", var_0, var_1, var_2);
    _id_D497(var_1, var_2);
  } else
    self setplayerdata(level.progressiongroup, var_0, var_1, var_2);
}

_id_E744(var_0, var_1, var_2) {
  var_3 = 0;

  if(!scripts\mp\utility\game::onlinestatsenabled() && !var_3) {
    return;
  }
  var_4 = self getplayerdata(level.progressiongroup, var_0, var_1);
  self setplayerdata(level.progressiongroup, var_0, var_1, var_4 + var_2);
}

_id_E761(var_0, var_1, var_2) {
  if(!scripts\mp\utility\game::onlinestatsenabled() && !istrue(var_2)) {
    return 0;
  }

  return self._id_2C9C[var_0][var_1];
}

_id_E771(var_0, var_1, var_2, var_3) {
  if(!scripts\mp\utility\game::onlinestatsenabled() && !istrue(var_3)) {
    return;
  }
  self._id_2C9C[var_0][var_1] = var_2;
}

_id_E745(var_0, var_1, var_2, var_3) {
  if(!scripts\mp\utility\game::onlinestatsenabled() && !istrue(var_3)) {
    return;
  }
  var_4 = _id_E761(var_0, var_1, var_3);
  _id_E771(var_0, var_1, var_4 + var_2, var_3);
}

_id_E746(var_0, var_1, var_2, var_3) {
  var_4 = 0;

  if(!scripts\mp\utility\game::onlinestatsenabled() && !var_4) {
    return;
  }
  var_5 = _id_E761(var_0, var_1) + var_2;

  if(var_5 > var_3) {
    var_5 = var_3;
  }

  if(var_5 < _id_E761(var_0, var_1)) {
    var_5 = var_3;
  }

  _id_E771(var_0, var_1, var_5);
}

_id_FC1C() {
  wait 0.15;
  var_0 = 0;

  while(!level.gameended) {
    scripts\mp\hostmigration::waittillhostmigrationdone();
    var_0++;

    if(var_0 >= level.players.size) {
      var_0 = 0;
    }

    if(isDefined(level.players[var_0])) {
      level.players[var_0] _id_10FC3();
      level.players[var_0] _id_FD88();
    }

    wait 2.0;
  }
}

_id_FC1D() {
  level endon("game_cleanup");
  level waittill("game_ended");

  foreach(var_1 in level.players) {
    var_1 _id_10FC3();
    var_1 _id_FD88();
  }

  level._id_4AFF = 1;
}

_id_D497(var_0, var_1) {
  var_2 = scripts\mp\utility\game::onlinestatsenabled();

  if(!var_2) {
    return;
  }
  if(isDefined(self._id_24D3[var_0]) && var_1 > self._id_24D3[var_0]) {
    self._id_24D3[var_0] = var_1;
    self._id_2C9B[var_0] = var_1;
  }
}

_id_10FC2() {
  foreach(var_1 in level.players) {
    if(isDefined(var_1) && var_1 scripts\mp\utility\game::onlinestatsenabled()) {
      foreach(var_4, var_3 in var_1._id_2C9B) {
        var_1 setplayerdata(level.progressiongroup, "bestScores", var_4, var_3);
      }
    }
  }
}

_id_10FC3() {
  var_0 = scripts\mp\utility\game::onlinestatsenabled();

  if(var_0) {
    foreach(var_3, var_2 in self._id_2CA1) {
      self setplayerdata(level.progressiongroup, var_3, var_2);
    }

    if(!isai(self)) {
      foreach(var_3, var_2 in self._id_E49E) {
        self setplayerdata("rankedloadouts", "squadMembers", var_3, var_2);
      }
    }
  }

  foreach(var_3, var_2 in self._id_2C9C) {
    foreach(var_8, var_7 in var_2) {
      if(var_3 == "round") {
        self setplayerdata("common", var_3, var_8, var_7);
        _id_D497(var_8, var_7);
        continue;
      }

      if(var_0) {
        self setplayerdata(level.progressiongroup, var_3, var_8, var_7);
      }
    }
  }
}

_id_10FC5() {
  if(!scripts\mp\utility\game::matchmakinggame()) {
    return;
  }
  level waittill("game_ended");
  wait 0.1;

  if(scripts\mp\utility\game::_id_10A16() || !scripts\mp\utility\game::isroundbased() && scripts\mp\utility\game::_id_79C1()) {
    foreach(var_1 in level.players) {
      var_2 = 0;

      if(isDefined(var_1.pers["shotsFired"]) && isDefined(var_1.pers["shotsHit"]) && var_1.pers["shotsFired"] > 0) {
        var_3 = var_1.pers["shotsFired"];
        var_4 = var_1.pers["shotsHit"];
        var_2 = var_4 / var_3;
      }

      if(!isDefined(var_1._id_761D)) {
        var_1._id_761D = scripts\engine\utility::ter_op(isDefined(var_1.pers["headshots"]), var_1.pers["headshots"], 0);
      }

      var_1 _id_7DF4(var_1._id_0267, var_1._id_0157, var_1._id_761D, var_2, var_1.pers["damage"]);
    }
  }
}

_id_7DF4(var_0, var_1, var_2, var_3, var_4) {
  if(!scripts\mp\utility\game::onlinestatsenabled()) {
    return;
  }
  for(var_5 = 0; var_5 < 4; var_5++) {
    var_6 = self getplayerdata(level.progressiongroup, "kdHistoryK", var_5 + 1);
    self setplayerdata(level.progressiongroup, "kdHistoryK", var_5, var_6);
    var_6 = self getplayerdata(level.progressiongroup, "kdHistoryD", var_5 + 1);
    self setplayerdata(level.progressiongroup, "kdHistoryD", var_5, var_6);
    var_6 = self getplayerdata(level.progressiongroup, "headshotHistory", var_5 + 1);
    self setplayerdata(level.progressiongroup, "headshotHistory", var_5, var_6);
    var_6 = self getplayerdata(level.progressiongroup, "accuracyHistory", var_5 + 1);
    self setplayerdata(level.progressiongroup, "accuracyHistory", var_5, var_6);
    var_6 = self getplayerdata(level.progressiongroup, "damageHistory", var_5 + 1);
    self setplayerdata(level.progressiongroup, "damageHistory", var_5, var_6);
  }

  self setplayerdata(level.progressiongroup, "kdHistoryK", 4, int(clamp(var_0, 0, 255)));
  self setplayerdata(level.progressiongroup, "kdHistoryD", 4, int(clamp(var_1, 0, 255)));
  self setplayerdata(level.progressiongroup, "headshotHistory", 4, int(clamp(var_2, 0, 255)));
  self setplayerdata(level.progressiongroup, "accuracyHistory", 4, int(clamp(var_3, 0, 255)));
  self setplayerdata(level.progressiongroup, "damageHistory", 4, var_4);
}

_id_7DF5(var_0, var_1, var_2) {
  if(scripts\mp\utility\weapon::_id_88F6(var_0)) {
    return;
  }
  if(istrue(level._id_4AFF)) {
    return;
  }
  if(scripts\mp\utility\game::onlinestatsenabled()) {
    var_3 = self getplayerdata(level.progressiongroup, "playerStats", "weaponStats", var_0, var_1);
    self setplayerdata(level.progressiongroup, "playerStats", "weaponStats", var_0, var_1, var_3 + var_2);
  }
}

_id_7DEB(var_0, var_1, var_2, var_3) {
  if(istrue(level._id_4AFF)) {
    return;
  }
  if(!scripts\mp\utility\weapon::_id_1D9D(var_0, var_3)) {
    return;
  }
  if(scripts\mp\utility\game::onlinestatsenabled()) {
    var_4 = self getplayerdata(level.progressiongroup, "playerStats", "attachmentsStats", var_0, var_1);
    self setplayerdata(level.progressiongroup, "playerStats", "attachmentsStats", var_0, var_1, var_4 + var_2);
  }
}

_id_FD88() {
  if(!isDefined(self._id_F40F)) {
    return;
  }
  if(isnullweapon(self._id_F40F)) {
    return;
  }
  if(scripts\mp\utility\weapon::_id_8A7D(self._id_F40F)) {
    if(!istrue(scripts\mp\supers::_id_DBFC(self._id_F40F))) {
      return;
    }
  }

  if(scripts\mp\utility\weapon::_id_88F6(self._id_F40F) || scripts\mp\utility\weapon::_id_8834(self._id_F40F) || scripts\mp\utility\weapon::_id_8787(self._id_F40F)) {
    return;
  }
  var_0 = self._id_F40F;
  var_1 = undefined;

  if(var_0._id_0245) {
    var_2 = scripts\mp\utility\weapon::_id_1DA5(var_0._id_04B7);

    if(var_2 == "shotgun" || var_2 == "gl" || var_2 == "glsmoke" || var_2 == "glgas" || var_2 == "glconc" || var_2 == "glflash" || var_2 == "glincendiary" || var_2 == "glsemtex" || var_2 == "glsnap") {
      var_1 = var_2;
      _id_B019(var_1, var_0);
      _id_B00E();
      return;
    }
  }

  if(!isDefined(var_1)) {
    var_3 = var_0.basename;
    var_4 = _func_00D6(var_3, 0, 3);

    if(scripts\mp\utility\weapon::_id_8AFA(var_0)) {
      var_1 = var_3;
    } else if(var_4 == "iw8" || var_4 == "s4_") {
      var_1 = scripts\mp\utility\weapon::getweaponrootname(var_0);
    }
  }

  if(!scripts\mp\utility\weapon::_id_879A(var_1) && !scripts\mp\utility\weapon::_id_879C(var_1)) {
    return;
  }
  var_5 = _func_02F7(var_0);
  _id_B00F(var_1, var_5);

  if(!scripts\mp\utility\weapon::_id_897E(var_0)) {
    _id_B01A(var_1, var_5);
  }

  var_6 = getweaponattachments(var_0);

  foreach(var_2 in var_6) {
    var_8 = scripts\mp\utility\weapon::_id_1DA5(var_2);

    if(!scripts\mp\utility\weapon::_id_1D9D(var_8, var_0)) {
      continue;
    }
    switch (var_8) {
      case "shotgun":
      case "glsnap":
      case "glsemtex":
      case "glincendiary":
      case "glflash":
      case "glconc":
      case "glgas":
      case "glsmoke":
      case "gl":
        continue;
    }

    _id_B019(var_8, var_0);
  }

  _id_B00E();
}

_id_B00E() {
  self._id_F40F = _func_0375();
  self._id_F414 = 0;
  self._id_F413 = 0;
  self._id_F412 = 0;
  self._id_F411 = 0;
  self._id_F410 = 0;
}

_id_B00F(var_0, var_1) {
  if(self._id_F414 > 0) {
    _id_7DF5(var_0, "shots", self._id_F414);
  }

  if(self._id_F413 > 0) {
    _id_7DF5(var_0, "kills", self._id_F413);
  }

  if(self._id_F412 > 0) {
    _id_7DF5(var_0, "hits", self._id_F412);
  }

  if(self._id_F411 > 0) {
    _id_7DF5(var_0, "headShots", self._id_F411);
  }

  if(self._id_F410 > 0) {
    _id_7DF5(var_0, "deaths", self._id_F410);
  }
}

_id_B01A(var_0, var_1) {
  if(self._id_F414 > 0) {
    var_2 = spawnStruct();
    var_2._id_04FE = var_0;
    var_2.statname = "shots";
    var_2.incvalue = self._id_F414;
    var_2._id_04CC = var_1;
    _id_06E2::_id_4C2A("callback_update_weapon_stats", var_2);
  }

  if(self._id_F413 > 0) {
    var_2 = spawnStruct();
    var_2._id_04FE = var_0;
    var_2.statname = "kills";
    var_2.incvalue = self._id_F413;
    var_2._id_04CC = var_1;
    _id_06E2::_id_4C2A("callback_update_weapon_stats", var_2);
  }

  if(self._id_F412 > 0) {
    var_2 = spawnStruct();
    var_2._id_04FE = var_0;
    var_2.statname = "hits";
    var_2.incvalue = self._id_F412;
    var_2._id_04CC = var_1;
    _id_06E2::_id_4C2A("callback_update_weapon_stats", var_2);
  }

  if(self._id_F411 > 0) {
    var_2 = spawnStruct();
    var_2._id_04FE = var_0;
    var_2.statname = "headshots";
    var_2.incvalue = self._id_F411;
    var_2._id_04CC = var_1;
    _id_06E2::_id_4C2A("callback_update_weapon_stats", var_2);
  }

  if(self._id_F410 > 0) {
    var_2 = spawnStruct();
    var_2._id_04FE = var_0;
    var_2.statname = "deaths";
    var_2.incvalue = self._id_F410;
    var_2._id_04CC = var_1;
    _id_06E2::_id_4C2A("callback_update_weapon_stats", var_2);
  }
}

_id_B019(var_0, var_1) {
  if(!scripts\mp\utility\weapon::_id_1D9D(var_0, var_1)) {
    return;
  }
  if(self._id_F414 > 0 && var_0 != "tactical") {
    _id_7DEB(var_0, "shots", self._id_F414, var_1);
    scripts\common\utility::_id_F73A(level._id_9BB0, var_0, "shots", self._id_F414, var_1);
  }

  if(self._id_F413 > 0 && var_0 != "tactical") {
    _id_7DEB(var_0, "kills", self._id_F413, var_1);
    scripts\common\utility::_id_F73A(level._id_9BB0, var_0, "kills", self._id_F413, var_1);
  }

  if(self._id_F412 > 0 && var_0 != "tactical") {
    _id_7DEB(var_0, "hits", self._id_F412, var_1);
    scripts\common\utility::_id_F73A(level._id_9BB0, var_0, "hits", self._id_F412, var_1);
  }

  if(self._id_F411 > 0 && var_0 != "tactical") {
    _id_7DEB(var_0, "headShots", self._id_F411, var_1);
    scripts\common\utility::_id_F73A(level._id_9BB0, var_0, "headShots", self._id_F411, var_1);
  }

  if(self._id_F410 > 0) {
    _id_7DEB(var_0, "deaths", self._id_F410, var_1);
    scripts\common\utility::_id_F73A(level._id_9BB0, var_0, "deaths", self._id_F410, var_1);
  }
}

_id_FD9E() {
  level waittill("game_ended");

  if(!scripts\mp\utility\game::matchmakinggame()) {
    return;
  }
  var_0 = 0;
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;

  foreach(var_7 in level.players) {
    var_5 = var_5 + var_7._id_F242["total"];
  }

  _func_03BF("dlog_event_global_minutes", ["increment", int(var_5 / 60)]);

  if(scripts\mp\utility\game::isroundbased() && !scripts\mp\utility\game::_id_10A16()) {
    return;
  }
  waitframe();

  foreach(var_7 in level.players) {
    var_0 = var_0 + var_7._id_0267;
    var_1 = var_1 + var_7._id_0157;
    var_2 = var_2 + var_7._id_006F;
    var_3 = var_3 + var_7 scripts\mp\utility\stats::_id_6C29("headshots");
    var_4 = var_4 + var_7 scripts\mp\utility\stats::_id_6C29("suicides");
  }

  _func_03BF("dlog_event_global_kills", ["increment", var_0]);
  _func_03BF("dlog_event_global_deaths", ["increment", var_1]);
  _func_03BF("dlog_event_global_headshots", ["increment", var_3]);
  _func_03BF("dlog_event_global_suicides", ["increment", var_4]);
  _func_03BF("dlog_event_global_games", ["increment", 1]);

  if(!isDefined(level._id_1D2C)) {
    _func_03BF("dlog_event_global_assists", ["increment", var_2]);
  }
}