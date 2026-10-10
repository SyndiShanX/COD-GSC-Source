/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\team_gun.gsc
************************************************/

#using scripts\mp\utility\stats;
#namespace team_gun;

function function_c1cddd7ae3bc2698() {
  return getDvar(@ "ui_gametype", "gun") == "team_gun";
}

function function_aa7d3b7589a7323e() {
  player = self;

  if(isbot(player)) {
    team = player.bot_team;
  } else {
    team = player.pers["team"];
  }

  player.gungamegunindex = function_1b6cc03649ea5017(team);

  if(player.gungamegunindex == 0) {
    player.gungameprevgunindex = 0;
    return;
  }

  player.gungameprevgunindex = player.gungamegunindex - 1;
}

function function_1b6cc03649ea5017(team) {
  if(!isDefined(level.var_b0ad9e7ef6c53ce7) || !isDefined(level.var_b0ad9e7ef6c53ce7[team])) {
    return 0;
  }

  return level.var_b0ad9e7ef6c53ce7[team];
}