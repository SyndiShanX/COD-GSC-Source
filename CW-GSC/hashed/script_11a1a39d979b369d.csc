/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_11a1a39d979b369d.csc
***********************************************/

#using script_644007a8c3885fc;
#using scripts\core_common\item_world_fixup;
#namespace namespace_9be0edfa;

function autoexec __init__() {
  function_a1302aca();
}

function function_a1302aca() {
  var_87d0eef8 = &item_world_fixup::remove_item;
  var_74257310 = &item_world_fixup::add_item_replacement;
  var_f8a4c541 = &item_world_fixup::function_6991057;
  var_edfbccd0 = &item_world_fixup::function_e70fa91c;
  namespace_1c7b37c6::item_replacer(var_f8a4c541, #"zm_magicbox_weapon_named_weapons", #"hash_76f3a790ba92b7db");
  namespace_1c7b37c6::item_replacer(var_f8a4c541, #"level_6_gun_list", #"hash_fc5403fae8e99f2");
  namespace_1c7b37c6::item_replacer(var_f8a4c541, #"named_gun_list", #"hash_28b82ccb71cfa6a0");
  namespace_1c7b37c6::item_replacer(var_f8a4c541, #"ltm_halloween_chest_wonder_weapons", #"hash_5077f30cee923efa");
  namespace_1c7b37c6::item_replacer(var_74257310, #"ww_ray_rifle_t9_item_sr", #"ray_gun_item_sr");

  if(getdvarstring(#"g_gametype") === "zcranked") {
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"zm_equipment_list", #"hash_74ff81f976594bff");
  }
}