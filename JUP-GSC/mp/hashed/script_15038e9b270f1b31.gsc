/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_15038e9b270f1b31.gsc
*************************************************/

#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_gametypes;
#namespace namespace_2c3a8b16eb34bd6;

function init() {
  if(getdvarint(@ "hash_a6b52f16f3853a9a", 0) == 0) {
    return;
  }

  level.var_bf269015710de2dd = 1;
  level.var_8ed22c88753f7445 = getdvarint(@ "hash_2401fbc45a4682a5", 100);
  level.var_a4dab5000eca4682 = getdvarint(@ "hash_3fd4f18a01c87ce2", 10);
  level.var_be6c4a2a3ea18574 = 0;
  level.var_373b806b04381d6f = 0;
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("updatePlayerAndTeamCountUI", &function_806ad317de2af4f3);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("onPlayerKilled", &function_6436c089f777048b);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("onPlayerConnect", &function_f5fd598a80445d04);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("onPlayerDisconnect", &function_98b1fbbdd7377898);
  level thread watchprematchdone();
}

function function_806ad317de2af4f3(aliveplayercount, activeteams) {
  totalplayers = level.players.size;
  aliveplayercount = 0;
  var_35068b9b9dc4c73f = 0;
  activeteams = [];

  for(i = 0; i < totalplayers; i++) {
    player = level.players[i];

    if(player scripts\mp\gametypes\br::function_7dbb8165d792b06c()) {
      continue;
    }

    if(!istrue(player.br_iseliminated)) {
      if(istrue(player.iszombie)) {
        var_35068b9b9dc4c73f++;
      } else {
        aliveplayercount++;
        activeteams[player.team] = 1;
      }
    }

    if(!isDefined(activeteams[player.team])) {
      result = scripts\mp\gametypes\br_gametypes::runbrgametypefunc("isTeamEliminated", player.team);

      if(isDefined(result)) {
        if(!result) {
          activeteams[player.team] = 1;
        }
      }
    }
  }

  foreach(uibot in scripts\mp\gametypes\br::function_749723c2a45a0233()) {
    aliveplayercount++;
    activeteams[uibot.team] = 1;
  }

  if(scripts\mp\flags::gameflag("prematch_done")) {
    activeteamcount = int(activeteams.size + level.var_8ed22c88753f7445 / scripts\cp_mp\utility\game_utility::function_4fb37368ae3585bb());
    aliveplayercount = int(aliveplayercount + level.var_8ed22c88753f7445);
  } else {
    activeteamcount = int(activeteams.size + level.var_be6c4a2a3ea18574 / scripts\cp_mp\utility\game_utility::function_4fb37368ae3585bb());
    aliveplayercount = int(aliveplayercount + level.var_be6c4a2a3ea18574);
  }

  level.var_373b806b04381d6f = activeteamcount;

  var_6837562bca96ad34 = int(pow(2, 8)) - 1;
  assert(var_35068b9b9dc4c73f <= var_6837562bca96ad34);
  assert(aliveplayercount <= var_6837562bca96ad34);
  assert(activeteams.size <= var_6837562bca96ad34);

  var_47bf15e70ee220a = (var_35068b9b9dc4c73f << 16) + (activeteamcount << 8) + aliveplayercount;
  setomnvar("ui_br_match_stats", var_47bf15e70ee220a);
}

function function_6436c089f777048b(deathdata) {
  if(scripts\mp\flags::gameflag("prematch_done")) {
    level thread function_479d3f9aaf4e3bf0();
  }
}

function function_f5fd598a80445d04(player) {
  var_92247b35cd23dbec = level.players.size - level.var_a4dab5000eca4682;

  if(var_92247b35cd23dbec > 0) {
    var_e4762082ef346678 = level.var_8ed22c88753f7445 / getdvarint(@ "party_maxplayers", 1);
  } else {
    var_e4762082ef346678 = 0;
  }

  if(var_e4762082ef346678 <= 0) {
    return;
  }

  totalplayers = level.players.size;
  var_f5439adc07558e92 = level.var_8ed22c88753f7445 + totalplayers;

  for(i = 0; i < var_e4762082ef346678; i++) {
    level.var_be6c4a2a3ea18574 = min(var_f5439adc07558e92, level.var_be6c4a2a3ea18574 + 1);
    scripts\mp\gametypes\br::updateplayerandteamcountui();

    if(level.var_8ed22c88753f7445 <= 0) {
      return;
    }
  }

  scripts\mp\gametypes\br::updateplayerandteamcountui();
}

function function_98b1fbbdd7377898(player) {
  if(scripts\mp\flags::gameflag("prematch_done")) {
    level thread function_479d3f9aaf4e3bf0();
    return;
  }

  level thread function_479d3f9aaf4e3bf0(1);
}

function function_397f011c8120ea71() {
  self setclientomnvar("ui_br_player_position", level.var_373b806b04381d6f + 1);
}

function watchprematchdone() {
  scripts\mp\gametypes\br::updateplayerandteamcountui();
  level waittill("prematch_over");
  level.var_e4762082ef346678 = undefined;
  level.var_be6c4a2a3ea18574 = undefined;
  var_43b93f9cb6d3a779 = level.players.size - level.var_a4dab5000eca4682;

  if(var_43b93f9cb6d3a779 > 0) {
    level.var_aefac0c879f41d97 = level.var_8ed22c88753f7445 / var_43b93f9cb6d3a779;
  } else {
    level.var_8ed22c88753f7445 = 0;
  }

  scripts\mp\gametypes\br::updateplayerandteamcountui();
}

function function_479d3f9aaf4e3bf0(bimmediate) {
  if(level.var_8ed22c88753f7445 <= 0) {
    return;
  }

  decrementcount = scripts\engine\utility::ter_op(scripts\mp\flags::gameflag("prematch_done"), level.var_aefac0c879f41d97, level.var_e4762082ef346678);

  if(!isDefined(decrementcount)) {
    return;
  }

  for(i = 0; i < decrementcount; i++) {
    if(!istrue(bimmediate)) {
      wait randomfloat(5);
    }

    level.var_8ed22c88753f7445 = max(0, level.var_8ed22c88753f7445 - 1);
    scripts\mp\gametypes\br::updateplayerandteamcountui();

    if(level.var_8ed22c88753f7445 <= 0) {
      return;
    }
  }
}

function getalivecount() {
  totalplayers = level.players.size;
  aliveplayercount = 0;

  for(i = 0; i < totalplayers; i++) {
    player = level.players[i];

    if(player scripts\mp\gametypes\br::function_7dbb8165d792b06c()) {
      continue;
    }

    if(!istrue(player.br_iseliminated)) {
      if(!istrue(player.iszombie)) {
        aliveplayercount++;
      }
    }
  }

  return aliveplayercount;
}