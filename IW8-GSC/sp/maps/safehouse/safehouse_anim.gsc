/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\safehouse\safehouse_anim.gsc
************************************************/

init_anim() {
  init_anim_script_model();
  init_anim_player();
  init_anim_vehicles();
  init_anim_dog();
  init_anim_generic_human();
}

#using_animtree("script_model");

init_anim_script_model() {
  level.scr_animtree["level_farahAnimatedBackpack"] = #animtree;
  level.scr_model["level_farahAnimatedBackpack"] = "prop_black_backpack";
  level.scr_animtree["level_barkovWeapon"] = #animtree;
  level.scr_weapon["level_barkovWeapon"] = ["iw8_pi_golf21"];
  level.scr_animtree["level_playerSilencer"] = #animtree;
  level.scr_model["level_playerSilencer"] = "attachment_wm_oil_filter_suppressor";
  level.scr_anim["level_playerSilencer"]["level_playerSilencer1"] = % sh_035_vm_suppressor_filter;
  level.scr_anim["level_playerSilencer"]["level_playerSilencer2"] = % sh_037_vm_motorcycle_suppressor_filter;
  level.scr_animtree["intro_flare"] = #animtree;
  level.scr_model["intro_flare"] = "misc_wm_flarestick";
  level.scr_anim["intro_flare"]["intro_enter"] = % sh_disguise_intro_scenea_flare;
  level.scr_animtree["intro_bomb"] = #animtree;
  level.scr_model["intro_bomb"] = "bomb_farah_weapon_wm_ied";
  level.scr_anim["intro_bomb"]["intro_enter"] = % sh_disguise_intro_scenea_bomb;
  level.scr_anim["intro_bomb"]["intro_idle"][0] = % sh_disguise_intro_idlea_bomb;
  level.scr_anim["intro_bomb"]["tunnels_sceneA"] = % sh_disguise_intro_sceneb_bomb;
  level.scr_animtree["tunnels_mattress"] = #animtree;
  level.scr_anim["tunnels_mattress"]["tunnels_sceneA"] = % sh_disguise_intro_sceneb_mattress;
  level.scr_anim["disguise_farahFoldedScarf"]["tunnels_sceneB"] = % sh_disguise_intro_scenec_farah_foldedscarf;
  level.scr_animtree["disguise_playerScarf"] = #animtree;
  level.scr_model["disguise_playerScarf"] = "vm_civ_me_clothing_white_headscarf_patterned_fullwrap";
  level.scr_anim["disguise_playerScarf"]["disguise_exit"] = % sh_disguise_intro_scened_plr_headscarf;
  level.scr_animtree["disguise_playerFoldedScarf"] = #animtree;
  level.scr_anim["disguise_playerFoldedScarf"]["disguise_exit"] = % sh_disguise_intro_scened_plr_foldedscarf;
  level.scr_animtree["disguise_curtain"] = #animtree;
  level.scr_anim["disguise_curtain"]["tunnels_sceneB"] = % sh_disguise_intro_scenec_curtain01;
  level.scr_anim["disguise_curtain"]["disguise_idle"][0] = % sh_disguise_intro_idlec_curtain01;
  level.scr_anim["disguise_curtain"]["disguise_exit"] = % sh_disguise_intro_scened_curtain01;
  level.scr_anim["disguise_curtain"]["holster_idle"][0] = % sh_disguise_intro_idled_curtain01;
  level.scr_animtree["disguise_farahFoldedScarf"] = #animtree;
  level.scr_anim["disguise_farahFoldedScarf"]["disguise_idle"][0] = % sh_disguise_intro_idlec_farah_foldedscarf;
  level.scr_anim["disguise_farahFoldedScarf"]["disguise_nag"] = % sh_disguise_intro_nagc_farah_foldedscarf;
  level.scr_anim["disguise_farahFoldedScarf"]["disguise_exit"] = % sh_disguise_intro_scened_farah_foldedscarf;
  level.scr_animtree["holster_door"] = #animtree;
  level.scr_anim["holster_door"]["holster_exit"] = % sh_disguise_intro_exit_door;
  level.scr_animtree["level_civilianWorkerCinderblock"] = #animtree;
  level.scr_model["level_civilianWorkerCinderblock"] = "construction_worldmodel_cinderblock_01";
  level.scr_anim["level_civilianWorkerCinderblock"]["level_civilianWorkerUnload"] = % sh_030_cinderblocks_scenea_brick01;
  level.scr_animtree["escape_door"] = #animtree;
  level.scr_anim["escape_door"]["escape_sceneA"] = % sh_032_alley_takedown_scene_door;
  var_0 = escape_getcinderblockanimations();

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    level.scr_animtree["escape_civilianCinderblock" + var_1] = #animtree;
    level.scr_model["escape_civilianCinderblock" + var_1] = "construction_worldmodel_cinderblock_01";
    level.scr_anim["escape_civilianCinderblock" + var_1]["escape_civilianBuilder"] = var_0[var_1];
  }

  level.scr_animtree["escape_playerCinderblock"] = #animtree;
  level.scr_model["escape_playerCinderblock"] = "construction_worldmodel_cinderblock_01";
  level.scr_anim["escape_playerCinderblock"]["escape_bullyPlayerMeleeCinderblock"] = % sh_032_alley_cinderblock_takedown_cinderblock;
  level.scr_anim["escape_playerCinderblock"]["plant_bullyPlayerMelee"] = % sh_032_alley_cinderblock_takedown_cinderblock;
  level.scr_animtree["escape_exitDoor"] = #animtree;
  level.scr_anim["escape_exitDoor"]["escape_exit"] = % sh_032_alley_takedown_exit_door;
  level.scr_animtree["takedown_door"] = #animtree;
  level.scr_anim["takedown_door"]["takedown_enter"] = % sh_040_intelhouse_scenea_door;
  level.scr_anim["takedown_door"]["takedown_breakout"] = % sh_040_intelhouse_scenea_breakout_door;
  level.scr_animtree["contacts_desk"] = #animtree;
  level.scr_anim["contacts_desk"]["contacts_enemyIdle"][0] = % est_search_desk_desk_idle;
  level.scr_animtree["cache_couch"] = #animtree;
  level.scr_anim["cache_couch"]["cache_scene"] = % sh_041_get_backpack_scenea_couch;
  level.scr_anim["level_farahAnimatedBackpack"]["cache_scene"] = % sh_041_get_backpack_scenea_backpack;
  level.scr_anim["level_farahAnimatedBackpack"]["cache_idle"][0] = % sh_041_get_backpack_idlea_backpack;
  level.scr_anim["level_farahAnimatedBackpack"]["cache_nagProximity"] = % sh_041_get_backpack_naga_backpack;
  level.scr_anim["level_farahAnimatedBackpack"]["cache_nagHolster"] = % sh_041_get_backpack_nagb_backpack;
  level.scr_anim["level_farahAnimatedBackpack"]["cache_exit"] = % sh_041_get_backpack_exit_backpack;
  level.scr_animtree["cache_door"] = #animtree;
  level.scr_anim["cache_door"]["cache_exit"] = % sh_041_get_backpack_exit_door;
  level.scr_animtree["square_hangingCrane"] = #animtree;
  level.scr_model["square_hangingCrane"] = "construction_crane_02";
  level.scr_anim["square_hangingCrane"]["square_hangingAnimation"] = % sh_051_hanging_crane_scene;
  level.scr_anim["square_hangingCrane"]["square_hangingIdleAnimation"][0] = % sh_051_hanging_crane_idle;
  level.scr_animtree["plant_playerIED"] = #animtree;
  level.scr_model["plant_playerIED"] = "bomb_farah_weapon_wm_ied";
  level.scr_anim["plant_playerIED"]["plant_playerIED"] = % sh_080_helibomb_vm_bomb;
  level.scr_animtree["plant_stairsCinderblock"] = #animtree;
  level.scr_model["plant_stairsCinderblock"] = "construction_worldmodel_cinderblock_01";
  level.scr_anim["plant_stairsCinderblock"]["plant_stairsCivilian"] = % sh_061_cinderblock_stairs_brick;
  level.scr_animtree["plant_farahBomb"] = #animtree;
  level.scr_model["plant_farahBomb"] = "weapon_wm_bomb_ied_bomb";
  level.scr_anim["plant_farahBomb"]["plant_farahBomb"] = % sh_100_bomb_plant_ied;
  level.scr_anim["level_farahAnimatedBackpack"]["plant_farahBomb"] = % sh_100_bomb_plant_backpack;
  level.scr_animtree["run_stretcher"] = #animtree;
  level.scr_model["run_stretcher"] = "tool_orange_stretcher_01";
  level.scr_anim["run_stretcher"]["run_exit"] = % sh_095_ambulance_stretcher;
  level.scr_animtree["crawl_farahBomb"] = #animtree;
  level.scr_model["crawl_farahBomb"] = "weapon_wm_bomb_ied_bomb";
  level.scr_anim["crawl_farahBomb"]["crawl_farahSceneB"] = % sh_110_bomb_truck_sceneb_bomb;
  level.scr_anim["level_farahAnimatedBackpack"]["caught_farahIntro"] = % sh_115_bomb_escape_intro_backpack;
  level.scr_anim["level_farahAnimatedBackpack"]["caught_farahIntroIdle"][0] = % sh_115_bomb_escape_idle_backpack;
  level.scr_anim["level_farahAnimatedBackpack"]["caught_farahNag"] = % sh_115_bomb_escape_nag_backpack;
  level.scr_anim["level_farahAnimatedBackpack"]["caught_farahSceneA"] = % sh_115_bomb_escape_scenea_backpack;
  level.scr_anim["level_farahAnimatedBackpack"]["caught_farahSceneB"] = % sh_115_bomb_escape_sceneb_backpack;
  level.scr_animtree["hide_door"] = #animtree;
  level.scr_anim["hide_door"]["hide_farahSceneC"] = % sh_115_bomb_detonate_exit_door;
  level.scr_animtree["carnage_farahDoor"] = #animtree;
  level.scr_anim["carnage_farahDoor"]["window_farahSceneB"] = % sh_120_massacre_alley_traversal_door;
  level.scr_anim["carnage_farahDoor"]["window_farahSceneBIdle"][0] = % sh_120_massacre_alley_idle_door;
  level.scr_anim["carnage_farahDoor"]["carnage_farahSceneA"] = % sh_120_massacre_intro_door;
  level.scr_animtree["advance_jerrican0"] = #animtree;
  level.scr_model["advance_jerrican0"] = "veh8_acc_jerry_can";
  level.scr_animtree["advance_jerrican1"] = #animtree;
  level.scr_model["advance_jerrican1"] = "veh8_acc_jerry_can";
  level.scr_anim["advance_jerrican0"]["advance_playerSceneAEnter"] = % sh_125_carnage_jerricans_scenea_can01;
  level.scr_anim["advance_jerrican1"]["advance_playerSceneAEnter"] = % sh_125_carnage_jerricans_scenea_can02;
  level.scr_anim["advance_jerrican0"]["advance_playerSceneAWalkReact"] = % sh_125_carnage_jerricans_reactb_walk_can01;
  level.scr_anim["advance_jerrican1"]["advance_playerSceneAWalkReact"] = % sh_125_carnage_jerricans_reactb_walk_can01;
  level.scr_anim["advance_jerrican0"]["advance_playerSceneAPourReact"] = % sh_125_carnage_jerricans_reacta_pour_can01;
  level.scr_anim["advance_jerrican1"]["advance_playerSceneAPourReact"] = % sh_125_carnage_jerricans_reacta_pour_can02;
  level.scr_anim["advance_jerrican0"]["advance_playerSceneAPourDeath"] = % sh_125_carnage_jerricans_death_can01;
  level.scr_anim["advance_jerrican1"]["advance_playerSceneAPourDeath"] = % sh_125_carnage_jerricans_death_can02;
  level.scr_anim["advance_jerrican0"]["advance_playerSceneBEnter"] = % sh_125_carnage_jerricans_sceneb_can01;
  level.scr_anim["advance_jerrican1"]["advance_playerSceneBEnter"] = % sh_125_carnage_jerricans_sceneb_can02;
  level.scr_anim["advance_jerrican0"]["advance_playerSceneBIdle"][0] = % sh_125_carnage_jerricans_sceneb_idle_can01;
  level.scr_anim["advance_jerrican1"]["advance_playerSceneBIdle"][0] = % sh_125_carnage_jerricans_sceneb_idle_can02;
}

escape_getcinderblockanimations() {
  return [%sh_031_cinderblocks_wall_brick01, %sh_031_cinderblocks_wall_brick02, %sh_031_cinderblocks_wall_brick03, %sh_031_cinderblocks_wall_brick04, %sh_031_cinderblocks_wall_brick05];
}

#using_animtree("player");

init_anim_player() {
  level.scr_animtree["player_rig"] = #animtree;
  level.scr_model["player_rig"] = "viewhands_alex_disguise_fullbody";
  level.scr_model["context_melee_player_rig"] = "viewhands_alex_disguise_fullbody";
  level.scr_anim["player_rig"]["level_playerSilencer1"] = % sh_035_vm_suppressor_plr;
  level.scr_anim["player_rig"]["level_playerSilencer2"] = % sh_037_vm_motorcycle_suppressor_plr;
  level.scr_anim["player_rig"]["tunnels_sceneA"] = % sh_disguise_intro_sceneb_plr;
  level.scr_anim["player_rig"]["tunnels_playerLadderAnimation"] = % thd_1f_010_vm_mantle_plr;
  level.scr_anim["player_rig"]["disguise_exit"] = % sh_disguise_intro_scened_plr;
  level.scr_anim["player_rig"]["market_bullyPlayerMelee"] = % sh_032_alley_cinderblock_takedown_plr;
  level.scr_anim["player_rig"]["escape_bullyPlayerMelee"] = % sh_032_alley_cinderblock_takedown_plr;
  level.scr_anim["player_rig"]["escape_bullyPlayerMeleeCinderblock"] = % sh_032_alley_cinderblock_takedown_plr;
  level.scr_anim["player_rig"]["escape_bullyPlayerMeleeKnife"] = % vm_sp_context_melee_stand_1_rear_player;
  level.scr_anim["player_rig"]["guarded_playerFalseSilencer"] = % sh_036_vm_no_suppressor_plr;
  level.scr_anim["player_rig"]["plant_playerIED"] = % sh_080_helibomb_vm_plr;
  level.scr_anim["player_rig"]["plant_bullyPlayerMelee"] = % sh_032_alley_cinderblock_takedown_plr;
  scripts\common\anim::addnotetrack_customfunction("player_rig", "add_fov_user_scale_override", ::plant_ied_add_fov_user_scale_override, "plant_playerIED");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "remove_fov_user_scale_override", ::plant_ied_remove_fov_user_scale_override, "plant_playerIED");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "plant_add_zplanes_override", ::plant_add_zplanes_override, "plant_playerIED");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "plant_remove_zplanes_override", ::plant_remove_zplanes_override, "plant_playerIED");
  level.scr_anim["player_rig"]["leave_exit"] = % sh_140_exfill_scene_plr;
  scripts\common\anim::addnotetrack_customfunction("player_rig", "add_fov_user_scale_override", ::leave_exit_add_fov_user_scale_override, "leave_exit");
}

#using_animtree("vehicles");

init_anim_vehicles() {
  level.scr_animtree["construction_animatedVehicle"] = #animtree;
  level.scr_anim["construction_animatedVehicle"]["construction_enter"] = % sh_025_cinderblock_split_scenea_truck;
  level.scr_animtree["run_vehicle"] = #animtree;
  level.scr_model["run_vehicle"] = "veh8_civ_lnd_palfa";
  level.scr_anim["run_vehicle"]["run_enter"] = % sh_107_truck_drive_in_ambulance;
  level.scr_anim["run_vehicle"]["run_exit"] = % sh_095_ambulance_ambulance;
  level.scr_animtree["backup_vehicle"] = #animtree;
  level.scr_model["backup_vehicle"] = "veh8_mil_lnd_umike";
  level.scr_anim["backup_vehicle"]["backup_enter"] = % sh_107_truck_drive_in_truck;
}

#using_animtree("dog");

init_anim_dog() {
  level.scr_animtree["level_cagedDog"] = #animtree;
  level.scr_anim["level_cagedDog"]["level_cagedDogIdle"][0] = % iw6_dog_casualidle;
  level.scr_anim["level_cagedDog"]["level_cagedDogGrowlIdle"][0] = % iw6_dog_attackidle;
  level.scr_anim["level_cagedDog"]["level_cagedDogDeath"] = % iw6_dog_death_6;
}

#using_animtree("generic_human");

init_anim_generic_human() {
  init_anim_generic_human_level();
  level.scr_anim["level_farah"]["intro_enter"] = % sh_disguise_intro_scenea_farah;
  level.scr_anim["level_hadir"]["intro_enter"] = % sh_disguise_intro_scenea_hadir;
  scripts\common\anim::addnotetrack_mayhemstart("level_farah", "mayhem_start", %sh_disguise_intro_scenea_farah_face, "intro_enter", 1);
  scripts\common\anim::addnotetrack_mayhemend("level_farah", "mayhem_end", %sh_disguise_intro_scenea_farah_face, "intro_enter", 1);
  level.scr_anim["level_farah"]["intro_idle"][0] = % sh_disguise_intro_idlea_farah;
  level.scr_anim["level_hadir"]["intro_idle"][0] = % sh_disguise_intro_idlea_hadir;
  level.scr_anim["level_farah"]["tunnels_sceneA"] = % sh_disguise_intro_sceneb_farah;
  level.scr_anim["level_hadir"]["tunnels_sceneA"] = % sh_disguise_intro_sceneb_hadir;
  level.scr_anim["level_uncle"]["tunnels_sceneA"] = % sh_disguise_intro_sceneb_ally01;
  level.scr_anim["level_hadir"]["tunnels_idleA"][0] = % sh_disguise_intro_idleb_hadir;
  level.scr_anim["level_hadir"]["tunnels_sceneANagA"] = % sh_disguise_intro_naga1_hadir;
  level.scr_anim["level_hadir"]["tunnels_sceneANagB"] = % sh_disguise_intro_naga2_hadir;
  level.scr_face["level_hadir"]["dx_vom_had_tunnels_explosives_20"] = % dx_vom_had_tunnels_explosives_20_face;
  level.scr_face["level_hadir"]["dx_vom_had_tunnels_explosives_40"] = % dx_vom_had_tunnels_explosives_40_face;
  scripts\common\anim::addnotetrack_mayhemstart("level_hadir", "mayhem_start", %sh_disguise_intro_sceneb_hadir_face, "tunnels_sceneA");
  scripts\common\anim::addnotetrack_mayhemend("level_hadir", "mayhem_end", %sh_disguise_intro_sceneb_hadir_face, "tunnels_sceneA");
  level.scr_anim["level_farah"]["tunnels_sceneB"] = % sh_disguise_intro_scenec_farah;
  level.scr_anim["level_uncle"]["tunnels_sceneB"] = % sh_disguise_intro_scenec_ally01;
  level.scr_anim["level_farah"]["disguise_idle"][0] = % sh_disguise_intro_idlec_farah;
  level.scr_anim["level_uncle"]["disguise_idle"][0] = % sh_disguise_intro_idlec_ally01;
  level.scr_anim["level_farah"]["disguise_nag"] = % sh_disguise_intro_nagc1_farah;
  level.scr_anim["level_farah"]["disguise_exit"] = % sh_disguise_intro_scened_farah;
  level.scr_anim["level_uncle"]["disguise_exit"] = % sh_disguise_intro_scened_ally01;
  level.scr_face["level_farah"]["dx_vom_far_disguise_scarf_20"] = % dx_vom_far_disguise_scarf_20_face;
  level.scr_face["level_farah"]["dx_vom_far_disguise_scarf_30"] = % dx_vom_far_disguise_scarf_30_face;
  level.scr_face["level_farah"]["dx_vom_far_disguise_scarf_40"] = % dx_vom_far_disguise_scarf_40_face;
  scripts\common\anim::addnotetrack_customfunction("level_farah", "disguise_intro_lerp_off", ::disguise_intro_remove_fov_user_scale, "disguise_exit");
  scripts\common\anim::addnotetrack_customfunction("level_farah", "attach_key", ::level_farahkeydetachearlylogic, "disguise_exit");
  scripts\common\anim::addnotetrack_attach("level_farah", "attach_key", "accessory_locker_key_02", "tag_accessory_right", "disguise_exit");
  scripts\common\anim::addnotetrack_mayhemstart("level_farah", "mayhem_start", %sh_disguise_intro_scened_farah_face, "disguise_exit", 1);
  scripts\common\anim::addnotetrack_mayhemend("level_farah", "mayhem_end", %sh_disguise_intro_scened_farah_face, "disguise_exit", 1);
  level.scr_anim["level_uncle"]["holster_idle"][0] = % sh_disguise_intro_idled_ally01;
  level.scr_anim["level_farah"]["holster_idle"][0] = % sh_disguise_intro_idled_farah;
  level.scr_anim["level_farah"]["holster_nag"] = % sh_disguise_intro_nagd1_farah;
  level.scr_anim["level_farah"]["holster_exit"] = % sh_disguise_intro_exit_farah;
  scripts\common\anim::addnotetrack_detach("level_farah", "detach_key", "accessory_locker_key_02", "tag_accessory_right", "holster_exit");
  level.scr_anim["market_enemy1"]["market_idle"][0] = % sh_015_marketplace_foodline_idlea_spetz01;
  level.scr_anim["market_enemy1"]["market_enter"] = % sh_015_marketplace_foodline_scenea_spetz01;
  level.scr_anim["market_civilian1"]["market_idle"][0] = % sh_015_marketplace_foodline_idlea_civ01;
  level.scr_anim["market_civilian2"]["market_idle"][0] = % sh_015_marketplace_foodline_idlea_civ02;
  level.scr_anim["market_civilian3"]["market_idle"][0] = % sh_015_marketplace_foodline_idlea_civ03;
  level.scr_anim["market_civilian4"]["market_idle"][0] = % sh_015_marketplace_foodline_idlea_civ04;
  level.scr_anim["market_civilian5"]["market_idle"][0] = % sh_015_marketplace_foodline_idlea_civ05;
  level.scr_anim["market_civilian1"]["market_enter"] = % sh_015_marketplace_foodline_scenea_civ01;
  level.scr_anim["market_civilian2"]["market_enter"] = % sh_015_marketplace_foodline_scenea_civ02;
  level.scr_anim["market_civilian3"]["market_enter"] = % sh_015_marketplace_foodline_scenea_civ03;
  level.scr_anim["market_civilian4"]["market_enter"] = % sh_015_marketplace_foodline_scenea_civ04;
  level.scr_anim["market_civilian5"]["market_enter"] = % sh_015_marketplace_foodline_scenea_civ05;
  level.scr_anim["market_civilian1"]["market_civilianReactIdle"][0] = % sh_022_marketplace_idle_civ05;
  level.scr_anim["market_civilian1"]["market_civilianReactPlayer"] = % sh_022_marketplace_react_plr_civ05;
  level.scr_anim["market_civilian1"]["market_civilianReactGun"][0] = % sh_022_marketplace_react_ads_idle_civ05;
  level.scr_goaltime["market_civilian1"]["market_civilianReactGun"] = 1.5;
  level.scr_anim["market_civilian2"]["market_civilianReactIdle"][0] = % sh_022_marketplace_idle_civ03;
  level.scr_anim["market_civilian2"]["market_civilianReactPlayer"] = % sh_022_marketplace_react_plr_civ03;
  level.scr_anim["market_civilian2"]["market_civilianReactGun"][0] = % sh_022_marketplace_react_ads_idle_civ03;
  level.scr_goaltime["market_civilian2"]["market_civilianReactGun"] = 1.5;
  level.scr_anim["market_civilian3"]["market_civilianReactIdle"][0] = % sh_022_marketplace_idle_civ04;
  level.scr_anim["market_civilian3"]["market_civilianReactPlayer"] = % sh_022_marketplace_react_plr_civ04;
  level.scr_anim["market_civilian3"]["market_civilianReactGun"][0] = % sh_022_marketplace_react_ads_idle_civ04;
  level.scr_goaltime["market_civilian3"]["market_civilianReactGun"] = 1.5;
  level.scr_anim["market_civilian4"]["market_civilianReactIdle"][0] = % sh_022_marketplace_idle_civ01;
  level.scr_anim["market_civilian4"]["market_civilianReactPlayer"] = % sh_022_marketplace_react_plr_civ01;
  level.scr_anim["market_civilian4"]["market_civilianReactGun"][0] = % sh_022_marketplace_react_ads_idle_civ01;
  level.scr_goaltime["market_civilian4"]["market_civilianReactGun"] = 1.5;
  level.scr_anim["market_civilian5"]["market_civilianReactIdle"][0] = % sh_022_marketplace_idle_civ02;
  level.scr_anim["market_civilian5"]["market_civilianReactPlayer"] = % sh_022_marketplace_react_plr_civ02;
  level.scr_anim["market_civilian5"]["market_civilianReactGun"][0] = % sh_022_marketplace_react_ads_idle_civ02;
  level.scr_goaltime["market_civilian5"]["market_civilianReactGun"] = 1.5;
  level.scr_anim["market_interiorEnemy"]["market_interior"] = % sh_nh_090_civ_glance_garage_civ01;
  level.scr_anim["market_interiorEnemy"]["market_interiorIdle"][0] = % sh_nh_090_civ_glance_garage_idle_civ01;
  level.scr_anim["market_bullyEnemy"]["market_bullyIdle"][0] = % sh_070_civ_beatdown_soldier;
  level.scr_anim["market_bullyCivilian"]["market_bullyIdle"][0] = % sh_070_civ_beatdown_civ;
  level.scr_anim["market_bullyEnemy"]["market_bullyPlayerMelee"] = % sh_032_alley_cinderblock_takedown_russ02;
  level.scr_anim["market_bullyCivilian"]["market_bullyPlayerMelee"] = % sh_070_civ_beatdown_rescue_civ;
  level.scr_anim["market_bullyCivilian"]["market_bullyExitIdle"][0] = % sh_070_civ_beatdown_rescue_civ_idle;
  level.scr_anim["construction_animatedEnemy1"]["construction_idleA"][0] = % sh_025_cinderblock_split_idlea_spetz01;
  level.scr_anim["construction_animatedEnemy2"]["construction_idleA"][0] = % sh_025_cinderblock_split_idlea_spetz02;
  level.scr_anim["construction_animatedEnemy3"]["construction_idleA"][0] = % sh_025_cinderblock_split_idlea_spetz03;
  level.scr_anim["construction_animatedCivilian"]["construction_idleA"][0] = % sh_025_cinderblock_split_idlea_civ01;
  level.scr_anim["construction_animatedVehicleCivilian"]["construction_idleA"][0] = % sh_020_marketplace_idlea_civ04;
  level.scr_anim["level_farah"]["construction_enter"] = % sh_025_cinderblock_split_scenea_farah;
  level.scr_anim["construction_animatedEnemy1"]["construction_enter"] = % sh_025_cinderblock_split_scenea_spetz01;
  level.scr_anim["construction_animatedEnemy2"]["construction_enter"] = % sh_025_cinderblock_split_scenea_spetz02;
  level.scr_anim["construction_animatedEnemy3"]["construction_enter"] = % sh_025_cinderblock_split_scenea_spetz03;
  level.scr_anim["construction_animatedCivilian"]["construction_enter"] = % sh_025_cinderblock_split_scenea_civ01;
  level.scr_anim["construction_animatedCivilian"]["construction_idleB"][0] = % sh_025_cinderblock_split_idleb_civ01;
  level.scr_anim["escape_bullyEnemy"]["escape_bullyIdle"][0] = % sh_032_alley_beatdown_intro_russ02;
  level.scr_anim["escape_bullyCivilian"]["escape_bullyIdle"][0] = % sh_032_alley_beatdown_intro_civ01;
  level.scr_face["escape_bullyCivilian"]["dx_vom_cvf1_plant_beating_40"] = % dx_vom_cvf1_plant_beating_40_face;
  level.scr_anim["level_farah"]["escape_sceneHot"] = % sh_032_hot_alley_cinderblock_takedown_farah;
  level.scr_anim["level_farah"]["escape_sceneA"] = % sh_032_alley_takedown_scenea_farah;
  level.scr_anim["escape_farahEnemy"]["escape_sceneA"] = % sh_032_alley_takedown_scenea_russ01;
  level.scr_anim["level_farah"]["escape_sceneAIdle"][0] = % sh_032_alley_takedown_scenea_idle_farah;
  level.scr_anim["level_farah"]["escape_sceneB"] = % sh_032_alley_takedown_sceneb_farah;
  level.scr_anim["escape_bullyEnemy"]["escape_sceneB"] = % sh_032_alley_takedown_sceneb_russ02;
  level.scr_anim["escape_bullyCivilian"]["escape_sceneB"] = % sh_032_alley_takedown_sceneb_civ01;
  level.scr_anim["escape_bullyEnemy"]["escape_bullyPlayerMeleeKnife"] = % vm_sp_context_melee_stand_1_rear_enemy;
  scripts\common\anim::addnotetrack_customfunction("escape_bullyEnemy", "cm_fx", ::escape_bullyenemyknifefxlogic, "escape_bullyPlayerMeleeKnife");
  level.scr_anim["escape_bullyEnemy"]["escape_bullyPlayerMeleeCinderblock"] = % sh_032_alley_cinderblock_takedown_russ02;
  level.scr_anim["escape_bullyCivilian"]["escape_bullyPlayerMelee"] = % sh_032_alley_cinderblock_takedown_civ01;
  level.scr_anim["level_farah"]["escape_bullyPlayerMelee"] = % sh_032_alley_cinderblock_takedown_farah;
  scripts\common\anim::addnotetrack_attach("level_farah", "attach_knife", "weapon_wm_me_soscar_knife", "tag_accessory_right", "escape_sceneA");
  scripts\common\anim::addnotetrack_customfunction("level_farah", "attach_knife", ::level_farahknifedetachearlylogic, "escape_sceneA");
  scripts\common\anim::addnotetrack_detach("level_farah", "detach_knife", "weapon_wm_me_soscar_knife", "tag_accessory_right", "escape_sceneB");
  scripts\common\anim::addnotetrack_detach("level_farah", "detach_knife", "weapon_wm_me_soscar_knife", "tag_accessory_right", "escape_bullyPlayerMelee");
  level.scr_anim["level_farah"]["escape_exit"] = % sh_032_alley_takedown_exit_farah;
  level.scr_goaltime["level_farah"]["escape_exit"] = 0.2;
  level.scr_anim["level_farah"]["escape_exitIdle"][0] = % sh_032_alley_takedown_sceneb_idle_farah;
  level.scr_anim["level_farah"]["escape_exitNag"] = % sh_032_alley_takedown_sceneb_nag_farah;
  level.scr_anim["escape_bullyCivilian"]["escape_exitIdle"][0] = % sh_032_alley_takedown_exit_civ01;
  level.scr_anim["escape_bullyCivilian"]["escape_bullyCivilianReactIdle"][0] = % emb_exfil_005_stacy_hostage_stacy_exitb_idle;
  level.scr_anim["escape_bullyCivilian"]["escape_bullyCivilianReactPlayer"] = % emb_exfil_005_stacy_hostage_stacy_exitb_react_plr;
  level.scr_anim["escape_bullyCivilian"]["escape_bullyCivilianReactGun"][0] = % emb_exfil_005_stacy_hostage_stacy_exitb_react_gun;
  level.scr_goaltime["escape_bullyCivilian"]["escape_bullyCivilianReactGun"] = 1.5;
  level.scr_anim["escape_civilianBuilder"]["escape_civilianBuilder"] = % sh_031_cinderblocks_wall_civ01;
  level.scr_anim["escape_civilianBuilder"]["escape_civilianBuilderIdle"][0] = % sh_022_marketplace_idle_civ06;
  level.scr_anim["escape_civilianBuilder"]["escape_civilianBuilderPlayer"] = % sh_022_marketplace_react_plr_civ06;
  level.scr_anim["escape_civilianBuilder"]["escape_civilianBuilderGun"][0] = % sh_022_marketplace_react_gun_civ06;
  level.scr_goaltime["escape_civilianBuilder"]["escape_civilianBuilderGun"] = 1.5;
  level.scr_anim["level_farah"]["guarded_enter"] = % sh_038_intelhouse_truck_enter;
  level.scr_anim["level_farah"]["guarded_idle"][0] = % sh_038_intelhouse_truck_idle;
  level.scr_anim["level_farah"]["guarded_nag"] = % sh_038_intelhouse_truck_nag2;
  level.scr_anim["level_farah"]["takedown_enter"] = % sh_040_intelhouse_scenea_farah;
  level.scr_anim["takedown_enemy"]["takedown_enter"] = % sh_040_intelhouse_scenea_aq01;
  level.scr_anim["level_farah"]["takedown_idle"][0] = % sh_040_intelhouse_idlea_farah;
  level.scr_anim["level_farah"]["takedown_breakout"] = % sh_040_intelhouse_scenea_breakout_farah;
  level.scr_anim["takedown_enemy"]["takedown_breakout"] = % sh_040_intelhouse_scenea_breakout_aq01;
  scripts\common\anim::addnotetrack_attach("level_farah", "attach_knife", "weapon_wm_me_soscar_knife", "tag_accessory_right", "takedown_enter");
  scripts\common\anim::addnotetrack_customfunction("level_farah", "attach_knife", ::level_farahknifedetachearlylogic, "takedown_enter");
  scripts\common\anim::addnotetrack_detach("level_farah", "detach_knife", "weapon_wm_me_soscar_knife", "tag_accessory_right", "takedown_enter");
  scripts\common\anim::addnotetrack_detach("level_farah", "detach_knife", "weapon_wm_me_soscar_knife", "tag_accessory_right", "takedown_breakout");
  level.scr_anim["contacts_enemy"]["contacts_enemyEnter"] = % est_search_desk_terry_arrival;
  level.scr_anim["contacts_enemy"]["contacts_enemyIdle"][0] = % est_search_desk_terry_idle;
  level.scr_anim["contacts_enemy"]["contacts_enemyExit"] = % est_search_desk_terry_exit;
  level.scr_anim["contacts_enemy"]["contacts_enemyReact"] = % est_search_desk_terry_react02;
  level.scr_anim["contacts_enemy"]["contacts_enemyDeath"] = % est_search_desk_terry_death_back;
  level.scr_anim["level_farah"]["cache_enter"] = % sh_041_get_backpack_enter_scenea_farah;
  level.scr_anim["level_farah"]["cache_scene"] = % sh_041_get_backpack_scenea_farah;
  level.scr_anim["level_farah"]["cache_idle"][0] = % sh_041_get_backpack_idlea_farah;
  level.scr_anim["level_farah"]["cache_nagProximity"] = % sh_041_get_backpack_naga_farah;
  level.scr_anim["level_farah"]["cache_nagHolster"] = % sh_041_get_backpack_nagb_farah;
  level.scr_anim["level_farah"]["cache_exit"] = % sh_041_get_backpack_exit_farah;
  scripts\common\anim::addnotetrack_detach("level_farah", "detach_key", "accessory_locker_key_02", "tag_accessory_right", "cache_exit");
  scripts\common\anim::addnotetrack_customfunction("level_farah", "attach_key", ::level_farahkeydetachearlylogic, "cache_exit");
  scripts\common\anim::addnotetrack_attach("level_farah", "attach_key", "accessory_locker_key_02", "tag_accessory_right", "cache_exit");
  level.scr_anim["level_farah"]["square_farahEnter"] = % sh_052_execution_walk_stop_farah;
  level.scr_anim["square_hangingCivilian1"]["square_hangingAnimation"] = % sh_051_hanging_civ_01_scene;
  level.scr_anim["square_hangingCivilian2"]["square_hangingAnimation"] = % sh_051_hanging_civ_02_scene;
  level.scr_anim["square_hangingCivilian3"]["square_hangingAnimation"] = % sh_051_hanging_civ_03_scene;
  level.scr_anim["square_hangingCivilian1"]["square_hangingIdleAnimation"][0] = % sh_051_hanging_civ_01_idle;
  level.scr_anim["square_hangingCivilian2"]["square_hangingIdleAnimation"][0] = % sh_051_hanging_civ_02_idle;
  level.scr_anim["square_hangingCivilian3"]["square_hangingIdleAnimation"][0] = % sh_051_hanging_civ_03_idle;
  level.scr_anim["level_farah"]["lookout_farahEnter"] = % sh_055_ladder_intro_farah;
  level.scr_anim["level_farah"]["lookout_farahIdle"][0] = % sh_055_ladder_idle_farah;
  level.scr_anim["level_farah"]["lookout_farahNag"] = % sh_055_ladder_nag_farah;
  level.scr_anim["level_farah"]["lookout_farahExit"] = % sh_060_heliland_exit_farah;
  level.scr_anim["plant_stairsCivilian"]["plant_stairsCivilian"] = % sh_061_cinderblock_stairs_civ01;
  level.scr_anim["plant_stairsCivilian"]["plant_stairsCivilianReactIdle"][0] = % sh_022_marketplace_idle_civ06;
  level.scr_anim["plant_stairsCivilian"]["plant_stairsCivilianReactPlayer"] = % sh_022_marketplace_react_plr_civ06;
  level.scr_anim["plant_stairsCivilian"]["plant_stairsCivilianReactGun"] = % sh_022_marketplace_react_gun_civ06;
  level.scr_goaltime["plant_stairsCivilian"]["plant_stairsCivilianReactGun"] = 1.5;
  level.scr_anim["plant_pilot"]["plant_pilotExit"] = % sh_060_heliland_heli_exit;
  level.scr_anim["plant_bullyEnemy"]["plant_bullyIdle"][0] = % sh_070_civ_beatdown_soldier;
  level.scr_anim["plant_bullyCivilian"]["plant_bullyIdle"][0] = % sh_070_civ_beatdown_civ;
  level.scr_anim["plant_bullyEnemy"]["plant_bullyPlayerMelee"] = % sh_032_alley_cinderblock_takedown_russ02;
  level.scr_anim["plant_bullyCivilian"]["plant_bullyPlayerMelee"] = % sh_070_civ_beatdown_rescue_civ;
  level.scr_anim["plant_bullyCivilian"]["plant_bullyExitIdle"][0] = % sh_070_civ_beatdown_rescue_civ_idle;
  level.scr_anim["level_farah"]["plant_farahBomb"] = % sh_100_bomb_plant_farah;
  level.scr_anim["level_farah"]["return_farahSceneA"] = % sh_055_ladder_intro_farah;
  level.scr_anim["level_farah"]["return_farahSceneAIdle"][0] = % sh_055_ladder_idle_farah;
  level.scr_anim["level_farah"]["return_farahSceneANag"] = % sh_055_ladder_nag_farah;
  level.scr_anim["level_farah"]["return_farahSceneB"] = % sh_092_helibomb_detonate_enter_farah;
  level.scr_anim["level_farah"]["return_farahSceneBIdle"][0] = % sh_092_helibomb_detonate_idle_farah;
  level.scr_anim["level_farah"]["return_farahSceneBNag"] = % sh_092_helibomb_detonate_nag_farah;
  level.scr_anim["level_farah"]["detonate_farahExit"] = % sh_092_helibomb_detonate_exit_farah;
  level.scr_anim["level_farah"]["run_enter"] = % sh_105_double_tap_enter_farah;
  level.scr_anim["level_farah"]["run_idle"][0] = % sh_105_double_tap_idlea_farah;
  level.scr_anim["run_enemy1"]["run_exit"] = % sh_095_ambulance_civ01;
  level.scr_anim["run_enemy2"]["run_exit"] = % sh_095_ambulance_civ02;
  level.scr_anim["level_farah"]["crawl_farahSceneA"] = % sh_110_bomb_truck_scenea_farah;
  level.scr_anim["level_farah"]["crawl_farahSceneAIdle"][0] = % sh_110_bomb_truck_scenea_idle_farah;
  level.scr_anim["level_farah"]["crawl_farahSceneB"] = % sh_110_bomb_truck_sceneb_farah;
  level.scr_anim["level_farah"]["crawl_farahSceneBIdle"][0] = % sh_110_bomb_truck_sceneb_idle_farah;
  level.scr_anim["level_farah"]["crawl_farahSceneC"] = % sh_110_bomb_truck_scenec_farah;
  level.scr_anim["level_farah"]["caught_farahIntro"] = % sh_115_bomb_escape_intro_farah;
  level.scr_anim["level_farah"]["caught_farahIntroIdle"][0] = % sh_115_bomb_escape_idle_farah;
  level.scr_anim["level_farah"]["caught_farahNag"] = % sh_115_bomb_escape_nag_farah;
  level.scr_anim["level_farah"]["caught_farahSceneA"] = % sh_115_bomb_escape_scenea_farah;
  level.scr_anim["level_farah"]["caught_farahSceneB"] = % sh_115_bomb_escape_sceneb_farah;
  level.scr_anim["level_farah"]["hide_farahSceneA"] = % sh_115_bomb_detonate_enter_farah;
  scripts\common\anim::addnotetrack_attach("level_farah", "attach_detonator", "offhand_wm_clacker", "tag_accessory_right", "hide_farahSceneA");
  level.scr_anim["level_farah"]["hide_farahSceneAIdle"][0] = % sh_115_bomb_detonate_idle_farah;
  level.scr_anim["level_farah"]["hide_farahSceneB"] = % sh_115_bomb_detonate_scene_farah;
  scripts\common\anim::addnotetrack_detach("level_farah", "detach_detonator", "offhand_wm_clacker", "tag_accessory_right", "hide_farahSceneB");
  level.scr_anim["level_farah"]["hide_farahSceneBIdle"][0] = % sh_115_bomb_detonate_idleb_farah;
  level.scr_anim["level_farah"]["hide_farahSceneC"] = % sh_115_bomb_detonate_exit_farah;
  level.scr_anim["level_farah"]["window_farahSceneA"] = % sh_120_massacre_window_enter_farah;
  level.scr_anim["level_farah"]["window_farahSceneAIdle"][0] = % sh_120_massacre_window_idle_farah;
  level.scr_anim["level_farah"]["window_farahSceneB"] = % sh_120_massacre_alley_traversal_farah;
  level.scr_anim["level_farah"]["window_farahSceneBNag"] = % sh_120_massacre_alley_nag_farah;
  level.scr_anim["level_farah"]["window_farahSceneBIdle"][0] = % sh_120_massacre_alley_idle_farah;
  level.scr_anim["level_farah"]["carnage_farahSceneA"] = % sh_120_massacre_intro_farah;
  level.scr_anim["level_farah"]["carnage_farahSceneAIdle"][0] = % sh_120_massacre_intro_idle_farah;
  level.scr_anim["level_farah"]["carnage_farahSceneANag"] = % sh_120_massacre_intro_nag_farah;
  level.scr_anim["level_farah"]["carnage_farahSceneB"] = % sh_120_massacre_get_down_farah;
  level.scr_anim["level_farah"]["carnage_farahSceneBIdle"][0] = % sh_120_massacre_down_idle;
  level.scr_anim["level_farah"]["carnage_farahSceneBExit"] = % sh_120_massacre_down_exit;
  var_0 = carnage_getenemyanimations();

  for(var_1 = 0; var_1 < var_0.size; var_1++)
    level.scr_anim["carnage_enemy"]["carnage_enemyEnter" + var_1] = var_0[var_1];

  level.scr_animtree["carnage_enemy"] = #animtree;
  var_2 = carnage_getcorpseanimations();

  for(var_1 = 0; var_1 < var_2.size; var_1++)
    level.scr_anim["carnage_corpse"]["carnage_corpse" + var_1] = var_2[var_1];

  level.scr_animtree["carnage_corpse"] = #animtree;
  level.scr_anim["advance_playerEnemy0"]["advance_playerSceneAEnter"] = % sh_125_carnage_jerricans_scenea_enemy01;
  level.scr_anim["advance_playerEnemy1"]["advance_playerSceneAEnter"] = % sh_125_carnage_jerricans_scenea_enemy02;
  level.scr_anim["advance_playerEnemy0"]["advance_playerSceneAWalkReact"] = % sh_125_carnage_jerricans_reactb_walk_enemy01;
  level.scr_anim["advance_playerEnemy1"]["advance_playerSceneAWalkReact"] = % sh_125_carnage_jerricans_reactb_walk_enemy01;
  level.scr_anim["advance_playerEnemy0"]["advance_playerSceneAPourReact"] = % sh_125_carnage_jerricans_reacta_pour_enemy01;
  level.scr_anim["advance_playerEnemy1"]["advance_playerSceneAPourReact"] = % sh_125_carnage_jerricans_reacta_pour_enemy02;
  level.scr_anim["advance_playerEnemy0"]["advance_playerSceneAPourDeath"] = % sh_125_carnage_jerricans_death_enemy01;
  level.scr_anim["advance_playerEnemy1"]["advance_playerSceneAPourDeath"] = % sh_125_carnage_jerricans_death_enemy02;
  level.scr_anim["advance_playerEnemy0"]["advance_playerSceneBEnter"] = % sh_125_carnage_jerricans_sceneb_enemy01;
  level.scr_anim["advance_playerEnemy1"]["advance_playerSceneBEnter"] = % sh_125_carnage_jerricans_sceneb_enemy02;
  level.scr_anim["advance_playerEnemy0"]["advance_playerSceneBIdle"][0] = % sh_125_carnage_jerricans_sceneb_idle_enemy01;
  level.scr_anim["advance_playerEnemy1"]["advance_playerSceneBIdle"][0] = % sh_125_carnage_jerricans_sceneb_idle_enemy02;
  level.scr_anim["advance_farahEnemy"]["advance_farahSceneAEnter"] = % sh_125_carnage_takedown_enter_enemy01;
  level.scr_anim["level_farah"]["advance_farahSceneAIdle"][0] = % sh_125_carnage_takedown_idlea_farah;
  level.scr_anim["advance_farahEnemy"]["advance_farahSceneAIdle"][0] = % sh_125_carnage_takedown_idlea_enemy01;
  level.scr_anim["level_farah"]["advance_farahSceneA"] = % sh_125_carnage_takedown_scenea_farah;
  level.scr_anim["advance_farahEnemy"]["advance_farahSceneA"] = % sh_125_carnage_takedown_scenea_enemy01;
  level.scr_anim["level_farah"]["advance_farahSceneAHot"] = % sh_125_hot_carnage_takedown_scenea_farah;
  level.scr_anim["level_farah"]["advance_farahSceneBIdle"][0] = % sh_125_carnage_takedown_idleb_farah;
  level.scr_anim["level_farah"]["advance_farahSceneB"] = % sh_125_carnage_takedown_sceneb_farah;
  scripts\common\anim::addnotetrack_attach("level_farah", "attach_knife", "weapon_wm_me_soscar_knife", "tag_accessory_left", "advance_farahSceneA");
  scripts\common\anim::addnotetrack_detach("level_farah", "detach_knife", "weapon_wm_me_soscar_knife", "tag_accessory_left", "advance_farahSceneA");
  level.scr_anim["level_farah"]["leave_enter"] = % sh_140_exfill_enter_farah;
  level.scr_anim["level_farah"]["leave_idle"][0] = % sh_140_exfill_idle_farah;
  level.scr_anim["level_farah"]["leave_exit"] = % sh_140_exfill_scene_farah;
  scripts\common\anim::addnotetrack_mayhemstart("level_farah", "mayhem_start", %sh_140_exfill_scene_farah_face, "leave_exit", 1);
  scripts\common\anim::addnotetrack_mayhemend("level_farah", "mayhem_end", %sh_140_exfill_scene_farah_face, "leave_exit", 1);
}

carnage_getenemyanimations() {
  return [%sh_125_carnage_soldier02, %sh_125_carnage_soldier03, %sh_125_carnage_soldier04, %sh_125_carnage_soldier05, %sh_125_carnage_soldier06, %sh_125_carnage_soldier07, %sh_125_carnage_soldier08];
}

carnage_getcorpseanimations() {
  return [%sh_125_carnage_deadbody01, %sh_125_carnage_deadbody02, %sh_125_carnage_deadbody03, %sh_125_carnage_deadbody04, %sh_125_carnage_deadbody05, %sh_125_carnage_deadbody06, %sh_125_carnage_deadbody07, %sh_125_carnage_deadbody09];
}

init_anim_generic_human_level() {
  level.scr_animtree["level_farah"] = #animtree;
  level.scr_animtree["level_hadir"] = #animtree;
  level.scr_anim["level_farah"]["level_farahCasualStandToPistol"] = % farah_casual_idle_to_pistol;
  level.scr_anim["level_farah"]["level_farahCasualCrouchToPistol"] = % farah_casual_crouch_to_pistol;
  level.scr_anim["level_farah"]["level_farahPistolCasualStand"] = % farah_pistol_to_casual_idle;
  init_anim_generic_human_level_civilian_worker();
  init_anim_generic_human_level_civilian_react();
  init_anim_generic_human_level_execution();
}

init_anim_generic_human_level_civilian_worker() {
  level.scr_anim["level_civilianWorkerUnloader"]["level_civilianWorkerUnload"] = % sh_030_cinderblocks_scenea_civ01;
  level.scr_anim["level_civilianWorkerUnloader"]["level_civilianWorkerUnloadIdle"][0] = % sh_030_cinderblocks_idle_civ01;
  level.scr_anim["level_civilianWorkera"]["level_civilianWorkerPickUp"] = % civ_cinderblock_guya_walk_grab_block_exit_l;
  level.scr_anim["level_civilianWorkerb"]["level_civilianWorkerPickUp"] = % civ_cinderblock_guyb_walk_grab_block_exit_l;
  level.scr_anim["level_civilianWorkerc"]["level_civilianWorkerPickUp"] = % civ_cinderblock_guyc_walk_grab_block_exit_l;
  level.scr_anim["level_civilianWorkerd"]["level_civilianWorkerPickUp"] = % civ_cinderblock_guyd_walk_grab_block_exit_l;
  level.scr_anim["level_civilianWorkera"]["level_civilianWorkerDropOff"] = % civ_cinderblock_guya_walk_drop_block_exit_l;
  level.scr_anim["level_civilianWorkerb"]["level_civilianWorkerDropOff"] = % civ_cinderblock_guyb_walk_drop_block_exit_l;
  level.scr_anim["level_civilianWorkerc"]["level_civilianWorkerDropOff"] = % civ_cinderblock_guyc_walk_drop_block_exit_l;
  level.scr_anim["level_civilianWorkerd"]["level_civilianWorkerDropOff"] = % civ_cinderblock_guyd_walk_drop_block_exit_l;
  level.scr_anim["level_civilianWorker"]["level_civilianWorkerArrivalstand"] = % sh_civ_idle_arrival_stand;
  level.scr_anim["level_civilianWorker"]["level_civilianWorkerArrivalsit"] = % sh_civ_idle_arrival_sit;
  level.scr_anim["level_civilianWorker"]["level_civilianWorkerReactIdlestand"][0] = % sh_022_marketplace_idle_civ02;
  level.scr_anim["level_civilianWorker"]["level_civilianWorkerReactPlayerstand"] = % sh_022_marketplace_react_plr_civ02;
  level.scr_anim["level_civilianWorker"]["level_civilianWorkerReactGunstand"][0] = % sh_022_marketplace_react_gun_civ02;
  level.scr_goaltime["level_civilianWorker"]["level_civilianWorkerReactGunstand"] = 1.5;
  level.scr_anim["level_civilianWorker"]["level_civilianWorkerReactIdlesit"][0] = % sh_022_marketplace_idle_civ05;
  level.scr_anim["level_civilianWorker"]["level_civilianWorkerReactPlayersit"] = % sh_022_marketplace_react_plr_civ05;
  level.scr_anim["level_civilianWorker"]["level_civilianWorkerReactGunsit"][0] = % sh_022_marketplace_react_gun_civ05;
  level.scr_goaltime["level_civilianWorker"]["level_civilianWorkerReactGunsit"] = 1.5;
}

init_anim_generic_human_level_civilian_react() {
  level.scr_anim["level_civilianReact1"]["level_civilianReactIdle"][0] = % sh_022_marketplace_idle_civ01;
  level.scr_anim["level_civilianReact1"]["level_civilianReactPlayer"] = % sh_022_marketplace_react_plr_civ01;
  level.scr_anim["level_civilianReact1"]["level_civilianReactGun"][0] = % sh_022_marketplace_react_ads_idle_civ01;
  level.scr_goaltime["level_civilianReact1"]["level_civilianReactGun"] = 1.5;
  level.scr_anim["level_civilianReact2"]["level_civilianReactIdle"][0] = % sh_022_marketplace_idle_civ02;
  level.scr_anim["level_civilianReact2"]["level_civilianReactPlayer"] = % sh_022_marketplace_react_plr_civ02;
  level.scr_anim["level_civilianReact2"]["level_civilianReactGun"][0] = % sh_022_marketplace_react_ads_idle_civ02;
  level.scr_goaltime["level_civilianReact2"]["level_civilianReactGun"] = 1.5;
  level.scr_anim["level_civilianReact3"]["level_civilianReactIdle"][0] = % sh_022_marketplace_idle_civ03;
  level.scr_anim["level_civilianReact3"]["level_civilianReactPlayer"] = % sh_022_marketplace_react_plr_civ03;
  level.scr_anim["level_civilianReact3"]["level_civilianReactGun"][0] = % sh_022_marketplace_react_ads_idle_civ03;
  level.scr_goaltime["level_civilianReact3"]["level_civilianReactGun"] = 1.5;
  level.scr_anim["level_civilianReact4"]["level_civilianReactIdle"][0] = % sh_022_marketplace_idle_civ04;
  level.scr_anim["level_civilianReact4"]["level_civilianReactPlayer"] = % sh_022_marketplace_react_plr_civ04;
  level.scr_anim["level_civilianReact4"]["level_civilianReactGun"][0] = % sh_022_marketplace_react_ads_idle_civ04;
  level.scr_goaltime["level_civilianReact4"]["level_civilianReactGun"] = 1.5;
  level.scr_anim["level_civilianReact5"]["level_civilianReactIdle"][0] = % sh_022_marketplace_idle_civ05;
  level.scr_anim["level_civilianReact5"]["level_civilianReactPlayer"] = % sh_022_marketplace_react_plr_civ05;
  level.scr_anim["level_civilianReact5"]["level_civilianReactGun"][0] = % sh_022_marketplace_react_ads_idle_civ05;
  level.scr_goaltime["level_civilianReact5"]["level_civilianReactGun"] = 1.5;
  level.scr_anim["level_civilianReact6"]["level_civilianReactIdle"][0] = % sh_022_marketplace_idle_civ06;
  level.scr_anim["level_civilianReact6"]["level_civilianReactPlayer"] = % sh_022_marketplace_react_plr_civ06;
  level.scr_anim["level_civilianReact6"]["level_civilianReactGun"][0] = % sh_022_marketplace_react_ads_idle_civ06;
  level.scr_goaltime["level_civilianReact6"]["level_civilianReactGun"] = 1.5;
}

init_anim_generic_human_level_execution() {
  level.scr_anim["level_barkov"]["level_executionSceneA"] = % sh_050_execution_scenea_barkov;
  level.scr_anim["level_barkov"]["level_executionSceneAIdle"][0] = % sh_050_execution_scenea_idle_barkov;
  level.scr_goaltime["level_barkov"]["level_executionSceneAIdle"] = 0.01;
  level.scr_anim["level_executionEnemy1"]["level_executionSceneA"] = % sh_050_execution_scenea_spetz01;
  level.scr_anim["level_executionEnemy1"]["level_executionSceneAIdle"][0] = % sh_050_execution_scenea_idle_spetz01;
  level.scr_anim["level_executionEnemy2"]["level_executionSceneA"] = % sh_050_execution_scenea_spetz02;
  level.scr_anim["level_executionEnemy2"]["level_executionSceneAIdle"][0] = % sh_050_execution_scenea_idle_spetz02;
  level.scr_anim["level_executionCivilian1"]["level_executionSceneA"] = % sh_050_execution_scenea_civ01;
  level.scr_anim["level_executionCivilian1"]["level_executionSceneAIdle"][0] = % sh_050_execution_scenea_idle_civ01;
  level.scr_anim["level_executionCivilian2"]["level_executionSceneA"] = % sh_050_execution_scenea_civ02;
  level.scr_anim["level_executionCivilian2"]["level_executionSceneAIdle"][0] = % sh_050_execution_scenea_idle_civ02;
  level.scr_anim["level_executionCivilian3"]["level_executionSceneA"] = % sh_050_execution_scenea_civ03;
  level.scr_anim["level_executionCivilian3"]["level_executionSceneAIdle"][0] = % sh_050_execution_scenea_idle_civ03;
  level.scr_anim["level_executionCivilian4"]["level_executionSceneA"] = % sh_050_execution_scenea_civ04;
  level.scr_anim["level_executionCivilian4"]["level_executionSceneAIdle"][0] = % sh_050_execution_scenea_idle_civ04;
  level.scr_anim["level_executionCivilian5"]["level_executionSceneA"] = % sh_050_execution_scenea_civ05;
  level.scr_anim["level_executionCivilian5"]["level_executionSceneAIdle"][0] = % sh_050_execution_scenea_idle_civ05;
  level.scr_anim["level_executionCivilian6"]["level_executionSceneA"] = % sh_050_execution_scenea_civ06;
  level.scr_anim["level_executionCivilian6"]["level_executionSceneAIdle"][0] = % sh_050_execution_scenea_idle_civ06;
  level.scr_anim["level_executionCivilian7"]["level_executionSceneA"] = % sh_050_execution_scenea_civ07;
  level.scr_anim["level_executionCivilian7"]["level_executionSceneAIdle"][0] = % sh_050_execution_scenea_idle_civ07;
  level.scr_anim["level_executionCivilian8"]["level_executionSceneA"] = % sh_050_execution_scenea_civ08;
  level.scr_anim["level_executionCivilian8"]["level_executionSceneAIdle"][0] = % sh_050_execution_scenea_idle_civ08;
  level.scr_anim["level_barkov"]["level_executionSceneB"] = % sh_050_execution_sceneb_barkov;
  level.scr_anim["level_barkov"]["level_executionSceneBIdle"][0] = % sh_050_execution_sceneb_idle_barkov;
  level.scr_anim["level_executionEnemy1"]["level_executionSceneB"] = % sh_050_execution_sceneb_spetz01;
  level.scr_anim["level_executionEnemy1"]["level_executionSceneBIdle"][0] = % sh_050_execution_sceneb_idle_spetz01;
  level.scr_anim["level_executionEnemy2"]["level_executionSceneB"] = % sh_050_execution_sceneb_spetz02;
  level.scr_anim["level_executionEnemy2"]["level_executionSceneBIdle"][0] = % sh_050_execution_sceneb_idle_spetz02;
  level.scr_anim["level_executionEnemy3"]["level_executionSceneB"] = % sh_050_execution_sceneb_spetz03;
  level.scr_anim["level_executionEnemy3"]["level_executionSceneBIdle"][0] = % sh_050_execution_sceneb_idle_spetz03;
  level.scr_anim["level_executionEnemy4"]["level_executionSceneB"] = % sh_050_execution_sceneb_spetz04;
  level.scr_anim["level_executionEnemy4"]["level_executionSceneBIdle"][0] = % sh_050_execution_sceneb_idle_spetz04;
  level.scr_anim["level_executionCivilian1"]["level_executionSceneB"] = % sh_050_execution_sceneb_civ01;
  level.scr_anim["level_executionCivilian1"]["level_executionSceneBIdle"][0] = % sh_050_execution_sceneb_idle_civ01;
  level.scr_anim["level_executionCivilian2"]["level_executionSceneB"] = % sh_050_execution_sceneb_civ02;
  level.scr_anim["level_executionCivilian2"]["level_executionSceneBIdle"][0] = % sh_050_execution_sceneb_idle_civ02;
  level.scr_anim["level_executionCivilian3"]["level_executionSceneB"] = % sh_050_execution_sceneb_civ03;
  level.scr_anim["level_executionCivilian3"]["level_executionSceneBIdle"][0] = % sh_050_execution_sceneb_idle_civ03;
  level.scr_anim["level_executionCivilian4"]["level_executionSceneB"] = % sh_050_execution_sceneb_civ04;
  level.scr_anim["level_executionCivilian4"]["level_executionSceneBIdle"][0] = % sh_050_execution_sceneb_idle_civ04;
  level.scr_anim["level_executionCivilian5"]["level_executionSceneB"] = % sh_050_execution_sceneb_civ05;
  level.scr_anim["level_executionCivilian5"]["level_executionSceneBIdle"][0] = % sh_050_execution_sceneb_idle_civ05;
  level.scr_anim["level_executionCivilian6"]["level_executionSceneB"] = % sh_050_execution_sceneb_civ06;
  level.scr_anim["level_executionCivilian6"]["level_executionSceneBIdle"][0] = % sh_050_execution_sceneb_idle_civ06;
  level.scr_anim["level_executionCivilian7"]["level_executionSceneB"] = % sh_050_execution_sceneb_civ07;
  level.scr_anim["level_executionCivilian7"]["level_executionSceneBIdle"][0] = % sh_050_execution_sceneb_idle_civ07;
  level.scr_anim["level_executionCivilian8"]["level_executionSceneB"] = % sh_050_execution_sceneb_civ08;
  level.scr_anim["level_executionCivilian8"]["level_executionSceneBIdle"][0] = % sh_050_execution_sceneb_idle_civ08;
  level.scr_anim["level_barkov"]["level_executionSceneC"] = % sh_050_execution_scenec_barkov;
  level.scr_anim["level_barkov"]["level_executionSceneCIdle"][0] = % sh_050_execution_scenec_idle_barkov;
  level.scr_anim["level_executionCivilian1"]["level_executionSceneC"] = % sh_050_execution_scenec_civ01;
  scripts\common\anim::addnotetrack_customfunction("level_executionCivilian1", "kill", scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardremovecivilian);
  level.scr_anim["level_executionCivilian2"]["level_executionSceneC"] = % sh_050_execution_scenec_civ02;
  scripts\common\anim::addnotetrack_customfunction("level_executionCivilian2", "kill", scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardremovecivilian);
  level.scr_anim["level_executionCivilian3"]["level_executionSceneC"] = % sh_050_execution_scenec_civ03;
  scripts\common\anim::addnotetrack_customfunction("level_executionCivilian3", "kill", scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardremovecivilian);
  level.scr_anim["level_executionCivilian4"]["level_executionSceneC"] = % sh_050_execution_scenec_civ04;
  scripts\common\anim::addnotetrack_customfunction("level_executionCivilian4", "kill", scripts\sp\maps\safehouse\safehouse_guard.gsc::level_guardremovecivilian);
  level.scr_anim["level_executionCivilian5"]["level_executionSceneC"] = % sh_050_execution_scenec_civ05;
  level.scr_anim["level_executionCivilian5"]["level_executionSceneCIdle"][0] = % sh_050_execution_scenec_idle_civ05;
  level.scr_anim["level_executionCivilian6"]["level_executionSceneC"] = % sh_050_execution_scenec_civ06;
  level.scr_anim["level_executionCivilian6"]["level_executionSceneCIdle"][0] = % sh_050_execution_scenec_idle_civ06;
  level.scr_anim["level_executionCivilian7"]["level_executionSceneC"] = % sh_050_execution_scenec_civ07;
  level.scr_anim["level_executionCivilian7"]["level_executionSceneCIdle"][0] = % sh_050_execution_scenec_idle_civ07;
  level.scr_anim["level_executionCivilian8"]["level_executionSceneC"] = % sh_050_execution_scenec_civ08;
  level.scr_anim["level_executionCivilian8"]["level_executionSceneCIdle"][0] = % sh_050_execution_scenec_idle_civ08;
}

level_farahkeydetachearlylogic(var_0) {
  var_0 endon("death");
  var_0 endon("entitydeleted");
  thread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_notifyonnotetrack(var_0, "detach_key");
  var_0 endon("detach_key");
  var_0 waittill("level_guardFight");
  var_0 detach("accessory_locker_key_02", "tag_accessory_right");
}

level_farahknifedetachearlylogic(var_0) {
  var_0 endon("death");
  var_0 endon("entitydeleted");
  thread scripts\sp\maps\safehouse\safehouse_utility.gsc::animation_notifyonnotetrack(var_0, "detach_knife");
  var_0 endon("detach_knife");
  var_0 scripts\engine\utility::waittill_any("level_guardFight", "level_farahKnifeDetach");
  var_0 detach("weapon_wm_me_soscar_knife", "tag_accessory_right");
}

escape_bullyenemyknifefxlogic(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  playFXOnTag(scripts\engine\utility::getfx("vfx_contextmelee_stab"), var_0, "j_neck");
}

plant_ied_add_fov_user_scale_override(var_0) {
  level.player lerpfovscalefactor(0, 0.6);
}

plant_ied_remove_fov_user_scale_override(var_0) {
  level.player lerpfovscalefactor(1, 0.8);
}

leave_exit_add_fov_user_scale_override(var_0) {
  level.player lerpfovscalefactor(0, 1);
}

disguise_intro_remove_fov_user_scale(var_0) {
  level.player lerpfovscalefactor(1, 1);
}

plant_add_zplanes_override(var_0) {
  if(level.player ispcplayer()) {
    level.og_zplanes = getDvar("OMNONNMOTP");
    setsaveddvar("OMNONNMOTP", "0.1 500 2.5 10000");
  }
}

plant_remove_zplanes_override(var_0) {
  if(level.player ispcplayer() && isDefined(level.og_zplanes)) {
    setsaveddvar("OMNONNMOTP", level.og_zplanes);
    level.og_zplanes = undefined;
  }
}