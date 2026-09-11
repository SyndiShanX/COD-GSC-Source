/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\utility\player_utility_cp.gsc
****************************************************/

function _isalive() {
  if(istrue(self.inlaststand)) {
    return 0;
  }

  return isalive(self);
}