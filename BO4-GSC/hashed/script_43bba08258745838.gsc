/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_43bba08258745838.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\util;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_talisman;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_weapons;
#namespace namespace_96796d10;

autoexec __init__system__() {
  system::register(#"hash_39bb8d673164edda", & __init__, undefined, undefined);
}

__init__() {
  zm_talisman::register_talisman("talisman_box_guarantee_wonder_weapon", & activate_talisman);
}

activate_talisman() {
  self.var_f15dc7c3 = & function_93c6fd5;
}

function_93c6fd5(a_keys) {
  a_valid = array();
  b_added = 0;
  if(isDefined(level.var_a65ad477) && !zm_weapons::get_is_in_box(level.var_a65ad477)) {
    a_keys = array(level.var_a65ad477);
    zm_weapons::function_55d25350(level.var_a65ad477);
    b_added = 1;
  }
  foreach(w_key in a_keys) {
    if(zm_weapons::is_wonder_weapon(w_key)) {
      array::add(a_valid, w_key);
    }
  }
  if(a_valid.size == 0) {
    a_valid = a_keys;
  }
  a_valid = array::randomize(a_valid);
  self.var_f15dc7c3 = undefined;
  if(b_added) {
    self thread function_eeca1349(level.var_a65ad477);
  }
  return a_valid;
}

function_60c07221(var_26fbc878) {
  level.var_a65ad477 = var_26fbc878;
}

function_eeca1349(var_26fbc878) {
  self waittilltimeout(12, # "user_grabbed_weapon");
  zm_weapons::function_503fb052(var_26fbc878);
}