/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\embassy\embassy_anim.gsc
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
  level.scr_animtree["player_rig"] = #animtree;
  level.scr_model["player_rig"] = "viewmodel_fullbody_kyle_desert";
  level.scr_anim["player_rig"]["infil_crash_ride"] = % emb_infil_010_crash_ride_plr;
  level.scr_anim["player_rig"]["infil_crash_crawl_a_idle"][0] = % emb_infil_010_crash_crawl_a_idle_plr;
  level.scr_goaltime["player_rig"]["infil_crash_crawl_a_idle"] = 0.1;
  level.scr_anim["player_rig"]["infil_crash_crawl_a"] = % emb_infil_010_crash_crawl_a_plr;
  level.scr_anim["player_rig"]["infil_crash_crawl_b_idle"][0] = % emb_infil_010_crash_crawl_b_idle_plr;
  level.scr_anim["player_rig"]["infil_crash_crawl_b"] = % emb_infil_010_crash_crawl_b_plr;
  level.scr_anim["player_rig"]["infil_crash_crawl_c_idle"][0] = % emb_infil_010_crash_crawl_c_idle_plr;
  level.scr_anim["player_rig"]["infil_crash_crawl_c"] = % emb_infil_010_crash_crawl_c_plr;
  level.scr_anim["player_rig"]["infil_crash_crawl_d_idle"][0] = % emb_infil_010_crash_crawl_d_idle_plr;
  level.scr_anim["player_rig"]["infil_crash_fall_relative"] = % emb_infil_010_crash_fall_relative_plr;
  level.scr_goaltime["player_rig"]["infil_crash_fall_relative"] = 0.0;
  level.scr_anim["player_rig"]["infil_crash_fall"] = % emb_infil_010_crash_fall_plr;
  level.scr_goaltime["player_rig"]["infil_crash_fall"] = 0.0;
  scripts\common\anim::addnotetrack_notify("player_rig", "go_prone", "go_prone", "infil_crash_fall");
  scripts\common\anim::addnotetrack_notify("player_rig", "plr_hit_ground", "player_lands", "infil_crash_fall");
  scripts\common\anim::addnotetrack_notify("player_rig", "can_move", "can_move", "infil_crash_fall");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "embassy_infil_chopper_crash_explo", ::embassy_infil_chopper_crash_explo_sfx, "infil_crash_fall");
  level.scr_anim["player_rig"]["infil_crash_fall_go_prone"] = % emb_infil_010_go_prone_plr;
  scripts\common\anim::addnotetrack_customfunction("player_rig", "crash_fall_remove_fov_scale_factor_override", ::crash_fall_remove_fov_scale_factor_override, "infil_crash_fall_go_prone");
  level.scr_anim["player_rig"]["infil_crash_fall_prone_to_crouch"] = % emb_infil_010_prone_to_crouch_plr;
  level.scr_anim["player_rig"]["bpg_scene_door_enter"] = % emb_bpg_020_hostage_door_enter_plr;
  level.scr_goaltime["player_rig"]["bpg_scene_door_enter"] = 0.0;
  level.scr_anim["player_rig"]["bpg_scene_door_struggle"] = % emb_bpg_020_hostage_door_struggle_plr;
  level.scr_goaltime["player_rig"]["bpg_scene_door_struggle"] = 0.1;
  level.scr_anim["player_rig"]["bpg_scene_door_success"] = % emb_bpg_020_hostage_door_sucess_plr;
  level.scr_goaltime["player_rig"]["bpg_scene_door_success"] = 1.0;
  scripts\common\anim::addnotetrack_notify("player_rig", "start_aq", "start_aq", "bpg_scene_door_success");
  scripts\common\anim::addnotetrack_notify("player_rig", "kill_plr", "kill_plr", "bpg_scene_door_success");
  level.scr_anim["player_rig"]["bpg_scene_door_success_branch"] = % emb_bpg_020_hostage_door_sucess_branch_plr;
  level.scr_goaltime["player_rig"]["bpg_scene_door_success_branch"] = 1.0;
  scripts\common\anim::addnotetrack_notify("player_rig", "start_aq", "start_aq", "bpg_scene_door_success_branch");
  scripts\common\anim::addnotetrack_notify("player_rig", "kill_plr", "kill_plr", "bpg_scene_door_success_branch");
  level.scr_anim["player_rig"]["bpg_scene_door_release"] = % emb_bpg_020_hostage_door_release_plr;
  level.scr_anim["player_rig"]["saferoom_enter"] = % emb_cctv_010_saferoom_enter_vmdoor_plr;
  level.scr_anim["player_rig"]["cctv_enter"] = % emb_cctv_010_saferoom_screenlook_plr;
  level.scr_anim["player_rig"]["cctv_exit"] = % emb_cctv_010_saferoom_screenexit_plr;
  scripts\common\anim::addnotetrack_customfunction("player_rig", "add_fov_user_scale_override", ::cctv_enter_add_fov_user_scale_override, "cctv_enter");
  level.scr_anim["player_rig"]["gar_meetup_exit"] = % emb_gar_010_meetup_exit_player;
  scripts\common\anim::addnotetrack_notify("player_rig", "card_swipe", "card_reader_swap", "gar_meetup_exit");
  level.scr_anim["player_rig"]["res_arrival_scene"] = % emb_res_010_arrival_scene_plr;
  level.scr_anim["player_rig"]["wolf_escapes"] = % emb_exfil_010_wolfescapes_plr;
  scripts\common\anim::addnotetrack_customfunction("player_rig", "hide_viewmodel", ::emb_nt_hide_viewmodel, "wolf_escapes");
  level.scr_anim["player_rig"]["wolf_escapes_cam"] = % emb_exfil_010_wolfescapes_3p;
  level.scr_goaltime["player_rig"]["wolf_escapes_cam"] = 0;
  level.scr_anim["player_rig"]["heart_to_heart"] = % emb_def_050_triage_scene_player;
  level.scr_anim["player_rig"]["player_mortar_fire"] = % emb_vm_mortar_player;
  scripts\common\anim::addnotetrack_customfunction("player_rig", "mortar_add_fov_user_scale", ::mortar_add_fov_user_scale, "player_mortar_fire");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "mortar_remove_fov_user_scale", ::mortar_remove_fov_user_scale, "player_mortar_fire");
  level.scr_anim["player_rig"]["mortar_boost"] = % emb_def_065_boost_scene_plyr;
}

#using_animtree("generic_human");

humans() {
  level.scr_anim["civ_driver"]["driver_idle"][0] = % sdr_com_veh8_techo_driver_idle;
  level.scr_anim["civ_driver"]["driver_death"] = % emb_def_truck_driver_death;
  level.scr_anim["emp_stand_pain_01"]["flare_drop"][0] = % emp_stand_pain_01;
  level.scr_anim["kyle"]["infil_crash_ride"] = % emb_infil_010_crash_ride_kyle;
  scripts\common\anim::addnotetrack_mayhemstart("kyle", "mayhem_start", %emb_infil_010_crash_ride_kyle_face, "infil_crash_ride");
  scripts\common\anim::addnotetrack_mayhemend("kyle", "mayhem_end", %emb_infil_010_crash_ride_kyle_face, "infil_crash_ride");
  level.scr_anim["kyle"]["cctv_exit"] = % emb_cctv_010_saferoom_screenexit_3p_kyle;
  scripts\common\anim::addnotetrack_mayhemstart("kyle", "mayhem_start", %emb_cctv_010_saferoom_screenexit_3p_kyle_face, "cctv_exit");
  scripts\common\anim::addnotetrack_mayhemend("kyle", "mayhem_end", %emb_cctv_010_saferoom_screenexit_3p_kyle_face, "cctv_exit");
  level.scr_anim["price"]["infil_crash_ride"] = % emb_infil_010_crash_ride_price;
  scripts\common\anim::addnotetrack_notify("price", "price_opens_door", "price_opens_door", "infil_crash_ride");
  scripts\common\anim::addnotetrack_mayhemstart("price", "mayhem_start", %emb_infil_010_crash_ride_price_face, "infil_crash_ride", 1);
  scripts\common\anim::addnotetrack_mayhemend("price", "mayhem_end", %emb_infil_010_crash_ride_price_face, "infil_crash_ride", 1);
  level.scr_anim["price"]["infil_crash_crawl"] = % emb_infil_010_crash_crawl_price;
  level.scr_goaltime["price"]["infil_crash_crawl"] = 0.1;
  scripts\common\anim::addnotetrack_notify("price", "vo_dx_vom_pri_intro_flyin_170", "bailout_vo_start", "infil_crash_crawl");
  level.scr_anim["price"]["infil_crash_crawl_idle"][0] = % emb_infil_010_crash_crawl_idle_price;
  level.scr_anim["price"]["infil_crash_fall_relative"] = % emb_infil_010_crash_fall_relative_price;
  level.scr_anim["price"]["infil_crash_fall"] = % emb_infil_010_crash_fall_price;
  level.scr_goaltime["price"]["infil_crash_fall"] = 0.0;
  scripts\common\anim::addnotetrack_notify("price", "rack_to_helo", "rack_to_helo", "infil_crash_fall");
  scripts\common\anim::addnotetrack_notify("price", "rack_to_price", "rack_to_price", "infil_crash_fall");
  scripts\common\anim::addnotetrack_notify("price", "rack_to_zero", "rack_to_zero", "infil_crash_fall");
  scripts\common\anim::addnotetrack_notify("price", "price_hit_ground", "price_lands", "infil_crash_fall");
  scripts\common\anim::addnotetrack_notify("price", "spawn_hat", "spawn_hat", "infil_crash_fall");
  scripts\common\anim::addnotetrack_mayhemstart("price", "mayhem_start", %emb_infil_010_crash_fall_price_face, "infil_crash_fall", 1);
  scripts\common\anim::addnotetrack_mayhemend("price", "mayhem_end", %emb_infil_010_crash_fall_price_face, "infil_crash_fall", 1);
  level.scr_anim["price"]["roof_stair_idle"][0] = % emb_infil_011_stair_idle_price;
  level.scr_anim["price"]["roof_stair_idle_nags"][0] = % emb_infil_011_stair_nag_price;
  scripts\common\anim::addnotetrack_notify("price", "nag", "nag", "roof_stair_idle_nags");
  level.scr_anim["price"]["roof_stair_to_office"] = % emb_infil_011_stair_enter_price;
  level.scr_goaltime["price"]["roof_stair_to_office"] = 0.2;
  scripts\common\anim::addnotetrack_customfunction("price", "start_vo", ::roof_to_stairs_vo, "roof_stair_to_office");
  level.scr_anim["price"]["offices_idle"][0] = % emb_infil_030_offices_idle_price;
  level.scr_anim["price"]["offices_idle_nags"][0] = % emb_infil_030_offices_nag_price;
  scripts\common\anim::addnotetrack_notify("price", "nag", "nag", "offices_idle_nags");
  level.scr_anim["price"]["offices_chaos"] = % emb_infil_030_offices_price;
  scripts\common\anim::addnotetrack_customfunction("price", "Start_group_E", ::cue_exit_civs, "offices_chaos");
  level.scr_anim["price"]["stairwell_door_idle"][0] = % emb_bpg_005_price_stairs_idle_a;
  level.scr_anim["price"]["stairwell_door"] = % emb_bpg_005_price_stairs_down_a;
  level.scr_goaltime["price"]["stairwell_door"] = 0.2;
  level.scr_anim["price"]["stairwell_b_down"] = % emb_bpg_005_price_stairs_down_b;
  level.scr_anim["price"]["stairwell_b_intro"] = % emb_bpg_005_price_stairs_intro_idle_b;
  level.scr_anim["price"]["stairwell_b_idle"][0] = % emb_bpg_005_price_stairs_idle_b;
  level.scr_anim["price"]["stairwell_b_outro"] = % emb_bpg_005_price_stairs_outro_idle_b;
  level.scr_anim["price"]["stairwell_c_down"] = % emb_bpg_005_price_stairs_down_c;
  level.scr_anim["price"]["stairwell_c_intro"] = % emb_bpg_005_price_stairs_intro_idle_c;
  level.scr_anim["price"]["stairwell_c_idle"][0] = % emb_bpg_005_price_stairs_idle_c;
  level.scr_anim["price"]["stairwell_c_outro"] = % emb_bpg_005_price_stairs_outro_idle_c;
  level.scr_anim["price"]["stairwell_d_break_door"] = % emb_bpg_005_price_stairs_break_door_d;
  level.scr_anim["price"]["stairwell_d_intro"] = % emb_bpg_005_price_stairs_intro_idle_d;
  level.scr_anim["price"]["stairwell_d_idle"][0] = % emb_bpg_005_price_stairs_idle_d;
  level.scr_anim["price"]["stairwell_d_outro"] = % emb_bpg_005_price_stairs_outro_idle_d;
  scripts\common\anim::addnotetrack_customfunction("price", "start_vo", ::md_vo, "stairwell_d_break_door");
  level.scr_anim["pilot"]["infil_crash_ride"] = % emb_infil_010_crash_ride_pilot;
  level.scr_anim["pilot"]["infil_crash_crawl"] = % emb_infil_010_crash_crawl_pilot;
  level.scr_anim["pilot"]["infil_crash_crawl_idle"][0] = % emb_infil_010_crash_crawl_idle_pilot;
  level.scr_anim["pilot"]["infil_crash_fall"] = % emb_infil_010_crash_fall_pilot;
  level.scr_goaltime["pilot"]["infil_crash_fall"] = 1.0;
  level.scr_anim["civ_1"]["stairwell_d_break_door"] = % emb_bpg_005_civ01_stairs_break_door_d;
  level.scr_anim["civ_1"]["stairwell_d_break_door_idle"][0] = % emb_bpg_005_civ01_stairs_break_door_idle_d;
  level.scr_anim["civ_2"]["stairwell_d_break_door"] = % emb_bpg_005_civ02_stairs_break_door_d;
  level.scr_anim["civ_2"]["stairwell_d_break_door_idle"][0] = % emb_bpg_005_civ02_stairs_break_door_idle_d;
  level.scr_anim["doorbust_guy"]["door_bust"] = % sh_sch_060_doorbustl_enemy;
  level.scr_anim["doorbust_guy"]["stairs_death"] = % sh_sch_060_doorbustl_death;
  level.scr_anim["aq_leader"]["compound_charge"] = % emb_leader_charge_getup_enemy;
  level.scr_anim["aq_88"]["first_wave_idle"][0] = % emb_enemy_first_wave_start_idle;
  level.scr_anim["aq_88"]["first_wave_gun_pump_1"] = % emb_enemy_first_wave_gun_pump_01;
  level.scr_anim["aq_88"]["first_wave_gun_pump_2"] = % emb_enemy_first_wave_gun_pump_02;
  level.scr_anim["aq_mortar"]["flare_enter_aq"] = % emb_wm_mortar_enter_alex;
  level.scr_anim["aq_mortar"]["flare_aq_idle"][0] = % emb_wm_mortar_idle_alex;
  level.scr_anim["aq_mortar"]["flare_launch_aq"] = % emb_wm_mortar_launch_alex;
  level.scr_anim["aq_mortar"]["flare_reload_aq"] = % emb_wm_mortar_reload_alex;
  level.scr_anim["aq_mortar"]["flare_exit_aq"] = % emb_wm_mortar_exit_alex;
  level.scr_anim["aq_mortar"]["mortar_guy_death"] = % emb_def_075_mortarhouse_mortardeath_scene_mortarman;
  level.scr_anim["aq_89"]["truck_death"] = % emb_def_truck_driver_death;
  scripts\common\anim::addnotetrack_customfunction("aq_89", "kill_me", ::kill_me_no_anim, "truck_death");
  level.scr_anim["rocketeer_1"]["infil_crash_ride"] = % emb_infil_010_crash_roof_guy01;
  level.scr_anim["rocketeer_2"]["infil_crash_ride"] = % emb_infil_010_crash_roof_guy02;
  level.scr_anim["aq_enforcer"]["gate_overrun_idle"][0] = % emb_infil_10_crash_bg_idle_alqmain;
  level.scr_anim["aq_enforcer"]["gate_overrun"] = % emb_infil_10_crash_bg_alqmain;
  level.scr_anim["mob_aq_fight_1"]["gate_overrun_idle"][0] = % emb_infil_10_crash_bg_idle_alq01;
  level.scr_anim["mob_aq_fight_1"]["gate_overrun"] = % emb_infil_10_crash_bg_alq01;
  level.scr_anim["mob_aq_fight_2"]["gate_overrun_idle"][0] = % emb_infil_10_crash_bg_idle_alq04;
  level.scr_anim["mob_aq_fight_2"]["gate_overrun"] = % emb_infil_10_crash_bg_alq04;
  level.scr_anim["mob_aq_fight_3"]["gate_overrun_idle"][0] = % emb_infil_10_crash_bg_idle_alq05;
  level.scr_anim["mob_aq_fight_3"]["gate_overrun"] = % emb_infil_10_crash_bg_alq05;
  level.scr_anim["mob_aq_fight_4"]["gate_overrun_idle"][0] = % emb_infil_10_crash_bg_idle_alq06;
  level.scr_anim["mob_aq_fight_4"]["gate_overrun"] = % emb_infil_10_crash_bg_alq06;
  level.scr_anim["mob_aq_fight_5"]["gate_overrun_idle"][0] = % emb_infil_10_crash_bg_idle_alq07;
  level.scr_anim["mob_aq_fight_5"]["gate_overrun"] = % emb_infil_10_crash_bg_alq07;
  level.scr_anim["mob_aq_fight_6"]["gate_overrun_idle"][0] = % emb_infil_10_crash_bg_idle_alq08;
  level.scr_anim["mob_aq_fight_6"]["gate_overrun"] = % emb_infil_10_crash_bg_alq08;
  level.scr_anim["mob_aq_1"]["gate_overrun_idle"][0] = % emb_infil_10_crash_bg_idle_alq15;
  level.scr_anim["mob_aq_1"]["gate_overrun"] = % emb_infil_10_crash_bg_alq15;
  level.scr_anim["mob_aq_2"]["gate_overrun_idle"][0] = % emb_infil_10_crash_bg_idle_civ01;
  level.scr_anim["mob_aq_2"]["gate_overrun"] = % emb_infil_10_crash_bg_civ01;
  level.scr_anim["mob_aq_3"]["gate_overrun_idle"][0] = % emb_infil_10_crash_bg_idle_civ04;
  level.scr_anim["mob_aq_3"]["gate_overrun"] = % emb_infil_10_crash_bg_civ04;
  level.scr_anim["mob_aq_4"]["gate_overrun_idle"][0] = % emb_infil_10_crash_bg_idle_civ05;
  level.scr_anim["mob_aq_4"]["gate_overrun"] = % emb_infil_10_crash_bg_civ05;
  level.scr_anim["mob_aq_5"]["gate_overrun_idle"][0] = % emb_infil_10_crash_bg_idle_civ06;
  level.scr_anim["mob_aq_5"]["gate_overrun"] = % emb_infil_10_crash_bg_civ06;
  level.scr_anim["mob_aq_6"]["gate_overrun_idle"][0] = % emb_infil_10_crash_bg_idle_civ07;
  level.scr_anim["mob_aq_6"]["gate_overrun"] = % emb_infil_10_crash_bg_civ07;
  level.scr_anim["mob_aq_7"]["gate_overrun_idle"][0] = % emb_infil_10_crash_bg_idle_civ10;
  level.scr_anim["mob_aq_7"]["gate_overrun"] = % emb_infil_10_crash_bg_civ10;
  level.scr_anim["mob_aq_8"]["gate_overrun_idle"][0] = % emb_infil_10_crash_bg_idle_civ11;
  level.scr_anim["mob_aq_8"]["gate_overrun"] = % emb_infil_10_crash_bg_civ11;
  level.scr_anim["mob_aq_9"]["gate_overrun_idle"][0] = % emb_infil_10_crash_bg_idle_civ12;
  level.scr_anim["mob_aq_9"]["gate_overrun"] = % emb_infil_10_crash_bg_civ12;
  level.scr_anim["mob_aq_10"]["gate_overrun_idle"][0] = % emb_infil_10_crash_bg_idle_civ13;
  level.scr_anim["mob_aq_10"]["gate_overrun"] = % emb_infil_10_crash_bg_civ13;
  level.scr_anim["mob_aq_11"]["gate_overrun_idle"][0] = % emb_infil_10_crash_bg_idle_civ14;
  level.scr_anim["mob_aq_11"]["gate_overrun"] = % emb_infil_10_crash_bg_civ14;
  level.scr_anim["mob_aq_12"]["gate_overrun_idle"][0] = % emb_infil_10_crash_bg_idle_alq09;
  level.scr_anim["mob_aq_12"]["gate_overrun"] = % emb_infil_10_crash_bg_alq09;
  level.scr_anim["mob_aq_13"]["gate_overrun_idle"][0] = % emb_infil_10_crash_bg_idle_alq11;
  level.scr_anim["mob_aq_13"]["gate_overrun"] = % emb_infil_10_crash_bg_alq11;
  level.scr_anim["mob_aq_14"]["gate_overrun_idle"][0] = % emb_infil_10_crash_bg_idle_alq13;
  level.scr_anim["mob_aq_14"]["gate_overrun"] = % emb_infil_10_crash_bg_alq13;
  level.scr_anim["mob_aq_15"]["gate_overrun_idle"][0] = % emb_infil_10_crash_bg_idle_alq14;
  level.scr_anim["mob_aq_15"]["gate_overrun"] = % emb_infil_10_crash_bg_alq14;
  level.scr_anim["mob_civ_1"]["gate_overrun_idle"][0] = % emb_infil_10_crash_bg_idle_alq02;
  level.scr_anim["mob_civ_1"]["gate_overrun"] = % emb_infil_10_crash_bg_alq02;
  level.scr_anim["mob_civ_2"]["gate_overrun_idle"][0] = % emb_infil_10_crash_bg_idle_alq03;
  level.scr_anim["mob_civ_2"]["gate_overrun"] = % emb_infil_10_crash_bg_alq03;
  level.scr_anim["mob_civ_3"]["gate_overrun_idle"][0] = % emb_infil_10_crash_bg_idle_alq10;
  level.scr_anim["mob_civ_3"]["gate_overrun"] = % emb_infil_10_crash_bg_alq10;
  level.scr_anim["mob_civ_4"]["gate_overrun_idle"][0] = % emb_infil_10_crash_bg_idle_alq12;
  level.scr_anim["mob_civ_4"]["gate_overrun"] = % emb_infil_10_crash_bg_alq12;
  level.scr_anim["mob_civ_5"]["gate_overrun_idle"][0] = % emb_infil_10_crash_bg_idle_alq16;
  level.scr_anim["mob_civ_5"]["gate_overrun"] = % emb_infil_10_crash_bg_alq16;
  level.scr_anim["mob_civ_6"]["gate_overrun_idle"][0] = % emb_infil_10_crash_bg_idle_civ02;
  level.scr_anim["mob_civ_6"]["gate_overrun"] = % emb_infil_10_crash_bg_civ02;
  level.scr_anim["mob_civ_7"]["gate_overrun_idle"][0] = % emb_infil_10_crash_bg_idle_civ03;
  level.scr_anim["mob_civ_7"]["gate_overrun"] = % emb_infil_10_crash_bg_civ03;
  level.scr_anim["mob_civ_8"]["gate_overrun_idle"][0] = % emb_infil_10_crash_bg_idle_civ08;
  level.scr_anim["mob_civ_8"]["gate_overrun"] = % emb_infil_10_crash_bg_civ08;
  level.scr_anim["mob_civ_9"]["gate_overrun_idle"][0] = % emb_infil_10_crash_bg_idle_civ09;
  level.scr_anim["mob_civ_9"]["gate_overrun"] = % emb_infil_10_crash_bg_civ09;
  level.scr_anim["mob_civ_10"]["gate_overrun_idle"][0] = % emb_infil_10_crash_bg_idle_civ15;
  level.scr_anim["mob_civ_10"]["gate_overrun"] = % emb_infil_10_crash_bg_civ15;
  level.scr_anim["mob_civ_gate_climber"]["climb_gate_1"] = % emb_infil_climbing_fence_civ01;
  level.scr_anim["mob_civ_gate_climber"]["climb_gate_2"] = % emb_infil_climbing_fence_civ03;
  level.scr_anim["office_manager"]["offices_chaos"] = % emb_infil_030_offices_manager;
  level.scr_anim["office_manager"]["offices_idle"][0] = % emb_infil_030_offices_idle_manager;
  level.scr_anim["office_civ_phone_lady"]["offices_chaos"] = % emb_infil_030_offices_civ11;
  level.scr_anim["office_civ_phone_lady"]["offices_idle"][0] = % emb_infil_030_offices_idle_civ11;
  level.scr_anim["office_civ_1"]["offices_chaos"] = % emb_infil_030_offices_civ01;
  level.scr_anim["office_civ_1"]["offices_idle"][0] = % emb_infil_030_offices_idle_civ01;
  level.scr_anim["office_civ_2"]["offices_chaos"] = % emb_infil_030_offices_civ02;
  level.scr_anim["office_civ_2"]["offices_idle"][0] = % emb_infil_030_offices_idle_civ02;
  level.scr_anim["office_civ_3"]["offices_chaos"] = % emb_infil_030_offices_civ03;
  level.scr_anim["office_civ_3"]["offices_idle"][0] = % emb_infil_030_offices_idle_civ03;
  level.scr_anim["office_civ_4"]["offices_idle"][0] = % emb_infil_030_offices_idle_civ04;
  level.scr_anim["office_civ_5"]["offices_chaos"] = % emb_infil_030_offices_civ05;
  level.scr_anim["office_civ_5"]["offices_idle"][0] = % emb_infil_030_offices_idle_civ05;
  level.scr_anim["office_civ_6"]["offices_chaos"] = % emb_infil_030_offices_civ06;
  level.scr_anim["office_civ_6"]["offices_idle"][0] = % emb_infil_030_offices_idle_civ06;
  level.scr_anim["office_civ_7"]["offices_chaos"] = % emb_infil_030_offices_civ07;
  level.scr_anim["office_civ_7"]["offices_idle"][0] = % emb_infil_030_offices_idle_civ07;
  level.scr_anim["office_civ_8"]["offices_chaos"] = % emb_infil_030_offices_civ08;
  level.scr_anim["office_civ_8"]["offices_idle"][0] = % emb_infil_030_offices_idle_civ08;
  level.scr_anim["office_civ_9"]["offices_chaos"] = % emb_infil_030_offices_civ09;
  level.scr_anim["office_civ_9"]["offices_idle"][0] = % emb_infil_030_offices_idle_civ09;
  level.scr_anim["office_civ_10"]["offices_chaos"] = % emb_infil_030_offices_civ10;
  level.scr_anim["office_civ_10"]["offices_idle"][0] = % emb_infil_030_offices_idle_civ10;
  level.scr_anim["office_civ_11"]["offices_chaos"] = % emb_infil_030_offices_civ23;
  level.scr_anim["office_civ_11"]["offices_idle"][0] = % emb_infil_030_offices_idle_civ23;
  level.scr_anim["office_civ_12"]["offices_chaos"] = % emb_infil_030_offices_civ12;
  level.scr_anim["office_civ_12"]["offices_idle"][0] = % emb_infil_030_offices_idle_civ12;
  level.scr_anim["office_civ_13"]["offices_chaos"] = % emb_infil_030_offices_civ13;
  level.scr_anim["office_civ_13"]["offices_idle"][0] = % emb_infil_030_offices_idle_civ13;
  level.scr_anim["office_civ_14"]["offices_idle"][0] = % emb_infil_030_offices_idle_civ17;
  level.scr_anim["office_civ_15"]["offices_chaos"] = % emb_infil_030_offices_civ18;
  level.scr_anim["office_civ_15"]["offices_idle"][0] = % emb_infil_030_offices_idle_civ18;
  level.scr_anim["office_civ_16"]["offices_chaos"] = % emb_infil_030_offices_civ19;
  level.scr_anim["office_civ_16"]["offices_idle"][0] = % emb_infil_030_offices_idle_civ19;
  level.scr_anim["office_civ_17"]["offices_chaos"] = % emb_infil_030_offices_civ20;
  level.scr_anim["office_civ_17"]["offices_idle"][0] = % emb_infil_030_offices_idle_civ20;
  level.scr_anim["office_civ_18"]["offices_chaos"] = % emb_infil_030_offices_civ21;
  level.scr_anim["office_civ_18"]["offices_idle"][0] = % emb_infil_030_offices_idle_civ21;
  level.scr_anim["office_civ_19"]["offices_chaos"] = % emb_infil_030_offices_civ22;
  level.scr_anim["office_civ_19"]["offices_idle"][0] = % emb_infil_030_offices_idle_civ22;
  scripts\common\anim::addnotetrack_customfunction("office_civ_6", "start", ::office_side_vo_1, "offices_chaos");
  scripts\common\anim::addnotetrack_customfunction("office_civ_phone_lady", "start", ::office_side_vo_2, "offices_chaos");
  level.scr_anim["office_avoid_civ_1"]["offices_idle"][0] = % emb_infil_030_offices_idle_civ14;
  level.scr_anim["office_avoid_civ_1"]["offices_chaos"] = % emb_infil_030_offices_civ14;
  level.scr_anim["office_avoid_civ_1"]["offices_idle_2"][0] = % emb_infil_030_offices_idle2_civ14;
  level.scr_anim["office_avoid_civ_2"]["offices_idle"][0] = % emb_infil_030_offices_idle_civ15;
  level.scr_anim["office_avoid_civ_2"]["offices_chaos"] = % emb_infil_030_offices_civ15;
  level.scr_anim["office_avoid_civ_2"]["offices_idle_2"][0] = % emb_infil_030_offices_idle2_civ15;
  level.scr_anim["office_idle_only_civ"]["offices_idle_2"][0] = % emb_infil_030_offices_idle2_civ24;
  scripts\common\anim::addnotetrack_customfunction("office_idle_only_civ", "start", ::office_side_vo_3, "offices_idle_2");
  level.scr_anim["office_civ_key_guy"]["offices_idle"][0] = % emb_infil_030_offices_idle_civ16_keyguy;
  level.scr_anim["office_civ_key_guy"]["offices_idle_2"][0] = % emb_infil_030_offices_idle2_civ16_keyguy;
  level.scr_anim["office_civ_key_guy"]["offices_key"] = % emb_infil_030_offices_civ16_keyguy;
  scripts\common\anim::addnotetrack_customfunction("office_civ_key_guy", "attach_keycard", ::attach_keycard_left, "offices_key");
  scripts\common\anim::addnotetrack_notify("office_civ_key_guy", "card_swipe", "card_reader_swap", "offices_key");
  scripts\common\anim::addnotetrack_notify("office_civ_key_guy", "detach_keycard", "detach_keycard", "offices_key");
  level.scr_anim["civ"]["stairwell_second_window"] = % sh_nh_022_carstop_b_civ01;
  level.scr_anim["aq"]["stairwell_second_window"] = % sh_nh_022_carstop_b_enmy01;
  level.scr_anim["aq_enforcer"]["bpg_md_door_enter"] = % emb_bpg_010_md_scenec_enter_aq26;
  level.scr_anim["aq_enforcer"]["bpg_md_door_idle"][0] = % emb_bpg_010_md_scenec_idle_aq26;
  level.scr_anim["aq_enforcer"]["bpg_md_first_wave"] = % emb_bpg_010_md_scenec_aq26;
  scripts\common\anim::addnotetrack_customfunction("aq_enforcer", "emb_pistol_fire", ::enforcer_pistol_fire, "bpg_md_first_wave");
  level.scr_anim["aq_entourage_1"]["bpg_md_door_enter"] = % emb_bpg_010_md_enter_aq02;
  level.scr_anim["aq_entourage_1"]["bpg_md_door_idle"][0] = % emb_bpg_010_md_idle_aq02;
  level.scr_anim["aq_entourage_1"]["bpg_md_first_wave"] = % emb_bpg_010_md_scenea_aq02;
  level.scr_goaltime["aq_entourage_1"]["bpg_md_first_wave"] = 1.0;
  level.scr_anim["aq_entourage_2"]["bpg_md_door_enter"] = % emb_bpg_010_md_enter_aq03;
  level.scr_anim["aq_entourage_2"]["bpg_md_door_idle"][0] = % emb_bpg_010_md_idle_aq03;
  level.scr_anim["aq_entourage_2"]["bpg_md_first_wave"] = % emb_bpg_010_md_scenea_aq03;
  level.scr_goaltime["aq_entourage_2"]["bpg_md_first_wave"] = 1.0;
  level.scr_anim["aq_entourage_3"]["bpg_md_door_enter"] = % emb_bpg_010_md_enter_aq08;
  level.scr_anim["aq_entourage_3"]["bpg_md_door_idle"][0] = % emb_bpg_010_md_idle_aq08;
  level.scr_anim["aq_entourage_3"]["bpg_md_first_wave"] = % emb_bpg_010_md_scenea_aq08;
  level.scr_goaltime["aq_entourage_3"]["bpg_md_first_wave"] = 1.0;
  level.scr_anim["aq_entourage_4"]["bpg_md_door_enter"] = % emb_bpg_010_md_enter_aq09;
  level.scr_anim["aq_entourage_4"]["bpg_md_door_idle"][0] = % emb_bpg_010_md_idle_aq09;
  level.scr_anim["aq_entourage_4"]["bpg_md_first_wave"] = % emb_bpg_010_md_scenea_aq09;
  level.scr_goaltime["aq_entourage_4"]["bpg_md_first_wave"] = 1.0;
  level.scr_anim["aq_entourage_5"]["bpg_md_door_enter"] = % emb_bpg_010_md_enter_aq05;
  level.scr_anim["aq_entourage_5"]["bpg_md_door_idle"][0] = % emb_bpg_010_md_idle_aq05;
  level.scr_anim["aq_entourage_5"]["bpg_md_first_wave"] = % emb_bpg_010_md_scenea_aq05;
  level.scr_goaltime["aq_entourage_5"]["bpg_md_first_wave"] = 1.0;
  level.scr_anim["aq_entourage_6"]["bpg_md_door_enter"] = % emb_bpg_010_md_enter_aq17;
  level.scr_anim["aq_entourage_6"]["bpg_md_door_idle"][0] = % emb_bpg_010_md_idle_aq17;
  level.scr_anim["aq_entourage_6"]["bpg_md_first_wave"] = % emb_bpg_010_md_sceneb_aq17;
  level.scr_goaltime["aq_entourage_6"]["bpg_md_first_wave"] = 1.0;
  level.scr_anim["aq_entourage_7"]["bpg_md_door_enter"] = % emb_bpg_010_md_enter_aq15;
  level.scr_anim["aq_entourage_7"]["bpg_md_door_idle"][0] = % emb_bpg_010_md_idle_aq15;
  level.scr_anim["aq_entourage_7"]["bpg_md_first_wave"] = % emb_bpg_010_md_sceneb_aq15;
  level.scr_goaltime["aq_entourage_7"]["bpg_md_first_wave"] = 1.0;
  level.scr_anim["aq_entourage_8"]["bpg_md_door_enter"] = % emb_bpg_010_md_scenec_enter_aq25;
  level.scr_anim["aq_entourage_8"]["bpg_md_door_idle"][0] = % emb_bpg_010_md_scenec_idle_aq25;
  level.scr_anim["aq_entourage_8"]["bpg_md_first_wave"] = % emb_bpg_010_md_scenec_aq25;
  level.scr_goaltime["aq_entourage_8"]["bpg_md_first_wave"] = 1.0;
  level.scr_anim["security_1"]["bpg_md_first_wave"] = % emb_bpg_010_md_scenea_security01;
  level.scr_anim["security_2"]["bpg_md_first_wave"] = % emb_bpg_010_md_scenea_security02;
  level.scr_anim["security_3"]["bpg_md_first_wave"] = % emb_bpg_010_md_scenec_security04;
  level.scr_anim["security_4"]["bpg_md_first_wave"] = % emb_bpg_010_md_scenec_security05;
  level.scr_anim["aq_one_off_table"]["bpg_md_first_wave"] = % emb_bpg_010_md_scenec_aq29;
  scripts\common\anim::addnotetrack_customfunction("aq_one_off_table", "sfx_glass_crack_06a", ::sfx_glass_crack_06a, "bpg_md_first_wave");
  scripts\common\anim::addnotetrack_customfunction("aq_one_off_table", "sfx_glass_crack_06b", ::sfx_glass_crack_06b, "bpg_md_first_wave");
  scripts\common\anim::addnotetrack_customfunction("aq_one_off_table", "sfx_glass_crack_06c", ::sfx_glass_crack_06c, "bpg_md_first_wave");
  level.scr_anim["price"]["bpg_scene_entrance"] = % emb_enf_020_hostage_enter_price;
  level.scr_anim["price"]["bpg_scene_entrance_idle"][0] = % emb_enf_020_hostage_idlea_price;
  level.scr_anim["price"]["bpg_scene_entrance_idle_nags"][0] = % emb_enf_020_hostage_idlea_nag_price;
  level.scr_anim["price"]["bpg_scene"] = % emb_enf_020_hostage_scenea_price;
  level.scr_anim["price"]["bpg_scene_escape_idle"][0] = % emb_enf_020_hostage_idlec_price;
  level.scr_anim["price"]["bpg_scene_escape_idle_nags"][0] = % emb_enf_020_hostage_exit_nag_price;
  level.scr_anim["price"]["bpg_scene_escape_exit"] = % emb_enf_020_hostage_exit_price;
  scripts\common\anim::addnotetrack_customfunction("price", "nag_line", ::bpg_scene_escape_idle_nag_vo, "bpg_scene_escape_idle_nags");
  scripts\common\anim::addnotetrack_customfunction("price", "push_door", ::bpg_scene_price_push_door, "bpg_scene");
  scripts\common\anim::addnotetrack_customfunction("price", "nag_vo", ::bpg_scene_price_vo_nag, "bpg_scene");
  level.scr_anim["bpg_scene_civ_mother"]["bpg_scene"] = % emb_enf_020_hostage_scenea_mother;
  level.scr_anim["bpg_scene_civ_mother"]["bpg_scene_escape_idle"][0] = % emb_enf_020_hostage_idlec_mother;
  level.scr_anim["bpg_scene_civ_mother"]["bpg_scene_exit"] = % emb_enf_020_hostage_exit_mother;
  level.scr_anim["bpg_scene_civ_marine"]["bpg_scene"] = % emb_enf_020_hostage_scenea_marine;
  level.scr_anim["bpg_scene_civ_marine"]["bpg_scene_escape_idle"][0] = % emb_enf_020_hostage_idlec_marine;
  level.scr_anim["bpg_scene_civ_marine"]["bpg_scene_exit"] = % emb_enf_020_hostage_exit_marine;
  scripts\common\anim::addnotetrack_flag("bpg_scene_civ_marine", "cleared_door", "bpg_scene_mar_cleared_door", "bpg_scene_exit");
  level.scr_anim["aq_enforcer"]["bpg_scene"] = % emb_enf_020_hostage_scenea_aq01;
  level.scr_anim["aq_enforcer"]["bpg_scene_door_success"] = % emb_bpg_020_hostage_door_interact_success_enforcer;
  level.scr_goaltime["aq_enforcer"]["bpg_scene_door_success"] = 0.5;
  level.scr_anim["aq_enforcer"]["bpg_scene_door_success_branch"] = % emb_bpg_020_hostage_door_interact_success_branch_enforcer;
  level.scr_goaltime["aq_enforcer"]["bpg_scene_door_success_branch"] = 1.0;
  scripts\common\anim::addnotetrack_customfunction("aq_enforcer", "headtrack_on", ::headtrack_on, "bpg_scene");
  scripts\common\anim::addnotetrack_customfunction("aq_enforcer", "headtrack_off", ::headtrack_off, "bpg_scene");
  scripts\common\anim::addnotetrack_flag("aq_enforcer", "kid_grabbed", "kid_grabbed", "bpg_scene");
  scripts\common\anim::addnotetrack_notify("aq_enforcer", "kid_killed", "kid_killed", "bpg_scene");
  level.scr_anim["bpg_scene_key_civ"]["bpg_scene"] = % emb_enf_020_hostage_scenea_civ06;
  scripts\common\anim::addnotetrack_customfunction("bpg_scene_key_civ", "attach_keycard", ::attach_keycard_right, "bpg_scene");
  scripts\common\anim::addnotetrack_notify("bpg_scene_key_civ", "detach_keycard", "detach_keycard", "bpg_scene");
  scripts\common\anim::addnotetrack_notify("bpg_scene_key_civ", "card_swipe", "card_reader_swap", "bpg_scene");
  level.scr_anim["bpg_scene_civ_escape_1"]["bpg_scene"] = % emb_enf_020_hostage_scenea_civ05;
  level.scr_anim["bpg_scene_civ_escape_1"]["bpg_scene_escape_idle"][0] = % emb_enf_020_hostage_idlec_civ05;
  level.scr_anim["bpg_scene_civ_escape_1"]["bpg_scene_exit"] = % emb_enf_020_hostage_exit_civ05;
  scripts\common\anim::addnotetrack_customfunction("bpg_scene_civ_escape_1", "start_vo", ::bpg_scene_civ_vo, "bpg_scene");
  level.scr_anim["bpg_scene_civ_escape_2"]["bpg_scene"] = % emb_enf_020_hostage_scenea_civ07;
  level.scr_anim["bpg_scene_civ_escape_2"]["bpg_scene_escape_idle"][0] = % emb_enf_020_hostage_idlec_civ07;
  level.scr_anim["bpg_scene_civ_escape_2"]["bpg_scene_exit"] = % emb_enf_020_hostage_exit_civ07;
  level.scr_anim["bpg_scene_civ_father"]["bpg_scene"] = % emb_enf_020_hostage_scenea_civ01;
  level.scr_anim["bpg_scene_civ_kid"]["bpg_scene"] = % emb_enf_020_hostage_scenea_civ02;
  level.scr_anim["bpg_scene_civ_kid"]["bpg_scene_door_success_branch"] = % emb_bpg_020_hostage_door_sucess_branch_child;
  level.scr_anim["bpg_scene_civ_1"]["bpg_scene"] = % emb_enf_020_hostage_scenea_civ11;
  level.scr_anim["bpg_scene_civ_2"]["bpg_scene"] = % emb_enf_020_hostage_scenea_civ10;
  level.scr_anim["bpg_scene_civ_3"]["bpg_scene"] = % emb_enf_020_hostage_scenea_civ12;
  level.scr_anim["bpg_scene_civ_4"]["bpg_scene"] = % emb_enf_020_hostage_scenea_civ08;
  level.scr_anim["bpg_scene_civ_5"]["bpg_scene"] = % emb_enf_020_hostage_scenea_civ09;
  level.scr_anim["aq_entourage_1"]["bpg_scene"] = % emb_enf_020_hostage_scenea_aq02;
  scripts\common\anim::addnotetrack_customfunction("aq_entourage_1", "sfx_glass_crack_03", ::sfx_glass_crack_03, "bpg_scene");
  level.scr_anim["aq_entourage_1"]["bpg_scene_escape_idle"][0] = % emb_enf_020_hostage_idlec_aq02;
  level.scr_anim["aq_entourage_1"]["bpg_scene_door_success"] = % emb_bpg_020_hostage_door_interact_success_terrorist02;
  level.scr_anim["aq_entourage_2"]["bpg_scene"] = % emb_enf_020_hostage_scenea_aq03;
  scripts\common\anim::addnotetrack_customfunction("aq_entourage_2", "sfx_glass_crack_05", ::sfx_glass_crack_05, "bpg_scene");
  level.scr_anim["aq_entourage_2"]["bpg_scene_escape_idle"][0] = % emb_enf_020_hostage_idlec_aq03;
  level.scr_anim["aq_entourage_3"]["bpg_scene"] = % emb_enf_020_hostage_scenea_aq04;
  scripts\common\anim::addnotetrack_customfunction("aq_entourage_3", "sfx_glass_crack_01", ::sfx_glass_crack_01, "bpg_scene");
  level.scr_anim["aq_entourage_3"]["bpg_scene_escape_idle"][0] = % emb_enf_020_hostage_idlec_aq04;
  level.scr_anim["aq_entourage_3"]["bpg_scene_door_success"] = % emb_bpg_020_hostage_door_interact_success_terrorist01;
  level.scr_anim["aq_entourage_4"]["bpg_scene"] = % emb_enf_020_hostage_scenea_aq05;
  scripts\common\anim::addnotetrack_customfunction("aq_entourage_4", "sfx_glass_crack_02", ::sfx_glass_crack_02, "bpg_scene");
  level.scr_anim["aq_entourage_4"]["bpg_scene_escape_idle"][0] = % emb_enf_020_hostage_idlec_aq05;
  level.scr_anim["aq_entourage_5"]["bpg_scene"] = % emb_enf_020_hostage_scenea_aq09;
  scripts\common\anim::addnotetrack_customfunction("aq_entourage_5", "sfx_glass_crack_04", ::sfx_glass_crack_04, "bpg_scene");
  level.scr_anim["aq_entourage_5"]["bpg_scene_escape_idle"][0] = % emb_enf_020_hostage_idlec_aq09;
  level.scr_anim["aq_entourage_6"]["bpg_scene"] = % emb_enf_020_hostage_scenea_aq06;
  level.scr_anim["aq_entourage_6"]["bpg_scene_escape_idle"][0] = % emb_enf_020_hostage_idlec_aq06;
  level.scr_anim["aq_basher_1"]["bpg_scene"] = % emb_enf_020_hostage_scenea_aq15;
  level.scr_anim["aq_basher_2"]["bpg_scene"] = % emb_enf_020_hostage_scenea_aq13;
  level.scr_anim["aq_basher_3"]["bpg_scene"] = % emb_enf_020_hostage_scenea_aq14;
  level.scr_anim["flavor_truck_passenger_1"]["flavor_truck_drive_by"] = % emb_truck_005_drive_enemy01;
  level.scr_anim["flavor_truck_passenger_2"]["flavor_truck_drive_by"] = % emb_truck_005_drive_enemy02;
  level.scr_anim["flavor_truck_driver"]["flavor_truck_drive_by"][0] = % reb_vh_techo_driver_idle_search01;
  level.scr_anim["civ_box_guy"]["to_attack_idle"][0] = % emb_truck_010_attack_idle_civ01;
  level.scr_anim["civ_box_guy"]["to_attack_scene"] = % emb_truck_010_attack_scene_civ01;
  level.scr_anim["red_shirt"]["to_attack_idle"][0] = % emb_truck_010_attack_idle_ally02;
  level.scr_anim["red_shirt"]["to_attack_react"] = % emb_truck_010_attack_react_ally02;
  level.scr_anim["aq_1"]["to_attack_scene_ride"] = % emb_truck_010_attack_truckride_terry01;
  level.scr_anim["aq_1"]["to_attack_scene"] = % emb_truck_010_attack_scene_terry01;
  level.scr_anim["aq_2"]["to_attack_scene_ride"] = % emb_truck_010_attack_truckride_terry02;
  level.scr_anim["aq_2"]["to_attack_scene"] = % emb_truck_010_attack_scene_terry02;
  level.scr_anim["aq_driver"]["to_attack_scene_ride"] = % emb_truck_010_attack_truckride_driver;
  level.scr_anim["civ"]["casual_idle"][0] = % civ_casual_idle;
  level.scr_anim["civ"]["casual_idle_twitch_0"] = % civ_casual_idle_twitch_a;
  level.scr_anim["civ"]["casual_idle_twitch_1"] = % civ_casual_idle_twitch_b;
  level.scr_anim["civ"]["casual_idle_twitch_2"] = % civ_casual_idle_twitch_c;
  level.scr_anim["civ"]["casual_idle_twitch_3"] = % civ_casual_idle_twitch_d;
  level.scr_anim["civ"]["casual_idle_twitch_4"] = % civ_casual_idle_twitch_e;
  level.scr_anim["civ"]["truck_react_1"] = % civ_casual_frantic_exposed_idle_twitch_a;
  level.scr_goaltime["civ"]["truck_react_1"] = 0.25;
  level.scr_anim["civ"]["truck_react_2"] = % civ_casual_frantic_exposed_idle_twitch_b;
  level.scr_goaltime["civ"]["truck_react_2"] = 0.25;
  level.scr_anim["civ"]["truck_react_3"] = % civ_casual_frantic_exposed_idle_twitch_c;
  level.scr_goaltime["civ"]["truck_react_3"] = 0.25;
  level.scr_anim["bpgc_conf_aq"]["bpgc_conference"] = % emb_oc_005_conference_enemy;
  level.scr_anim["bpgc_conf_civ_1"]["bpgc_conference"] = % emb_oc_005_conference_civ01;
  level.scr_anim["bpgc_conf_civ_2"]["bpgc_conference"] = % emb_oc_005_conference_civ02;
  level.scr_anim["bpgc_hostage_aq"]["bpgc_hostage_enter"] = % emb_oc_010_hostage_alqatala_enter;
  level.scr_anim["bpgc_hostage_aq"]["bpgc_hostage_idle"] = % emb_oc_010_hostage_alqatala_idle;
  level.scr_anim["bpgc_hostage_aq"]["bpgc_hostage_exit"] = % emb_oc_010_hostage_alqatala_exita;
  scripts\common\anim::addnotetrack_notify("bpgc_hostage_aq", "fire", "hostage_aq_fired", "bpgc_hostage_exit");
  level.scr_anim["bpgc_hostage_aq"]["bpgc_hostage_death"] = % emb_oc_010_hostage_alqatala_exitb;
  level.scr_anim["bpgc_hostage_civ"]["bpgc_hostage_enter"] = % emb_oc_010_hostage_civ_enter;
  level.scr_anim["bpgc_hostage_civ"]["bpgc_hostage_idle"] = % emb_oc_010_hostage_civ_idle;
  level.scr_anim["bpgc_hostage_civ"]["bpgc_hostage_death"] = % emb_oc_010_hostage_civ_exita;
  level.scr_anim["bpgc_hostage_civ"]["bpgc_hostage_exit"] = % emb_oc_010_hostage_civ_exitb;
  level.scr_anim["bpgc_interrogation_civ_1"]["bpgc_interrogation"] = % emb_oc_015_execution_civ01;
  level.scr_anim["bpgc_interrogation_civ_2"]["bpgc_interrogation"] = % emb_oc_015_execution_civ02;
  level.scr_anim["bpgc_interrogation_aq"]["bpgc_interrogation"] = % emb_oc_015_execution_enemy;
  level.scr_anim["price"]["halligan_scene"] = % emb_oc_030_basement_door_price;
  scripts\common\anim::addnotetrack_customfunction("price", "breakout_A", ::halligan_breakout_a, "halligan_scene");
  scripts\common\anim::addnotetrack_customfunction("price", "breakout_B", ::halligan_breakout_b, "halligan_scene");
  scripts\common\anim::addnotetrack_customfunction("price", "breakout_end", ::halligan_breakout_end, "halligan_scene");
  level.scr_anim["price"]["halligan_breakout_a"] = % emb_oc_030_basement_door_price_breakout_a;
  level.scr_goaltime["price"]["halligan_breakout_a"] = 1.0;
  level.scr_anim["price"]["halligan_breakout_b"] = % emb_oc_030_basement_door_price_breakout_b;
  level.scr_goaltime["price"]["halligan_breakout_b"] = 1.0;
  level.scr_anim["price"]["halligan_end_idle"][0] = % sdr_com_cover_right_stand_hide_idle;
  level.scr_goaltime["price"]["halligan_end_idle"] = 0.2;
  level.scr_anim["price"]["halligan_end_nag"] = % sdr_com_cover_right_stand_hide_twitch03;
  level.scr_anim["price"]["halligan_end_exit"] = % sdr_cqb_cover_right_stand_fast_exit_8;
  level.scr_anim["enemy"]["halligan_scene"] = % emb_oc_030_basement_door_enemy01;
  level.scr_anim["enemy"]["halligan_breakout_a"] = % emb_oc_030_basement_door_enemy01_breakout_a;
  level.scr_goaltime["enemy"]["halligan_breakout_a"] = 1.0;
  level.scr_anim["enemy"]["halligan_breakout_b"] = % emb_oc_030_basement_door_enemy01_breakout_b;
  level.scr_goaltime["enemy"]["halligan_breakout_b"] = 1.0;
  level.scr_anim["dead_body"]["dying_crawl_death_v2"] = % dying_crawl_death_v2;
  level.scr_anim["dead_body"]["corner_standr_death_grenade_explode"] = % corner_standr_death_grenade_explode;
  level.scr_anim["dead_body"]["europa_storage_room_sdf_crawl_01_death"] = % europa_storage_room_sdf_crawl_01_death;
  level.scr_anim["dead_body"]["exposed_death_firing_02"] = % exposed_death_firing_02;
  level.scr_anim["dead_body"]["doorpeek_deatha"] = % doorpeek_deatha;
  level.scr_anim["sr_invader_crowguy"]["sr_door_buster"] = % emb_cctv_005_doorkick_enemy;
  scripts\common\anim::addnotetrack_customfunction("sr_invader_crowguy", "crowguy_vo", ::crowguy_vo, "sr_door_buster");
  level.scr_anim["price"]["sr_enter"] = % emb_cctv_010_saferoom_enter_price;
  level.scr_anim["price"]["sr_enter_idle"][0] = % emb_cctv_010_saferoom_enter_idle_price;
  level.scr_anim["price"]["sr_scene"] = % emb_cctv_010_saferoom_scene_price;
  level.scr_anim["price"]["sr_scene_idle"][0] = % emb_cctv_010_saferoom_scene_idle_price;
  level.scr_anim["price"]["sr_scene_idle_nag"] = % emb_cctv_010_saferoom_scene_nag_price;
  level.scr_anim["farah"]["sr_scene"] = % emb_cctv_010_saferoom_scene_farah;
  level.scr_anim["farah"]["sr_scene_idle"][0] = % emb_cctv_010_saferoom_scene_idle_farah;
  level.scr_anim["farah"]["sr_scene_react"] = % emb_cctv_010_saferoom_scene_react_farah;
  level.scr_anim["alex"]["sr_scene"] = % emb_cctv_010_saferoom_scene_alex;
  level.scr_anim["alex"]["sr_scene_idle"][0] = % emb_cctv_010_saferoom_scene_idle_alex;
  level.scr_anim["alex"]["sr_scene_idle_nag"] = % emb_cctv_010_saferoom_scene_nag_alex;
  level.scr_anim["hadir"]["sr_scene"] = % emb_cctv_010_saferoom_scene_hadir;
  level.scr_anim["hadir"]["sr_scene_idle"][0] = % emb_cctv_010_saferoom_scene_idle_hadir;
  level.scr_anim["hadir"]["sr_scene_react"] = % emb_cctv_010_saferoom_scene_react_hadir;
  level.scr_anim["wolf"]["sr_scene"] = % emb_cctv_010_saferoom_scene_wolf;
  level.scr_anim["wolf"]["sr_scene_idle"][0] = % emb_cctv_010_saferoom_scene_idle_wolf;
  level.scr_anim["wolf"]["sr_scene_react"] = % emb_cctv_010_saferoom_scene_react_wolf;
  level.scr_anim["aq"]["garage_react"] = % reb_smtobj_patrol_look_under_react_8;
  level.scr_anim["marine"]["calm_stand_idle"][0] = % hm_grnd_yel_casual_idle_ar;
  level.scr_anim["alex"]["wolf_escort_1_enter"] = % emb_res_005_wolf_traversal_01_enter_alex;
  level.scr_anim["stacy"]["wolf_escort_1_enter"] = % emb_res_005_wolf_traversal_01_enter_stacy;
  level.scr_anim["wolf"]["wolf_escort_1_enter"] = % emb_res_005_wolf_traversal_01_enter_wolf;
  level.scr_anim["hadir"]["wolf_escort_1_enter"] = % emb_res_005_wolf_traversal_01_enter_hadir;
  level.scr_anim["alex"]["wolf_escort_1_idle"][0] = % emb_res_005_wolf_traversal_01_idle_alex;
  level.scr_anim["stacy"]["wolf_escort_1_idle"][0] = % emb_res_005_wolf_traversal_01_idle_stacy;
  level.scr_anim["wolf"]["wolf_escort_1_idle"][0] = % emb_res_005_wolf_traversal_01_idle_wolf;
  level.scr_anim["hadir"]["wolf_escort_1_idle"][0] = % emb_res_005_wolf_traversal_01_idle_hadir;
  level.scr_anim["alex"]["wolf_escort_2_enter"] = % emb_res_005_wolf_traversal_02_enter_alex;
  level.scr_anim["stacy"]["wolf_escort_2_enter"] = % emb_res_005_wolf_traversal_02_enter_stacy;
  level.scr_anim["wolf"]["wolf_escort_2_enter"] = % emb_res_005_wolf_traversal_02_enter_wolf;
  level.scr_anim["hadir"]["wolf_escort_2_enter"] = % emb_res_005_wolf_traversal_02_enter_hadir;
  level.scr_anim["alex"]["wolf_escort_2_idle"][0] = % emb_res_005_wolf_traversal_02_idle_alex;
  level.scr_anim["stacy"]["wolf_escort_2_idle"][0] = % emb_res_005_wolf_traversal_02_idle_stacy;
  level.scr_anim["wolf"]["wolf_escort_2_idle"][0] = % emb_res_005_wolf_traversal_02_idle_wolf;
  level.scr_anim["hadir"]["wolf_escort_2_idle"][0] = % emb_res_005_wolf_traversal_02_idle_hadir;
  level.scr_anim["alex"]["wolf_escort_3_enter"] = % emb_res_005_wolf_traversal_03_enter_alex;
  level.scr_anim["stacy"]["wolf_escort_3_enter"] = % emb_res_005_wolf_traversal_03_enter_stacy;
  level.scr_anim["wolf"]["wolf_escort_3_enter"] = % emb_res_005_wolf_traversal_03_enter_wolf;
  level.scr_anim["hadir"]["wolf_escort_3_enter"] = % emb_res_005_wolf_traversal_03_enter_hadir;
  level.scr_anim["alex"]["wolf_escort_3_idle"][0] = % emb_res_005_wolf_traversal_03_idle_alex;
  level.scr_anim["stacy"]["wolf_escort_3_idle"][0] = % emb_res_005_wolf_traversal_03_idle_stacy;
  level.scr_anim["wolf"]["wolf_escort_3_idle"][0] = % emb_res_005_wolf_traversal_03_idle_wolf;
  level.scr_anim["hadir"]["wolf_escort_3_idle"][0] = % emb_res_005_wolf_traversal_03_idle_hadir;
  level.scr_anim["alex"]["wolf_escort_4_enter"] = % emb_res_005_wolf_traversal_04_enter_alex;
  level.scr_anim["stacy"]["wolf_escort_4_enter"] = % emb_res_005_wolf_traversal_04_enter_stacy;
  level.scr_anim["wolf"]["wolf_escort_4_enter"] = % emb_res_005_wolf_traversal_04_enter_wolf;
  level.scr_anim["hadir"]["wolf_escort_4_enter"] = % emb_res_005_wolf_traversal_04_enter_hadir;
  level.scr_anim["alex"]["wolf_escort_4_idle"][0] = % emb_res_005_wolf_traversal_04_idle_alex;
  level.scr_anim["stacy"]["wolf_escort_4_idle"][0] = % emb_res_005_wolf_traversal_04_idle_stacy;
  level.scr_anim["wolf"]["wolf_escort_4_idle"][0] = % emb_res_005_wolf_traversal_04_idle_wolf;
  level.scr_anim["hadir"]["wolf_escort_4_idle"][0] = % emb_res_005_wolf_traversal_04_idle_hadir;
  level.scr_anim["price"]["gar_meetup_enter"] = % emb_gar_010_meetup_enter_price;
  level.scr_anim["stacy"]["gar_meetup_enter"] = % emb_gar_010_meetup_enter_stacy;
  level.scr_anim["farah"]["gar_meetup_enter"] = % emb_gar_010_meetup_enter_farah;
  level.scr_anim["hadir"]["gar_meetup_enter"] = % emb_gar_010_meetup_enter_hadir;
  level.scr_anim["wolf"]["gar_meetup_enter"] = % emb_gar_010_meetup_enter_wolf;
  level.scr_anim["alex"]["gar_meetup_enter"] = % emb_gar_010_meetup_enter_alex;
  level.scr_anim["price"]["gar_meetup_idle"][0] = % emb_gar_010_meetup_idle_price;
  level.scr_anim["price"]["gar_meetup_idle_nags"][0] = % emb_gar_010_meetup_idle_nag_price;
  level.scr_anim["stacy"]["gar_meetup_idle"][0] = % emb_gar_010_meetup_idle_stacy;
  level.scr_anim["hadir"]["gar_meetup_idle"][0] = % emb_gar_010_meetup_idle_hadir;
  level.scr_anim["wolf"]["gar_meetup_idle"][0] = % emb_gar_010_meetup_idle_wolf;
  level.scr_anim["alex"]["gar_meetup_idle"][0] = % emb_gar_010_meetup_idle_alex;
  level.scr_anim["farah"]["gar_meetup_idle"][0] = % emb_gar_010_meetup_idle_farah;
  level.scr_anim["price"]["gar_meetup_exit"] = % emb_gar_010_meetup_exit_price;
  level.scr_anim["farah"]["gar_meetup_exit"] = % emb_gar_010_meetup_exit_farah;
  level.scr_anim["stacy"]["gar_meetup_exit"] = % emb_gar_010_meetup_exit_stacy;
  scripts\common\anim::addnotetrack_mayhemstart("stacy", "mayhem_start", %emb_gar_010_meetup_exit_stacy_face, "gar_meetup_exit");
  scripts\common\anim::addnotetrack_mayhemend("stacy", "mayhem_end", %emb_gar_010_meetup_exit_stacy_face, "gar_meetup_exit");
  level.scr_anim["stacy"]["gar_meetup_exit_idle"][0] = % emb_gar_010_meetup_exit_idle_stacy;
  level.scr_anim["civ"]["alley_life_intro"] = % emb_res_009_alley_life_intro_civ06;
  level.scr_anim["civ"]["alley_life"] = % emb_res_009_alley_life_civ06;
  level.scr_anim["kid_1"]["alley_life_kids_idle"][0] = % emb_res_006_alley_children_idle_boy1;
  level.scr_anim["kid_2"]["alley_life_kids_idle"][0] = % emb_res_006_alley_children_idle_boy2;
  level.scr_anim["kid_1"]["alley_life_kids"] = % emb_res_006_alley_children_boy1;
  level.scr_anim["kid_2"]["alley_life_kids"] = % emb_res_006_alley_children_boy2;
  scripts\common\anim::addnotetrack_flag("kid_2", "kids_done_talking", "kids_done_talking", "alley_life_kids");
  level.scr_anim["farah"]["alley_life_kids"] = % emb_res_006_alley_children_farah;
  level.scr_anim["civ"]["alley_life_tv_idle"][0] = % emb_res_008_tv_idle_civ;
  level.scr_anim["civ"]["alley_life_tv"] = % emb_res_008_tv_react_civ;
  level.scr_anim["civ"]["alley_life_tv_gun_react"][0] = % sh_020_marketplace_reactads_civ05;
  level.scr_anim["farah"]["res_arrival_enter"] = % emb_res_010_arrival_enter_farah;
  level.scr_anim["price"]["res_arrival_enter"] = % emb_res_010_arrival_enter_price;
  level.scr_anim["farah"]["res_arrival_idle"][0] = % emb_res_010_arrival_idle_farah;
  level.scr_anim["price"]["res_arrival_idle"][0] = % emb_res_010_arrival_idle_price;
  level.scr_anim["mar_greeting"]["res_arrival_scene"] = % emb_res_010_arrival_scene_soldier;
  level.scr_anim["mar_informer"]["res_arrival_scene"] = % emb_res_010_room_scene_soldier;
  level.scr_anim["stacy"]["res_arrival_scene"] = % emb_res_010_arrival_scene_stacy;
  level.scr_anim["farah"]["res_arrival_scene"] = % emb_res_010_arrival_scene_farah;
  level.scr_anim["alex"]["res_arrival_scene"] = % emb_res_010_arrival_scene_alex;
  level.scr_anim["price"]["res_arrival_scene"] = % emb_res_010_arrival_scene_price;
  level.scr_anim["hadir"]["res_arrival_scene"] = % emb_res_010_arrival_scene_hadir;
  scripts\common\anim::addnotetrack_customfunction("hadir", "arrival_hadir_pistol_holster", ::arrival_hadir_pistol_holster, "res_arrival_scene");
  scripts\common\anim::addnotetrack_customfunction("hadir", "arrival_hadir_pickup_rifle", ::arrival_hadir_pickup_rifle, "res_arrival_scene");
  level.scr_anim["wolf"]["res_arrival_scene"] = % emb_res_010_arrival_scene_wolf;
  level.scr_anim["mar_greeting"]["res_arrival_scene_idle"][0] = % emb_res_010_arrival_scene_idle_soldier;
  level.scr_anim["mar_informer"]["res_arrival_scene_idle"][0] = % emb_res_010_room_idle_soldier;
  level.scr_anim["marine"]["res_arrival_scene_idle_local"][0] = % emb_res_010_room_idle_soldier_local;
  level.scr_anim["stacy"]["res_arrival_scene_idle"][0] = % emb_res_020_room_idle_stacy;
  level.scr_anim["alex"]["res_arrival_scene_idle"][0] = % emb_res_020_room_idle_alex;
  level.scr_anim["farah"]["res_arrival_scene_idle"][0] = % emb_res_020_room_idle_farah;
  level.scr_anim["hadir"]["res_arrival_scene_idle"][0] = % emb_res_020_room_idle_hadir;
  level.scr_anim["price"]["res_arrival_scene_idle"][0] = % emb_res_020_room_idle_price;
  level.scr_anim["stacy"]["res_room_ads_react"] = % emb_res_020_room_react_stacy;
  level.scr_anim["stacy"]["res_room_plr_react_l"] = % sh_020_marketplace_reactl_civ04;
  level.scr_anim["stacy"]["res_room_plr_react_r"] = % sh_020_marketplace_reactr_civ04;
  level.scr_anim["alex"]["res_room_exit"] = % emb_res_020_room_exit_alex;
  level.scr_anim["farah"]["res_room_exit"] = % emb_res_020_room_exit_farah;
  level.scr_anim["hadir"]["res_room_exit"] = % emb_res_020_room_exit_hadir;
  level.scr_anim["price"]["res_room_exit"] = % emb_res_020_room_exit_price;
  level.scr_anim["alex"]["res_room_exit_idle"][0] = % emb_res_020_room_exit_idle_alex;
  level.scr_anim["farah"]["res_room_exit_idle"][0] = % emb_res_020_room_exit_idle_farah;
  level.scr_anim["hadir"]["res_room_exit_idle"][0] = % emb_res_020_room_exit_idle_hadir;
  level.scr_anim["price"]["res_room_exit_idle"][0] = % emb_res_020_room_exit_idle_price;
  level.scr_anim["alex"]["res_room_exit_to_defend"] = % emb_res_020_exit_defend_alex;
  level.scr_anim["farah"]["res_room_exit_to_defend"] = % emb_res_020_exit_defend_farah;
  level.scr_anim["price"]["res_room_exit_to_defend"] = % emb_res_020_exit_defend_price;
  level.scr_anim["hadir"]["res_room_exit_to_defend"] = % emb_res_020_exit_defend_hadir;
  level.scr_anim["civ"]["dejected_idle_0"][0] = % emb_res_015_dejected_idle_civ03;
  level.scr_anim["civ"]["dejected_idle_1"][0] = % emb_res_015_dejected_idle_civ04;
  level.scr_anim["civ"]["dejected_idle_2"][0] = % emb_res_015_dejected_idle_civ01;
  level.scr_anim["civ"]["dejected_idle_3"][0] = % emb_res_015_dejected_idle_civ02;
  level.scr_anim["civ"]["dejected_idle_4"][0] = % emb_res_015_dejected_idle_civ05;
  level.scr_anim["civ"]["dejected_idle_5"][0] = % emb_res_015_dejected_idle_civ06;
  level.scr_anim["civ"]["dejected_react_ads_enter_0"] = % emb_res_015_dejected_react_ads_enter_civ03;
  level.scr_anim["civ"]["dejected_react_ads_enter_1"] = % emb_res_015_dejected_react_ads_enter_civ04;
  level.scr_anim["civ"]["dejected_react_ads_enter_2"] = % emb_res_015_dejected_react_ads_enter_civ01;
  level.scr_anim["civ"]["dejected_react_ads_enter_3"] = % emb_res_015_dejected_react_ads_enter_civ02;
  level.scr_anim["civ"]["dejected_react_ads_enter_4"] = % emb_res_015_dejected_react_ads_enter_civ05;
  level.scr_anim["civ"]["dejected_react_ads_enter_5"] = % emb_res_015_dejected_react_ads_enter_civ06;
  level.scr_anim["civ"]["dejected_react_ads_exit_0"] = % emb_res_015_dejected_react_ads_exit_civ03;
  level.scr_anim["civ"]["dejected_react_ads_exit_1"] = % emb_res_015_dejected_react_ads_exit_civ04;
  level.scr_anim["civ"]["dejected_react_ads_exit_2"] = % emb_res_015_dejected_react_ads_exit_civ01;
  level.scr_anim["civ"]["dejected_react_ads_exit_3"] = % emb_res_015_dejected_react_ads_exit_civ02;
  level.scr_anim["civ"]["dejected_react_ads_exit_4"] = % emb_res_015_dejected_react_ads_exit_civ05;
  level.scr_anim["civ"]["dejected_react_ads_exit_5"] = % emb_res_015_dejected_react_ads_exit_civ06;
  level.scr_anim["civ"]["dejected_react_ads_idle_0"][0] = % emb_res_015_dejected_react_ads_idle_civ03;
  level.scr_anim["civ"]["dejected_react_ads_idle_1"][0] = % emb_res_015_dejected_react_ads_idle_civ04;
  level.scr_anim["civ"]["dejected_react_ads_idle_2"][0] = % emb_res_015_dejected_react_ads_idle_civ01;
  level.scr_anim["civ"]["dejected_react_ads_idle_3"][0] = % emb_res_015_dejected_react_ads_idle_civ02;
  level.scr_anim["civ"]["dejected_react_ads_idle_4"][0] = % emb_res_015_dejected_react_ads_idle_civ05;
  level.scr_anim["civ"]["dejected_react_ads_idle_5"][0] = % emb_res_015_dejected_react_ads_idle_civ06;
  level.scr_anim["civ"]["dejected_react_plr_0"] = % emb_res_015_dejected_react_plr_civ03;
  level.scr_anim["civ"]["dejected_react_plr_1"] = % emb_res_015_dejected_react_plr_civ04;
  level.scr_anim["civ"]["dejected_react_plr_2"] = % emb_res_015_dejected_react_plr_civ01;
  level.scr_anim["civ"]["dejected_react_plr_3"] = % emb_res_015_dejected_react_plr_civ02;
  level.scr_anim["civ"]["dejected_react_plr_4"] = % emb_res_015_dejected_react_plr_civ05;
  level.scr_anim["civ"]["dejected_react_plr_5"] = % emb_res_015_dejected_react_plr_civ06;
  level.scr_anim["ambo"]["ambo_kill_scene_idle"][0] = % emb_cctv_018_start_idle_amb;
  level.scr_anim["ambo"]["ambo_kill_scene"] = % emb_cctv_018_amb_kill_amb;
  level.scr_anim["aq_cctv"]["ambo_kill_scene"] = % emb_cctv_018_amb_kill_aq;
  level.scr_anim["stacy"]["office_start_idle"][0] = % emb_cctv_020_office_start_idle_stacy;
  level.scr_anim["stacy"]["office_start"] = % emb_cctv_020_office_start_stacy;
  level.scr_anim["stacy"]["office_get_card"] = % emb_cctv_022_office_getcard_stacy;
  level.scr_anim["ambo"]["office_get_card"] = % emb_cctv_022_office_getcard_amb;
  level.scr_anim["stacy"]["office_get_card_idle"][0] = % emb_cctv_022_office_getcard_idle_stacy;
  level.scr_anim["ambo"]["office_get_card_idle"][0] = % emb_cctv_022_office_getcard_idle_amb;
  level.scr_anim["stacy"]["office_exit"] = % emb_cctv_025_office_exit_stacy;
  level.scr_anim["ambo"]["office_exit"] = % emb_cctv_025_office_exit_amb;
  level.scr_anim["stacy"]["office_exit_idle"][0] = % emb_cctv_025_office_exit_idle_stacy;
  level.scr_anim["aq_cctv"]["triage_scene_idle"][0] = % emb_def_050_triage_table_idle_civ01;
  level.scr_anim["aq_cctv"]["est_search_desk_terry_idle"][0] = % emb_search_desk_terry_idle;
  level.scr_anim["bookcase_victim"]["bookcase_beating_idle_start"][0] = % emb_cctv_040_interrogation_idle02_victim;
  level.scr_anim["aq_cctv_bookcase_01"]["bookcase_beating_idle_start"][0] = % emb_cctv_040_interrogation_idle02_enemy01;
  level.scr_anim["aq_cctv_bookcase_02"]["bookcase_beating_idle_start"][0] = % emb_cctv_040_interrogation_idle02_enemy02;
  level.scr_anim["bookcase_victim"]["bookcase_beating"][0] = % emb_cctv_040_interrogation_victim;
  level.scr_anim["aq_cctv_bookcase_01"]["bookcase_beating"][0] = % emb_cctv_040_interrogation_enemy01;
  level.scr_anim["aq_cctv_bookcase_02"]["bookcase_beating"][0] = % emb_cctv_040_interrogation_enemy02;
  level.scr_anim["cctv_victim"]["room_beating_scene"] = % sh_nh_015_room_beat_civ;
  level.scr_anim["aq_cctv"]["room_beating_scene"] = % sh_nh_015_room_beat_terry;
  level.scr_anim["ambo"]["ambo_kill_scene"] = % emb_cctv_018_amb_kill_amb;
  level.scr_anim["aq_cctv"]["ambo_kill_scene"] = % emb_cctv_018_amb_kill_aq;
  scripts\common\anim::addnotetrack_customfunction("aq_cctv", "fire", ::notetrack_civ_killed, "ambo_kill_scene");
  level.scr_anim["runner_01"]["ambo_kill_scene"] = % emb_cctv_018_amb_kill_civ01;
  level.scr_anim["runner_02"]["ambo_kill_scene"] = % emb_cctv_018_amb_kill_civ02;
  level.scr_anim["aq_cctv"]["hallway_kill_scene"] = % emb_cctv_027_hallway_kill_aq;
  level.scr_anim["runner_01"]["hallway_kill_scene"] = % emb_cctv_027_hallway_kill_civ01;
  level.scr_anim["runner_02"]["hallway_kill_scene"] = % emb_cctv_027_hallway_kill_civ02;
  level.scr_anim["wounded_victim"]["wounded_start_idle"][0] = % emb_cctv_050_wounded_idle_civ01;
  level.scr_anim["wounded_victim"]["wounded_start"] = % emb_cctv_050_wounded_civ01;
  level.scr_anim["stacy"]["wounded_start"] = % emb_cctv_050_wounded_stacy;
  level.scr_anim["aq_cctv"]["wounded_start"] = % emb_cctv_050_wounded_enemy;
  level.scr_anim["stacy"]["wounded_end_idle"][0] = % emb_cctv_050_wounded_end_idle_stacy;
  level.scr_anim["stacy"]["wounded_exit"] = % civ_cctv_exposed_crouch_walk_exit_6;
  level.scr_anim["stacy"]["hallway_exit"] = % civ_cctv_exposed_crouch_walk_exit_4;
  level.scr_goaltime["stacy"]["hallway_exit"] = 0.5;
  level.scr_anim["stacy"]["card_swipe"] = % emb_cctv_card_swipe_stacy;
  level.scr_anim["aq_cctv"]["lookaround_05"] = % reb_smtobj_lookaround05;
  level.scr_anim["emb_def_civ_table_exit_civ01"]["civ_table_idle"][0] = % emb_def_civ_table_idle_civ01;
  level.scr_anim["emb_def_civ_table_exit_civ02"]["civ_table_idle"][0] = % emb_def_civ_table_idle_civ02;
  level.scr_anim["emb_def_civ_table_exit_civ01"]["civ_table_exit"] = % emb_def_civ_table_exit_civ01;
  level.scr_anim["emb_def_civ_table_exit_civ02"]["civ_table_exit"] = % emb_def_civ_table_exit_civ02;
  level.scr_anim["emb_def_civ_run_c_civ01"]["civ_walk_run"] = % emb_def_civ_run_c_civ01;
  level.scr_anim["emb_def_civ_run_c_civ02"]["civ_walk_run"] = % emb_def_civ_run_c_civ02;
  level.scr_anim["emb_def_civs_bike_b_civ"]["civ_bikers"] = % emb_def_civs_bike_b_civ;
  level.scr_anim["emb_def_civ_point_a_civ01"]["civ_spotters_idle"][0] = % emb_def_civ_point_a_idle_civ01;
  level.scr_anim["emb_def_civ_point_a_civ01"]["civ_spotters"] = % emb_def_civ_point_a_civ01;
  level.scr_anim["emb_def_civ_point_a_civ02"]["civ_spotters_idle"][0] = % emb_def_civ_point_a_idle_civ02;
  level.scr_anim["emb_def_civ_point_a_civ02"]["civ_spotters"] = % emb_def_civ_point_a_civ02;
  level.scr_anim["emb_def_civ_point_a_civ03"]["civ_spotters_idle"][0] = % emb_def_civ_point_a_idle_civ01;
  level.scr_anim["emb_def_civ_point_a_civ03"]["civ_spotters"] = % emb_def_civ_point_a_civ03;
  level.scr_anim["soccer_guy_1"]["civ_soccer_guys_idle"][0] = % emb_def_civ_tv_idle_civ01;
  level.scr_anim["soccer_guy_2"]["civ_soccer_guys_idle"][0] = % emb_def_civ_tv_idle_civ02;
  level.scr_anim["soccer_guy_3"]["civ_soccer_guys_idle"][0] = % emb_def_civ_tv_idle_civ03;
  level.scr_anim["soccer_guy_1"]["civ_soccer_guys"] = % emb_def_civ_tv_start_civ01;
  level.scr_anim["soccer_guy_2"]["civ_soccer_guys"] = % emb_def_civ_tv_start_civ02;
  level.scr_anim["soccer_guy_3"]["civ_soccer_guys"] = % emb_def_civ_tv_start_civ03;
  level.scr_anim["shipcrib_europa_lounge_newsreel_scene_un3_scene"]["civ_soccer_guys"] = % shipcrib_europa_lounge_newsreel_scene_un3_scene;
  level.scr_anim["shipcrib_europa_lounge_newsreel_scene_un4_scene"]["civ_soccer_guys"] = % shipcrib_europa_lounge_newsreel_scene_un4_scene;
  level.scr_anim["shipcrib_europa_lounge_newsreel_scene_un5_scene"]["civ_soccer_guys"] = % shipcrib_europa_lounge_newsreel_scene_un5_scene;
  level.scr_anim["shipcrib_europa_lounge_newsreel_scene_un3_scene"]["civ_soccer_guys_idle"][0] = % shipcrib_europa_lounge_newsreel_scene_un3_idle;
  level.scr_anim["shipcrib_europa_lounge_newsreel_scene_un4_scene"]["civ_soccer_guys_idle"][0] = % shipcrib_europa_lounge_newsreel_scene_un4_idle;
  level.scr_anim["shipcrib_europa_lounge_newsreel_scene_un5_scene"]["civ_soccer_guys_idle"][0] = % shipcrib_europa_lounge_newsreel_scene_un5_idle;
  level.scr_anim["garage_civ"]["garage_civ_intro"] = % sh_nh_090_civ_glance_garage_intro_civ02;
  level.scr_anim["garage_civ"]["garage_civ_idle"][0] = % sh_nh_090_civ_glance_garage_idle_civ02;
  level.scr_anim["garage_civ"]["garage_civ_exit"] = % sh_nh_090_civ_glance_garage_civ02;
  level.scr_anim["price"]["rooftops_intro_run"] = % emb_def_010_intro_run_price;
  scripts\common\anim::addnotetrack_customfunction("price", "vo_dx_vom_pri_defend_intro_30", ::price_directions_finished, "rooftops_intro_run");
  level.scr_anim["farah"]["rooftops_intro_run"] = % emb_def_010_intro_run_farah;
  level.scr_anim["alex"]["rooftops_intro_run"] = % emb_def_010_intro_run_alex;
  level.scr_anim["ally_01_mortar"]["rooftops_idle"][0] = % emb_def_020_rooftop_idle_ally01;
  level.scr_anim["ally_02_mortar"]["rooftops_idle"][0] = % emb_def_020_rooftop_idle_ally02;
  level.scr_anim["price"]["rooftops_begin"] = % emb_def_020_rooftop_price;
  scripts\common\anim::addnotetrack_customfunction("price", "sd_dx_vom_pri_defend_roof_60", ::price_intro_vo_finished, "rooftops_begin");
  level.scr_anim["farah"]["rooftops_begin"] = % emb_def_020_rooftop_farah;
  level.scr_anim["ally_01_mortar"]["rooftops_begin"] = % emb_def_020_rooftop_ally01;
  scripts\common\anim::addnotetrack_customfunction("ally_01_mortar", "grab_glowstick", ::grab_glowstick, "rooftops_begin");
  scripts\common\anim::addnotetrack_customfunction("ally_01_mortar", "toss_glowstick", ::toss_glowstick, "rooftops_begin");
  level.scr_anim["ally_02_mortar"]["rooftops_begin"] = % emb_def_020_rooftop_ally02;
  level.scr_anim["ally_01_mortar"]["flare_nag_start"] = % emb_def_027_lights_start_ally01;
  level.scr_anim["ally_01_mortar"]["flare_nag_idle"][0] = % emb_def_027_lights_start_idle_ally01;
  level.scr_anim["ally_01_mortar"]["flare_nag"] = % emb_def_027_lights_nag_ally01;
  level.scr_anim["ally_01_mortar"]["flare_nag_react"] = % emb_def_027_lights_launch_ally01;
  level.scr_anim["price"]["mortar_scene_start"] = % emb_def_025_lull_start_price;
  level.scr_anim["farah"]["mortar_scene_start"] = % emb_def_025_lull_start_farah;
  level.scr_anim["ally_01_mortar"]["mortar_scene_start"] = % emb_def_025_lull_start_ally01;
  level.scr_anim["ally_02_mortar"]["mortar_scene_start"] = % emb_def_025_lull_start_ally02;
  level.scr_anim["price"]["mortar_scene_idle"][0] = % emb_def_025_lull_start_idle_price;
  level.scr_anim["farah"]["mortar_scene_idle"][0] = % emb_def_025_lull_start_idle_farah;
  level.scr_anim["ally_01_mortar"]["mortar_scene_idle"][0] = % emb_def_025_lull_start_idle_ally01;
  level.scr_anim["ally_02_mortar"]["mortar_scene_idle"][0] = % emb_def_025_lull_start_idle_ally02;
  level.scr_anim["price"]["mortar_scene_trucks"] = % emb_def_026_trucks_start_price;
  level.scr_anim["farah"]["mortar_scene_trucks"] = % emb_def_026_trucks_start_farah;
  level.scr_anim["ally_01_mortar"]["mortar_scene_trucks"] = % emb_def_026_trucks_start_ally01;
  level.scr_anim["ally_02_mortar"]["mortar_scene_trucks"] = % emb_def_026_trucks_start_ally02;
  level.scr_anim["price"]["mortar_scene_trucks_idle"][0] = % emb_def_026_trucks_start_idle_price;
  level.scr_anim["farah"]["mortar_scene_trucks_idle"][0] = % emb_def_026_trucks_start_idle_farah;
  level.scr_anim["ally_01_mortar"]["mortar_scene_trucks_idle"][0] = % emb_def_026_trucks_start_idle_ally01;
  level.scr_anim["ally_02_mortar"]["mortar_scene_trucks_idle"][0] = % emb_def_026_trucks_start_idle_ally02;
  level.scr_anim["price"]["mortar_scene_attack"] = % emb_def_030_mortar_start_price;
  level.scr_anim["farah"]["mortar_scene_attack"] = % emb_def_030_mortar_start_farah;
  level.scr_anim["ally_01_mortar"]["mortar_scene_attack"] = % emb_def_030_mortar_start_ally01;
  scripts\common\anim::addnotetrack_customfunction("ally_01_mortar", "kill_me", ::kill_me_no_anim, "mortar_scene_attack");
  level.scr_anim["ally_02_mortar"]["mortar_scene_attack"] = % emb_def_030_mortar_start_ally02;
  level.scr_anim["alex"]["flare_enter_aq"] = % emb_wm_mortar_enter_alex;
  level.scr_anim["alex"]["flare_aq_idle"][0] = % emb_wm_mortar_idle_alex;
  level.scr_anim["alex"]["flare_launch_aq"] = % emb_wm_mortar_launch_alex;
  level.scr_anim["alex"]["flare_reload_aq"] = % emb_wm_mortar_reload_alex;
  level.scr_anim["alex"]["flare_exit_aq"] = % emb_wm_mortar_exit_alex;
  level.scr_anim["ally_03"]["drag_scene_enter"] = % emb_def_040_drag_enter_ally01;
  level.scr_anim["ally_03"]["drag_scene_hit"] = % emb_def_040_drag_hit_ally01;
  scripts\common\anim::addnotetrack_customfunction("ally_03", "start_shooting", ::drag_scene_shoot, "drag_scene_hit");
  level.scr_anim["ally_03"]["drag_scene_drag"] = % emb_def_040_drag_drag_ally01;
  scripts\common\anim::addnotetrack_customfunction("ally_03", "draw_pistol", ::drag_pistol_swap, "drag_scene_drag");
  level.scr_anim["ally_04"]["drag_scene_drag"] = % emb_def_040_drag_drag_ally02;
  level.scr_anim["ally_03"]["drag_scene_idle"][0] = % emb_def_040_drag_idle_b_ally01;
  level.scr_anim["price"]["triage_scene_pre_enter"] = % emb_def_050_triage_pre_enter_price;
  level.scr_anim["price"]["triage_scene_enter_idle"][0] = % emb_def_050_triage_pre_idle_price;
  level.scr_anim["price"]["triage_scene_start"] = % emb_def_050_triage_enter_price;
  scripts\common\anim::addnotetrack_notify("price", "green_beam_hint", "green_beam_hint", "triage_scene_start");
  level.scr_anim["civ_01"]["triage_scene_start"] = % emb_def_050_triage_enter_civ01;
  level.scr_anim["price"]["triage_scene_idle"][0] = % emb_def_050_triage_table_idle_price;
  scripts\common\anim::addnotetrack_notify("price", "nag", "price_triage_nag", "triage_scene_idle");
  level.scr_anim["civ_01"]["triage_scene_idle"][0] = % emb_def_050_triage_table_idle_civ01;
  level.scr_anim["price"]["heart_to_heart"] = % emb_def_050_triage_scene_price;
  scripts\common\anim::addnotetrack_notify("price", "mayhem_start", "triage_mayhem_price_face", "heart_to_heart");
  scripts\common\anim::addnotetrack_notify("price", "mayhem_end", "price_mayhem_end", "heart_to_heart");
  level.scr_anim["civ_01"]["triage_scene_exit"] = % emb_def_050_triage_scene_exit_civ01;
  level.scr_anim["price"]["triage_scene_ladder_idle"][0] = % emb_def_050_triage_ladder_idle_price;
  level.scr_anim["price"]["triage_scene_ladder_climb"] = % emb_def_050_triage_ladder_climb_price;
  level.scr_anim["civ"]["cower_0"][0] = % unarmed_cowercrouch_idle_duck;
  level.scr_anim["civ"]["cower_1"][0] = % hm_grnd_civ_react01_idle02;
  level.scr_anim["civ"]["cower_2"][0] = % hm_grnd_civ_react01_idle03;
  level.scr_anim["civ"]["cower_3"][0] = % hm_grnd_civ_react01_idle07;
  level.scr_anim["civ"]["cower_4"][0] = % hm_grnd_civ_react02_idle01;
  level.scr_anim["civ"]["cower_5"][0] = % hm_grnd_civ_react02_idle02;
  level.scr_anim["civ"]["cower_6"][0] = % hm_grnd_civ_react02_idle03;
  level.scr_anim["civ"]["cower_7"][0] = % hm_grnd_civ_react02_idle05;
  level.scr_anim["farah"]["ladder_up_scene"] = % emb_def_055_ladder_farah;
  level.scr_anim["price"]["ladder_climb"] = % emb_def_055_ladder_ally;
  level.scr_anim["alex"]["ladder_climb"] = % emb_def_055_ladder_ally;
  level.scr_anim["hadir"]["ladder_climb"] = % emb_def_055_ladder_ally;
  level.scr_anim["stairs_guy"]["stairs_scene"] = % emb_def_070_mortarhouse_stairs_enemy01;
  level.scr_anim["hadir"]["mortar_house_exit"] = % emb_def_080_mortarhouse_exit_price;
  level.scr_anim["hadir"]["mortar_boost_enter"] = % emb_def_065_boost_enter_hadir;
  level.scr_anim["hadir"]["mortar_boost_idle"][0] = % emb_def_065_boost_idle_hadir;
  level.scr_anim["hadir"]["mortar_boost_nag"] = % emb_def_065_boost_nag_hadir;
  level.scr_anim["hadir"]["mortar_boost"] = % emb_def_065_boost_scene_hadir;
  level.scr_anim["aq_1"]["mortar_boost"] = % emb_def_065_boost_scene_aq;
  level.scr_anim["hadir"]["fridge_takedown_enter"] = % emb_def_067_fridge_takedown_enter_hadir;
  level.scr_anim["hadir"]["fridge_takedown_enter_idle"][0] = % emb_def_067_fridge_takedown_idle_hadir;
  level.scr_anim["hadir"]["fridge_takedown"] = % emb_def_067_fridge_takedown_scene_hadir;
  level.scr_anim["aq_1"]["fridge_takedown"] = % emb_def_067_fridge_takedown_scene_aq;
  var_0 = "generic";
  level.scr_anim[var_0]["faveladoor_fastopen"] = % sh_sch_060_doorbustr_enemy;
  level.scr_anim[var_0]["faveladoor_idle"][0] = % reb_smtobj_door_r_loop;
  level.scr_anim[var_0]["faveladoor_kick"] = % reb_smtobj_door_r_kick01;
  level.scr_anim[var_0]["faveladoor_peak"] = % reb_smtobj_door_r_peak;
  level.scr_anim[var_0]["faveladoor_gren"] = % reb_smtobj_door_r_grenade;
  level.scr_anim["soldier_01"]["sniper_start_idle"][0] = % emb_def_060_sniper_start_idle_ally01;
  level.scr_anim["soldier_01"]["sniper_start_death"] = % emb_def_060_sniper_death_ally01;
  scripts\common\anim::addnotetrack_customfunction("soldier_01", "kill_me", ::kill_me_no_anim, "sniper_start_death");
  level.scr_anim["soldier_02"]["sniper_start_idle"][0] = % emb_def_060_sniper_start_idle_ally02;
  level.scr_anim["soldier_02"]["sniper_start_death"] = % emb_def_060_sniper_death_ally02;
  scripts\common\anim::addnotetrack_customfunction("soldier_02", "kill_me", ::kill_me_no_anim, "sniper_start_death");
  level.scr_anim["kyle"]["wolf_escapes"] = % emb_exfil_010_wolfescapes_kyle;
  scripts\common\anim::addnotetrack_notify("kyle", "mayhem_start", "ending_mayhem_kyle_face", "wolf_escapes");
  level.scr_anim["price"]["wolf_escapes"] = % emb_exfil_010_wolfescapes_price;
  scripts\common\anim::addnotetrack_notify("price", "mayhem_start", "ending_mayhem_price_face", "wolf_escapes");
  level.scr_anim["hadir"]["wolf_escapes"] = % emb_exfil_010_wolfescapes_hadir;
  scripts\common\anim::addnotetrack_notify("hadir", "mayhem_start", "ending_mayhem_hadir_face", "wolf_escapes");
  level.scr_anim["farah"]["wolf_escapes"] = % emb_exfil_010_wolfescapes_farah;
  scripts\common\anim::addnotetrack_notify("farah", "mayhem_start", "ending_mayhem_farah_face", "wolf_escapes");
  level.scr_anim["alex"]["wolf_escapes"] = % emb_exfil_010_wolfescapes_alex;
  scripts\common\anim::addnotetrack_notify("alex", "mayhem_start", "ending_mayhem_alex_face", "wolf_escapes");
  level.scr_anim["residence_stacy_killer"]["bpgc_hostage_enter"] = % emb_exfil_005_stacy_hostage_alqatala_enter;
  level.scr_anim["residence_stacy_killer"]["bpgc_hostage_flash"] = % sdr_com_exposed_stand_flashbang_react_07;
  level.scr_anim["residence_stacy_killer"]["bpgc_hostage_idle"][0] = % emb_exfil_005_stacy_hostage_alqatala_idle;
  level.scr_anim["residence_stacy_killer"]["bpgc_hostage_exit"] = % emb_exfil_005_stacy_hostage_alqatala_exita;
  scripts\common\anim::addnotetrack_notify("residence_stacy_killer", "fire", "hostage_aq_fired", "bpgc_hostage_exit");
  level.scr_anim["residence_stacy_killer"]["bpgc_hostage_death"] = % emb_exfil_005_stacy_hostage_alqatala_exitb;
  level.scr_anim["stacy"]["bpgc_hostage_enter"] = % emb_exfil_005_stacy_hostage_stacy_enter;
  level.scr_anim["stacy"]["bpgc_hostage_idle"][0] = % emb_exfil_005_stacy_hostage_stacy_idle;
  level.scr_anim["stacy"]["bpgc_hostage_death"] = % emb_exfil_005_stacy_hostage_stacy_exita;
  level.scr_anim["stacy"]["bpgc_hostage_exit"] = % emb_exfil_005_stacy_hostage_stacy_exitb;
  level.scr_anim["stacy"]["dejected_idle"][0] = % emb_exfil_005_stacy_hostage_stacy_exitb_idle;
  level.scr_anim["stacy"]["dejected_react_01"] = % emb_exfil_005_stacy_hostage_stacy_exitb_react_plr;
  level.scr_anim["stacy"]["dejected_react_02"] = % emb_exfil_005_stacy_hostage_stacy_exitb_react_plr2;
  level.scr_anim["stacy"]["dejected_react_gun"] = % emb_exfil_005_stacy_hostage_stacy_exitb_react_gun;
  level.scr_anim["soldier_01"]["deadbody_02"] = % deadbody_02;
  level.scr_anim["soldier_01"]["deadbody_07"] = % deadbody_07;
  level.scr_anim["soldier_01"]["deadbody_08"] = % deadbody_08;
  level.scr_face["price"]["dx_vom_pri_roof_stairwell_20"] = % dx_vom_pri_roof_stairwell_20_face;
  level.scr_face["price"]["dx_vom_pri_escape_garage_210"] = % dx_vom_pri_escape_garage_210_face;
  level.scr_face["price"]["dx_vom_pri_escape_garage_220"] = % dx_vom_pri_escape_garage_220_face;
  level.scr_face["price"]["dx_vom_pri_entrance_overrun_140"] = % dx_vom_pri_entrance_overrun_140_face;
  level.scr_face["price"]["dx_vom_pri_entrance_overrun_150"] = % dx_vom_pri_entrance_overrun_150_face;
  level.scr_face["price"]["dx_vom_pri_entrance_overrun_160"] = % dx_vom_pri_entrance_overrun_160_face;
  level.scr_face["price"]["dx_vom_pri_reception_bulletproof_122"] = % dx_vom_pri_reception_bulletproof_122_face;
  level.scr_face["price"]["dx_vom_pri_reception_bulletproof_124"] = % dx_vom_pri_reception_bulletproof_124_face;
  level.scr_face["price"]["dx_vom_pri_basement_halligan_60"] = % dx_vom_pri_basement_halligan_60_face;
  level.scr_face["price"]["dx_vom_pri_basement_traverse_22"] = % dx_vom_pri_basement_traverse_22_face;
  level.scr_face["price"]["dx_vom_pri_basement_traverse_23"] = % dx_vom_pri_basement_traverse_23_face;
  level.scr_face["price"]["dx_vom_pri_breach_offices_60"] = % dx_vom_pri_breach_offices_60_face;
  level.scr_face["price"]["dx_vom_pri_alley_compound_30"] = % dx_vom_pri_alley_compound_30_face;
  level.scr_face["price"]["dx_vom_pri_alley_compound_40"] = % dx_vom_pri_alley_compound_40_face;
  level.scr_face["alex"]["dx_vom_alx_cine_saferoom_180"] = % dx_vom_alx_cine_saferoom_180_face;
  level.scr_face["price"]["dx_vom_pri_cine_saferoom_170"] = % dx_vom_pri_cine_saferoom_170_face;
  level.scr_face["price"]["dx_vom_pri_residence_arrival_exit_70"] = % dx_vom_pri_residence_arrival_exit_70_face;
  level.scr_face["price"]["dx_vom_pri_defend_intro_30"] = % dx_vom_pri_defend_intro_30_face;
  level.scr_face["price"]["dx_vom_pri_defend_roof_63"] = % dx_vom_pri_defend_roof_63_face;
  level.scr_face["price"]["dx_vom_pri_defend_roof_60"] = % dx_vom_pri_defend_roof_60_face;
  level.scr_face["price"]["dx_vom_pri_defend_roof_62"] = % dx_vom_pri_defend_roof_62_face;
  level.scr_face["price"]["dx_vom_pri_defend_cafe_20"] = % dx_vom_pri_defend_cafe_20_face;
  level.scr_face["price"]["dx_vom_pri_defend_intro_27"] = % dx_vom_pri_defend_intro_27_face;
  level.scr_face["price"]["dx_vom_pri_defend_cafe_80"] = % dx_vom_pri_defend_cafe_80_face;
  level.scr_face["price"]["dx_vom_pri_defend_building_fight_10"] = % dx_vom_pri_defend_building_fight_10_face;
  level.scr_face["price"]["dx_vom_pri_residence_arrival_exit_30"] = % dx_vom_pri_residence_arrival_exit_30_face;
  level.scr_face["price"]["dx_vom_pri_defend_resupply_140"] = % dx_vom_pri_defend_resupply_140_face;
  level.scr_face["price"]["dx_vom_pri_defend_resupply_150"] = % dx_vom_pri_defend_resupply_150_face;
  level.scr_face["price"]["dx_vom_pri_defend_roof_64"] = % dx_vom_pri_defend_roof_64_face;
  level.scr_face["price"]["dx_vom_pri_defend_resupply_160"] = % dx_vom_pri_defend_resupply_160_face;
  level.scr_face["price"]["dx_vom_pri_defend_resupply_43"] = % dx_vom_pri_defend_resupply_43_face;
  level.scr_face["price"]["dx_vom_pri_defend_resupply_42"] = % dx_vom_pri_defend_resupply_42_face;
  level.scr_face["price"]["dx_vom_pri_defend_intro_20"] = % dx_vom_pri_defend_intro_20_face;
  level.scr_face["stacy"]["dx_vom_stac_wolf_escapes_final_00"] = % dx_vom_stac_wolf_escapes_final_00_face;
  level.scr_face["stacy"]["dx_vom_stac_wolf_escapes_final_10"] = % dx_vom_stac_wolf_escapes_final_10_face;
  level.scr_face["stacy"]["dx_vom_stac_wolf_escapes_final_30"] = % dx_vom_stac_wolf_escapes_final_30_face;
  level.scr_face["price"]["dx_vom_pri_topfloor_office_280"] = % dx_vom_pri_topfloor_office_280_face;
  level.scr_face["price"]["dx_vom_pri_topfloor_office_290"] = % dx_vom_pri_topfloor_office_290_face;
  level.scr_face["price"]["dx_vom_pri_topfloor_office_300"] = % dx_vom_pri_topfloor_office_300_face;
  level.scr_face["price"]["dx_vom_pri_alley_compound_50"] = % dx_vom_pri_alley_compound_50_face;
  level.scr_face["price"]["dx_vom_pri_alley_compound_60"] = % dx_vom_pri_alley_compound_60_face;
  level.scr_face["price"]["dx_vom_pri_basement_traverse_21"] = % dx_vom_pri_basement_traverse_21_face;
  level.scr_face["price"]["dx_vom_pri_basement_traverse_50"] = % dx_vom_pri_basement_traverse_50_face;
  level.scr_face["price"]["dx_vom_pri_basement_traverse_60"] = % dx_vom_pri_basement_traverse_60_face;
  level.scr_face["price"]["dx_vom_pri_breach_offices_70"] = % dx_vom_pri_breach_offices_70_face;
  level.scr_face["price"]["dx_vom_pri_breach_offices_80"] = % dx_vom_pri_breach_offices_80_face;
  level.scr_face["price"]["dx_vom_pri_entrance_overrun_100"] = % dx_vom_pri_entrance_overrun_100_face;
  level.scr_face["price"]["dx_vom_pri_entrance_overrun_110"] = % dx_vom_pri_entrance_overrun_110_face;
  level.scr_face["price"]["dx_vom_pri_entrance_overrun_120"] = % dx_vom_pri_entrance_overrun_120_face;
  level.scr_face["price"]["dx_vom_pri_entrance_overrun_131"] = % dx_vom_pri_entrance_overrun_131_face;
  level.scr_face["price"]["dx_vom_pri_escape_garage_200"] = % dx_vom_pri_escape_garage_200_face;
  level.scr_face["price"]["dx_vom_pri_escape_garage_190"] = % dx_vom_pri_escape_garage_190_face;
  level.scr_face["price"]["dx_vom_pri_roof_stairwell_50"] = % dx_vom_pri_roof_stairwell_50_face;
  level.scr_face["price"]["dx_vom_pri_roof_stairwell_60"] = % dx_vom_pri_roof_stairwell_60_face;
  level.scr_face["price"]["dx_vom_pri_roof_stairwell_70"] = % dx_vom_pri_roof_stairwell_70_face;
  level.scr_face["stacy"]["dx_vom_stac_escape_garage_140"] = % dx_vom_stac_escape_garage_140_face;
  level.scr_face["aq_cctv_bookcase_01"]["dx_vom_enf_cctv_post_intro_interrogation1_10"] = % dx_vom_enf_cctv_post_intro_interrogation1_10_face;
  level.scr_face["aq_cctv_bookcase_01"]["dx_vom_enf_cctv_post_intro_interrogation1_20"] = % dx_vom_enf_cctv_post_intro_interrogation1_20_face;
  level.scr_face["aq_cctv_bookcase_01"]["dx_vom_enf_cctv_post_intro_interrogation1_40"] = % dx_vom_enf_cctv_post_intro_interrogation1_40_face;
  level.scr_face["aq_cctv_bookcase_01"]["dx_vom_enf_cctv_post_intro_interrogation1_50"] = % dx_vom_enf_cctv_post_intro_interrogation1_50_face;
  level.scr_face["bookcase_victim"]["dx_vom_cvm1_cctv_post_intro_interrogation1_30"] = % dx_vom_cvm1_cctv_post_intro_interrogation1_30_face;
  level.scr_face["bookcase_victim"]["dx_vom_cvm1_cctv_post_intro_interrogation1_70"] = % dx_vom_cvm1_cctv_post_intro_interrogation1_70_face;
  level.scr_face["wounded_victim"]["dx_vom_cvm2_cctv_02_wounded_90"] = % dx_vom_cvm2_cctv_02_wounded_90_face;
  level.scr_face["hadir"]["dx_vom_had_defend_mortar_building_182"] = % dx_vom_had_defend_mortar_building_182_face;
  level.scr_face["hadir"]["dx_vom_had_defend_mortar_building_184"] = % dx_vom_had_defend_mortar_building_184_face;
  level.scr_face["hadir"]["dx_vom_had_defend_mortar_building_186"] = % dx_vom_had_defend_mortar_building_186_face;
  level.scr_face["hadir"]["dx_vom_had_defend_mortar_building_188"] = % dx_vom_had_defend_mortar_building_188_face;
  level.scr_face["hadir"]["dx_vom_had_defend_mortar_building_192"] = % dx_vom_had_defend_mortar_building_192_face;
  level.scr_face["hadir"]["dx_vom_had_defend_mortar_building_194"] = % dx_vom_had_defend_mortar_building_194_face;
  level.scr_face["hadir"]["dx_vom_had_defend_mortar_building_196"] = % dx_vom_had_defend_mortar_building_196_face;
  level.scr_face["hadir"]["dx_vom_had_defend_mortar_building_198"] = % dx_vom_had_defend_mortar_building_198_face;
  level.scr_face["hadir"]["dx_vom_had_defend_mortar_interior_50"] = % dx_vom_had_defend_mortar_interior_50_face;
  level.scr_face["hadir"]["dx_vom_had_defend_mortar_interior_60"] = % dx_vom_had_defend_mortar_interior_60_face;
  level.scr_face["hadir"]["dx_vom_had_defend_mortar_interior_70"] = % dx_vom_had_defend_mortar_interior_70_face;
  level.scr_face["price"]["dx_vom_pri_defend_building_fight_50"] = % dx_vom_pri_defend_building_fight_50_face;
  level.scr_face["price"]["dx_vom_pri_defend_building_fight_30"] = % dx_vom_pri_defend_building_fight_30_face;
  level.scr_face["price"]["dx_vom_pri_defend_building_fight_20"] = % dx_vom_pri_defend_building_fight_20_face;
  level.scr_face["price"]["dx_vom_pri_defend_resupply_20"] = % dx_vom_pri_defend_resupply_20_face;
  level.scr_face["price"]["dx_vom_pri_defend_resupply_70"] = % dx_vom_pri_defend_resupply_70_face;
  level.scr_face["price"]["dx_vom_pri_defend_resupply_60"] = % dx_vom_pri_defend_resupply_60_face;
  level.scr_face["price"]["dx_vom_pri_defend_resupply_50"] = % dx_vom_pri_defend_resupply_50_face;
  level.scr_face["price"]["dx_vom_pri_defend_resupply_40"] = % dx_vom_pri_defend_resupply_40_face;
  level.scr_face["ambo"]["dx_vom_amba_cctv_01_intro_20"] = % dx_vom_amba_cctv_01_intro_20_face;
}

cue_exit_civs(var_0) {
  scripts\engine\utility::flag_set("cue_exit_civs");
}

emb_roof_vo(var_0) {
  var_1 = lookupsoundlength("dx_vom_pri_roof_crash_10");
  wait(var_1);
  wait 0.4;
  thread scripts\engine\sp\utility::smart_radio_dialogue("dx_vom_alx_roof_crash_15");
  wait 0.3;
  var_0 scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_roof_crash_30");
  scripts\engine\sp\utility::smart_radio_dialogue("dx_vom_alx_roof_crash_35");
}

roof_to_stairs_vo(var_0) {
  thread emb_roof_pre_office_vo();
  var_0 scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_topfloor_office_03");
  wait 0.8;
  level.player scripts\engine\sp\utility::smart_dialogue("dx_vom_kyle_topfloor_office_04");
  wait 1.3;
  var_0 scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_topfloor_office_07");
}

emb_roof_pre_office_vo() {
  scripts\engine\utility::flag_wait("near_office_door");
  var_0 = scripts\engine\utility::getStruct("ap_offices_chaos", "targetname");
  var_1 = spawn("script_origin", var_0.origin);
  var_1 scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_fmgr_topfloor_office_02");
}

office_side_vo_1(var_0) {
  level endon("passed_door_to_stairs");

  if(scripts\engine\utility::flag("office_side_vo_1")) {
    return;
  }
  scripts\engine\utility::flag_set("office_side_vo_1");
  var_0 thread stop_office_side_vo();
  var_0 scripts\engine\sp\utility::smart_dialogue("dx_vom_cvm1_topfloor_office_80");
  var_0 scripts\engine\sp\utility::smart_dialogue("dx_vom_cvm2_topfloor_office_90");
  var_0 scripts\engine\sp\utility::smart_dialogue("dx_vom_cvm1_topfloor_office_100");
  var_0 scripts\engine\sp\utility::smart_dialogue("dx_vom_cvm2_topfloor_office_110");
  var_0 scripts\engine\sp\utility::smart_dialogue("dx_vom_cvm1_topfloor_office_120");
}

office_side_vo_2(var_0) {
  level endon("passed_door_to_stairs");

  if(scripts\engine\utility::flag("office_side_vo_2")) {
    return;
  }
  scripts\engine\utility::flag_set("office_side_vo_2");
  scripts\engine\utility::flag_wait("cue_exit_civs");
  var_0 thread stop_office_side_vo();
  var_0 scripts\engine\sp\utility::smart_dialogue("dx_vom_wk3_topfloor_office_130");
  var_0 scripts\engine\sp\utility::smart_dialogue("dx_vom_wk3_topfloor_office_140");
  var_0 scripts\engine\sp\utility::smart_dialogue("dx_vom_cvm1_topfloor_office_150");
  var_0 scripts\engine\sp\utility::smart_dialogue("dx_vom_wk3_topfloor_office_160");
  var_0 scripts\engine\sp\utility::smart_dialogue("dx_vom_wk3_topfloor_office_170");
  wait 1;
  var_0 scripts\engine\sp\utility::smart_dialogue("dx_vom_wk3_topfloor_office_180");
}

office_side_vo_3(var_0) {
  level endon("passed_door_to_stairs");

  if(scripts\engine\utility::flag("office_side_vo_3")) {
    return;
  }
  scripts\engine\utility::flag_set("office_side_vo_3");
  scripts\engine\utility::flag_wait("cue_exit_civs");
  wait 2.5;
  var_0 scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_cvf1_topfloor_office_340");
  var_0 scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_civ4_topfloor_office_350");
  var_0 scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_cvm1_topfloor_office_360");
}

attach_keycard_left(var_0) {
  var_0.keycard = scripts\engine\sp\utility::getmodel("keycard");
  var_0 attach(var_0.keycard, "tag_accessory_left");
  level waittill("detach_keycard");
  var_0 detach(var_0.keycard, "tag_accessory_left");
}

attach_keycard_right(var_0) {
  var_0.keycard = scripts\engine\sp\utility::getmodel("keycard");
  var_0 attach(var_0.keycard, "tag_accessory_right");
  level waittill("detach_keycard");
  var_0 detach(var_0.keycard, "tag_accessory_right");
}

enforcer_pistol_fire(var_0) {
  var_1 = var_0 gettagorigin("tag_weapon_left");
  var_2 = var_0 gettagangles("tag_weapon_left");
  var_3 = var_1 + anglesToForward(var_2) * 1.3 + anglestoup(var_2) * 2.1;
  var_4 = var_3 + anglesToForward(var_2) * 100;
  magicbullet(var_0.sidearm, var_3, var_4);
}

stop_office_side_vo() {
  scripts\engine\utility::flag_wait("passed_door_to_stairs");

  if(isDefined(self))
    self stopsounds();
}

md_vo(var_0) {
  wait 2;
  level.player scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_kyle_entrance_overrun_55");
  level.player scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_kyle_entrance_overrun_56");
  level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_entrance_overrun_60");
  level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_entrance_overrun_130");
  wait 1;
  level.player scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_kyle_entrance_overrun_135");
  wait 0.5;
  level.price scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_pri_entrance_overrun_131");
}

headtrack_on(var_0) {
  var_0 scripts\common\utility::lookatentity(level.player);
}

headtrack_off(var_0) {
  var_0 scripts\common\utility::lookatentity();
}

bpg_scene_price_vo_nag(var_0) {
  level endon("bpg_scene_enforcer_done");
  level endon("bpg_scene_interact_success");
  var_0 scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_reception_bulletproof_124");
  wait 15;
  var_0 scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_reception_bulletproof_122");
}

bpg_scene_civ_vo(var_0) {
  wait 14;
  wait 7;
}

bpg_scene_escape_idle_nag_vo(var_0) {
  if(!isDefined(level.price.escape_idle_nags)) {
    var_1 = ["dx_vom_pri_reception_bulletproof_140", "dx_vom_pri_reception_bulletproof_132", "dx_vom_pri_reception_bulletproof_135"];
    level.price.escape_idle_nags = scripts\engine\sp\utility::create_deck(var_1);
  }

  if(level.price scripts\sp\maps\embassy\embassy_util.gsc::player_moving_toward())
    return 0;

  level.price scripts\engine\sp\utility::smart_dialogue(level.price.escape_idle_nags scripts\engine\sp\utility::deck_draw());
}

bpg_scene_price_push_door(var_0) {
  var_1 = scripts\sp\door::get_interactive_door("bpg_scene_entrance_door");

  if(var_1.angles[1] < 350) {
    var_1 thread scripts\sp\door::remove_open_ability();
    var_1 thread scripts\sp\door::door_open_completely(level.price, 0.5);
  }
}

halligan_breakout_a(var_0) {
  level.halligan_breakout = "breakout_a";
}

halligan_breakout_b(var_0) {
  level.halligan_breakout = "breakout_b";
}

halligan_breakout_end(var_0) {
  level.halligan_breakout = undefined;
}

drag_scene_shoot(var_0) {
  var_1 = scripts\engine\utility::getStruct("drag_scene_shooter", "targetname");
  var_1.groundorigin = scripts\engine\utility::drop_to_ground(var_1.origin, 0, -100);
  var_2 = 100;
  var_3 = 0.5;
  var_4 = var_3 * 20;
  var_5 = var_4 * 0.5;

  for(var_6 = 0; var_6 < var_4; var_6++) {
    if(var_6 < var_5) {
      var_7 = var_6 / var_5;
      var_7 = 1 - var_7;
      var_8 = vectorNormalize(var_1.groundorigin - var_0.origin);
      var_9 = var_0.origin + var_8 * (var_2 * var_7);
    } else {
      var_7 = (var_6 - var_5) / var_4;
      var_10 = var_0.origin + (0, 0, 52);
      var_8 = vectorNormalize(var_10 - var_0.origin);
      var_9 = var_0.origin + var_8 * (var_2 * var_7);
    }

    magicbullet("iw8_ar_akilo47", var_1.origin, var_9);
    waitframe();
  }
}

price_directions_finished(var_0) {
  wait(lookupsoundlength("dx_vom_pri_defend_intro_30") / 1000);
  wait 0.25;
  level.alex scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_alx_defend_intro_40");
  wait 0.1;
  level.player scripts\sp\maps\embassy\embassy_util.gsc::say_as_chatter("dx_vom_kyle_defend_intro_130");
}

price_intro_vo_finished(var_0) {
  wait(lookupsoundlength("dx_vom_pri_defend_roof_60") / 1000);
  scripts\engine\utility::flag_set("intro_vo_finished");
}

grab_glowstick(var_0) {
  var_1 = getEnt("light_stick", "targetname");
  var_1 show();
  var_1 linkTo(var_0, "tag_ik_wrist_loc_ri", (3, 0, 0), (0, 0, 0));
  var_0.glowstick = var_1;
  var_2 = var_0.glowstick.light;
  var_2.origin = var_1.origin;
  var_2 linkTo(var_1);
  var_3 = scripts\engine\utility::spawn_tag_origin(var_1.origin, var_1.angles);
  var_3 linkTo(var_1);
  var_1 hide();
  playFXOnTag(scripts\engine\utility::getfx("vfx_glow_stick"), var_3, "tag_origin");
  level waittill("mortar_impact");
  waitframe();
  level waittill("mortar_impact");
  stopFXOnTag(scripts\engine\utility::getfx("vfx_glow_stick"), var_3, "tag_origin");
}

toss_glowstick(var_0) {
  wait 0.1;
  var_1 = var_0.glowstick;
  var_1 unlink();
  var_2 = getdvarint("NPOQPMP");
  var_3 = distance(var_1.origin, var_1.og_origin);
  var_4 = round_server_time(var_3 / 175);
  var_5 = var_1.og_origin - var_1.origin;
  var_6 = 0.5 * var_2 * squared(var_4) * -1;
  var_7 = (var_5[0] / var_4, var_5[1] / var_4, (var_5[2] - var_6) / var_4);
  var_1.light unlink();
  var_1.light moveTo(var_1.light.og_origin, var_4);
  var_1.light rotateTo(var_1.light.og_angles, var_4);
  var_1 movegravity(var_7, var_4);
  var_1 rotateTo(var_1.og_angles, var_4);
}

round_server_time(var_0) {
  var_0 = var_0 * 20;
  var_1 = int(var_0);
  return var_1 / 20;
}

crowguy_vo(var_0) {
  level notify("stop_basement_vo");
  var_0 scripts\engine\sp\utility::smart_dialogue_generic("dx_vom_aq1_basement_traverse_08");
}

arrival_hadir_pistol_holster(var_0) {
  if(isDefined(level.hadir.stowsidearmposition))
    level.hadir scripts\anim\shared.gsc::placeweaponon(level.hadir.sidearm, level.hadir.stowsidearmposition);
  else
    level.hadir scripts\anim\shared.gsc::placeweaponon(level.hadir.sidearm, "none");
}

arrival_hadir_pickup_rifle(var_0) {
  level.hadir scripts\anim\shared.gsc::placeweaponon(level.hadir.primaryweapon, "right");
  level.hadir.weapon = level.hadir.primaryweapon;
}

#using_animtree("script_model");

script_models() {
  level.scr_animtree["door"] = #animtree;
  level.scr_animtree["infil_fast_rope"] = #animtree;
  level.scr_model["infil_fast_rope"] = "equipment_fast_rope_wm_01_infil_heli_l";
  level.scr_anim["infil_fast_rope"]["infil_crash_ride"] = % emb_infil_010_crash_ride_rope;
  level.scr_anim["infil_fast_rope"]["infil_crash_crawl"] = % emb_infil_010_crash_crawl_rope;
  level.scr_goaltime["infil_fast_rope"]["infil_crash_crawl"] = 0.0;
  level.scr_anim["infil_fast_rope"]["infil_crash_crawl_idle"][0] = % emb_infil_010_crash_crawl_idle_rope;
  level.scr_goaltime["infil_fast_rope"]["infil_crash_crawl_idle"] = 0.0;
  level.scr_anim["infil_fast_rope"]["infil_crash_fall_relative"] = % emb_infil_010_crash_fall_relative_rope;
  level.scr_goaltime["infil_fast_rope"]["infil_crash_fall_relative"] = 0.0;
  level.scr_anim["infil_fast_rope"]["infil_crash_fall"] = % emb_infil_010_crash_fall_rope;
  level.scr_goaltime["infil_fast_rope"]["infil_crash_fall"] = 0.0;
  level.scr_animtree["price_hat"] = #animtree;
  level.scr_model["price_hat"] = "hat_prop_hero_price_boonie";
  level.scr_anim["price_hat"]["infil_crash_hat_pickup"] = % emb_infil_010_crash_fall_price_hat;
  level.scr_animtree["price_crash_gun"] = #animtree;
  level.scr_anim["price_crash_gun"]["infil_crash_fall"] = % emb_infil_010_crash_fall_gun;
  level.scr_animtree["infil_crash_rocket"] = #animtree;
  level.scr_model["infil_crash_rocket"] = "weapon_wm_missile_rpapa7";
  level.scr_anim["infil_crash_rocket"]["infil_crash_ride"] = % emb_infil_010_crash_rocket;
  scripts\common\anim::addnotetrack_notify("infil_crash_rocket", "rocket_fire", "rocket_fire", "infil_crash_ride");
  scripts\common\anim::addnotetrack_notify("infil_crash_rocket", "rocket_hit", "rocket_hit", "infil_crash_ride");
  level.scr_animtree["infil_crash_rocket_miss"] = #animtree;
  level.scr_model["infil_crash_rocket_miss"] = "weapon_wm_missile_rpapa7";
  level.scr_anim["infil_crash_rocket_miss"]["infil_crash_ride"] = % emb_infil_010_crash_rocket_02;
  scripts\common\anim::addnotetrack_notify("infil_crash_rocket_miss", "rocket_fire", "rocket_fire", "infil_crash_ride");
  level.scr_animtree["infil_crash_wreckage_01"] = #animtree;
  level.scr_model["infil_crash_wreckage_01"] = "barrier_chain_link_fence_160_01";
  level.scr_anim["infil_crash_wreckage_01"]["infil_crash_fall"] = % emb_infil_010_crash_fall_fence_160;
  level.scr_animtree["infil_crash_wreckage_02"] = #animtree;
  level.scr_model["infil_crash_wreckage_02"] = "barrier_chain_link_fence_32_01";
  level.scr_anim["infil_crash_wreckage_02"]["infil_crash_fall"] = % emb_infil_010_crash_fall_fence_32;
  level.scr_animtree["infil_crash_wreckage_03"] = #animtree;
  level.scr_model["infil_crash_wreckage_03"] = "equipment_antenna_set_01_tall";
  level.scr_anim["infil_crash_wreckage_03"]["infil_crash_fall"] = % emb_infil_010_crash_fall_antenna_tall_01;
  level.scr_animtree["gate_car"] = #animtree;
  level.scr_model["gate_car"] = "veh8_civ_lnd_walfa_static_dst";
  level.scr_animtree["mortar"] = #animtree;
  level.scr_model["mortar"] = "misc_wm_mortar";
  level.scr_anim["mortar"]["player_mortar_fire"] = % emb_vm_mortar_mortar;
  level.scr_anim["mortar"]["rooftops_idle"][0] = % emb_def_020_rooftop_idle_mortar;
  level.scr_anim["mortar"]["rooftops_begin"] = % emb_def_020_rooftop_mortar;
  level.scr_animtree["chair1"] = #animtree;
  level.scr_model["chair1"] = "chair_folding";
  level.scr_anim["chair1"]["civ_chair"] = % emb_def_civ_table_exit_chair1;
  level.scr_anim["chair1"]["civ_chair_idle"][0] = % emb_def_civ_table_idle_chair1;
  level.scr_animtree["chair2"] = #animtree;
  level.scr_model["chair2"] = "chair_folding";
  level.scr_anim["chair2"]["civ_chair"] = % emb_def_civ_table_exit_chair2;
  level.scr_anim["chair2"]["civ_chair_idle"][0] = % emb_def_civ_table_idle_chair2;
  level.scr_animtree["bike1"] = #animtree;
  level.scr_model["bike1"] = "misc_emb_bike";
  level.scr_anim["bike1"]["civ_bikers"] = % emb_def_civs_bike_b_bike;
  level.scr_animtree["ammo_box"] = #animtree;
  level.scr_model["ammo_box"] = "container_ammo_box_01";
  level.scr_anim["ammo_box"]["rooftops_begin"] = % emb_def_020_rooftop_box;
  level.scr_animtree["mortar"] = #animtree;
  level.scr_model["mortar"] = "misc_wm_mortar_shell";
  level.scr_animtree["gate_l"] = #animtree;
  level.scr_model["gate_l"] = "me_gate_long_exterior_metal_01";
  level.scr_anim["gate_l"]["gate_overrun_idle"][0] = % emb_infil_10_crash_bg_idle_gatel;
  level.scr_anim["gate_l"]["gate_overrun"] = % emb_infil_10_crash_bg_gatel;
  level.scr_animtree["gate_r"] = #animtree;
  level.scr_model["gate_r"] = "me_gate_long_exterior_metal_01";
  level.scr_anim["gate_r"]["gate_overrun_idle"][0] = % emb_infil_10_crash_bg_idle_gater;
  level.scr_anim["gate_r"]["gate_overrun"] = % emb_infil_10_crash_bg_gater;
  level.scr_animtree["keycard"] = #animtree;
  level.scr_model["keycard"] = "electronics_keycard_office_01";
  level.scr_animtree["card_reader_green"] = #animtree;
  level.scr_model["card_reader_green"] = "electrical_office_security_lock_01";
  level.scr_animtree["card_reader_red"] = #animtree;
  level.scr_model["card_reader_red"] = "electrical_office_security_lock_01_lock";
  level.scr_animtree["offices_door"] = #animtree;
  level.scr_model["offices_door"] = "door_metal_office_single_01";
  level.scr_anim["offices_door"]["offices_chaos"] = % emb_infil_030_offices_door;
  level.scr_animtree["offices_door"] = #animtree;
  level.scr_model["offices_door"] = "door_metal_office_single_01";
  level.scr_anim["offices_door"]["offices_chaos"] = % emb_infil_030_offices_door;
  level.scr_animtree["stairwell_door"] = #animtree;
  level.scr_model["stairwell_door"] = "door_metal_office_single_01";
  level.scr_anim["stairwell_door"]["stairwell_door"] = % emb_bpg_005_price_stairs_down_a_door;
  level.scr_animtree["offices_prop_1"] = #animtree;
  level.scr_model["offices_prop_1"] = "un_office_paper_shredder_01";
  level.scr_anim["offices_prop_1"]["offices_chaos"] = % emb_infil_030_offices_civ01_shredder;
  level.scr_animtree["offices_prop_2"] = #animtree;
  level.scr_model["offices_prop_2"] = "un_office_paper_shredder_01";
  level.scr_anim["offices_prop_2"]["offices_chaos"] = % emb_infil_030_offices_civ07_shredder;
  level.scr_animtree["offices_prop_3"] = #animtree;
  level.scr_model["offices_prop_3"] = "un_office_paper_stack_01";
  level.scr_anim["offices_prop_3"]["offices_chaos"] = % emb_infil_030_offices_civ01_paper_stack;
  level.scr_animtree["offices_prop_4"] = #animtree;
  level.scr_model["offices_prop_4"] = "offhand_vm_cellphone_old_on";
  level.scr_anim["offices_prop_4"]["offices_chaos"] = % emb_infil_030_offices_manager_phone;
  level.scr_anim["offices_prop_4"]["offices_chaos_idle"][0] = % emb_infil_030_offices_manager_phone_idle;
  level.scr_animtree["offices_prop_5"] = #animtree;
  level.scr_model["offices_prop_5"] = "un_office_paper_01";
  level.scr_anim["offices_prop_5"]["offices_chaos"] = % emb_infil_030_offices_civ01_paper;
  level.scr_anim["offices_prop_5"]["offices_chaos_idle"][0] = % emb_infil_030_offices_civ01_paper_idle;
  level.scr_animtree["offices_prop_6"] = #animtree;
  level.scr_model["offices_prop_6"] = "ee_furniture_chair_desk_01";
  level.scr_anim["offices_prop_6"]["offices_chaos"] = % emb_infil_030_offices_civ02_chair;
  level.scr_animtree["offices_prop_7"] = #animtree;
  level.scr_model["offices_prop_7"] = "un_office_storage_box_open_01";
  level.scr_anim["offices_prop_7"]["offices_chaos"] = % emb_infil_030_offices_civ02_case;
  level.scr_animtree["offices_prop_8"] = #animtree;
  level.scr_model["offices_prop_8"] = "offhand_vm_cellphone_old_on";
  level.scr_anim["offices_prop_8"]["offices_chaos"] = % emb_infil_030_offices_civ03_phone;
  level.scr_anim["offices_prop_8"]["offices_chaos_idle"][0] = % emb_infil_030_offices_civ03_phone_idle;
  level.scr_animtree["offices_prop_9"] = #animtree;
  level.scr_model["offices_prop_9"] = "ee_furniture_chair_desk_01";
  level.scr_anim["offices_prop_9"]["offices_chaos"] = % emb_infil_030_offices_civ05_chair;
  level.scr_animtree["offices_prop_10"] = #animtree;
  level.scr_model["offices_prop_10"] = "offhand_vm_cellphone_old_on";
  level.scr_anim["offices_prop_10"]["offices_chaos"] = % emb_infil_030_offices_civ05_phone;
  level.scr_anim["offices_prop_10"]["offices_chaos_idle"][0] = % emb_infil_030_offices_civ05_phone_idle;
  level.scr_animtree["offices_prop_11"] = #animtree;
  level.scr_model["offices_prop_11"] = "misc_computer_mouse_black_01";
  level.scr_anim["offices_prop_11"]["offices_chaos"] = % emb_infil_030_offices_civ05_mouse;
  level.scr_anim["offices_prop_11"]["offices_chaos_idle"][0] = % emb_infil_030_offices_civ05_mouse_idle;
  level.scr_animtree["offices_prop_12"] = #animtree;
  level.scr_model["offices_prop_12"] = "computer_pc_tower_01";
  level.scr_anim["offices_prop_12"]["offices_chaos"] = % emb_infil_030_offices_civ06_computer;
  level.scr_animtree["offices_prop_13"] = #animtree;
  level.scr_model["offices_prop_13"] = "un_office_storage_box_open_01";
  level.scr_anim["offices_prop_13"]["offices_chaos"] = % emb_infil_030_offices_civ07_case;
  level.scr_animtree["offices_prop_14"] = #animtree;
  level.scr_model["offices_prop_14"] = "un_office_paper_01";
  level.scr_anim["offices_prop_14"]["offices_chaos"] = % emb_infil_030_offices_civ07_paper;
  level.scr_anim["offices_prop_14"]["offices_chaos_idle"][0] = % emb_infil_030_offices_civ07_paper_idle;
  level.scr_animtree["offices_prop_15"] = #animtree;
  level.scr_model["offices_prop_15"] = "offhand_vm_cellphone_old_on";
  level.scr_anim["offices_prop_15"]["offices_chaos"] = % emb_infil_030_offices_civ18_phone;
  level.scr_anim["offices_prop_15"]["offices_chaos_idle"][0] = % emb_infil_030_offices_civ18_phone_idle;
  level.scr_animtree["offices_prop_16"] = #animtree;
  level.scr_model["offices_prop_16"] = "offhand_vm_cellphone_old_on";
  level.scr_anim["offices_prop_16"]["offices_chaos"] = % emb_infil_030_offices_civ21_phone;
  level.scr_anim["offices_prop_16"]["offices_chaos_idle"][0] = % emb_infil_030_offices_civ21_phone_idle;
  level.scr_animtree["offices_prop_17"] = #animtree;
  level.scr_model["offices_prop_17"] = "un_office_storage_box_open_01";
  level.scr_anim["offices_prop_17"]["offices_chaos"] = % emb_infil_030_offices_civ14_case;
  level.scr_animtree["offices_prop_18"] = #animtree;
  level.scr_model["offices_prop_18"] = "misc_computer_mouse_black_01";
  level.scr_anim["offices_prop_18"]["offices_chaos_idle"][0] = % emb_infil_030_offices_civ16_mouse_idle;
  level.scr_anim["offices_prop_18"]["offices_chaos_idle2"][0] = % emb_infil_030_offices_civ16_mouse_idle02;
  level.scr_animtree["offices_prop_19"] = #animtree;
  level.scr_model["offices_prop_19"] = "offhand_vm_cellphone_old_on";
  level.scr_anim["offices_prop_19"]["offices_chaos_idle"][0] = % emb_infil_030_offices_civ24_phone;
  level.scr_animtree["offices_prop_20"] = #animtree;
  level.scr_model["offices_prop_20"] = "uk_file_cabinet_garage_big_rig_01";
  level.scr_anim["offices_prop_20"]["offices_chaos"] = % emb_infil_030_offices_civ16_cabinet;
  level.scr_animtree["offices_prop_21"] = #animtree;
  level.scr_model["offices_prop_21"] = "uk_file_cabinet_garage_big_rig_01";
  level.scr_anim["offices_prop_21"]["offices_chaos"] = % emb_infil_030_offices_civ14_cabinet;
  level.scr_animtree["offices_prop_22"] = #animtree;
  level.scr_model["offices_prop_22"] = "offhand_vm_cellphone_old_on";
  level.scr_anim["offices_prop_22"]["offices_chaos"] = % emb_infil_030_offices_civ11_phone;
  level.scr_anim["offices_prop_22"]["offices_chaos_idle"][0] = % emb_infil_030_offices_civ11_idle_phone;
  level.scr_animtree["offices_prop_23"] = #animtree;
  level.scr_model["offices_prop_23"] = "un_office_storage_box_open_01";
  level.scr_anim["offices_prop_23"]["offices_chaos"] = % emb_infil_030_offices_civ13_case;
  level.scr_anim["offices_prop_23"]["offices_chaos_idle"][0] = % emb_infil_030_offices_civ13_idle_case;
  level.scr_animtree["offices_prop_24"] = #animtree;
  level.scr_model["offices_prop_24"] = "un_office_paper_01";
  level.scr_anim["offices_prop_24"]["offices_chaos"] = % emb_infil_030_offices_civ13_paper;
  level.scr_anim["offices_prop_24"]["offices_chaos_idle"][0] = % emb_infil_030_offices_civ13_idle_paper;
  level.scr_animtree["offices_prop_25"] = #animtree;
  level.scr_model["offices_prop_25"] = "uk_file_cabinet_garage_big_rig_01";
  level.scr_anim["offices_prop_25"]["offices_chaos"] = % emb_infil_030_offices_civ10_cabinet;
  level.scr_animtree["offices_prop_26"] = #animtree;
  level.scr_model["offices_prop_26"] = "uk_file_cabinet_garage_big_rig_01";
  level.scr_anim["offices_prop_26"]["offices_chaos"] = % emb_infil_030_offices_civ22_cabinet;
  level.scr_animtree["offices_prop_27"] = #animtree;
  level.scr_model["offices_prop_27"] = "uk_file_cabinet_garage_small_rig_01";
  level.scr_anim["offices_prop_27"]["offices_chaos"] = % emb_infil_030_offices_civ23_cabinet;
  level.scr_animtree["offices_prop_28"] = #animtree;
  level.scr_model["offices_prop_28"] = "un_office_paper_01";
  level.scr_anim["offices_prop_28"]["offices_chaos"] = % emb_infil_030_offices_civ10_paper;
  level.scr_anim["offices_prop_28"]["offices_chaos_idle"][0] = % emb_infil_030_offices_idle_civ10_paper;
  level.scr_animtree["offices_prop_29"] = #animtree;
  level.scr_model["offices_prop_29"] = "un_office_paper_01";
  level.scr_anim["offices_prop_29"]["offices_chaos_idle"][0] = % emb_infil_030_offices_idle_civ10_paper02;
  level.scr_animtree["offices_prop_30"] = #animtree;
  level.scr_model["offices_prop_30"] = "uk_file_cabinet_garage_big_rig_01";
  level.scr_anim["offices_prop_30"]["offices_chaos_idle"][0] = % emb_infil_030_offices_idle_civ19_cabinet_b;
  level.scr_animtree["offices_prop_31"] = #animtree;
  level.scr_model["offices_prop_31"] = "uk_file_cabinet_garage_small_rig_01";
  level.scr_anim["offices_prop_31"]["offices_chaos_idle"][0] = % emb_infil_030_offices_idle_civ19_cabinet_s;
  level.scr_animtree["offices_prop_32"] = #animtree;
  level.scr_model["offices_prop_32"] = "uk_file_cabinet_garage_small_rig_01";
  level.scr_anim["offices_prop_32"]["offices_chaos_idle"][0] = % emb_infil_030_offices_idle_civ20_cabinet;
  level.scr_animtree["offices_prop_33"] = #animtree;
  level.scr_model["offices_prop_33"] = "un_office_paper_stack_01";
  level.scr_anim["offices_prop_33"]["offices_chaos"] = % emb_infil_030_offices_civ10_paperstack;
  level.scr_animtree["offices_prop_avoid"] = #animtree;
  level.scr_model["offices_prop_avoid"] = "un_office_paper_01";
  level.scr_anim["offices_prop_avoid"]["offices_chaos_idle"][0] = % emb_infil_030_offices_idle2_civ14_paper;
  level.scr_animtree["crowd"] = #animtree;
  level.scr_model["crowd"] = "periph_crowd_combined";
  level.scr_animtree["crowd_low"] = #animtree;
  level.scr_model["crowd_low"] = "periph_crowd_combined_low";
  level.scr_anim["crowd_1"]["crowd_chant"][0] = % emb_infil_005_crowd_idle_crowd01;
  level.scr_anim["crowd_2"]["crowd_chant"][0] = % emb_infil_005_crowd_idle_crowd02;
  level.scr_anim["crowd_3"]["crowd_chant"][0] = % emb_infil_005_crowd_idle_crowd03;
  level.scr_anim["crowd_4"]["crowd_chant"][0] = % emb_infil_005_crowd_idle_crowd04;
  level.scr_anim["crowd_5"]["crowd_enter"] = % emb_infil_005_crowd_enter_crowd05;
  level.scr_anim["crowd_5"]["crowd_chant"][0] = % emb_infil_005_crowd_idle_crowd05;
  level.scr_anim["crowd_6"]["crowd_chant"][0] = % emb_infil_005_crowd_idle_crowd06;
  level.scr_anim["crowd_7"]["crowd_chant"][0] = % emb_infil_005_crowd_idle_crowd07;
  level.scr_anim["crowd_8"]["crowd_chant"][0] = % emb_infil_005_crowd_idle_crowd08;
  level.scr_anim["crowd_9"]["crowd_chant"][0] = % emb_infil_005_crowd_idle_crowd09;
  level.scr_anim["crowd_10"]["crowd_chant"][0] = % emb_infil_005_crowd_idle_crowd10;
  level.scr_anim["crowd_11"]["crowd_chant"][0] = % emb_infil_005_crowd_idle_crowd11;
  level.scr_anim["crowd_12"]["crowd_chant"][0] = % emb_infil_005_crowd_idle_crowd12;
  level.scr_anim["crowd_13"]["crowd_chant"][0] = % emb_infil_005_crowd_idle_crowd13;
  level.scr_anim["crowd_14"]["crowd_chant"][0] = % emb_infil_005_crowd_idle_crowd14;
  level.scr_anim["crowd_15"]["crowd_chant"][0] = % emb_infil_005_crowd_idle_crowd15;
  level.scr_anim["crowd_16"]["crowd_chant"][0] = % emb_infil_005_crowd_idle_crowd16;
  level.scr_anim["crowd_17"]["crowd_chant"][0] = % emb_infil_005_crowd_idle_crowd17;
  level.scr_anim["crowd_18"]["crowd_chant"][0] = % emb_infil_005_crowd_idle_crowd18;
  level.scr_anim["crowd_19"]["crowd_chant"][0] = % emb_infil_005_crowd_idle_crowd19;
  level.scr_anim["crowd_20"]["crowd_chant"][0] = % emb_infil_005_crowd_idle_crowd20;
  level.scr_anim["crowd_21"]["crowd_chant"][0] = % emb_infil_005_crowd_idle_crowd21;
  level.scr_anim["crowd_22"]["crowd_chant"][0] = % emb_infil_005_crowd_idle_crowd22;
  level.scr_anim["crowd_23"]["crowd_chant"][0] = % emb_infil_005_crowd_idle_crowd23;
  level.scr_anim["crowd_24"]["crowd_chant"][0] = % emb_infil_005_crowd_idle_crowd24;
  level.scr_anim["crowd_25"]["crowd_chant"][0] = % emb_infil_005_crowd_idle_crowd25;
  level.scr_anim["crowd_26"]["crowd_chant"][0] = % emb_infil_005_crowd_idle_crowd26;
  level.scr_anim["crowd_27"]["crowd_chant"][0] = % emb_infil_005_crowd_idle_crowd27;
  level.scr_anim["crowd_28"]["crowd_chant"][0] = % emb_infil_005_crowd_idle_crowd28;
  level.scr_anim["crowd_29"]["crowd_chant"][0] = % emb_infil_005_crowd_idle_crowd29;
  level.scr_anim["crowd_30"]["crowd_chant"][0] = % emb_infil_005_crowd_idle_crowd30;
  level.scr_anim["crowd_31"]["crowd_enter"] = % emb_infil_005_crowd_enter_crowd31;
  level.scr_anim["crowd_31"]["crowd_chant"][0] = % emb_infil_005_crowd_idle_crowd31;
  level.scr_anim["crowd_32"]["crowd_enter"] = % emb_infil_005_crowd_enter_crowd32;
  level.scr_anim["crowd_32"]["crowd_chant"][0] = % emb_infil_005_crowd_idle_crowd32;
  level.scr_anim["crowd_33"]["crowd_enter"] = % emb_infil_005_crowd_enter_crowd33;
  level.scr_anim["crowd_33"]["crowd_chant"][0] = % emb_infil_005_crowd_idle_crowd33;
  level.scr_anim["crowd_34"]["crowd_enter"] = % emb_infil_005_crowd_enter_crowd34;
  level.scr_anim["crowd_34"]["crowd_chant"][0] = % emb_infil_005_crowd_idle_crowd34;
  level.scr_anim["crowd_35"]["crowd_enter"] = % emb_infil_005_crowd_enter_crowd35;
  level.scr_anim["crowd_1"]["crowd_chant_offices"][0] = % emb_infil_005_crowd_idle_b_crowd01;
  level.scr_anim["crowd_2"]["crowd_chant_offices"][0] = % emb_infil_005_crowd_idle_b_crowd02;
  level.scr_animtree["crowd_veh_1"] = #animtree;
  level.scr_model["crowd_veh_1"] = "veh8_civ_lnd_palfa_periph_white";
  level.scr_anim["crowd_veh_1"]["crowd_enter"] = % emb_infil_005_crowd_enter_veh01;
  level.scr_animtree["crowd_veh_2"] = #animtree;
  level.scr_model["crowd_veh_2"] = "veh8_civ_lnd_victor40_periph_white";
  level.scr_anim["crowd_veh_2"]["crowd_enter"] = % emb_infil_005_crowd_enter_veh02;
  level.scr_animtree["crowd_veh_3"] = #animtree;
  level.scr_model["crowd_veh_3"] = "veh8_civ_lnd_victor40_periph_white";
  level.scr_anim["crowd_veh_3"]["crowd_enter"] = % emb_infil_005_crowd_enter_veh03;
  level.scr_animtree["periph_veh"] = #animtree;
  level.scr_model["periph_veh"] = "veh8_civ_lnd_periph_combined";
  level.scr_anim["periph_veh"]["ambiance"][0] = % emb_infil_005_crowd_enter_veh_combined;
  level.scr_animtree["roof_door"] = #animtree;
  level.scr_model["roof_door"] = "door_metal_single_b_01_grey_sp";
  level.scr_anim["roof_door"]["roof_stair_to_office"] = % emb_infil_011_stair_enter_door;
  level.scr_animtree["stair_car"] = #animtree;
  level.scr_model["stair_car"] = "veh8_civ_lnd_skilo";
  level.scr_anim["stair_car"]["stairwell_second_window"] = % sh_nh_022_carstop_b_car;
  level.scr_animtree["md_gun"] = #animtree;
  level.scr_model["md_gun"] = "weapon_wm_pi_golf21_sp";
  level.scr_anim["md_gun"]["bpg_md_first_wave"] = % emb_bpg_010_md_scenea_security03_pistol;
  scripts\common\anim::addnotetrack_customfunction("md_gun", "fire_magic_bullet", ::emb_nt_fire_magic_bullet, "bpg_md_first_wave");
  level.scr_animtree["md_table"] = #animtree;
  level.scr_model["md_table"] = "me_furniture_fancy_table_low_02";
  level.scr_anim["md_table"]["bpg_md_first_wave"] = % emb_bpg_010_md_scenec_aq29_table;
  level.scr_animtree["md_door_1"] = #animtree;
  level.scr_model["md_door_1"] = "door_metal_office_double_right_04";
  level.scr_anim["md_door_1"]["bpg_md_first_wave"] = % emb_bpg_010_md_scenea_door1;
  level.scr_animtree["md_door_2"] = #animtree;
  level.scr_model["md_door_2"] = "door_metal_office_double_left_04";
  level.scr_anim["md_door_2"]["bpg_md_first_wave"] = % emb_bpg_010_md_scenea_door2;
  level.scr_animtree["md_door_3"] = #animtree;
  level.scr_model["md_door_3"] = "door_metal_office_double_right_02";
  level.scr_anim["md_door_3"]["bpg_md_first_wave"] = % emb_bpg_010_md_scenea_door3;
  level.scr_animtree["md_door_4"] = #animtree;
  level.scr_model["md_door_4"] = "door_metal_office_double_left_02";
  level.scr_anim["md_door_4"]["bpg_md_first_wave"] = % emb_bpg_010_md_scenea_door4;
  level.scr_animtree["md_office_chair"] = #animtree;
  level.scr_model["md_office_chair"] = "ee_furniture_chair_desk_01";
  level.scr_anim["md_office_chair"]["bpg_md_first_wave"] = % emb_bpg_010_md_scenec_security05_chair;
  level.scr_animtree["lower_stairwell_door"] = #animtree;
  level.scr_model["lower_stairwell_door"] = "door_metal_office_single_04";
  level.scr_anim["lower_stairwell_door"]["stairwell_d_break_door"] = % emb_bpg_005_door_stairs_break_door_d;
  level.scr_animtree["bpg_scene_door_l"] = #animtree;
  level.scr_model["bpg_scene_door_l"] = "door_metal_office_double_left_04";
  level.scr_anim["bpg_scene_door_l"]["bpg_scene"] = % emb_enf_020_hostage_exit_door01_open;
  level.scr_anim["bpg_scene_door_l"]["bpg_scene_exit"] = % emb_enf_020_hostage_exit_door01_close;
  level.scr_animtree["bpg_scene_door_r"] = #animtree;
  level.scr_model["bpg_scene_door_r"] = "door_metal_office_double_right_04";
  level.scr_anim["bpg_scene_door_r"]["bpg_scene"] = % emb_enf_020_hostage_exit_door02_open;
  level.scr_anim["bpg_scene_door_r"]["bpg_scene_exit"] = % emb_enf_020_hostage_exit_door02_close;
  level.scr_animtree["bpg_scene_chair_1"] = #animtree;
  level.scr_model["bpg_scene_chair_1"] = "uk_chairs_waiting_room_01_blue";
  level.scr_anim["bpg_scene_chair_1"]["bpg_scene"] = % emb_enf_020_hostage_scenea_aq04_chair01;
  level.scr_anim["bpg_scene_chair_1"]["bpg_scene_escape_idle"][0] = % emb_enf_020_hostage_idlec_aq04_chair01;
  level.scr_animtree["bpg_scene_chair_2"] = #animtree;
  level.scr_model["bpg_scene_chair_2"] = "uk_chairs_waiting_room_01_blue";
  level.scr_anim["bpg_scene_chair_2"]["bpg_scene"] = % emb_enf_020_hostage_scenea_aq09_chair02;
  level.scr_animtree["bpg_scene_chair_3"] = #animtree;
  level.scr_model["bpg_scene_chair_3"] = "uk_chairs_waiting_room_01_blue";
  level.scr_anim["bpg_scene_chair_3"]["bpg_scene"] = % emb_enf_020_hostage_scenea_civ12_chair03;
  level.scr_animtree["bpg_scene_crowbar"] = #animtree;
  level.scr_model["bpg_scene_crowbar"] = "equipment_metal_crowbar_01";
  level.scr_anim["bpg_scene_crowbar"]["bpg_scene"] = % emb_enf_020_hostage_scenea_aq13_crowbar;
  level.scr_animtree["bpg_scene_door_latch"] = #animtree;
  level.scr_model["bpg_scene_door_latch"] = "door_bar_latch_01";
  level.scr_anim["bpg_scene_door_latch"]["bpg_scene_door_enter"] = % emb_bpg_020_hostage_door_enter_latch;
  level.scr_goaltime["bpg_scene_door_latch"]["bpg_scene_door_enter"] = 0.0;
  level.scr_anim["bpg_scene_door_latch"]["bpg_scene_door_struggle"] = % emb_bpg_020_hostage_door_struggle_latch;
  level.scr_goaltime["bpg_scene_door_latch"]["bpg_scene_door_struggle"] = 0.1;
  level.scr_anim["bpg_scene_door_latch"]["bpg_scene_door_success"] = % emb_bpg_020_hostage_door_success_latch;
  level.scr_goaltime["bpg_scene_door_latch"]["bpg_scene_door_success"] = 1.0;
  level.scr_animtree["truck_office_collapse_wall"] = #animtree;
  level.scr_model["truck_office_collapse_wall"] = "me_destruction_sim_embassy_truck_dmg_wall_beams_01_rig";
  level.scr_anim["truck_office_collapse_wall"]["wall_collapse"] = % emb_truck_010_attack_scene_roof;
  level.scr_animtree["flavor_truck"] = #animtree;
  level.scr_model["flavor_truck"] = "veh8_civ_lnd_techo_rebel";
  level.scr_anim["flavor_truck"]["flavor_truck_drive_by"] = % emb_truck_005_drive_veh01;
  level.scr_animtree["box"] = #animtree;
  level.scr_model["box"] = "un_office_storage_box_open_01";
  level.scr_anim["box"]["to_attack_idle"][0] = % emb_truck_010_attack_idle_box;
  level.scr_anim["box"]["to_attack_scene"] = % emb_truck_010_attack_scene_box;
  level.scr_animtree["box_lid"] = #animtree;
  level.scr_model["box_lid"] = "un_office_storage_box_lid_01";
  level.scr_anim["box_lid"]["to_attack_idle"][0] = % emb_truck_010_attack_idle_boxlid;
  level.scr_anim["box_lid"]["to_attack_scene"] = % emb_truck_010_attack_scene_boxlid;
  level.scr_animtree["sr_crowbar"] = #animtree;
  level.scr_model["sr_crowbar"] = "equipment_metal_crowbar_01";
  level.scr_anim["sr_crowbar"]["sr_door_buster"] = % emb_cctv_005_doorkick_crowbar;
  level.scr_animtree["sr_door"] = #animtree;
  level.scr_model["sr_door"] = "door_metal_office_single_04";
  level.scr_anim["sr_door"]["sr_scene"] = % emb_cctv_010_saferoom_scene_door;
  level.scr_animtree["sr_door_buzzer"] = #animtree;
  level.scr_model["sr_door_buzzer"] = "electrical_door_intercom_01";
  level.scr_anim["sr_door_buzzer"]["saferoom_enter"] = % emb_cctv_010_saferoom_enter_vmdoor_button;
  level.scr_animtree["cctv_mic"] = #animtree;
  level.scr_model["cctv_mic"] = "me_communication_cctv_mic_01_rig";
  level.scr_anim["cctv_mic"]["cctv_enter"] = % emb_cctv_010_saferoom_screenlook_mic;
  level.scr_model["handcuffs"] = "zip_tie_handcuffs_wm";
  level.scr_animtree["bpgc_conf_door"] = #animtree;
  level.scr_model["bpgc_conf_door"] = "door_wood_office_single_01";
  level.scr_anim["bpgc_conf_door"]["bpgc_conference"] = % emb_oc_005_conference_door;
  level.scr_animtree["bpgc_conf_chair"] = #animtree;
  level.scr_model["bpgc_conf_chair"] = "ee_furniture_chair_desk_01";
  level.scr_anim["bpgc_conf_chair"]["bpgc_conference"] = % emb_oc_005_conference_chair01;
  level.scr_animtree["safety_door"] = #animtree;
  level.scr_model["safety_door"] = "door_sliding_main_01";
  level.scr_anim["safety_door_1"]["bpg_scene_door_success"] = % emb_bpg_020_hostage_door_success_door01;
  level.scr_goaltime["safety_door_1"]["bpg_scene_door_success"] = 1.0;
  level.scr_anim["safety_door_2"]["bpg_scene_door_success"] = % emb_bpg_020_hostage_door_success_door02;
  level.scr_goaltime["safety_door_2"]["bpg_scene_door_success"] = 1.0;
  level.scr_anim["keycard"]["gar_meetup_enter"] = % emb_gar_010_meetup_enter_keycard;
  level.scr_anim["keycard"]["gar_meetup_idle"][0] = % emb_gar_010_meetup_idle_keycard;
  level.scr_anim["keycard"]["gar_meetup_exit"] = % emb_gar_010_meetup_exit_keycard;
  level.scr_animtree["garage_door"] = #animtree;
  level.scr_model["garage_door"] = "door_metal_roller_01_closed_large_01_emb";
  level.scr_anim["garage_door"]["gar_meetup_exit"] = % emb_gar_010_meetup_exit_door;
  level.scr_animtree["garage_enter_door"] = #animtree;
  level.scr_model["garage_enter_door"] = "door_metal_office_single_04";
  level.scr_anim["garage_enter_door"]["gar_meetup_enter"] = % emb_gar_010_meetup_enter_door;
  scripts\common\anim::addnotetrack_notify("garage_enter_door", "card_swipe", "card_reader_swap", "gar_meetup_enter");
  level.scr_animtree["garage_enter_door2"] = #animtree;
  level.scr_model["garage_enter_door2"] = "door_metal_office_single_04";
  level.scr_anim["garage_enter_door2"]["gar_meetup_enter"] = % emb_gar_010_meetup_enter_door2;
  level.scr_animtree["kids_gate"] = #animtree;
  level.scr_anim["kids_gate"]["alley_life_kids"] = % emb_res_006_alley_children_alleydoor;
  level.scr_animtree["residence_saferoom_door"] = #animtree;
  level.scr_model["residence_saferoom_door"] = "door_metal_security_shelter_single_sp_01";
  level.scr_anim["residence_saferoom_door"]["wolf_escapes"] = % emb_exfil_010_wolfescapes_door;
  level.scr_animtree["chair_start"] = #animtree;
  level.scr_anim["chair_start"]["office_start"] = % emb_cctv_020_office_start_chair;
  level.scr_model["chair_start"] = "ee_furniture_chair_desk_01";
  level.scr_animtree["phone_start"] = #animtree;
  level.scr_model["phone_start"] = "cnd_cellphone_01_on";
  level.scr_anim["phone_start"]["office_start"] = % emb_cctv_020_office_start_phone;
  level.scr_anim["phone_start"]["office_start_idle"][0] = % emb_cctv_020_office_start_idle_phone;
  level.scr_animtree["saferoom_door"] = #animtree;
  level.scr_model["saferoom_door"] = "door_metal_security_shelter_single_sp_01";
  level.scr_anim["saferoom_door"]["res_arrival_scene"] = % emb_res_010_arrival_scene_saferoomdoor;
  level.scr_animtree["exit_door_left"] = #animtree;
  level.scr_model["exit_door_left"] = "door_wood_ornate_01_yellow_double_l";
  level.scr_animtree["exit_door_right"] = #animtree;
  level.scr_model["exit_door_right"] = "door_wood_ornate_01_yellow_double_r";
  level.scr_animtree["ladder"] = #animtree;
  level.scr_anim["ladder"]["ladder_up_scene"] = % emb_def_055_ladder_ladder;
  level.scr_animtree["cctv_office_door"] = #animtree;
  level.scr_model["cctv_office_door"] = "door_metal_office_single_03";
  level.scr_anim["cctv_office_door"]["office"] = % emb_cctv_018_amb_kill_door;
  level.scr_anim["cctv_office_door"]["office"] = % emb_cctv_018_amb_kill_door;
  level.scr_animtree["cctv_hallway_door"] = #animtree;
  level.scr_model["cctv_hallway_door"] = "door_metal_office_double_left_04";
  level.scr_anim["cctv_hallway_door"]["hallway_kill_scene"] = % emb_cctv_027_hallway_kill_door;
  level.scr_animtree["cctv_ambo_phone"] = #animtree;
  level.scr_model["cctv_ambo_phone"] = "cnd_cellphone_01_on";
  level.scr_anim["cctv_ambo_phone"]["ambo_kill_scene"] = % emb_cctv_018_amb_kill_phone;
  level.scr_anim["cctv_ambo_phone"]["office_start"] = % emb_cctv_020_office_start_phone;
  level.scr_anim["cctv_ambo_phone"]["office_start_idle"][0] = % emb_cctv_020_office_start_idle_phone;
  level.scr_animtree["alley_life_door"] = #animtree;
  level.scr_model["alley_life_door"] = "destruction_door_124_left";
  level.scr_anim["alley_life_door"]["alley_life_intro"] = % emb_res_009_alley_life_intro_door06;
  level.scr_anim["alley_life_door"]["alley_life"] = % emb_res_009_alley_life_door06;
  level.scr_animtree["fridge_door"] = #animtree;
  level.scr_anim["fridge_door"]["fridge_takedown"] = % emb_def_067_fridge_takedown_scene_door;
  level.scr_animtree["fridge_bottom"] = #animtree;
  level.scr_anim["fridge_bottom"]["fridge_takedown"] = % emb_def_067_fridge_takedown_scene_bot_fridge;
  level.scr_animtree["fridge_top"] = #animtree;
  level.scr_anim["fridge_top"]["fridge_takedown"] = % emb_def_067_fridge_takedown_scene_top_fridge;
  level.scr_animtree["fridge_body"] = #animtree;
  level.scr_anim["fridge_body"]["fridge_takedown"] = % emb_def_067_fridge_takedown_scene_body_fridge;
  level.scr_animtree["fridge_broom"] = #animtree;
  level.scr_anim["fridge_broom"]["fridge_takedown"] = % emb_def_067_fridge_takedown_scene_broom;
  level.scr_animtree["enemy_mortar"] = #animtree;
  level.scr_anim["enemy_mortar"]["flare_enter_aq"] = % emb_wm_mortar_enter_mortar;
  level.scr_anim["enemy_mortar"]["flare_aq_idle"][0] = % emb_wm_mortar_idle_mortar;
  level.scr_anim["enemy_mortar"]["flare_launch_aq"] = % emb_wm_mortar_launch_mortar;
  level.scr_anim["enemy_mortar"]["flare_reload_aq"] = % emb_wm_mortar_reload_mortar;
  level.scr_anim["enemy_mortar"]["mortar_guy_death"] = % emb_def_075_mortarhouse_mortardeath_scene_mortar;
  level.scr_goaltime["enemy_mortar"]["mortar_guy_death"] = 0.2;
  level.scr_animtree["favela_door"] = #animtree;
  level.scr_anim["favela_door"]["faveladoor_fastopen"] = % reb_smtobj_door_r_fastopen_rdoor;
  level.scr_anim["favela_door"]["faveladoor_kick"] = % reb_smtobj_door_r_kick01_rdoor;
  level.scr_anim["favela_door"]["faveladoor_peak"] = % reb_smtobj_door_r_peak_rdoor;
  level.scr_anim["favela_door"]["faveladoor_gren"] = % reb_smtobj_door_r_grenade_rdoor;
  level.scr_animtree["beam_case"] = #animtree;
  level.scr_model["beam_case"] = "device_communication_case_satellite_phone_01_animated";
  level.scr_anim["beam_case"]["triage_scene_start"] = % emb_def_050_triage_enter_briefcase;
  level.scr_animtree["green_beam"] = #animtree;
  level.scr_anim["green_beam"]["triage_scene_start"] = % emb_def_050_triage_enter_laser;
  level.scr_anim["green_beam"]["heart_to_heart"] = % emb_def_050_triage_scene_laser;
  level.scr_animtree["halligan"] = #animtree;
  level.scr_model["halligan"] = "misc_wm_halligan_tool";
  level.scr_anim["door"]["halligan_scene"] = % emb_oc_030_basement_door;
  level.scr_anim["door"]["halligan_scene_reverse"] = % emb_oc_030_basement_close_door;
}

emb_nt_fire_magic_bullet(var_0) {
  var_1 = var_0 gettagorigin("tag_flash");
  var_2 = var_0 gettagangles("tag_flash");
  var_3 = var_1 + anglesToForward(var_2) * 1000;
  playFXOnTag(scripts\engine\utility::getfx("vfx_muz_pis_w"), var_0, "tag_flash");
  magicbullet("iw8_pi_golf21", var_1, var_3);
}

emb_nt_hide_viewmodel(var_0) {
  level notify("wolf_cam_swap");
}

#using_animtree("vehicles");

vehicles() {
  level.scr_animtree["truck_01"] = #animtree;
  level.scr_model["truck_01"] = "veh8_civ_lnd_techo_dirty_tan";
  level.scr_anim["truck_01"]["mortar_trucks_arrive"] = % emb_def_025_trucks_enter_veh01;
  level.scr_animtree["truck_02"] = #animtree;
  level.scr_model["truck_02"] = "veh8_civ_lnd_techo_dirty_tan";
  level.scr_anim["truck_02"]["mortar_trucks_arrive"] = % emb_def_025_trucks_enter_veh02;
  level.scr_animtree["truck_03"] = #animtree;
  level.scr_model["truck_03"] = "veh8_civ_lnd_techo_dirty_tan";
  level.scr_anim["truck_03"]["mortar_trucks_arrive"] = % emb_def_025_trucks_enter_veh03;
  level.scr_animtree["infil_heli"] = #animtree;
  level.scr_model["infil_heli"] = "veh8_mil_air_blima";
  level.scr_anim["infil_heli"]["infil_crash_ride"] = % emb_infil_010_crash_ride_helo;
  level.scr_anim["infil_heli"]["infil_crash_crawl"][0] = % emb_infil_010_crash_crawl_helo;
  level.scr_goaltime["infil_heli"]["infil_crash_crawl"] = 0.1;
  level.scr_anim["infil_heli"]["infil_crash_fall"] = % emb_infil_010_crash_fall_helo;
  level.scr_goaltime["infil_heli"]["infil_crash_fall"] = 1.5;
  scripts\common\anim::addnotetrack_notify("infil_heli", "hit_building", "heli_tail_hit", "infil_crash_fall");
  level.scr_animtree["wolf_truck"] = #animtree;
  level.scr_anim["wolf_truck"]["gate_overrun"] = % emb_infil_10_crash_bg_techo01;
  level.scr_animtree["office_truck"] = #animtree;
  level.scr_anim["office_truck"]["to_attack_scene"] = % emb_truck_010_attack_scene_truck;
  level.scr_animtree["truck_01"] = #animtree;
  level.scr_model["truck_01"] = "veh8_civ_lnd_techo_dirty_tan";
  level.scr_anim["truck_01"]["wolf_escapes"] = % emb_exfil_010_wolfescapes_truck;
}

kill_me_no_anim(var_0) {
  if(isDefined(var_0.magic_bullet_shield) && var_0.magic_bullet_shield)
    var_0 scripts\common\ai::stop_magic_bullet_shield();

  var_0.allowdeath = 1;
  var_0.a.nodeath = 1;
  var_0 kill();
}

drag_pistol_swap(var_0) {}

notetrack_civ_killed(var_0) {
  level notify("cctv_civ_killed");
}

embassy_infil_chopper_crash_explo_sfx(var_0) {
  var_0 playexplosionsound("embassy_infil_chopper_crash_explo_lr", "exp");
}

sfx_glass_crack_01(var_0) {
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_glass_crack_01", (-6504, -2686, 92));
  wait 4;
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_glass_spidering_01", (-6504, -2686, 92));
}

sfx_glass_crack_02(var_0) {
  wait 2;
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_glass_crack_02", (-6418, -2682, 92));
  wait 3;
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_glass_spidering_02", (-6418, -2682, 92));
}

sfx_glass_crack_03(var_0) {
  wait 3;
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_glass_crack_03", (-6331, -2682, 91));
  wait 6;
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_glass_spidering_03", (-6331, -2682, 91));
}

sfx_glass_crack_04(var_0) {
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_glass_chair_throw", (-6249, -2686, 94));
  wait 0.2;
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_glass_crack_04", (-6249, -2686, 94));
  wait 7;
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_glass_spidering_04", (-6249, -2686, 94));
}

sfx_glass_crack_05(var_0) {
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_glass_crack_05", (-6164, -2690, 92));
  wait 6;
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_glass_spidering_05", (-6164, -2690, 92));
}

sfx_glass_crack_06a(var_0) {
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_glass_crack_04", (-7110, -2375, 92));
  wait 2;
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_glass_spidering_01", (-7110, -2375, 92));
}

sfx_glass_crack_06b(var_0) {
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_glass_crack_05", (-7110, -2375, 92));
}

sfx_glass_crack_06c(var_0) {
  thread scripts\engine\utility::play_sound_in_space("scn_embassy_glass_crack_03", (-7110, -2375, 92));
}

crash_fall_remove_fov_scale_factor_override(var_0) {
  level.player lerpfovscalefactor(1, 1.2);
}

cctv_enter_add_fov_user_scale_override(var_0) {
  level.player lerpfovscalefactor(0, 1);
}

mortar_add_fov_user_scale(var_0) {
  level.player lerpfovscalefactor(0, 0.4);
}

mortar_remove_fov_user_scale(var_0) {
  level.player lerpfovscalefactor(1, 0.4);
}