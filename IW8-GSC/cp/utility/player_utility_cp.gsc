/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\utility\player_utility_cp.gsc
***********************************************/

_isalive() {
  if(istrue(self.inlaststand))
    return 0;

  return isalive(self);
}