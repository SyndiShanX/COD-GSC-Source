/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: 58227.gsc
***********************************************/

function ref_13A9E() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("team_utility", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("team_utility", "init")]]();
    return;
  }
}

function getfriendlyplayers(var_0, var_1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("team_utility", "getFriendlyPlayers")) {
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("team_utility", "getFriendlyPlayers")]](var_0, var_1);
  }

  return [];
}

function getenemyplayers(var_0, var_1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("team_utility", "getEnemyPlayers")) {
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("team_utility", "getEnemyPlayers")]](var_0, var_1);
  }

  return [];
}