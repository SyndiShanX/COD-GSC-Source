/*********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\talisman\zm_talisman_box_guarantee_box_only.gsc
*********************************************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\util;
#include scripts\zm_common\zm_stats;
#include scripts\zm_common\zm_talisman;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_weapons;

#namespace zm_talisman_box_guarantee_box_only;

autoexec __init__system__() {
  system::register(#"zm_talisman_box_guarantee_box_only", &__init__, undefined, undefined);
}

__init__() {
  zm_talisman::register_talisman("talisman_box_guarantee_box_only", &activate_talisman);
}

activate_talisman() {
  self.var_afb3ba4e = &function_543a48f0;
  self.var_c21099c0 = 1;
}

function_543a48f0(a_keys) {
  a_wallbuys = array();
  a_valid = array();
  var_52fb84b5 = [];
  var_52fb84b5 = struct::get_array("weapon_upgrade", "targetname");
  var_52fb84b5 = arraycombine(var_52fb84b5, struct::get_array("buildable_wallbuy", "targetname"), 1, 0);

  for(i = 0; i < var_52fb84b5.size; i++) {
    w_wallbuy = getweapon(var_52fb84b5[i].zombie_weapon_upgrade);
    array::add(a_wallbuys, w_wallbuy);
  }

  foreach(w_key in a_keys) {
    if(!zm_weapons::is_wonder_weapon(w_key)) {
      array::add(a_valid, w_key);
    }
  }

  a_keys = array::exclude(a_valid, a_wallbuys);
  a_keys = array::randomize(a_keys);
  self.var_afb3ba4e = undefined;
  self.var_c21099c0 = undefined;
  return a_keys;
}