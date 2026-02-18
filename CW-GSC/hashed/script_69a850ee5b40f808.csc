/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_69a850ee5b40f808.csc
***********************************************/

#using script_644007a8c3885fc;
#using scripts\core_common\item_world_fixup;
#namespace namespace_7f51d30f;

function autoexec __init__() {
  function_90ae260d();
}

function function_90ae260d() {
  var_87d0eef8 = &item_world_fixup::remove_item;
  var_74257310 = &item_world_fixup::add_item_replacement;
  var_f8a4c541 = &item_world_fixup::function_6991057;
  var_edfbccd0 = &item_world_fixup::function_e70fa91c;
  namespace_1c7b37c6::item_replacer(var_f8a4c541, #"zm_magicbox_weapon_named_weapons", #"hash_1b5199fd1393a226");
  namespace_1c7b37c6::item_replacer(var_f8a4c541, #"level_6_gun_list", #"hash_24b2c0f4ab55c0d7");
  namespace_1c7b37c6::item_replacer(var_f8a4c541, #"named_gun_list", #"hash_6284c394c2718975");
  namespace_1c7b37c6::item_replacer(var_f8a4c541, #"ltm_halloween_chest_wonder_weapons", #"hash_350839c1d730853f");
  namespace_1c7b37c6::item_replacer(var_74257310, #"ww_ray_rifle_t9_item_sr", #"ray_gun_item_sr");
}