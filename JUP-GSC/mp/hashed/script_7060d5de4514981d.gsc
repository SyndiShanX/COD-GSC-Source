/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_7060d5de4514981d.gsc
*************************************************/

#using scripts\engine\utility;
#namespace namespace_1e8b45a54c41285f;

function function_c358395fdd65426c(taskid) {
  if(!istrue(self.zombieaisettings.var_e58a65b7a8f5973c.var_8046d8e4a62a55c0)) {
    return anim.failure;
  }

  if(self.var_1b51c793abb7dbe6 <= 1) {
    return anim.success;
  }

  var_de7821bc51ab43a0 = [[self.var_8f1d8328f7a9091b]]();

  if(var_de7821bc51ab43a0 >= 7 && self.var_1b51c793abb7dbe6 <= 3) {
    return anim.success;
  }

  return anim.failure;
}