/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_51063413e14ecf17.gsc
*************************************************/

#using script_bd0d3e8f9ff5c11;
#namespace namespace_c234fc735f913929;

function function_64e819ba93c64ccc(taskid) {
  target = self.enemy;

  if(!isalive(target)) {
    return anim.failure;
  }

  if(function_e82696e7b59178f3(target.origin)) {
    return anim.failure;
  }

  return anim.success;
}