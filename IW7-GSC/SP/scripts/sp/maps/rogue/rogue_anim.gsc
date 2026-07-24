/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\rogue\rogue_anim.gsc
************************************************/

main() {
  setup_interrogate();
  _id_775B();
  _id_33A8();
  script_model();
  player();
  _id_13267();
  _id_53F2();
  precachemodel("vm_hero_protagonist_base");
}

setup_interrogate() {
  _id_0E75::_id_DD27();
  _id_0E75::_id_DD28();
  _id_0E77::_id_DB53();
  _id_0E77::_id_DB54();
  _id_0E74::_id_EA4F();
}

#using_animtree("generic_human");

_id_775B() {
  level._id_EC85["MCO"]["infil_scene_a_idle"][0] = % rogue_infil_mco_idle;
  level._id_EC85["xo"]["infil_scene_a_idle"][0] = % rogue_infil_xo_idle;
  level._id_EC85["marine1"]["infil_scene_a_idle"][0] = % rogue_infil_mr1_idle;
  level._id_EC85["marine2"]["infil_scene_a_idle"][0] = % rogue_infil_mr2_idle;
  level._id_EC85["MCO"]["infil_scene_b"] = % rogue_infil_mco_scene_b;
  scripts\sp\anim::_id_17F6("MCO", "boost_rig_on", ::_id_E611, "infil_scene_b");
  level._id_EC85["xo"]["infil_scene_b"] = % rogue_infil_xo_scene_b;
  level._id_EC85["marine1"]["infil_scene_b"] = % rogue_infil_mr1_scene_b;
  scripts\sp\anim::_id_17F6("marine1", "boost_rig_on", ::_id_E611, "infil_scene_b");
  scripts\sp\anim::_id_17FC("marine1", "grab_gun", "reset_brooks_gun", "infil_scene_b");
  level._id_EC85["marine2"]["infil_scene_b"] = % rogue_infil_mr2_scene_b;
  level._id_EC85["MCO"]["infil_scene_b_idle"][0] = % rogue_infil_mco_idle_2;
  level._id_EC85["xo"]["infil_scene_b_idle"][0] = % rogue_infil_xo_idle_2;
  level._id_EC85["marine1"]["infil_scene_b_idle"][0] = % rogue_infil_mr1_idle_2;
  level._id_EC85["marine2"]["infil_scene_b_idle"][0] = % rogue_infil_mr2_idle_2;
  level._id_EC85["MCO"]["infil_scene_c"] = % rogue_infil_mco_scene_c;
  scripts\sp\anim::_id_17F6("MCO", "vo_rogue_omr_onmebeadvised", ::_id_9476, "infil_scene_c");
  level._id_EC85["xo"]["infil_scene_c"] = % rogue_infil_xo_scene_c;
  level._id_EC85["marine1"]["infil_scene_c"] = % rogue_infil_mr1_scene_c;
  level._id_EC85["marine2"]["infil_scene_c"] = % rogue_infil_mr2_scene_c;
  level._id_EC85["MCO"]["sprint"][0] = % sprint1_loop;
  level._id_EC85["MCO"]["run"][0] = % walk_forward;
  level._id_EC85["MCO"]["walk"][0] = % patrol_bored_gundown_walk1;
  level._id_EC85["MCO"]["walk"][1] = % patrol_bored_gundown_walk2;
  level._id_EC85["MCO"]["walk"][2] = % patrol_bored_gundown_walk3;
  level._id_EC85["xo"]["run"][0] = % walk_forward;
  level._id_EC85["xo"]["walk"][0] = % patrol_bored_gundown_walk1;
  level._id_EC85["xo"]["walk"][1] = % patrol_bored_gundown_walk2;
  level._id_EC85["xo"]["walk"][2] = % patrol_bored_gundown_walk3;
  level._id_EC85["xo"]["sprint"][0] = % sprint1_loop;
  level._id_EC85["marine2"]["run"][0] = % walk_forward;
  level._id_EC85["marine2"]["walk"][0] = % patrol_bored_gundown_walk1;
  level._id_EC85["marine2"]["walk"][1] = % patrol_bored_gundown_walk2;
  level._id_EC85["marine2"]["walk"][2] = % patrol_bored_gundown_walk3;
  level._id_EC85["marine2"]["sprint"][0] = % sprint1_loop;
  level._id_EC85["marine1"]["run"][0] = % walk_forward;
  level._id_EC85["marine1"]["walk"][0] = % patrol_bored_gundown_walk1;
  level._id_EC85["marine1"]["walk"][1] = % patrol_bored_gundown_walk2;
  level._id_EC85["marine1"]["walk"][2] = % patrol_bored_gundown_walk3;
  level._id_EC85["marine1"]["sprint"][0] = % sprint1_loop;
  level._id_EC85["MCO"]["hangar_vignette_scene"] = % rogue_hangar_mco_scene;
  level._id_EC85["MCO"]["hangar_vignette_ready"][0] = % rogue_hangar_mco_idle_ready;
  level._id_EC85["MCO"]["hangar_vignette_enter"] = % rogue_hangar_mco_enter;
  level._id_EC85["MCO"]["hangar_vignette_idle"][0] = % rogue_hangar_mco_idle;
  level._id_EC85["MCO"]["hangar_vignette_exit"] = % rogue_hangar_mco_exit;
  level._id_EC85["xo"]["hangar_vignette_enter"] = % rogue_hangar_xo_enter;
  level._id_EC85["xo"]["hangar_vignette_idle"][0] = % rogue_hangar_xo_idle;
  level._id_EC85["xo"]["hangar_vignette_exit"] = % rogue_hangar_xo_exit;
  level._id_EC85["xo"]["hangar_vignette_scene"] = % rogue_hangar_xo_scene;
  level._id_EC85["xo"]["hangar_vignette_ready"][0] = % rogue_hangar_xo_idle_ready;
  level._id_EC85["marine2"]["hangar_vignette_enter"] = % rogue_hangar_marine2_enter;
  scripts\sp\anim::_id_17FC("marine2", "vo_asteroid_ksh_holycow", "play_extra_hangar_vo", "hangar_vignette_enter");
  level._id_EC85["marine2"]["hangar_vignette_idle"][0] = % rogue_hangar_marine2_idle;
  level._id_EC85["marine2"]["hangar_vignette_exit"] = % rogue_hangar_marine2_exit;
  level._id_EC85["marine2"]["hangar_vignette_scene"] = % rogue_hangar_marine2_scene;
  level._id_EC85["marine2"]["hangar_vignette_ready"][0] = % rogue_hangar_marine2_idle_ready;
  level._id_EC85["marine1"]["hangar_vignette_enter"] = % rogue_hangar_marine1_enter;
  level._id_EC85["marine1"]["hangar_vignette_idle"][0] = % rogue_hangar_marine1_idle;
  level._id_EC85["marine1"]["hangar_vignette_exit"] = % rogue_hangar_marine1_exit;
  level._id_EC85["marine1"]["hangar_vignette_scene"] = % rogue_hangar_marine1_scene;
  level._id_EC85["marine1"]["hangar_vignette_ready"][0] = % rogue_hangar_marine1_idle_ready;
  level._id_EC85["MCO"]["array_2_enter"] = % rogue_solar_array_2_mco_enter;
  level._id_EC85["MCO"]["array_2_enter_idle"][0] = % rogue_solar_array_2_mco_enter_idle;
  level._id_EC85["MCO"]["array_2_scene"] = % rogue_solar_array_2_mco_scene;
  level._id_EC85["MCO"]["array_2_idle"][0] = % rogue_solar_array_2_mco_idle;
  level._id_EC85["MCO"]["array_2_exit"] = % rogue_solar_array_2_mco_exit;
  level._id_EC85["MCO"]["dorm_approach_land"] = % rogue_solar_array_2_mco_landing;
  level._id_EC85["MCO"]["fast_stairs"] = % rogue_surface_fast_stair_1;
  level._id_EC89["MCO"]["fast_stairs"] = 0.1;
  level._id_EC85["xo"]["dorm_approach_land"] = % rogue_solar_array_2_salter_landing;
  level._id_EC85["xo"]["array_2_enter"] = % rogue_solar_array_2_salter_enter;
  scripts\sp\anim::_id_17F6("xo", "vo_asteroid_slt_HeyThinkIfound", ::_id_A60B, "array_2_enter");
  level._id_EC85["xo"]["array_2_enter_idle"][0] = % rogue_solar_array_2_salter_enter_idle;
  level._id_EC85["xo"]["array_2_scene"] = % rogue_solar_array_2_salter_scene;
  scripts\sp\anim::_id_17FC("xo", "start_mco", "start_mco", "array_2_scene");
  scripts\sp\anim::_id_17FC("xo", "stop_beacon", "stop_beacon", "array_2_scene");
  level._id_EC85["xo"]["array_2_idle"][0] = % rogue_solar_array_2_salter_idle;
  level._id_EC85["xo"]["array_2_exit"] = % rogue_solar_array_2_salter_exit;
  level._id_EC85["xo"]["fast_stairs"] = % rogue_surface_fast_stair_2;
  level._id_EC89["xo"]["fast_stairs"] = 0.1;
  level._id_EC85["xo"]["lava_react"] = % hm_grnd_red_cover_stand_hide_reaction01_ar;
  level._id_EC85["MCO"]["lava_react"] = % hm_grnd_red_cover_stand_hide_reaction01_ar;
  level._id_EC85["marine1"]["lava_react"] = % hm_grnd_red_cover_stand_hide_reaction01_ar;
  level._id_EC85["marine2"]["lava_react"] = % hm_grnd_red_cover_stand_hide_reaction01_ar;
  level._id_EC85["marine2"]["dorm_approach_land"] = % rogue_solar_array_2_kashima_landing;
  level._id_EC85["marine2"]["array_2_enter"] = % rogue_solar_array_2_kashima_enter;
  level._id_EC85["marine2"]["array_2_enter_idle"][0] = % rogue_solar_array_2_kashima_enter_idle;
  level._id_EC85["marine2"]["array_2_scene"] = % rogue_solar_array_2_kashima_scene;
  level._id_EC85["marine2"]["array_2_idle"][0] = % rogue_solar_array_2_kashima_idle;
  level._id_EC85["marine2"]["array_2_exit"] = % rogue_solar_array_2_kashima_exit;
  level._id_EC85["marine2"]["fast_stairs"] = % rogue_surface_fast_stair_3;
  level._id_EC89["marine2"]["fast_stairs"] = 0.1;
  level._id_EC85["marine1"]["dorm_approach_land"] = % rogue_solar_array_2_brooks_landing;
  level._id_EC85["marine1"]["array_2_enter"] = % rogue_solar_array_2_brooks_enter;
  level._id_EC85["marine1"]["array_2_enter_idle"][0] = % rogue_solar_array_2_brooks_enter_idle;
  level._id_EC85["marine1"]["array_2_scene"] = % rogue_solar_array_2_brooks_scene;
  level._id_EC85["marine1"]["array_2_idle"][0] = % rogue_solar_array_2_brooks_idle;
  level._id_EC85["marine1"]["array_2_exit"] = % rogue_solar_array_2_brooks_exit;
  level._id_EC85["marine1"]["fast_stairs"] = % rogue_surface_fast_stair_4;
  level._id_EC89["marine1"]["fast_stairs"] = 0.1;
  level._id_EC85["MCO"]["dorm_airlock_intro"] = % rogue_dorm_airlock_mco_entry;
  level._id_EC85["xo"]["dorm_airlock_intro"] = % rogue_dorm_airlock_xo_entry;
  scripts\sp\anim::_id_17F6("xo", "vo_asteroid_slt_Airlocksusebackupcells", ::_id_D335);
  level._id_EC85["marine1"]["dorm_airlock_intro"] = % rogue_dorm_airlock_mr1_entry;
  level._id_EC85["marine2"]["dorm_airlock_intro"] = % rogue_dorm_airlock_mr2_entry;
  level._id_EC85["MCO"]["dorm_airlock_intro_idle"][0] = % rogue_dorm_airlock_mco_idle;
  level._id_EC85["xo"]["dorm_airlock_intro_idle"][0] = % rogue_dorm_airlock_xo_idle;
  level._id_EC85["marine2"]["dorm_airlock_intro_idle"][0] = % rogue_dorm_airlock_mr2_idle;
  level._id_EC85["MCO"]["dorm_airlock_exit"] = % rogue_dorm_airlock_mco_exit;
  level._id_EC85["xo"]["dorm_airlock_exit"] = % rogue_dorm_airlock_xo_exit;
  level._id_EC85["marine1"]["dorm_airlock_exit"] = % rogue_dorm_airlock_mr1_exit;
  level._id_EC85["marine2"]["dorm_airlock_exit"] = % rogue_dorm_airlock_mr2_exit;
  level._id_EC85["MCO"]["dorm_airlock_entrance_run"] = % asteroid_airlock_mco_entrance_run;
  level._id_EC85["MCO"]["dorm_airlock_entrance_nostop"] = % asteroid_airlock_mco_entrance_enter_nostop;
  level._id_EC85["MCO"]["dorm_airlock_entrance_idle"][0] = % asteroid_airlock_mco_entrance_idle;
  level._id_EC85["MCO"]["dorm_airlock_entrance_enter"] = % asteroid_airlock_mco_entrance_enter;
  level._id_EC85["MCO"]["dorm_airlock_inside_idle"][0] = % asteroid_airlock_mco_entrance_inside_idle;
  level._id_EC85["MCO"]["dorm_explore_entrance"] = % rogue_kitchen_mco_entry;
  level._id_EC85["MCO"]["dorm_explore_idle_crouch"][0] = % rogue_kitchen_mco_idle_crouch;
  level._id_EC85["MCO"]["dorm_explore"] = % rogue_kitchen_mco_scene;
  level._id_EC85["MCO"]["dorm_explore_alt"] = % rogue_kitchen_mco_scene_alt;
  level._id_EC85["MCO"]["dorm_explore_idle_stand"][0] = % rogue_kitchen_mco_idle_stand;
  level._id_EC85["MCO"]["dorm_done_idle"][0] = % rogue_dorm_mco_wait_idle;
  level._id_EC85["MCO"]["dorm_main_room_intro"] = % rogue_dorm_mco_entrance;
  level._id_EC85["MCO"]["dorm_main_room_scene"] = % rogue_dorm_mco_scene;
  level._id_EC85["MCO"]["dorm_main_exit_enter"] = % rogue_dorm_mco_wait_enter;
  level._id_EC85["xo"]["dorm_airlock_entrance_run"] = % asteroid_airlock_salter_entrance_run;
  scripts\sp\anim::_id_17F6("xo", "in_door", ::_id_4147);
  level._id_EC85["xo"]["dorm_airlock_entrance_idle"][0] = % asteroid_airlock_salter_entrance_idle;
  level._id_EC85["xo"]["dorm_explore_entrance"] = % rogue_hub_quarters_xo_entry;
  level._id_EC85["xo"]["dorm_explore_flip_idle"][0] = % rogue_hub_quarters_xo_idle_paper_flip;
  level._id_EC85["xo"]["dorm_explore_idle_trans"] = % rogue_hub_quarters_idle_trans;
  level._id_EC85["xo"]["dorm_explore_scene_a"] = % rogue_hub_quarters_scenea;
  scripts\sp\anim::_id_17F6("xo", "beer_line", ::_id_2F44);
  level._id_EC85["xo"]["dorm_explore_scene_b"] = % rogue_hub_quarters_sceneb;
  level._id_EC85["xo"]["dorm_explore_scene_c"] = % rogue_hub_quarters_scenec;
  level._id_EC85["xo"]["dorm_explore_move"] = % rogue_hub_quarters_move;
  level._id_EC85["xo"]["dorm_explore_return"] = % rogue_hub_quarters_return;
  scripts\sp\anim::_id_17F6("xo", "better_branch_vo", ::_id_2F44);
  level._id_EC85["xo"]["dorm_done_idle"][0] = % rogue_dorm_salter_wait_idle;
  level._id_EC85["xo"]["dorm_main_room_intro"] = % rogue_dorm_xo_entrance;
  level._id_EC85["xo"]["dorm_main_room_scene"] = % rogue_dorm_xo_scene;
  level._id_EC85["marine2"]["dorm_airlock_entrance_run"] = % asteroid_airlock_ally1_entrance_run;
  scripts\sp\anim::_id_17F6("marine2", "door_in", ::_id_4147);
  level._id_EC85["marine2"]["dorm_airlock_entrance_idle"][0] = % asteroid_airlock_ally1_entrance_idle;
  level._id_EC85["marine2"]["dorm_explore_entrance"] = % rogue_kitchen_mr2_entry;
  level._id_EC85["marine2"]["dorm_explore_idle"][0] = % rogue_kitchen_mr2_idle;
  level._id_EC85["marine2"]["dorm_explore"] = % rogue_kitchen_mr2_scene;
  level._id_EC85["marine2"]["dorm_explore_check"] = % rogue_kitchen_mr2_check_this;
  level._id_EC85["marine2"]["armory_enter"] = % rogue_armory_mr2_entry_scene;
  level._id_EC85["marine2"]["armory_exit"] = % rogue_armory_mr2_exit_scene;
  scripts\sp\anim::_id_17F6("marine2", "mayhem_start", ::_id_5A7A, "armory_exit");
  scripts\sp\anim::_id_17FC("marine2", "mayhem_end", "stop_kash_mayhem", "armory_exit");
  level._id_EC85["marine2"]["armory"] = % rogue_armory_mr2_pick_up_scene;
  level._id_EC85["marine2"]["armory_idle"][0] = % rogue_armory_mr2_idle;
  level._id_EC85["marine2"]["armory_idle_2"][0] = % rogue_armory_mr2_idle2;
  level._id_EC85["marine2"]["dorm_done_idle"][0] = % rogue_dorm_kash_wait_idle;
  level._id_EC85["marine2"]["dorm_main_room_intro"] = % rogue_dorm_mr2_entrance;
  level._id_EC85["marine2"]["dorm_main_room_scene"] = % rogue_dorm_mr2_scene;
  level._id_EC85["marine1"]["dorm_airlock_entrance_run"] = % asteroid_airlock_ally2_entrance_run;
  scripts\sp\anim::_id_17F6("marine2", "vo_asteroid_ksh_YoCapnGotsomething", ::_id_21C0, "armory_enter");
  scripts\sp\anim::_id_17F6("marine1", "door_in", ::_id_4147);
  scripts\sp\anim::_id_17FC("marine2", "start_mco", "start_mco_kitchen", "dorm_explore");
  level._id_EC85["marine1"]["dorm_airlock_entrance_idle"][0] = % asteroid_airlock_ally2_entrance_idle;
  level._id_EC85["marine1"]["dorm_explore"] = % asteroid_dorm_search_lounge;
  level._id_EC85["marine1"]["dorm_done_idle"][0] = % rogue_dorm_brooks_wait_idle;
  level._id_EC85["marine1"]["dorm_main_room_intro"] = % rogue_dorm_mr1_entrance;
  level._id_EC85["marine1"]["dorm_main_room_scene"] = % rogue_dorm_mr1_scene_01;
  scripts\sp\anim::_id_17F6("marine1", "vo_asteroid_brk_Lookslikeanearthquake", scripts\sp\maps\rogue\dormitory::_id_A60A);
  level._id_EC85["marine1"]["dorm_main_room_mr1_scene2"] = % rogue_dorm_mr1_scene_02;
  level._id_EC85["marine1"]["dorm_main_room_mr1_scene3"] = % rogue_dorm_mr1_scene_03;
  level._id_EC85["marine1"]["rogue_dorm_mr1_idle"][0] = % rogue_dorm_mr1_idle;
  level._id_EC85["marine2"]["rogue_poi_idle"][0] = % rogue_poi_idle;
  level._id_EC85["marine2"]["rogue_poi_idle_A"][0] = % rogue_poi_idle_a;
  level._id_EC85["marine2"]["rogue_poi_idle_B"][0] = % rogue_poi_idle_b;
  level._id_EC85["marine2"]["rogue_poi_enter_L00"] = % rogue_poi_enter_l00;
  level._id_EC85["marine2"]["rogue_poi_exit_L00"] = % rogue_poi_exit_l00;
  level._id_EC85["marine2"]["rogue_poi_enter_R90"] = % rogue_poi_enter_r90;
  level._id_EC85["marine2"]["rogue_poi_exit_R90"] = % rogue_poi_exit_r90;
  level._id_EC85["marine2"]["rogue_poi_enter_L90"] = % rogue_poi_enter_l90;
  level._id_EC85["marine2"]["rogue_poi_exit_L90"] = % rogue_poi_exit_l90;
  level._id_EC85["xo"]["rogue_poi_idle"][0] = % rogue_poi_idle;
  level._id_EC85["xo"]["rogue_poi_idle_A"][0] = % rogue_poi_idle_a_xo;
  level._id_EC85["xo"]["rogue_poi_idle_B"][0] = % rogue_poi_idle_b_xo;
  level._id_EC85["xo"]["rogue_poi_enter_L00"] = % rogue_poi_enter_l00;
  level._id_EC85["xo"]["rogue_poi_exit_L00"] = % rogue_poi_exit_l00;
  level._id_EC85["xo"]["rogue_poi_enter_R90"] = % rogue_poi_enter_r90;
  level._id_EC85["xo"]["rogue_poi_exit_R90"] = % rogue_poi_exit_r90;
  level._id_EC85["xo"]["rogue_poi_enter_L90"] = % rogue_poi_enter_l90;
  level._id_EC85["xo"]["rogue_poi_exit_L90"] = % rogue_poi_exit_l90;
  level._id_EC85["MCO"]["corpse_hall_scene_1"] = % rogue_corpse_hall_mco_scene;
  level._id_EC85["xo"]["corpse_hall_scene_1"] = % rogue_corpse_hall_salt_scene;
  scripts\sp\anim::_id_17F6("xo", "button_on", ::_id_5FAD);
  level._id_EC85["marine2"]["corpse_hall_scene_1"] = % rogue_corpse_hall_kash_scene;
  level._id_EC85["marine1"]["corpse_hall_scene_1"] = % rogue_corpse_hall_brooks_scene;
  level._id_EC85["MCO"]["corpse_hall_idle_1"][0] = % rogue_corpse_hall_mco_idle;
  level._id_EC85["marine2"]["corpse_hall_idle_1"][0] = % rogue_corpse_hall_kash_idle;
  level._id_EC85["marine1"]["corpse_hall_idle_1"][0] = % rogue_corpse_hall_brooks_idle;
  level._id_EC85["MCO"]["corpse_hall_scene_2"] = % rogue_corpse_airlock_mco_scene;
  scripts\sp\anim::_id_17F6("MCO", "vo_rogue_usf_keepittightscan", ::_id_D334);
  scripts\sp\anim::_id_17F6("MCO", "vo_rogue_usf_scanyoursectors", ::_id_50B1, "corpse_hall_scene_2");
  level._id_EC85["xo"]["corpse_hall_scene_2"] = % rogue_corpse_airlock_salt_scene;
  level._id_EC85["marine2"]["corpse_hall_scene_2"] = % rogue_corpse_airlock_kash_scene;
  level._id_EC85["marine1"]["corpse_hall_scene_2"] = % rogue_corpse_airlock_brooks_scene;
  level._id_EC85["MCO"]["corpse_hall_idle_2"][0] = % rogue_corpse_airlock_mco_idle;
  level._id_EC85["xo"]["corpse_hall_idle_2"][0] = % rogue_corpse_airlock_salt_idle;
  level._id_EC85["marine2"]["corpse_hall_idle_2"][0] = % rogue_corpse_airlock_kash_idle;
  level._id_EC85["marine1"]["corpse_hall_idle_2"][0] = % rogue_corpse_airlock_brooks_idle;
  level._id_EC85["xo"]["corpse_hall_c6_react"] = % rogue_corpse_airlock_salt_react;
  level._id_EC85["xo"]["corpse_hall_idle_1"][0] = % rogue_corpse_hall_salt_idle;
  level._id_EC85["xo"]["corpse_hall_salt_ready_idle"][0] = % rogue_corpse_airlock_salt_ready_idle;
  level._id_EC85["xo"]["creep_hall_1"] = % rogue_creephall_walk_1_xo;
  level._id_EC85["xo"]["creep_hall_1_idle"][0] = % rogue_creephall_idle_1_xo;
  level._id_EC85["xo"]["creep_hall_2"] = % rogue_creephall_walk_2_xo;
  level._id_EC85["xo"]["creep_hall_2_idle"][0] = % rogue_creephall_idle_2_xo;
  level._id_EC85["xo"]["creep_hall_3"] = % rogue_creephall_walk_3_xo;
  level._id_EC85["xo"]["creep_hall_3_idle"][0] = % rogue_creephall_idle_3_xo;
  level._id_EC85["xo"]["creep_hall_4"] = % rogue_creephall_walk_4_xo;
  level._id_EC85["xo"]["creep_hall_4_idle"][0] = % rogue_creephall_idle_4_xo;
  level._id_EC85["xo"]["creep_hall_5"] = % rogue_creephall_walk_5_xo;
  level._id_EC85["xo"]["creep_hall_5_idle"][0] = % rogue_creephall_idle_5_xo;
  level._id_EC85["xo"]["creep_hall_grab"] = % rogue_creephall_grab_xo;
  level._id_EC85["xo"]["creep_hall_grab_idle"][0] = % rogue_creephall_grab_idle_xo;
  level._id_EC85["xo"]["creep_hall_grab_escape"] = % rogue_creephall_grab_escape_xo;
  scripts\sp\anim::_id_17FC("xo", "fire", "fire");
  level._id_EC85["xo"]["creep_hall_4"] = % rogue_creephall_walk_4_xo;
  level._id_EC85["corpse"]["creep_hall_corpse_idle"][0] = % rogue_creephall_corpse_idle;
  level._id_EC85["xo"]["door_lift_idle"][0] = % rogue_creephall_xo_door_idle;
  level._id_EC87["civ_corpse"] = #animtree;
  level._id_EC85["civ_corpse"]["rogue_shipping_1_corpse02"] = % rogue_shipping_1_corpse02;
  level._id_EC85["civ_corpse"]["rogue_depot_2_corpse_3"] = % rogue_depot_2_corpse_3;
  level._id_EC85["civ_corpse"]["rogue_depot_2_corpse_2"] = % rogue_depot_2_corpse_2;
  level._id_EC88["marine1"]["rogue_brk_oorah"] = % rogue_brk_25b_350_hr_r3;
  level._id_EC88["marine1"]["rogue_brk_sunsrising"] = % rogue_brk_25b_310_hr_r3;
  level._id_EC88["marine1"]["asteroid_brk_steadypower"] = % rogue_brk_25_20_hr_r2;
  level._id_EC88["marine1"]["rogue_brk_weredark"] = % rogue_brk_25a_65_hr_r3;
  level._id_EC88["marine1"]["rogue_brk_copywellcoverhi"] = % rogue_brk_25b_70_hr_r2;
  level._id_EC88["marine1"]["rogue_brk_mechstwelveoclo"] = % rogue_brk_25b_101_hr_r3;
  level._id_EC88["marine1"]["rogue_brk_daylightdayligh"] = % rogue_brk_25b_250_hr_r3;
  level._id_EC88["marine1"]["rogue_brk_werenotwaitinar"] = % rogue_brk_25b_430_hr_r2;
  level._id_EC88["marine2"]["asteroid_ksh_thisiscrazy"] = % rogue_ksh_23_30_hr_r2;
  level._id_EC88["marine2"]["asteroid_ksh_controlroomisth"] = % rogue_ksh_25_50_hr_r3;
  level._id_EC88["marine2"]["rogue_ksh_heretheycome"] = % rogue_ksh_25b_110_hr_r3;
  level._id_EC88["marine2"]["rogue_ksh_damnitidonotwan"] = % rogue_ksh_25b_20_hr_r3;
  level._id_EC88["marine2"]["rogue_ksh_wegotshadow"] = % rogue_ksh_25b_230_hr_r3;
  level._id_EC88["marine2"]["rogue_ksh_theyreswarmin"] = % rogue_ksh_25b_270_hr_r3;
  level._id_EC88["marine2"]["rogue_ksh_theyjustkeepcom"] = % rogue_ksh_25b_330_hr_r3;
  level._id_EC88["marine2"]["rogue_ksh_oorah"] = % rogue_ksh_25b_360_hr_r3;
  level._id_EC88["marine2"]["rogue_ksh_thinkthatwasall"] = % rogue_ksh_25b_420_hr_r2;
  level._id_EC88["marine2"]["rogue_ksh_controlcentersonthe"] = % rogue_ksh_25b_451_hr_r3;
  level._id_EC88["marine2"]["asteroid_ksh_whatarethechanc"] = % asteroid_ksh_whatarethechanc_face;
  level._id_EC88["MCO"]["rogue_omr_justdontletemge"] = % rogue_omr_25b_280_hr_r3;
  level._id_EC88["MCO"]["rogue_omr_letsthintheherd"] = % rogue_omr_25b_300_hr_r3;
  level._id_EC88["MCO"]["rogue_omr_finishemoffbefo"] = % rogue_omr_25b_390_hr_r3;
  level._id_EC88["MCO"]["rogue_omr_keepusmovincapt"] = % rogue_omr_25b_450_hr_r2;
  level._id_EC88["MCO"]["rogue_omr_heresourwindowd"] = % rogue_omr_25b_410_hr_r3;
  level._id_EC88["MCO"]["rogue_usf_letsgetitopen"] = % rogue_omr_25_110_hr_r3;
  level._id_EC88["MCO"]["rogue_omr_thebloodythings"] = % rogue_omr_25b_10_hr_r3;
  level._id_EC88["MCO"]["rogue_omr_rogerthat"] = % rogue_omr_25b_40_hr_r2;
  level._id_EC88["MCO"]["rogue_omr_letsnotgetcorne"] = % rogue_omr_25b_90_hr_r2;
  level._id_EC88["MCO"]["rogue_omr_daycyclesupstay"] = % rogue_omr_25b_100_hr_r3;
  level._id_EC88["MCO"]["rogue_omr_weaponsfree"] = % rogue_omr_25b_120_hr_r3;
  level._id_EC88["MCO"]["rogue_omr_gunemwhiletheyr"] = % rogue_omr_25b_240_hr_r3;
  level._id_EC88["MCO"]["asteroid_usf_LeadthewayCaptain"] = % asteroid_usf_leadthewaycaptain_face;
  level._id_EC88["MCO"]["asteroid_usf_Letskeepmoving"] = % asteroid_usf_letskeepmoving_face;
  level._id_EC88["MCO"]["asteroid_omr_gowithhimcaptai"] = % asteroid_omr_gowithhimcaptai_face;
  level._id_EC88["MCO"]["asteroid_omr_werereadywheny"] = % asteroid_omr_werereadywheny_face;
  level._id_EC88["MCO"]["asteroid_omr_onyoucorporal"] = % asteroid_omr_onyoucorporal_face;
  level._id_EC88["MCO"]["asteroid_omr_pushforward"] = % asteroid_omr_pushforward_face;
  level._id_EC88["MCO"]["asteroid_omr_moveup"] = % asteroid_omr_moveup_face;
  level._id_EC88["MCO"]["asteroid_omr_wegettothecomma"] = % asteroid_omr_wegettothecomma_face;
  level._id_EC88["xo"]["rogue_slt_hacksdone"] = % rogue_slt_25b_370_hr_r3;
  level._id_EC88["xo"]["rogue_slt_gettingdark"] = % rogue_slt_25b_400_hr_r3;
  level._id_EC88["xo"]["rogue_slt_grabthedoorreye"] = % rogue_slt_25b_440_hr_r2;
  level._id_EC88["xo"]["asteroid_slt_allsatobeadvise"] = % rogue_slt_25_10_hr_r2;
  level._id_EC88["xo"]["rogue_slt_letskeeprollin"] = % rogue_slt_25_30_hr_r2;
  level._id_EC88["xo"]["rogue_slt_movenow"] = % rogue_slt_25a_70_hr_r3;
  level._id_EC88["xo"]["rogue_slt_signalsweakstay"] = % rogue_slt_25b_210_hr_r3;
  level._id_EC88["xo"]["rogue_slt_reyesyouretoofa"] = % rogue_slt_25b_220_hr_r3;
  level._id_EC88["xo"]["rogue_slt_gettocover"] = % rogue_slt_25b_260_hr_r3;
  level._id_EC88["xo"]["rogue_slt_nightcyclegetre"] = % rogue_slt_25b_290_hr_r3;
  level._id_EC88["xo"]["rogue_slt_wecanhackthroug"] = % rogue_slt_25b_30_hr_r2;
  level._id_EC88["xo"]["rogue_slt_hacksalmostdone"] = % rogue_slt_25b_320_hr_r3;
  level._id_EC88["xo"]["rogue_slt_allyoursreyes"] = % rogue_slt_25b_50_hr_r2;
  level._id_EC88["xo"]["rogue_slt_beadvisedcomman"] = % rogue_slt_25b_60_hr_r2;
  level._id_EC88["xo"]["rogue_slt_weresetslickhit"] = % rogue_slt_25b_80_hr_r2;
  level._id_EC88["xo"]["rogue_slt_letsgetthisdoor"] = % rogue_slt_letsgetthisdoor_face;
  level._id_EC85["MCO"]["control_room_scene"] = % rogue_ctrl_room_mco_scene;
  scripts\sp\anim::_id_17FC("MCO", "pvo_asteroid_plr_wherearethey", "timeOut_set_door", "control_room_scene");
  level._id_EC85["xo"]["control_room_scene"] = % rogue_ctrl_room_xo_scene;
  scripts\sp\anim::_id_17FC("xo", "close_door", "close_xo_airlock", "control_room_scene");
  level._id_EC85["marine2"]["control_room_scene"] = % rogue_ctrl_room_mr2_scene;
  level._id_EC85["marine1"]["control_room_scene"] = % rogue_ctrl_room_mr1_scene;
  level._id_EC85["MCO"]["tankfall_react_start"] = % hm_grnd_yel_patrol_reaction_explosion_ar_8;
  level._id_EC85["MCO"]["tankfall_react_end"] = % hm_grnd_yel_patrol_reaction_explosion_exit_ar_8;
  level._id_EC85["marine1"]["civ_scene"] = % rogue_outpost_mr1_civ_depot_1;
  level._id_EC85["marine2"]["civ_scene"] = % rogue_outpost_mr2_civ_depot_1;
  scripts\sp\anim::_id_17F6("marine2", "pvo_asteroid_plr_imspacecombatai", ::_id_D248, "civ_scene");
  level._id_EC85["civ_owens"]["civ_scene"] = % rogue_outpost_owens_civ_depot_1;
  level._id_EC85["civ_owens"]["owens_idle"][0] = % rogue_civ_generic_idle;
  level._id_EC85["civ_lee"]["civ_scene"] = % rogue_outpost_lee_civ_depot_1;
  scripts\sp\anim::_id_17F6("civ_lee", "salt_pip", scripts\sp\maps\rogue\civilians::_id_CDFC);
  level._id_EC85["xo"]["salter_civ_pip"] = % rogue_outpost_xo_civ_depot_1;
  scripts\sp\anim::_id_17FC("xo", "pip_on", "pip_on", "salter_civ_pip");
  scripts\sp\anim::_id_17FC("xo", "pip_off", "pip_off", "salter_civ_pip");
  level._id_EC85["marine1"]["civ_buddy_door_nag"] = % rogue_outpost_mr1_door_open_nag;
  level._id_EC85["MCO"]["civ_scene_a"] = % rogue_outpost_mco_civ_depot_scenea;
  level._id_EC85["MCO"]["civ_scene_b"] = % rogue_outpost_mco_civ_depot_sceneb;
  level._id_EC85["civ_lee"]["civ_lever_approach1"] = % rogue_outpost_lee_civ_depot_2_intro;
  level._id_EC85["civ_lee"]["civ_lever_idle1"][0] = % rogue_outpost_lee_civ_depot_2_idle_1;
  level._id_EC85["civ_lee"]["civ_lever_approach2"] = % rogue_outpost_lee_civ_depot_2_scene;
  scripts\sp\anim::_id_17FC("civ_lee", "civ_button_prompt", "turn_on_civ_button", "civ_lever_approach2");
  level._id_EC85["civ_lee"]["civ_lever_idle2"][0] = % rogue_outpost_lee_civ_depot_2_idle_2;
  level._id_EC85["MCO"]["civ_lever_idle"][0] = % rogue_outpost_mco_civ_depot_2_idle_1;
  level._id_EC85["MCO"]["civ_lever_nag1"] = % rogue_outpost_mco_civ_depot_2_nag_1;
  level._id_EC85["MCO"]["civ_lever_nag2"] = % rogue_outpost_mco_civ_depot_2_nag_2;
  level._id_EC85["civ_1"]["civ_scene"] = % rogue_civ_depot_civ1_scene;
  level._id_EC85["civ_2"]["civ_scene"] = % rogue_civ_depot_civ2_scene;
  level._id_EC85["civ_3"]["civ_scene"] = % rogue_civ_depot_civ3_scene;
  level._id_EC85["civ_4"]["civ_scene"] = % rogue_civ_depot_civ4_scene;
  level._id_EC85["civ_5"]["civ_scene"] = % rogue_civ_depot_civ5_scene;
  level._id_EC85["civ_6"]["civ_scene"] = % rogue_civ_depot_civ6_scene;
  level._id_EC85["civ_7"]["civ_scene"] = % rogue_civ_depot_civ7_scene;
  level._id_EC85["civ_8"]["civ_scene"] = % rogue_civ_depot_civ8_scene;
  level._id_EC85["civ_9"]["civ_scene"] = % rogue_civ_depot_civ9_scene;
  level._id_EC85["civ_10"]["civ_scene"] = % rogue_civ_depot_civ10_scene;
  level._id_EC85["civ_11"]["civ_scene"] = % rogue_civ_depot_civ11_scene;
  level._id_EC85["civ_12"]["civ_scene"] = % rogue_civ_depot_civ12_scene;
  level._id_EC85["civ_13"]["civ_scene"] = % rogue_civ_depot_civ13_scene;
  level._id_EC85["civ_14"]["civ_scene"] = % rogue_civ_depot_civ14_scene;
  level._id_EC85["civ_15"]["civ_scene"] = % rogue_civ_depot_civ15_scene;
  level._id_EC85["civ_1"]["civ_idle"][0] = % rogue_civ_depot_civ1_idle;
  level._id_EC85["civ_2"]["civ_idle"][0] = % rogue_civ_depot_civ2_idle;
  level._id_EC85["civ_3"]["civ_idle"][0] = % rogue_civ_depot_civ3_idle;
  level._id_EC85["civ_4"]["civ_idle"][0] = % rogue_civ_depot_civ4_idle;
  level._id_EC85["civ_5"]["civ_idle"][0] = % rogue_civ_depot_civ5_idle;
  level._id_EC85["civ_6"]["civ_idle"][0] = % rogue_civ_depot_civ6_idle;
  level._id_EC85["civ_7"]["civ_idle"][0] = % rogue_civ_depot_civ7_idle;
  level._id_EC85["civ_8"]["civ_idle"][0] = % rogue_civ_depot_civ8_idle;
  level._id_EC85["civ_9"]["civ_idle"][0] = % rogue_civ_depot_civ9_idle;
  level._id_EC85["civ_10"]["civ_idle"][0] = % rogue_civ_depot_civ10_idle;
  level._id_EC85["civ_11"]["civ_idle"][0] = % rogue_civ_depot_civ11_idle;
  level._id_EC85["civ_12"]["civ_idle"][0] = % rogue_civ_depot_civ12_idle;
  level._id_EC85["civ_13"]["civ_idle"][0] = % rogue_civ_depot_civ13_idle;
  level._id_EC85["civ_14"]["civ_idle"][0] = % rogue_civ_depot_civ14_idle;
  level._id_EC85["civ_15"]["civ_idle"][0] = % rogue_civ_depot_civ15_idle;
  level._id_EC85["civ_guard_1"]["civ_scene"] = % rogue_civ_depot_civ10_scene;
  level._id_EC85["civ_guard_1"]["civ_idle"][0] = % rogue_civ_depot_civ10_idle;
  level._id_EC85["civ_guard_2"]["civ_scene"] = % rogue_civ_depot_civ11_scene;
  level._id_EC85["civ_guard_2"]["civ_idle"][0] = % rogue_civ_depot_civ11_idle;
  level._id_EC88["MCO"]["rogue_usf_grabcoverwehold"] = % rogue_usf_grabcoverwehold_face;
  level._id_EC85["xo"]["finale_idle"][0] = % rogue_salter_finale_dropship_idle;
  level._id_EC85["xo"]["finale_start"] = % rogue_salter_finale_dropship_enter;
  level._id_EC85["xo"]["finale_scene"] = % rogue_finale_salter_guard;
  level._id_EC85["MCO"]["finale_scene"] = % asteroid_finale_mco_drag;
  level._id_EC85["marine1"]["finale_scene"] = % rogue_finale_brooks_help;
  level._id_EC85["civ_brooks_civ"]["finale_scene"] = % rogue_finale_civ_help_up;
  level._id_EC85["civ_burn"]["finale_scene"] = % rogue_finale_burning_man;
  level._id_EC85["civ_lee"]["finale_scene"] = % rogue_finale_civ_civcarry;
  level._id_EC85["civ_owens"]["finale_scene"] = % rogue_finale_owens_scene;
  scripts\sp\anim::_id_17F6("civ_owens", "vo_rogue_fcv1_closedcircuitcapturedthis", scripts\sp\maps\rogue\civilians::_id_F910, "civ_scene");
  scripts\sp\anim::_id_17F6("civ_lee", "shoot_lee", ::_id_6C50, "finale_scene");
  scripts\sp\anim::_id_17F6("MCO", "vo_asteroid_omr_effort1", ::_id_6C49, "finale_scene");
  scripts\sp\anim::_id_17F6("MCO", "vo_asteroid_omr_stayundermecome", ::_id_6C48, "finale_scene");
  scripts\sp\anim::_id_17F6("MCO", "start_mayhem", ::_id_6C4A, "finale_scene");
  scripts\sp\anim::_id_17FA("xo", "vo_asteroid_slt_wegottagonow", "finale_takeoff_begin", "finale_scene");
  level._id_EC85["civ_dead_0"]["finale_scene"] = % rogue_finale_civ_shot_01;
  level._id_EC85["civ_dead_1"]["finale_corpse"] = % rogue_finale_civ_corpse_01;
  level._id_EC85["civ_dead_2"]["finale_corpse"] = % rogue_finale_civ_corpse_02;
  level._id_EC85["civ_dead_3"]["finale_corpse"] = % rogue_finale_civ_corpse_03;
  level._id_EC85["civ_dead_4"]["finale_corpse"] = % rogue_finale_civ_corpse_04;
  level._id_EC85["marine2"]["finale_corpse"] = % rogue_finale_kashima_corpse;
  level._id_EC87["solar_corpse"] = #animtree;
  level._id_EC8C["solar_corpse"] = "body_civ_miner_burnt_01";
  level._id_EC85["solar_corpse"]["array_2_scene"] = % rogue_solar_array_2_corpse;
  level._id_EC87["dorm_exit_corpse_1"] = #animtree;
  level._id_EC85["dorm_exit_corpse_1"]["dorm_exit_corpse"] = % asteroid_dormitory_1_corpse_01;
  level._id_EC87["dorm_exit_corpse_2"] = #animtree;
  level._id_EC85["dorm_exit_corpse_2"]["dorm_exit_corpse"] = % asteroid_dormitory_1_corpse_02;
  level._id_EC87["dorm_exit_corpse_3"] = #animtree;
  level._id_EC85["dorm_exit_corpse_3"]["corpse_hall_scene_1"] = % rogue_corpse_airlock_dragged;
  level._id_EC87["dorm_kitchen_corpse"] = #animtree;
  level._id_EC85["dorm_kitchen_corpse"]["dorm_corpse"] = % asteroid_kitchen_1_dead_01;
  level._id_EC87["miner_corpse"] = #animtree;
  level._id_EC8C["miner_corpse"] = "body_civ_miner_burnt_02";
  level._id_EC85["miner_corpse"]["depot_corpse_0"] = % rogue_depot_1_corpse_01;
  level._id_EC85["miner_corpse"]["depot_corpse_1"] = % rogue_depot_1_corpse_02;
  level._id_EC85["miner_corpse"]["depot_corpse_2"] = % rogue_depot_1_corpse_03;
  level._id_EC85["miner_corpse"]["depot_corpse_3"] = % rogue_depot_1_corpse_04;
  level._id_EC85["miner_corpse"]["depot_corpse_4"] = % rogue_depot_1_corpse_05;
  level._id_EC85["miner_corpse"]["depot_corpse_5"] = % rogue_depot_1_corpse_06;
  level._id_EC85["miner_corpse"]["hall_corpse_0"] = % rogue_robot_hall_corpse_01;
  level._id_EC85["miner_corpse"]["hall_corpse_1"] = % rogue_robot_hall_corpse_02;
  level._id_EC85["miner_corpse"]["hall_corpse_2"] = % rogue_robot_hall_corpse_03;
  level._id_EC85["miner_corpse"]["rogue_robot_hall_corpse_02"] = % rogue_robot_hall_corpse_02;
  level._id_EC85["miner_corpse"]["rogue_depot_1_corpse_05"] = % rogue_depot_1_corpse_05;
}

#using_animtree("c6");

_id_33A8() {
  level._id_EC85["security_bot"]["pwr_up"] = % c6_asteroid_poweroff_idle;
  level._id_EC85["security_bot"]["pwr_off"][0] = % c6_asteroid_poweroff_idle_looping;
  level._id_EC85["security_bot"]["crawl1"] = % rogue_shipping_c6_crawl_to_run_1;
  level._id_EC85["security_bot"]["crawl2"] = % rogue_shipping_c6_crawl_to_run_2;
  level._id_EC85["security_bot"]["crawl3"] = % rogue_shipping_c6_crawl_to_run_3;
  level._id_EC85["security_bot"]["crawl4"] = % rogue_shipping_c6_crawl_to_run_4;
  level._id_EC87["robot_corpse"] = #animtree;
  level._id_EC8C["robot_corpse"] = "robot_c6";
  level._id_EC85["robot_corpse"]["corpse_hall_scene_2"] = % rogue_corpse_airlock_c6_knifepull;
  level._id_EC85["creep_bot"]["creep_hall_idle"][0] = % rogue_creephall_idle_c6;
  level._id_EC85["creep_bot"]["creep_hall_grab"] = % rogue_creephall_grab_c6;
  level._id_EC85["creep_bot"]["creep_hall_grab_idle"][0] = % rogue_creephall_grab_idle_c6;
  level._id_EC85["creep_bot"]["creep_hall_grab_escape"] = % rogue_creephall_grab_death_c6;
  level._id_EC85["creep_bot"]["creep_hall_grab_release"] = % rogue_creephall_grab_death_c6;
  level._id_EC85["creep_bot"]["creep_hall_grab_dead"][0] = % rogue_creephall_grab_death_idle_c6;
  level._id_EC85["glass_robot"]["bang_on_glass_1"][0] = % rogue_shipping_glass_c6_idle1;
  level._id_EC85["glass_robot"]["bang_on_glass_2"][0] = % rogue_shipping_glass_c6_idle2;
  level._id_EC85["glass_robot"]["bang_on_glass_3"][0] = % rogue_shipping_glass_c6_idle3;
  level._id_EC85["glass_robot"]["bang_on_glass_4"][0] = % rogue_shipping_glass_c6_idle4;
  level._id_EC85["glass_robot"]["bang_on_glass_grab"] = % rogue_shipping_break_glass_c6_enter;
  level._id_EC85["glass_robot"]["bang_on_glass_post_grab_fast"][0] = % rogue_shipping_break_glass_c6_power_on_idle;
  level._id_EC85["glass_robot"]["bang_on_glass_post_grab_slow"][0] = % rogue_shipping_break_glass_c6_power_off_idle;
  level._id_EC85["grab_robot"]["hang_death1"] = % rogue_creephall_hanging_c6_death_1;
  level._id_EC85["grab_robot"]["hang_death2"] = % rogue_creephall_hanging_c6_death_2;
  level._id_EC85["grab_robot"]["hang_death3"] = % rogue_creephall_hanging_c6_death_3;
  level._id_EC85["grab_robot"]["hang_death4"] = % rogue_creephall_hanging_c6_death_4;
  level._id_EC85["grab_robot"]["hang_death5"] = % rogue_creephall_hanging_c6_death_5;
  level._id_EC85["grab_robot"]["hang_grab1"] = % rogue_creephall_hanging_c6_grab_1;
  level._id_EC85["grab_robot"]["hang_grab2"] = % rogue_creephall_hanging_c6_grab_2;
  level._id_EC85["grab_robot"]["hang_grab3"] = % rogue_creephall_hanging_c6_grab_3;
  level._id_EC85["grab_robot"]["hang_grab4"] = % rogue_creephall_hanging_c6_grab_4;
  level._id_EC85["grab_robot"]["hang_grab5"] = % rogue_creephall_hanging_c6_grab_5;
  level._id_EC85["grab_robot"]["hang_grab6"] = % rogue_creephall_hanging_c6_grab_6;
  level._id_EC85["grab_robot"]["hang_grab7"] = % rogue_creephall_hanging_c6_grab_7;
  level._id_EC85["grab_robot"]["hang_grab8"] = % rogue_creephall_hanging_c6_grab_8;
  level._id_EC85["grab_robot"]["hang_grab9"] = % rogue_creephall_hanging_c6_grab_9;
  level._id_EC85["grab_robot"]["hang_power_off"] = % rogue_creephall_hanging_c6_power_off;
  level._id_EC85["grab_robot"]["hang_power_off_idle"][0] = % rogue_creephall_hanging_c6_power_off_idle;
  level._id_EC85["grab_robot"]["hang_power_on"] = % rogue_creephall_hanging_c6_power_on;
  level._id_EC85["grab_robot"]["hang_power_on_idle"][0] = % rogue_creephall_hanging_c6_power_on_idle;
  level._id_EC85["roof_robot"]["roof_crawl1"] = % rogue_shipping_ceiling_c6_1;
  level._id_EC85["roof_robot"]["roof_crawl2"] = % rogue_shipping_ceiling_c6_2;
  level._id_EC85["roof_robot"]["roof_crawl3"] = % rogue_shipping_ceiling_c6_3;
  level._id_EC85["roof_robot"]["roof_crawl4"] = % rogue_shipping_ceiling_c6_4;
  level._id_EC85["generic"]["rail_hop_1"] = % ph_hill400_c6_over_railing_landing_01;
  level._id_EC85["generic"]["rail_hop_2"] = % ph_hill400_c6_over_railing_landing_03;
  level._id_EC85["security_bot"]["shipping_sleep1"] = % c6_grnd_red_scary_poweroff_ar;
  level._id_EC85["security_bot"]["shipping_sleep2"] = % c6_grnd_red_scary_poweroff_02_ar;
  level._id_EC87["fake_worker"] = #animtree;
  level._id_EC85["fake_worker"]["finale_asleep1"] = % c6_grnd_red_scary_poweroff_ar;
  level._id_EC85["fake_worker"]["finale_asleep2"] = % c6_grnd_red_scary_poweroff_02_ar;
  level._id_EC87["wall_bot"] = #animtree;
  level._id_EC85["wall_bot"]["power_off_idle"][0] = % rogue_creephall_hanging_c6_power_off_idle;
  level._id_EC85["wall_bot"]["power_on_idle"][0] = % rogue_creephall_hanging_c6_power_on_idle;
  level._id_EC85["wall_bot"]["death_0"] = % rogue_creephall_hanging_c6_death_1;
  level._id_EC85["wall_bot"]["death_1"] = % rogue_creephall_hanging_c6_death_2;
  level._id_EC85["wall_bot"]["death_2"] = % rogue_creephall_hanging_c6_death_3;
  level._id_EC85["wall_bot"]["death_3"] = % rogue_creephall_hanging_c6_death_4;
  level._id_EC85["wall_bot"]["death_4"] = % rogue_creephall_hanging_c6_death_5;
  level._id_EC85["wall_bot"]["death_loop"][0] = % rogue_creephall_hanging_c6_death_1;
  level._id_EC85["wall_bot"]["death_loop"][1] = % rogue_creephall_hanging_c6_death_2;
  level._id_EC85["wall_bot"]["death_loop"][2] = % rogue_creephall_hanging_c6_death_3;
  level._id_EC85["wall_bot"]["death_loop"][3] = % rogue_creephall_hanging_c6_death_4;
  level._id_EC85["wall_bot"]["death_loop"][4] = % rogue_creephall_hanging_c6_death_5;
  level._id_EC85["wall_bot"]["power_on"] = % rogue_creephall_hanging_c6_power_on;
  level._id_EC85["wall_bot"]["power_off"] = % rogue_creephall_hanging_c6_power_off;
  level._id_EC85["worker_bot"]["crawl1"] = % rogue_shipping_c6_crawl_to_run_1;
  level._id_EC85["worker_bot"]["crawl2"] = % rogue_shipping_c6_crawl_to_run_2;
  level._id_EC85["worker_bot"]["crawl3"] = % rogue_shipping_c6_crawl_to_run_3;
  level._id_EC85["worker_bot"]["crawl4"] = % rogue_shipping_c6_crawl_to_run_4;
  level._id_EC85["worker_bot"]["emerge1"] = % zom_dismem_crawl_climbup_40;
  level._id_EC85["worker_bot"]["climb1"] = % rogue_creepbot_rail_b_up_short;
  level._id_EC85["worker_bot"]["chasm1"] = % rogue_shipping_single_elev_climb_1;
  level._id_EC85["worker_bot"]["catwalk1"] = % rogue_creepbot_rail_b_up_short;
  level._id_EC85["worker_bot"]["c6_reveal_0"] = % rogue_creephall_c6_reveal_1;
  level._id_EC85["worker_bot"]["c6_reveal_1"] = % rogue_creephall_c6_reveal_2;
  level._id_EC85["worker_bot"]["c6_reveal_2"] = % rogue_creephall_c6_reveal_3;
  level._id_EC85["worker_bot"]["c6_reveal_3"] = % rogue_creephall_c6_reveal_4;
  level._id_EC85["worker_bot"]["c6_reveal_4"] = % rogue_creephall_c6_reveal_5;
  level._id_EC85["worker_bot"]["c6_reveal_5"] = % rogue_creephall_c6_reveal_6;
}

#using_animtree("script_model");

script_model() {
  level._id_EC87["brooks_gun"] = #animtree;
  level._id_EC85["brooks_gun"]["brooks_gun_infil"][0] = % rogue_infil_mr1_scene_b_gun_idle;
  level._id_EC87["sun_org"] = #animtree;
  level._id_EC85["sun_org"]["sun_rot"] = % rogue_sun_rot_wobbly;
  level._id_EC87["hangar_door"] = #animtree;
  level._id_EC85["hangar_door"]["hangar_vignette_exit"] = % rogue_hangar_door_open;
  level._id_EC87["airlock_door"] = #animtree;
  level._id_EC85["airlock_door"]["dorm_airlock_entrance_player"] = % asteroid_airlock_door_entrance_close;
  level._id_EC85["airlock_door"]["corpse_hall_scene_1"] = % rogue_airlock_door_open_corpse;
  level._id_EC85["airlock_door"]["airlock_open_inside"] = % airlock_open_door;
  scripts\sp\anim::_id_17F6("airlock_door", "door_open", ::_id_F364);
  level._id_EC85["airlock_door"]["airlock_open_outside"] = % airlock_open_pull_door;
  scripts\sp\anim::_id_17F6("airlock_door", "door_open", ::_id_F364);
  level._id_EC85["airlock_door"]["airlock_open"] = % rogue_airlock_door_close;
  level._id_EC85["airlock_door"]["airlock_close"] = % rogue_airlock_door_open;
  level._id_EC85["airlock_door"]["dorm_long_door"] = % airlock_open_door_wave;
  level._id_EC85["airlock_door"]["corpse_hall_scene_2"] = % rogue_airlock_door_close_corpse;
  scripts\sp\anim::_id_17F6("airlock_door", "door_open", ::_id_F364);
  level._id_EC8C["airlock_door"] = "door_airlock_01_door";
  level._id_EC87["armory_box"] = #animtree;
  level._id_EC85["armory_box"]["armory_enter"] = % rogue_armory_ammo_box;
  level._id_EC8C["armory_box"] = "weapon_steeldragon_sp_wm";
  level._id_EC87["asteroid_01"] = #animtree;
  level._id_EC85["asteroid_01"]["flyin_rocks"] = % rogue_infil_rock_1_flyin;
  level._id_EC8C["asteroid_01"] = "rock_large_rogue_asteroid_sm";
  level._id_EC87["asteroid_02"] = #animtree;
  level._id_EC85["asteroid_02"]["flyin_rocks"] = % rogue_infil_rock_2_flyin;
  level._id_EC8C["asteroid_02"] = "rock_large_rogue_asteroid_sm";
  level._id_EC87["asteroid_03"] = #animtree;
  level._id_EC85["asteroid_03"]["flyin_rocks"] = % rogue_infil_rock_3_flyin;
  level._id_EC8C["asteroid_03"] = "rock_large_rogue_asteroid_sm";
  level._id_EC87["asteroid_04"] = #animtree;
  level._id_EC85["asteroid_04"]["flyin_rocks"] = % rogue_infil_rock_4_flyin;
  level._id_EC8C["asteroid_04"] = "rock_large_rogue_asteroid_sm";
  level._id_EC87["asteroid_05"] = #animtree;
  level._id_EC85["asteroid_05"]["flyin_rocks"] = % rogue_infil_rock_5_flyin;
  level._id_EC8C["asteroid_05"] = "rock_large_rogue_asteroid_sm";
  level._id_EC87["robot_knife"] = #animtree;
  level._id_EC85["robot_knife"]["corpse_hall_scene_2_keepknife"] = % rogue_corpse_airlock_knife_knifepull_keep;
  level._id_EC85["robot_knife"]["corpse_hall_scene_2_throwknife"] = % rogue_corpse_airlock_knife_knifepull;
  level._id_EC8C["robot_knife"] = "tactical_knife_iw7";
  level._id_EC87["creep_hall_box_0"] = #animtree;
  level._id_EC85["creep_hall_box_0"]["creep_hall_grab"] = % rogue_creephall_box_1;
  level._id_EC87["creep_hall_box_1"] = #animtree;
  level._id_EC85["creep_hall_box_1"]["creep_hall_grab"] = % rogue_creephall_box_2;
  level._id_EC87["creep_hall_box_2"] = #animtree;
  level._id_EC85["creep_hall_box_2"]["creep_hall_grab"] = % rogue_creephall_box_3;
  level._id_EC87["drill"] = #animtree;
  level._id_EC85["drill"]["drill_down"] = % machinery_industrial_mining_drill_asteroid_down;
  level._id_EC85["drill"]["drill_up"] = % machinery_industrial_mining_drill_asteroid_up;
  level._id_EC85["drill"]["drill_down_idle"][0] = % machinery_industrial_mining_drill_asteroid_down_idle;
  level._id_EC85["drill"]["drill_up_idle"][0] = % machinery_industrial_mining_drill_asteroid_up_idle;
  level._id_EC8C["drill"] = "machinery_industrial_mining_drill_asteroid";
  level._id_EC85["airlock_door"]["exit_defend"] = % rogue_shipping_proximity_door_open;
  level._id_EC87["civ_door_in"] = #animtree;
  level._id_EC85["civ_door_in"]["civ_scene"] = % rogue_civ_depot_door_open;
  level._id_EC87["civ_tablet"] = #animtree;
  level._id_EC85["civ_tablet"]["civ_scene"] = % rogue_civ_depot_tablet_scene;
  level._id_EC87["civ_lever"] = #animtree;
  level._id_EC85["civ_lever"]["civ_lever"] = % rogue_outpost_plr_civ_depot_2_interact_panel;
  level._id_EC85["airlock_door"]["control_room_scene"] = % rogue_ctrl_room_xo_scene_door;
  level._id_EC87["array_door"] = #animtree;
  level._id_EC85["array_door"]["array_2_enter"] = % rogue_solar_array_2_door;
  level._id_EC8C["array_door"] = "door_metal_vertical_bifold_01";
  level._id_EC85["dropship_seat_right_01"]["seat_open"] = % titan_dropship_seat07_exit;
  level._id_EC85["dropship_seat_right_01"]["infil_scene_c1"] = % rogue_infil_seat_enter_seat;
  level._id_EC85["dropship_seat_right_01"]["infil_scene_c2"] = % rogue_infil_seat_bink;
  level._id_EC85["dropship_seat_right_01"]["infil_scene_c3"] = % rogue_infil_seat_exit_seat;
  level._id_EC85["dropship_seat_right_02"]["infil_scene_b"] = % rogue_infil_seat_mco_scene_b;
  level._id_EC85["dropship_seat_left_01"]["infil_scene_b"] = % rogue_infil_seat_mr1_scene_b;
  level._id_EC87["beer"] = #animtree;
  level._id_EC85["beer"]["idle1"][0] = % rogue_kitchen_beer_idle_1;
  level._id_EC85["beer"]["idle2"][0] = % rogue_kitchen_beer_idle_2;
  level._id_EC85["beer"]["scene"] = % rogue_kitchen_beer_scene;
  level._id_EC8C["beer"] = "europa_blue_aluminum_beer_bottles_02";
  level._id_EC87["creep_blocker"] = #animtree;
  level._id_EC85["creep_blocker"]["creep_hall_1"] = % rogue_creephall_walk_1_collision;
  level._id_EC85["creep_blocker"]["creep_hall_1_idle"][0] = % rogue_creephall_idle_1_collision;
  level._id_EC85["creep_blocker"]["creep_hall_2"] = % rogue_creephall_walk_2_collision;
  level._id_EC85["creep_blocker"]["creep_hall_2_idle"][0] = % rogue_creephall_idle_2_collision;
  level._id_EC85["creep_blocker"]["creep_hall_3"] = % rogue_creephall_walk_3_collision;
  level._id_EC85["creep_blocker"]["creep_hall_3_idle"][0] = % rogue_creephall_idle_3_collision;
  level._id_EC85["creep_blocker"]["creep_hall_grab"] = % rogue_creephall_grab_collision;
  level._id_EC85["creep_blocker"]["creep_hall_grab_idle"][0] = % rogue_creephall_grab_idle_collision;
  level._id_EC85["creep_blocker"]["creep_hall_grab_escape"] = % rogue_creephall_grab_escape_collision;
  level._id_EC85["creep_blocker"]["creep_hall_grab_release"] = % rogue_creephall_grab_plr_release_collision;
  level._id_EC85["creep_blocker"]["creep_hall_4"] = % rogue_creephall_walk_4_collision;
  level._id_EC8C["creep_blocker"] = "tag_origin";
  level._id_EC85["door"]["ship_hall_idle"] = % rogue_shipping_buddy_door2_pull_door;
  level._id_EC87["restraint"] = #animtree;
  level._id_EC85["restraint"]["creep_hall_idle"][0] = % rogue_creephall_idle_c6_restraint;
  level._id_EC85["restraint"]["creep_hall_grab"] = % rogue_creephall_grab_c6_restraint;
  level._id_EC85["restraint"]["creep_hall_grab_idle"][0] = % rogue_creephall_grab_idle_c6_restraint;
  level._id_EC85["restraint"]["creep_hall_grab_escape"] = % rogue_creephall_grab_death_c6_restraint;
  level._id_EC85["restraint"]["creep_hall_grab_dead"][0] = % rogue_creephall_grab_death_idle_c6_restraint;
  level._id_EC87["tank"] = #animtree;
  level._id_EC85["tank"]["pit_collapse"] = % rogue_depot_pit_tower;
}

#using_animtree("player");

player() {
  level._id_EC87["player_rig"] = #animtree;
  level._id_EC8C["player_rig"] = "viewmodel_base_viewhands_iw7";
  level._id_EC85["player_rig"]["infil_scene_b"] = % rogue_infil_plr_screen_exit;
  level._id_EC85["player_rig"]["infil_scene_c1"] = % rogue_infil_plr_enter_seat;
  level._id_EC85["player_rig"]["infil_scene_c2"] = % rogue_infil_plr_bink;
  level._id_EC85["player_rig"]["infil_scene_c3"] = % rogue_infil_plr_exit_seat;
  scripts\sp\anim::_id_17FC("player_rig", "grab_helmet", "grab_helmet", "infil_scene_c2");
  level._id_EC85["player_rig"]["dorm_airlock_entrance_player"] = % asteroid_airlock_player_entrance;
  scripts\sp\anim::_id_17F6("player_rig", "start_door", ::_id_10172);
  scripts\sp\anim::_id_17FC("player_rig", "start_ally_anims", "start_ally_anims", "dorm_airlock_entrance_player");
  level._id_EC85["player_rig"]["armory_locker"] = % rogue_dorm_armory_player_locker;
  level._id_EC85["player_rig"]["dorm_long_door"] = % airlock_open_player_wave;
  level._id_EC85["player_rig"]["armory_exit"] = % rogue_armory_plr_scene;
  level._id_EC85["player_rig"]["corpse_hall_scene_1"] = % rogue_airlock_door_plr_open_corpse;
  level._id_EC85["player_rig"]["corpse_hall_scene_2_keepknife"] = % rogue_corpse_airlock_plyr_knifepull_keep;
  level._id_EC85["player_rig"]["corpse_hall_scene_2_throwknife"] = % rogue_corpse_airlock_plyr_knifepull;
  scripts\sp\anim::_id_17FC("player_rig", "knife_pull", "play_knife_sparks");
  scripts\sp\anim::_id_17F6("player_rig", "Release_player", ::_id_5A73);
  level._id_EC85["player_rig"]["exit_defend"] = % rogue_shipping_proximity_door_plr_open;
  scripts\sp\anim::_id_17FC("player_rig", "allies_proceed", "allies_proceed");
  level._id_EC85["player_rig"]["civ_scene"] = % rogue_civ_depot_plyr_enter;
  level._id_EC85["player_rig"]["civ_button"] = % rogue_civ_depot_plyr_button_press;
  level._id_EC85["player_rig"]["civ_lever"] = % rogue_outpost_plr_civ_depot_2_interact;
  level._id_EC85["player_rig"]["finale_scene"] = % asteroid_finale_player_drag;
  scripts\sp\anim::_id_17FA("player_rig", "on_ground", "flag_fnl_player_fall", "finale_scene");
  scripts\sp\anim::_id_17FC("player_rig", "spawn_kashima_corpse", "spawn_kash_corpse", "finale_scene");
  scripts\sp\anim::_id_17FA("player_rig", "finale_explosion", "final_explosion", "finale_scene");
  scripts\sp\anim::_id_17F6("player_rig", "vo_rogue_plr_nostopthatsan", ::_id_6C47, "finale_scene");
  level._id_EC85["player_rig"]["melee_bot"] = % vm_gesture_point_5_ar57;
  level._id_EC85["player_rig"]["airlock_open_inside"] = % airlock_open_player;
  level._id_EC85["player_rig"]["airlock_open_outside"] = % airlock_open_pull_player;
  level._id_EC85["player_rig"]["player_landing"] = % rogue_player_land;
}

#using_animtree("vehicles");

_id_13267() {
  level._id_EC87["dropship"] = #animtree;
  level._id_EC85["dropship"]["infil_scene_b"] = % rogue_infil_dropship_screen_exit;
  level._id_EC85["dropship"]["infil_scene_c3"] = % rogue_infil_door_scene_c;
  level._id_EC85["dropship"]["finale_scene"] = % rogue_finale_dropship_exit;
  scripts\sp\anim::_id_17FA("dropship", "second_explosion", "flag_fnl_second_explo", "finale_scene");
  scripts\sp\anim::_id_17F6("dropship", "lifting_off", scripts\sp\maps\rogue\finale::_id_6C3F, "finale_scene");
}

#using_animtree("generic_human");

_id_4A47() {
  var_0 = [];
  var_0["xo"]["intro"] = % rogue_creephall_xo_intro_to_door;
  var_0["xo"]["idle"] = % rogue_creephall_xo_door_idle;
  var_0["xo"]["pull"] = % rogue_creephall_xo_door_pull;
  var_0["xo"]["outro"] = % rogue_creephall_xo_door_enter;
  var_0["xo"]["nag"] = % rogue_creephall_xo_door_open_nag;
  var_0["marine1"]["outro"] = % rogue_creephall_mr1_door_enter;
  var_0["MCO"]["outro"] = % rogue_creephall_mco_door_enter;
  var_0["marine2"]["outro"] = % rogue_creephall_mr2_door_enter;
  return var_0;
}

#using_animtree("player");

_id_4A49() {
  level._id_EC8C["door_player_rig"] = "vm_hero_protagonist_base";
  var_0 = [];
  var_0["door_player_rig"]["intro"] = % rogue_creephall_plr_intro_to_door;
  var_0["door_player_rig"]["idle"] = % rogue_creephall_plr_door_idle;
  var_0["door_player_rig"]["pull"] = % rogue_creephall_plr_door_pull;
  var_0["door_player_rig"]["outro"] = % rogue_creephall_plr_door_enter;
  return var_0;
}

#using_animtree("script_model");

_id_4A48() {
  var_0 = [];
  var_0["door"]["idle"] = % rogue_creephall_door_idle;
  var_0["door"]["pull"] = % rogue_creephall_door_pull;
  var_0["door"]["outro"] = % rogue_creephall_door_open;
  return var_0;
}

#using_animtree("generic_human");

_id_FD41() {
  var_0 = [];
  var_0["marine2"]["intro"] = % rogue_shipping_buddy_door2_enter_mr2;
  var_0["marine2"]["idle"] = % rogue_shipping_buddy_door2_idle_mr2;
  var_0["marine2"]["pull"] = % rogue_shipping_buddy_door2_pull_mr2;
  var_0["marine2"]["outro"] = % rogue_shipping_buddy_door2_exit_mr2;
  var_0["xo"]["outro"] = % rogue_shipping_buddy_door2_exit_xo;
  var_0["MCO"]["outro"] = % rogue_shipping_buddy_door2_exit_mco;
  var_0["marine1"]["outro"] = % rogue_shipping_buddy_door2_exit_mr1;
  return var_0;
}

#using_animtree("player");

_id_FD43() {
  level._id_EC8C["door_player_rig"] = "vm_hero_protagonist_base";
  var_0 = [];
  var_0["door_player_rig"]["intro"] = % rogue_shipping_buddy_door2_enter_plr;
  var_0["door_player_rig"]["idle"] = % rogue_shipping_buddy_door2_idle_plr;
  var_0["door_player_rig"]["pull"] = % rogue_shipping_buddy_door2_pull_plr;
  var_0["door_player_rig"]["outro"] = % rogue_shipping_buddy_door2_exit_plr;
  return var_0;
}

#using_animtree("script_model");

_id_FD42() {
  var_0 = [];
  var_0["door"]["idle"] = % rogue_shipping_buddy_door2_idle_door;
  var_0["door"]["pull"] = % rogue_shipping_buddy_door2_pull_door;
  var_0["door"]["outro"] = % rogue_shipping_buddy_door2_exit_door;
  return var_0;
}

_id_6C50(var_0) {
  var_1 = [];
  var_2 = undefined;

  foreach(var_4 in getaiarray("axis")) {
    if(var_4.classname == "actor_enemy_c6_worker") {
      continue;
    }
    if(_id_0B1D::_id_385C(var_4 gettagorigin("tag_flash"), var_0)) {
      var_1[var_1.size] = var_4;
      var_4 thread scripts\sp\utility::_id_B14F();
    }

    if(var_1.size == 2) {
      break;
    }
  }

  if(!var_1.size) {
    return;
  }
  foreach(var_2 in var_1) {
    var_7 = randomintrange(2, 4);

    for(var_8 = 0; var_8 < var_7; var_8++) {
      var_9 = var_0 gettagorigin("j_spine4") + scripts\engine\utility::randomvectorrange(-20, 20);
      var_2 shoot(1, var_9);
      wait(randomfloatrange(0.05, 0.15));
    }
  }

  playFX(level._effect["vfx_electric_spark_burst_b"], var_2.origin + (0, 0, 50));
  var_2 thread scripts\sp\utility::_id_1101B();
  var_2 notify("stop_going_to_node");
  var_2.goalradius = 32;
  var_2 setgoalpos(level.player.origin);
  wait 4;

  if(isalive(var_2)) {
    playFX(level._effect["vfx_electric_spark_burst_b"], var_2.origin + (0, 0, 50));
    var_2 scripts\sp\utility::_id_54C6();
  }
}

_id_6C49(var_0) {
  var_1 = (-10, -75, 0);
  playworldsound("scn_rogue_finale_big_explo", var_0.origin);
  level.player scripts\engine\utility::delaycall(0.6, ::playsound, "scn_rogue_finale_right_explo");
  thread scripts\engine\utility::exploder("knockomar");
  earthquake(1, 0.5, level.player.origin, 100);
  scripts\engine\utility::flag_set("omar_down");
  var_2 = scripts\engine\utility::get_array_of_closest(level._id_B4F9.origin, getaiarray("axis"), undefined, 2, 350, 10);

  if(var_2.size)
    scripts\engine\utility::array_thread(var_2, scripts\sp\utility::_id_54C6);
}

_id_6C48(var_0) {
  wait 2;
  var_0 scripts\sp\maps\rogue\rogue_util::_id_3290();
  scripts\engine\utility::flag_set("dropship_departs");
  scripts\engine\utility::exploder("omarsun");
}

#using_animtree("generic_human");

_id_3FC3() {
  var_0 = [];
  var_0["marine1"]["intro"] = % rogue_outpost_mr1_intro_to_door;
  var_0["marine1"]["idle"] = % rogue_outpost_mr1_door_idle;
  var_0["marine1"]["pull"] = % rogue_outpost_mr1_door_pull;
  var_0["marine1"]["outro"] = % rogue_outpost_mr1_civ_depot_1;
  var_0["marine1"]["nag"] = % rogue_outpost_mr1_door_open_nag;
  return var_0;
}

#using_animtree("player");

_id_3FC5() {
  level._id_EC8C["door_player_rig"] = "vm_hero_protagonist_base";
  var_0 = [];
  var_0["door_player_rig"]["intro"] = % rogue_outpost_plr_intro_to_door;
  var_0["door_player_rig"]["idle"] = % rogue_outpost_plr_door_idle;
  var_0["door_player_rig"]["pull"] = % rogue_outpost_plr_door_pull;
  var_0["door_player_rig"]["outro"] = % rogue_outpost_plr_civ_depot_1;
  return var_0;
}

#using_animtree("script_model");

_id_3FC4() {
  var_0 = [];
  var_0["door"]["idle"] = % rogue_creephall_door_idle;
  var_0["door"]["pull"] = % rogue_outpost_door_pull;
  var_0["door"]["outro"] = % rogue_outpost_door_open;
  return var_0;
}

#using_animtree("generic_human");

_id_6C4A(var_0) {
  var_0 detach(var_0.hatmodel);
  var_0 detach(var_0.headmodel);
  var_0 _meth_82A2(%mayhem_asteroid_finale_mco_drag, 1.0, 0.0, 1.0);
  wait 6;
  var_0 clearanim(%mayhem_asteroid_finale_mco_drag, 0.05);
  var_0 attach(var_0.headmodel);
  var_0 attach(var_0.hatmodel);
}

_id_5A7A(var_0) {
  var_0 detach(var_0.headmodel);
  var_0 detach(var_0.hatmodel);
  var_0 _meth_82A2(%mayhem_rogue_armory_mr2_exit_scene, 1.0, 0.0, 1.0);
  level waittill("stop_kash_mayhem");
  var_0 clearanim(%mayhem_rogue_armory_mr2_exit_scene, 0.05);
  var_0 attach(var_0.headmodel);
  var_0 attach(var_0.hatmodel);
}

_id_5DBB(var_0) {
  level._id_5D6C _id_0BBC::_id_C5F1("left");
}

_id_D24E(var_0) {
  var_1 = level.player scripts\sp\utility::_id_D08C("ges_radio");

  if(var_1) {
    level.player scripts\engine\utility::delaycall(0.5, ::playsound, "ges_plr_radio_on");
    level.player scripts\engine\utility::delaythread(4, scripts\sp\utility::_id_1102B);
    level.player scripts\engine\utility::delaycall(4, ::playsound, "ges_plr_radio_off");
    return 1;
  }
}

_id_53F2() {}

_id_5A7C(var_0) {
  var_0 notify("jumped");
}

_id_10102(var_0) {
  var_0 show();
}

_id_5199(var_0) {
  playFX(level._effect["object_toss_explode"], var_0.origin, anglesToForward(level._id_111C3._id_C6EA.angles));
  var_0 delete();
  level notify("canister_explode");
}

_id_4147(var_0) {
  scripts\engine\utility::flag_clear("guy_entering_airlock");
}

_id_21C0(var_0) {
  var_0 notify("asteroid_ksh_YoCapnGotsomething");
}

_id_2F44(var_0) {
  if(scripts\engine\utility::flag("player_visited_kitchen") && !isDefined(level._id_B33E._id_1512))
    level.player scripts\sp\utility::_id_10350("asteroid_plr_betterbeer");
  else
    level.player scripts\sp\utility::_id_10350("asteroid_plr_betterthantitan");
}

_id_2F42(var_0) {
  if(!scripts\engine\utility::flag("array1_nag"))
    level._id_B33B scripts\sp\utility::_id_10346("asteroid_brk_Shitthatwasclose");
}

_id_2F43(var_0) {
  if(!scripts\engine\utility::flag("array2_nag"))
    level._id_B4F9 scripts\sp\utility::_id_10346("asteroid_usf_Catchyourbreath");
}

_id_F995(var_0) {
  wait 2;
  level.player notify("airlock_vo_done");
}

_id_F364(var_0) {
  level.player notify("door_opened");
}

_id_10172(var_0) {
  level._id_B4F9 notify("shut_door");
}

_id_5A73(var_0) {
  level.player notify("unlink");
}

_id_5FAD(var_0) {
  scripts\engine\utility::flag_set("activate_knife");
}

_id_D335(var_0) {
  level.player _id_0E4B::_id_1348D();
}

_id_D334(var_0) {
  wait 2;
  _id_0E4B::_id_8E0A();
  level.player _id_D333();
  scripts\engine\utility::delaythread(1.5, _id_0E4B::_id_8DEA);
}

_id_50B1(var_0) {
  wait 2;
  scripts\engine\utility::flag_set("start_creep_vo");
}

_id_D333(var_0) {
  scripts\engine\utility::delaythread(0.05, _id_0B0B::_id_25C2);
  level.player _id_0E4B::_id_13485();
}

_id_D248(var_0) {
  level.player enableweapons();
  scripts\engine\utility::waitframe();
  level.player scripts\sp\utility::_id_F526("safe", 1);
  level.player thread scripts\sp\utility::_id_D090("ges_rescue", level._id_3FA7);
  level.player scripts\sp\utility::_id_F526("relaxed");
}

_id_E611(var_0) {
  if(!isDefined(var_0._id_E628)) {
    var_0 notify("booster_on");
    var_0 playSound("rogue_dropship_npc_boost_rig_on");
    var_0 attach(var_0._id_A489);
  }
}

_id_6C47(var_0) {
  level.player _meth_8185();
  level.player _meth_84AF(1);
  level.player disableweapons();
  wait 3.5;
  earthquake(0.3, 7, level.player.origin, 5000);
  level.player playSound("scn_rogue_finale_last_explos");
  wait 2.8;
  level.player _meth_82C0("fade_to_black_minus_music", 0.1);
  wait 0.2;

  if(getdvarint("loop_finale", 0) == 0)
    scripts\sp\utility::_id_BF95();
  else
    map_restart();
}

_id_9476(var_0) {
  wait 6;
  level.player thread scripts\sp\utility::_id_10350("rogue_plr_rogerthat2");
  wait 0.1;
  level._id_B33B thread scripts\sp\utility::_id_10346("rogue_brk_rogerthat2");
}

_id_A60B(var_0) {
  scripts\engine\utility::flag_set("kill_array_chatter");
  level._id_B33E stopsounds();
}