/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\team_utility.gsc
**************************************************/

_id_A92ED2F4C44E5FFA() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("team_utility", "init"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("team_utility", "init")]]();
}

getfriendlyplayers(_id_68BB1F110EC06A58, _id_7102F45D5F0B5834) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("team_utility", "getFriendlyPlayers"))
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("team_utility", "getFriendlyPlayers")]](_id_68BB1F110EC06A58, _id_7102F45D5F0B5834);

  return [];
}

getenemyplayers(_id_68BB1F110EC06A58, _id_7102F45D5F0B5834) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("team_utility", "getEnemyPlayers"))
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("team_utility", "getEnemyPlayers")]](_id_68BB1F110EC06A58, _id_7102F45D5F0B5834);

  return [];
}