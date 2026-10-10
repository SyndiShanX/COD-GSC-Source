/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gamestaterestore.gsc
***********************************************/

#using script_548072087c9fd504;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\codcasterclientmatchdata;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#namespace gamestaterestore;

function setupcallbacks() {
  println("<dev string:x1c>");

  if(getdvarint(@ "hash_7dfc9d99d9c1ff2f", 0) == 0) {
    return;
  }

  println("<dev string:x38>");

  if(isDefined(game["gameStateRestore"]) && istrue(game["gameStateRestore"].enabled)) {
    println("<dev string:x5b>");

    if(isDefined(level.onplayerconnectcallbacks)) {
      level.onplayerconnectcallbacks[level.onplayerconnectcallbacks.size] = &function_e366f768381eb363;
      return;
    }

    level.onplayerconnectcallbacks[0] = &function_e366f768381eb363;
  }
}

function function_e366f768381eb363() {
  if(getdvarint(@ "hash_7dfc9d99d9c1ff2f", 0) == 0) {
    return;
  }

  println("<dev string:x80>");

  if(game["gameStateRestore"].enabled) {
    thread restorestate(self);
  }
}

function restorestate(player) {
  if(getdvarint(@ "hash_7dfc9d99d9c1ff2f", 0) == 0) {
    return;
  }

  self waittill("giveLoadout");
  println("<dev string:x96>");
  gamestatedata = game["gameStateRestore"];

  foreach(playerdata in gamestatedata.players) {
    if(playerdata.identifier != self.name) {
      continue;
    }

    function_bc22a4311e741bb3(self, playerdata);
    function_a5d40ec6023315a0(self.name);
    break;
  }
}

function function_a5d40ec6023315a0(playername) {
  if(getdvarint(@ "hash_7dfc9d99d9c1ff2f", 0) == 0) {
    return;
  }

  println("<dev string:xad>");

  for(i = 0; i < game["gameStateRestore"].players.size; i++) {
    if(game["gameStateRestore"].players[i].identifier == playername) {
      game["gameStateRestore"].players[i] = undefined;
      break;
    }
  }

  if(game["gameStateRestore"].players.size <= 0) {
    game["gameStateRestore"].enabled = 0;
  }
}

function function_3433ff82f51bce6d() {
  if(getdvarint(@ "hash_7dfc9d99d9c1ff2f", 0) == 0) {
    return;
  }

  println("<dev string:xc9>");
  game["gameStateRestore"] = namespace_f5675568ccc8acc6::function_8c8838610394416a();
  game["gameStateRestoreAlreadyUsed"] = 1;
}

function getlifeid(playername) {
  if(getdvarint(@ "hash_7dfc9d99d9c1ff2f", 0) == 0) {
    return 0;
  }

  gamestatedata = game["gameStateRestore"];

  foreach(playerdata in gamestatedata.players) {
    if(playerdata.identifier != playername) {
      continue;
    }

    return playerdata.deaths;
  }

  return 0;
}

function restoreteamscores() {
  if(getdvarint(@ "hash_7dfc9d99d9c1ff2f", 0) == 0) {
    return;
  }

  if(!isDefined(game["gameStateRestore"]) || !game["gameStateRestore"].enabled) {
    return;
  }

  println("<dev string:xe3>");
  gamestate = game["gameStateRestore"];
  function_cc67f138614157c4(gamestate);
  game["roundsPlayed"] = gamestate.team1score + gamestate.team2score;

  if(game["roundsPlayed"] / level.roundswitch % 2 == 1) {
    game["switchedsides"] = 1;
  }

  function_9f5611f9df9b6bee(gamestate);
  println("<dev string:x100>");
  level thread scripts\mp\gamelogic::callbackserverstart();
}

function function_cc67f138614157c4(gamestate) {
  game["roundsWon"]["allies"] = gamestate.team1score;
  game["roundsWon"]["axis"] = gamestate.team2score;
  game["teamScores"]["allies"] = gamestate.team1score;
  game["teamScores"]["axis"] = gamestate.team2score;
  setteamscore("allies", gamestate.team1score);
  setteamscore("axis", gamestate.team2score);
}

function function_9f5611f9df9b6bee(gamestate) {
  attacking_team = game["attackers"];
  defending_team = game["defenders"];

  if(getbasegametype() == "control") {
    game["segment_captures"][attacking_team] = gamestate.var_bbb396fc2f580332;
    game["segment_captures"][defending_team] = gamestate.var_6eb8962f9ca9f5c1;
  }

  game["match_kills"][attacking_team] = gamestate.team1kills;
  game["match_kills"][defending_team] = gamestate.team2kills;
}

function function_bc22a4311e741bb3(player, playerdata) {
  if(getdvarint(@ "hash_7dfc9d99d9c1ff2f", 0) == 0) {
    return;
  }

  if(!isDefined(game["gameStateRestore"]) || !game["gameStateRestore"].enabled) {
    return;
  }

  println("<dev string:x11e>");
  player.kills = playerdata.kills;
  player initpersstat("kills");
  player incpersstat("kills", player.kills);
  player.deaths = playerdata.deaths;
  player initpersstat("deaths");
  player incpersstat("deaths", player.deaths);
  restorekillstreaks(player, playerdata);
  function_eb800ab2be810565(player, playerdata);
}

function restorekillstreaks(player, playerdata) {
  if(getdvarint(@ "hash_7dfc9d99d9c1ff2f", 0) == 0) {
    return;
  }

  println("<dev string:x13c>" + player.name);

  if(playerdata.killstreaksprogress < 0) {
    playerdata.killstreaksprogress = 0;
  }

  var_4591b3666013f31 = playerdata.killstreaksprogress;
  player.pers["cur_kill_streak"] = var_4591b3666013f31;
  player initpersstat("streakPoints");
  player incpersstat("streakPoints", var_4591b3666013f31);
  player function_7ee466e81b1afc12(6, var_4591b3666013f31);
  player function_7ee466e81b1afc12(7, var_4591b3666013f31);
  player.lifeid = player.deaths;
  player.pers["deaths"] = player.lifeid;
  player givestreakpoints(#"kill", var_4591b3666013f31);

  for(slotnumber = 1; slotnumber <= 3; slotnumber++) {
    streak = playerdata.killstreaks[slotnumber - 1];
    streakused = streak.used;
    streakearned = streak.earned;
    streakinslot = player getkillstreakinslot(slotnumber);

    if(isDefined(streakinslot) && isDefined(streakinslot.streakname)) {
      streakcost = player calcstreakcost(streakinslot.streakname);

      if(streakused) {
        streakinslot.available = -1;
      } else if(streakearned || streakcost <= var_4591b3666013f31) {
        streakinslot.available = 1;
      }

      player function_8d43ce79a3f2d876(slotnumber, streakinslot.available);
    }
  }
}

function function_d0e691079192c053(player, playerdata) {
  var_f99ae5d85fb5351b = player.super.staticdata.pointsneeded;
  percentageprogress = playerdata.fieldupgrade.progress;
  var_57304761143d03ed = percentageprogress * var_f99ae5d85fb5351b / 100;
  return var_57304761143d03ed;
}

function function_eb800ab2be810565(player, playerdata) {
  if(getdvarint(@ "hash_7dfc9d99d9c1ff2f", 0) == 0) {
    return;
  }

  if(playerdata.fieldupgrade.progress) {
    var_319b074b9c1a6807 = function_d0e691079192c053(player, playerdata);
    player[[getsharedfunc("supers", "giveSuperPoints")]](var_319b074b9c1a6807);
  }
}