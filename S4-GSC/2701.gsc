/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2701.gsc
*************************************************/

_id_9136(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(game["dialog"][var_0])) {
    return;
  }
  if(level.teambased && !isDefined(var_1)) {
    return;
  }
  var_7 = level.players;

  if(isDefined(var_1)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getTeamData")) {
      var_7 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getTeamData")]](var_1, "players");
    }
  }

  for(var_8 = 0; var_8 < var_7.size; var_8++) {
    var_9 = var_7[var_8];

    if(isDefined(var_3) && scripts\engine\utility::array_contains(var_3, var_9)) {
      continue;
    }
    if(var_9 _meth_81E2() && !var_9 _meth_81E3()) {
      continue;
    }
    var_9 _id_9138(var_0, var_2, undefined, var_4, var_5, var_6);
  }
}

_id_829D() {
  foreach(var_1 in level._id_EF89) {
    level._id_90A3[var_1][""] = 0;
  }
}

_id_E775(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(var_2) || !isDefined(var_6)) {
    var_6 = 0;
  }

  if(!isDefined(var_7)) {
    var_7 = 1;
  }

  if(istrue(level.gameended)) {
    return;
  }
  if(!isDefined(level._id_90A3[var_1][var_0])) {
    level._id_90A3[var_1][var_0] = 0;
  }

  if(isDefined(var_2) && istrue(var_6) && !isDefined(level._id_90A3[var_1][var_2])) {
    level._id_90A3[var_1][var_2] = 0;
  }

  if(isDefined(var_5)) {
    if(gettime() < level._id_90A3[var_1][var_0] + var_5) {
      return;
    }
    var_5 = undefined;
  } else if(gettime() < level._id_90A3[var_1][var_0] + _id_69DD() + scripts\engine\utility::ter_op(var_7, getplayercounttimeoffset() * 1000, 0))
    return;
  else if(isDefined(var_2) && istrue(var_6) && gettime() < level._id_90A3[var_1][var_2] + 5000) {
    return;
  }
  thread _id_46C0(var_0, var_1, var_2, var_3, var_4, var_5);
  level._id_90A3[var_1][var_0] = gettime();

  if(isDefined(var_2) && istrue(var_6)) {
    level._id_90A3[var_1][var_2] = gettime();
  }
}

_id_46C0(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  level endon("game_ended");
  wait 0.1;
  scripts\mp\utility\script::_id_1096C();
  _id_9136(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

_id_9139(var_0, var_1, var_2, var_3) {
  foreach(var_5 in var_1) {
    var_5 _id_9137(var_0, var_2, undefined, var_3);
  }
}

_id_9137(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(game["dialog"][var_0])) {
    return;
  }
  _id_9138(var_0, var_1, var_2, var_3, var_4, var_5);
}

_id_9138(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(istrue(level._id_4A7D)) {
    return;
  }
  if(isDefined(level._id_9FEC) && self[[level._id_9FEC]](var_0)) {
    return;
  }
  if(scripts\mp\utility\game::getgametype() == "arena_evo" && !isDefined(var_1)) {
    var_1 = "chvo";
    var_5 = 1;
    var_4 = 5;
    var_6 = 0;
  }

  if(!isDefined(var_1)) {
    var_1 = "generic";
    var_5 = 1;
    var_4 = 5;
  }

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  if(!isDefined(var_6)) {
    var_6 = 1;
  }

  if(isDefined(var_4)) {
    var_4 = var_4 * 1000;

    if(!isDefined(self._id_B705)) {
      _id_829E();
    }

    if(gettime() < self._id_B705["time"] + var_4 + scripts\engine\utility::ter_op(var_6, getplayercounttimeoffset(), 0) && self._id_B705["dialog"] == var_0) {
      return;
    }
    if(var_5 && !istrue(var_2) && gettime() < self._id_B705["time"] + var_4 + scripts\engine\utility::ter_op(var_6, getplayercounttimeoffset(), 0) && self._id_B705["group"] == var_1) {
      return;
    }
    self._id_B705["time"] = gettime();
    self._id_B705["dialog"] = var_0;

    if(var_5) {
      self._id_B705["group"] = var_1;
    }
  }

  var_7 = self.pers["team"];

  if(level.gametype == "br") {
    var_7 = scripts\mp\gametypes\br_public::_id_2BBB(self);
  }

  if(isDefined(var_7) && scripts\mp\utility\teams::_id_8878(var_7)) {
    var_8 = self getplayerdata("common", "mp_announcer_type");
    var_9 = "mp_glob_";
    var_10 = 0;
    var_11 = "";
    var_12 = _func_0107(game["dialog"][var_0]);

    if(var_12) {
      var_10 = randomint(game["dialog"][var_0].size);
      var_11 = game["dialog"][var_0][var_10];
    }

    if(var_8 > 0) {
      var_13 = tablelookupbyrow("mp/announcervoicedata.csv", var_8, 3);
      var_14 = var_9 + var_13 + "_" + scripts\engine\utility::ter_op(var_12, var_11, game["dialog"][var_0]);
    } else {
      var_15 = _id_6D07(var_1);
      var_14 = var_9 + var_15 + "bchr_" + scripts\engine\utility::ter_op(var_12, var_11, game["dialog"][var_0]);

      if(!_func_0205(var_14)) {
        var_14 = var_9 + "gene_" + "bchr_" + scripts\engine\utility::ter_op(var_12, var_11, game["dialog"][var_0]);
      }
    }

    if(scripts\mp\utility\game::getgametype() == "arena_evo" && issubstr(var_0, "timesup")) {
      return;
    }
    if(scripts\mp\utility\game::_id_8701()) {
      var_16 = "mp";
      var_17 = "glob";
      var_15 = _id_6724(game["dialog"][var_0]);
      var_18 = "ald1";
      var_19 = game["dialog"][var_0];

      if(!_id_56A0(var_19) || issubstr(var_19, var_18)) {
        var_14 = game["dialog"][var_0];
      } else {
        var_14 = var_16 + "_" + var_17 + "_" + var_15 + "_" + var_18 + "_" + var_19;
      }
    }

    if(!var_12 && issubstr(game["dialog"][var_0], "mp_glob")) {
      var_14 = game["dialog"][var_0];
    } else if(var_12 && issubstr(var_11, "mp_glob")) {
      var_14 = var_11;
    }

    var_14 = tolower(var_14);
    var_20 = _func_0142(var_14) / 1000.0;
    self _meth_8287(var_14, var_0, var_20, var_1, var_2, var_3);
  }

  if(issubstr(var_0, "secured") || var_0 == "friendly_captured_2") {
    thread scripts\mp\s4_quips_mp::triggerquip("quiptrigger_013");
  } else if(issubstr(var_0, "lost") || var_0 == "enemy_captured_2") {
    thread scripts\mp\s4_quips_mp::triggerquip("quiptrigger_014");
  }
}

_id_6D07(var_0) {
  var_1 = "";

  if(!isDefined(var_0) || !_func_0121(var_0)) {
    return var_1 + "_";
  }

  if(var_0 == "gametype" || var_0 == "status") {
    switch (level.gametype) {
      case "dom":
        var_1 = "domi";
        break;
      case "war":
        var_1 = "tdm";
        break;
      case "arena_evo":
        var_1 = "chvo";
        break;
      default:
        var_1 = "";
        break;
    }
  } else if(var_0 == "killstreak_used" || var_0 == "killstreak_earned")
    var_1 = "kill";
  else {
    var_1 = var_0;
  }

  return var_1 + "_";
}

_id_6724(var_0) {
  var_1 = "";

  if(isDefined(level._id_490C[var_0])) {
    return level._id_490C[var_0];
  }

  switch (level.gametype) {
    case "dom":
      var_1 = "domi";
      break;
    case "war":
      var_1 = "tmdm";
      break;
    default:
      var_1 = "";
      break;
  }

  return var_1;
}

_id_56A0(var_0) {
  return isDefined(level._id_490C[var_0]);
}

_id_829E() {
  self._id_B705["time"] = 0;
  self._id_B705["dialog"] = "";
  self._id_B705["group"] = "";
}

_id_B871(var_0) {
  var_1 = self.team;
  var_2 = [self];

  if(getdvarint("#x367a86a14fe025540", 1)) {
    var_2 = [];
  }

  var_3 = var_1;

  if(level.gametype == "br") {
    var_3 = scripts\mp\gametypes\br_public::_id_2BBB(self);
  }

  if(level.teambased) {
    if(isDefined(level._id_8DC5[var_0])) {
      if(isDefined(level._id_8DC5[var_0][var_1])) {
        if(gettime() < level._id_8DC5[var_0][var_1]) {
          return;
        }
      }
    }

    level._id_8DC5[var_0][var_1] = gettime() + 10000;
  }

  var_4 = self _meth_81E4();

  if(isDefined(var_4)) {
    var_2[var_2.size] = var_4;
  }

  var_5 = level._id_8DD5._id_EA18._id_EC74[var_0]["kills"];

  if(level.teambased) {
    var_6 = _id_31B2(var_0, 1);
    var_7 = _id_31B2(var_0);

    if(istrue(var_6)) {
      _id_9136(var_3 + "_friendly_" + var_0 + "_inbound", var_1, "killstreak_used", var_2, undefined, 0);
    }

    if(!isDefined(var_4)) {
      var_2 = undefined;
    }

    if(istrue(var_7) && scripts\mp\utility\killstreak::_id_6AE1(var_0)) {
      foreach(var_9 in level._id_EF89) {
        if(var_9 != var_1) {
          _id_9136(var_3 + "_enemy_" + var_0 + "_inbound", var_9, "killstreak_used", var_2, undefined, scripts\engine\utility::ter_op(var_5 >= 5, undefined, 0));
        }
      }

      return;
    }
  } else if(scripts\mp\utility\killstreak::_id_6AE1(var_0)) {
    var_11 = [self];
    _id_9136(var_3 + "_enemy_" + var_0 + "_inbound", undefined, "killstreak_used", var_11, undefined, scripts\engine\utility::ter_op(var_5 >= 5, undefined, 0));
    var_12 = [];

    foreach(var_14 in level.players) {
      if(var_14 != self) {
        var_12[var_12.size] = var_14;
      }
    }

    _id_9136(var_3 + "_friendly_" + var_0 + "_inbound", var_1, "killstreak_used", var_12, undefined, 0);
  }
}

_id_B86E(var_0, var_1, var_2, var_3) {
  if(level._id_DCBA) {
    return;
  }
  var_0 = _id_68FE(var_0);

  if(!isDefined(game["dialog"][var_0])) {
    return;
  }
  var_4 = game["dialog"][var_0];

  if(issubstr(var_4, "op_" + var_0) || var_4 == "op_" + var_0) {
    _id_09C1::_id_AC3E(var_0, var_1, var_2, var_3);
  } else {
    _id_9137(var_0, var_1, var_2, var_3);
  }
}

_id_68FE(var_0) {
  var_1 = strtok(var_0, "_");
  var_2 = undefined;

  foreach(var_6, var_4 in var_1) {
    if(!isDefined(var_2)) {
      var_2 = var_4;
    } else {
      var_2 = var_2 + var_4;
    }

    var_5 = var_1[var_6 + 1];

    if(isDefined(var_5)) {
      if(var_5 == "rare" || var_5 == "legend" || var_5 == "epic") {
        break;
      } else
        var_2 = var_2 + "_";
    }
  }

  return var_2;
}

_id_31B2(var_0, var_1) {
  var_2 = 1;

  if(level.gametype == "br") {
    if(istrue(var_1)) {
      switch (var_0) {
        case "manual_turret":
        case "airdrop":
        case "radar_drone_overwatch":
          var_2 = 0;
          break;
      }
    } else {
      switch (var_0) {
        case "manual_turret":
        case "uav":
        case "airdrop":
        case "toma_strike":
        case "precision_airstrike":
        case "radar_drone_overwatch":
          var_2 = 0;
          break;
      }
    }
  } else if(level.gametype == "arm") {
    switch (var_0) {
      case "manual_turret":
      case "airdrop":
      case "radar_drone_overwatch":
        var_2 = 0;
        break;
    }
  } else if(istrue(var_1)) {
    switch (var_0) {
      case "radar_drone_overwatch":
        var_2 = 0;
        break;
    }
  }

  return var_2;
}

_id_DD6B(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(game["dialog"][var_0])) {
    return;
  }
  var_5 = gettime();

  if(!isDefined(self._id_9046) || var_5 < self._id_9046 + 30000 || var_5 < level._id_90A3[self.team][var_0] + 5000) {
    return;
  }
  if(isDefined(var_4)) {
    var_6 = var_4;
  } else {
    var_6 = scripts\mp\utility\teams::_id_6DDF(self.team);
  }

  self._id_9046 = var_5;
  var_7 = "dx_mpa_" + var_6 + "tl_" + game["dialog"][var_0];
  self _meth_8287(var_7, var_0, 2, var_1, var_2, var_3);
}

_id_6AE0() {
  return 10;
}

_id_69DD() {
  if(istrue(level._id_97C9)) {
    return 15000;
  } else {
    return 5000;
  }
}

getplayercounttimeoffset() {
  var_0 = 0;

  if(scripts\mp\utility\game::_id_8A5F() && scripts\mp\utility\game::getgametype() == "br") {
    var_0 = 0;
  } else if(level._id_9C5D <= 12) {
    var_0 = 0;
  } else if(level._id_9C5D > 12 && level._id_9C5D <= 24) {
    var_0 = 10;
  } else if(level._id_9C5D > 24 && level._id_9C5D <= 40) {
    var_0 = 15;
  } else {
    var_0 = 20;
  }

  return var_0;
}