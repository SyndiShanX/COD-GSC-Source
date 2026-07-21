/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\stpetersburg\stpetersburg_anim.gsc
******************************************************/

main() {
  level_anims_player();
  humans();
  interrogation();
  script_models();
  vehicles();
}

#using_animtree("player");

level_anims_player() {
  level.scr_animtree["player_rig"] = #animtree;
  level.scr_model["player_rig"] = "viewhands_hero_kyle_urban_fullbody";
  level.scr_anim["player_rig"]["camera_intro"] = % stp_bar_010_slamzoom_cam;
  level.scr_anim["player_rig"]["new_camera_intro"] = % stp_bar_010_intro_scene_plr_cam;
  level.scr_goaltime["player_rig"]["new_camera_intro"] = 0.05;
  level.scr_anim["player_rig"]["new_camera_window"] = % stp_bar_010_intro_scene_plr_cam_window;
  level.scr_goaltime["player_rig"]["new_camera_window"] = 0.05;
  scripts\common\anim::addnotetrack_customfunction("player_rig", "letterbox_end", ::intro_camera_letterbox_end, "new_camera_window");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "dof_on", ::camera_intro_dof_on, "new_camera_window");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "dof_rack", ::camera_intro_dof_rack, "new_camera_window");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "dof_off", ::camera_intro_dof_off, "new_camera_window");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "trigger_fov", ::camera_intro_fov_start, "new_camera_window");
  level.scr_anim["player_rig"]["interrogation_intro"] = % stp_wh_010_intro3p_vmcam;
  scripts\common\anim::addnotetrack_customfunction("player_rig", "fov_zoomoutA_start", ::camera_fov_change, "interrogation_intro");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "fov_zoomoutA_end", ::camera_fov_change, "interrogation_intro");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "fov_zoomoutB_Start", ::camera_fov_change, "interrogation_intro");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "fov_zoomoutB_end", ::camera_fov_change, "interrogation_intro");
  scripts\common\anim::addnotetrack_customfunction("player_rig", "interrogation_remove_fov_user_scale", ::interrogation_remove_fov_user_scale, "interrogation_intro");
  level.scr_anim["player_rig"]["acquire_open"] = % stp_wh_010_acquire_player_interact_door;
  level.scr_anim["player_rig"]["acquire"] = % stp_wh_010_acquire_player;
  level.scr_anim["player_rig"]["warning_decline"] = % stp_wh_010_enter_decline_player;
  level.scr_anim["player_rig"]["family_handoff"] = % stp_wh_010_handoff_player;
  level.scr_anim["player_rig"]["gun_pickup"] = % stp_wh_020_interrogation_gun_pickup_plr;
  scripts\common\anim::addnotetrack_customfunction("player_rig", "pc_fov_change", ::pc_force_fov, "acquire");
  scripts\common\anim::addnotetrack_notify("player_rig", "pc_fov_clear", "acquire_pc_fov_clear", "acquire");
  level.scr_anim["player_rig"]["car_interact_left"] = % stp_wh_020_exit_interact_left_vm;
  level.scr_anim["player_rig"]["car_interact_right"] = % stp_wh_020_exit_interact_right_vm;
  level.scr_anim["player_rig"]["interrogation_outro"] = % stp_wh_030_outro_gas_3p_vmcam;
}

#using_animtree("generic_human");

humans() {
  level.scr_animtree["generic"] = #animtree;
  level.scr_anim["generic"]["bar_street_civ_cower_alt2"][0] = % lon_pic_040_sting_civ05_idle;
  level.scr_anim["generic"]["smoking"][0] = % reb_stl_idle_stand_smoking;
  level.scr_anim["generic"]["stp_apt_hall_blockers_stand_idle_civ02"][0] = % stp_apt_hall_blockers_stand_idle_civ02;
  level.scr_anim["generic"]["piccadilly_aftermath_civ_03"] = % piccadilly_aftermath_civ_03;
  level.scr_anim["generic"]["hf_grnd_red_civ_hide_shellshock06"][0] = % hf_grnd_red_civ_hide_shellshock06;
  level.scr_anim["generic"]["civ_casual_frantic_exposed_idle"][0] = % civ_casual_frantic_exposed_idle;
  level.scr_anim["generic"]["rpg_reload"] = % rpg_stand_reload;
  level.scr_anim["generic"]["background_idle1"] = % civ_casual_idle;
  level.scr_anim["generic"]["background_idle2"] = % civ_casual_idle_twitch_a;
  level.scr_anim["generic"]["background_idle3"] = % civ_casual_idle_twitch_b;
  level.scr_anim["generic"]["background_idle4"] = % civ_casual_idle_twitch_c;
  level.scr_anim["generic"]["background_idle5"] = % civ_casual_idle_twitch_d;
  level.scr_anim["generic"]["background_idle6"] = % civ_casual_idle_twitch_e;
  level.scr_anim["generic"]["background_exit_back_right"] = % civ_casual_run_exit_1;
  level.scr_anim["generic"]["background_exit_back"] = % civ_casual_run_exit_2;
  level.scr_anim["generic"]["background_exit_back_left"] = % civ_casual_run_exit_3;
  level.scr_anim["generic"]["background_exit_left"] = % civ_casual_run_exit_4;
  level.scr_anim["generic"]["background_exit_right"] = % civ_casual_run_exit_6;
  level.scr_anim["generic"]["background_exit_front_left"] = % civ_casual_run_exit_7;
  level.scr_anim["generic"]["background_exit_front"] = % civ_casual_run_exit_8;
  level.scr_anim["generic"]["background_exit_front_right"] = % civ_casual_run_exit_9;
  level.scr_anim["fake_player"]["intro_scene"] = % stp_bar_010_intro_scene_kyle;
  level.scr_goaltime["fake_player"]["intro_scene"] = 0.05;
  level.scr_anim["price"]["intro_scene"] = % stp_bar_010_intro_scene_price;
  level.scr_goaltime["price"]["intro_scene"] = 0.05;
  scripts\common\anim::addnotetrack_customfunction("price", "pistol_pickup", ::price_pistol_pickup, "intro_scene");
  scripts\common\anim::addnotetrack_customfunction("price", "ammo_pickup", ::price_ammo_pickup, "intro_scene");
  scripts\common\anim::addnotetrack_customfunction("price", "gun_remove", ::price_gun_remove, "intro_scene");
  level.scr_anim["fake_player"]["intro_scene2"] = % stp_bar_010_intro_scene_kyle2;
  level.scr_goaltime["fake_player"]["intro_scene2"] = 0.05;
  level.scr_anim["price"]["intro_scene2"] = % stp_bar_010_intro_scene_price2;
  level.scr_goaltime["price"]["intro_scene2"] = 0.05;
  scripts\common\anim::addnotetrack_customfunction("price", "pistol_pickup", ::price_pistol_pickup, "intro_scene2");
  scripts\common\anim::addnotetrack_customfunction("price", "ammo_pickup", ::price_ammo_pickup, "intro_scene2");
  scripts\common\anim::addnotetrack_customfunction("price", "gun_remove", ::price_gun_remove, "intro_scene2");
  level.scr_anim["nikolai"]["intro_scene"] = % stp_bar_010_intro_scene_nikolai;
  level.scr_goaltime["nikolai"]["intro_scene"] = 0.05;
  level.scr_anim["nikolai"]["intro_scene_idle"][0] = % stp_bar_010_intro_scene_idle_nikolai;
  scripts\common\anim::addnotetrack_flag("nikolai", "open_case", "flag_stakeout_allow_weapon_select", "intro_scene");
  level.scr_anim["nikolai"]["intro_scene2"] = % stp_bar_010_intro_scene_nikolai2;
  level.scr_goaltime["nikolai"]["intro_scene2"] = 0.05;
  scripts\common\anim::addnotetrack_flag("nikolai", "open_case", "flag_stakeout_allow_weapon_select", "intro_scene2");
  scripts\common\anim::addnotetrack_mayhemstart("fake_player", "mayhem_start", %stp_bar_010_intro_scene_kyle_face, "intro_scene");
  scripts\common\anim::addnotetrack_mayhemend("fake_player", "mayhem_end", %stp_bar_010_intro_scene_kyle_face, "intro_scene");
  scripts\common\anim::addnotetrack_mayhemstart("price", "mayhem_start", %stp_bar_010_intro_scene_price_face, "intro_scene");
  scripts\common\anim::addnotetrack_mayhemend("price", "mayhem_end", %stp_bar_010_intro_scene_price_face, "intro_scene");
  scripts\common\anim::addnotetrack_mayhemstart("nikolai", "mayhem_start", %stp_bar_010_intro_scene_nikolai_face, "intro_scene");
  scripts\common\anim::addnotetrack_mayhemend("nikolai", "mayhem_end", %stp_bar_010_intro_scene_nikolai_face, "intro_scene");
  scripts\common\anim::addnotetrack_mayhemstart("price", "mayhem_start", %stp_bar_010_intro_scene_price_face2, "intro_scene2");
  scripts\common\anim::addnotetrack_mayhemend("price", "mayhem_end", %stp_bar_010_intro_scene_price_face2, "intro_scene2");
  scripts\common\anim::addnotetrack_mayhemstart("nikolai", "mayhem_start", %stp_bar_010_intro_scene_nikolai_face2, "intro_scene2");
  scripts\common\anim::addnotetrack_mayhemend("nikolai", "mayhem_end", %stp_bar_010_intro_scene_nikolai_face2, "intro_scene2");
  level.scr_anim["enforcer"]["intro_scene"] = % stp_bar_010_intro_scene_butcher;
  level.scr_goaltime["enforcer"]["intro_scene"] = 0.05;
  level.scr_anim["aq1"]["intro_scene"] = % stp_bar_010_intro_scene_aq01;
  level.scr_goaltime["aq1"]["intro_scene"] = 0.05;
  level.scr_anim["aq2"]["intro_scene"] = % stp_bar_010_intro_scene_aq02;
  level.scr_goaltime["aq2"]["intro_scene"] = 0.05;
  level.scr_anim["aq3"]["intro_scene"] = % stp_bar_010_intro_scene_aq03;
  level.scr_goaltime["aq3"]["intro_scene"] = 0.05;
  level.scr_anim["aq4"]["intro_idle"][0] = % stp_bar_010_intro_idle_aq04;
  level.scr_anim["aq4"]["intro_scene"] = % stp_bar_010_intro_scene_aq04;
  level.scr_goaltime["aq4"]["intro_scene"] = 0.05;
  level.scr_anim["aq4"]["civ_casual_idle"][0] = % civ_casual_idle;
  scripts\common\anim::addnotetrack_customfunction("enforcer", "enable_breath_fx", scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::enable_breath_fx, "intro_scene");
  scripts\common\anim::addnotetrack_customfunction("aq1", "enable_breath_fx", scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::enable_breath_fx, "intro_scene");
  scripts\common\anim::addnotetrack_customfunction("aq2", "enable_breath_fx", scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::enable_breath_fx, "intro_scene");
  level.scr_anim["price"]["stakeout_window_idle_a"][0] = % stp_bar_010_stakeout_window_idlea_price;
  level.scr_anim["price"]["stakeout_window_a_to_b"] = % stp_bar_010_stakeout_window_idlea_to_b_price;
  level.scr_anim["price"]["stakeout_window_idle_b"][0] = % stp_bar_010_stakeout_window_idleb_price;
  level.scr_anim["price"]["stakeout_bedroom_to_kitchen"] = % stp_bar_010_stakeout_bedroom_to_kitchen_price;
  level.scr_anim["price"]["stakeout_kitchen_intro"] = % stp_bar_010_stakeout_kitchen_intro_price;
  scripts\common\anim::addnotetrack_customfunction("price", "pistol_pickup", ::price_pistol_pickup, "stakeout_kitchen_intro");
  scripts\common\anim::addnotetrack_customfunction("price", "gun_remove", ::price_gun_remove, "stakeout_kitchen_intro");
  level.scr_anim["price"]["stakeout_kitchen_idle"][0] = % stp_bar_010_stakeout_kitchen_idle_price;
  level.scr_anim["price"]["stakeout_kitchen_idle_twitch01"] = % stp_bar_010_stakeout_kitchen_idle_twitch01_price;
  level.scr_goaltime["price"]["stakeout_kitchen_idle_twitch01"] = 0.2;
  level.scr_anim["price"]["stakeout_kitchen_idle_twitch02"] = % stp_bar_010_stakeout_kitchen_idle_twitch02_price;
  level.scr_goaltime["price"]["stakeout_kitchen_idle_twitch02"] = 0.2;
  level.scr_anim["price"]["stakeout_kitchen_exit"] = % stp_bar_010_stakeout_kitchen_exit_price;
  level.scr_goaltime["price"]["stakeout_kitchen_exit"] = 0.2;
  level.scr_anim["price"]["stakeout_kitchen_exit_to_idle"] = % stp_bar_010_stakeout_kitchen_exit_to_idle_price;
  level.scr_goaltime["price"]["stakeout_kitchen_exit_to_idle"] = 0.2;
  level.scr_anim["price"]["stakeout_kitchen_exit_to_stairs"] = % stp_bar_010_stakeout_kitchen_exit_to_stairs_price;
  level.scr_goaltime["price"]["stakeout_kitchen_exit_to_stairs"] = 0.2;
  level.scr_anim["price"]["stakeout_idle_stairs"][0] = % stp_bar_010_stakeout_stairs_idle_price;
  level.scr_anim["price"]["stakeout_stairs_idle_twitch01"] = % stp_bar_010_stakeout_stairs_idle_twitch01_price;
  level.scr_goaltime["price"]["stakeout_stairs_idle_twitch01"] = 0.2;
  level.scr_anim["price"]["stakeout_stairs_idle_twitch02"] = % stp_bar_010_stakeout_stairs_idle_twitch02_price;
  level.scr_goaltime["price"]["stakeout_stairs_idle_twitch02"] = 0.2;
  level.scr_anim["price"]["stakeout_idle_exit_stairs"] = % stp_bar_010_stakeout_stairs_idle_exit_price;
  level.scr_goaltime["price"]["stakeout_idle_exit_stairs"] = 0.2;
  level.scr_anim["price"]["stakeout_descend_stairs"] = % stp_bar_010_stakeout_stairs_descend_price;
  level.scr_goaltime["price"]["stakeout_descend_stairs"] = 0.0;
  scripts\common\anim::addnotetrack_customfunction("price", "bottom_stairs", ::price_bottom_stairs, "stakeout_descend_stairs");
  level.scr_anim["nikolai"]["stakeout_bedroom_intro"] = % stp_bar_010_stakeout_bedroom_intro_nikolai;
  level.scr_anim["nikolai"]["stakeout_bedroom_idle"][0] = % stp_bar_010_stakeout_bedroom_idle_nikolai;
  level.scr_anim["nikolai"]["stakeout_bedroom_bag_remove"] = % stp_bar_010_stakeout_bedroom_bag_remove_nikolai;
  level.scr_anim["nikolai"]["stakeout_desk_idle"][0] = % stp_bar_010_stakeout_bedroom_desk_idle_nikolai;
  level.scr_anim["nikolai"]["stakeout_bedroom_to_kitchen"] = % stp_bar_010_stakeout_bedroom_to_kitchen_nikolai;
  level.scr_goaltime["nikolai"]["stakeout_bedroom_to_kitchen"] = 0.2;
  level.scr_anim["nikolai"]["stakeout_kitchen_intro"] = % stp_bar_010_stakeout_kitchen_intro_nikolai;
  level.scr_goaltime["nikolai"]["stakeout_kitchen_intro"] = 0.2;
  level.scr_anim["nikolai"]["stakeout_kitchen_idle"][0] = % stp_bar_010_stakeout_kitchen_idle_nikolai;
  level.scr_anim["nikolai"]["stakeout_kitchen_idle_twitch01"] = % stp_bar_010_stakeout_kitchen_idle_twitch01_nikolai;
  level.scr_goaltime["nikolai"]["stakeout_kitchen_idle_twitch01"] = 0.2;
  level.scr_anim["nikolai"]["stakeout_kitchen_idle_twitch02"] = % stp_bar_010_stakeout_kitchen_idle_twitch02_nikolai;
  level.scr_goaltime["nikolai"]["stakeout_kitchen_idle_twitch02"] = 0.2;
  level.scr_anim["nikolai"]["stakeout_kitchen_exit_alt"] = % stp_bar_010_stakeout_kitchen_exit_alt01_nikolai;
  level.scr_goaltime["nikolai"]["stakeout_kitchen_exit_alt"] = 0.2;
  level.scr_anim["nikolai"]["stakeout_kitchen_exit"] = % stp_bar_010_stakeout_kitchen_exit_nikolai;
  level.scr_goaltime["nikolai"]["stakeout_kitchen_exit"] = 0.2;
  level.scr_anim["nikolai"]["stakeout_kitchen_idle02"][0] = % stp_bar_010_stakeout_kitchen_idle02_nikolai;
  level.scr_anim["nikolai"]["stakeout_kitchen_idle02_twitch01"] = % stp_bar_010_stakeout_kitchen_idle02_twitch01_nikolai;
  level.scr_goaltime["nikolai"]["stakeout_kitchen_idle02_twitch01"] = 0.2;
  level.scr_anim["nikolai"]["stakeout_door_idle"][0] = % stp_bar_010_stakeout_door_idle_nikolai;
  level.scr_anim["nikolai"]["stakeout_door_close"] = % stp_bar_010_stakeout_door_close_nikolai;
  level.scr_anim["fake_player"]["stakeout_bedroom_intro"] = % stp_bar_010_stakeout_intro_player;
  level.scr_anim["price"]["stealth_door_idle"][0] = % stp_bar_010_stakeout_exit_idle_price;
  level.scr_anim["price"]["stealth_alley_intro"] = % stp_bar_010_alley_intro_price;
  level.scr_goaltime["price"]["stealth_alley_intro"] = 0.5;
  scripts\common\anim::addnotetrack_customfunction("price", "gun_remove", ::price_gun_remove, "stealth_alley_intro");
  level.scr_goaltime["price"]["stealth_alley_shootout"] = 0.7;
  level.scr_anim["price"]["stealth_alley_shootout"] = % stp_bar_010_alley_shootout_price;
  scripts\common\anim::addnotetrack_customfunction("price", "gun_remove", ::price_gun_remove, "stealth_alley_shootout");
  scripts\common\anim::addnotetrack_customfunction("price", "gun_recall", ::price_gun_recall, "stealth_alley_shootout");
  scripts\common\anim::addnotetrack_customfunction("price", "gun_fire", ::price_gun_fire, "stealth_alley_shootout");
  level.scr_anim["aq01"]["stealth_alley_intro"] = % stp_bar_010_alley_intro_aq01;
  level.scr_anim["aq02"]["stealth_alley_intro"] = % stp_bar_010_alley_intro_aq02;
  level.scr_anim["aq03"]["stealth_alley_intro"] = % stp_bar_010_alley_intro_aq03;
  level.scr_anim["aq04"]["stealth_alley_intro"] = % stp_bar_010_alley_intro_aq04;
  level.scr_anim["aq05"]["stealth_alley_intro"] = % stp_bar_010_alley_intro_aq05;
  level.scr_anim["aq01"]["stealth_alley_shootout"] = % stp_bar_010_alley_shootout_aq01;
  level.scr_anim["aq02"]["stealth_alley_shootout"] = % stp_bar_010_alley_shootout_aq02;
  level.scr_anim["aq03"]["stealth_alley_shootout"] = % stp_bar_010_alley_shootout_aq03;
  level.scr_anim["aq04"]["stealth_alley_shootout"] = % stp_bar_010_alley_shootout_aq04;
  level.scr_anim["aq05"]["stealth_alley_shootout"] = % stp_bar_010_alley_shootout_aq05;
  level.scr_anim["generic"]["vehicle_ralfa_civ_scared_idle_LF"][0] = % vehicle_ralfa_civ_scared_idle_lf;
  level.scr_anim["generic"]["vehicle_ralfa_civ_scared_idle_RF"][0] = % vehicle_ralfa_civ_scared_idle_rf;
  level.scr_anim["generic"]["vehicle_ralfa_civ_scared_idle_LR"][0] = % vehicle_ralfa_civ_scared_idle_lr;
  level.scr_anim["generic"]["vehicle_ralfa_civ_scared_idle_RR"][0] = % vehicle_ralfa_civ_scared_idle_rr;
  level.scr_anim["generic"]["vehicle_skilo_civ_scared_idle_LF"][0] = % vehicle_skilo_civ_scared_idle_lf;
  level.scr_anim["generic"]["vehicle_skilo_civ_scared_idle_RF"][0] = % vehicle_skilo_civ_scared_idle_rf;
  level.scr_anim["generic"]["vehicle_skilo_civ_scared_idle_LR"][0] = % vehicle_skilo_civ_scared_idle_lr;
  level.scr_anim["generic"]["vehicle_skilo_civ_scared_idle_RR"][0] = % vehicle_skilo_civ_scared_idle_rr;
  level.scr_anim["generic"]["vehicle_ralfa_civ_death_LF"] = % vehicle_ralfa_civ_death_lf;
  level.scr_anim["generic"]["vehicle_ralfa_civ_death_RF"] = % vehicle_ralfa_civ_death_rf;
  level.scr_anim["generic"]["vehicle_ralfa_civ_death_LR"] = % vehicle_ralfa_civ_death_lr;
  level.scr_anim["generic"]["vehicle_ralfa_civ_death_RR"] = % vehicle_ralfa_civ_death_rr;
  level.scr_anim["generic"]["vehicle_skilo_civ_death_LF"] = % vehicle_skilo_civ_death_lf;
  level.scr_anim["generic"]["vehicle_skilo_civ_death_RF"] = % vehicle_skilo_civ_death_rf;
  level.scr_anim["generic"]["vehicle_skilo_civ_death_LR"] = % vehicle_skilo_civ_death_lr;
  level.scr_anim["generic"]["vehicle_skilo_civ_death_RR"] = % vehicle_skilo_civ_death_rr;
  level.scr_anim["generic"]["traverse_stepup_52"] = % traverse_stepup_52;
  level.scr_anim["generic"]["traverse_stepup_52_fast"] = % traverse_stepup_52_fast;
  level.scr_anim["generic"]["hm_grnd_red_civilianA_run_lookback"] = % hm_grnd_red_civiliana_run_lookback;
  level.scr_anim["generic"]["hm_grnd_red_civilianA_run_stumble02"] = % hm_grnd_red_civiliana_run_stumble02;
  level.scr_anim["generic"]["hf_grnd_red_civ_run_turn_r_9"] = % hf_grnd_red_civ_run_turn_r_9;
  level.scr_anim["generic"]["hf_grnd_red_civ_run_turn_l_7"] = % hf_grnd_red_civ_run_turn_l_7;
  level.scr_anim["generic"]["hm_grnd_red_civilianB_run_lookback"] = % hm_grnd_red_civilianb_run_lookback;
  level.scr_anim["generic"]["hm_grnd_red_civilianB_run_lookback"] = % hm_grnd_red_civilianb_run_lookback;
  level.scr_anim["generic"]["apartment_handsup_idle"][0] = % lon_pic_ctr_030_bus_sniper_civ7_idle;
  level.scr_anim["generic"]["apartment_handsup_death"] = % lon_pic_ctr_030_bus_sniper_civ7_death;
  level.scr_anim["generic"]["dying_crawl"] = % sdr_com_exposed_crouch_long_death_crawl_belly;
  level.scr_goaltime["generic"]["dying_crawl"] = 0.05;
  level.scr_anim["generic"]["dying_crawl_death"] = % sdr_com_exposed_crouch_long_death_crawl_belly_death;
  level.scr_goaltime["generic"]["dying_crawl_death"] = 0.05;
  level.scr_anim["generic"]["dying_crawl_shoot_death"] = % sdr_com_exposed_crouch_long_death_crawl_belly_shoot_death;
  level.scr_goaltime["generic"]["dying_crawl_shoot_death"] = 0.05;
  level.scr_anim["generic"]["vehicle_skilo_civ_idle_RF"][0] = % vehicle_skilo_civ_idle_rf;
  level.scr_anim["generic"]["vehicle_ralfa_civ_idle_RF"][0] = % vehicle_ralfa_civ_idle_rf;
  level.scr_anim["generic"]["vehicle_victor40_civ_idle_RF"][0] = % vehicle_victor40_civ_idle_rf;
  level.scr_anim["generic"]["vehicle_decho_civ_idle_RF"][0] = % vehicle_decho_civ_idle_rf;
  level.scr_anim["generic"]["vehicle_audi_civ_idle_RF"][0] = % vehicle_audi_civ_idle_rf;
  level.scr_anim["price"]["alley_door_intro"] = % stp_alley_backdoor_approach_price;
  level.scr_anim["price"]["alley_door_idle"][0] = % stp_alley_backdoor_idle_price;
  level.scr_anim["enforcer"]["fence_climb"] = % sdr_com_traverse_wall_100;
  level.scr_anim["enforcer"]["fence_jump"] = % traverse_jumpdown_56;
  level.scr_anim["enforcer"]["sdr_com_exposed_run_exit_2"] = % sdr_com_exposed_run_exit_2;
  level.scr_anim["enforcer"]["alley_door_kick"] = % stp_cafe_escape_enter_kickdoor_butcher;
  level.scr_anim["price"]["fence_duck"] = % stp_run_react_duck;
  level.scr_anim["enforcer"]["corner_standr_rambo_short"] = % corner_standr_rambo_short;
  level.scr_anim["enforcer"]["run_death_facedown"] = % run_death_facedown;
  level.scr_anim["enforcer"]["bar_street_run_1"] = % hm_grnd_red_run_n_gun_left_120_ar;
  level.scr_anim["enforcer"]["bar_street_run_2"] = % stp_sdr_com_rungun_run_forward_bl;
  level.scr_goaltime["enforcer"]["bar_street_run_2"] = 0.2;
  level.scr_anim["enforcer"]["bar_street_run_3"] = % hm_grnd_red_run_twitch_look_behind02_ar;
  level.scr_goaltime["enforcer"]["bar_street_run_3"] = 0.05;
  level.scr_anim["enforcer"]["bar_street_run_4"] = % sdr_com_run_pain_stomach_fast;
  level.scr_anim["enforcer"]["bar_street_turn"] = % sdr_com_run_turn_l_4;
  level.scr_goaltime["enforcer"]["bar_street_turn"] = 0.2;
  level.scr_anim["enforcer"]["hf_grnd_red_civ_run_turn_r_9"] = % hf_grnd_red_civ_run_turn_r_9;
  level.scr_anim["enforcer"]["hm_grnd_red_civilianB_run_lookback"] = % hm_grnd_red_civilianb_run_lookback;
  level.scr_anim["dead_body"]["dying_crawl_death_v1"] = % dying_crawl_death_v1;
  level.scr_anim["dead_body"]["dying_crawl_death_v2"] = % dying_crawl_death_v2;
  level.scr_anim["dead_body"]["corner_standr_death_grenade_explode"] = % corner_standr_death_grenade_explode;
  level.scr_anim["dead_body"]["europa_storage_room_sdf_crawl_01_death"] = % europa_storage_room_sdf_crawl_01_death;
  level.scr_anim["dead_body"]["reb_vh_mkilo_driver_death01"] = % reb_vh_mkilo_driver_death01;
  level.scr_anim["dead_body"]["HTF_ESC_010_GasVictim4"] = % htf_esc_010_gasvictim4;
  level.scr_anim["dead_body"]["HTF_ESC_010_GasVictim5"] = % htf_esc_010_gasvictim5;
  level.scr_anim["dead_body"]["EST_CY_031_dead_bodies_A_dead01"] = % est_cy_031_dead_bodies_a_dead01;
  level.scr_anim["dead_body"]["EST_CY_031_dead_bodies_D_dead01"] = % est_cy_031_dead_bodies_d_dead01;
  level.scr_anim["dead_body"]["generic_dead_civ_01"] = % generic_dead_civ_01;
  level.scr_anim["dead_body"]["generic_dead_civ_06"] = % generic_dead_civ_06;
  level.scr_anim["dead_body"]["generic_dead_wall_lean_civ_03"] = % generic_dead_wall_lean_civ_03;
  level.scr_anim["dead_body"]["exposed_death_firing_02"] = % exposed_death_firing_02;
  level.scr_anim["dead_body"]["doorpeek_deatha"] = % doorpeek_deatha;
  level.scr_anim["aq01"]["reb_stl_patrol_pstl_idle_react_md_2"] = % reb_stl_patrol_pstl_idle_react_md_2;
  level.scr_anim["aq01"]["reb_stl_patrol_pstl_idle_react_md_4"] = % reb_stl_patrol_pstl_idle_react_md_4;
  level.scr_anim["aq01"]["reb_stl_patrol_pstl_idle_react_md_6"] = % reb_stl_patrol_pstl_idle_react_md_6;
  level.scr_anim["aq01"]["reb_stl_patrol_pstl_idle_react_md_8"] = % reb_stl_patrol_pstl_idle_react_md_8;
  level.scr_anim["enforcer"]["backroom_idle"][0] = % stp_bar_030_backroom_scene_idle_enforcer;
  level.scr_anim["enemy4"]["backroom_idle"][0] = % stp_bar_030_backroom_scene_idle_aq01;
  level.scr_anim["enemy1"]["backroom_idle"][0] = % stp_bar_030_backroom_scene_idle_aq02;
  level.scr_anim["enforcer"]["backroom_react"] = % stp_bar_030_backroom_scene_reveal_enforcer;
  level.scr_goaltime["enforcer"]["backroom_react"] = 0.5;
  level.scr_anim["enemy4"]["backroom_react"] = % stp_bar_030_backroom_scene_reveal_aq01;
  level.scr_anim["enemy1"]["backroom_react"] = % stp_bar_030_backroom_scene_reveal_aq02;
  level.scr_goaltime["aq02"]["backroom_react"] = 0.5;
  level.scr_anim["price"]["post_backroom_intro"] = % stp_bar_030_backroom_scene_intro_price;
  level.scr_anim["price"]["post_backroom_idle"][0] = % stp_bar_030_backroom_scene_idle_price;
  level.scr_anim["price"]["bar_backroom_table"] = % stp_bar_020_backroom_inspect_price;
  level.scr_anim["price"]["bar_backroom_idle"][0] = % stp_bar_020_backroom_idle_price;
  level.scr_anim["price"]["bar_backroom_table_grab"] = % stp_bar_030_backroom_scene_weapon_grab_price;
  level.scr_anim["enforcer"]["bar_escape_slide"] = % stp_bar_escape_jump_cover_enforcer;
  level.scr_goaltime["enforcer"]["bar_escape_slide"] = 0.05;
  level.scr_anim["enforcer"]["bar_escape_blind_fire_idle"][0] = % stp_bar_escape_blind_fire_enforcer;
  level.scr_anim["enforcer"]["bar_escape_exit"] = % stp_bar_escape_exit_enforcer;
  scripts\common\anim::addnotetrack_customfunction("enforcer", "sfx_bar_escape_door", ::sfx_bar_escape_door, "bar_escape_exit");
  level.scr_anim["generic"]["bar_pooltable_aq"] = % stp_bar_escape_scene_civ03;
  level.scr_goaltime["generic"]["bar_pooltable_aq"] = 0.05;
  level.scr_anim["generic"]["bar_back_aq"] = % stp_bar_escape_scene_aq01;
  level.scr_goaltime["generic"]["bar_back_aq"] = 0.05;
  level.scr_anim["generic"]["bar_right_aq"] = % stp_bar_escape_scene_aq02;
  level.scr_goaltime["generic"]["bar_right_aq"] = 0.05;
  scripts\common\anim::addnotetrack_customfunction("enforcer", "blind_fire", ::blind_fire, "bar_escape_blind_fire_idle");
  level.scr_anim["apt_shocked_civ"]["apt_entrance_hiding"][0] = % stp_apt_stairs_cower_idle;
  level.scr_anim["apt_shocked_civ"]["apt_entrance_react"] = % stp_apt_stairs_cower_react;
  level.scr_anim["apt_shocked_civ"]["apt_entrance_react_idle"][0] = % stp_apt_stairs_cower_react_idle;
  level.scr_anim["civ"]["apt_hallway_flee"] = % stp_apt_hallway_mother_child_scene_mom;
  level.scr_anim["civ"]["apt_hallway_flee_idle"][0] = % stp_apt_hallway_mother_child_idle_mom;
  level.scr_anim["child"]["apt_hallway_flee"] = % stp_apt_hallway_mother_child_scene_child;
  level.scr_anim["child"]["apt_hallway_flee_idle"][0] = % stp_apt_hallway_mother_child_idle_child;
  level.scr_anim["civ01"]["bar_street_flee"] = % pic_terattack_bomb_react_civ_08;
  level.scr_anim["civ02"]["bar_street_flee"] = % pic_terattack_bomb_react_civ_05;
  level.scr_anim["civ03"]["bar_street_flee"] = % stp_bar_street_woman_run_toward_civ03;
  level.scr_anim["civ03"]["bar_street_flee_idle"][0] = % stp_bar_street_woman_idle_toward_civ03;
  level.scr_anim["civ01"]["canal_civs_onlookers"] = % stp_can_010_onlookers_civ01;
  level.scr_anim["civ02"]["canal_civs_onlookers"] = % stp_can_010_onlookers_civ02;
  level.scr_anim["civ03"]["canal_civs_onlookers"] = % stp_can_010_onlookers_civ03;
  level.scr_anim["civ01"]["canal_civs_onlookers_idle2"][0] = % stp_apt_stairs_cower_idle;
  level.scr_anim["civ02"]["canal_civs_onlookers_idle2"][0] = % stp_apt_stairs_cower_idle;
  level.scr_anim["civ03"]["canal_civs_onlookers_idle2"][0] = % stp_apt_stairs_cower_idle;
  level.scr_anim["civ04"]["canal_civs_flee_car"] = % stp_can_020_civdeathcars_civ01;
  level.scr_anim["civ05"]["canal_civs_flee_car"] = % stp_can_020_civdeathcars_civ09;
  level.scr_anim["civ06"]["canal_civs_flee_car"] = % stp_can_020_civdeathcars_civ06;
  level.scr_anim["civ07"]["canal_civs_flee"] = % stp_can_020_street_civs_flee_civ01;
  level.scr_anim["civ04"]["canal_civs_flee_idle"][0] = % stp_apt_stairs_cower_idle;
  level.scr_anim["civ05"]["canal_civs_flee_idle"][0] = % stp_apt_stairs_cower_idle;
  level.scr_anim["civ06"]["canal_civs_flee_idle"][0] = % stp_apt_stairs_cower_idle;
  level.scr_anim["civ01"]["canal_civs_flee_sidewalk"] = % stp_can_020_street_civs_flee_civ01;
  level.scr_anim["child01"]["canal_civs_flee"] = % stp_bar_street_couple_run_civ02;
  level.scr_anim["child01"]["canal_civs_flee_idle"][0] = % stp_apt_hallway_mother_child_idle_child;
  level.scr_anim["parent01"]["canal_civs_flee"] = % stp_bar_street_couple_run_civ01;
  level.scr_anim["parent01"]["canal_civs_flee_idle"][0] = % stp_apt_hallway_mother_child_idle_mom;
  level.scr_anim["police"]["evade_cafe_police_enter"] = % stp_cafe_escape_scene_pol1;
  level.scr_anim["enforcer"]["evade_cafe_enforcer_escape"] = % stp_cafe_escape_scene_enf;
  level.scr_anim["enforcer"]["evade_cafe_enforcer_exits"] = % stp_cafe_escape_exit_bashdoor_butcher;
  level.scr_anim["price"]["evade_price_react"] = % stp_cafe_reactmolotov_price;
  level.scr_anim["price"]["evade_price_react_1"] = % sdr_com_molotov_reactions_left_arm_sling;
  level.scr_anim["price"]["evade_price_react_2"] = % sdr_com_molotov_reactions_left_leg_sling;
}

interrogation() {
  level.scr_anim["escort_intrg_mother"]["idle_loop"][0] = % stp_wh_010_escort_mech_idle_wife;
  level.scr_anim["escort_intrg_mother"]["idle_loop_hallway"][0] = % stp_wh_010_escort_mech_idle_halt_wife;
  level.scr_anim["escort_intrg_mother"]["forward_start"] = % stp_wh_010_escort_mech_walk_8_start_wife;
  level.scr_anim["escort_intrg_mother"]["forward_loop"][0] = % stp_wh_010_escort_mech_walk_8_wife;
  level.scr_anim["escort_intrg_mother"]["forward_stop"] = % stp_wh_010_escort_mech_walk_8_stop_wife;
  level.scr_anim["escort_intrg_mother"]["backward_start"] = % stp_wh_010_escort_mech_walk_2_start_wife;
  level.scr_anim["escort_intrg_mother"]["backward_loop"][0] = % stp_wh_010_escort_mech_walk_2_wife;
  level.scr_anim["escort_intrg_mother"]["backward_stop"] = % stp_wh_010_escort_mech_walk_2_stop_wife;
  level.scr_anim["escort_intrg_mother"]["left_start"] = % stp_wh_010_escort_mech_walk_4_start_wife;
  level.scr_anim["escort_intrg_mother"]["left_loop"][0] = % stp_wh_010_escort_mech_walk_4_wife;
  level.scr_anim["escort_intrg_mother"]["left_stop"] = % stp_wh_010_escort_mech_walk_4_stop_wife;
  level.scr_anim["escort_intrg_mother"]["right_start"] = % stp_wh_010_escort_mech_walk_6_start_wife;
  level.scr_anim["escort_intrg_mother"]["right_loop"][0] = % stp_wh_010_escort_mech_walk_6_wife;
  level.scr_anim["escort_intrg_mother"]["right_stop"] = % stp_wh_010_escort_mech_walk_6_stop_wife;
  level.scr_anim["escort_intrg_mother"]["turn_left_start"] = % stp_wh_010_escort_mech_turn_90l_start_wife;
  level.scr_anim["escort_intrg_mother"]["turn_left"][0] = % stp_wh_010_escort_mech_turn_90l_wife;
  level.scr_anim["escort_intrg_mother"]["turn_left_stop"] = % stp_wh_010_escort_mech_turn_90l_stop_wife;
  level.scr_anim["escort_intrg_mother"]["turn_right_start"] = % stp_wh_010_escort_mech_turn_90r_start_wife;
  level.scr_anim["escort_intrg_mother"]["turn_right"][0] = % stp_wh_010_escort_mech_turn_90r_wife;
  level.scr_anim["escort_intrg_mother"]["turn_right_stop"] = % stp_wh_010_escort_mech_turn_90r_stop_wife;
  level.scr_anim["escort_intrg_mother"]["forward_start_hallway"] = % stp_wh_010_escort_mech_walk_8_halt_start_wife;
  level.scr_anim["escort_intrg_mother"]["forward_loop_hallway"][0] = % stp_wh_010_escort_mech_walk_8_halt_wife;
  level.scr_anim["escort_intrg_mother"]["forward_stop_hallway"] = % stp_wh_010_escort_mech_walk_8_halt_stop_wife;
  level.scr_anim["escort_intrg_mother"]["backward_start_hallway"] = % stp_wh_010_escort_mech_walk_2_halt_start_wife;
  level.scr_anim["escort_intrg_mother"]["backward_loop_hallway"][0] = % stp_wh_010_escort_mech_walk_2_halt_wife;
  level.scr_anim["escort_intrg_mother"]["backward_stop_hallway"] = % stp_wh_010_escort_mech_walk_2_halt_stop_wife;
  level.scr_anim["escort_intrg_mother"]["left_start_hallway"] = % stp_wh_010_escort_mech_walk_4_halt_start_wife;
  level.scr_anim["escort_intrg_mother"]["left_loop_hallway"][0] = % stp_wh_010_escort_mech_walk_4_halt_wife;
  level.scr_anim["escort_intrg_mother"]["left_stop_hallway"] = % stp_wh_010_escort_mech_walk_4_halt_stop_wife;
  level.scr_anim["escort_intrg_mother"]["right_start_hallway"] = % stp_wh_010_escort_mech_walk_6_halt_start_wife;
  level.scr_anim["escort_intrg_mother"]["right_loop_hallway"][0] = % stp_wh_010_escort_mech_walk_6_halt_wife;
  level.scr_anim["escort_intrg_mother"]["right_stop_hallway"] = % stp_wh_010_escort_mech_walk_6_halt_stop_wife;
  level.scr_anim["escort_intrg_mother"]["turn_left_start_hallway"] = % stp_wh_010_escort_mech_turn_90l_start_02_wife;
  level.scr_anim["escort_intrg_mother"]["turn_left_hallway"][0] = % stp_wh_010_escort_mech_turn_90l_wife;
  level.scr_anim["escort_intrg_mother"]["turn_left_stop_hallway"] = % stp_wh_010_escort_mech_turn_90l_stop_02_wife;
  level.scr_anim["escort_intrg_mother"]["turn_right_start_hallway"] = % stp_wh_010_escort_mech_turn_90r_start_02_wife;
  level.scr_anim["escort_intrg_mother"]["turn_right_hallway"][0] = % stp_wh_010_escort_mech_turn_90r_wife;
  level.scr_anim["escort_intrg_mother"]["turn_right_stop_hallway"] = % stp_wh_010_escort_mech_turn_90r_stop_02_wife;
  level.scr_anim["escort_intrg_mother"]["react_hallway"] = % stp_wh_010_escort_mech_react_01_wife;
  level.scr_anim["escort_intrg_mother"]["handoff_disengage"] = % stp_wh_010_escort_mech_transition_handoff_wife;

  foreach(var_2, var_1 in level.scr_anim["escort_intrg_mother"]) {
    if(scripts\engine\utility::array_contains(strtok(var_2, "_"), "loop"))
      level.scr_goaltime["escort_intrg_mother"][var_2] = 0;
  }

  level.scr_anim["escort_intrg_son"]["idle_loop"][0] = % stp_wh_010_escort_mech_idle_child;
  level.scr_anim["escort_intrg_son"]["idle_loop_hallway"][0] = % stp_wh_010_escort_mech_idle_halt_child;
  level.scr_anim["escort_intrg_son"]["forward_start"] = % stp_wh_010_escort_mech_walk_8_start_child;
  level.scr_anim["escort_intrg_son"]["forward_loop"][0] = % stp_wh_010_escort_mech_walk_8_child;
  level.scr_anim["escort_intrg_son"]["forward_stop"] = % stp_wh_010_escort_mech_walk_8_stop_child;
  level.scr_anim["escort_intrg_son"]["backward_start"] = % stp_wh_010_escort_mech_walk_2_start_child;
  level.scr_anim["escort_intrg_son"]["backward_loop"][0] = % stp_wh_010_escort_mech_walk_2_child;
  level.scr_anim["escort_intrg_son"]["backward_stop"] = % stp_wh_010_escort_mech_walk_2_stop_child;
  level.scr_anim["escort_intrg_son"]["left_start"] = % stp_wh_010_escort_mech_walk_4_start_child;
  level.scr_anim["escort_intrg_son"]["left_loop"][0] = % stp_wh_010_escort_mech_walk_4_child;
  level.scr_anim["escort_intrg_son"]["left_stop"] = % stp_wh_010_escort_mech_walk_4_stop_child;
  level.scr_anim["escort_intrg_son"]["right_start"] = % stp_wh_010_escort_mech_walk_6_start_child;
  level.scr_anim["escort_intrg_son"]["right_loop"][0] = % stp_wh_010_escort_mech_walk_6_child;
  level.scr_anim["escort_intrg_son"]["right_stop"] = % stp_wh_010_escort_mech_walk_6_stop_child;
  level.scr_anim["escort_intrg_son"]["turn_left_start"] = % stp_wh_010_escort_mech_turn_90l_start_child;
  level.scr_anim["escort_intrg_son"]["turn_left"][0] = % stp_wh_010_escort_mech_turn_90l_child;
  level.scr_anim["escort_intrg_son"]["turn_left_stop"] = % stp_wh_010_escort_mech_turn_90l_stop_child;
  level.scr_anim["escort_intrg_son"]["turn_right_start"] = % stp_wh_010_escort_mech_turn_90r_start_child;
  level.scr_anim["escort_intrg_son"]["turn_right"][0] = % stp_wh_010_escort_mech_turn_90r_child;
  level.scr_anim["escort_intrg_son"]["turn_right_stop"] = % stp_wh_010_escort_mech_turn_90r_stop_child;
  level.scr_anim["escort_intrg_son"]["forward_start_hallway"] = % stp_wh_010_escort_mech_walk_8_halt_start_child;
  level.scr_anim["escort_intrg_son"]["forward_loop_hallway"][0] = % stp_wh_010_escort_mech_walk_8_halt_child;
  level.scr_anim["escort_intrg_son"]["forward_stop_hallway"] = % stp_wh_010_escort_mech_walk_8_halt_stop_child;
  level.scr_anim["escort_intrg_son"]["backward_start_hallway"] = % stp_wh_010_escort_mech_walk_2_halt_start_child;
  level.scr_anim["escort_intrg_son"]["backward_loop_hallway"][0] = % stp_wh_010_escort_mech_walk_2_halt_child;
  level.scr_anim["escort_intrg_son"]["backward_stop_hallway"] = % stp_wh_010_escort_mech_walk_2_halt_stop_child;
  level.scr_anim["escort_intrg_son"]["left_start_hallway"] = % stp_wh_010_escort_mech_walk_4_halt_start_child;
  level.scr_anim["escort_intrg_son"]["left_loop_hallway"][0] = % stp_wh_010_escort_mech_walk_4_halt_child;
  level.scr_anim["escort_intrg_son"]["left_stop_hallway"] = % stp_wh_010_escort_mech_walk_4_halt_stop_child;
  level.scr_anim["escort_intrg_son"]["right_start_hallway"] = % stp_wh_010_escort_mech_walk_6_halt_start_child;
  level.scr_anim["escort_intrg_son"]["right_loop_hallway"][0] = % stp_wh_010_escort_mech_walk_6_halt_child;
  level.scr_anim["escort_intrg_son"]["right_stop_hallway"] = % stp_wh_010_escort_mech_walk_6_halt_stop_child;
  level.scr_anim["escort_intrg_son"]["turn_left_start_hallway"] = % stp_wh_010_escort_mech_turn_90l_start_02_child;
  level.scr_anim["escort_intrg_son"]["turn_left_hallway"][0] = % stp_wh_010_escort_mech_turn_90l_child;
  level.scr_anim["escort_intrg_son"]["turn_left_stop_hallway"] = % stp_wh_010_escort_mech_turn_90l_stop_02_child;
  level.scr_anim["escort_intrg_son"]["turn_right_start_hallway"] = % stp_wh_010_escort_mech_turn_90r_start_02_child;
  level.scr_anim["escort_intrg_son"]["turn_right_hallway"][0] = % stp_wh_010_escort_mech_turn_90r_child;
  level.scr_anim["escort_intrg_son"]["turn_right_stop_hallway"] = % stp_wh_010_escort_mech_turn_90r_stop_02_child;
  level.scr_anim["escort_intrg_son"]["react_hallway"] = % stp_wh_010_escort_mech_react_01_child;
  level.scr_anim["escort_intrg_son"]["handoff_disengage"] = % stp_wh_010_escort_mech_transition_handoff_child;

  foreach(var_2, var_1 in level.scr_anim["escort_intrg_son"]) {
    if(scripts\engine\utility::array_contains(strtok(var_2, "_"), "loop"))
      level.scr_goaltime["escort_intrg_son"][var_2] = 0;
  }

  level.scr_anim["interrogation_enforcer"]["interrogation_intro"] = % stp_wh_010_intro3p_butcher;
  level.scr_anim["yegor"]["interrogation_intro"] = % stp_wh_010_intro3p_yegor;
  level.scr_anim["price"]["interrogation_intro"] = % stp_wh_010_intro3p_price;
  level.scr_anim["fake_player"]["interrogation_intro"] = % stp_wh_010_intro3p_kyle;
  level.scr_anim["yegor"]["room_idle"][0] = % stp_wh_010_enter_yegor_idle_room;
  scripts\common\anim::addnotetrack_mayhemstart("interrogation_enforcer", "mayhem_partA_start", %stp_wh_010_intro3p_butcher_parta_face, "interrogation_intro");
  scripts\common\anim::addnotetrack_mayhemend("interrogation_enforcer", "mayhem_partA_end", %stp_wh_010_intro3p_butcher_parta_face, "interrogation_intro");
  scripts\common\anim::addnotetrack_mayhemstart("interrogation_enforcer", "mayhem_partB_start", %stp_wh_010_intro3p_butcher_partb_face, "interrogation_intro");
  scripts\common\anim::addnotetrack_mayhemend("interrogation_enforcer", "mayhem_partB_end", %stp_wh_010_intro3p_butcher_partb_face, "interrogation_intro");
  scripts\common\anim::addnotetrack_flag("interrogation_enforcer", "mayhem_partB_start", "intro_butcher_mayhem_b", "interrogation_intro");
  scripts\common\anim::addnotetrack_mayhemstart("yegor", "mayhem_partA_start", %stp_wh_010_intro3p_yegor_parta_face, "interrogation_intro");
  scripts\common\anim::addnotetrack_mayhemend("yegor", "mayhem_partA_end", %stp_wh_010_intro3p_yegor_parta_face, "interrogation_intro");
  scripts\common\anim::addnotetrack_mayhemstart("yegor", "mayhem_partB_start", %stp_wh_010_intro3p_yegor_partb_face, "interrogation_intro");
  scripts\common\anim::addnotetrack_mayhemend("yegor", "mayhem_partB_end", %stp_wh_010_intro3p_yegor_partb_face, "interrogation_intro");
  scripts\common\anim::addnotetrack_flag("yegor", "mayhem_partB_start", "intro_yegor_mayhem_b", "interrogation_intro");
  scripts\common\anim::addnotetrack_mayhemstart("price", "mayhem_start", %stp_wh_010_intro3p_price_face, "interrogation_intro");
  scripts\common\anim::addnotetrack_mayhemend("price", "mayhem_end", %stp_wh_010_intro3p_price_face, "interrogation_intro");
  scripts\common\anim::addnotetrack_mayhemstart("fake_player", "mayhem_start", %stp_wh_010_intro3p_kyle_face, "interrogation_intro");
  scripts\common\anim::addnotetrack_mayhemend("fake_player", "mayhem_end", %stp_wh_010_intro3p_kyle_face, "interrogation_intro");
  level.scr_anim["nikolai"]["acquire_intro"] = % stp_wh_010_acquire_nikolai;
  level.scr_anim["nikolai"]["acquire_intro_idle"][0] = % stp_wh_010_acquire_nikolai_idle01;
  level.scr_anim["nikolai"]["acquire_intro_nag_near_1"] = % stp_wh_010_acquire_nikolai_nag01_near;
  level.scr_goaltime["nikolai"]["acquire_intro_nag_near_1"] = 1.8;
  level.scr_anim["nikolai"]["acquire_intro_nag_near_2"] = % stp_wh_010_acquire_nikolai_nag02_near;
  level.scr_goaltime["nikolai"]["acquire_intro_nag_near_2"] = 1.8;
  level.scr_anim["nikolai"]["acquire_intro_nag_far_1"] = % stp_wh_010_acquire_nikolai_nag01_far;
  level.scr_goaltime["nikolai"]["acquire_intro_nag_far_1"] = 1.8;
  level.scr_anim["nikolai"]["acquire_intro_nag_far_2"] = % stp_wh_010_acquire_nikolai_nag02_far;
  level.scr_goaltime["nikolai"]["acquire_intro_nag_far_2"] = 1.8;
  level.scr_anim["interrogation_mother"]["acquire_intro"] = % stp_wh_010_acquire_wife_arrive;
  level.scr_anim["interrogation_son"]["acquire_intro"] = % stp_wh_010_acquire_child_arrive;
  scripts\common\anim::addnotetrack_flag("nikolai", "van_interact_available", "van_interact_available", "acquire_intro");
  scripts\common\anim::addnotetrack_flag("nikolai", "nikolai_intro_vo", "nikolai_intro_vo", "acquire_intro");
  scripts\common\anim::addnotetrack_flag("nikolai", "nikolai_nag_ready", "nikolai_nag_ready", "acquire_intro");
  scripts\common\anim::addnotetrack_customfunction("nikolai", "script_dx_vom_nik_interrogation_intro_family_10", ::nikolai_acquire_intro_vo, "acquire_intro");
  scripts\common\anim::addnotetrack_notify("nikolai", "nag_trigger", "nik_nag_trigger", "acquire_intro_nag_near_1");
  scripts\common\anim::addnotetrack_notify("nikolai", "nag_trigger", "nik_nag_trigger", "acquire_intro_nag_near_2");
  scripts\common\anim::addnotetrack_notify("nikolai", "nag_trigger", "nik_nag_trigger", "acquire_intro_nag_far_1");
  scripts\common\anim::addnotetrack_notify("nikolai", "nag_trigger", "nik_nag_trigger", "acquire_intro_nag_far_2");
  level.scr_anim["nikolai"]["acquire_open"] = % stp_wh_010_acquire_nikolai_interact_door;
  level.scr_anim["interrogation_mother"]["acquire_open"] = % stp_wh_010_acquire_wife_van;
  level.scr_anim["interrogation_son"]["acquire_open"] = % stp_wh_010_acquire_child_van;
  level.scr_anim["nikolai"]["acquire_idle"][0] = % stp_wh_010_acquire_nikolai_idle02;
  level.scr_anim["nikolai"]["acquire_nag_near_1"] = % stp_wh_010_acquire_nikolai_nag01_car_near;
  level.scr_goaltime["nikolai"]["acquire_nag_near_1"] = 1.8;
  level.scr_anim["nikolai"]["acquire_nag_near_2"] = % stp_wh_010_acquire_nikolai_nag02_car_near;
  level.scr_goaltime["nikolai"]["acquire_nag_near_2"] = 1.8;
  level.scr_anim["nikolai"]["acquire_nag_far_1"] = % stp_wh_010_acquire_nikolai_nag01_car_far;
  level.scr_goaltime["nikolai"]["acquire_nag_far_1"] = 1.8;
  level.scr_anim["nikolai"]["acquire_nag_far_2"] = % stp_wh_010_acquire_nikolai_nag02_car_far;
  level.scr_goaltime["nikolai"]["acquire_nag_far_2"] = 1.8;
  scripts\common\anim::addnotetrack_notify("interrogation_mother", "script_dx_vom_ousa_interrogation_intro_family_70", "acquire_van_wife_vo", "acquire_open");
  scripts\common\anim::addnotetrack_notify("nikolai", "nikolai_remark", "nikolai_escort_remark", "acquire_open");
  scripts\common\anim::addnotetrack_notify("nikolai", "nag_trigger", "nik_nag_trigger", "acquire_nag_near_1");
  scripts\common\anim::addnotetrack_notify("nikolai", "nag_trigger", "nik_nag_trigger", "acquire_nag_near_2");
  scripts\common\anim::addnotetrack_notify("nikolai", "nag_trigger", "nik_nag_trigger", "acquire_nag_far_1");
  scripts\common\anim::addnotetrack_notify("nikolai", "nag_trigger", "nik_nag_trigger", "acquire_nag_far_2");
  scripts\common\anim::addnotetrack_customfunction("nikolai", "restoreUserFOV", ::van_restore_user_fov, "acquire_open");
  level.scr_anim["interrogation_mother"]["acquire"] = % stp_wh_010_acquire_wife;
  level.scr_anim["interrogation_son"]["acquire"] = % stp_wh_010_acquire_child;
  level.scr_anim["interrogation_mother"]["acquire_idle"][0] = % stp_wh_010_acquire_wife_idle;
  level.scr_anim["interrogation_son"]["acquire_idle"][0] = % stp_wh_010_acquire_child_idle;
  scripts\common\anim::addnotetrack_customfunction("interrogation_mother", "vo_dx_vom_ousa_interrogation_intro_family_150", ::van_stop_vo, "acquire");
  level.scr_anim["nikolai"]["car_idle"][0] = % stp_wh_010_acquire_nikolai_idle03;
  level.scr_anim["nikolai"]["car_remark"] = % stp_wh_010_acquire_nikolai_at_car;
  level.scr_anim["nikolai"]["escort_idle"][0] = % stp_wh_010_acquire_nikolai_idle04;
  level.scr_anim["price"]["door_open"] = % stp_wh_010_enter_price_door_open;
  level.scr_anim["price"]["content_warning"] = % stp_wh_010_enter_option_dont_price;
  level.scr_anim["price"]["content_warning_idle"][0] = % stp_wh_010_enter_price_idle_door;
  level.scr_anim["price"]["content_warning_nag_1"] = % stp_wh_010_enter_nag01_bring_price;
  level.scr_anim["price"]["content_warning_nag_2"] = % stp_wh_010_enter_nag02_cmon_price;
  level.scr_anim["price"]["content_warning_nag_3"] = % stp_wh_010_enter_nag03_deliver_price;
  level.scr_anim["price"]["warning_decline"] = % stp_wh_010_enter_decline_price;
  level.scr_anim["interrogation_mother"]["warning_decline"] = % stp_wh_010_enter_decline_wife;
  level.scr_anim["interrogation_son"]["warning_decline"] = % stp_wh_010_enter_decline_child;
  level.scr_anim["yegor"]["warning_decline"] = % stp_wh_010_enter_decline_yegor;
  level.scr_anim["interrogation_enforcer"]["warning_decline"] = % stp_wh_010_enter_decline_butcher;
  level.scr_anim["price"]["decline_exit"] = % stp_wh_010_exit_decline_price;
  level.scr_anim["nikolai"]["decline_exit"] = % stp_wh_010_exit_decline_nik;
  scripts\common\anim::addnotetrack_customfunction("nikolai", "car_unlock", ::police_car_unlock, "decline_exit");
  scripts\common\anim::addnotetrack_customfunction("price", "price_enters_car", ::price_car_enter, "decline_exit");
  scripts\common\anim::addnotetrack_flag("price", "price_vo_done", "police_car_nag_spoken", "decline_exit");
  level.scr_anim["price"]["warning_accept"] = % stp_wh_010_enter_pcap_proceed_price;
  level.scr_anim["price"]["warning_accept_idle"][0] = % stp_wh_010_enter_proceed_price_idle_aside;
  level.scr_anim["interrogation_enforcer"]["room_enter"] = % stp_wh_010_enter_pcap_proceed_butcher;
  level.scr_anim["yegor"]["room_enter"] = % stp_wh_010_enter_pcap_proceed_yegor;
  scripts\common\anim::addnotetrack_notify("interrogation_enforcer", "script_dx_vom_ousa_interrogation_room_interrogate_50", "script_dx_vom_ousa_interrogation_room_interrogate_50", "room_enter");
  scripts\common\anim::addnotetrack_notify("interrogation_enforcer", "script_dx_vom_amon_interrogation_room_interrogate_70", "script_dx_vom_amon_interrogation_room_interrogate_70", "room_enter");
  scripts\common\anim::addnotetrack_notify("interrogation_enforcer", "script_dx_vom_ousa_interrogation_room_interrogate_100", "script_dx_vom_ousa_interrogation_room_interrogate_100", "room_enter");
  level.scr_anim["price"]["family_handoff"] = % stp_wh_010_handoff_price;
  level.scr_anim["yegor"]["family_handoff"] = % stp_wh_010_handoff_yegor;
  level.scr_goaltime["interrogation_enforcer"]["family_handoff"] = 0.2;
  level.scr_anim["interrogation_enforcer"]["family_handoff"] = % stp_wh_010_handoff_butcher;
  level.scr_goaltime["interrogation_enforcer"]["family_handoff"] = 0.8;
  level.scr_anim["interrogation_mother"]["family_handoff"] = % stp_wh_010_handoff_wife;
  level.scr_anim["interrogation_son"]["family_handoff"] = % stp_wh_010_handoff_child;
  scripts\common\anim::addnotetrack_customfunction("price", "gun_show", ::price_place_revolver, "family_handoff");
  scripts\common\anim::addnotetrack_notify("price", "gun_placed", "gun_placed", "family_handoff");
  scripts\common\anim::addnotetrack_notify("yegor", "mother_hood", "mother_hood_switch", "family_handoff");
  scripts\common\anim::addnotetrack_notify("yegor", "son_hood", "son_hood_switch", "family_handoff");
  scripts\common\anim::addnotetrack_notify("price", "script_dx_vom_kyle_interrogation_room_interrogate_230", "script_dx_vom_kyle_interrogation_room_interrogate_230", "family_handoff");
  level.scr_anim["price"]["handoff_nag_1"] = % stp_wh_010_aside_nag01_givethem_price;
  level.scr_anim["price"]["handoff_nag_2"] = % stp_wh_010_aside_nag02_handoff_price;
  level.scr_anim["price"]["idle_loop"][0] = % stp_wh_010_enter_price_idle;
  level.scr_anim["yegor"]["idle_loop"][0] = % stp_wh_010_enter_yegor_idle;
  level.scr_anim["price"]["offer_gun_nag_1"] = % stp_wh_020_handoff_nag01_takeit_price;
  level.scr_anim["price"]["offer_gun_nag_2"] = % stp_wh_020_handoff_nag02_pickitup_price;
  level.scr_anim["price"]["offer_gun_nag_3"] = % stp_wh_020_handoff_nag03_necessary_price;
  level.scr_anim["price"]["abandon_trigger"] = % stp_wh_020_handoff_nag04_reconsider_price;
  level.scr_anim["price"]["scene_gun_pickup"] = % stp_wh_020_interrogation_gun_pickup_price;
  level.scr_goaltime["price"]["scene_gun_pickup"] = 1;
  level.scr_anim["interrogation_enforcer"]["scene_gun_pickup"] = % stp_wh_020_interrogation_gun_pickup_butcher;
  level.scr_goaltime["interrogation_enforcer"]["scene_gun_pickup"] = 0.8;
  scripts\common\anim::addnotetrack_notify("interrogation_enforcer", "script_dx_vom_ousa_interrogation_revolver_pickup_100", "script_dx_vom_ousa_interrogation_revolver_pickup_100", "scene_gun_pickup");
  scripts\common\anim::addnotetrack_notify("interrogation_enforcer", "script_dx_vom_amon_interrogation_revolver_pickup_110", "script_dx_vom_amon_interrogation_revolver_pickup_110", "scene_gun_pickup");
  scripts\common\anim::addnotetrack_notify("interrogation_enforcer", "gun_pickup_vo_done", "gun_pickup_vo_done", "scene_gun_pickup");
  level.scr_anim["price"]["scene_dry_fire"] = % stp_wh_020_dryfire_a_price;
  level.scr_anim["price"]["scene_dry_fire_react_1"] = % stp_wh_020_dryfire_react01_trigger_price;
  level.scr_anim["price"]["scene_dry_fire_react_2"] = % stp_wh_020_dryfire_react02_shame_price;
  level.scr_anim["price"]["scene_dry_fire_price"] = % stp_wh_020_dryfire_b_price;
  scripts\common\anim::addnotetrack_notify("price", "bullets_placed", "bullets_placed", "scene_dry_fire");
  scripts\common\anim::addnotetrack_notify("price", "bullets_placed", "bullets_placed", "scene_dry_fire_price");
  level.scr_anim["price"]["offer_bullet_nag_1"] = % stp_wh_020_dryfire_nag01_loadit_price;
  level.scr_anim["price"]["offer_bullet_nag_2"] = % stp_wh_020_dryfire_nag02_putsix_price;
  level.scr_anim["price"]["offer_bullet_nag_3"] = % stp_wh_020_dryfire_nag03_sergeant_price;
  level.scr_anim["price"]["scene_press_02"] = % stp_wh_020_intel_press02_price;
  level.scr_goaltime["price"]["scene_press_02"] = 1.0;
  level.scr_anim["interrogation_mother"]["scene_press_02"] = % stp_wh_020_intel_press02_wife;
  level.scr_anim["interrogation_son"]["scene_press_02"] = % stp_wh_020_intel_press02_child;
  level.scr_anim["interrogation_enforcer"]["scene_press_02"] = % stp_wh_020_intel_press02_butcher;
  level.scr_goaltime["interrogation_enforcer"]["scene_press_02"] = 0.8;
  scripts\common\anim::addnotetrack_customfunction("price", "contextual_exit_vo", ::price_exit_vo, "scene_press_02");
  scripts\common\anim::addnotetrack_notify("price", "price_opens_door", "price_opens_door", "scene_press_02");
  scripts\common\anim::addnotetrack_flag("interrogation_enforcer", "intel_revealed", "intel_revealed", "scene_press_02");
  scripts\common\anim::addnotetrack_notify("interrogation_enforcer", "script_dx_vom_kyle_interrogation_revolver_load_80", "script_dx_vom_kyle_interrogation_revolver_load_80", "scene_press_02");
  scripts\common\anim::addnotetrack_customfunction("interrogation_enforcer", "enforcer_chair_swap", ::enforcer_chair_swap, "scene_press_02");
  level.scr_anim["interrogation_enforcer"]["linger_aim_1"] = % stp_int_chair_defeated_beg01_kill_butcher;
  level.scr_anim["interrogation_enforcer"]["linger_aim_2"] = % stp_int_chair_defeated_beg02_plan_butcher;
  level.scr_anim["interrogation_enforcer"]["linger_aim_3"] = % stp_int_chair_defeated_beg03_go_butcher;
  level.scr_anim["interrogation_enforcer"]["linger_aim_4"] = % stp_int_chair_defeated_beg04_go_butcher;
  level.scr_anim["price"]["hallway_nags"] = % stp_wh_020_intel_success_hallway_nags_price;
  level.scr_anim["price"]["hallway_idle"][0] = % stp_wh_020_intel_success_hallway_idle_price;
  level.scr_anim["price"]["walk_to_car"] = % stp_wh_020_intel_success_hallway_to_car_price;
  level.scr_anim["price"]["car_idle"][0] = % stp_wh_020_intel_success_car_idle_price;
  scripts\common\anim::addnotetrack_customfunction("price", "price_enters_car", ::price_car_enter, "walk_to_car");
  scripts\common\anim::addnotetrack_flag("price", "price_vo_done", "police_car_nag_spoken", "walk_to_car");
  level.scr_anim["nikolai"]["hallway_idle"][0] = % stp_wh_020_intel_success_hallway_idle_nik;
  level.scr_anim["nikolai"]["walk_to_car"] = % stp_wh_020_intel_success_hallway_to_car_nik;
  level.scr_anim["nikolai"]["car_idle"][0] = % stp_wh_020_intel_success_car_idle_nik;
  scripts\common\anim::addnotetrack_customfunction("nikolai", "car_unlock", ::police_car_unlock, "walk_to_car");
  level.scr_anim["price"]["car_nag_1"] = % stp_wh_020_intel_success_car_nag1_price;
  level.scr_anim["price"]["car_nag_2"] = % stp_wh_020_intel_success_car_nag2_price;
  level.scr_anim["price"]["ads_price"] = % stp_wh_020_react_ads_price;
  level.scr_anim["price"]["react_death"] = % stp_wh_020_fail_death_react_price;
  level.scr_anim["interrogation_enforcer"]["interrogation_outro"] = % stp_wh_030_outro_gas_3p_butcher;
  level.scr_anim["interrogation_mother"]["interrogation_outro"] = % stp_wh_030_outro_gas_3p_wife;
  level.scr_anim["interrogation_son"]["interrogation_outro"] = % stp_wh_030_outro_gas_3p_child;
  level.scr_anim["outro_police_1"]["interrogation_outro"] = % stp_wh_030_outro_gas_3p_police01;
  level.scr_anim["outro_police_2"]["interrogation_outro"] = % stp_wh_030_outro_gas_3p_police02;
  level.scr_anim["outro_police_3"]["interrogation_outro"] = % stp_wh_030_outro_gas_3p_police03;
  level.scr_anim["outro_police_4"]["interrogation_outro"] = % stp_wh_030_outro_gas_3p_police04;
  level.scr_anim["interrogation_enforcer"]["idle_interrogate"][0] = % stp_int_chair_enforcer_idle;
  level.scr_anim["interrogation_enforcer"]["idle_interrogate_med"][0] = % stp_wh_010_handoff_butcher_idle;
  level.scr_anim["interrogation_enforcer"]["idle_interrogate_high"][0] = % stp_int_chair_enforcer_grieve_both;
  level.scr_anim["interrogation_enforcer"]["idle_transition"] = % stp_int_chair_enforcer_trans_to_grieve_both;
  level.scr_anim["interrogation_enforcer"]["ads_left_in"] = % stp_int_chair_enforcer_ads_left_in;
  level.scr_anim["interrogation_enforcer"]["ads_left"][0] = % stp_int_chair_enforcer_ads_left_idle;
  level.scr_anim["interrogation_enforcer"]["ads_left_out"] = % stp_int_chair_enforcer_ads_left_out;
  level.scr_anim["interrogation_enforcer"]["ads_center_in"] = % stp_int_chair_enforcer_ads_center_in;
  level.scr_anim["interrogation_enforcer"]["ads_center"][0] = % stp_int_chair_enforcer_ads_center_idle;
  level.scr_anim["interrogation_enforcer"]["ads_center_out"] = % stp_int_chair_enforcer_ads_center_out;
  level.scr_anim["interrogation_enforcer"]["ads_right_in"] = % stp_int_chair_enforcer_ads_right_in;
  level.scr_anim["interrogation_enforcer"]["ads_right"][0] = % stp_int_chair_enforcer_ads_right_idle;
  level.scr_anim["interrogation_enforcer"]["ads_right_out"] = % stp_int_chair_enforcer_ads_right_out;
  level.scr_anim["interrogation_enforcer"]["death_head"] = % stp_int_chair_enforcer_death_head;
  level.scr_goaltime["interrogation_enforcer"]["death_head"] = 0.2;
  level.scr_anim["interrogation_enforcer"]["death_head_idle"][0] = % stp_int_chair_enforcer_death_head_idle;
  level.scr_anim["interrogation_enforcer"]["death"] = % stp_int_chair_enforcer_death_body;
  level.scr_goaltime["interrogation_enforcer"]["death"] = 0.2;
  level.scr_anim["interrogation_enforcer"]["death_idle"][0] = % stp_int_chair_enforcer_death_body_idle;
  level.scr_anim["interrogation_enforcer"]["shot_arm_left"] = % stp_int_chair_enforcer_shot_arm_left;
  level.scr_anim["interrogation_enforcer"]["shot_arm_right"] = % stp_int_chair_enforcer_shot_arm_right;
  level.scr_anim["interrogation_enforcer"]["shot_leg_left"] = % stp_int_chair_enforcer_shot_leg_left;
  level.scr_anim["interrogation_enforcer"]["shot_leg_right"] = % stp_int_chair_enforcer_shot_leg_right;
  level.scr_anim["interrogation_enforcer"]["scene_dry_fire"] = % stp_wh_020_dryfire_a_butcher;
  level.scr_anim["interrogation_enforcer"]["scene_dry_fire_price"] = % stp_wh_020_dryfire_b_butcher;
  level.scr_anim["interrogation_enforcer"]["react_aim_wife"][0] = % stp_int_chair_enforcer_react_pre_ads_mom;
  level.scr_anim["interrogation_enforcer"]["react_ads_wife"][0] = % stp_int_chair_enforcer_react_ads_mom;
  level.scr_anim["interrogation_enforcer"]["react_ads_son"][0] = % stp_int_chair_enforcer_react_ads_son;
  level.scr_anim["interrogation_enforcer"]["react_death_wife"] = % stp_wh_020_fail_death_react_butcher;
  level.scr_anim["interrogation_enforcer"]["grieve_wife_death"][0] = % stp_int_chair_enforcer_grieve_mom;
  level.scr_anim["interrogation_enforcer"]["react_death_son"] = % stp_wh_020_fail_death_react_butcher;
  level.scr_anim["interrogation_enforcer"]["grieve_son_death"][0] = % stp_int_chair_enforcer_grieve_son;
  level.scr_anim["interrogation_enforcer"]["react_death_both"] = % stp_wh_020_fail_death_react_butcher;
  level.scr_anim["interrogation_enforcer"]["grieve_both_death"][0] = % stp_int_chair_enforcer_grieve_both;
  level.scr_anim["interrogation_enforcer"]["whizby_flinch_1"] = % stp_int_chair_enforcer_idle_flinch_01;
  level.scr_anim["interrogation_enforcer"]["whizby_flinch_2"] = % stp_int_chair_enforcer_idle_flinch_02;
  level.scr_anim["interrogation_enforcer"]["dry_fire_flinch"] = % stp_int_chair_enforcer_idle_flinch_03;
  scripts\common\anim::addnotetrack_notify("interrogation_enforcer", "script_dx_vom_kyle_interrogation_revolver_empty_10", "script_dx_vom_kyle_interrogation_revolver_empty_10", "scene_dry_fire");
  scripts\common\anim::addnotetrack_notify("interrogation_enforcer", "script_dx_vom_ousa_interrogation_revolver_empty_80", "script_dx_vom_ousa_interrogation_revolver_empty_80", "scene_dry_fire");
  scripts\common\anim::addnotetrack_notify("interrogation_enforcer", "script_dx_vom_amon_interrogation_revolver_empty_90", "script_dx_vom_amon_interrogation_revolver_empty_90", "scene_dry_fire");
  scripts\common\anim::addnotetrack_notify("interrogation_enforcer", "script_dx_vom_ousa_interrogation_revolver_empty_160", "script_dx_vom_ousa_interrogation_revolver_empty_160", "scene_dry_fire");
  scripts\common\anim::addnotetrack_notify("interrogation_enforcer", "script_dx_vom_ousa_interrogation_revolver_empty_80", "script_dx_vom_ousa_interrogation_revolver_empty_80", "scene_dry_fire_price");
  scripts\common\anim::addnotetrack_notify("interrogation_enforcer", "script_dx_vom_amon_interrogation_revolver_empty_90", "script_dx_vom_amon_interrogation_revolver_empty_90", "scene_dry_fire_price");
  scripts\common\anim::addnotetrack_notify("interrogation_enforcer", "script_dx_vom_ousa_interrogation_revolver_empty_160", "script_dx_vom_ousa_interrogation_revolver_empty_160", "scene_dry_fire_price");
  level.scr_anim["interrogation_mother"]["idle_interrogate"][0] = % stp_int_chair02_mother_idle;
  level.scr_anim["interrogation_mother"]["idle_interrogate_high"][0] = % stp_int_chair02_mother_idle_high;
  level.scr_anim["interrogation_mother"]["whizby_1"] = % stp_int_chair02_mother_idle_high_interrupt_01;
  level.scr_anim["interrogation_mother"]["whizby_2"] = % stp_int_chair02_mother_idle_high_interrupt_02;
  level.scr_anim["interrogation_mother"]["whizby_3"] = % stp_int_chair02_mother_idle_high_interrupt_03;
  level.scr_anim["interrogation_mother"]["whizby_4"] = % stp_int_chair02_mother_idle_high_interrupt_04;
  level.scr_anim["interrogation_mother"]["whizby_single"] = % stp_int_chair02_mother_idle_to_idle_high;
  level.scr_anim["interrogation_mother"]["death_head"] = % stp_wh_020_fail_death_wife_head_wife;
  level.scr_anim["interrogation_mother"]["death"] = % stp_wh_020_fail_death_wife_body_wife;
  level.scr_anim["interrogation_mother"]["react_death_son"] = % stp_wh_020_fail_death_child_head_wife;
  level.scr_anim["interrogation_mother"]["grieve_son_death"][0] = % stp_int_chair02_mother_grieve_son;
  level.scr_anim["interrogation_mother"]["react_death_enforcer"] = % stp_int_chair02_mother_idle_to_idle_high;
  level.scr_anim["interrogation_mother"]["grieve_enforcer_death"][0] = % stp_int_chair02_mother_idle_high;
  level.scr_anim["interrogation_son"]["idle_interrogate"][0] = % stp_int_chair02_son_idle;
  level.scr_anim["interrogation_son"]["idle_interrogate_high"][0] = % stp_int_chair02_son_idle_high;
  level.scr_anim["interrogation_son"]["whizby_1"] = % stp_int_chair02_son_idle_high_interrupt_01;
  level.scr_anim["interrogation_son"]["whizby_2"] = % stp_int_chair02_son_idle_high_interrupt_02;
  level.scr_anim["interrogation_son"]["whizby_3"] = % stp_int_chair02_son_idle_high_interrupt_03;
  level.scr_anim["interrogation_son"]["whizby_4"] = % stp_int_chair02_son_idle_high_interrupt_04;
  level.scr_anim["interrogation_son"]["whizby_single"] = % stp_int_chair02_son_idle_to_idle_high;
  level.scr_anim["interrogation_son"]["death_head"] = % stp_wh_020_fail_death_child_head_child;
  level.scr_anim["interrogation_son"]["death"] = % stp_wh_020_fail_death_child_head_child;
  level.scr_anim["interrogation_son"]["react_death_mother_head"] = % stp_wh_020_fail_death_wife_head_child;
  level.scr_anim["interrogation_son"]["react_death_mother"] = % stp_wh_020_fail_death_wife_body_child;
  level.scr_anim["interrogation_son"]["grieve_mother_death"][0] = % stp_int_chair02_son_grieve_mom;
  level.scr_anim["interrogation_son"]["react_death_enforcer"] = % stp_int_chair02_son_idle_to_idle_high;
  level.scr_anim["interrogation_son"]["grieve_enforcer_death"][0] = % stp_int_chair02_son_idle_high;
  level.scr_anim["interrogation_son"]["death_head_first"] = % stp_int_chair02_son_death_head_first;
  level.scr_anim["interrogation_son"]["death_first"] = % stp_int_chair02_son_death_body_first;
  level.scr_anim["interrogation_son"]["death_held_idle"][0] = % stp_int_chair02_son_death_held_idle;
  level.scr_anim["interrogation_son"]["death_fall"] = % stp_int_chair02_son_death_fall;
  level.scr_face["interrogation_enforcer"]["dx_vom_enf_interrogation_revolver_aim_20"] = % dx_vom_enf_interrogation_revolver_aim_20_face;
  level.scr_face["interrogation_enforcer"]["dx_vom_enf_interrogation_revolver_aim_30"] = % dx_vom_enf_interrogation_revolver_aim_30_face;
  level.scr_face["interrogation_enforcer"]["dx_vom_enf_interrogation_revolver_aim_40"] = % dx_vom_enf_interrogation_revolver_aim_40_face;
  level.scr_face["interrogation_enforcer"]["dx_vom_enf_interrogation_revolver_aim_50"] = % dx_vom_enf_interrogation_revolver_aim_50_face;
  level.scr_face["interrogation_enforcer"]["dx_vom_enf_interrogation_revolver_aim_80"] = % dx_vom_enf_interrogation_revolver_aim_80_face;
  level.scr_face["interrogation_enforcer"]["dx_vom_enf_interrogation_revolver_ads_kid_10"] = % dx_vom_enf_interrogation_revolver_ads_kid_10_face;
  level.scr_face["interrogation_enforcer"]["dx_vom_enf_interrogation_revolver_aim_150"] = % dx_vom_enf_interrogation_revolver_aim_150_face;
  level.scr_face["interrogation_enforcer"]["dx_vom_enf_interrogation_revolver_aim_170"] = % dx_vom_enf_interrogation_revolver_aim_170_face;
  level.scr_face["interrogation_enforcer"]["dx_vom_enf_interrogation_revolver_aim_220"] = % dx_vom_enf_interrogation_revolver_aim_220_face;
  level.scr_face["interrogation_enforcer"]["dx_vom_enf_interrogation_revolver_testfire_100"] = % dx_vom_enf_interrogation_revolver_testfire_100_face;
  level.scr_face["interrogation_enforcer"]["dx_vom_enf_interrogation_revolver_testfire_110"] = % dx_vom_enf_interrogation_revolver_testfire_110_face;
  level.scr_face["interrogation_enforcer"]["dx_vom_enf_interrogation_revolver_linger_30"] = % dx_vom_enf_interrogation_revolver_linger_30_face;
  level.scr_face["interrogation_enforcer"]["dx_vom_enf_interrogation_revolver_linger_80"] = % dx_vom_enf_interrogation_revolver_linger_80_face;
  level.scr_face["interrogation_enforcer"]["dx_vom_enf_interrogation_revolver_linger_100"] = % dx_vom_enf_interrogation_revolver_linger_100_face;
  level.scr_face["price"]["dx_vom_pri_interrogation_revolver_aim_180"] = % dx_vom_pri_interrogation_revolver_aim_180_face;
  level.scr_face["price"]["dx_vom_pri_interrogation_revolver_aim_190"] = % dx_vom_pri_interrogation_revolver_aim_190_face;
  level.scr_face["price"]["dx_vom_pri_interrogation_revolver_aim_200"] = % dx_vom_pri_interrogation_revolver_aim_200_face;
  level.scr_face["price"]["dx_vom_pri_interrogation_revolver_aim_210"] = % dx_vom_pri_interrogation_revolver_aim_210_face;
  level.scr_face["price"]["dx_vom_pri_interrogation_revolver_ads_price_10"] = % dx_vom_pri_interrogation_revolver_ads_price_10;
  level.scr_face["price"]["dx_vom_pri_interrogation_revolver_ads_price_20"] = % dx_vom_pri_interrogation_revolver_ads_price_20;
  level.scr_face["price"]["dx_vom_pri_interrogation_revolver_ads_price_30"] = % dx_vom_pri_interrogation_revolver_ads_price_30;
  level.scr_face["price"]["dx_vom_pri_interrogation_revolver_testfire_70"] = % dx_vom_pri_interrogation_revolver_testfire_70_face;
  level.scr_face["price"]["dx_vom_pri_interrogation_revolver_testfire_80"] = % dx_vom_pri_interrogation_revolver_testfire_80_face;
  level.scr_face["price"]["dx_vom_pri_interrogation_revolver_testfire_90"] = % dx_vom_pri_interrogation_revolver_testfire_90_face;
  level.scr_face["price"]["dx_vom_pri_interrogation_revolver_testfire_120"] = % dx_vom_pri_interrogation_revolver_testfire_120_face;
  level.scr_face["price"]["dx_vom_pri_stakeout_exit_80"] = % dx_vom_pri_stakeout_exit_80_face;
  level.scr_face["price"]["dx_vom_pri_stakeout_exit_190"] = % dx_vom_pri_stakeout_exit_190_face;
  level.scr_face["price"]["dx_vom_pri_alley_stealth_permits_110"] = % dx_vom_pri_alley_stealth_permits_110_face;
  level.scr_face["price"]["dx_vom_pri_alley_stealth_permits_120"] = % dx_vom_pri_alley_stealth_permits_120_face;
  level.scr_face["price"]["dx_vom_pri_alley_stealth_permits_150"] = % dx_vom_pri_alley_stealth_permits_150_face;
  level.scr_face["price"]["dx_vom_pri_alley_stealth_permits_160"] = % dx_vom_pri_alley_stealth_permits_160_face;
  level.scr_face["price"]["dx_vom_pri_bar_backroom_meeting_110"] = % dx_vom_pri_bar_backroom_meeting_110_face;
  level.scr_face["price"]["dx_vom_pri_bar_backroom_meeting_140"] = % dx_vom_pri_bar_backroom_meeting_140_face;
  level.scr_face["price"]["dx_vom_pri_acquire_street_80"] = % dx_vom_pri_acquire_street_80_face;
  level.scr_face["nikolai"]["dx_vom_nik_acquire_street_30"] = % dx_vom_nik_acquire_street_30_face;
  level.scr_face["nikolai"]["dx_vom_nik_interrogation_intro_family_10"] = % dx_vom_nik_stpetersburg_interrogation_intro_family_10_face;
  level.scr_face["nikolai"]["dx_vom_nik_interrogation_intro_family_30"] = % dx_vom_nik_stpetersburg_interrogation_intro_family_30_face;
  level.scr_face["nikolai"]["dx_vom_nik_interrogation_intro_family_40"] = % dx_vom_nik_stpetersburg_interrogation_intro_family_40_face;
  level.scr_face["nikolai"]["dx_vom_nik_interrogation_intro_family_45"] = % dx_vom_nik_stpetersburg_interrogation_intro_family_45_face;
  level.scr_face["nikolai"]["dx_vom_nik_interrogation_intro_family_60"] = % dx_vom_nik_stpetersburg_interrogation_intro_family_60_face;
  level.scr_face["nikolai"]["dx_vom_nik_interrogation_intro_family_65"] = % dx_vom_nik_stpetersburg_interrogation_intro_family_65_face;
  level.scr_face["nikolai"]["dx_vom_nik_interrogation_intro_family_50"] = % dx_vom_nik_stpetersburg_interrogation_intro_family_50_face;
  level.scr_face["nikolai"]["dx_vom_nik_interrogation_intro_family_55"] = % dx_vom_nik_stpetersburg_interrogation_intro_family_55_face;
  level.scr_face["nikolai"]["dx_vom_nik_interrogation_intro_family_130"] = % dx_vom_nik_stpetersburg_interrogation_intro_family_130_face;
  level.scr_face["nikolai"]["dx_vom_nik_interrogation_intro_family_140"] = % dx_vom_nik_stpetersburg_interrogation_intro_family_140_face;
  level.scr_face["nikolai"]["dx_vom_nik_interrogation_intro_family_135"] = % dx_vom_nik_stpetersburg_interrogation_intro_family_135_face;
  level.scr_face["nikolai"]["dx_vom_nik_interrogation_intro_family_145"] = % dx_vom_nik_stpetersburg_interrogation_intro_family_145_face;
  level.scr_face["nikolai"]["dx_vom_nik_interrogation_intro_family_160"] = % dx_vom_nik_stpetersburg_interrogation_intro_family_160_face;
  level.scr_face["nikolai"]["dx_vom_nik_interrogation_intro_family_170"] = % dx_vom_nik_stpetersburg_interrogation_intro_family_170_face;
  level.scr_face["nikolai"]["dx_vom_nik_interrogation_intro_family_180"] = % dx_vom_nik_stpetersburg_interrogation_intro_family_180_face;
  level.scr_face["nikolai"]["dx_vom_nik_interrogation_intro_family_190"] = % dx_vom_nik_stpetersburg_interrogation_intro_family_190_face;
  level.scr_face["nikolai"]["dx_vom_nik_interrogation_intro_family_175"] = % dx_vom_nik_stpetersburg_interrogation_intro_family_175_face;
  level.scr_face["nikolai"]["dx_vom_nik_interrogation_intro_family_185"] = % dx_vom_nik_stpetersburg_interrogation_intro_family_185_face;
  level.scr_face["nikolai"]["dx_vom_nik_interrogation_intro_family_195"] = % dx_vom_nik_stpetersburg_interrogation_intro_family_195_face;
  level.scr_face["interrogation_mother"]["dx_vom_ousa_interrogation_intro_family_70"] = % dx_vom_ousa_interrogation_intro_family_70_face;
  level.scr_face["interrogation_mother"]["dx_vom_ousa_interrogation_intro_family_120"] = % dx_vom_ousa_interrogation_intro_family_120_face;
  level.scr_face["interrogation_mother"]["dx_vom_ousa_interrogation_intro_family_162"] = % dx_vom_ousa_interrogation_intro_family_162_face;
  level.scr_face["interrogation_mother"]["dx_vom_ousa_interrogation_intro_family_163"] = % dx_vom_ousa_interrogation_intro_family_163_face;
  level.scr_face["interrogation_mother"]["dx_vom_ousa_interrogation_intro_family_164"] = % dx_vom_ousa_interrogation_intro_family_164_face;
  level.scr_face["interrogation_mother"]["dx_vom_ousa_interrogation_intro_family_165"] = % dx_vom_ousa_interrogation_intro_family_165_face;
  level.scr_face["interrogation_mother"]["dx_vom_ousa_interrogation_intro_family_166"] = % dx_vom_ousa_interrogation_intro_family_166_face;
  level.scr_face["interrogation_mother"]["dx_vom_ousa_interrogation_intro_family_210"] = % dx_vom_ousa_interrogation_intro_family_210_face;
  level.scr_face["interrogation_mother"]["dx_vom_ousa_interrogation_intro_family_220"] = % dx_vom_ousa_interrogation_intro_family_220_face;
  level.scr_face["interrogation_mother"]["dx_vom_ousa_interrogation_intro_family_240"] = % dx_vom_ousa_interrogation_intro_family_240_face;
  level.scr_face["interrogation_mother"]["dx_vom_amon_interrogation_intro_family_100"] = % dx_vom_amon_interrogation_intro_family_100_face;
  level.scr_face["interrogation_mother"]["dx_vom_amon_interrogation_intro_family_200"] = % dx_vom_amon_interrogation_intro_family_200_face;
}

#using_animtree("script_model");

script_models() {
  level.scr_animtree["guncase"] = #animtree;
  level.scr_model["guncase"] = "prop_storage_pelican_case_rifle_01";
  level.scr_anim["guncase"]["intro_scene"] = % stp_bar_010_stakeout_bedroom_to_kitchen_guncase;
  level.scr_anim["guncase"]["intro_scene2"] = % stp_bar_010_stakeout_bedroom_to_kitchen_guncase2;
  level.scr_animtree["stealth_door"] = #animtree;
  level.scr_model["stealth_door"] = "door_wood_double_b_r_01_brown_sp";
  level.scr_anim["door"]["stealth_alley_intro"] = % stp_bar_010_alley_intro_door;
  level.scr_animtree["door"] = #animtree;
  level.scr_model["door"] = "uk_house_door_interior_01_old_36w_r";
  level.scr_anim["door"]["stakeout_kitchen_exit"] = % stp_bar_010_stakeout_kitchen_door_open_door;
  level.scr_anim["door"]["stakeout_door_close"] = % stp_bar_010_stakeout_kitchen_door_close_door;
  level.scr_animtree["apt_grenade"] = #animtree;
  level.scr_model["apt_grenade"] = "frag_grenade_prop_no_lod";
  level.scr_anim["apt_grenade"]["stp_apt_grenade_loop"][0] = % stp_apt_grenade_grenade_idle;
  level.scr_anim["apt_grenade"]["stp_apt_grenade_outro"] = % stp_apt_grenade_grenade_explosion;
  level.scr_animtree["door"] = #animtree;
  level.scr_model["door"] = "uk_house_door_exterior_01_36w_l";
  level.scr_anim["door"]["evade_cafe_door01"] = % stp_cafe_escape_scene_door01;
  level.scr_anim["door"]["evade_cafe_door02"] = % stp_cafe_escape_scene_door02;
  level.scr_anim["door"]["evade_cafe_door03"] = % stp_cafe_escape_scene_door03;
  level.scr_anim["door"]["evade_cafe_door04"] = % stp_cafe_escape_scene_door04;
  level.scr_animtree["interrogation_door"] = #animtree;
  level.scr_anim["interrogation_door"]["interrogation_intro"] = % stp_wh_010_intro3p_door;
  level.scr_anim["interrogation_door"]["door_open"] = % stp_wh_010_enter_door;
  level.scr_anim["interrogation_door"]["warning_accept"] = % stp_wh_010_enter_pcap_proceed_door;
  level.scr_anim["interrogation_door"]["warning_decline"] = % stp_wh_010_enter_decline_door;
  level.scr_anim["interrogation_door"]["decline_exit"] = % stp_wh_010_exit_decline_door;
  level.scr_anim["interrogation_door"]["scene_press_02"] = % stp_wh_020_intel_press02_door01;
  level.scr_anim["interrogation_door"]["interrogation_outro"] = % stp_wh_030_outro_gas_3p_door;
  level.scr_animtree["bullets"] = #animtree;
  level.scr_anim["bullets"]["dry_fire_bullet_1"] = % stp_wh_020_dryfire_bullet01;
  level.scr_anim["bullets"]["dry_fire_bullet_2"] = % stp_wh_020_dryfire_bullet02;
  level.scr_anim["bullets"]["dry_fire_bullet_3"] = % stp_wh_020_dryfire_bullet03;
  level.scr_anim["bullets"]["dry_fire_bullet_4"] = % stp_wh_020_dryfire_bullet04;
  level.scr_anim["bullets"]["dry_fire_bullet_5"] = % stp_wh_020_dryfire_bullet05;
  level.scr_anim["bullets"]["dry_fire_bullet_6"] = % stp_wh_020_dryfire_bullet06;
  scripts\common\anim::addnotetrack_customfunction("bullets", "unhide_bullet", ::bullet_show);
  level.scr_animtree["garage_door"] = #animtree;
  level.scr_anim["garage_door"]["garage_door_open"] = % stp_wh_010_acquire_door;
  level.scr_animtree["interrogation_side_door"] = #animtree;
  level.scr_anim["interrogation_side_door"]["family_handoff"] = % stp_wh_010_handoff_door_side;
  level.scr_animtree["interrogation_chair_enforcer"] = #animtree;
  level.scr_anim["interrogation_chair_enforcer"]["chair_idle"][0] = % stp_int_chair_idle;
  level.scr_anim["interrogation_chair_enforcer"]["chair_idle_high"][0] = % stp_int_chair_idle_high;
  level.scr_anim["interrogation_chair_enforcer"]["scene_press_02"] = % stp_wh_020_intel_press02_chair;
  level.scr_animtree["interrogation_chair_family"] = #animtree;
  level.scr_anim["interrogation_chair_family"]["chair_idle"][0] = % stp_int_chair02_idle;
  level.scr_anim["interrogation_chair_family"]["chair_idle_high"][0] = % stp_int_chair02_idle_high;
  level.scr_anim["interrogation_chair_family"]["whizby_single"] = % stp_int_chair02_idle_to_idle_high;
  level.scr_anim["interrogation_chair_family"]["whizby_1"] = % stp_int_chair02_idle_high_interrupt_01;
  level.scr_anim["interrogation_chair_family"]["whizby_2"] = % stp_int_chair02_idle_high_interrupt_02;
  level.scr_anim["interrogation_chair_family"]["death_head_wife"] = % stp_wh_020_fail_death_wife_head_chair02;
  level.scr_anim["interrogation_chair_family"]["death_wife"] = % stp_wh_020_fail_death_wife_body_chair02;
  level.scr_anim["interrogation_chair_family"]["death_head_son"] = % stp_wh_020_fail_death_child_head_chair02;
  level.scr_anim["interrogation_chair_family"]["death_son"] = % stp_wh_020_fail_death_child_head_chair02;
  level.scr_anim["interrogation_chair_family"]["room_enter"] = % stp_wh_010_enter_pcap_proceed_chair;
  level.scr_anim["interrogation_chair_family"]["family_handoff"] = % stp_wh_010_handoff_chair;
  level.scr_animtree["escort_ref"] = #animtree;
  level.scr_anim["escort_ref"]["escort_idle"][0] = % stp_wh_010_escort_mech_idle_vm_cam;
  level.scr_anim["escort_ref"]["escort_sway_in"] = % stp_wh_010_escort_mech_idle_in_vm_cam;
  level.scr_anim["escort_ref"]["escort_sway"][0] = % stp_wh_010_escort_mech_walk8_vm_cam;
  level.scr_anim["escort_ref"]["escort_sway_out"] = % stp_wh_010_escort_mech_idle_out_vm_cam;
  level.scr_animtree["apt_hallway_door"] = #animtree;
  level.scr_anim["apt_hallway_door"]["apt_hallway_flee"] = % stp_apt_hallway_mother_child_open_door;
  level.scr_animtree["intro_stakeout_bag"] = #animtree;
  level.scr_model["intro_stakeout_bag"] = "prop_un_military_duffle_bag_01";
  level.scr_anim["intro_stakeout_bag"]["stakeout_bedroom_intro"] = % stp_bar_010_stakeout_intro_bag;
  level.scr_anim["intro_stakeout_bag"]["stakeout_bedroom_idle"][0] = % stp_bar_010_stakeout_door_idle_bag;
  level.scr_anim["intro_stakeout_bag"]["stakeout_bedroom_bag_remove"] = % stp_bar_010_stakeout_remove_bag;
  level.scr_animtree["binocs"] = #animtree;
  level.scr_model["binocs"] = "misc_wm_spotter_scope";
  level.scr_anim["binocs"]["intro_scene"] = % stp_bar_010_intro_scene_binocs;
  level.scr_goaltime["binocs"]["intro_scene"] = 0.05;
  level.scr_anim["binocs"]["intro_scene2"] = % stp_bar_010_intro_scene_binocs2;
  level.scr_goaltime["binocs"]["intro_scene2"] = 0.05;
  level.scr_anim["binocs"]["stakeout_bedroom_to_kitchen"] = % stp_bar_010_stakeout_bedroom_to_kitchen_binoculars;
}

#using_animtree("vehicles");

vehicles() {
  level.scr_animtree["van"] = #animtree;
  level.scr_anim["van"]["acquire_intro"] = % stp_wh_010_acquire_van;
  level.scr_anim["van"]["acquire_open"] = % stp_wh_010_acquire_van_interact_door;
  level.scr_anim["van"]["acquire_idle"][0] = % stp_wh_010_acquire_van_idle;
  level.scr_anim["van"]["decline_exit"] = % stp_wh_010_exit_decline_van;
  level.scr_anim["van"]["walk_to_car"] = % stp_wh_020_intel_success_van;
  scripts\common\anim::addnotetrack_customfunction("van", "brake_on", ::van_brakelights_on, "acquire_intro");
  scripts\common\anim::addnotetrack_customfunction("van", "brake_off", ::van_brakelights_off, "acquire_intro");
  level.scr_animtree["skilo"] = #animtree;
  level.scr_anim["skilo"]["decline_exit"] = % stp_wh_010_exit_decline_car;
  level.scr_anim["skilo"]["walk_to_car"] = % stp_wh_020_intel_success_car;
  level.scr_anim["skilo"]["car_interact_left"] = % stp_wh_020_exit_interact_left_car;
  level.scr_anim["skilo"]["car_interact_right"] = % stp_wh_020_exit_interact_right_car;
  level.scr_anim["skilo"]["stp_gauntlet_shootout_010_AQ_fight_arrive_VehA"] = % stp_gauntlet_shootout_010_aq_fight_arrive_veha;
  scripts\common\anim::addnotetrack_notify("skilo", "front_right_splash_on", "vehA_front_right_splash_on", "stp_gauntlet_shootout_010_AQ_fight_arrive_VehA");
  scripts\common\anim::addnotetrack_notify("skilo", "front_right_splash_off", "vehA_front_right_splash_off", "stp_gauntlet_shootout_010_AQ_fight_arrive_VehA");
  scripts\common\anim::addnotetrack_notify("skilo", "back_right_splash_on", "vehA_back_right_splash_on", "stp_gauntlet_shootout_010_AQ_fight_arrive_VehA");
  scripts\common\anim::addnotetrack_notify("skilo", "back_right_splash_off", "vehA_back_right_splash_off", "stp_gauntlet_shootout_010_AQ_fight_arrive_VehA");
  scripts\common\anim::addnotetrack_notify("skilo", "front_left_splash_on", "vehA_front_left_splash_on", "stp_gauntlet_shootout_010_AQ_fight_arrive_VehA");
  scripts\common\anim::addnotetrack_notify("skilo", "front_left_splash_off", "vehA_front_left_splash_off", "stp_gauntlet_shootout_010_AQ_fight_arrive_VehA");
  scripts\common\anim::addnotetrack_notify("skilo", "front_left_splash02_on", "vehA_front_left_splash02_on", "stp_gauntlet_shootout_010_AQ_fight_arrive_VehA");
  scripts\common\anim::addnotetrack_notify("skilo", "front_left_splash02_off", "vehA_front_left_splash02_off", "stp_gauntlet_shootout_010_AQ_fight_arrive_VehA");
  scripts\common\anim::addnotetrack_notify("skilo", "back_left_splash_on", "vehA_back_left_splash_on", "stp_gauntlet_shootout_010_AQ_fight_arrive_VehA");
  scripts\common\anim::addnotetrack_notify("skilo", "back_left_splash_off", "vehA_back_left_splash_off", "stp_gauntlet_shootout_010_AQ_fight_arrive_VehA");
  scripts\common\anim::addnotetrack_notify("skilo", "front_right_dust_on", "vehA_front_right_dust_on", "stp_gauntlet_shootout_010_AQ_fight_arrive_VehA");
  scripts\common\anim::addnotetrack_notify("skilo", "front_right_dust_off", "vehA_front_right_dust_off", "stp_gauntlet_shootout_010_AQ_fight_arrive_VehA");
  scripts\common\anim::addnotetrack_notify("skilo", "back_right_dust_on", "vehA_back_right_dust_on", "stp_gauntlet_shootout_010_AQ_fight_arrive_VehA");
  scripts\common\anim::addnotetrack_notify("skilo", "back_right_dust_off", "vehA_back_right_dust_off", "stp_gauntlet_shootout_010_AQ_fight_arrive_VehA");
  scripts\common\anim::addnotetrack_notify("skilo", "front_left_dust_on", "vehA_front_left_dust_on", "stp_gauntlet_shootout_010_AQ_fight_arrive_VehA");
  scripts\common\anim::addnotetrack_notify("skilo", "front_left_dust_off", "vehA_front_left_dust_off", "stp_gauntlet_shootout_010_AQ_fight_arrive_VehA");
  scripts\common\anim::addnotetrack_notify("skilo", "back_left_dust_on", "vehA_back_left_dust_on", "stp_gauntlet_shootout_010_AQ_fight_arrive_VehA");
  scripts\common\anim::addnotetrack_notify("skilo", "back_left_dust_off", "vehA_back_left_dust_off", "stp_gauntlet_shootout_010_AQ_fight_arrive_VehA");
  level.scr_anim["skilo"]["stp_gauntlet_shootout_010_AQ_fight_arrive_VehB"] = % stp_gauntlet_shootout_010_aq_fight_arrive_vehb;
  scripts\common\anim::addnotetrack_notify("skilo", "back_right_dust_on", "vehB_back_right_dust_on", "stp_gauntlet_shootout_010_AQ_fight_arrive_VehB");
  scripts\common\anim::addnotetrack_notify("skilo", "back_right_dust_off", "vehB_back_right_dust_off", "stp_gauntlet_shootout_010_AQ_fight_arrive_VehB");
  scripts\common\anim::addnotetrack_notify("skilo", "back_left_dust_on", "vehB_back_left_dust_on", "stp_gauntlet_shootout_010_AQ_fight_arrive_VehB");
  scripts\common\anim::addnotetrack_notify("skilo", "back_left_dust_off", "vehB_back_left_dust_off", "stp_gauntlet_shootout_010_AQ_fight_arrive_VehB");
  level.scr_animtree["decho"] = #animtree;
  level.scr_anim["decho"]["fr_door_open"] = % reb_com_veh8_decho_fr_door_open;
  level.scr_anim["decho"]["fl_door_open"] = % reb_com_veh8_decho_fl_door_open;
  level.scr_anim["decho"]["stp_gauntlet_shootout_010_AQ_fight_arrive_VehC"] = % stp_gauntlet_shootout_010_aq_fight_arrive_vehc;
  scripts\common\anim::addnotetrack_notify("decho", "front_right_dust_on", "vehC_front_right_dust_on", "stp_gauntlet_shootout_010_AQ_fight_arrive_VehC");
  scripts\common\anim::addnotetrack_notify("decho", "front_right_dust_off", "vehC_front_right_dust_off", "stp_gauntlet_shootout_010_AQ_fight_arrive_VehC");
  scripts\common\anim::addnotetrack_notify("decho", "back_right_dust_on", "vehC_back_right_dust_on", "stp_gauntlet_shootout_010_AQ_fight_arrive_VehC");
  scripts\common\anim::addnotetrack_notify("decho", "back_right_dust_off", "vehC_back_right_dust_off", "stp_gauntlet_shootout_010_AQ_fight_arrive_VehC");
  scripts\common\anim::addnotetrack_notify("decho", "front_left_dust_on", "vehC_front_left_dust_on", "stp_gauntlet_shootout_010_AQ_fight_arrive_VehC");
  scripts\common\anim::addnotetrack_notify("decho", "front_left_dust_off", "vehC_front_left_dust_off", "stp_gauntlet_shootout_010_AQ_fight_arrive_VehC");
  scripts\common\anim::addnotetrack_notify("decho", "back_left_dust_on", "vehC_back_left_dust_on", "stp_gauntlet_shootout_010_AQ_fight_arrive_VehC");
  scripts\common\anim::addnotetrack_notify("decho", "back_left_dust_off", "vehC_back_left_dust_off", "stp_gauntlet_shootout_010_AQ_fight_arrive_VehC");
  level.scr_animtree["techo"] = #animtree;
  level.scr_anim["techo"]["intro_scene"] = % stp_bar_010_intro_scene_vehicle;
  level.scr_goaltime["techo"]["intro_scene"] = 0.05;
  scripts\common\anim::addnotetrack_customfunction("techo", "brake_on", ::car_brakelights_on, "intro_scene");
  scripts\common\anim::addnotetrack_customfunction("techo", "brake_off", ::car_brakelights_off, "intro_scene");
  level.scr_animtree["civdeathcars_walfa01"] = #animtree;
  level.scr_model["civdeathcars_walfa01"] = "veh8_civ_lnd_walfa";
  level.scr_anim["civdeathcars_walfa01"]["canal_civs_flee_car"] = % stp_can_020_civdeathcars_walfa01;
  level.scr_animtree["onlookers_walfa01"] = #animtree;
  level.scr_model["onlookers_walfa01"] = "veh8_civ_lnd_walfa";
  level.scr_anim["onlookers_walfa01"]["canal_civs_onlookers_car"] = % stp_can_020_civdeathcars_walfa01;
  level.scr_animtree["ambulance"] = #animtree;
  level.scr_anim["ambulance"]["canal_civs_flee_ambulance"] = % stp_can_020_street_civs_flee_ambulance;
}

price_pistol_pickup(var_0) {
  var_1 = getEnt("price_gun_pickup", "targetname");
  var_1 hide();
  level.price scripts\common\ai::gun_recall();
}

price_ammo_pickup(var_0) {
  var_1 = getEnt("intro_stakeout_loot_ammo", "targetname");
  var_1 hide();
}

price_bottom_stairs(var_0) {
  scripts\engine\utility::flag_set("flag_alley_stealth_price_bottom_stairs");
}

blind_fire(var_0) {
  var_1 = var_0 gettagorigin(getweaponflashtagname(var_0));
  var_2 = var_0 gettagangles(getweaponflashtagname(var_0));
  var_3 = var_1 + anglesToForward(var_2) * 1000;
  var_4 = 0;
  var_5 = 10;
  var_6 = scripts\engine\utility::getStruct("bar_enforcer_blindfire_target", "targetname");
  playFXOnTag(scripts\engine\utility::getfx("vfx_muz_ar_w"), var_0, getweaponflashtagname(var_0));

  if(scripts\engine\utility::cointoss()) {
    var_3 = var_6.origin;
    var_5 = 1;
  }

  magicbullet("iw8_ar_akilo47", var_1, var_3 + scripts\engine\utility::randomvectorrange(var_4, var_5), level.enforcer);
}

camera_fov_change(var_0) {}

car_brakelights_on(var_0) {
  var_1 = getEnt("stakeout_enforcer_truck", "targetname");
  playFXOnTag(scripts\engine\utility::getfx("vfx_stpburg_brake_lights_truck"), var_1, "tag_hood");
}

car_brakelights_off(var_0) {
  var_1 = getEnt("stakeout_enforcer_truck", "targetname");
  stopFXOnTag(scripts\engine\utility::getfx("vfx_stpburg_brake_lights_truck"), var_1, "tag_hood");
}

van_brakelights_on(var_0) {
  playFXOnTag(scripts\engine\utility::getfx("vfx_stpburg_tail_lights_utility_van"), level.nikolaivan, "tag_hood");
}

van_brakelights_off(var_0) {
  stopFXOnTag(scripts\engine\utility::getfx("vfx_stpburg_backup_lights_utility_van"), level.nikolaivan, "tag_hood");
  wait 0.25;
  stopFXOnTag(scripts\engine\utility::getfx("vfx_stpburg_tail_lights_utility_van"), level.nikolaivan, "tag_hood");
}

police_car_unlock(var_0) {
  level thread scripts\engine\sp\utility::notify_delay("car_unlock", 1);
  playFXOnTag(scripts\engine\utility::getfx("car_unlock_fx"), level.policecar, "tag_origin");
  wait 0.2;
  killfxontag(scripts\engine\utility::getfx("car_unlock_fx"), level.policecar, "tag_origin");
  wait 0.2;
  playFXOnTag(scripts\engine\utility::getfx("car_unlock_fx"), level.policecar, "tag_origin");
  wait 0.2;
  killfxontag(scripts\engine\utility::getfx("car_unlock_fx"), level.policecar, "tag_origin");
}

price_gun_remove(var_0) {
  level.price scripts\common\ai::gun_remove();
}

price_gun_recall(var_0) {
  level.price scripts\common\ai::gun_recall();
}

price_gun_fire(var_0) {
  var_1 = getcompleteweaponname("iw8_pi_golf21", ["silencerpstl_west01"]);
  var_2 = level.price gettagorigin(getweaponflashtagname(var_1));
  var_3 = level.price gettagangles(getweaponflashtagname(var_1));
  var_4 = var_2 + anglesToForward(var_3) * 100;
  magicbullet(var_1, var_2, var_4, level.price);
  playFXOnTag(scripts\engine\utility::getfx("vfx_muz_pis_w"), level.price, getweaponflashtagname(var_1));
}

price_place_revolver(var_0) {
  level.price scripts\common\ai::gun_recall();
}

bullet_show(var_0) {
  var_0 show();
}

nikolai_acquire_intro_vo(var_0) {
  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_nikolai("Sergeant Garrick. Package is in back.", "dx_vom_nik_interrogation_intro_family_10");
}

price_exit_vo(var_0) {
  var_1 = "dx_vom_pri_interrogation_revolver_ads_butcher_50";

  if(scripts\engine\utility::flag("enforcer_dead"))
    var_1 = "dx_vom_pri_interrogation_revolver_ads_butcher_51";

  scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::add_dialogue_line_price("We are leaving", var_1);
}

price_car_enter(var_0) {
  scripts\sp\maps\stpetersburg\stpetersburg_vo.gsc::vo_interrogation_exit_nags();
}

sfx_bar_escape_door(var_0) {
  thread scripts\engine\utility::play_sound_in_space("stp_bar_escape_exit_enforcer_door", (740, -2998, 16));
}

interrogation_remove_fov_user_scale(var_0) {
  level.player modifybasefov(55, 1);
  wait 1;
  level.player lerpfovscalefactor(1, 2);
}

intro_camera_letterbox_end(var_0) {
  level notify("cine_letterboxing");
}

camera_intro_dof_on(var_0) {
  scripts\engine\utility::flag_set("camera_intro_dof_on");
}

camera_intro_dof_rack(var_0) {
  scripts\engine\utility::flag_set("camera_intro_dof_rack");
}

camera_intro_dof_off(var_0) {
  scripts\engine\utility::flag_set("camera_intro_dof_off");
}

camera_intro_fov_start(var_0) {
  level.player lerpfov(65.0, 2.8);
}

van_restore_user_fov(var_0) {
  level.player lerpfovscalefactor(1, 0.5);
}

van_stop_vo(var_0) {
  level.enforcerwife stopsounds();
}

enforcer_chair_swap(var_0) {
  level.enforcerchair setModel("ee_furniture_chair_wooden_interrogation");
}

pc_force_fov(var_0) {
  if(level.player ispcplayer()) {
    level.player modifybasefov(65.0, 0.1);
    level waittill("acquire_pc_fov_clear");
    level.player modifybasefov(55.0, 0.35);
  }
}

cine_skip_mayhem_end(var_0) {}