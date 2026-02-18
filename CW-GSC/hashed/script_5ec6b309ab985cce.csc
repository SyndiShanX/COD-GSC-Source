/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_5ec6b309ab985cce.csc
***********************************************/

#using script_644007a8c3885fc;
#using scripts\core_common\item_world_fixup;
#namespace namespace_ed93e89a;

function autoexec __init__() {
  function_5355973a();
}

function function_5355973a() {
  var_87d0eef8 = &item_world_fixup::remove_item;
  var_74257310 = &item_world_fixup::add_item_replacement;
  var_f8a4c541 = &item_world_fixup::function_6991057;
  var_edfbccd0 = &item_world_fixup::function_e70fa91c;
  namespace_1c7b37c6::item_replacer(var_f8a4c541, #"zm_magicbox_weapon_named_weapons", #"hash_ae7cd5bcb26ed4");
  namespace_1c7b37c6::item_replacer(var_f8a4c541, #"level_6_gun_list", #"hash_73a96a34fef07711");
  namespace_1c7b37c6::item_replacer(var_f8a4c541, #"named_gun_list", #"hash_46278665675794d3");
  namespace_1c7b37c6::item_replacer(var_f8a4c541, #"ltm_halloween_chest_wonder_weapons", #"hash_444c92427ea7e4f9");
  namespace_1c7b37c6::item_replacer(var_74257310, #"ray_gun_item_sr", #"ww_ray_rifle_t9_item_sr");

  if(getdvarstring(#"g_gametype") === "zcranked") {
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"zm_equipment_list", #"hash_74ff81f976594bff");
  }
}