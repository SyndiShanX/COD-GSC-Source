/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\highway\highway_anim.gsc
***********************************************/

init_anims() {
  level_anims_script_model();
  level_anims_player();
  level_anims_vehicles();
  level_anims_generic_human();
}

#using_animtree("script_model");

level_anims_script_model() {
  level.scr_animtree["level_oilPump"] = #animtree;
  level.scr_anim["level_oilPump"]["level_oilPumpIdle"][0] = % hod_me_machinery_oil_pumpjack_01;
  var_0 = ride_getgatetypes();
  var_1 = ride_getgateanimations();

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];
    var_4 = var_1[var_2];
    level.scr_animtree["HOD_intro_truck_gate_" + var_3] = #animtree;
    level.scr_model["HOD_intro_truck_gate_" + var_3] = "ygb_hse_d_carport_gate_a";
    level.scr_anim["HOD_intro_truck_gate_" + var_3]["ride"] = var_4;
  }

  level.scr_animtree["ride_vehicle"] = #animtree;
  level.scr_model["ride_vehicle"] = "veh8_mil_lnd_pindia";
  level.scr_anim["ride_vehicle"]["ride"] = % hod_intro_truck_truck;
  level.scr_animtree["intro_animatedPlankCrate"] = #animtree;
  level.scr_model["intro_animatedPlankCrate"] = "military_radio_crate_01";
  level.scr_anim["intro_animatedPlankCrate"]["intro_plankEnter"] = % hod_intro_plank_walk_up_crate;
  level.scr_animtree["intro_animatedPhone"] = #animtree;
  level.scr_model["intro_animatedPhone"] = "offhand_wm_cellphone_old_on";
  level.scr_anim["intro_animatedPhone"]["intro_phoneIdleA"][0] = % hod_intro_rooftop_idlea_ally04_phone;
  level.scr_anim["intro_animatedPhone"]["intro_phoneEnter"] = % hod_intro_rooftop_scene_ally04_phone;
  level.scr_anim["intro_animatedPhone"]["intro_phoneIdleB"][0] = % hod_intro_rooftop_idle_ally04_phone;
  level.scr_animtree["intro_animatedHadirSniper"] = #animtree;
  level.scr_weapon["intro_animatedHadirSniper"] = ["hadir_sniper"];
  var_5 = intro_getstairscrateanimations();

  for(var_6 = 0; var_6 < var_5.size; var_6++) {
    level.scr_animtree["intro_animatedStairsCrate" + var_6] = #animtree;
    level.scr_model["intro_animatedStairsCrate" + var_6] = "container_ammo_box_small_animated";
    level.scr_anim["intro_animatedStairsCrate" + var_6]["intro_stairsEnter"] = var_5[var_6];
  }

  var_7 = intro_getcinderblockanimations();

  for(var_6 = 0; var_6 < var_7.size; var_6++) {
    level.scr_animtree["intro_animatedCinderblock" + var_6] = #animtree;
    level.scr_model["intro_animatedCinderblock" + var_6] = "cinderblock_01_02";
    level.scr_anim["intro_animatedCinderblock" + var_6]["intro_cinderblockEnter"] = var_7[var_6];
  }

  level.scr_animtree["intro_animatedCinderblockSledgehammer"] = #animtree;
  level.scr_model["intro_animatedCinderblockSledgehammer"] = "misc_wm_sledgehammer";
  level.scr_anim["intro_animatedCinderblockSledgehammer"]["intro_cinderblockIdleA"][0] = % hod_intro_rooftop_idlea_sledgehammer;
  level.scr_anim["intro_animatedCinderblockSledgehammer"]["intro_cinderblockEnter"] = % hod_intro_rooftop_scene_sledgehammer;
  level.scr_anim["intro_animatedHadirSniper"]["intro_hadirIdle"][0] = % hod_intro_hadir_roof_idlea_hadir_rifle;
  level.scr_anim["intro_animatedHadirSniper"]["roof_sceneAEnter"] = % hod_intro_hadir_roof_scenea_hadir_rifle;
  level.scr_anim["intro_animatedHadirSniper"]["roof_sceneAIdle"][0] = % hod_intro_hadir_roof_idleb_hadir_rifle;
  level.scr_anim["intro_animatedHadirSniper"]["roof_sceneANag"] = % hod_intro_hadir_roof_naga_hadir_rifle;
  level.scr_anim["intro_animatedHadirSniper"]["roof_sceneBEnter"] = % hod_intro_hadir_roof_sceneb_hadir_rifle;
  level.scr_goaltime["intro_animatedHadirSniper"]["roof_sceneBEnter"] = 0.1;
  level.scr_animtree["intro_animatedFarahScope"] = #animtree;
  level.scr_model["intro_animatedFarahScope"] = "weapon_wm_scope_kilo98_v2";
  level.scr_anim["intro_animatedFarahScope"]["roof_sceneCEnter"] = % hod_intro_hadir_roof_scenec_farah_scope;
  level.scr_anim["intro_animatedFarahScope"]["roof_sceneCIdle"][0] = % hod_intro_hadir_roof_idleb_farah_scope;
  level.scr_animtree["tutorial_primaryTarget"] = #animtree;
  level.scr_model["tutorial_primaryTarget"] = "container_water_jug_01_light_green_distant";
  level.scr_anim["tutorial_primaryTarget"]["tutorial_targetEnter"] = % hod_tut_water_jug_prop01;
  level.scr_animtree["trap_IED"] = #animtree;
  level.scr_model["trap_IED"] = "weapon_wm_bomb_ied";
  level.scr_anim["trap_IED"]["trap_placeIED"] = % hod_trap_car_bomb_bomb;
  level.scr_animtree["mortars_backpack"] = #animtree;
  level.scr_model["mortars_backpack"] = "prop_black_backpack";
  level.scr_anim["mortars_backpack"]["mortars_enter"] = % hod_mortars_backpack_enter;
  level.scr_anim["mortars_backpack"]["mortars_fire"] = % hod_mortars_backpack_fire;
  level.scr_anim["mortars_backpack"]["mortars_idle"][0] = % hod_mortars_backpack_idle;
  level.scr_anim["mortars_backpack"]["mortars_react"] = % hod_mortars_backpack_react;
  level.scr_animtree["mortars_mortar"] = #animtree;
  level.scr_model["mortars_mortar"] = "misc_wm_mortar";
  level.scr_anim["mortars_mortar"]["mortars_enter"] = % hod_mortars_enter_mortar;
  level.scr_anim["mortars_mortar"]["mortars_fire"] = % hod_mortars_fire_mortar;
  level.scr_anim["mortars_mortar"]["mortars_idle"][0] = % hod_mortars_idle_mortar;
  level.scr_anim["mortars_mortar"]["mortars_react"] = % hod_mortars_react_mortar;
  level.scr_animtree["restock_farahIED"] = #animtree;
  level.scr_model["restock_farahIED"] = "weapon_wm_bomb_ied_bomb";
  level.scr_anim["restock_farahIED"]["restock_enter"] = % hod_ied_setup_enter_farah_bomb;
  level.scr_animtree["restock_hadirIED"] = #animtree;
  level.scr_model["restock_hadirIED"] = "weapon_wm_bomb_ied_bomb";
  level.scr_anim["restock_hadirIED"]["restock_enter"] = % hod_ied_setup_enter_hadir_bomb;
  level.scr_animtree["level_hadirGasMask"] = #animtree;
  level.scr_model["level_hadirGasMask"] = "prop_gasmask";
  level.scr_anim["level_hadirGasMask"]["crash_exit"] = % hod_gas_truck_exit_gasmask;
  level.scr_animtree["crash_board"] = #animtree;
  level.scr_model["crash_board"] = "hardware_plywood_bare_01_48_hod";
  level.scr_anim["crash_board"]["crash_enter"] = % hod_gas_truck_plywood;
  level.scr_anim["crash_board"]["crash_exit"] = % hod_gas_truck_exit_plywood;
  level.scr_animtree["drag_playerGasMask"] = #animtree;
  level.scr_model["drag_playerGasMask"] = "Prop_child_hadir_gas_mask";
  level.scr_anim["drag_playerGasMask"]["drag_enter"] = % hod_hadir_player_drag_gasmask;
  level.scr_animtree["bunker_farahBox"] = #animtree;
  level.scr_model["bunker_farahBox"] = "box_wooden_grenade_02";
  level.scr_anim["bunker_farahBox"]["bunker_enter"] = % hod_bunker_enter_box;
}

#using_animtree("player");

level_anims_player() {
  level.scr_animtree["player_rig"] = #animtree;
  level.scr_model["player_rig"] = "viewhands_alex_fullbody";
  level.scr_anim["player_rig"]["ride_camera"] = % hod_intro_truck_camera;
  level.scr_anim["player_rig"]["ride"] = % hod_intro_truck_player;
  level.scr_anim["player_rig"]["bunker_sceneBEnter"] = % hod_bunker_sceneb_player;
  level.scr_anim["player_rig"]["crash_enter"] = % hod_gas_truck_plr;
  level.scr_anim["player_rig"]["drag_enter"] = % hod_hadir_player_drag_plr;
}

#using_animtree("vehicles");

level_anims_vehicles() {
  level.scr_anim["trap_vehicle"]["trap_placeIED"] = % hod_trap_car_bomb_car;
  level.scr_animtree["level_hadirTruck"] = #animtree;
  level.scr_anim["level_hadirTruck"]["crash_enter"] = % hod_gas_truck_tailgate;
  level.scr_anim["level_hadirTruck"]["crash_exit"] = % hod_gas_truck_exit_zuniform;
}

#using_animtree("generic_human");

level_anims_generic_human() {
  level.scr_animtree["farah"] = #animtree;
  level.scr_animtree["hadir"] = #animtree;
  level.scr_anim["farah"]["ride"] = % hod_intro_truck_scenea_farah;
  level.scr_anim["ride_animatedDriverAlly"]["ride"] = % hod_intro_truck_driver;
  level.scr_anim["ride_animatedGateAlly0"]["ride"] = % hod_intro_truck_guard01;
  level.scr_anim["ride_animatedGateAlly1"]["ride"] = % hod_intro_truck_guard02;
  level.scr_anim["ride_animatedAlexAlly"]["ride"] = % hod_intro_truck_alex;
  scripts\common\anim::addnotetrack_customfunction("farah", "farah_dismount", ::custom_fov, "ride");
  scripts\common\anim::addnotetrack_mayhemstart("farah", "mayhem_start", %hod_intro_truck_farah_face, "ride", 1);
  scripts\common\anim::addnotetrack_mayhemend("farah", "mayhem_end", %hod_intro_truck_farah_face, "ride", 1);
  level.scr_anim["intro_animatedPlankAlly0"]["intro_plankEnter"] = % hod_intro_plank_walk_up_civ01;
  level.scr_anim["intro_animatedPlankAlly1"]["intro_plankEnter"] = % hod_intro_plank_walk_up_civ02;
  level.scr_anim["intro_animatedPhoneAlly"]["intro_phoneIdleA"][0] = % hod_intro_rooftop_idlea_ally04;
  level.scr_anim["intro_animatedPhoneAlly"]["intro_phoneEnter"] = % hod_intro_rooftop_scene_ally04;
  level.scr_anim["intro_animatedPhoneAlly"]["intro_phoneIdleB"][0] = % hod_intro_rooftop_idle_ally04;
  level.scr_anim["intro_animatedCinderblockAlly0"]["intro_cinderblockIdleA"][0] = % hod_intro_rooftop_idlea_ally02;
  level.scr_anim["intro_animatedCinderblockAlly1"]["intro_cinderblockIdleA"][0] = % hod_intro_rooftop_idlea_ally03;
  level.scr_anim["intro_animatedCinderblockAlly0"]["intro_cinderblockEnter"] = % hod_intro_rooftop_scene_ally02;
  level.scr_anim["intro_animatedCinderblockAlly1"]["intro_cinderblockEnter"] = % hod_intro_rooftop_scene_ally03;
  level.scr_anim["intro_animatedCinderblockAlly0"]["intro_cinderblockIdleB"][0] = % hod_intro_rooftop_idle_ally02;
  level.scr_anim["intro_animatedCinderblockAlly1"]["intro_cinderblockIdleB"][0] = % hod_intro_rooftop_idle_ally03;
  level.scr_anim["intro_animatedStairsAlly"]["intro_stairsEnter"] = % hod_intro_enter_ally01;
  level.scr_anim["intro_animatedStairsAlly"]["intro_stairsIdle"][0] = % hod_intro_idle_ally01;
  level.scr_anim["hadir"]["intro_hadirIdle"][0] = % hod_intro_hadir_roof_idlea_hadir;
  level.scr_anim["farah"]["intro_farahSceneA"] = % hod_intro_truck_sceneb_farah;
  level.scr_goaltime["farah"]["intro_farahSceneA"] = 0;
  level.scr_anim["farah"]["intro_farahSceneB"] = % hod_intro_enter_farah;
  level.scr_anim["farah"]["intro_farahSceneBIdle"][0] = % hod_intro_idle_farah;
  level.scr_anim["farah"]["intro_farahSceneBNag"] = % hod_intro_nag_farah;
  level.scr_anim["farah"]["intro_farahSceneC"] = % hod_intro_rooftop_enter_farah;
  level.scr_anim["farah"]["intro_farahSceneCIdle"][0] = % hod_intro_rooftop_idle_farah;
  level.scr_anim["farah"]["intro_farahSceneCNag"] = % hod_intro_rooftop_nag_farah;
  level.scr_anim["farah"]["roof_farahEnter"] = % hod_intro_hadir_roof_enter_farah;
  level.scr_anim["farah"]["roof_sceneAEnter"] = % hod_intro_hadir_roof_scenea_farah;
  level.scr_anim["hadir"]["roof_sceneAEnter"] = % hod_intro_hadir_roof_scenea_hadir;
  level.scr_anim["farah"]["roof_sceneAIdle"][0] = % hod_intro_hadir_roof_idlea_farah;
  level.scr_anim["hadir"]["roof_sceneAIdle"][0] = % hod_intro_hadir_roof_idleb_hadir;
  level.scr_anim["hadir"]["roof_sceneANag"] = % hod_intro_hadir_roof_naga_hadir;
  level.scr_anim["farah"]["roof_sceneBEnter"] = % hod_intro_hadir_roof_sceneb_farah;
  level.scr_anim["hadir"]["roof_sceneBEnter"] = % hod_intro_hadir_roof_sceneb_hadir;
  level.scr_goaltime["hadir"]["roof_sceneBEnter"] = 0.1;
  level.scr_anim["farah"]["roof_sceneBIdle"][0] = % hod_intro_hadir_roof_idlea_farah;
  level.scr_anim["hadir"]["roof_sceneBIdle"][0] = % hod_intro_hadir_roof_idlec_hadir;
  level.scr_anim["hadir"]["roof_sceneBNag"] = % hod_intro_hadir_roof_nagb_hadir;
  level.scr_anim["farah"]["roof_sceneCEnter"] = % hod_intro_hadir_roof_scenec_farah;
  level.scr_anim["hadir"]["roof_sceneCEnter"] = % hod_intro_hadir_roof_scenec_hadir;
  level.scr_anim["farah"]["roof_sceneCIdle"][0] = % hod_intro_hadir_roof_idleb_farah;
  level.scr_anim["hadir"]["roof_sceneCIdle"][0] = % hod_intro_hadir_roof_idled_hadir;
  level.scr_anim["hadir"]["roof_sceneDIdle"] = % hod_intro_hadir_roof_exit_hadir;
  level.scr_anim["tutorial_ally"]["tutorial_enter"] = % hod_flashlight_guy_scene;
  level.scr_anim["tutorial_ally"]["tutorial_idle"][0] = % hod_flashlight_guy_idle;
  level.scr_anim["tutorial_ally"]["tutorial_targetEnter"] = % hod_tut_water_jug_ally01;
  level.scr_anim["convoy_enemy0"]["convoy_enter"] = % hod_convoy_carbomb_alq01;
  level.scr_anim["convoy_enemy1"]["convoy_enter"] = % hod_convoy_carbomb_intro_alq02;
  level.scr_anim["convoy_enemy2"]["convoy_enter"] = % hod_convoy_carbomb_alq03;
  level.scr_anim["convoy_enemy1"]["convoy_idle"][0] = % hod_convoy_carbomb_idle_alq02;
  level.scr_anim["convoy_enemy1"]["convoy_exit"] = % hod_convoy_carbomb_alq02;
  level.scr_anim["assassinate_enemy0"]["assassinate_enter"] = % hod_assassinate_rooftop_scout01;
  level.scr_anim["assassinate_enemy1"]["assassinate_enter"] = % hod_assassinate_rooftop_scout02;
  level.scr_anim["assassinate_enemy0"]["assassinate_idle"][0] = % hod_assassinate_rooftop_idle_scout01;
  level.scr_anim["assassinate_enemy1"]["assassinate_idle"][0] = % hod_assassinate_rooftop_idle_scout02;
  level.scr_anim["assassinate_enemy0"]["assassinate_react"] = % hod_assassinate_rooftop_react_scout01;
  level.scr_anim["assassinate_enemy1"]["assassinate_react"] = % hod_assassinate_rooftop_react_scout02;
  level.scr_anim["trap_IEDAlly0"]["trap_placeIED"] = % hod_trap_car_bomb_ally01;
  level.scr_anim["trap_IEDAlly1"]["trap_placeIED"] = % hod_trap_car_bomb_ally02;
  level.scr_anim["mortar_ai0"]["mortars_enter"] = % hod_mortars_enter_aq1;
  level.scr_anim["mortar_ai1"]["mortars_enter"] = % hod_mortars_enter_aq2;
  level.scr_anim["mortar_ai0"]["mortars_fire"] = % hod_mortars_fire_aq1;
  level.scr_anim["mortar_ai1"]["mortars_fire"] = % hod_mortars_fire_aq2;
  level.scr_anim["mortar_ai0"]["mortars_idle"][0] = % hod_mortars_idle_aq1;
  level.scr_anim["mortar_ai1"]["mortars_idle"][0] = % hod_mortars_idle_aq2;
  level.scr_anim["mortar_ai0"]["mortars_react"] = % hod_mortars_react_aq1;
  level.scr_anim["mortar_ai1"]["mortars_react"] = % hod_mortars_react_aq2;
  level.scr_anim["suicide_driver"]["suicide_driverIdle"][0] = % reb_vh_techo_driver_idle_combat01;
  level.scr_anim["suicide_driver"]["suicide_driverDeath"] = % emb_def_truck_driver_death;
  level.scr_anim["level_redShirt"]["restock_enter"] = % hod_ied_setup_ally_arrival;
  level.scr_anim["level_redShirt"]["restock_idle"][0] = % hod_ied_setup_ally_idle;
  level.scr_anim["level_redShirt"]["restock_exit"] = % hod_ied_setup_ally_exit;
  level.scr_anim["farah"]["restock_enter"] = % hod_ied_setup_enter_farah;
  level.scr_anim["farah"]["restock_idle"][0] = % hod_ied_setup_idle_farah;
  level.scr_anim["farah"]["restock_exit"] = % hod_ied_setup_exit_farah;
  level.scr_anim["hadir"]["restock_enter"] = % hod_ied_setup_enter_hadir;
  level.scr_anim["hadir"]["restock_idle"][0] = % hod_ied_setup_idle_hadir;
  level.scr_anim["hadir"]["restock_exit"] = % hod_ied_setup_exit_hadir;
  level.scr_anim["radio_ally"]["radio_allyEnterIdle"][0] = % hod_radio_operator_sniped_idle_ally01;
  level.scr_anim["radio_ally"]["radio_allyEnter"] = % hod_radio_operator_sniped_ally01;
  level.scr_anim["radio_ally"]["radio_allyIdle"][0] = % hod_radio_operator_sniped_idleb_ally01;
  level.scr_anim["radio_ally"]["radio_allyDeath"] = % hod_radio_operator_sniped_death_ally01;
  level.scr_anim["hadir"]["crash_enter"] = % hod_gas_truck_intro_hadir;
  level.scr_anim["hadir"]["crash_exit"] = % hod_gas_truck_exit_hadir;
  level.scr_anim["gas_dyingAI1"]["gas_dying"] = % htf_ff_020_gasattack_attack_wh01;
  level.scr_anim["gas_dyingAI2"]["gas_dying"] = % htf_ff_020_gasattack_attack_wh02;
  level.scr_anim["gas_dyingAI3"]["gas_dying"] = % htf_ff_020_gasattack_attack_wh03;
  level.scr_anim["gas_dyingAI10"]["gas_dying"] = % htf_ff_020_gasattack_attack_civ01;
  level.scr_anim["gas_dyingAI20"]["gas_dying"] = % htf_ff_020_gasattack_attack_civ02;
  level.scr_anim["gas_dyingAI30"]["gas_dying"] = % htf_ff_020_gasattack_attack_civ03;
  level.scr_anim["gas_dyingAI40"]["gas_dying"] = % htf_ff_020_gasattack_attack_civ04;
  level.scr_anim["gas_dyingAI50"]["gas_dying"] = % htf_ff_020_gasattack_attack_civ05;
  level.scr_anim["gas_dyingAI60"]["gas_dying"] = % htf_ff_020_gasattack_attack_civ06;
  level.scr_anim["gas_dyingAI70"]["gas_dying"] = % htf_ff_020_gasattack_attack_civ07;
  level.scr_anim["gas_dyingAI80"]["gas_dying"] = % hod_yard_010_death_enemy_02;
  level.scr_anim["gas_dyingAI90"]["gas_dying"] = % hod_yard_010_death_enemy_03;
  level.scr_anim["gas_dyingAI100"]["gas_dying"] = % hod_yard_010_death_enemy_04;
  level.scr_anim["hadir"]["gas_enter"] = % hod_bunker_intro_hadir;
  level.scr_anim["hadir"]["gas_idle"][0] = % hod_bunker_intro_idle_hadir;
  level.scr_anim["hadir"]["gas_nag"] = % hod_bunker_intro_nag_hadir;
  level.scr_anim["farah"]["gas_enter"] = % hod_bunker_intro_farah;
  level.scr_anim["farah"]["gas_idle"][0] = % hod_bunker_intro_idle_farah;
  level.scr_anim["hadir"]["drag_enter"] = % hod_hadir_player_drag_hadir;
  level.scr_anim["hadir"]["bunker_enter"] = % hod_bunker_enter_hadir;
  level.scr_anim["hadir"]["bunker_sceneAEnter"] = % hod_bunker_scenea_hadir;
  level.scr_anim["hadir"]["bunker_sceneAIdle"][0] = % hod_bunker_scenea_idle_hadir;
  level.scr_anim["hadir"]["bunker_sceneANag"] = % hod_bunker_scenea_nag_hadir;
  level.scr_anim["hadir"]["bunker_sceneBEnter"] = % hod_bunker_sceneb_hadir;
  level.scr_anim["farah"]["bunker_enter"] = % hod_bunker_enter_farah;
  level.scr_anim["farah"]["bunker_sceneAEnter"] = % hod_bunker_scenea_farah;
  level.scr_anim["farah"]["bunker_sceneAIdle"][0] = % hod_bunker_scenea_idle_farah;
  level.scr_anim["farah"]["bunker_sceneBEnter"] = % hod_bunker_sceneb_farah;
  level.scr_face["farah"]["dx_vom_far_intro_joke_10"] = % dx_vom_far_intro_joke_10_face;
  level.scr_face["farah"]["dx_vom_far_intro_joke_30"] = % dx_vom_far_intro_joke_30_face;
  level.scr_face["farah"]["dx_vom_far_intro_joke_50"] = % dx_vom_far_intro_joke_50_face;
  level.scr_face["farah"]["dx_vom_far_intro_joke_70"] = % dx_vom_far_intro_joke_70_face;
  level.scr_face["farah"]["dx_vom_far_intro_joke_90"] = % dx_vom_far_intro_joke_90_face;
  level.scr_face["farah"]["dx_vom_far_intro_gun_70"] = % dx_vom_far_intro_gun_70_face;
  level.scr_face["farah"]["dx_vom_far_intro_gun_90"] = % dx_vom_far_intro_gun_90_face;
  level.scr_face["hadir"]["dx_vom_had_intro_gun_80"] = % dx_vom_had_intro_gun_80_face;
  level.scr_face["hadir"]["dx_vom_had_intro_gun_120"] = % dx_vom_had_intro_gun_120_face;
  level.scr_face["farah"]["dx_vom_far_intro_village_104"] = % dx_vom_far_intro_village_104_face;
  level.scr_face["farah"]["dx_vom_far_intro_village_105"] = % dx_vom_far_intro_village_105_face;
  level.scr_face["farah"]["dx_vom_far_intro_village_250"] = % dx_vom_far_intro_village_250_face;
  level.scr_face["farah"]["dx_vom_far_intro_village_270"] = % dx_vom_far_intro_village_270_face;
  level.scr_face["farah"]["dx_vom_far_intro_village_290"] = % dx_vom_far_intro_village_290_face;
  level.scr_face["farah"]["dx_vom_far_intro_village_190"] = % dx_vom_far_intro_village_190_face;
  level.scr_face["farah"]["dx_vom_far_intro_village_220"] = % dx_vom_far_intro_village_220_face;
  level.scr_face["farah"]["dx_vom_far_intro_village_230"] = % dx_vom_far_intro_village_230_face;
  level.scr_face["farah"]["dx_vom_far_intro_village_240"] = % dx_vom_far_intro_village_240_face;
  level.scr_face["farah"]["dx_vom_far_intro_rooftop_80"] = % dx_vom_far_intro_rooftop_80_face;
  level.scr_face["farah"]["dx_vom_far_intro_rooftop_100"] = % dx_vom_far_intro_rooftop_100_face;
  level.scr_face["farah"]["dx_vom_far_intro_rooftop_110"] = % dx_vom_far_intro_rooftop_110_face;
  level.scr_face["farah"]["dx_vom_far_intro_rooftop_120"] = % dx_vom_far_intro_rooftop_120_face;
  level.scr_face["farah"]["dx_vom_far_sniper_combat_81"] = % dx_vom_far_sniper_combat_81_face;
  level.scr_face["farah"]["dx_vom_far_sniper_combat_88"] = % dx_vom_far_sniper_combat_88_face;
  level.scr_face["farah"]["dx_vom_far_sniper_nags_10"] = % dx_vom_far_sniper_nags_10_face;
  level.scr_face["farah"]["dx_vom_far_sniper_nags_20"] = % dx_vom_far_sniper_nags_20_face;
  level.scr_face["farah"]["dx_vom_far_sniper_nags_30"] = % dx_vom_far_sniper_nags_30_face;
  level.scr_face["farah"]["dx_vom_far_sniper_kill_10"] = % dx_vom_far_sniper_kill_10_face;
  level.scr_face["farah"]["dx_vom_far_russian_jets_30"] = % dx_vom_far_russian_jets_30_face;
  level.scr_face["farah"]["dx_vom_far_mortar_team3_20"] = % dx_vom_far_mortar_team3_20_face;
  level.scr_face["farah"]["dx_vom_far_russian_jets_40"] = % dx_vom_far_russian_jets_40_face;
  level.scr_face["farah"]["dx_vom_far_russian_apcs_10"] = % dx_vom_far_russian_apcs_10_face;
  level.scr_face["hadir"]["dx_vom_had_gas_tailgate_80"] = % dx_vom_had_gas_tailgate_80_face;
  level.scr_face["farah"]["dx_vom_far_intro_rooftop_90"] = % dx_vom_far_intro_rooftop_90_face;
  level.scr_face["farah"]["dx_vom_far_sniper_combat_83"] = % dx_vom_far_sniper_combat_83_face;
  level.scr_face["farah"]["dx_vom_far_sniper_combat_150"] = % dx_vom_far_sniper_combat_150_face;
  level.scr_face["farah"]["dx_vom_far_sniper_combat_50"] = % dx_vom_far_sniper_combat_50_face;
  level.scr_face["farah"]["dx_vom_far_sniper_combat_42"] = % dx_vom_far_sniper_combat_42_face;
  level.scr_face["farah"]["dx_vom_far_sniper_combat_10"] = % dx_vom_far_sniper_combat_10_face;
  level.scr_face["farah"]["dx_vom_far_svbied_truck_120"] = % dx_vom_far_svbied_truck_120_face;
  level.scr_face["farah"]["dx_vom_far_mines_setup_20"] = % dx_vom_far_mines_setup_20_face;
  level.scr_face["farah"]["dx_vom_far_mines_setup_30"] = % dx_vom_far_mines_setup_30_face;
  level.scr_face["farah"]["dx_vom_far_mines_setup_40"] = % dx_vom_far_mines_setup_40_face;
  level.scr_face["farah"]["dx_vom_far_mines_setup_50"] = % dx_vom_far_mines_setup_50_face;
  level.scr_face["farah"]["dx_vom_far_mines_setup_60"] = % dx_vom_far_mines_setup_60_face;
  level.scr_face["farah"]["dx_vom_far_intro_gun_160"] = % dx_vom_far_intro_gun_160_face;
  level.scr_face["farah"]["dx_vom_far_intro_gun_165"] = % dx_vom_far_intro_gun_165_face;
  level.scr_face["farah"]["dx_vom_far_intro_gun_170"] = % dx_vom_far_intro_gun_170_face;
  level.scr_face["farah"]["dx_vom_far_sniper_radio_30"] = % dx_vom_far_sniper_radio_30_face;
  level.scr_face["farah"]["dx_vom_far_sniper_radio_40"] = % dx_vom_far_sniper_radio_40_face;
  level.scr_face["farah"]["dx_vom_far_sniper_radio_50"] = % dx_vom_far_sniper_radio_50_face;
  level.scr_face["hadir"]["dx_vom_had_mines_setup_10"] = % dx_vom_had_mines_setup_10_face;
  level.scr_face["hadir"]["dx_vom_had_resupply_ieds_10"] = % dx_vom_had_resupply_ieds_10_face;
  level.scr_face["hadir"]["dx_vom_had_resupply_ieds_20"] = % dx_vom_had_resupply_ieds_20_face;
}

custom_fov(var_0) {
  level.player lerpfovscalefactor(1, 2);
}

ride_getgatetypes() {
  return ["l", "r"];
}

#using_animtree("script_model");

intro_getstairscrateanimations() {
  return [%hod_intro_enter_ally01_crate01, %hod_intro_enter_ally01_crate02];
}

intro_getcinderblockanimations() {
  return [%hod_intro_rooftop_scene_cinderblock01, %hod_intro_rooftop_scene_cinderblock02, %hod_intro_rooftop_scene_cinderblock03];
}

ride_getgateanimations() {
  return [%hod_intro_truck_gate_l, %hod_intro_truck_gate_r];
}