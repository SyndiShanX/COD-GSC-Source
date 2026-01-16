/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\anims_table_juggernaut.gsc
**************************************************/

#include common_scripts\utility;
#include animscripts\anims;
#using_animtree("generic_human");

setup_juggernaut_anim_array() {
  self animscripts\anims::clearanimcache();

  if(!isDefined(self.anim_array))
    self.anim_array = [];

  self.anim_array[self.animtype]["move"]["stand"]["rifle"]["combat_run_f"] = % juggernaut_walkf;
  self.anim_array[self.animtype]["move"]["stand"]["rifle"]["sprint"] = % juggernaut_sprint;
  self.anim_array[self.animtype]["combat"]["stand"]["rifle"]["straight_level"] = % juggernaut_aim5;
  self.anim_array[self.animtype]["move"]["stand"]["spread"]["combat_run_f"] = % juggernaut_walkf;
  self.anim_array[self.animtype]["move"]["stand"]["spread"]["sprint"] = % juggernaut_sprint;
  self.anim_array[self.animtype]["combat"]["stand"]["spread"]["straight_level"] = % juggernaut_aim5;
}