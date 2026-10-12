/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\utility\player_utility_cp.gsc
****************************************************/



#using scripts\common\utility;
#using scripts\engine\utility;
#namespace player_utility_cp;

function _isalive() {
  if(istrue(self.inlaststand)) {
    return 0;
  }

  return isalive(self);
}