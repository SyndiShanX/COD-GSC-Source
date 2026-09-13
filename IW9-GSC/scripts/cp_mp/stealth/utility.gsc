/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\stealth\utility.gsc
***********************************************/

_id_F9DD1250EA99D251(val) {
  if(isPlayer(self))
    _id_50C9C1C52C852F54(val);
  else
    self.attackeraccuracy = val;
}

_id_50C9C1C52C852F54(val) {
  self.scriptedattackeraccuracy = val;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("gameskill", "updatePlayerAttackerAccuracy"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("gameskill", "updatePlayerAttackerAccuracy")]]();
}