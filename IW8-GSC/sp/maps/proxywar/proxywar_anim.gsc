/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\proxywar\proxywar_anim.gsc
***********************************************/

main() {
  level.player.animname = "player";
  player();
  humans();
  script_models();
  vehicles();
}

#using_animtree("player");

player() {
  level.scr_anim["player_rig"]["bink_intro"] = % pw_infil_010_fastrope_idle_plr;
  level.scr_anim["player_rig"]["infil_player"] = % pw_infil_010_fastrope_plr;
  scripts\common\anim::addnotetrack_customfunction("player_rig", "fieldofview_open", ::fov_open, "infil_player");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "fieldofview_close", ::fov_close, "infil_player");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "remove_fov_user_scale_override", ::infil_remove_fov_user_scale_override, "infil_player");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "on_rope", ::player_on_fast_rope, "infil_player");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "end_rope_rumble", ::end_rope_rumble, "infil_player");
  level.scr_anim["player_rig"]["turn_on_power"] = % pxw_whs_060_button_plr_handle;
  level.scr_anim["player_rig"]["try_door_button"] = % pxw_whs_040_search_button_fail_plr;
  level.scr_anim["player_rig"]["swab"] = % pw_swab_010_plr;
  scripts\common\anim::addnotetrack_customfunction("player_rig", "add_fov_user_scale_override", ::swab_add_fov_user_scale_override, "swab");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "remove_fov_user_scale_override", ::swab_remove_fov_user_scale_override, "swab");
  level.scr_anim["player_rig"]["convoy_rollout"] = % pw_exit_010_ambush_plr_scene;
  level.scr_anim["player_rig"]["trucks_stolen"] = % pw_rpg_010_wakeup_plr;
  level.scr_goaltime["player_rig"]["trucks_stolen"] = 0;
  scripts\common\anim::addnotetrack_customfunction("player_rig", "start_drag_rumble", ::start_drag_rumble, "trucks_stolen");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "stop_drag_rumble", ::stop_drag_rumble, "trucks_stolen");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "enable_springcam", ::enable_springcam, "trucks_stolen");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "remove_player_gasmask", ::remove_player_gasmask, "trucks_stolen");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "switch_to_bodydouble", ::switch_to_bodydouble, "trucks_stolen");
  scripts\common\anim::addnotetrack_notify("player_rig", "show_cinematic_bars", "show_cinematic_bars", "trucks_stolen");
}

#using_animtree("generic_human");

humans() {
  level.scr_anim["stub_char"]["stub_idle"][0] = % sdr_cbq_interior_idle;
  level.scr_anim["body_double"]["infil_player"] = % pw_infil_010_fastrope_alex_3rd;
  scripts\common\anim::addnotetrack_mayhemstart("body_double", "mayhem_start", %pw_infil_010_fastrope_alex_3rd_face, "infil_player");
  scripts\common\anim::addnotetrack_mayhemend("body_double", "mayhem_end", %pw_infil_010_fastrope_alex_3rd_face, "infil_player");
  level.scr_anim["commander"]["infil_heli_player"] = % pw_infil_010_fastrope_chiefa;
  level.scr_anim["alpha1"]["infil"] = % pw_infil_010_fastrope_ally01;
  level.scr_anim["alpha2"]["infil"] = % pw_infil_010_fastrope_ally02;
  level.scr_anim["commander"]["infil_heli_partner"] = % pw_infil_010_fastrope_chiefb;
  level.scr_anim["bravo1"]["infil"] = % pw_infil_010_fastrope_ally03;
  level.scr_anim["bravo2"]["infil"] = % pw_infil_010_fastrope_ally04;
  level.scr_anim["bravo3"]["infil"] = % pw_infil_010_fastrope_ally05;
  level.scr_anim["alpha1"]["forest_move_enter"] = % pxw_wood_010_approach_ally01_enter;
  level.scr_anim["alpha2"]["forest_move_enter"] = % pxw_wood_010_approach_ally02_enter;
  level.scr_anim["bravo1"]["forest_move_enter_idle"][0] = % pxw_wood_010_approach_ally03_enter_idle;
  level.scr_anim["bravo2"]["forest_move_enter_idle"][0] = % pxw_wood_010_approach_ally04_enter_idle;
  level.scr_anim["bravo3"]["forest_move_enter_idle"][0] = % pxw_wood_010_approach_ally05_enter_idle;
  level.scr_anim["alpha1"]["forest_move_a"] = % pxw_wood_010_approach_ally01_path_a;
  level.scr_anim["alpha2"]["forest_move_a"] = % pxw_wood_010_approach_ally02_path_a;
  level.scr_anim["bravo1"]["forest_move_a"] = % pxw_wood_010_approach_ally03_path_a;
  level.scr_anim["bravo2"]["forest_move_a"] = % pxw_wood_010_approach_ally04_path_a;
  level.scr_anim["bravo3"]["forest_move_a"] = % pxw_wood_010_approach_ally05_path_a;
  level.scr_anim["alpha1"]["forest_move_a_idle"][0] = % pxw_wood_010_approach_ally01_path_a_idle;
  level.scr_anim["alpha2"]["forest_move_a_idle"][0] = % pxw_wood_010_approach_ally02_path_a_idle;
  level.scr_anim["bravo1"]["forest_move_a_idle"][0] = % pxw_wood_010_approach_ally03_path_a_idle;
  level.scr_anim["bravo2"]["forest_move_a_idle"][0] = % pxw_wood_010_approach_ally04_path_a_idle;
  level.scr_anim["bravo3"]["forest_move_a_idle"][0] = % pxw_wood_010_approach_ally05_path_a_idle;
  level.scr_anim["alpha1"]["forest_move_b"] = % pxw_wood_010_approach_ally01_path_b;
  level.scr_anim["alpha2"]["forest_move_b"] = % pxw_wood_010_approach_ally02_path_b;
  level.scr_anim["bravo1"]["forest_move_b"] = % pxw_wood_010_approach_ally03_path_b;
  level.scr_anim["bravo2"]["forest_move_b"] = % pxw_wood_010_approach_ally04_path_b;
  level.scr_anim["bravo3"]["forest_move_b"] = % pxw_wood_010_approach_ally05_path_b;
  level.scr_anim["bravo1"]["forest_move_b_idle"][0] = % pxw_wood_010_approach_ally03_path_b_idle;
  level.scr_anim["bravo2"]["forest_move_b_idle"][0] = % pxw_wood_010_approach_ally04_path_b_idle;
  level.scr_anim["bravo3"]["forest_move_b_idle"][0] = % pxw_wood_010_approach_ally05_path_b_idle;
  level.scr_anim["enemy1"]["overlook_patrol"] = % pxw_wood_015_overlook_patro_enemy01;
  level.scr_anim["enemy2"]["overlook_patrol"] = % pxw_wood_015_overlook_patro_enemy02;
  level.scr_anim["alpha2"]["overlook_reveal"] = % pw_wood_020_reveal_enter_ally01;
  level.scr_anim["alpha1"]["overlook_reveal"] = % pw_wood_020_reveal_enter_ally02;
  level.scr_anim["alpha1"]["overlook_reveal_point"] = % pw_wood_020_reveal_point_ally02;
  level.scr_anim["alpha2"]["overlook_reveal_idle"][0] = % pw_wood_020_reveal_enter_idle_ally01;
  level.scr_anim["alpha1"]["overlook_reveal_idle"][0] = % pw_wood_020_reveal_enter_idle_ally02;
  level.scr_anim["alpha1"]["overlook_reveal_idle_nags"][0] = % pw_wood_020_reveal_enter_nag_ally02;
  level.scr_anim["alpha1"]["overlook_reveal_react"] = % pw_wood_020_reveal_look_up_ally02;
  level.scr_anim["alpha2"]["overlook_reveal_react"] = % pw_wood_020_reveal_look_up_ally01;
  level.scr_anim["alpha2"]["overlook_door_bust"] = % pw_wood_020_reveal_scene_ally01;
  level.scr_anim["alpha1"]["overlook_door_bust"] = % pw_wood_020_reveal_scene_ally02;
  level.scr_anim["alpha2"]["overlook_door_bust_idle"][0] = % pw_wood_020_reveal_scene_idle_ally01;
  level.scr_goaltime["alpha2"]["overlook_door_bust_idle"] = 0.01;
  level.scr_anim["alpha1"]["overlook_door_bust_idle"][0] = % pw_wood_020_reveal_scene_idle_ally02;
  level.scr_goaltime["alpha1"]["overlook_door_bust_idle"] = 0.01;
  level.scr_anim["alpha2"]["overlook_drop_down"] = % pw_wood_020_reveal_jump_ally01;
  level.scr_anim["alpha1"]["overlook_drop_down"] = % pw_wood_020_reveal_jump_ally02;
  level.scr_anim["alpha2"]["overlook_drop_down_idle"][0] = % pw_wood_020_reveal_jump_idle_ally01;
  level.scr_anim["alpha1"]["overlook_drop_down_idle"][0] = % pw_wood_020_reveal_jump_idle_ally02;
  level.scr_anim["alpha2"]["overlook_exit"] = % pw_wood_020_reveal_exit_ally01;
  level.scr_anim["alpha1"]["overlook_exit"] = % pw_wood_020_reveal_exit_ally02;
  level.scr_anim["enemy1"]["idle_a"][0] = % pxw_wood_025_binoculars_enemy01_idlea;
  level.scr_anim["enemy1"]["suv_enter_compound"] = % pxw_wood_025_binoculars_enemy01;
  level.scr_anim["enemy1"]["idle_b"][0] = % pxw_wood_025_binoculars_enemy01_idleb;
  level.scr_anim["enemy2"]["idle_a"][0] = % pxw_wood_025_binoculars_enemy02_idlea;
  level.scr_anim["enemy2"]["suv_enter_compound"] = % pxw_wood_025_binoculars_enemy02;
  level.scr_anim["enemy2"]["idle_b"][0] = % pxw_wood_025_binoculars_enemy02_idleb;
  level.scr_anim["enemy3"]["suv_enter_compound"] = % pxw_wood_025_binoculars_enemy03;
  scripts\common\anim::addnotetrack_customfunction("enemy3", "exited_suv", ::exited_suv, "suv_enter_compound");
  level.scr_anim["enemy4"]["suv_enter_compound"] = % pxw_wood_025_binoculars_enemy04;
  level.scr_anim["rus_forest_patrol_1"]["patrol_arrive"] = % pxw_wood_030_patrol_ally_01;
  level.scr_anim["rus_forest_patrol_2"]["patrol_arrive"] = % pxw_wood_030_patrol_ally_04;
  level.scr_anim["rus_forest_patrol_3"]["patrol_arrive"] = % pxw_wood_030_patrol_ally_03;
  level.scr_anim["rus_forest_patrol_4"]["patrol_arrive"] = % pxw_wood_030_patrol_ally_05;
  level.scr_anim["alpha2"]["patrol_approach"] = % pxw_wood_030_approach_b_ally01_scene;
  level.scr_anim["alpha1"]["patrol_approach"] = % pxw_wood_030_approach_b_ally02_scene;
  level.scr_anim["bravo3"]["patrol_approach"] = % pxw_wood_030_approach_b_ally03_scene;
  level.scr_anim["bravo1"]["patrol_approach"] = % pxw_wood_030_approach_b_ally04_scene;
  level.scr_anim["bravo2"]["patrol_approach"] = % pxw_wood_030_approach_b_ally05_scene;
  level.scr_anim["alpha2"]["patrol_approach_idle"][0] = % pxw_wood_030_approach_b_ally01_idle;
  level.scr_anim["alpha1"]["patrol_approach_idle"][0] = % pxw_wood_030_approach_b_ally02_idle;
  level.scr_anim["bravo3"]["patrol_approach_idle"][0] = % pxw_wood_030_approach_b_ally03_idle;
  level.scr_anim["bravo1"]["patrol_approach_idle"][0] = % pxw_wood_030_approach_b_ally04_idle;
  level.scr_anim["bravo2"]["patrol_approach_idle"][0] = % pxw_wood_030_approach_b_ally05_idle;
  level.scr_anim["alpha2"]["patrol_approach_exit"] = % pxw_wood_030_approach_b_ally01_exit;
  level.scr_anim["alpha1"]["patrol_approach_exit"] = % pxw_wood_030_approach_b_ally02_exit;
  level.scr_anim["bravo3"]["patrol_approach_exit"] = % pxw_wood_030_approach_b_ally03_exit;
  level.scr_anim["bravo1"]["patrol_approach_exit"] = % pxw_wood_030_approach_b_ally04_exit;
  level.scr_anim["bravo2"]["patrol_approach_exit"] = % pxw_wood_030_approach_b_ally05_exit;
  level.scr_anim["burning_guy"]["burning_guy_death"] = % pxw_yard_010_death_enemy_03;
  level.scr_anim["crawling_guy"]["crawling_guy_enter"] = % pxw_yard_010_death_scene_enemy_enter;
  level.scr_anim["crawling_guy"]["crawling_guy_idle"][0] = % pxw_yard_010_death_scene_enemy_idle;
  level.scr_anim["crawling_guy"]["crawling_guy_kill"] = % pxw_yard_010_death_scene_enemy_kill;
  level.scr_anim["alpha2"]["crawling_guy_kill"] = % pxw_yard_010_death_scene_ally_kill;
  scripts\common\anim::addnotetrack_customfunction("alpha2", "fire_if_alive", ::fire_if_alive, "crawling_guy_kill");
  level.scr_anim["pistol_guy"]["back_crawl"] = % sdr_com_exposed_crouch_long_death_crawl_back;
  level.scr_anim["pistol_guy"]["back_crawl_fire"] = % sdr_com_exposed_crouch_long_death_crawl_back_fire_death;
  level.scr_anim["alpha1"]["breach_enter"] = % pxw_yard_020_kill_enter_ally_01;
  level.scr_goaltime["alpha1"]["breach_enter"] = 0.2;
  level.scr_anim["alpha2"]["breach_enter"] = % pxw_yard_020_kill_enter_ally_02;
  level.scr_goaltime["alpha2"]["breach_enter"] = 0.2;
  level.scr_anim["rus_breach_guy_1"]["breach_enter"] = % pxw_yard_020_kill_enter_enemy_01;
  level.scr_anim["rus_breach_guy_2"]["breach_enter"] = % pxw_yard_020_kill_enter_enemy_02;
  level.scr_anim["rus_breach_guy_3"]["breach_enter"] = % pxw_yard_020_kill_enter_enemy_03;
  level.scr_anim["alpha1"]["breach_idle"][0] = % pxw_yard_020_kill_idle_ally_01;
  level.scr_anim["alpha2"]["breach_idle"][0] = % pxw_yard_020_kill_idle_ally_02;
  level.scr_anim["rus_breach_guy_1"]["breach_idle"][0] = % pxw_yard_020_kill_idle_enemy_01;
  level.scr_anim["rus_breach_guy_2"]["breach_idle"][0] = % pxw_yard_020_kill_idle_enemy_02;
  level.scr_anim["rus_breach_guy_3"]["breach_idle"][0] = % pxw_yard_020_kill_idle_enemy_03;
  level.scr_anim["alpha1"]["breach_room"] = % pxw_yard_020_kill_combat_a_ally_01;
  level.scr_anim["alpha2"]["breach_room"] = % pxw_yard_020_kill_combat_a_ally_02;
  level.scr_anim["rus_breach_guy_1"]["breach_room"] = % pxw_yard_020_kill_combat_a_enemy_01;
  level.scr_anim["rus_breach_guy_2"]["breach_room"] = % pxw_yard_020_kill_combat_a_enemy_02;
  level.scr_anim["rus_breach_guy_3"]["breach_room"] = % pxw_yard_020_kill_combat_a_enemy_03;
  scripts\common\anim::addnotetrack_customfunction("alpha1", "fire_if_alive", ::fire_if_alive, "breach_room");
  scripts\common\anim::addnotetrack_customfunction("alpha2", "fire_if_alive", ::fire_if_alive, "breach_room");
  level.scr_anim["alpha2"]["combat_intro_enter"] = % pxw_yard_030_halligan_ally01_enter;
  level.scr_anim["alpha1"]["combat_intro_enter"] = % pxw_yard_030_halligan_ally02_enter;
  level.scr_anim["bravo3"]["combat_intro_enter"] = % pxw_yard_030_halligan_ally03_enter;
  level.scr_anim["alpha2"]["combat_intro_idle"][0] = % pxw_yard_030_halligan_ally01_idle;
  level.scr_goaltime["alpha2"]["combat_intro_idle"] = 0.01;
  level.scr_anim["alpha1"]["combat_intro_idle"][0] = % pxw_yard_030_halligan_ally02_idle;
  level.scr_goaltime["alpha1"]["combat_intro_idle"] = 0.01;
  level.scr_anim["bravo3"]["combat_intro_idle"][0] = % pxw_yard_030_halligan_ally03_idle;
  level.scr_anim["alpha2"]["combat_intro_halligan"] = % pxw_yard_030_halligan_ally01_doorbreak;
  level.scr_goaltime["alpha2"]["combat_intro_halligan"] = 0.2;
  level.scr_anim["alpha1"]["combat_intro_halligan"] = % pxw_yard_030_halligan_ally02_doorbreak;
  level.scr_goaltime["alpha1"]["combat_intro_halligan"] = 0.2;
  level.scr_anim["alpha2"]["combat_intro_scene"] = % pxw_yard_030_halligan_ally01_scene;
  level.scr_anim["alpha1"]["combat_intro_scene"] = % pxw_yard_030_halligan_ally02_scene;
  level.scr_anim["bravo3"]["combat_intro_scene"] = % pxw_yard_030_halligan_ally03_scene;
  level.scr_anim["bravo3"]["retreat_breach_setup"] = % pw_yard_040_lower_door_ally1_bomb_plant;
  level.scr_anim["bravo3"]["retreat_breach_idle"][0] = % pw_yard_040_lower_door_ally1_idle;
  level.scr_anim["bravo3"]["retreat_breach_detonate"] = % pw_yard_040_lower_door_ally1_detonate;
  scripts\common\anim::addnotetrack_customfunction("bravo3", "delete_bomb_strip", ::delete_bomb_strip, "retreat_breach_detonate");
  level.scr_anim["alpha1"]["warehouse_gate_open_enter"] = % pxw_whs_010_masks_ally_2_enter;
  scripts\common\anim::addnotetrack_customfunction("alpha1", "mask_on", ::team_mask_up, "warehouse_gate_open_enter");
  level.scr_anim["bravo1"]["warehouse_gate_open_enter"] = % pxw_whs_010_masks_ally_1_enter;
  level.scr_anim["bravo2"]["warehouse_gate_open_enter"] = % pxw_whs_010_masks_ally_3_enter;
  level.scr_anim["alpha1"]["warehouse_gate_open_idle"][0] = % pxw_whs_010_masks_ally_2_idle;
  level.scr_anim["bravo1"]["warehouse_gate_open_idle"][0] = % pxw_whs_010_masks_ally_1_idle;
  level.scr_anim["bravo2"]["warehouse_gate_open_idle"][0] = % pxw_whs_010_masks_ally_3_idle;
  level.scr_anim["alpha1"]["warehouse_gate_open_start"] = % pxw_whs_010_masks_ally_2_scene;
  scripts\common\anim::addnotetrack_notify("alpha1", "turn_off_lights", "turn_off_lights", "warehouse_gate_open_start");
  level.scr_anim["bravo1"]["warehouse_gate_open_start"] = % pxw_whs_010_masks_ally_1_scene;
  level.scr_anim["bravo2"]["warehouse_gate_open_start"] = % pxw_whs_010_masks_ally_3_scene;
  level.scr_anim["alpha1"]["warehouse_gate_open_cover_idle"][0] = % pxw_whs_010_masks_ally_2_scene_idle;
  level.scr_anim["bravo1"]["warehouse_gate_open_cover_idle"][0] = % pxw_whs_010_masks_ally_1_scene_idle;
  level.scr_anim["bravo2"]["warehouse_gate_open_cover_idle"][0] = % pxw_whs_010_masks_ally_3_scene_idle;
  level.scr_anim["alpha1"]["warehouse_gate_open_cover_exit"] = % pxw_whs_010_masks_ally_2_exit;
  level.scr_anim["bravo1"]["warehouse_gate_open_cover_exit"] = % pxw_whs_010_masks_ally_1_exit;
  level.scr_anim["bravo2"]["warehouse_gate_open_cover_exit"] = % pxw_whs_010_masks_ally_3_exit;
  level.scr_animtree["final_defender"] = #animtree;
  level.scr_model["final_defender"] = "body_spetsnaz_ar_2_1";
  level.scr_anim["final_defender"]["final_defender_death"] = % pxw_whs_030_spetsnaz_enemy_shot;
  level.scr_anim["bravo1"]["warehouse_check_body"] = % pxw_whs_030_spetsnaz_ally;
  level.scr_anim["final_defender"]["warehouse_check_body"] = % pxw_whs_030_spetsnaz_enemy;
  level.scr_anim["alpha1"]["warehouse_button_idle"][0] = % pxw_whs_040_search_wait_idle_ally01;
  level.scr_anim["alpha1"]["warehouse_discover_gas"] = % pxw_whs_040_search_enter_ally01;
  level.scr_anim["alpha1"]["warehouse_discover_gas_nag"] = % pxw_whs_040_search_nag_ally01;
  level.scr_anim["alpha1"]["warehouse_discover_gas_idle"][0] = % pxw_whs_040_search_idle_ally01;
  level.scr_anim["bravo3"]["swab"] = % pw_swab_010_ally;
  level.scr_anim["alpha1"]["trucks_approach_gate_pre_idle"][0] = % pw_exit_010_truck_pullin_ally1_enter_idle;
  level.scr_anim["alpha1"]["trucks_approach_gate_pre_idle_nag"] = % pw_exit_010_truck_pullin_ally1_enter_nag;
  level.scr_anim["alpha1"]["trucks_approach_gate"] = % pw_exit_010_truck_pullin_ally1;
  level.scr_anim["alpha1"]["trucks_approach_gate_idle"][0] = % pw_exit_010_truck_pullin_ally1_idle;
  level.scr_anim["bravo3"]["trucks_approach_gate"] = % pw_exit_010_truck_pullin_ally2;
  level.scr_anim["bravo3"]["trucks_approach_gate_idle"][0] = % pw_exit_010_truck_pullin_ally2_idle;
  level.scr_anim["bravo1"]["trucks_approach_gate"] = % pw_exit_010_truck_pullin_ally3;
  level.scr_anim["bravo1"]["trucks_approach_gate_idle"][0] = % pw_exit_010_truck_pullin_ally3_idle;
  level.scr_anim["bravo2"]["trucks_approach_gate"] = % pw_exit_010_truck_pullin_ally4;
  scripts\common\anim::addnotetrack_customfunction("bravo2", "lights_on", ::turn_on_suv_interior_light, "trucks_approach_gate");
  scripts\common\anim::addnotetrack_customfunction("bravo2", "driver_ready", ::driver_ready, "trucks_approach_gate");
  level.scr_anim["bravo2"]["trucks_approach_gate_idle"][0] = % pw_exit_010_truck_pullin_ally4_idle;
  level.scr_anim["bravo2"]["trucks_approach_gate_nag"] = % pw_exit_010_truck_pullin_ally4_nag;
  level.scr_anim["bravo1"]["convoy_rollout"] = % pw_exit_010_ambush_ally_scene;
  level.scr_anim["bravo2"]["convoy_rollout"] = % pw_exit_010_ambush_driver_scene;
  scripts\common\anim::addnotetrack_customfunction("bravo2", "lights_off", ::turn_off_suv_interior_light, "convoy_rollout");
  level.scr_anim["hadir"]["trucks_stolen"] = % pw_rpg_010_hadir;
  level.scr_anim["fake_aq"]["trucks_stolen"] = % pw_rpg_010_terry;
  level.scr_anim["body_double"]["trucks_stolen"] = % pw_rpg_010_bodydouble;
  scripts\common\anim::addnotetrack_mayhemstart("body_double", "mayhem_start", %pw_rpg_010_wakeup_plr_face, "trucks_stolen");
  scripts\common\anim::addnotetrack_mayhemend("body_double", "mayhem_end", %pw_rpg_010_wakeup_plr_face, "trucks_stolen");
  scripts\common\anim::addnotetrack_notify("body_double", "play_bink", "play_bink", "trucks_stolen");
  level.scr_anim["alpha1"]["trucks_stolen"] = % pw_rpg_010_wakeup_marine;
  scripts\common\anim::addnotetrack_customfunction("alpha1", "remove_weapons", ::final_scene_remove_weapons, "trucks_stolen");
  scripts\common\anim::addnotetrack_customfunction("alpha1", "mb_1_miss", ::fire_mb_1_miss, "trucks_stolen");
  scripts\common\anim::addnotetrack_customfunction("alpha1", "mb_1_hit", ::fire_mb_1_hit, "trucks_stolen");
  level.scr_anim["bravo3"]["trucks_stolen"] = % pw_rpg_010_drag_marine2;
  scripts\common\anim::addnotetrack_customfunction("bravo3", "mb_2_miss", ::fire_mb_2_miss, "trucks_stolen");
  scripts\common\anim::addnotetrack_customfunction("bravo3", "mb_2_hit", ::fire_mb_2_hit, "trucks_stolen");
  level.scr_face["alpha2"]["dx_vom_h72_forest_overlook_scout_370"] = % dx_vom_h72_forest_overlook_scout_370_face;
  level.scr_face["alpha1"]["dx_vom_h71_forest_overlook_ridge_40"] = % dx_vom_h71_forest_overlook_ridge_40_face;
  level.scr_face["alpha1"]["dx_vom_h71_forest_overlook_ridge_50"] = % dx_vom_h71_forest_overlook_ridge_50_face;
  level.scr_face["alpha1"]["dx_vom_h71_forest_overlook_ridge_60"] = % dx_vom_h71_forest_overlook_ridge_60_face;
  level.scr_face["alpha1"]["dx_vom_h71_forest_overlook_ridge_70"] = % dx_vom_h71_forest_overlook_ridge_70_face;
  level.scr_face["alpha1"]["dx_vom_h71_forest_overlook_ridge_80"] = % dx_vom_h71_forest_overlook_ridge_80_face;
  level.scr_face["alpha1"]["dx_vom_h71_railyard_entrance_aftermath_210"] = % dx_vom_h71_railyard_entrance_aftermath_210_face;
  level.scr_face["alpha1"]["dx_vom_h71_warehouse_enter_power_10"] = % dx_vom_h71_warehouse_enter_power_10_face;
  level.scr_face["alpha1"]["dx_vom_h71_forest_overlook_scout_80"] = % dx_vom_h71_forest_overlook_scout_80_face;
  level.scr_face["alpha1"]["dx_vom_h71_forest_overlook_scout_330"] = % dx_vom_h71_forest_overlook_scout_330_face;
  level.scr_face["alpha1"]["dx_vom_h71_forest_overlook_scout_320"] = % dx_vom_h71_forest_overlook_scout_320_face;
  level.scr_face["alpha1"]["dx_vom_h71_forest_overlook_scout_300"] = % dx_vom_h71_forest_overlook_scout_300_face;
  level.scr_face["alpha1"]["dx_vom_h71_forest_overlook_scout_220"] = % dx_vom_h71_forest_overlook_scout_220_face;
  level.scr_face["alpha1"]["dx_vom_h71_forest_overlook_scout_40"] = % dx_vom_h71_forest_overlook_scout_40_face;
}

#using_animtree("script_model");

script_models() {
  level.scr_animtree["rope"] = #animtree;
  level.scr_model["rope"] = "equipment_fast_rope_wm_01_infil_heli_l";
  level.scr_anim["rope"]["infil_heli_player"] = % pw_infil_010_fastrope_ropea;
  level.scr_anim["rope"]["infil_heli_player_fall"] = % pw_infil_010_fastrope_ropea_fall;
  level.scr_anim["rope"]["infil_heli_partner"] = % pw_infil_010_fastrope_ropeb;
  level.scr_anim["rope"]["infil_heli_partner_fall"] = % pw_infil_010_fastrope_ropeb_fall;
  level.scr_animtree["overlook_door"] = #animtree;
  level.scr_anim["overlook_door"]["overlook_door_bust"] = % pw_wood_020_reveal_scene_door;
  level.scr_animtree["fake_door"] = #animtree;
  level.scr_model["fake_door"] = "door_metal_panel_02_cross_rusty_rl_hero";
  level.scr_anim["fake_door"]["suv_enter_compound"] = % pxw_wood_025_binoculars_door;
  level.scr_animtree["extinguisher"] = #animtree;
  level.scr_model["extinguisher"] = "uk_fire_extinguisher_small_01a";
  level.scr_animtree["door"] = #animtree;
  level.scr_anim["door"]["breach_room"] = % pxw_yard_020_kill_combat_a_door_front;
  level.scr_animtree["halligan"] = #animtree;
  level.scr_model["halligan"] = "misc_wm_halligan_tool";
  level.scr_anim["door"]["combat_intro_halligan_door_l"] = % pxw_yard_030_halligan_doorl_doorbreak;
  level.scr_anim["door"]["combat_intro_halligan_door_r"] = % pxw_yard_030_halligan_doorr_doorbreak;
  level.scr_anim["door"]["combat_intro_scene_door_l"] = % pxw_yard_030_halligan_doorl_scene;
  level.scr_anim["door"]["combat_intro_scene_door_r"] = % pxw_yard_030_halligan_doorr_scene;
  level.scr_animtree["mg_target"] = #animtree;
  level.scr_anim["mg_target"]["combat_intro_scene"] = % pxw_yard_030_halligan_bullet_scene;
  level.scr_animtree["railyard_lmg"] = #animtree;
  level.scr_weapon["railyard_lmg"] = ["iw8_lm_pkilo", [], 1];
  level.scr_animtree["clacker"] = #animtree;
  level.scr_model["clacker"] = "offhand_vm_clacker_tactical";
  level.scr_anim["clacker"]["retreat_breach_setup"] = % pw_yard_040_lower_door_clacker_bomb_plant;
  level.scr_anim["clacker"]["retreat_breach_idle"][0] = % pw_yard_040_lower_door_clacker_idle;
  level.scr_anim["clacker"]["retreat_breach_detonate"] = % pw_yard_040_lower_door_clacker_detonate;
  level.scr_animtree["bomb_strip"] = #animtree;
  level.scr_model["bomb_strip"] = "bomb_c4_large_double_01";
  level.scr_anim["bomb_strip"]["retreat_breach_setup"] = % pw_yard_040_lower_door_bomb_bomb_plant;
  level.scr_animtree["courtyard_door_l"] = #animtree;
  level.scr_model["courtyard_door_l"] = "door_metal_panel_02_cross_rusty_rl_hero";
  level.scr_anim["courtyard_door_l"]["retreat_breach_detonate"] = % pw_yard_040_lower_door_doorl_bomb_plant;
  level.scr_animtree["courtyard_door_r"] = #animtree;
  level.scr_model["courtyard_door_r"] = "door_metal_panel_02_cross_rusty_rl_hero";
  level.scr_anim["courtyard_door_r"]["retreat_breach_detonate"] = % pw_yard_040_lower_door_doorr_bomb_plant;
  level.scr_animtree["warehouse_gate"] = #animtree;
  level.scr_model["warehouse_gate"] = "me_metal_panel_sliding_security_gate_128";
  level.scr_anim["warehouse_gate"]["warehouse_gate_open_start"] = % pxw_whs_010_masks_door_scene;
  level.scr_animtree["power_lever"] = #animtree;
  level.scr_model["power_lever"] = "uk_electrical_box_medium_02_animated";
  level.scr_anim["power_lever"]["turn_on_power"] = % pxw_whs_020_button_ai_electric_box_handle;
  level.scr_animtree["door_button"] = #animtree;
  level.scr_anim["door_button"]["warehouse_discover_gas"] = % pxw_whs_040_search_enter_button;
  level.scr_anim["door_button"]["try_door_button"] = % pxw_whs_040_search_button_fail_button;
  level.scr_animtree["warehouse_roller_door"] = #animtree;
  level.scr_anim["warehouse_roller_door"]["warehouse_discover_gas"] = % pxw_whs_040_search_enter_door;
  level.scr_animtree["swab"] = #animtree;
  level.scr_model["swab"] = "uk_tool_chemical_swab_02";
  level.scr_anim["swab"]["swab"] = % pw_swab_010_swb;
  level.scr_animtree["gasmask1"] = #animtree;
  level.scr_model["gasmask1"] = "prop_gasmask";
  level.scr_anim["gasmask1"]["warehouse_gate_open_enter"] = % pxw_whs_010_masks_mask_2_enter;
  level.scr_animtree["gasmask2"] = #animtree;
  level.scr_model["gasmask2"] = "prop_gasmask";
  level.scr_anim["gasmask2"]["warehouse_gate_open_enter"] = % pxw_whs_010_masks_mask_1_enter;
  level.scr_animtree["gasmask3"] = #animtree;
  level.scr_model["gasmask3"] = "prop_gasmask";
  level.scr_anim["gasmask3"]["warehouse_gate_open_enter"] = % pxw_whs_010_masks_mask_3_enter;
  level.scr_animtree["player_gasmask"] = #animtree;
  level.scr_model["player_gasmask"] = "prop_child_hadir_gas_mask";
  level.scr_anim["player_gasmask"]["player_mask_on"] = % pxw_vm_gasmask_prop;
  level.scr_goaltime["player_gasmask"]["player_mask_on"] = 0;
  scripts\common\anim::addnotetrack_customfunction("player_gasmask", "mask_is_on", ::mask_is_on, "player_mask_on");
  level.scr_anim["player_gasmask"]["trucks_stolen"] = % pw_rpg_010_wakeup_gas_mask;
  level.scr_animtree["windshield"] = #animtree;
  level.scr_model["windshield"] = "veh8_civ_lnd_decho_dst_windshield";
}

#using_animtree("vehicles");

vehicles() {
  level.scr_anim["infil_heli_player"]["bink_intro"] = % pw_infil_010_fastrope_idle_helia;
  level.scr_animtree["infil_heli_player"] = #animtree;
  level.scr_model["infil_heli_player"] = "veh8_mil_air_blima";
  level.scr_anim["infil_heli_player"]["infil"] = % pw_infil_010_fastrope_helia;
  level.scr_animtree["infil_heli_partner"] = #animtree;
  level.scr_model["infil_heli_partner"] = "veh8_mil_air_blima";
  level.scr_anim["infil_heli_partner"]["infil"] = % pw_infil_010_fastrope_helib;
  level.scr_animtree["jet1"] = #animtree;
  level.scr_anim["jet1"]["fly"] = % pxw_wood_025_phosp_plane_1;
  level.scr_animtree["jet2"] = #animtree;
  level.scr_anim["jet2"]["fly"] = % pxw_wood_025_phosp_plane_2;
  level.scr_animtree["overlook_truck"] = #animtree;
  level.scr_model["overlook_truck"] = "veh8_mil_lnd_mkilo23_rus";
  level.scr_anim["overlook_truck"]["truck_enter"] = % pxw_wood_025_binoculars_truck_mkilo;
  level.scr_animtree["suv"] = #animtree;
  level.scr_model["suv"] = "veh8_civ_lnd_decho_black";
  level.scr_anim["suv"]["suv_enter_compound"] = % pxw_wood_025_binoculars_truck;
  level.scr_animtree["rus_forest_patrol_truck"] = #animtree;
  level.scr_anim["rus_forest_patrol_truck"]["patrol_arrive"] = % pxw_wood_030_patrol_truck;
  scripts\common\anim::addnotetrack_flag("rus_forest_patrol_truck", "enemies_exited", "enemies_exited", "patrol_arrive");
  level.scr_animtree["truck1"] = #animtree;
  level.scr_anim["truck1"]["trucks_approach_gate"] = % pw_exit_010_sniper_truck1_pull_in;
  level.scr_anim["truck1"]["trucks_approach_gate_idle"][0] = % pw_exit_010_sniper_truck1_pull_in_idle;
  scripts\common\anim::addnotetrack_customfunction("truck1", "lights_on", ::decho_lights_on, "trucks_approach_gate");
  scripts\common\anim::addnotetrack_customfunction("truck1", "brakes_on", ::decho_brakes_on, "trucks_approach_gate");
  level.scr_animtree["truck2"] = #animtree;
  level.scr_anim["truck2"]["trucks_approach_gate"] = % pw_exit_010_sniper_truck2_pull_in;
  scripts\common\anim::addnotetrack_customfunction("truck2", "lights_on", ::decho_lights_on, "trucks_approach_gate");
  scripts\common\anim::addnotetrack_customfunction("truck2", "brakes_on", ::decho_brakes_on, "trucks_approach_gate");
  scripts\common\anim::addnotetrack_customfunction("truck2", "brakes_off", ::decho_brakes_off, "trucks_approach_gate");
  level.scr_anim["truck2"]["trucks_approach_gate_idle"][0] = % pw_exit_010_sniper_truck2_pull_in_idle;
  level.scr_animtree["truck3"] = #animtree;
  level.scr_anim["truck3"]["trucks_approach_gate"] = % pw_swab_010_trck;
  level.scr_anim["truck3"]["trucks_approach_gate_idle"][0] = % pw_swab_010_trck_idle;
  level.scr_anim["truck1"]["convoy_rollout"] = % proxywar_truck_flip;
  scripts\common\anim::addnotetrack_notify("truck1", "suicide_truck_explosion", "suicide_truck_explosion", "convoy_rollout");
  scripts\common\anim::addnotetrack_customfunction("truck1", "suicide_truck_explosion", ::truck1_flip, "convoy_rollout");
  scripts\common\anim::addnotetrack_customfunction("truck1", "brakes_off", ::decho_brakes_off, "convoy_rollout");
  scripts\common\anim::addnotetrack_customfunction("truck1", "brakes_on", ::decho_brakes_on, "convoy_rollout");
  scripts\common\anim::addnotetrack_customfunction("truck1", "lights_off", ::decho_lights_off, "convoy_rollout");
  level.scr_anim["truck2"]["convoy_rollout"] = % pw_exit_010_ambush_truck_main_scene;
  scripts\common\anim::addnotetrack_notify("truck2", "slam_to_black", "slam_to_black", "convoy_rollout");
  scripts\common\anim::addnotetrack_customfunction("truck2", "lights_off", ::decho_lights_off, "convoy_rollout");
  scripts\common\anim::addnotetrack_customfunction("truck2", "brakes_off", ::decho_brakes_off, "convoy_rollout");
  scripts\common\anim::addnotetrack_customfunction("truck2", "start_mb_volley", ::forest_magic_bullet_volley, "convoy_rollout");
  level.scr_animtree["suicide_truck"] = #animtree;
  level.scr_model["suicide_truck"] = "veh8_mil_lnd_pindia_black";
  level.scr_anim["suicide_truck"]["convoy_rollout"] = % pw_exit_010_ambush_truck_exp_scene;
  scripts\common\anim::addnotetrack_notify("suicide_truck", "suicide_truck_impact", "suicide_truck_impact", "convoy_rollout");
  level.scr_anim["truck2"]["trucks_stolen"] = % pw_rpg_010_drag_truck;
  level.scr_anim["truck3"]["trucks_stolen"] = % pw_rpg_010_truck2;
  scripts\common\anim::addnotetrack_customfunction("truck3", "start_truck_rumble", ::start_truck_rumble, "trucks_stolen");
  scripts\common\anim::addnotetrack_customfunction("truck3", "audio_truck_exit", ::audio_truck_exit, "trucks_stolen");
  level.scr_anim["truck1"]["truck_enter"] = % pw_swab_010_trck_door;
  level.scr_anim["truck3"]["truck_enter"] = % pw_swab_010_trck_door;
}

player_on_fast_rope(var_0) {
  level.playerheli notify("heli_leaving");
  level notify("player_on_rope");
  level.player playrumblelooponentity("tank_rumble");
}

end_rope_rumble(var_0) {
  level.player stoprumble("tank_rumble");
  level.playerheli stoprumble("subtle_tank_rumble");
}

fov_open(var_0) {
  level.player modifybasefov(65, 1.0);
}

fov_close(var_0) {
  level.player modifybasefov(50, 1.0);
}

lock_in_death_anim(var_0) {
  if(isalive(var_0)) {
    var_0.allowdeath = 0;
    var_0 scripts\engine\sp\utility::clear_deathanim();
    var_0.skipdeathanim = 1;
    var_0.a.nodeath = 1;
    var_0.noragdoll = 1;
  }
}

infil_remove_fov_user_scale_override(var_0) {
  level.player lerpfovscalefactor(1, 2);
}

exited_suv(var_0) {
  scripts\engine\utility::flag_set("suv_patrol_started");
  thread scripts\sp\maps\proxywar\proxywar_lighting.gsc::lights_off("suv_c_head_lights");
  thread scripts\sp\maps\proxywar\proxywar_lighting.gsc::lights_off("suv_c_tail_lights");
}

delete_bomb_strip(var_0) {
  if(isDefined(level.bombstrip)) {
    var_1 = distance2d(level.bombstrip.origin, level.player.origin);

    if(var_1 <= 150) {
      var_2 = scripts\engine\math::remap(var_1, 0, 150, 500, 0);
      level.player scripts\sp\utility::do_damage(var_2, level.bombstrip.origin, undefined, undefined, "MOD_EXPLOSIVE", "frag");
    }

    level.bombstrip delete();
  }
}

team_mask_up(var_0) {
  level thread scripts\sp\maps\proxywar\proxywar_util.gsc::gasmask_on();
  wait 2.3;

  foreach(var_2 in level.alpha_and_bravo_team) {
    var_2 detach(var_2.hatmodel);
    var_2.hatmodel = var_2.hatmodel + "_gasmask";
    var_2 attach(var_2.hatmodel);
  }
}

swab_add_fov_user_scale_override(var_0) {
  level.player lerpfovscalefactor(0, 0.6);
}

swab_remove_fov_user_scale_override(var_0) {
  level.player lerpfovscalefactor(1, 1);
}

turn_on_suv_interior_light(var_0) {
  thread scripts\sp\maps\proxywar\proxywar_lighting.gsc::lights_on("suv_b_dome_light");
}

turn_off_suv_interior_light(var_0) {
  thread scripts\sp\maps\proxywar\proxywar_lighting.gsc::lights_off("suv_b_dome_light");
}

hide_mask(var_0) {
  if(isDefined(var_0))
    var_0 hide();
}

show_mask(var_0) {
  if(isDefined(var_0))
    var_0 show();
}

mask_is_on(var_0) {
  scripts\engine\utility::flag_set("player_mask_on");
}

fire_if_alive(var_0) {
  var_1 = var_0.scene_kill_target[0];
  var_2 = getEnt(var_1, "script_noteworthy");

  if(isalive(var_2))
    var_0 shoot(1000);

  var_0.scene_kill_target = scripts\engine\utility::array_remove(var_0.scene_kill_target, var_1);
}

truck1_flip(var_0) {
  var_1 = ["tag_window_front_left", "tag_window_front_right", "tag_window_back_left", "tag_window_back_right", "tag_windshield_front", "tag_windshield_back"];

  foreach(var_3 in var_1) {
    var_0 hidepart(var_3);

    if(issubstr(var_3, "windshield")) {
      playFXOnTag(scripts\engine\utility::getfx("vfx_veh_glass_windshield"), var_0, var_3);
      continue;
    }

    playFXOnTag(scripts\engine\utility::getfx("vfx_veh_glass_window_side"), var_0, var_3);
  }

  var_5 = ["tag_light_back_left", "tag_light_back_right", "tag_light_front_left", "tag_light_front_right"];

  foreach(var_7 in var_5) {
    var_0 hidepart(var_7);
    playFXOnTag(scripts\engine\utility::getfx("vfx_veh_glass_lamp"), var_0, var_7);
  }

  thread scripts\sp\maps\proxywar\proxywar_lighting.gsc::lights_off("suv_a_head_lights");
  thread scripts\sp\maps\proxywar\proxywar_lighting.gsc::lights_off("suv_a_tail_lights");
  waitframe();
  decho_brakes_off(level.truck1);
  waitframe();
  decho_lights_off(level.truck1);
  var_0 setModel("proxywar_decho_dst_black");
  waitframe();
  scripts\engine\utility::exploder("crash_backlight");
}

decho_brakes_on(var_0) {
  playFXOnTag(scripts\engine\utility::getfx("vfx_pw_veh_taillight_decho_left_nolight_braking"), var_0, "tag_light_back_left");
  playFXOnTag(scripts\engine\utility::getfx("vfx_pw_veh_taillight_decho_right_nolight_braking"), var_0, "tag_light_back_right");
}

decho_brakes_off(var_0) {
  killfxontag(scripts\engine\utility::getfx("vfx_pw_veh_taillight_decho_left_nolight_braking"), var_0, "tag_light_back_left");
  killfxontag(scripts\engine\utility::getfx("vfx_pw_veh_taillight_decho_right_nolight_braking"), var_0, "tag_light_back_right");
}

decho_lights_on(var_0) {
  playFXOnTag(scripts\engine\utility::getfx("vfx_pw_veh_taillight_decho_left_nolight"), var_0, "tag_light_back_left");
  playFXOnTag(scripts\engine\utility::getfx("vfx_pw_veh_taillight_decho_right_nolight"), var_0, "tag_light_back_right");
  playFXOnTag(scripts\engine\utility::getfx("vfx_pw_veh_headlight_decho_left_nolight"), var_0, "tag_light_front_left");
  playFXOnTag(scripts\engine\utility::getfx("vfx_pw_veh_headlight_decho_right_nolight"), var_0, "tag_light_front_right");
}

decho_lights_off(var_0) {
  killfxontag(scripts\engine\utility::getfx("vfx_pw_veh_taillight_decho_left_nolight"), var_0, "tag_light_back_left");
  killfxontag(scripts\engine\utility::getfx("vfx_pw_veh_taillight_decho_right_nolight"), var_0, "tag_light_back_right");
  killfxontag(scripts\engine\utility::getfx("vfx_pw_veh_headlight_decho_left_nolight"), var_0, "tag_light_front_left");
  killfxontag(scripts\engine\utility::getfx("vfx_pw_veh_headlight_decho_right_nolight"), var_0, "tag_light_front_right");

  if(var_0 == level.truck2) {
    thread scripts\sp\maps\proxywar\proxywar_lighting.gsc::lights_off("suv_b_head_lights");
    thread scripts\sp\maps\proxywar\proxywar_lighting.gsc::lights_off("suv_b_tail_lights");
  }
}

driver_ready(var_0) {
  scripts\engine\utility::flag_set("driver_ready");
}

final_scene_remove_weapons(var_0) {
  level.alpha1 scripts\common\ai::gun_remove();
}

forest_magic_bullet_volley(var_0) {
  var_1 = scripts\engine\utility::getStructArray("mb_forest", "targetname");
  var_2 = [];

  foreach(var_4 in var_1)
  var_2[var_2.size] = scripts\engine\utility::spawn_tag_origin(var_4.origin, var_4.angles);

  foreach(var_9, var_7 in var_2) {
    var_8 = [];

    switch (var_9) {
      case 0:
        var_8 = [level.truck2 gettagorigin("tag_hood"), level.truck2 gettagorigin("tag_hood") + (20, 0, 10), level.truck2 gettagorigin("tag_hood") + (25, 0, 15)];
        break;
      case 1:
        var_8 = [level.truck2 gettagorigin("tag_light_front_left"), level.truck2 gettagorigin("tag_light_front_left") + (20, 0, 10), level.truck2 gettagorigin("tag_light_front_left") + (25, 0, 15)];
        break;
      case 2:
        var_8 = [level.truck2 gettagorigin("tag_light_front_right"), level.truck2 gettagorigin("tag_light_front_right") + (-20, 0, 25), level.truck2 gettagorigin("tag_light_front_right") + (-25, 0, 35)];
        break;
    }

    var_7 thread magic_bullet_volley(var_8);
    wait 0.4;
  }

  wait 3;

  foreach(var_7 in var_2) {
    var_7 notify("end_volley");
    var_7 delete();
    wait 0.2;
  }
}

magic_bullet_volley(var_0) {
  self endon("end_volley");

  for(;;) {
    playFXOnTag(scripts\engine\utility::getfx("ak_muzzle_flash"), self, "tag_origin");
    magicbullet("iw8_ar_akilo47", self.origin, scripts\engine\utility::random(var_0));
    wait(randomfloatrange(0.2, 0.4));
  }
}

fire_mb_1_miss(var_0) {
  if(!isDefined(level.mbsource1))
    level.mbsource1 = scripts\engine\utility::spawn_tag_origin(scripts\engine\utility::getStruct("mb_fire_1", "targetname").origin, (0, 0, 0));

  var_1 = [(20, 10, 63), (-20, 10, 32), (20, 10, 45)];
  playFXOnTag(scripts\engine\utility::getfx("ak_muzzle_flash"), level.mbsource1, "tag_origin");
  magicbullet("iw8_ar_akilo47", level.mbsource1.origin, level.alpha1.origin + scripts\engine\utility::random(var_1));
}

fire_mb_1_hit(var_0) {
  playFXOnTag(scripts\engine\utility::getfx("ak_muzzle_flash"), level.mbsource1, "tag_origin");
  magicbullet("iw8_ar_akilo47", level.mbsource1.origin, level.alpha1 gettagorigin("j_spine4"));
}

fire_mb_2_miss(var_0) {
  if(!isDefined(level.mbsource2))
    level.mbsource2 = scripts\engine\utility::spawn_tag_origin(scripts\engine\utility::getStruct("mb_fire_2", "targetname").origin, (0, 0, 0));

  var_1 = [(20, 10, 63), (-20, 10, 32), (20, 10, 45)];
  playFXOnTag(scripts\engine\utility::getfx("ak_muzzle_flash"), level.mbsource2, "tag_origin");
  magicbullet("iw8_ar_akilo47", level.mbsource2.origin, level.bravo3.origin + scripts\engine\utility::random(var_1));
}

fire_mb_2_hit(var_0) {
  magicbullet("iw8_ar_akilo47", scripts\engine\utility::getStruct("mb_fire_2", "targetname").origin, level.bravo3 gettagorigin("j_spine4"));
}

enable_springcam(var_0) {
  level.player springcamenabled(2, 5.0, 0.2);
}

start_drag_rumble(var_0) {
  level.player playrumblelooponentity("subtle_tank_rumble");
}

stop_drag_rumble(var_0) {
  level.player stoprumble("subtle_tank_rumble");
}

remove_player_gasmask(var_0) {
  level notify("remove_gasmask");
  scripts\sp\maps\proxywar\proxywar_util.gsc::remove_mask_overlay();
}

start_truck_rumble(var_0) {
  level.truck3 playrumblelooponentity("subtle_tank_rumble");
}

switch_to_bodydouble(var_0) {
  level.player_rig hide();
  level.player lerpviewangleclamp(1.0, 0.1, 0.1, 0, 0, 0, 0);
  level.player.bodydouble show();
}

audio_truck_exit(var_0) {
  level.truck3 playSound("scn_proxy_truck3_drive_off_lr");
  level notify("audio_truck3_driving_off");
}