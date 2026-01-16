/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\arena.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\gamestate;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\system_shared;
#include scripts\mp_common\gametypes\match;

#namespace arena;

autoexec __init__system__() {
  system::register(#"arena", &__init__, undefined, undefined);
}

__init__() {
  callback::on_connect(&on_connect);
  callback::on_disconnect(&on_disconnect);

  if(gamemodeisarena()) {
    callback::on_game_playing(&on_game_playing);
    level.var_a962eeb6 = &function_51203700;
  }
}

on_connect() {
  if(isDefined(self.pers[#"arenainit"]) && self.pers[#"arenainit"] == 1) {
    return;
  }

  draftenabled = getgametypesetting(#"pregamedraftenabled") == 1;
  voteenabled = getgametypesetting(#"pregameitemvoteenabled") == 1;

  if(!draftenabled && !voteenabled) {
    self arenabeginmatch();

    if(function_945560bf() == 1) {
      self.pers[#"hash_1b5251cc167039c8"] = self function_a200171d();
    }
  }

  self.pers[#"arenainit"] = 1;
}

function_b856a952(team) {
  if(getdvarint(#"hash_6eb6c222bc98b01", 0)) {
    penalty = function_377f07c2();

    for(index = 0; index < level.players.size; index++) {
      player = level.players[index];

      if(isDefined(player.team) && player.team == team && !isDefined(player.pers[#"hash_6dbbb195b62e0dd3"])) {
        if(isDefined(player.pers[#"arenainit"]) && player.pers[#"arenainit"] == 1) {
          if(isDefined(player.pers[#"hash_1b5251cc167039c8"])) {
            player function_ca53535e(penalty);
            player function_46445a75(player.pers[#"hash_1b5251cc167039c8"]);
            player.pers[#"hash_6dbbb195b62e0dd3"] = 1;
          }
        }
      }
    }
  }
}

on_disconnect() {
  if(isDefined(self) && isDefined(self.team) && isDefined(level.playercount) && isDefined(level.playercount[self.team])) {
    if(!gamestate::is_game_over() && level.playercount[self.team] <= function_7a0dc792()) {
      function_b856a952(self.team);
    }
  }
}

update_arena_challenge_seasons() {
  eventstate = "";
  eventtype = function_945560bf();

  switch (eventtype) {
    case 0:
      eventstate = #"rankedplaystats";
      break;
    case 1:
      eventstate = #"leagueplaystats";
      break;
    case 4:
      eventstate = #"hash_4986c748eb81d3c5";
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

match_end() {
  for(index = 0; index < level.players.size; index++) {
    player = level.players[index];

    if(isDefined(player.pers[#"arenainit"]) && player.pers[#"arenainit"] == 1) {
      if(match::get_flag("tie")) {
        player arenaendmatch(0);
      } else if(match::function_a2b53e17(player)) {
        player arenaendmatch(1);
      } else {
        player arenaendmatch(-1);
      }

      if(isDefined(player.pers[#"hash_1b5251cc167039c8"])) {
        player function_46445a75(player.pers[#"hash_1b5251cc167039c8"]);
      }
    }
  }

  if(match::get_flag("tie") || !isDefined(game.outcome.team)) {
    function_a357a2b8(0);
    return;
  }

  if(game.outcome.team == #"allies") {
    function_a357a2b8(1);
    return;
  }

  function_a357a2b8(-1);
}

function_51203700() {
  return false;
}

on_game_playing() {
  function_e938380b();
}