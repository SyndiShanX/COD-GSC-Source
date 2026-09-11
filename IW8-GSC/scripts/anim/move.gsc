/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\move.gsc
***********************************************/

function mayshootwhilemoving() {
  if(nullweapon(self.weapon)) {
    return false;
  }

  var_0 = weaponclass(self.weapon);

  if(!scripts\anim\utility_common::usingriflelikeweapon()) {
    return false;
  }

  if(scripts\anim\utility_common::isasniper()) {
    if(!scripts\anim\utility::iscqbwalking() && self.facemotion) {
      return false;
    }
  }

  if(istrue(self.dontshootwhilemoving)) {
    return false;
  }

  return true;
}