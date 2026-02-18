/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_7cd114897e1b962b.csc
***********************************************/

#using script_644007a8c3885fc;
#using scripts\core_common\item_world_fixup;
#namespace namespace_7613a4d0;

function autoexec __init__() {
  function_6e338a1c();
  level.var_21f73755 = 1;
}

function function_6e338a1c() {
  str_gametype = getdvarstring(#"g_gametype");
  var_87d0eef8 = &item_world_fixup::remove_item;
  var_74257310 = &item_world_fixup::add_item_replacement;
  var_f8a4c541 = &item_world_fixup::function_6991057;

  if(str_gametype == "zsurvival") {
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"zm_equipment_list", #"zm_equipment_list_outbreak");
  }

  if(str_gametype == "zclassic" || str_gametype == # "zholiday") {
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"zombie_level1_resource_list", #"zombie_level1_scrap_list");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"zombie_level2_resource_list", #"zombie_level2_scrap_list");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"zombie_level3_resource_list", #"zombie_level3_scrap_list");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"zombie_level4_resource_list", #"zombie_level4_scrap_list");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"zombie_level5_resource_list", #"zombie_level5_scrap_list");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"zombie_level6_resource_list", #"zombie_level6_scrap_list");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"zombie_armor_level1_resource_list", #"zombie_armor_level1_noammo_resource_list");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"zombie_armor_level2_resource_list", #"zombie_armor_level2_noammo_resource_list");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"zombie_armor_level3_resource_list", #"zombie_armor_level3_noammo_resource_list");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"zombie_armor_level4_resource_list", #"zombie_armor_level4_noammo_resource_list");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"zombie_armor_level5_resource_list", #"zombie_armor_level5_noammo_resource_list");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"zombie_armor_level6_resource_list", #"zombie_armor_level6_noammo_resource_list");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"sr_explore_chest_ammo_mods", #"sr_explore_chest_perk_bottles");
  }

  var_c200446c = function_be90acca(str_gametype) === # "zonslaught";

  if(var_c200446c) {
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"zombie_level1_scrap_list", #"sr_zombie_drop_ammo");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"zombie_level2_scrap_list", #"sr_zombie_drop_ammo");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"zombie_level3_scrap_list", #"sr_zombie_drop_ammo");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"zombie_level4_scrap_list", #"sr_zombie_drop_ammo");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"zombie_level5_scrap_list", #"sr_zombie_drop_ammo");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"zombie_level6_scrap_list", #"sr_zombie_drop_ammo");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"level_1_gun_list", #"level_1_onslaught_gun_list");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"level_2_gun_list", #"level_2_onslaught_gun_list");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"level_3_gun_list", #"level_3_onslaught_gun_list");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"level_4_gun_list", #"level_4_onslaught_gun_list");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"level_5_gun_list", #"level_5_onslaught_gun_list");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"level_6_gun_list", #"level_6_onslaught_gun_list");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"level_7_gun_list", #"level_7_onslaught_gun_list");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"level_8_gun_list", #"level_8_onslaught_gun_list");

    if(str_gametype === # "hash_1aecd78b7244ff81") {
      namespace_1c7b37c6::item_replacer(var_f8a4c541, #"level_1_onslaught_gun_list", #"t9_empty_global");
      namespace_1c7b37c6::item_replacer(var_f8a4c541, #"level_2_onslaught_gun_list", #"t9_empty_global");
      namespace_1c7b37c6::item_replacer(var_f8a4c541, #"level_3_onslaught_gun_list", #"t9_empty_global");
      namespace_1c7b37c6::item_replacer(var_f8a4c541, #"level_4_onslaught_gun_list", #"t9_empty_global");
      namespace_1c7b37c6::item_replacer(var_f8a4c541, #"level_5_onslaught_gun_list", #"t9_empty_global");
      namespace_1c7b37c6::item_replacer(var_f8a4c541, #"level_6_onslaught_gun_list", #"t9_empty_global");
      namespace_1c7b37c6::item_replacer(var_f8a4c541, #"level_7_onslaught_gun_list", #"t9_empty_global");
      namespace_1c7b37c6::item_replacer(var_f8a4c541, #"level_8_onslaught_gun_list", #"t9_empty_global");
      namespace_1c7b37c6::item_remover(var_87d0eef8, #"brainrot_item_sr");
      namespace_1c7b37c6::item_remover(var_87d0eef8, #"napalmburst_item_sr");
      namespace_1c7b37c6::item_remover(var_87d0eef8, #"deadwire_item_sr");
      namespace_1c7b37c6::item_remover(var_87d0eef8, #"cryofreeze_item_sr");
      namespace_1c7b37c6::item_remover(var_87d0eef8, #"shatterblast_item_sr");
      namespace_1c7b37c6::item_remover(var_87d0eef8, #"aether_tool_item_sr");
      namespace_1c7b37c6::item_remover(var_87d0eef8, #"bronze_chalice_item_sr");
      namespace_1c7b37c6::item_remover(var_87d0eef8, #"silver_chalice_item_sr");
      namespace_1c7b37c6::item_remover(var_87d0eef8, #"gold_chalice_item_sr");
    }

    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ray_gun_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ray_gun_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ww_ray_rifle_t9_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ww_ray_rifle_t9_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ww_ieu_acid_t9_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ww_ieu_electric_t9_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ww_ieu_gas_t9_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ww_ieu_plasma_t9_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ww_ieu_shockwave_t9_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ww_ieu_acid_t9_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ww_ieu_electric_t9_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ww_ieu_gas_t9_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ww_ieu_plasma_t9_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ww_ieu_shockwave_t9_upgraded_item_sr");
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"ai_bonus_item_list", #"ai_bonus_onslaught_item_list");
  }

  if(is_true(getgametypesetting(#"hash_7e8e34cc69a77e0b")) || getdvarint(#"hash_40bd34b35079cf2e", 0) > 0) {
    namespace_1c7b37c6::item_replacer(var_f8a4c541, #"zm_equipment_list", #"zm_ltm1_equipment_drop_list");
  }

  namespace_1c7b37c6::item_replacer(var_74257310, #"hash_74efc2f0523a1b43", #"acog_t9_item_sr");
  namespace_1c7b37c6::item_replacer(var_74257310, #"hash_1bdc6102e1922ee1", #"barrel2_t9_item_sr");
  namespace_1c7b37c6::item_replacer(var_74257310, #"hash_3d79e8fa4d04bbe9", #"barrel_t9_item_sr");
  namespace_1c7b37c6::item_replacer(var_74257310, #"hash_63a257f430cb24e4", #"compensator2_t9_item_sr");
  namespace_1c7b37c6::item_replacer(var_74257310, #"hash_7e68f63f8995b1e6", #"compensator_t9_item_sr");
  namespace_1c7b37c6::item_replacer(var_74257310, #"hash_66f7a79dbd87eec0", #"dualoptic_t9_item_sr");
  namespace_1c7b37c6::item_replacer(var_74257310, #"hash_409656a5454ca9a1", #"elo2_t9_item_sr");
  namespace_1c7b37c6::item_replacer(var_74257310, #"hash_139fe0e3be289c29", #"elo_t9_item_sr");
  namespace_1c7b37c6::item_replacer(var_74257310, #"hash_1d1e0f96c57550a2", #"elo3_t9_item_sr");
  namespace_1c7b37c6::item_replacer(var_74257310, #"hash_43a7c00ebad019fc", #"extclip2_t9_item_sr");
  namespace_1c7b37c6::item_replacer(var_74257310, #"hash_2551991b0ce4278e", #"extclip_t9_item_sr");
  namespace_1c7b37c6::item_replacer(var_74257310, #"hash_2a74aa6c21425de8", #"fastreload2_t9_item_sr");
  namespace_1c7b37c6::item_replacer(var_74257310, #"hash_13e7b5e35b27fda2", #"fastreload_t9_item_sr");
  namespace_1c7b37c6::item_replacer(var_74257310, #"hash_1e87409dae378d95", #"grip2_t9_item_sr");
  namespace_1c7b37c6::item_replacer(var_74257310, #"hash_780b6e02fd11b515", #"grip_t9_item_sr");
  namespace_1c7b37c6::item_replacer(var_74257310, #"hash_5e8e59ff7a020c33", #"handle2_t9_item_sr");
  namespace_1c7b37c6::item_replacer(var_74257310, #"hash_72c4fa7a2b91b0b3", #"handle_t9_item_sr");
  namespace_1c7b37c6::item_replacer(var_74257310, #"hash_7a28e0acec4d71b2", #"heavy2_t9_item_sr");
  namespace_1c7b37c6::item_replacer(var_74257310, #"heavy_t9_item", #"heavy_t9_item_sr");
  namespace_1c7b37c6::item_replacer(var_74257310, #"hash_6edd00dc752c24e1", #"holo_t9_item_sr");
  namespace_1c7b37c6::item_replacer(var_74257310, #"hash_13101dfb0ca2d5fe", #"ir_t9_item_sr");
  namespace_1c7b37c6::item_replacer(var_74257310, #"hash_a89044fba7b2c27", #"light2_t9_item_sr");
  namespace_1c7b37c6::item_replacer(var_74257310, #"light_t9_item", #"light_t9_item_sr");
  namespace_1c7b37c6::item_replacer(var_74257310, #"hash_2beafef30af1e8c5", #"mixbarrel2_t9_item_sr");
  namespace_1c7b37c6::item_replacer(var_74257310, #"hash_693720c039d99805", #"mixbarrel_t9_item_sr");
  namespace_1c7b37c6::item_replacer(var_74257310, #"hash_63dd998473d02f01", #"mixbody2_t9_item_sr");
  namespace_1c7b37c6::item_replacer(var_74257310, #"hash_6d0a8b21a8b8b789", #"mixbody_t9_item_sr");
  namespace_1c7b37c6::item_replacer(var_74257310, #"hash_7ec532c309e0eef7", #"mixclip2_t9_item_sr");
  namespace_1c7b37c6::item_replacer(var_74257310, #"hash_8337602f5a165af", #"mixclip_t9_item_sr");
  namespace_1c7b37c6::item_replacer(var_74257310, #"hash_4bfc4ce4d3e99f07", #"mixhandle2_t9_item_sr");
  namespace_1c7b37c6::item_replacer(var_74257310, #"hash_13623c18b49d567f", #"mixhandle_t9_item_sr");
  namespace_1c7b37c6::item_replacer(var_74257310, #"hash_6cc986f0af4b142a", #"mixmuzzle2_t9_item_sr");
  namespace_1c7b37c6::item_replacer(var_74257310, #"hash_438ee0a9ed0f3b64", #"mixmuzzle_t9_item_sr");
  namespace_1c7b37c6::item_replacer(var_74257310, #"hash_6db3b0a25b06fbb9", #"mixstock2_t9_item_sr");
  namespace_1c7b37c6::item_replacer(var_74257310, #"hash_311a6366c098f011", #"mixstock_t9_item_sr");
  namespace_1c7b37c6::item_replacer(var_74257310, #"hash_26a11c1d57bbb4d1", #"mixunder2_t9_item_sr");
  namespace_1c7b37c6::item_replacer(var_74257310, #"hash_64d48522d34c4f99", #"mixunder_t9_item_sr");
  namespace_1c7b37c6::item_replacer(var_74257310, #"hash_776efcf8d78c80", #"quickdraw2_t9_item_sr");
  namespace_1c7b37c6::item_replacer(var_74257310, #"hash_2b8002d0d1dd882a", #"quickdraw_t9_item_sr");
  namespace_1c7b37c6::item_replacer(var_74257310, #"hash_2ff1e718a658a883", #"reddot_t9_item_sr");
  namespace_1c7b37c6::item_replacer(var_74257310, #"hash_60df57f4f5a14577", #"reflex2_t9_item_sr");
  namespace_1c7b37c6::item_replacer(var_74257310, #"hash_53ac88663aebc40", #"reflex3_t9_item_sr");
  namespace_1c7b37c6::item_replacer(var_74257310, #"hash_7935909de8935589", #"reflex4_t9_item_sr");
  namespace_1c7b37c6::item_replacer(var_74257310, #"hash_28efceaacc63752f", #"reflex_t9_item_sr");
  namespace_1c7b37c6::item_replacer(var_74257310, #"hash_6e6118f39468cb2c", #"scope3x_t9_item_sr");
  namespace_1c7b37c6::item_replacer(var_74257310, #"hash_af064392d860f1f", #"scope4x_t9_item_sr");
  namespace_1c7b37c6::item_replacer(var_74257310, #"hash_10ade3abf18cb742", #"smoothzoom2_t9_item_sr");
  namespace_1c7b37c6::item_replacer(var_74257310, #"hash_4bc121b59bfe4a2c", #"smoothzoom_t9_item_sr");
  namespace_1c7b37c6::item_replacer(var_74257310, #"hash_3c63a8769b611006", #"speedgrip2_t9_item_sr");
  namespace_1c7b37c6::item_replacer(var_74257310, #"hash_114f1df6ad46f598", #"speedgrip_t9_item_sr");
  namespace_1c7b37c6::item_replacer(var_74257310, #"hash_fddd3e0764a6167", #"sprintout2_t9_item_sr");
  namespace_1c7b37c6::item_replacer(var_74257310, #"hash_21f2c71ee52d3d5f", #"sprintout_t9_item_sr");
  namespace_1c7b37c6::item_replacer(var_74257310, #"hash_767e2b6d5150883b", #"stalker2_t9_item_sr");
  namespace_1c7b37c6::item_replacer(var_74257310, #"hash_12aaf0a984a5418b", #"stalker_t9_item_sr");
  namespace_1c7b37c6::item_replacer(var_74257310, #"hash_100ffabc91f834d2", #"steadyaim2_t9_item_sr");
  namespace_1c7b37c6::item_replacer(var_74257310, #"hash_1d25af262e371b3c", #"steadyaim_t9_item_sr");
  namespace_1c7b37c6::item_replacer(var_74257310, #"hash_7823002429b5d54f", #"suppressed2_t9_item_sr");
  namespace_1c7b37c6::item_replacer(var_74257310, #"hash_bec81919557da77", #"suppressed_t9_item_sr");

  if(!is_true(getgametypesetting(#"hash_21dfcc8984dad931"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ray_gun_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ray_gun_upgraded_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_9574295c8d1417e"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_accurate_t9_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_accurate_t9_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_accurate_t9_white_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_accurate_t9_white_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_accurate_t9_white_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_accurate_t9_green_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_accurate_t9_green_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_accurate_t9_green_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_accurate_t9_blue_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_accurate_t9_blue_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_accurate_t9_blue_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_accurate_t9_purple_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_accurate_t9_purple_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_accurate_t9_purple_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_accurate_t9_orange_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_accurate_t9_orange_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_accurate_t9_orange_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_5b2d331d596e0292");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_1729a203dbc446f8");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_67af34a77d27a7cf");
  }

  if(!is_true(getgametypesetting(#"hash_197b8b458c4577b9"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_damage_t9_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_damage_t9_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_damage_t9_white_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_damage_t9_white_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_damage_t9_white_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_damage_t9_green_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_damage_t9_green_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_damage_t9_green_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_damage_t9_blue_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_damage_t9_blue_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_damage_t9_blue_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_damage_t9_purple_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_damage_t9_purple_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_damage_t9_purple_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_damage_t9_orange_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_damage_t9_orange_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_damage_t9_orange_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_77d1b7aa5ea3ccc1");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_7b233c3274c0a761");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_295f9914fb41be4e");
  }

  if(!is_true(getgametypesetting(#"hash_3cd4e4f070668ada"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_fastfire_t9_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_fastfire_t9_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_fastfire_t9_white_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_fastfire_t9_white_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_fastfire_t9_white_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_fastfire_t9_green_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_fastfire_t9_green_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_fastfire_t9_green_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_fastfire_t9_blue_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_fastfire_t9_blue_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_fastfire_t9_blue_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_fastfire_t9_purple_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_fastfire_t9_purple_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_fastfire_t9_purple_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_fastfire_t9_orange_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_fastfire_t9_orange_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_fastfire_t9_orange_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_6fec98353aa8cf82");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_32da80f29ddd6b08");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_29936bdf24f06fdf");
  }

  if(!is_true(getgametypesetting(#"hash_38fc677b479b1b9b"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_fasthandling_t9_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_fasthandling_t9_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_fasthandling_t9_white_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_fasthandling_t9_white_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_fasthandling_t9_white_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_fasthandling_t9_green_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_fasthandling_t9_green_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_fasthandling_t9_green_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_fasthandling_t9_blue_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_fasthandling_t9_blue_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_fasthandling_t9_blue_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_fasthandling_t9_purple_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_fasthandling_t9_purple_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_fasthandling_t9_purple_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_fasthandling_t9_orange_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_fasthandling_t9_orange_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_fasthandling_t9_orange_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_7473ef780c3cd063");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_4a8134cdff7770a3");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_51fd64cb3365db20");
  }

  if(!is_true(getgametypesetting(#"hash_5428069c26ac7a85"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_mobility_t9_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_mobility_t9_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_mobility_t9_white_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_mobility_t9_white_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_mobility_t9_white_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_mobility_t9_green_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_mobility_t9_green_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_mobility_t9_green_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_mobility_t9_blue_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_mobility_t9_blue_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_mobility_t9_blue_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_mobility_t9_purple_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_mobility_t9_purple_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_mobility_t9_purple_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_mobility_t9_orange_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_mobility_t9_orange_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_mobility_t9_orange_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_4dfb91f0a16f381");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_7eac69a46b6c1721");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_66de50e598bc050e");
  }

  if(!is_true(getgametypesetting(#"hash_30fcc5c576cf049c"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_slowhandling_t9_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_slowhandling_t9_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_slowhandling_t9_white_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_slowhandling_t9_white_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_slowhandling_t9_white_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_slowhandling_t9_green_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_slowhandling_t9_green_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_slowhandling_t9_green_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_slowhandling_t9_blue_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_slowhandling_t9_blue_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_slowhandling_t9_blue_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_slowhandling_t9_purple_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_slowhandling_t9_purple_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_slowhandling_t9_purple_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_slowhandling_t9_orange_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_slowhandling_t9_orange_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_slowhandling_t9_orange_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_5b1db5e03f5e110");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_29ef5eff7240be66");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_1dd7ef9708d592a5");
  }

  if(!is_true(getgametypesetting(#"hash_21138fb9940856ed"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_standard_t9_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_standard_t9_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_standard_t9_white_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_standard_t9_white_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_standard_t9_white_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_standard_t9_green_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_standard_t9_green_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_standard_t9_green_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_standard_t9_blue_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_standard_t9_blue_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_standard_t9_blue_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_standard_t9_purple_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_standard_t9_purple_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_standard_t9_purple_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_standard_t9_orange_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_standard_t9_orange_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ar_standard_t9_orange_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_26bdebfa4c19c961");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_7dd291a21f7375c1");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_73b0c097aecf62e");
  }

  if(!is_true(getgametypesetting(#"hash_55a71b8eec91f064"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"knife_loadout_t9_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"knife_loadout_t9_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"knife_loadout_t9_white_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"knife_loadout_t9_white_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"knife_loadout_t9_green_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"knife_loadout_t9_green_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"knife_loadout_t9_blue_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"knife_loadout_t9_blue_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"knife_loadout_t9_purple_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"knife_loadout_t9_purple_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"knife_loadout_t9_orange_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"knife_loadout_t9_orange_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_35be7629fed232e");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_25dc0832f0318d43");
  }

  if(!is_true(getgametypesetting(#"hash_a496839f1b02b42"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"melee_wakizashi_t9_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"melee_wakizashi_t9_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"melee_wakizashi_t9_white_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"melee_wakizashi_t9_white_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"melee_wakizashi_t9_green_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"melee_wakizashi_t9_green_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"melee_wakizashi_t9_blue_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"melee_wakizashi_t9_blue_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"melee_wakizashi_t9_purple_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"melee_wakizashi_t9_purple_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"melee_wakizashi_t9_orange_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"melee_wakizashi_t9_orange_upgraded_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_17d1136ac99cdb85"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"melee_sledgehammer_t9_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"melee_sledgehammer_t9_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"melee_sledgehammer_t9_white_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"melee_sledgehammer_t9_white_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"melee_sledgehammer_t9_green_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"melee_sledgehammer_t9_green_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"melee_sledgehammer_t9_blue_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"melee_sledgehammer_t9_blue_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"melee_sledgehammer_t9_purple_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"melee_sledgehammer_t9_purple_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"melee_sledgehammer_t9_orange_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"melee_sledgehammer_t9_orange_upgraded_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_70c3412e2cba1306"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"melee_etool_t9_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"melee_etool_t9_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"melee_etool_t9_white_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"melee_etool_t9_white_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"melee_etool_t9_green_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"melee_etool_t9_green_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"melee_etool_t9_blue_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"melee_etool_t9_blue_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"melee_etool_t9_purple_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"melee_etool_t9_purple_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"melee_etool_t9_orange_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"melee_etool_t9_orange_upgraded_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_6df7f3b336fa9540"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"melee_machete_t9_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"melee_machete_t9_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"melee_machete_t9_white_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"melee_machete_t9_white_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"melee_machete_t9_green_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"melee_machete_t9_green_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"melee_machete_t9_blue_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"melee_machete_t9_blue_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"melee_machete_t9_purple_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"melee_machete_t9_purple_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"melee_machete_t9_orange_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"melee_machete_t9_orange_upgraded_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_6e08ae9c93d49fa9"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"launcher_freefire_t9_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"launcher_freefire_t9_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"launcher_freefire_t9_white_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"launcher_freefire_t9_white_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"launcher_freefire_t9_white_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"launcher_freefire_t9_green_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"launcher_freefire_t9_green_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"launcher_freefire_t9_green_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"launcher_freefire_t9_blue_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"launcher_freefire_t9_blue_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"launcher_freefire_t9_blue_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"launcher_freefire_t9_purple_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"launcher_freefire_t9_purple_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"launcher_freefire_t9_purple_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"launcher_freefire_t9_orange_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"launcher_freefire_t9_orange_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"launcher_freefire_t9_orange_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_63dcfacd6885b917");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_72bd537d51265067");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_e86c17e3d9d283c");
  }

  if(!is_true(getgametypesetting(#"hash_325ba7c748b18956"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"launcher_standard_t9_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"launcher_standard_t9_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"launcher_standard_t9_white_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"launcher_standard_t9_white_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"launcher_standard_t9_white_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"launcher_standard_t9_green_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"launcher_standard_t9_green_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"launcher_standard_t9_green_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"launcher_standard_t9_blue_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"launcher_standard_t9_blue_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"launcher_standard_t9_blue_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"launcher_standard_t9_purple_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"launcher_standard_t9_purple_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"launcher_standard_t9_purple_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"launcher_standard_t9_orange_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"launcher_standard_t9_orange_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"launcher_standard_t9_orange_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_6db9367335eea300");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_24a067f15a7551b6");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_7f529291e37ba5f5");
  }

  if(!is_true(getgametypesetting(#"hash_276c762aa3f9fb83"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_accurate_t9_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_accurate_t9_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_accurate_t9_white_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_accurate_t9_white_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_accurate_t9_white_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_accurate_t9_green_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_accurate_t9_green_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_accurate_t9_green_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_accurate_t9_blue_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_accurate_t9_blue_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_accurate_t9_blue_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_accurate_t9_purple_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_accurate_t9_purple_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_accurate_t9_purple_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_accurate_t9_orange_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_accurate_t9_orange_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_accurate_t9_orange_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_69767bccfe487d39");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_5d07658a38c7f729");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_7446bb3ab0a6d586");
  }

  if(!is_true(getgametypesetting(#"hash_3a7ec0a6978ebd27"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_fastfire_t9_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_fastfire_t9_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_fastfire_t9_white_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_fastfire_t9_white_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_fastfire_t9_white_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_fastfire_t9_green_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_fastfire_t9_green_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_fastfire_t9_green_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_fastfire_t9_blue_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_fastfire_t9_blue_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_fastfire_t9_blue_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_fastfire_t9_purple_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_fastfire_t9_purple_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_fastfire_t9_purple_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_fastfire_t9_orange_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_fastfire_t9_orange_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_fastfire_t9_orange_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_591cbfbc064e6c05");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_66d13728a35aa565");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_26d4d92dfea8fcfa");
  }

  if(!is_true(getgametypesetting(#"hash_783783e66c8036bb"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_light_t9_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_light_t9_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_light_t9_white_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_light_t9_white_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_light_t9_white_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_light_t9_green_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_light_t9_green_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_light_t9_green_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_light_t9_blue_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_light_t9_blue_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_light_t9_blue_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_light_t9_purple_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_light_t9_purple_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_light_t9_purple_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_light_t9_orange_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_light_t9_orange_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_light_t9_orange_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_6ba3b12d87d50cb7");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_c22385bc196c5c7");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_661744174e0f39c");
  }

  if(!is_true(getgametypesetting(#"hash_61d2c98cd4f42430"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_slowfire_t9_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_slowfire_t9_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_slowfire_t9_white_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_slowfire_t9_white_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_slowfire_t9_white_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_slowfire_t9_green_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_slowfire_t9_green_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_slowfire_t9_green_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_slowfire_t9_blue_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_slowfire_t9_blue_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_slowfire_t9_blue_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_slowfire_t9_purple_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_slowfire_t9_purple_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_slowfire_t9_purple_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_slowfire_t9_orange_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_slowfire_t9_orange_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"lmg_slowfire_t9_orange_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_19e050fa878481ae");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_50b024af36d4b464");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_6bca7f356e3c90c3");
  }

  if(!is_true(getgametypesetting(#"hash_7d458c697d0c4966"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_burst_t9_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_burst_t9_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_burst_t9_white_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_burst_t9_white_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_burst_t9_white_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_burst_t9_green_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_burst_t9_green_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_burst_t9_green_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_burst_t9_blue_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_burst_t9_blue_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_burst_t9_blue_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_burst_t9_purple_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_burst_t9_purple_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_burst_t9_purple_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_burst_t9_orange_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_burst_t9_orange_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_burst_t9_orange_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_687b669dd14bfd4");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_385a47e4285092ca");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_18f40daf4b28ae41");
  }

  if(!is_true(getgametypesetting(#"hash_26a2c5ac44218a16"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_fullauto_t9_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_fullauto_t9_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_fullauto_t9_white_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_fullauto_t9_white_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_fullauto_t9_white_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_fullauto_t9_green_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_fullauto_t9_green_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_fullauto_t9_green_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_fullauto_t9_blue_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_fullauto_t9_blue_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_fullauto_t9_blue_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_fullauto_t9_purple_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_fullauto_t9_purple_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_fullauto_t9_purple_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_fullauto_t9_orange_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_fullauto_t9_orange_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_fullauto_t9_orange_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_46137706e84fd10e");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_6b417bbaff220784");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_722e68f0aec8f63");
  }

  if(!is_true(getgametypesetting(#"hash_1456b26ab6d295ef"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_revolver_t9_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_revolver_t9_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_revolver_t9_white_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_revolver_t9_white_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_revolver_t9_white_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_revolver_t9_green_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_revolver_t9_green_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_revolver_t9_green_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_revolver_t9_blue_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_revolver_t9_blue_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_revolver_t9_blue_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_revolver_t9_purple_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_revolver_t9_purple_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_revolver_t9_purple_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_revolver_t9_orange_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_revolver_t9_orange_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_revolver_t9_orange_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_6e599b756b1482d3");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_6e7f2d6bf29196f3");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_9cfa0b458e2a870");
  }

  if(!is_true(getgametypesetting(#"hash_7fd1ff1f0b2dc779"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_semiauto_t9_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_semiauto_t9_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_semiauto_t9_white_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_semiauto_t9_white_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_semiauto_t9_white_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_semiauto_t9_green_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_semiauto_t9_green_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_semiauto_t9_green_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_semiauto_t9_blue_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_semiauto_t9_blue_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_semiauto_t9_blue_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_semiauto_t9_purple_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_semiauto_t9_purple_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_semiauto_t9_purple_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_semiauto_t9_orange_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_semiauto_t9_orange_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"pistol_semiauto_t9_orange_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_352d77559d328ff9");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_578576238b6cc4e9");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_3c4ac72e4daf6046");
  }

  if(!is_true(getgametypesetting(#"hash_61b10205e83c5849"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"shotgun_fullauto_t9_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"shotgun_fullauto_t9_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"shotgun_fullauto_t9_white_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"shotgun_fullauto_t9_white_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"shotgun_fullauto_t9_white_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"shotgun_fullauto_t9_green_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"shotgun_fullauto_t9_green_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"shotgun_fullauto_t9_green_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"shotgun_fullauto_t9_blue_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"shotgun_fullauto_t9_blue_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"shotgun_fullauto_t9_blue_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"shotgun_fullauto_t9_purple_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"shotgun_fullauto_t9_purple_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"shotgun_fullauto_t9_purple_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"shotgun_fullauto_t9_orange_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"shotgun_fullauto_t9_orange_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"shotgun_fullauto_t9_orange_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_1238206d42f56bb7");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_5a2fc4dcd77182c7");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_5b1fbf329992009c");
  }

  if(!is_true(getgametypesetting(#"hash_36996ba5b37104c9"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"shotgun_pump_t9_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"shotgun_pump_t9_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"shotgun_pump_t9_white_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"shotgun_pump_t9_white_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"shotgun_pump_t9_white_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"shotgun_pump_t9_green_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"shotgun_pump_t9_green_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"shotgun_pump_t9_green_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"shotgun_pump_t9_blue_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"shotgun_pump_t9_blue_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"shotgun_pump_t9_blue_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"shotgun_pump_t9_purple_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"shotgun_pump_t9_purple_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"shotgun_pump_t9_purple_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"shotgun_pump_t9_orange_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"shotgun_pump_t9_orange_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"shotgun_pump_t9_orange_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_2b64ba20f741c03");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_694c6b5c798cff83");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_2f8b985821ed6180");
  }

  if(!is_true(getgametypesetting(#"hash_1b556d0ef1bd7a36"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"shotgun_semiauto_t9_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"shotgun_semiauto_t9_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"shotgun_semiauto_t9_white_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"shotgun_semiauto_t9_white_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"shotgun_semiauto_t9_white_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"shotgun_semiauto_t9_green_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"shotgun_semiauto_t9_green_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"shotgun_semiauto_t9_green_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"shotgun_semiauto_t9_blue_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"shotgun_semiauto_t9_blue_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"shotgun_semiauto_t9_blue_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"shotgun_semiauto_t9_purple_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"shotgun_semiauto_t9_purple_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"shotgun_semiauto_t9_purple_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"shotgun_semiauto_t9_orange_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"shotgun_semiauto_t9_orange_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"shotgun_semiauto_t9_orange_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_1fb9cb69c31e6a64");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_2853c33ed2e0d9fa");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_1def269957739d71");
  }

  if(!is_true(getgametypesetting(#"hash_75dc05dded650042"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_accurate_t9_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_accurate_t9_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_accurate_t9_white_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_accurate_t9_white_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_accurate_t9_white_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_accurate_t9_green_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_accurate_t9_green_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_accurate_t9_green_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_accurate_t9_blue_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_accurate_t9_blue_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_accurate_t9_blue_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_accurate_t9_purple_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_accurate_t9_purple_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_accurate_t9_purple_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_accurate_t9_orange_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_accurate_t9_orange_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_accurate_t9_orange_upgraded_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_4e946885bf06df52"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_burst_t9_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_burst_t9_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_burst_t9_white_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_burst_t9_white_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_burst_t9_white_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_burst_t9_green_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_burst_t9_green_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_burst_t9_green_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_burst_t9_blue_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_burst_t9_blue_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_burst_t9_blue_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_burst_t9_purple_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_burst_t9_purple_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_burst_t9_purple_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_burst_t9_orange_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_burst_t9_orange_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_burst_t9_orange_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_190de4bed9fc266c");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_3632af26be7e7992");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_7980c79e0b854b19");
  }

  if(!is_true(getgametypesetting(#"hash_5dee59f4f540e800"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_capacity_t9_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_capacity_t9_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_capacity_t9_white_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_capacity_t9_white_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_capacity_t9_white_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_capacity_t9_green_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_capacity_t9_green_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_capacity_t9_green_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_capacity_t9_blue_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_capacity_t9_blue_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_capacity_t9_blue_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_capacity_t9_purple_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_capacity_t9_purple_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_capacity_t9_purple_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_capacity_t9_orange_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_capacity_t9_orange_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_capacity_t9_orange_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_4ffb12ed23fe69bc");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_125bbfb48ff7ecc2");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_6c69e4dbaa09ad49");
  }

  if(!is_true(getgametypesetting(#"hash_634569782c55f196"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_fastfire_t9_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_fastfire_t9_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_fastfire_t9_white_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_fastfire_t9_white_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_fastfire_t9_white_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_fastfire_t9_green_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_fastfire_t9_green_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_fastfire_t9_green_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_fastfire_t9_blue_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_fastfire_t9_blue_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_fastfire_t9_blue_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_fastfire_t9_purple_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_fastfire_t9_purple_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_fastfire_t9_purple_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_fastfire_t9_orange_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_fastfire_t9_orange_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_fastfire_t9_orange_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_5d9647113e7dae6");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_2e94c6086a29c0ec");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_31ef014e2ae18f3b");
  }

  if(!is_true(getgametypesetting(#"hash_46d3411097467f2d"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_handling_t9_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_handling_t9_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_handling_t9_white_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_handling_t9_white_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_handling_t9_white_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_handling_t9_green_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_handling_t9_green_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_handling_t9_green_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_handling_t9_blue_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_handling_t9_blue_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_handling_t9_blue_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_handling_t9_purple_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_handling_t9_purple_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_handling_t9_purple_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_handling_t9_orange_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_handling_t9_orange_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_handling_t9_orange_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_3ab4f01a7d75a711");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_4c4912d1dd882191");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_7dcc56eb54028fe");
  }

  if(!is_true(getgametypesetting(#"hash_7880919be865d57b"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_heavy_t9_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_heavy_t9_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_heavy_t9_white_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_heavy_t9_white_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_heavy_t9_white_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_heavy_t9_green_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_heavy_t9_green_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_heavy_t9_green_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_heavy_t9_blue_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_heavy_t9_blue_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_heavy_t9_blue_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_heavy_t9_purple_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_heavy_t9_purple_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_heavy_t9_purple_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_heavy_t9_orange_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_heavy_t9_orange_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_heavy_t9_orange_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_7a800082b5280041");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_380f2ea00bb391e1");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_609793136b8e90ce");
  }

  if(!is_true(getgametypesetting(#"hash_7889914479f048a1"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_spray_t9_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_spray_t9_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_spray_t9_white_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_spray_t9_white_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_spray_t9_white_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_spray_t9_green_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_spray_t9_green_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_spray_t9_green_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_spray_t9_blue_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_spray_t9_blue_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_spray_t9_blue_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_spray_t9_purple_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_spray_t9_purple_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_spray_t9_purple_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_spray_t9_orange_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_spray_t9_orange_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_spray_t9_orange_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_2116e38be200ebf7");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_2cf14ec3050af307");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_16b627cf86c11bdc");
  }

  if(!is_true(getgametypesetting(#"hash_7e967deb0d6b9649"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_standard_t9_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_standard_t9_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_standard_t9_white_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_standard_t9_white_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_standard_t9_white_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_standard_t9_green_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_standard_t9_green_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_standard_t9_green_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_standard_t9_blue_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_standard_t9_blue_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_standard_t9_blue_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_standard_t9_purple_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_standard_t9_purple_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_standard_t9_purple_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_standard_t9_orange_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_standard_t9_orange_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smg_standard_t9_orange_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_551ca3818f740355");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_7043729826e48415");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_35514f9d12f4fdaa");
  }

  if(!is_true(getgametypesetting(#"hash_4f1f179b0cd480f1"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_cannon_t9_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_cannon_t9_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_cannon_t9_white_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_cannon_t9_white_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_cannon_t9_white_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_cannon_t9_green_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_cannon_t9_green_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_cannon_t9_green_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_cannon_t9_blue_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_cannon_t9_blue_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_cannon_t9_blue_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_cannon_t9_purple_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_cannon_t9_purple_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_cannon_t9_purple_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_cannon_t9_orange_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_cannon_t9_orange_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_cannon_t9_orange_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_39cfa9ec04309821");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_49fe183faaff7881");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_350fd28d36691cee");
  }

  if(!is_true(getgametypesetting(#"hash_5db80c269fca68d2"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_accurate_t9_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_accurate_t9_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_accurate_t9_white_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_2be63ea50aeb81e1");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_accurate_t9_white_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_accurate_t9_green_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_accurate_t9_green_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_accurate_t9_green_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_accurate_t9_blue_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_accurate_t9_blue_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_accurate_t9_blue_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_accurate_t9_purple_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_accurate_t9_purple_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_accurate_t9_purple_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_accurate_t9_orange_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_accurate_t9_orange_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_accurate_t9_orange_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_7410ab94b8b2a056");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_38d1418112ad647c");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_665c51533a75f70b");
  }

  if(!is_true(getgametypesetting(#"hash_430002f66a3fd19b"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_powersemi_t9_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_powersemi_t9_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_powersemi_t9_white_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_powersemi_t9_white_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_powersemi_t9_white_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_powersemi_t9_green_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_powersemi_t9_green_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_powersemi_t9_green_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_powersemi_t9_blue_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_powersemi_t9_blue_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_powersemi_t9_blue_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_powersemi_t9_purple_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_powersemi_t9_purple_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_powersemi_t9_purple_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_powersemi_t9_orange_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_powersemi_t9_orange_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_powersemi_t9_orange_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_11dfe0da85e74745");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_5f17e8e02529f6a5");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_7711eee758908f3a");
  }

  if(!is_true(getgametypesetting(#"hash_7db8d2ae05b98ba1"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_quickscope_t9_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_quickscope_t9_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_quickscope_t9_white_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_quickscope_t9_white_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_quickscope_t9_white_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_quickscope_t9_green_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_quickscope_t9_green_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_quickscope_t9_green_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_quickscope_t9_blue_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_quickscope_t9_blue_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_quickscope_t9_blue_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_quickscope_t9_purple_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_quickscope_t9_purple_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_quickscope_t9_purple_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_quickscope_t9_orange_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_quickscope_t9_orange_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_quickscope_t9_orange_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_4cf361d49f792fed");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_46b094c2983263dd");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_1d55870eee7b1fc2");
  }

  if(!is_true(getgametypesetting(#"hash_f75e8d54b6ad799"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_standard_t9_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_standard_t9_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_standard_t9_white_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_standard_t9_white_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_standard_t9_white_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_standard_t9_green_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_standard_t9_green_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_standard_t9_green_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_standard_t9_blue_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_standard_t9_blue_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_standard_t9_blue_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_standard_t9_purple_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_standard_t9_purple_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_standard_t9_purple_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_standard_t9_orange_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_standard_t9_orange_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sniper_standard_t9_orange_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_288ec9b301b6b1bd");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_11a0fb16973993cd");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_39d971c2260eebf2");
  }

  if(!is_true(getgametypesetting(#"hash_27c9278627272303"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"special_crossbow_t9_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"special_crossbow_t9_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"special_crossbow_t9_white_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"special_crossbow_t9_white_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"special_crossbow_t9_white_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"special_crossbow_t9_green_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"special_crossbow_t9_green_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"special_crossbow_t9_green_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"special_crossbow_t9_blue_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"special_crossbow_t9_blue_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"special_crossbow_t9_blue_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"special_crossbow_t9_purple_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"special_crossbow_t9_purple_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"special_crossbow_t9_purple_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"special_crossbow_t9_orange_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"special_crossbow_t9_orange_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"special_crossbow_t9_orange_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_27fbb9e5e90039ee");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_3e84e6eb62624ba4");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_44c796cccc051203");
  }

  if(!is_true(getgametypesetting(#"hash_57a94eeed5771bca"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"special_ballisticknife_t9_dw_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"special_ballisticknife_t9_dw_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"special_ballisticknife_t9_dw_white_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"special_ballisticknife_t9_dw_white_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"special_ballisticknife_t9_dw_green_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"special_ballisticknife_t9_dw_green_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"special_ballisticknife_t9_dw_blue_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"special_ballisticknife_t9_dw_blue_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"special_ballisticknife_t9_dw_purple_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"special_ballisticknife_t9_dw_purple_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"special_ballisticknife_t9_dw_orange_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"special_ballisticknife_t9_dw_orange_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_3f8b51d634b8067c");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_571d1cd8a0f2b009");
  }

  if(!is_true(getgametypesetting(#"hash_4384633993522bf4"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"special_grenadelauncher_t9_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"special_grenadelauncher_t9_blue_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"special_grenadelauncher_t9_white_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"special_grenadelauncher_t9_blue_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"special_grenadelauncher_t9_green_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"special_grenadelauncher_t9_blue_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"special_grenadelauncher_t9_blue_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"special_grenadelauncher_t9_blue_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"special_grenadelauncher_t9_purple_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"special_grenadelauncher_t9_blue_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"special_grenadelauncher_t9_orange_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"special_grenadelauncher_t9_blue_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_6e2ef2dcc7db7576");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"special_grenadelauncher_t9_blue_upgraded_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_10756ba8dff36e5a"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_damagesemi_t9_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_damagesemi_t9_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_damagesemi_t9_white_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_damagesemi_t9_white_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_damagesemi_t9_white_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_damagesemi_t9_green_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_damagesemi_t9_green_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_damagesemi_t9_green_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_damagesemi_t9_blue_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_damagesemi_t9_blue_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_damagesemi_t9_blue_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_damagesemi_t9_purple_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_damagesemi_t9_purple_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_damagesemi_t9_purple_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_damagesemi_t9_orange_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_damagesemi_t9_orange_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_damagesemi_t9_orange_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_6e9de44134fcba88");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_2874bd08c6351ae");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_29e1b8e89a63e9d");
  }

  if(!is_true(getgametypesetting(#"hash_6891ea2844c28717"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_fastburst_t9_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_fastburst_t9_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_fastburst_t9_white_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_fastburst_t9_white_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_fastburst_t9_white_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_fastburst_t9_green_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_fastburst_t9_green_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_fastburst_t9_green_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_fastburst_t9_blue_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_fastburst_t9_blue_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_fastburst_t9_blue_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_fastburst_t9_purple_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_fastburst_t9_purple_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_fastburst_t9_purple_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_fastburst_t9_orange_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_fastburst_t9_orange_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_fastburst_t9_orange_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_304d190e0d3d0fcb");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_5f7cad8521a767b");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_248dca521f5f3388");
  }

  if(!is_true(getgametypesetting(#"hash_fb69584de9657e3"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_longburst_t9_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_longburst_t9_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_longburst_t9_white_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_longburst_t9_white_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_longburst_t9_white_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_longburst_t9_green_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_longburst_t9_green_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_longburst_t9_green_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_longburst_t9_blue_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_longburst_t9_blue_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_longburst_t9_blue_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_longburst_t9_purple_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_longburst_t9_purple_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_longburst_t9_purple_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_longburst_t9_orange_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_longburst_t9_orange_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_longburst_t9_orange_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_7b49122756d14edb");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_546c9713917cdaeb");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_1f3f1d42d4901678");
  }

  if(!is_true(getgametypesetting(#"hash_1a5305df17fdcc40"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_powerburst_t9_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_powerburst_t9_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_powerburst_t9_white_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_powerburst_t9_white_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_powerburst_t9_white_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_powerburst_t9_green_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_powerburst_t9_green_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_powerburst_t9_green_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_powerburst_t9_blue_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_powerburst_t9_blue_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_powerburst_t9_blue_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_powerburst_t9_purple_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_powerburst_t9_purple_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_powerburst_t9_purple_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_powerburst_t9_orange_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_powerburst_t9_orange_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_powerburst_t9_orange_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_4d87254f53dab84e");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_656a433ad676dfc4");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_1f2b61d42aa15ca3");
  }

  if(!is_true(getgametypesetting(#"hash_4cbfbe5e677ce735"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_precisionsemi_t9_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_precisionsemi_t9_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_precisionsemi_t9_white_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_precisionsemi_t9_white_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_precisionsemi_t9_white_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_precisionsemi_t9_green_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_precisionsemi_t9_green_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_precisionsemi_t9_green_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_precisionsemi_t9_blue_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_precisionsemi_t9_blue_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_precisionsemi_t9_blue_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_precisionsemi_t9_purple_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_precisionsemi_t9_purple_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_precisionsemi_t9_purple_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_precisionsemi_t9_orange_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_precisionsemi_t9_orange_rand_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"tr_precisionsemi_t9_orange_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_57cd12d6f5f0ae89");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_6645f935003b5019");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_51e668baf5282fb6");
  }

  if(!is_true(getgametypesetting(#"hash_596181cc4de6aad0"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ww_ieu_acid_t9_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ww_ieu_electric_t9_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ww_ieu_gas_t9_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ww_ieu_plasma_t9_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ww_ieu_shockwave_t9_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ww_ieu_acid_t9_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ww_ieu_electric_t9_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ww_ieu_gas_t9_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ww_ieu_plasma_t9_upgraded_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ww_ieu_shockwave_t9_upgraded_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_6a5453075de4b0b3"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"concussion_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_22e96504754e8375"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"decoy_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_52f19cd89938e56a"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"stimshot_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_240adf6a97ca2bdc"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"cymbal_monkey_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_55a58334a47dd0cb"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"frag_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_76986c7749f63b9a"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hatchet_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_f8c884a70b46f1f"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"molotov_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_1ab1a89d032f7080"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"satchel_charge_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_5d8dd9151ffe3c3f"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"semtex_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_51b60215d13d454"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"black_hole_bomb_item_t9_sr");
  }

  if(!is_true(getgametypesetting(#"hash_2434908be5662858"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"grapple_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_48d605c9ac0d9395"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"armor_item_lv1_t9_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"armor_item_lv1_t9_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"armor_item_lv1_t9_sr");
  }

  if(!is_true(getgametypesetting(#"hash_daa01e426a57a0a"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"armor_shard_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_26dc68686741b223"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"field_upgrade_aether_shroud_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"field_upgrade_aether_shroud_1_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"field_upgrade_aether_shroud_2_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"field_upgrade_aether_shroud_3_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"field_upgrade_aether_shroud_4_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"field_upgrade_aether_shroud_5_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_4230e2ce569b5e48"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"field_upgrade_energy_mine_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"field_upgrade_energy_mine_1_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"field_upgrade_energy_mine_2_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"field_upgrade_energy_mine_3_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"field_upgrade_energy_mine_4_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"field_upgrade_energy_mine_5_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_af8083f7ea1c28b"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"field_upgrade_frost_blast_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"field_upgrade_frost_blast_1_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"field_upgrade_frost_blast_2_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"field_upgrade_frost_blast_3_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"field_upgrade_frost_blast_4_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"field_upgrade_frost_blast_5_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_77e5bcb82c95cf00"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"field_upgrade_heal_aoe_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"field_upgrade_heal_aoe_1_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"field_upgrade_heal_aoe_2_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"field_upgrade_heal_aoe_3_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"field_upgrade_heal_aoe_4_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"field_upgrade_heal_aoe_5_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_2015355bc530a7e8"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"field_upgrade_ring_of_fire_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"field_upgrade_ring_of_fire_1_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"field_upgrade_ring_of_fire_2_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"field_upgrade_ring_of_fire_3_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"field_upgrade_ring_of_fire_4_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"field_upgrade_ring_of_fire_5_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_6e7905f68c5d7bdd"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"field_upgrade_frenzied_guard_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"field_upgrade_frenzied_guard_1_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"field_upgrade_frenzied_guard_2_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"field_upgrade_frenzied_guard_3_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"field_upgrade_frenzied_guard_4_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"field_upgrade_frenzied_guard_5_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_5cedd3fe49a8b4e1"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"field_upgrade_toxic_growth_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"field_upgrade_toxic_growth_1_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"field_upgrade_toxic_growth_2_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"field_upgrade_toxic_growth_3_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"field_upgrade_toxic_growth_4_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"field_upgrade_toxic_growth_5_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_1fc262f0136c2814"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"field_upgrade_lightning_links_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"field_upgrade_lightning_links_1_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"field_upgrade_lightning_links_2_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"field_upgrade_lightning_links_3_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"field_upgrade_lightning_links_4_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"field_upgrade_lightning_links_5_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_6c0eea959e1beea9"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"item_survival_deadshot");
  }

  if(!is_true(getgametypesetting(#"hash_4a821fd3ce297dbb"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"item_survival_elemental_pop");
  }

  if(!is_true(getgametypesetting(#"hash_350adc73849f66ad"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"item_survival_juggernog");
  }

  if(!is_true(getgametypesetting(#"hash_790760c24def02df"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"item_survival_quickrevive");
  }

  if(!is_true(getgametypesetting(#"hash_3ad94f36f9fe01c3"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"item_survival_speedcola");
  }

  if(!is_true(getgametypesetting(#"hash_1eae2946efd5fc50"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"item_survival_staminup");
  }

  if(!is_true(getgametypesetting(#"hash_21f347fcb9fbef2a"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"item_survival_tombstone");
  }

  if(!is_true(getgametypesetting(#"hash_616a22c5c1ebe5b8"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"item_survival_mulekick");
  }

  if(!is_true(getgametypesetting(#"hash_45fa8995b51490e8"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"item_survival_deathperception");
  }

  if(!is_true(getgametypesetting(#"hash_4b8929fb898a9e80"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"item_survival_phdslider");
  }

  if(!is_true(getgametypesetting(#"hash_7ead02dd6721f46a"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"brainrot_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_10de3b1cea667398"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"napalmburst_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_66cad2a554f4d928"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"deadwire_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_54537cc749c2001d"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"cryofreeze_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_2537d92585f4fce2"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"shatterblast_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_538641f0b1aebc8c"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"aether_tool_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_7b0522e8455161b3"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"resource_item_harvesting_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"resource_item_medium_harvesting_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"resource_item_small_harvesting_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_680f19a3118e2c48");
  }

  if(!is_true(getgametypesetting(#"hash_e62f83d1be06913"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"item_survival_scorestreak_artillery_strike");
  }

  if(!is_true(getgametypesetting(#"hash_115a6ae50a238213"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"item_survival_scorestreak_bow");
  }

  if(!is_true(getgametypesetting(#"hash_6a0b096c6bbfd5eb"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"item_survival_scorestreak_chopper_gunner");
  }

  if(!is_true(getgametypesetting(#"hash_5bffbdd0ee4c82ed"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"item_survival_scorestreak_remote_missile");
  }

  if(!is_true(getgametypesetting(#"hash_58c821bc828f5ebe"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"item_survival_scorestreak_deathmachine");
  }

  if(!is_true(getgametypesetting(#"hash_72ad1c2b51381a57"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"item_survival_scorestreak_flamethrower");
  }

  if(!is_true(getgametypesetting(#"hash_4cec0e29a8901e65"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"item_survival_scorestreak_hand_cannon");
  }

  if(!is_true(getgametypesetting(#"zmenablescorestreaknapalmstrike"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"item_survival_scorestreak_napalm_strike");
  }

  if(!is_true(getgametypesetting(#"hash_3c47218eb5aa98c9"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"item_survival_scorestreak_pineapple_gun");
  }

  if(!is_true(getgametypesetting(#"hash_7edbf65b1ef09118"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"item_survival_scorestreak_ultimate_turret");
  }

  if(!is_true(getgametypesetting(#"hash_45aec06707484fef"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"item_survival_scorestreak_arcxd");
  }

  if(!is_true(getgametypesetting(#"hash_294ddd2442e040f4"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"scrap_item_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"scrap_item_harvesting_sr");
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"scrap_rare_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_3e70ce2c501807dc"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"self_revive_sr_item");
  }

  if(!is_true(getgametypesetting(#"hash_c6635a2daea5f19"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_9ead5435b1f7051");
  }

  if(!is_true(getgametypesetting(#"hash_7da80c21d54c06fe"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_357391843c5cf84c");
  }

  if(!is_true(getgametypesetting(#"hash_5288d81f40e45f48"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"hash_124596f306f098a");
  }

  if(!is_true(getgametypesetting(#"hash_3f800fdfdeecf1a4"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"acog_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_e2896eee66cc912"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"barrel_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_7bc197f18ad9c160"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"barrel2_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_33dfbf870d70dcff"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"compensator_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_160f3f7bd6c73057"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"compensator2_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_68113c8c43f83f21"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"dualoptic_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_569740eb69009df4"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"elo_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_23a116036c0c1772"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"elo2_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_23a117036c0c1925"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"elo3_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_332bb2baad5b58ff"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"extclip_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_4e9980349237e457"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"extclip2_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_56993805c86d5f25"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"fastreload_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_13b948d391d89415"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"fastreload2_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_196d0df204447726"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"grip_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_78c5c63d405656fc"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"grip2_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_4c45273c674d9ee4"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"handle_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_672081a388e4e5a2"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"handle2_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_3e5289b2695c4ca9"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"heavy_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_428c952907d62b61"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"heavy2_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_5b33393a60d164e"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"holo_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_37d48bb6639008a1"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"ir_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_7af999d88a5c3e9e"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"light_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_525f16f31abe7e44"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"light2_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_2c3ed1049b2a9bb8"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"mixbarrel_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_5958b4d3a9664b7e"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"mixbarrel2_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_6fd518232d24ffe0"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"mixbody_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_2c17d5c5b5deb1d6"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"mixbody2_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_2626d22dd381efe2"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"mixclip_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_55e6f3de65ca7e70"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"mixclip2_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_5fa8eb8092935d4a"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"mixhandle_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_1f65a3791067d2e8"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"mixhandle2_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_6bedad625441f5f9"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"mixmuzzle_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_26d369152c14a7f1"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"mixmuzzle2_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_40f536a8f29d74ba"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"mixstock_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_7e206914418d0318"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"mixstock2_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_170998bbdeb41682"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"mixunder_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_5965373b6c028d10"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"mixunder2_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_ffe306b56f17a7b"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"quickdraw_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_1e668f64bc52ca0b"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"quickdraw2_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_235cec66e8d6bee4"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"reddot_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_27bb3c5a1198d400"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"reflex_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_1bfbbf0be6b090f6"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"reflex2_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_1bfbc00be6b092a9"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"reflex3_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_1bfbc10be6b0945c"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"reflex4_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_62cadb1ee561ae0d"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"scope3x_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_62c0d91ee5595622"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"scope4x_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_7bf18814d3e2c8f7"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smoothzoom_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_7e3300640a5b26bf"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"smoothzoom2_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_40c823219ff89d55"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"speedgrip_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_cb11922d3737605"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"speedgrip2_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_5cb59df3a875fa4e"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sprintout_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_7e95e1074078a0b4"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"sprintout2_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_64433bd5b95b8e2"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"stalker_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_3b9cbac29f690970"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"stalker2_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_2b42adb78f8dd85"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"steadyaim_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_110289ee8ee0bdf5"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"steadyaim2_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_1ff9ab7a376254f4"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"suppressed_t9_item_sr");
  }

  if(!is_true(getgametypesetting(#"hash_379326ac1c160c72"))) {
    namespace_1c7b37c6::item_remover(var_87d0eef8, #"suppressed2_t9_item_sr");
  }
}