/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\teams.gsc
***********************************************/

function getteamdata(var_0, var_1) {
  return level.teamdata[var_0][var_1];
}

function setteamdata(var_0, var_1, var_2) {
  level.teamdata[var_0][var_1] = var_2;
}

function modifyteamdata(var_0, var_1, var_2) {
  level.teamdata[var_0][var_1] += var_2;
}

function addplayertoteam(var_0, var_1, var_2) {
  level.teamdata[var_1]["teamCount"]++;
  level.teamdata[var_1]["players"] = scripts\engine\utility::array_add(level.teamdata[var_1]["players"], var_0);

  if(var_2) {
    addtoteamlives(var_0, var_1, 0, "addPlayerToTeam");
    return;
  }
}

function removeplayerfromteam(var_0, var_1) {
  level.teamdata[var_1]["teamCount"]--;
  level.teamdata[var_1]["players"] = scripts\engine\utility::array_remove(level.teamdata[var_1]["players"], var_0);
}

function addtoteamlives(var_0, var_1, var_2, var_3) {
  level.teamdata[var_1]["aliveCount"]++;
  level.teamdata[var_1]["alivePlayers"] = scripts\engine\utility::array_add(level.teamdata[var_1]["alivePlayers"], var_0);

  if(level.multiteambased) {
    level.teamdata[var_1]["deathEvent"] = 0;
  }

  ref_140C9("add", var_1, var_0);

  if(isDefined(level.ref_11C65)) {
    [[level.ref_11C65]](var_0, var_1, var_3);
  }

  if(scripts\mp\utility\game::lpcfeaturegated()) {
    return;
  }

  if(istrue(var_2) && isgameplayteam(var_1) && !scripts\cp_mp\utility\game_utility::isrealismenabled()) {
    foreach(var_0 in level.teamdata[var_1]["players"]) {
      var_0 playlocalsound("mp_bodycount_tick_positive");
    }

    var_6 = getenemyplayers(var_1);

    foreach(var_0 in var_6) {
      var_0 playlocalsound("mp_bodycount_tick_negative");
    }

    return;
  }
}

function removefromteamlives(var_0, var_1, var_2, var_3) {
  level.teamdata[var_1]["aliveCount"]--;
  level.teamdata[var_1]["alivePlayers"] = scripts\engine\utility::array_remove(level.teamdata[var_1]["alivePlayers"], var_0);
  ref_140C9("remove", var_1, var_0);

  if(isDefined(level.ref_11C7E)) {
    [[level.ref_11C7E]](var_0, var_1, var_3);
  }

  if(istrue(var_2) && isgameplayteam(var_1) && !scripts\cp_mp\utility\game_utility::isrealismenabled()) {
    var_4 = "mp_bodycount_tick_negative";
    var_5 = "mp_bodycount_tick_positive";

    if(level.teamdata[var_1]["aliveCount"] == 1) {
      var_4 = "mp_bodycount_tick_negative_final";
      var_5 = "mp_bodycount_tick_positive_final";
    }

    var_6 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var_1, var_0.squadindex);

    foreach(var_0 in var_6) {
      var_0 playlocalsound(var_4);
    }

    if(!scripts\mp\utility\game::lpcfeaturegated()) {
      var_9 = getenemyplayers(var_1);

      foreach(var_0 in var_9) {
        var_0 playlocalsound(var_5);
      }

      return;
    }

    return;
  }
}

function ref_140C9(var_0, var_1, var_2) {
  var_3 = getdvarint("scr_alive_count_fix", 1);
  var_4 = 0;
  var_5 = 0;

  if(var_0 == "disconnect") {
    var_4 = scripts\engine\utility::array_contains(level.teamdata[var_1]["alivePlayers"], var_2);

    if(var_4 && var_3) {
      var_2 scripts\mp\playerlogic::removefromalivecount(1, "validateAliveCount");
    }
  } else if(var_0 == "add") {
    var_6 = scripts\engine\utility::array_remove_duplicates(level.teamdata[var_1]["alivePlayers"]);

    if(var_6.size < level.teamdata[var_1]["alivePlayers"].size) {
      var_5 = 1;
      var_0 += " duplicate";
    }
  }

  var_7 = level.teamdata[var_1]["alivePlayers"].size;
  var_8 = level.teamdata[var_1]["aliveCount"];

  if(var_7 != var_8 || var_4 || var_5) {
    var_9 = "";

    if(var_5) {
      var_9 = "WARNING: Duplicate players in alive player array";
    } else if(var_4) {
      var_9 = "WARNING: player in alive array after disconnect!";
    } else {
      var_9 = "WARNING: alivePlayers and aliveCount are out of sync!";
    }

    getentitylessscriptablearray("dlog_event_alive_count_mismatch", ["alive_players", var_7, "alive_count", var_8, "event", var_0, "team", var_1, "player_xuid", var_2 getxuid(), "player_name", var_2.name]);
    scripts\mp\utility\script::laststand_dogtags(var_9);

    if(var_3) {
      level.teamdata[var_1]["alivePlayers"] = scripts\engine\utility::array_remove_duplicates(level.teamdata[var_1]["alivePlayers"]);
      level.teamdata[var_1]["aliveCount"] = level.teamdata[var_1]["alivePlayers"].size;
      [[level.updategameevents]]();
      return;
    }

    return;
  }
}

function getteamcount(var_0, var_1) {
  if(istrue(var_1)) {
    return level.teamdata[var_0]["alivePlayers"].size;
  }

  return level.teamdata[var_0]["players"].size;
}

function resetchallengetimer() {
  var_0 = 0;

  foreach(var_2 in level.teamnamelist) {
    var_3 = getteamcount(var_2, 1);

    if(var_3 > 0) {
      var_0++;
    }
  }

  return var_0;
}

function getenemyteams(var_0) {
  var_1 = level.teamnamelist;
  var_1 = scripts\engine\utility::array_remove(var_1, var_0);

  if(isDefined(level.ref_14687) || scripts\mp\utility\game::deposit_from_compromised_convoy_delayed_failsafe()) {
    var_1 = scripts\engine\utility::array_remove(var_1, "team_two_hundred");
  }

  return var_1;
}

function getfriendlyplayers(var_0, var_1) {
  var_2 = [];
  jumpiffalse(istrue(var_1)) LOC_0000005e;

  foreach(var_4 in level.teamdata[var_0]["alivePlayers"]) {
    if(isDefined(var_4) && isalive(var_4) && !isDefined(var_4.fauxdead)) {
      var_2 = var_4;
    }
  }

  goto LOC_00000093;
}

function getenemyplayers(var_0, var_1) {
  var_2 = [];
  var_3 = getenemyteams(var_0);

  foreach(var_5 in var_3) {
    if(istrue(var_1)) {
      foreach(var_7 in level.teamdata[var_5]["alivePlayers"]) {
        if(isDefined(var_7) && isalive(var_7) && !isDefined(var_7.fauxdead)) {
          var_2 = var_7;
        }
      }

      continue;
    }

    foreach(var_7 in level.teamdata[var_5]["players"]) {
      var_2 = var_7;
    }
  }

  return var_2;
}

function getenemycount(var_0, var_1) {
  var_2 = 0;
  var_3 = getenemyteams(var_0);

  foreach(var_5 in var_3) {
    var_2 += getteamcount(var_5, istrue(var_1));
  }

  return var_2;
}

function isgameplayteam(var_0) {
  return isDefined(var_0) && scripts\engine\utility::array_contains(level.teamnamelist, var_0);
}

function getfaction(var_0) {
  return game[var_0];
}

function getteamname(var_0) {
  if(!isDefined(level.teamdata[var_0]["teamName"])) {
    level.teamdata[var_0]["teamName"] = tablelookupistring("mp/factionTable.csv", 0, game[var_0], 1);
  }

  return level.teamdata[var_0]["teamName"];
}

function getteamshortname(var_0) {
  if(!isDefined(level.teamdata[var_0]["shortName"])) {
    level.teamdata[var_0]["shortName"] = tablelookupistring("mp/factionTable.csv", 0, game[var_0], 2);
  }

  return level.teamdata[var_0]["shortName"];
}

function getteamicon(var_0) {
  if(!isDefined(level.teamdata[var_0]["teamIcon"])) {
    level.teamdata[var_0]["teamIcon"] = tablelookup("mp/factionTable.csv", 0, game[var_0], 5);
  }

  return level.teamdata[var_0]["teamIcon"];
}

function getteamheadicon(var_0) {
  if(!isDefined(level.teamdata[var_0]["headIcon"])) {
    level.teamdata[var_0]["headIcon"] = tablelookup("mp/factionTable.csv", 0, game[var_0], 7);
  }

  return level.teamdata[var_0]["headIcon"];
}

function getteamvoiceinfix(var_0) {
  if(!isDefined(level.teamdata[var_0]["soundInfix"])) {
    level.teamdata[var_0]["soundInfix"] = tablelookup("mp/factionTable.csv", 0, game[var_0], 8);
  }

  return level.teamdata[var_0]["soundInfix"];
}

function getcustomizationprefix(var_0) {
  if(!isDefined(level.teamdata[var_0]["customizationInfix"])) {
    level.teamdata[var_0]["customizationInfix"] = tablelookup("mp/factionTable.csv", 0, game[var_0], 10);
  }

  return level.teamdata[var_0]["customizationInfix"];
}

function rpgafterspawnfunc(var_0) {
  if(!isDefined(level.teamdata[var_0]["teamFaction"])) {
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
      default:
        var_1 = 11;
        break;
    }

    level.teamdata[var_1]["teamFaction"] = tablelookup("mp/mapInfo.csv", 0, scripts\cp_mp\utility\game_utility::getmapname(), var_1);

    if(level.teamdata[var_1]["teamFaction"] == "") {
      level.teamdata[var_1]["teamFaction"] = "USMC";
    }

    game[var_1] = level.teamdata[var_1]["teamFaction"];
  }

  return level.teamdata[var_1]["teamFaction"];
}

function getcustomgametypeteammax() {
  var_0 = scripts\mp\utility\game::getgametype();
  return getdvarint("scr_" + var_0 + "_teamcount", -1);
}

function ref_13A9F() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("team_utility", "getFriendlyPlayers", &getfriendlyplayers);
  scripts\cp_mp\utility\script_utility::registersharedfunc("team_utility", "getEnemyPlayers", &getenemyplayers);
}