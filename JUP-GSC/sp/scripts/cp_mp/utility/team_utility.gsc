/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp_mp\utility\team_utility.gsc
*****************************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#namespace team_utility;

function function_a92ed2f4c44e5ffa() {
  if(issharedfuncdefined("team_utility", "init")) {
    [[getsharedfunc("team_utility", "init")]]();
  }
}

function getfriendlyplayers(testteam, aliveonly) {
  if(issharedfuncdefined("team_utility", "getFriendlyPlayers")) {
    return [[getsharedfunc("team_utility", "getFriendlyPlayers")]](testteam, aliveonly);
  }

  return [];
}

function getenemyplayers(testteam, aliveonly) {
  if(issharedfuncdefined("team_utility", "getEnemyPlayers")) {
    return [[getsharedfunc("team_utility", "getEnemyPlayers")]](testteam, aliveonly);
  }

  return [];
}