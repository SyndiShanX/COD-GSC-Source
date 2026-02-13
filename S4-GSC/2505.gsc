/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2505.gsc
*************************************************/

_id_EF5B() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("team_utility", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("team_utility", "init")]]();
  }
}

_id_6A59(var_0, var_1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("team_utility", "getFriendlyPlayers")) {
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("team_utility", "getFriendlyPlayers")]](var_0, var_1);
  }

  return [];
}

_id_69FD(var_0, var_1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("team_utility", "getEnemyPlayers")) {
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("team_utility", "getEnemyPlayers")]](var_0, var_1);
  }

  return [];
}