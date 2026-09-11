/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\teams.gsc
***********************************************/

function getteamdata(var0, var1) {
  return level.teamdata[var0][var1];
}

function setteamdata(var0, var1, var2) {
  level.teamdata[var0][var1] = var2;
}

function modifyteamdata(var0, var1, var2) {
  level.teamdata[var0][var1] += var2;
}

function addplayertoteam(var0, var1, var2) {
  level.teamdata[var1]["teamCount"]++;
  level.teamdata[var1]["players"] = scripts\engine\utility::array_add(level.teamdata[var1]["players"], var0);

  if(var2) {
    addtoteamlives(var0, var1, 0, "addPlayerToTeam");
    return;
  }
}

function removeplayerfromteam(var0, var1) {
  level.teamdata[var1]["teamCount"]--;
  level.teamdata[var1]["players"] = scripts\engine\utility::array_remove(level.teamdata[var1]["players"], var0);
}

function addtoteamlives(var0, var1, var2, var3) {
  level.teamdata[var1]["aliveCount"]++;
  level.teamdata[var1]["alivePlayers"] = scripts\engine\utility::array_add(level.teamdata[var1]["alivePlayers"], var0);

  if(level.multiteambased) {
    level.teamdata[var1]["deathEvent"] = 0;
  }

  ref_140c9("add", var1, var0);

  if(isDefined(level.ref_11c65)) {
    [[level.ref_11c65]](var0, var1, var3);
  }

  if(scripts\mp\utility\game::lpcfeaturegated()) {
    return;
  }

  if(istrue(var2) && isgameplayteam(var1) && !scripts\cp_mp\utility\game_utility::isrealismenabled()) {
    foreach(var0 in level.teamdata[var1]["players"]) {
      var0 playlocalsound("mp_bodycount_tick_positive");
    }

    var6 = getenemyplayers(var1);

    foreach(var0 in var6) {
      var0 playlocalsound("mp_bodycount_tick_negative");
    }

    return;
  }
}

function removefromteamlives(var0, var1, var2, var3) {
  level.teamdata[var1]["aliveCount"]--;
  level.teamdata[var1]["alivePlayers"] = scripts\engine\utility::array_remove(level.teamdata[var1]["alivePlayers"], var0);
  ref_140c9("remove", var1, var0);

  if(isDefined(level.ref_11c7e)) {
    [[level.ref_11c7e]](var0, var1, var3);
  }

  if(istrue(var2) && isgameplayteam(var1) && !scripts\cp_mp\utility\game_utility::isrealismenabled()) {
    var4 = "mp_bodycount_tick_negative";
    var5 = "mp_bodycount_tick_positive";

    if(level.teamdata[var1]["aliveCount"] == 1) {
      var4 = "mp_bodycount_tick_negative_final";
      var5 = "mp_bodycount_tick_positive_final";
    }

    var6 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic(var1, var0.squadindex);

    foreach(var0 in var6) {
      var0 playlocalsound(var4);
    }

    if(!scripts\mp\utility\game::lpcfeaturegated()) {
      var9 = getenemyplayers(var1);

      foreach(var0 in var9) {
        var0 playlocalsound(var5);
      }

      return;
    }

    return;
  }
}

function ref_140c9(var0, var1, var2) {
  var3 = getdvarint("scr_alive_count_fix", 1);
  var4 = 0;
  var5 = 0;

  if(var0 == "disconnect") {
    var4 = scripts\engine\utility::array_contains(level.teamdata[var1]["alivePlayers"], var2);

    if(var4 && var3) {
      var2 scripts\mp\playerlogic::removefromalivecount(1, "validateAliveCount");
    }
  } else if(var0 == "add") {
    var6 = scripts\engine\utility::array_remove_duplicates(level.teamdata[var1]["alivePlayers"]);

    if(var6.size < level.teamdata[var1]["alivePlayers"].size) {
      var5 = 1;
      var0 += " duplicate";
    }
  }

  var7 = level.teamdata[var1]["alivePlayers"].size;
  var8 = level.teamdata[var1]["aliveCount"];

  if(var7 != var8 || var4 || var5) {
    var9 = "";

    if(var5) {
      var9 = "WARNING: Duplicate players in alive player array";
    } else if(var4) {
      var9 = "WARNING: player in alive array after disconnect!";
    } else {
      var9 = "WARNING: alivePlayers and aliveCount are out of sync!";
    }

    getentitylessscriptablearray("dlog_event_alive_count_mismatch", ["alive_players", var7, "alive_count", var8, "event", var0, "team", var1, "player_xuid", var2 getxuid(), "player_name", var2.name]);
    scripts\mp\utility\script::laststand_dogtags(var9);

    if(var3) {
      level.teamdata[var1]["alivePlayers"] = scripts\engine\utility::array_remove_duplicates(level.teamdata[var1]["alivePlayers"]);
      level.teamdata[var1]["aliveCount"] = level.teamdata[var1]["alivePlayers"].size;
      [[level.updategameevents]]();
      return;
    }

    return;
  }
}

function getteamcount(var0, var1) {
  if(istrue(var1)) {
    return level.teamdata[var0]["alivePlayers"].size;
  }

  return level.teamdata[var0]["players"].size;
}

function resetchallengetimer() {
  var0 = 0;

  foreach(var2 in level.teamnamelist) {
    var3 = getteamcount(var2, 1);

    if(var3 > 0) {
      var0++;
    }
  }

  return var0;
}

function getenemyteams(var0) {
  var1 = level.teamnamelist;
  var1 = scripts\engine\utility::array_remove(var1, var0);

  if(isDefined(level.ref_14687) || scripts\mp\utility\game::deposit_from_compromised_convoy_delayed_failsafe()) {
    var1 = scripts\engine\utility::array_remove(var1, "team_two_hundred");
  }

  return var1;
}

function getfriendlyplayers(var0, var1) {
  var2 = [];
  jumpiffalse(istrue(var1)) LOC_0000005e;

  foreach(var4 in level.teamdata[var0]["alivePlayers"]) {
    if(isDefined(var4) && isalive(var4) && !isDefined(var4.fauxdead)) {
      var2 = var4;
    }
  }

  goto LOC_00000093;
}

function getenemyplayers(var0, var1) {
  var2 = [];
  var3 = getenemyteams(var0);

  foreach(var5 in var3) {
    if(istrue(var1)) {
      foreach(var7 in level.teamdata[var5]["alivePlayers"]) {
        if(isDefined(var7) && isalive(var7) && !isDefined(var7.fauxdead)) {
          var2 = var7;
        }
      }

      continue;
    }

    foreach(var7 in level.teamdata[var5]["players"]) {
      var2 = var7;
    }
  }

  return var2;
}

function getenemycount(var0, var1) {
  var2 = 0;
  var3 = getenemyteams(var0);

  foreach(var5 in var3) {
    var2 += getteamcount(var5, istrue(var1));
  }

  return var2;
}

function isgameplayteam(var0) {
  return isDefined(var0) && scripts\engine\utility::array_contains(level.teamnamelist, var0);
}

function getfaction(var0) {
  return game[var0];
}

function getteamname(var0) {
  if(!isDefined(level.teamdata[var0]["teamName"])) {
    level.teamdata[var0]["teamName"] = tablelookupistring("mp/factionTable.csv", 0, game[var0], 1);
  }

  return level.teamdata[var0]["teamName"];
}

function getteamshortname(var0) {
  if(!isDefined(level.teamdata[var0]["shortName"])) {
    level.teamdata[var0]["shortName"] = tablelookupistring("mp/factionTable.csv", 0, game[var0], 2);
  }

  return level.teamdata[var0]["shortName"];
}

function getteamicon(var0) {
  if(!isDefined(level.teamdata[var0]["teamIcon"])) {
    level.teamdata[var0]["teamIcon"] = tablelookup("mp/factionTable.csv", 0, game[var0], 5);
  }

  return level.teamdata[var0]["teamIcon"];
}

function getteamheadicon(var0) {
  if(!isDefined(level.teamdata[var0]["headIcon"])) {
    level.teamdata[var0]["headIcon"] = tablelookup("mp/factionTable.csv", 0, game[var0], 7);
  }

  return level.teamdata[var0]["headIcon"];
}

function getteamvoiceinfix(var0) {
  if(!isDefined(level.teamdata[var0]["soundInfix"])) {
    level.teamdata[var0]["soundInfix"] = tablelookup("mp/factionTable.csv", 0, game[var0], 8);
  }

  return level.teamdata[var0]["soundInfix"];
}

function getcustomizationprefix(var0) {
  if(!isDefined(level.teamdata[var0]["customizationInfix"])) {
    level.teamdata[var0]["customizationInfix"] = tablelookup("mp/factionTable.csv", 0, game[var0], 10);
  }

  return level.teamdata[var0]["customizationInfix"];
}

function rpgafterspawnfunc(var0) {
  if(!isDefined(level.teamdata[var0]["teamFaction"])) {
    switch (var0) {
      case "axis":
        var1 = 10;
        break;
      case "allies":
        var1 = 11;
        break;
      case "team_three":
        var1 = 12;
        break;
      case "team_four":
        var1 = 13;
        break;
      case "team_five":
        var1 = 14;
        break;
      case "team_six":
        var1 = 15;
        break;
      default:
        var1 = 11;
        break;
    }

    level.teamdata[var1]["teamFaction"] = tablelookup("mp/mapInfo.csv", 0, scripts\cp_mp\utility\game_utility::getmapname(), var1);

    if(level.teamdata[var1]["teamFaction"] == "") {
      level.teamdata[var1]["teamFaction"] = "USMC";
    }

    game[var1] = level.teamdata[var1]["teamFaction"];
  }

  return level.teamdata[var1]["teamFaction"];
}

function getcustomgametypeteammax() {
  var0 = scripts\mp\utility\game::getgametype();
  return getdvarint("scr_" + var0 + "_teamcount", -1);
}

function ref_13a9f() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("team_utility", "getFriendlyPlayers", &getfriendlyplayers);
  scripts\cp_mp\utility\script_utility::registersharedfunc("team_utility", "getEnemyPlayers", &getenemyplayers);
}