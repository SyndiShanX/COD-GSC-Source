/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\arena.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\gamestate_util;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\system_shared;
#using scripts\mp_common\gametypes\match;
#namespace arena;

function private autoexec __init__system__() {
  system::register(#"arena", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  callback::on_connecting(&on_connecting);
  callback::on_connect(&on_connect);
  callback::on_disconnect(&on_disconnect);

  if(gamemodeisarena()) {
    callback::on_game_playing(&on_game_playing);
    level.var_a962eeb6 = &function_51203700;
  }
}

function function_51203700() {
  return false;
}

function on_connecting() {
  if(getdvarint(#"hash_143d0e437ef89350", 0) == 0) {
    return;
  }

  if(!gamemodeisarena() || isDefined(self.pers[# "arenainit"]) && self.pers[# "arenainit"] == 1) {
    return;
  }

  if(level.var_ba92f0a8) {
    return;
  }

  self arenabeginmatch();

  if(function_945560bf() == 0) {
    self.pers[# "hash_1b5251cc167039c8"] = self function_a200171d();
  }

  self.pers[# "arenainit"] = 1;
}

function on_connect() {
  if(getdvarint(#"hash_143d0e437ef89350", 0) == 1) {
    return;
  }

  if(!gamemodeisarena() || isDefined(self.pers[# "arenainit"]) && self.pers[# "arenainit"] == 1) {
    return;
  }

  if(level.var_ba92f0a8) {
    return;
  }

  self arenabeginmatch();

  if(function_945560bf() == 0) {
    self.pers[# "hash_1b5251cc167039c8"] = self function_a200171d();
    uploadstats(self);
  }

  self.pers[# "arenainit"] = 1;
}

function on_game_playing() {
  if(gamemodeisarena()) {
    function_e938380b();

    if(gamemodeisarena() && isDefined(self.pers[# "arenainit"]) && self.pers[# "arenainit"] == 1) {
      penalty = function_377f07c2();

      for(index = 0; index < level.players.size; index++) {
        player = level.players[index];

        if(isDefined(player) && isDefined(player.team) && isDefined(level.playercount) && isDefined(level.playercount[player.team])) {
          if(!gamestate::is_game_over() && level.playercount[player.team] <= function_7a0dc792()) {
            if(!isDefined(player.pers[# "hash_6dbbb195b62e0dd3"])) {
              if(isDefined(player.pers[# "arenainit"]) && player.pers[# "arenainit"] == 1) {
                if(isDefined(player.pers[# "hash_1b5251cc167039c8"])) {
                  player function_ca53535e(penalty);
                  player.pers[# "hash_6dbbb195b62e0dd3"] = 1;
                }
              }
            }
          }
        }
      }
    }
  }
}

function function_b856a952(team) {
  if(gamemodeisarena() && getdvarint(#"hash_6eb6c222bc98b01", 0)) {
    penalty = function_377f07c2();

    for(index = 0; index < level.players.size; index++) {
      player = level.players[index];

      if(isDefined(player.team) && player.team == team && !isDefined(player.pers[# "hash_6dbbb195b62e0dd3"])) {
        if(isDefined(player.pers[# "arenainit"]) && player.pers[# "arenainit"] == 1) {
          if(isDefined(player.pers[# "hash_1b5251cc167039c8"])) {
            player function_ca53535e(penalty);
            player.pers[# "hash_6dbbb195b62e0dd3"] = 1;
          }
        }
      }
    }
  }
}

function on_disconnect() {
  if(gamemodeisarena() && isDefined(self.pers[# "arenainit"]) && self.pers[# "arenainit"] == 1) {
    if(isDefined(self) && isDefined(self.team) && isDefined(level.playercount) && isDefined(level.playercount[self.team])) {
      if(!gamestate::is_game_over() && level.playercount[self.team] <= function_7a0dc792()) {
        function_b856a952(self.team);
      }
    }
  }
}

function function_77151fd1() {
  if(gamemodeisarena() && getdvarint(#"hash_6eb6c222bc98b01", 0)) {
    penalty = function_377f07c2();

    for(index = 0; index < level.players.size; index++) {
      player = level.players[index];

      if(!isDefined(player.pers[# "hash_6dbbb195b62e0dd3"])) {
        if(isDefined(player.pers[# "arenainit"]) && player.pers[# "arenainit"] == 1) {
          if(isDefined(player.pers[# "hash_1b5251cc167039c8"])) {
            player function_ca53535e(penalty);
            player.pers[# "hash_6dbbb195b62e0dd3"] = 1;
          }
        }
      }
    }
  }
}

function cancel_match() {
  if(gamemodeisarena()) {
    for(index = 0; index < level.players.size; index++) {
      player = level.players[index];

      if(isDefined(player.pers[# "arenainit"]) && player.pers[# "arenainit"] == 1) {
        player function_4403ddff();
        uploadstats(player);
      }
    }
  }
}

function match_end() {
  if(gamemodeisarena()) {
    function_77151fd1();

    for(index = 0; index < level.players.size; index++) {
      player = level.players[index];

      if(isDefined(player.pers[# "arenainit"]) && player.pers[# "arenainit"] == 1) {
        matchresult = undefined;
        var_74386ffc = -1;

        if(match::get_flag("tie")) {
          matchresult = 1;
          player arenaendmatch(0, level.var_ba92f0a8);
        } else if(match::function_a2b53e17(player)) {
          matchresult = 2;
          player arenaendmatch(1, level.var_ba92f0a8);
        } else {
          matchresult = 0;
          player arenaendmatch(-1, level.var_ba92f0a8);
        }

        if(getdvarint(#"hash_5a49cb3f6a18c3a6", 0) && player function_4ded3935()) {
          var_876fccfb = player stats::get_stat(#"arenabest", #"performancevalue");
          var_74386ffc = player function_cdaaa372(var_876fccfb);

          if(var_74386ffc == -1) {
            var_23491496 = getscriptbundle(#"arena_league_play_skill_divisions_default");

            if(isDefined(var_876fccfb) && isDefined(var_23491496)) {
              foreach(tierindex, var_b5ddbfd7 in var_23491496.skilldivisiontierlist) {
                if(var_876fccfb < var_b5ddbfd7.var_7197b13a) {
                  var_74386ffc = tierindex;
                  break;
                }
              }
            }
          }
        }

        if(isDefined(player.pers[# "hash_1b5251cc167039c8"])) {
          if(isDefined(matchresult)) {
            if(var_74386ffc != -1) {
              player function_cce105c8(#"hash_4e13b2889185a48d", 1, player.pers[# "hash_1b5251cc167039c8"], 2, matchresult, 3, var_74386ffc, 4, level.var_ba92f0a8, 5, getdvarint(#"hash_6e07431d7a79d00f", 0));
              continue;
            }

            player function_cce105c8(#"hash_4e13b2889185a48d", 1, player.pers[# "hash_1b5251cc167039c8"], 2, matchresult, 4, level.var_ba92f0a8, 5, getdvarint(#"hash_6e07431d7a79d00f", 0));
          }
        }
      }
    }

    function_42e2cd11(level.var_ba92f0a8);
  }
}

function update_arena_challenge_seasons() {
  if(!gamemodeisarena()) {
    return;
  }

  eventstate = "";
  eventtype = function_945560bf();

  switch (eventtype) {
    case 1:
      eventstate = # "rankedplaystats";
      break;
    case 0:
      eventstate = # "leagueplaystats";
      break;
    case 4:
      eventstate = # "hash_4986c748eb81d3c5";
      break;
    default:
      return;
  }

  perseasonwins = self stats::get_stat(#"arenaperseasonstats", eventstate, #"matchesstats", #"wins");

  if(perseasonwins >= getdvarint(#"arena_seasonvetchallengewins", 0)) {
    arenaslot = arenagetslot();
    currentseason = self stats::get_stat(#"arenastats", arenaslot, #"season");
    seasonvetchallengearraycount = self getdstatarraycount("arenaChallengeSeasons");

    for(i = 0; i < seasonvetchallengearraycount; i++) {
      challengeseason = self stats::get_stat(#"arenachallengeseasons", i);

      if(challengeseason == currentseason) {
        return;
      }

      if(challengeseason == 0) {
        self stats::set_stat(#"arenachallengeseasons", i, currentseason);
        break;
      }
    }
  }
}