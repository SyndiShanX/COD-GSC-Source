/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\zm_ping.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#namespace zm_ping;

function private autoexec __init__system__() {
  system::register(#"zm_ping", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  level.var_a0b1f787 = [];
  level.var_2d1b0ac = [];
  level.var_3cbb97 = [];
  level.var_d459a1cf = [];
  level.var_3fc6a555 = [];
  function_5ae4a10c(1, "door", #"hash_50ac7af2c5bc8257", #"hash_5f3108a8ed351288", #"ui_icon_minimap_doorbuys");
  function_5ae4a10c(11, "door");
  function_5ae4a10c(2, "debris", #"hash_14b4234423a635c0", #"hash_5e2a1ca8dc76be67", #"ui_icon_minimap_doorbuys");
  function_5ae4a10c(3, "double_door", #"hash_50ac7af2c5bc8257", #"hash_5f3108a8ed351288", #"ui_icon_minimap_doorbuys");
  function_5ae4a10c(4, "electric_door", #"hash_59bd96ed40a5975e", undefined, #"ui_icon_minimap_powerdoors");
  function_5ae4a10c(5, "power_double_door", #"hash_59bd96ed40a5975e", undefined, #"ui_icon_minimap_powerdoors");
  function_5ae4a10c(6, "intel", #"hash_1f02d183075803d9", #"zmpingitemintel", undefined, 1);
  function_5ae4a10c(12, "barricade", #"hash_6bd049dac126e3d7", undefined, #"hash_7b0c47f2b55db04c", 1, 98);
  function_5ae4a10c(array(#"p9_usa_large_ammo_crate_01", #"hash_94b3a8b935248d0"), "ammocache", #"hash_6d999ac22537eeb7", #"hash_e98c059b131f86c", #"hash_1d81c3d4a23328ba");
  function_5ae4a10c(array(#"p9_fxanim_zm_gp_dac_xmodel", #"p9_fxanim_zm_gp_dac_low_xmodel"), "pc_terminal", #"hash_393d988e963356ec", #"hash_2e657370192514b5", #"hash_5c22f831283cbe0d", 0, -20);
  function_5ae4a10c(array(#"p9_fxanim_zm_gp_wunderfizz_on_xmodel", #"hash_6e47d6576612543c"), "fizz_machine", #"hash_a8b446447be6cb5", #"hash_307d328d2ca73346", #"ui_icon_minimap_wunderfizz");
  function_5ae4a10c(array(#"p9_fxanim_zm_gp_crafting_xmodel", #"hash_15f88361c2fa15c"), "crafting_table", #"hash_27a696fe263f18f5", #"hash_4990f9c23cc9c32a", #"hash_4290c0ae929fe8c4");
  function_5ae4a10c(#"p9_fxanim_zm_gp_pap_xmodel", "pack_a_punch", #"hash_632b8df2d8b1e18b", #"hash_5e9f5daa234fe730", #"hash_154530b7f83b7426");
  function_5ae4a10c(array(#"p9_fxanim_zm_gp_armor_station_xmodel", #"hash_6847db4bdfca2dc8"), "armor_station", #"hash_9c7074e60cba94e", #"hash_51d31303312306d", #"ui_icon_minimap_armorstation", 1, -20);
  function_5ae4a10c("p9_fxanim_zm_gp_chest_01_sml_low_xmodel", "explore_chest_small", #"hash_526ea917d293160b", #"hash_69eda3d15a6035ab", #"hash_4c2e7f9c9b051d54");
  function_5ae4a10c("p9_fxanim_zm_gp_chest_01_med_low_xmodel", "explore_chest_medium", #"hash_5b83af320fbb5beb", #"hash_69eda3d15a6035ab", #"hash_4c2e7f9c9b051d54");
  function_5ae4a10c("p9_fxanim_zm_gp_chest_01_lrg_low_xmodel", "explore_chest_large", #"hash_47e5788369dfc93", #"hash_69eda3d15a6035ab", #"hash_4c2e7f9c9b051d54");
  function_5ae4a10c(#"p9_fxanim_zm_gp_chest_01_lrg_gold_xmodel", "explore_chest_gold", #"hash_607c4680a1d5e42a", #"hash_69eda3d15a6035ab", #"hash_4c2e7f9c9b051d54");
  function_5ae4a10c(array("p9_gold_surcrystal_medium_01", "p9_gold_surcrystal_medium_02", #"p9_sur_crystal_medium_01", #"p9_sur_crystal_medium_02"), "loot_pod", #"hash_786b6df51c6c7977", #"hash_2e354b187fdbfbbc", #"hash_237f8ac6e3096959");
  function_5ae4a10c(#"p9_sur_crystal_small_01", "dark_aether_crystal", #"hash_69364657a8e13bea", #"zmpingitemquest", undefined, 0, 32);
  function_5ae4a10c(#"p9_sur_essence_container", "large_essence", #"hash_1f00efce440309fb", #"zmpingitemaetherium", #"ui_icon_general_feedback_large_essence_cannister");
  function_5ae4a10c(undefined, "magicbox", #"hash_3f01b77865c1572d", #"hash_4542da19e0c104c", #"hash_5135a0345a6ece48");
  function_5ae4a10c(undefined, "wallbuy", &function_d1852e75, #"hash_5fc866a41152b3c", #"ui_icon_minimap_wallbuys");
  function_5ae4a10c(#"hash_615f17c2d8b69f96", "exfil_radio", undefined, #"hash_4e2a478df2a81e8c");
  function_5ae4a10c(array(#"p9_sur_elemental_pop", #"p9_sur_elemental_pop_off"), "perk_elemental_pop", #"hash_6d71fbf718d4b5e1", #"hash_5605b2abdf38cd4", #"ui_icon_minimap_elementalpop", 1, -20);
  function_5ae4a10c(array(#"p9_sur_machine_juggernog", #"p9_sur_machine_juggernog_off"), "perk_juggernog", #"hash_90f7c3bd3c217c4", #"hash_22f552b15fc207f8", #"ui_icon_minimap_juggernog", 1, -20);
  function_5ae4a10c(array(#"p9_sur_machine_quick_revive", #"p9_sur_machine_quick_revive_off"), "perk_quick_revive", #"hash_634c9bd3e54d280a", #"hash_1aadb875c07be53a", #"ui_icon_minimap_quickrevive", 1, -20);
  function_5ae4a10c(array(#"p9_sur_machine_speed_cola", #"p9_sur_machine_speed_cola_off"), "perk_speed_cola", #"hash_fcf3aa364c93996", #"hash_33fa52ed652faf8a", #"ui_icon_minimap_speedcola", 1, -20);
  function_5ae4a10c(array(#"p9_sur_machine_staminup", #"p9_sur_machine_staminup_off"), "perk_staminup", #"hash_199b94b5cb963ae5", #"hash_35f32b2271ef6ed7", #"ui_icon_minimap_staminup", 1, -20);
  function_5ae4a10c(array(#"p9_sur_vending_ads", #"p9_sur_vending_ads_off"), "perk_deadshot", #"hash_7c5e12190fbe93c0", #"hash_462ae51bbab3172a", #"ui_icon_minimap_deadshotdaiquiri", 1, -20);
  function_5ae4a10c(array(#"p9_sur_machine_tombstone", #"p9_sur_machine_tombstone_off"), "perk_tombstone", #"hash_10f37b608ff27f9b", #"hash_13b63b8343516b9e", #"hash_384cc4be4e840eb9", 1, -20);
  function_5ae4a10c(array(#"hash_4bee36a9434de051", #"hash_4bee33a9434ddb38", #"hash_4bee34a9434ddceb", #"hash_4bee39a9434de56a"), "tombstone_stash", #"hash_3b1c85278c23c698", undefined, #"ui_icon_general_feedback_stash");
  function_5ae4a10c(array(#"p9_sur_machine_mule_kick", #"hash_47b744b5982bc2a4", #"p9_fxanim_zm_gp_mule_kick_mod"), "perk_mule_kick", #"hash_69c36ca7036b925d", #"hash_68784da81f2a99f7", #"ui_icon_minimap_mulekick", 1, -20);
  function_5ae4a10c(array(#"p9_sur_machine_death_perception"), "perk_death_perception", #"hash_4c319044777c42e5", #"hash_4df32dcf844b0659", #"ui_icon_minimap_deathperception", 1, -20);
  function_5ae4a10c(#"p7_zm_power_up_nuke", "powerup_nuke", #"zombie/powerup_nuke", #"hash_db9d5c95dfea201", #"ui_icon_zombie_powerup_nuke_large");
  function_5ae4a10c(#"p7_zm_power_up_insta_kill", "powerup_insta_kill", #"hash_1784640b956f2f85", #"hash_504ad9537b38881f", #"ui_icon_zombie_powerup_instakill_large");
  function_5ae4a10c(#"p7_zm_power_up_max_ammo", "powerup_max_ammo", #"zombie/powerup_max_ammo", #"hash_2a901c3db306ba24", #"ui_icon_zombie_powerup_max_ammo_large");
  function_5ae4a10c(#"p7_zm_power_up_double_points", "powerup_double_points", #"hash_774207d74b355a8a", #"hash_25d360e4ab517722", #"ui_icon_zombie_powerup_double_points_large");
  function_5ae4a10c(#"p7_zm_power_up_carpenter", "powerup_carpenter", #"hash_7ee3cb05607f53f3", #"hash_23e7594539b63cb8", #"ui_icon_zombie_powerup_carpenter_large");
  function_5ae4a10c(#"p7_zm_power_up_firesale", "powerup_firesale", #"hash_2c7bc0fa0980f8f5", #"hash_365549a15c5bde23", #"ui_icon_zombie_powerup_firesale_large");
  function_5ae4a10c(#"wpn_t9_zm_perk_can_powerup", "powerup_free_perk", #"hash_165c84a677f7a58c", #"zmpingperkcan", #"ui_icon_zombie_powerup_random_perk_can_large");
  function_5ae4a10c(#"p8_zm_power_up_bonfire_sale", "powerup_bonfire_sale", undefined);
  function_5ae4a10c(#"zombie_z_money_icon", "powerup_bonus_points", #"hash_5162c283a9d6ee16", #"hash_3321e0bf2e424c30", #"ui_icon_zombie_powerup_bonus_points_large");
  function_5ae4a10c(#"p8_zm_powerup_full_power", "powerup_hero_power", #"hash_50af8943ead42bcc", #"hash_3580f779bbcaa04d", #"ui_icon_zombie_powerup_field_upgrade_large");
  function_5ae4a10c(#"p9_zm_powerup_stocking", "powerup_naughty_or_nice", #"hash_c63a666160e5343", #"hash_ebdfcb1ce94a2dc", #"ui_icon_zombie_powerup_stocking_large");
  function_5ae4a10c(#"p9_zm_powerup_clock", "powerup_cranked_pause", #"hash_4beb7d0e9dfb41f4", #"hash_2565a35b56075980", #"ui_icon_zombie_powerup_cranked_large");
  function_5ae4a10c(#"hash_31994e81355d0644", "world_event_jump_pad", #"hash_7614bf03db1c1bf8", #"hash_5b20033c44a4321f", #"hash_eb7621f8461d66b", 0, -32);
  function_5ae4a10c(#"p9_fxanim_sv_dragon_console_mod", "world_event_dragon_head", #"hash_33a048b0781a38c8", #"hash_5b20033c44a4321f", #"hash_60e316ebd207430", 0, -500);
  function_5ae4a10c(#"p7_zm_ctl_deathray_sphere", "world_event_orb_follow", #"hash_77ca1dab94ef928f", #"hash_76483333c5c6984", #"hash_4598f61bd8fb7947");
  function_5ae4a10c(#"p9_zm_radio_pack_01_surface", "world_event_horde_hunt", #"hash_5bc748f665dac8a4", #"hash_5b20033c44a4321f", #"hash_23f095c979f39d9a");
  function_5ae4a10c(#"rus_radio_05", "world_event_radio_tuning", #"hash_4dc4d41c22a526c6", #"hash_5b20033c44a4321f", #"hash_72e6c7a164d73a8d");
  function_5ae4a10c(#"rus_radio_backpack_01_b", "world_event_amplifier", #"hash_103c75dc7a21b891", #"hash_5b20033c44a4321f", #"hash_72e6c7a164d73a8d");
  function_5ae4a10c(array(#"p9_sur_crystal_medium_01_orange", #"p9_sur_crystal_medium_02_orange"), "world_event_monster_house", #"hash_2ada18a5a09b2150", #"hash_2e354b187fdbfbbc", #"hash_237f8ac6e3096959");
  function_5ae4a10c(#"p9_fxanim_zm_gp_chest_01_lrg_black_xmodel", "world_event_black_chest", #"hash_3704fa0bf24407c2", #"hash_5b20033c44a4321f", #"hash_102649046bcfedd1");
  function_5ae4a10c(#"hash_7a7aadfb584e0859", "world_event_black_chest_swarm", #"hash_1af19c8f09575317", #"hash_76483333c5c6984", #"hash_16fe2add4180ac0", 0, -100);
  function_5ae4a10c(#"hash_698f8c105a349a42", "platinum_klaus_hand", #"hash_4e85ae5f5e2418f4", #"hash_5b20033c44a4321f", #"hash_605a95c3bb95cae8", 0, 0);
  function_5ae4a10c(#"hash_6ceeb1e8c8e22a40", "fizz_machine", #"hash_a8b446447be6cb5", #"hash_307d328d2ca73346", #"ui_icon_minimap_wunderfizz");
  function_5ae4a10c(#"p9_fxanim_zm_gp_wunderfizz_off_xmodel", "fizz_machine", #"hash_a8b446447be6cb5", #"hash_307d328d2ca73346", #"ui_icon_minimap_wunderfizz");
  function_5ae4a10c(#"p8_wz_ep_fishing_pole", "fishing", #"hash_37f2a930f03bac8c", #"hash_5b20033c44a4321f", #"hash_3495a362a9bca583", 0, -32);
  function_5ae4a10c(#"p9_sur_essence_container_orange", "round_accelerant", #"hash_20fd9d10230088d", #"hash_5b20033c44a4321f", #"ui_icon_zm_minimap_rampage_inducer", 0, 0);
  function_5ae4a10c(array(#"p9_sur_machine_phd_slider"), "perk_phd_slider", #"hash_79fbaba94cc08a3d", #"hash_2be744903390f195", #"ui_icon_minimap_phdslider", 1, -20);
  function_5ae4a10c(#"p9_fxanim_zm_tungsten_pn_full_mod", "aetherium_neutralizer", #"hash_348e920f379ab2a8", undefined, #"hash_541d134aef3a5f87", 1, 0);
  function_5ae4a10c(undefined, "mimic_prop_spawn");
  clientfield::register("scriptmover", "" + # "hash_dfecc4e02f58398", 1, 3, "int", &function_3ed2984b, 0, 0);
  clientfield::register("zbarrier", "" + # "hash_dfecc4e02f58398", 1, 2, "int", &function_1bcf5171, 0, 0);
}

function function_3ed2984b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self.var_fc558e74 = level.var_a0b1f787[bwastimejump];
}

function function_1bcf5171(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self.var_fc558e74 = level.var_a0b1f787[10 + bwastimejump];
}

function function_5ae4a10c(modelname, targetname, displayname, var_7382ea8b, icon, var_b5a47119 = 0, zoffset = 0) {
  if(isarray(modelname)) {
    foreach(item in modelname) {
      function_5ae4a10c(item, targetname, displayname, var_7382ea8b, icon);
    }

    return;
  }

  if(isDefined(modelname)) {
    level.var_a0b1f787[modelname] = targetname;
  }

  if(isDefined(level.var_2d1b0ac[targetname]) && isDefined(displayname)) {
    assert(level.var_2d1b0ac[targetname] == displayname, "<dev string:x38>");
  }

  if(isDefined(displayname)) {
    level.var_2d1b0ac[targetname] = displayname;
  }

  if(isDefined(var_7382ea8b)) {
    level.var_3cbb97[targetname] = var_7382ea8b;
  }

  if(isDefined(icon)) {
    level.var_f8c1279b[targetname] = icon;
  }

  level.var_d459a1cf[targetname] = var_b5a47119;
  level.var_3fc6a555[targetname] = zoffset;
}

function private function_d1852e75(ent) {
  assert(isDefined(ent.var_ed875153), "<dev string:x71>");
  return ent.var_ed875153;
}