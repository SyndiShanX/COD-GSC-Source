/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_3bdadfff7554ceba.gsc
*************************************************/

#using scripts\engine\utility;
#using scripts\mp\bots\bots;
#using scripts\mp\utility\game;
#namespace namespace_438781effce634d4;

function init() {
  if(getdvarint(@ "hash_1a92c8ba1b57a968", 0) == 0) {
    return;
  }

  setdevdvar(@ "hash_81644941d60ec323", 1);
  setdevdvar(@ "hash_ac6f58a6e20ed4c2", 1);

  level thread function_2366683817cdb090();
}

function function_2366683817cdb090() {
  if(game["roundsPlayed"] > 0) {
    return;
  }

  if(level.teambased) {
    while(!scripts\mp\utility\game::gamehasstarted()) {
      wait 0.05;
    }
  } else {
    while(!istrue(level.prematchstarted)) {
      waitframe();
    }
  }

  if(getdvarint(@ "hash_1a92c8ba1b57a968", 0) == 0) {
    return;
  }

  while(!istrue(game["gamestarted"])) {
    waitframe();
  }

  if(isDefined(game["roundsPlayed"]) && game["roundsPlayed"] > 0) {
    return;
  }

  if(!isDefined(level.var_69def5c06e03559)) {
    level.var_69def5c06e03559 = level.teamnamelist;
  }

  if(!isDefined(level.var_737572a27a1ca724)) {
    if(istrue(level.teambased)) {
      if(isDefined(level.maxteamsize) && level.maxteamsize != 0) {
        level.var_737572a27a1ca724 = level.maxteamsize;
      } else {
        level.var_737572a27a1ca724 = 6;
      }
    } else {
      level.var_737572a27a1ca724 = int(7) / 2;
    }
  }

  while(istrue(level.var_ce2396e9ae4bc1a0)) {
    waitframe();
  }

  if(!level.onlinegame) {
    while(!isDefined(level.player)) {
      waitframe();
    }

    if(istrue(level.teambased)) {
      level.var_69def5c06e03559 = scripts\engine\utility::array_remove(level.var_69def5c06e03559, level.player.pers["<dev string:x1c>"]);
      level.var_69def5c06e03559 = scripts\engine\utility::array_combine([level.player.pers["<dev string:x1c>"]], level.var_69def5c06e03559);
    } else {
      level.var_69def5c06e03559 = ["<dev string:x21>", "<dev string:x28>"];
    }
  }

  level thread outline_players();

  foreach(entry in level.var_69def5c06e03559) {
    if(isDefined(level.player) && scripts\engine\utility::is_equal(level.player.pers["team"], entry)) {
      num_to_spawn = level.var_737572a27a1ca724 - 1;

      if(issplitscreen()) {
        num_to_spawn = level.var_737572a27a1ca724 - 1;
      }
    } else {
      num_to_spawn = level.var_737572a27a1ca724;
    }

    level thread scripts\mp\bots\bots::spawn_bots(num_to_spawn, entry, undefined, undefined, undefined, "recruit");
  }
}

function outline_players() {
  if(!getdvarint(@ "hash_e40a51d94d1570ea", 0)) {
    return;
  }

  while(true) {
    if(isDefined(level.players)) {
      foreach(player in level.players) {
        if(isDefined(level.player) && scripts\engine\utility::is_equal(player.pers["team"], level.player.pers["team"])) {
          player hudoutlineenable("outline_nodepth_green");
          continue;
        }

        player hudoutlineenable("outline_nodepth_red");
      }
    }

    wait 0.25;
  }
}

function pause() {
  level.var_ce2396e9ae4bc1a0 = 1;
}

function run() {
  level.var_ce2396e9ae4bc1a0 = 0;
}

function function_6cce72ce8bb6af87(teams) {
  level.var_69def5c06e03559 = teams;
}

function function_4a18dd73a966821e(count) {
  level.var_737572a27a1ca724 = count;
}

function modegetforceoperatorcustomization(player, operatorref, operatorskinref) {
  return ["jup_mp_delta", 0];
}