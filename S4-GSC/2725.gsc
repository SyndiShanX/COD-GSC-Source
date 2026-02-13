/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2725.gsc
*************************************************/

_id_6DCA(var_0, var_1) {
  return level._id_EF6A[var_0][var_1];
}

_id_D70F(var_0, var_1, var_2) {
  level._id_EF6A[var_0][var_1] = var_2;
}

_id_A010(var_0, var_1, var_2) {
  level._id_EF6A[var_0][var_1] = level._id_EF6A[var_0][var_1] + var_2;
}

_id_1114(var_0, var_1, var_2) {
  level._id_EF6A[var_1]["teamCount"]++;
  level._id_EF6A[var_1]["players"] = ::scripts\engine\utility::array_add(level._id_EF6A[var_1]["players"], var_0);

  if(var_2) {
    _id_1178(var_0, var_1);
  }
}

_id_C509(var_0, var_1) {
  level._id_EF6A[var_1]["teamCount"]--;
  level._id_EF6A[var_1]["players"] = ::scripts\engine\utility::array_remove(level._id_EF6A[var_1]["players"], var_0);
}

_id_1178(var_0, var_1, var_2) {
  level._id_EF6A[var_1]["aliveCount"]++;
  level._id_EF6A[var_1]["alivePlayers"] = ::scripts\engine\utility::array_add(level._id_EF6A[var_1]["alivePlayers"], var_0);

  if(level._id_A2FC) {
    level._id_EF6A[var_1]["deathEvent"] = 0;
  }

  _id_FF42("add", var_1, var_0);

  if(scripts\mp\utility\game::_id_98D3()) {
    return;
  }
  if(istrue(var_2) && _id_8878(var_1) && !scripts\cp_mp\utility\game_utility::_id_89EC()) {
    foreach(var_0 in level._id_EF6A[var_1]["players"]) {
      var_0 playlocalsound("mp_bodycount_tick_positive");
    }

    var_5 = _id_69FD(var_1);

    foreach(var_0 in var_5) {
      var_0 playlocalsound("mp_bodycount_tick_negative");
    }
  }
}

_id_C4BE(var_0, var_1, var_2) {
  level._id_EF6A[var_1]["aliveCount"]--;
  level._id_EF6A[var_1]["alivePlayers"] = ::scripts\engine\utility::array_remove(level._id_EF6A[var_1]["alivePlayers"], var_0);
  _id_FF42("remove", var_1, var_0);

  if(istrue(var_2) && _id_8878(var_1) && !scripts\cp_mp\utility\game_utility::_id_89EC()) {
    var_3 = "mp_bodycount_tick_negative";
    var_4 = "mp_bodycount_tick_positive";

    if(level._id_EF6A[var_1]["aliveCount"] == 1) {
      var_3 = "mp_bodycount_tick_negative_final";
      var_4 = "mp_bodycount_tick_positive_final";
    }

    foreach(var_0 in level._id_EF6A[var_1]["players"]) {}

    if(!scripts\mp\utility\game::_id_98D3()) {
      var_7 = _id_69FD(var_1);

      foreach(var_0 in var_7) {}
    }
  }
}

_id_FF42(var_0, var_1, var_2) {
  var_3 = getdvarint("#x33d0c09ed4682d992", 1);
  var_4 = 0;
  var_5 = 0;

  if(var_0 == "disconnect") {
    var_4 = scripts\engine\utility::array_contains(level._id_EF6A[var_1]["alivePlayers"], var_2);

    if(var_4 && var_3) {
      var_2 scripts\mp\playerlogic::_id_C4A4(1);
    }
  } else if(var_0 == "add") {
    var_6 = scripts\engine\utility::_id_1BC1(level._id_EF6A[var_1]["alivePlayers"]);

    if(var_6.size < level._id_EF6A[var_1]["alivePlayers"].size) {
      var_5 = 1;
      var_0 = var_0 + " duplicate";
    }
  }

  var_7 = level._id_EF6A[var_1]["alivePlayers"].size;
  var_8 = level._id_EF6A[var_1]["aliveCount"];

  if(var_7 != var_8 || var_4 || var_5) {
    var_9 = "";

    if(var_5) {
      var_9 = "WARNING: Duplicate players in alive player array";
    } else if(var_4) {
      var_9 = "WARNING: player in alive array after disconnect!";
    } else {
      var_9 = "WARNING: alivePlayers and aliveCount are out of sync!";
    }

    _func_03BF("dlog_event_alive_count_mismatch", ["alive_players", var_7, "alive_count", var_8, "event", var_0, "team", var_1, "player_xuid", var_2 getxuid(), "player_name", var_2.name]);
    scripts\mp\utility\script::_id_47BB(var_9);

    if(var_3) {
      level._id_EF6A[var_1]["alivePlayers"] = ::scripts\engine\utility::_id_1BC1(level._id_EF6A[var_1]["alivePlayers"]);
      level._id_EF6A[var_1]["aliveCount"] = level._id_EF6A[var_1]["alivePlayers"].size;
      [[level._id_FC75]]();
    }
  }
}

_id_6DC9(var_0, var_1) {
  if(istrue(var_1)) {
    return level._id_EF6A[var_0]["alivePlayers"].size;
  } else {
    return level._id_EF6A[var_0]["players"].size;
  }
}

_id_6A01(var_0) {
  var_1 = level._id_EF89;
  var_1 = scripts\engine\utility::array_remove(var_1, var_0);
  return var_1;
}

_id_6A59(var_0, var_1) {
  var_2 = [];

  if(istrue(var_1)) {
    foreach(var_4 in level._id_EF6A[var_0]["alivePlayers"]) {
      if(isDefined(var_4) && isalive(var_4) && !isDefined(var_4._id_59E0)) {
        var_2[var_2.size] = var_4;
      }
    }
  } else {
    foreach(var_4 in level._id_EF6A[var_0]["players"]) {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

_id_69FD(var_0, var_1) {
  var_2 = [];
  var_3 = _id_6A01(var_0);

  foreach(var_5 in var_3) {
    if(istrue(var_1)) {
      foreach(var_7 in level._id_EF6A[var_5]["alivePlayers"]) {
        if(isDefined(var_7) && isalive(var_7) && !isDefined(var_7._id_59E0)) {
          var_2[var_2.size] = var_7;
        }
      }

      continue;
    }

    foreach(var_7 in level._id_EF6A[var_5]["players"]) {
      var_2[var_2.size] = var_7;
    }
  }

  return var_2;
}

_id_69FB(var_0, var_1) {
  var_2 = 0;
  var_3 = _id_6A01(var_0);

  foreach(var_5 in var_3) {
    var_2 = var_2 + _id_6DC9(var_5, istrue(var_1));
  }

  return var_2;
}

_id_8878(var_0) {
  return isDefined(var_0) && scripts\engine\utility::array_contains(level._id_EF89, var_0);
}

_id_6A2F(var_0) {
  return game[var_0];
}

_id_6DD3(var_0) {
  if(!isDefined(level._id_EF6A[var_0]["teamName"])) {
    level._id_EF6A[var_0]["teamName"] = _func_0226("mp/factionTable.csv", 0, game[var_0], 1);
  }

  return level._id_EF6A[var_0]["teamName"];
}

_id_6DDA(var_0) {
  if(!isDefined(level._id_EF6A[var_0]["shortName"])) {
    level._id_EF6A[var_0]["shortName"] = _func_0226("mp/factionTable.csv", 0, game[var_0], 2);
  }

  return level._id_EF6A[var_0]["shortName"];
}

_id_6DD0(var_0) {
  if(!isDefined(level._id_EF6A[var_0]["teamIcon"])) {
    level._id_EF6A[var_0]["teamIcon"] = _func_0222("mp/factionTable.csv", 0, game[var_0], 5);
  }

  return level._id_EF6A[var_0]["teamIcon"];
}

_id_6DCF(var_0) {
  if(!isDefined(level._id_EF6A[var_0]["headIcon"])) {
    level._id_EF6A[var_0]["headIcon"] = _func_0222("mp/factionTable.csv", 0, game[var_0], 7);
  }

  return level._id_EF6A[var_0]["headIcon"];
}

_id_6DDF(var_0) {
  if(!isDefined(level._id_EF6A[var_0]["soundInfix"])) {
    level._id_EF6A[var_0]["soundInfix"] = _func_0222("mp/factionTable.csv", 0, game[var_0], 8);
  }

  return level._id_EF6A[var_0]["soundInfix"];
}

_id_69BA(var_0) {
  if(!isDefined(level._id_EF6A[var_0]["customizationInfix"])) {
    level._id_EF6A[var_0]["customizationInfix"] = _func_0222("mp/factionTable.csv", 0, game[var_0], 10);
  }

  return level._id_EF6A[var_0]["customizationInfix"];
}

_id_6DCC(var_0) {
  if(!isDefined(level._id_EF6A[var_0]["teamFaction"])) {
    switch (var_0) {
      case "axis":
        var_1 = 10;
        break;
      case "allies":
        var_1 = 11;
        break;
      case "team_three":
        var_1 = 12;
        break;
      case "team_four":
        var_1 = 13;
        break;
      case "team_five":
        var_1 = 14;
        break;
      case "team_six":
        var_1 = 15;
        break;
      case "team_seven":
        var_1 = 46;
        break;
      case "team_eight":
        var_1 = 47;
        break;
      case "team_nine":
        var_1 = 48;
        break;
      case "team_ten":
        var_1 = 49;
        break;
      case "team_eleven":
        var_1 = 50;
        break;
      default:
        var_1 = 11;
        break;
    }

    level._id_EF6A[var_0]["teamFaction"] = _func_0222("mp/mapInfo.csv", 0, scripts\cp_mp\utility\game_utility::_id_6B2D(), var_1);

    if(level._id_EF6A[var_0]["teamFaction"] == "") {
      level._id_EF6A[var_0]["teamFaction"] = "USMC";
    }

    game[var_0] = level._id_EF6A[var_0]["teamFaction"];
  }

  return level._id_EF6A[var_0]["teamFaction"];
}

_id_69B8() {
  var_0 = scripts\mp\utility\game::getgametype();
  return getdvarint(_func_0483("#x3ecead486797add6d", var_0, "_teamcount"), -1);
}

_id_EF5C() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("team_utility", "getFriendlyPlayers", ::_id_6A59);
  scripts\cp_mp\utility\script_utility::registersharedfunc("team_utility", "getEnemyPlayers", ::_id_69FD);
}