/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\skyway_code.gsc
*****************************************************/

random_wait_and_kill(var_0, var_1) {
  self endon("death");
  wait(randomfloatrange(var_0, var_1));
}

get_a10_player_start() {
  var_0 = common_scripts\utility::getstruct("a10_player_start", "targetname");
  return var_0;
}

istank() {
  if(issubstr(self.classname, "t90"))
    return 1;

  if(issubstr(self.classname, "t72"))
    return 1;

  if(issubstr(self.classname, "m1a1"))
    return 1;

  if(issubstr(self.classname, "m1a2"))
    return 1;

  return 0;
}