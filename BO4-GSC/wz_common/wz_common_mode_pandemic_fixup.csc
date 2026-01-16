/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\wz_common_mode_pandemic_fixup.csc
*******************************************************/

#include scripts\mp_common\item_world_fixup;
#include scripts\wz_common\wz_common_fixup;

#namespace wz_common_mode_pandemic_fixup;

autoexec function_45a212c0() {
  var_a12b4736 = &item_world_fixup::function_96ff7b88;
  var_d2223309 = &item_world_fixup::function_261ab7f5;
  var_b5014996 = &item_world_fixup::function_19089c75;
  var_87d0eef8 = &item_world_fixup::remove_item;
  var_74257310 = &item_world_fixup::add_item_replacement;
  var_f8a4c541 = &item_world_fixup::function_6991057;

  if(isDefined(getgametypesetting(#"infectionmode")) && getgametypesetting(#"infectionmode")) {
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"ammo_type_12ga_item", #"ammo_type_12ga_double_item");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"ammo_type_338_item", #"ammo_type_338_double_item");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"ammo_type_45_item", #"ammo_type_45_double_item");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"hash_49fecbcd6cbd1ed9", #"ammo_type_50cal_double_item");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"ammo_type_556_item", #"ammo_type_556_double_item");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"ammo_type_762_item", #"ammo_type_762_double_item");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"ammo_type_9mm_item", #"ammo_type_9mm_double_item");
    wz_common_fixup::item_replacer(var_d2223309, var_74257310, #"ammo_type_rocket_item", #"ammo_type_rocket_double_item");
    wz_common_fixup::item_replacer(var_b5014996, var_f8a4c541, #"supply_stash_parent_dlc1", #"supply_stash_parent_pandemic");
  }
}