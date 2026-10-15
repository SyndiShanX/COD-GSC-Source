/****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\talisman\zm_talisman_box_guarantee_lmg.gsc
****************************************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\util;
#include scripts\zm_common\zm_stats;
#include scripts\zm_common\zm_talisman;
#include scripts\zm_common\zm_utility;

#namespace zm_talisman_box_guarantee_lmg;

autoexec __init__system__() {
  system::register(#"zm_talisman_box_guarantee_lmg", &__init__, undefined, undefined);
}

__init__() {
  zm_talisman::register_talisman("talisman_box_guarantee_lmg", &activate_talisman);
}

activate_talisman() {
  self.var_afb3ba4e = &function_8d50b46a;
  self.var_c21099c0 = 1;
}

function_8d50b46a(a_keys) {
  a_valid = array();

  foreach(w_key in a_keys) {
    if(w_key.weapclass == "mg") {
      array::add(a_valid, w_key);
    }
  }

  if(a_valid.size == 0) {
    a_valid = a_keys;
  }

  a_valid = array::randomize(a_valid);
  self.var_afb3ba4e = undefined;
  self.var_c21099c0 = undefined;
  return a_valid;
}