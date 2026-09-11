/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58227.gsc
***********************************************/

function ref_13a9e() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("team_utility", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("team_utility", "init")]]();
    return;
  }
}

function getfriendlyplayers(var0, var1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("team_utility", "getFriendlyPlayers")) {
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("team_utility", "getFriendlyPlayers")]](var0, var1);
  }

  return [];
}

function getenemyplayers(var0, var1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("team_utility", "getEnemyPlayers")) {
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("team_utility", "getEnemyPlayers")]](var0, var1);
  }

  return [];
}