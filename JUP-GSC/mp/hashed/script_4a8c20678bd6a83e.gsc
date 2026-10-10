/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_4a8c20678bd6a83e.gsc
*************************************************/

#using scripts\asm\asm;
#namespace zombie_traverse;

function processtraverse(taskid, params) {
  if(!self.var_20a0e88052918576) {
    return anim.failure;
  }

  return anim.running;
}

function is_traversing() {
  return self.var_32a34987ee1b3095 != "not_set";
}