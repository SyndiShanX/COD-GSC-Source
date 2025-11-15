/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\anims_table_shotgun.gsc
***********************************************/

#include common_scripts\utility;
#include maps\_utility;
#include animscripts\anims_table;
#using_animtree("generic_human");

setup_shotgun_anim_array(animtype, array) {
  assert(isDefined(array) && isarray(array));
  array[animtype]["combat"]["stand"]["spread"]["single"] = array( % shotgun_stand_fire_1a, % shotgun_stand_fire_1b);
  array[animtype]["combat"]["stand"]["spread"]["reload"] = array( % shotgun_stand_reload_c);
  array[animtype]["combat"]["stand"]["spread"]["reload_crouchhide"] = array( % shotgun_stand_reload_a, % shotgun_stand_reload_b);
  array[animtype]["combat"]["stand"]["spread"]["straight_level"] = % shotgun_aim_5;
  array[animtype]["combat"]["stand"]["spread"]["exposed_idle"] = array( % shotgun_stand_exposed_idle);
  array[animtype]["combat"]["stand"]["spread"]["add_aim_up"] = % shotgun_aim_8;
  array[animtype]["combat"]["stand"]["spread"]["add_aim_down"] = % shotgun_aim_2;
  array[animtype]["combat"]["stand"]["spread"]["add_aim_left"] = % shotgun_aim_4;
  array[animtype]["combat"]["stand"]["spread"]["add_aim_right"] = % shotgun_aim_6;
  array[animtype]["combat"]["crouch"]["spread"]["single"] = array( % shotgun_crouch_fire);
  array[animtype]["combat"]["crouch"]["spread"]["reload"] = array( % shotgun_crouch_reload);
  array[animtype]["combat"]["crouch"]["spread"]["exposed_idle"] = array( % shotgun_crouch_exposed_idle);
  array[animtype]["combat"]["crouch"]["spread"]["straight_level"] = % shotgun_crouch_aim_5;
  array[animtype]["combat"]["crouch"]["spread"]["add_aim_up"] = % shotgun_crouch_aim_8;
  array[animtype]["combat"]["crouch"]["spread"]["add_aim_down"] = % shotgun_crouch_aim_2;
  array[animtype]["combat"]["crouch"]["spread"]["add_aim_left"] = % shotgun_crouch_aim_4;
  array[animtype]["combat"]["crouch"]["spread"]["add_aim_right"] = % shotgun_crouch_aim_6;
  array[animtype]["move"]["stand"]["spread"]["single"] = array( % shotgun_stand_fire_1a, % shotgun_stand_fire_1b);
  return array;
}