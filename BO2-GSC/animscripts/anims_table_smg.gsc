/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\anims_table_smg.gsc
*******************************************/

#include common_scripts\utility;
#using_animtree("generic_human");

setup_smg_anim_array(animtype, array) {
  assert(isDefined(array) && isarray(array));
  array[animtype]["combat"]["stand"]["smg"]["exposed_idle"] = array( % smg_stand_exposed_idle_alert, % smg_stand_exposed_idle_alert_v2, % smg_stand_exposed_idle_alert_v3);
  array[animtype]["combat"]["stand"]["smg"]["straight_level"] = % smg_stand_exposed_aim_5;
  array[animtype]["combat"]["stand"]["smg"]["add_aim_up"] = % smg_stand_exposed_aim_8;
  array[animtype]["combat"]["stand"]["smg"]["add_aim_down"] = % smg_stand_exposed_aim_2;
  array[animtype]["combat"]["stand"]["smg"]["add_aim_left"] = % smg_stand_exposed_aim_4;
  array[animtype]["combat"]["stand"]["smg"]["add_aim_right"] = % smg_stand_exposed_aim_6;
  array[animtype]["combat"]["stand"]["smg"]["melee_0"] = % ai_melee_03;
  array[animtype]["combat"]["stand"]["smg"]["stand_2_melee_0"] = % ai_stand_2_melee_03;
  array[animtype]["combat"]["stand"]["smg"]["run_2_melee_0"] = % ai_run_2_melee_03_charge;
  return array;
}