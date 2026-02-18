/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\zm_tungsten_fixup.gsc
***********************************************/

#using script_2a30ac7aa0ee8988;
#using scripts\core_common\item_world_fixup;
#namespace namespace_d5db95b4;

function autoexec __init__() {
  function_c70f8122();
}

function function_c70f8122() {
  var_87d0eef8 = &item_world_fixup::remove_item;
  var_74257310 = &item_world_fixup::add_item_replacement;
  var_f8a4c541 = &item_world_fixup::function_6991057;
  var_edfbccd0 = &item_world_fixup::function_e70fa91c;
  namespace_1c7b37c6::item_replacer(var_f8a4c541, #"zm_magicbox_weapon_named_weapons", #"hash_76801accbe42542");
  namespace_1c7b37c6::item_replacer(var_f8a4c541, #"zm_magicbox_scorestreak_list", #"hash_66e8775be8803156");
  namespace_1c7b37c6::item_replacer(var_f8a4c541, #"level_6_gun_list", #"hash_2615b9246d595abb");
  namespace_1c7b37c6::item_replacer(var_f8a4c541, #"named_gun_list", #"hash_577ec9e24502ddd");
  namespace_1c7b37c6::item_replacer(var_f8a4c541, #"ltm_halloween_chest_wonder_weapons", #"hash_418c1b8934168303");
  namespace_1c7b37c6::item_replacer(var_74257310, #"ww_ray_rifle_t9_item_sr", #"ray_gun_item_sr");
}