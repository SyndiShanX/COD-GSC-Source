/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_26983a80042c09d8.gsc
*************************************************/

#using script_bd0d3e8f9ff5c11;
#namespace namespace_16e4ada217cd5608;

function function_b209f843e410abb5(taskid) {
  target = self.enemy;

  if(!isalive(target)) {
    return anim.failure;
  }

  if(abs(target.origin[2] - self.origin[2]) > 100) {
    return anim.failure;
  }

  if(!istrue(self.zombieaisettings.var_e58a65b7a8f5973c.var_a379ec913c7fcfa1)) {
    return anim.failure;
  }

  closest_tacpoint = findclosesttacpoint(target.origin);

  if(isDefined(closest_tacpoint)) {
    var_5472fac695b32f65 = function_5e2c6953b8312bd6(closest_tacpoint);

    if(var_5472fac695b32f65 < 1000) {
      return anim.failure;
    }
  }

  if(function_e82696e7b59178f3(target.origin)) {
    return anim.failure;
  }

  return anim.success;
}