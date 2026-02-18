/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_22608e7a9ce54ae8.gsc
***********************************************/

#using script_2a30ac7aa0ee8988;
#using scripts\core_common\item_world_fixup;
#using scripts\zm_common\zm_utility;
#namespace namespace_5f402033;

function autoexec function_ceb1991() {
  if(zm_utility::is_survival()) {
    function_c2e022a9();
  }
}

function function_c2e022a9() {
  var_87d0eef8 = &item_world_fixup::remove_item;
  var_74257310 = &item_world_fixup::add_item_replacement;
  var_f8a4c541 = &item_world_fixup::function_6991057;

  if(is_true(getgametypesetting(#"hash_1e8998fd7f271bb7"))) {
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"zm_fishing_common_list", #"zm_fishing_common_list_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"armor_zombie_level1_drop_list", #"armor_zombie_level1_drop_list_sr_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"armor_zombie_level2_drop_list", #"armor_zombie_level2_drop_list_sr_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"armor_zombie_level3_drop_list", #"armor_zombie_level3_drop_list_sr_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"armor_zombie_level4_drop_list", #"armor_zombie_level4_drop_list_sr_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"armor_zombie_level5_drop_list", #"armor_zombie_level5_drop_list_sr_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"armor_zombie_level6_drop_list", #"armor_zombie_level6_drop_list_sr_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"normal_zombie_level1_drop_list", #"normal_zombie_level1_drop_list_sr_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"normal_zombie_level2_drop_list", #"normal_zombie_level2_drop_list_sr_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"normal_zombie_level3_drop_list", #"normal_zombie_level3_drop_list_sr_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"normal_zombie_level4_drop_list", #"normal_zombie_level4_drop_list_sr_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"normal_zombie_level5_drop_list", #"normal_zombie_level5_drop_list_sr_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"normal_zombie_level6_drop_list", #"normal_zombie_level6_drop_list_sr_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"special_zombie_level1_drop_list", #"special_zombie_level1_drop_list_sr_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"special_zombie_level2_drop_list", #"special_zombie_level2_drop_list_sr_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"special_zombie_level3_drop_list", #"special_zombie_level3_drop_list_sr_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"special_zombie_level4_drop_list", #"special_zombie_level4_drop_list_sr_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"special_zombie_level5_drop_list", #"special_zombie_level5_drop_list_sr_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"special_zombie_level6_drop_list", #"special_zombie_level6_drop_list_sr_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"elite_zombie_level1_parent_list", #"elite_zombie_level1_parent_list_sr_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"elite_zombie_level2_parent_list", #"elite_zombie_level2_parent_list_sr_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"elite_zombie_level3_parent_list", #"elite_zombie_level3_parent_list_sr_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"elite_zombie_level4_parent_list", #"elite_zombie_level4_parent_list_sr_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"elite_zombie_level5_parent_list", #"elite_zombie_level5_parent_list_sr_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"elite_zombie_level6_parent_list", #"elite_zombie_level6_parent_list_sr_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"boss_zombie_level1_parent_list", #"boss_zombie_level1_parent_list_sr_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"boss_zombie_level2_parent_list", #"boss_zombie_level2_parent_list_sr_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"boss_zombie_level3_parent_list", #"boss_zombie_level3_parent_list_sr_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"boss_zombie_level4_parent_list", #"boss_zombie_level4_parent_list_sr_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"boss_zombie_level5_parent_list", #"boss_zombie_level5_parent_list_sr_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"boss_zombie_level6_parent_list", #"boss_zombie_level6_parent_list_sr_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"black_chest_level_1", #"black_chest_level_1_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"black_chest_level_2", #"black_chest_level_2_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"black_chest_level_3", #"black_chest_level_3_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"black_chest_level_4", #"black_chest_level_4_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"black_chest_level_5", #"black_chest_level_5_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"black_chest_level_6", #"black_chest_level_6_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"gold_chest_level_1", #"gold_chest_level_1_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"gold_chest_level_2", #"gold_chest_level_2_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"gold_chest_level_3", #"gold_chest_level_3_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"gold_chest_level_4", #"gold_chest_level_4_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"gold_chest_level_5", #"gold_chest_level_5_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"gold_chest_level_6", #"gold_chest_level_6_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"large_chest_level_1", #"large_chest_level_1_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"large_chest_level_2", #"large_chest_level_2_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"large_chest_level_3", #"large_chest_level_3_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"large_chest_level_4", #"large_chest_level_4_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"large_chest_level_5", #"large_chest_level_5_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"large_chest_level_6", #"large_chest_level_6_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"medium_chest_level_1", #"medium_chest_level_1_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"medium_chest_level_2", #"medium_chest_level_2_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"medium_chest_level_3", #"medium_chest_level_3_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"medium_chest_level_4", #"medium_chest_level_4_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"medium_chest_level_5", #"medium_chest_level_5_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"medium_chest_level_6", #"medium_chest_level_6_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"small_chest_level_1", #"small_chest_level_1_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"small_chest_level_2", #"small_chest_level_2_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"small_chest_level_3", #"small_chest_level_3_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"small_chest_level_4", #"small_chest_level_4_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"small_chest_level_5", #"small_chest_level_5_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"small_chest_level_6", #"small_chest_level_6_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"loot_pod_level_1", #"loot_pod_level_1_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"loot_pod_level_2", #"loot_pod_level_2_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"loot_pod_level_3", #"loot_pod_level_3_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"loot_pod_level_4", #"loot_pod_level_4_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"loot_pod_level_5", #"loot_pod_level_5_food");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"loot_pod_level_6", #"loot_pod_level_6_food");
    return;
  }

  namespace_1c7b37c6::item_replacer(var_f8a4c541, #"armor_zombie_level1_drop_list", #"armor_zombie_level1_drop_list_sr");
  namespace_1c7b37c6::item_replacer(var_f8a4c541, #"armor_zombie_level2_drop_list", #"armor_zombie_level2_drop_list_sr");
  namespace_1c7b37c6::item_replacer(var_f8a4c541, #"armor_zombie_level3_drop_list", #"armor_zombie_level3_drop_list_sr");
  namespace_1c7b37c6::item_replacer(var_f8a4c541, #"armor_zombie_level4_drop_list", #"armor_zombie_level4_drop_list_sr");
  namespace_1c7b37c6::item_replacer(var_f8a4c541, #"armor_zombie_level5_drop_list", #"armor_zombie_level5_drop_list_sr");
  namespace_1c7b37c6::item_replacer(var_f8a4c541, #"armor_zombie_level6_drop_list", #"armor_zombie_level6_drop_list_sr");
  namespace_1c7b37c6::item_replacer(var_f8a4c541, #"normal_zombie_level1_drop_list", #"normal_zombie_level1_drop_list_sr");
  namespace_1c7b37c6::item_replacer(var_f8a4c541, #"normal_zombie_level2_drop_list", #"normal_zombie_level2_drop_list_sr");
  namespace_1c7b37c6::item_replacer(var_f8a4c541, #"normal_zombie_level3_drop_list", #"normal_zombie_level3_drop_list_sr");
  namespace_1c7b37c6::item_replacer(var_f8a4c541, #"normal_zombie_level4_drop_list", #"normal_zombie_level4_drop_list_sr");
  namespace_1c7b37c6::item_replacer(var_f8a4c541, #"normal_zombie_level5_drop_list", #"normal_zombie_level5_drop_list_sr");
  namespace_1c7b37c6::item_replacer(var_f8a4c541, #"normal_zombie_level6_drop_list", #"normal_zombie_level6_drop_list_sr");
  namespace_1c7b37c6::item_remover(var_87d0eef8, #"item_zmquest_sr_ltm_food_banana");
  namespace_1c7b37c6::item_remover(var_87d0eef8, #"item_zmquest_sr_ltm_food_burger");
  namespace_1c7b37c6::item_remover(var_87d0eef8, #"item_zmquest_sr_ltm_food_canned_corn");
  namespace_1c7b37c6::item_remover(var_87d0eef8, #"item_zmquest_sr_ltm_food_cauliflower");
  namespace_1c7b37c6::item_remover(var_87d0eef8, #"item_zmquest_sr_ltm_food_cheese");
  namespace_1c7b37c6::item_remover(var_87d0eef8, #"item_zmquest_sr_ltm_food_chicken_soup");
  namespace_1c7b37c6::item_remover(var_87d0eef8, #"item_zmquest_sr_ltm_food_chips");
  namespace_1c7b37c6::item_remover(var_87d0eef8, #"item_zmquest_sr_ltm_food_cookie");
  namespace_1c7b37c6::item_remover(var_87d0eef8, #"item_zmquest_sr_ltm_food_poutine");
  namespace_1c7b37c6::item_remover(var_87d0eef8, #"item_zmquest_sr_ltm_food_croissant");
  namespace_1c7b37c6::item_remover(var_87d0eef8, #"item_zmquest_sr_ltm_food_pizza_slice");
  namespace_1c7b37c6::item_remover(var_87d0eef8, #"item_zmquest_sr_ltm_food_pizza_full");
}