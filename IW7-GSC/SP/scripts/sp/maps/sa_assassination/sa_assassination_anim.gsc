/**********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\sa_assassination\sa_assassination_anim.gsc
**********************************************************************/

main() {
  player();
  _id_13267();
  _id_91DC();
  _id_EA2C();
  _id_A056();
  script_model();
  _id_2392();
}

#using_animtree("player");

player() {
  level._id_EC87["player_rig"] = #animtree;
  level._id_EC87["player_arms"] = #animtree;
  level._id_EC8C["player_rig"] = "viewmodel_base_viewhands_iw7";
  level._id_EC85["player_rig"]["player_enter_barracks"] = % sa_assassin_enter_barracks_plr_start;
  level._id_EC85["player_rig"]["keel_enter_plr_start"] = % sa_assassin_keel_enter_plr_start_scripted;
  level._id_EC85["player_rig"]["intro_plr"] = % sa_assassin_intro_plr;
  level._id_EC85["player_rig"]["keel_handoff"] = % sa_assassin_keel_walk_plr_finish;
  level._id_EC85["player_rig"]["player_disguise_start"] = % sa_assassin_barracks_disguise_plr_start;
  level._id_EC85["player_rig"]["guy1_barracks_kill"] = % sa_assassin_barrack_kills_meleedeath_player;
  level._id_EC85["player_rig"]["keel_repair_guy_melee"] = % vm_grnd_stealth_exposed_melee_kill_01;
  level._id_EC85["player_rig"]["melee_neck_snap"] = % vm_grnd_stealth_exposed_melee_kill_2;
  level._id_EC87["player_rig_disguise"] = #animtree;
  level._id_EC8C["player_rig_disguise"] = "viewmodel_mp_stryker_2";
  level._id_EC85["player_rig_disguise"]["player_disguise_end"] = % sa_assassin_barracks_disguise_plr_finish;
  level._id_EC85["player_rig_disguise"]["plr_handscanner"] = % sa_assassin_conf_room_scanner_plr_start;
  level._id_EC85["player_rig_disguise"]["plr_gasplant"] = % sa_assassin_prime_vent_player;
  level._id_EC85["player_rig_disguise"]["plr_airlock_int"] = % sa_vips_airlock_pull_plr;
  level._id_EC85["player_rig_disguise"]["exfil_plr"] = % sa_assassin_exfil_plr;
  level._id_EC85["player_rig_disguise"]["hack_terminal"] = % vm_gauntlet_armory_hack;
  level._id_EC85["player_rig_disguise"]["open_loot_door"] = % door_armory_open_player;
  scripts\sp\anim::_id_17FA("player_rig", "fade_out", "flag_fade_out", "player_disguise_start");
  scripts\sp\anim::_id_17FA("player_rig_disguise", "fade_in", "flag_fade_in", "player_disguise_end");
  scripts\sp\anim::_id_17FA("player_rig_disguise", "helmet_on", "flag_helmet_on", "player_disguise_end");
  scripts\sp\anim::_id_17FA("player_rig_disguise", "start_bink", "flag_hand_bink", "plr_handscanner");
  scripts\sp\anim::_id_17FA("player_rig_disguise", "complete_bink", "flag_hand_bink_end", "plr_handscanner");
}

_id_21E8() {
  level._id_EC87["player_rig_disguise"] = #animtree;
  level._id_EC8C["player_rig_disguise"] = "viewmodel_mp_stryker_2";
  level._id_EC85["player_rig_disguise"]["plr_airlock_int"] = % sa_vips_airlock_pull_plr;
  level._id_EC85["player_rig_disguise"]["exfil_plr"] = % sa_assassin_exfil_plr;
}

#using_animtree("generic_human");

_id_2392() {
  level._id_E977._id_12ACC = [];
  level._id_EC85["generic"]["sa_drillsarge_loop"] = % shipcrib_drill_sargent_02;
  level._id_EC85["generic"]["sa_pushups1_loop"] = % shipcrib_pushups_seta_01;
  level._id_EC85["generic"]["sa_pushups2_loop"] = % shipcrib_pushups_setc_01;
  level._id_EC85["generic"]["sa_pushups3_loop"] = % shipcrib_pushups_setd_01;
  level._id_EC85["generic"]["sa_barracks_chill1_loop"] = % shipcrib_chillwalll_idle_01;
  level._id_EC85["generic"]["sa_barracks_chill1_twitch_1"] = % shipcrib_chillwalll_l90_01;
  level._id_EC85["generic"]["sa_barracks_chill1_twitch_2"] = % shipcrib_chillwalll_l60_01;
  level._id_EC85["generic"]["sa_barracks_chill1_twitch_3"] = % shipcrib_chillwalll_l30_01;
  level._id_EC85["generic"]["sa_barracks_chill1_twitch_4"] = % shipcrib_chillwalll_l00_01;
  level._id_EC85["generic"]["sa_barracks_chill1_twitch_5"] = % shipcrib_chillwalll_r30_01;
  level._id_EC85["generic"]["sa_barracks_chill1_twitch_6"] = % shipcrib_chillwalll_r60_01;
  level._id_EC85["generic"]["sa_barracks_chill1_twitch_7"] = % shipcrib_chillwalll_r90_01;
  level._id_E977._id_12ACC["sa_barracks_chill1"] = 7;
  level._id_EC85["generic"]["sa_barracks_sitting1_loop"] = % ph_un_hq_listening_sitting_loop01;
  level._id_EC85["generic"]["sa_barracks_sitting2_loop"] = % ph_un_hq_listening_sitting_loop02;
  level._id_EC85["generic"]["sa_barracks_sitting3_loop"] = % ph_un_hq_listening_sitting_loop03;
  level._id_EC85["generic"]["sa_barracks_sitting4_loop"] = % ph_un_hq_listening_sitting_loop04;
  level._id_EC85["generic"]["sa_techofficer_work_enter"] = % sa_assassin_tech_officer_enter;
  level._id_EC85["generic"]["sa_techofficer_work"] = % sa_assassin_tech_officer_loop;
  level._id_EC85["generic"]["sa_techofficer_work_exit"] = % sa_assassin_tech_officer_exit;
  level._id_EC85["generic"]["sa_techofficer_work_twitch_1"] = % sa_assassin_tech_officer_loop;
  level._id_EC85["generic"]["sa_techofficer_work_twitch_2"] = % sa_assassin_tech_officer_loop;
  level._id_EC85["generic"]["sa_techofficer_work_twitch_3"] = % sa_assassin_tech_officer_loop;
  level._id_EC85["generic"]["sa_techofficer_work_twitch_4"] = % sa_assassin_tech_officer_loop;
  level._id_EC85["generic"]["sa_techofficer_work_twitch_5"] = % sa_assassin_tech_officer_loop;
  level._id_EC85["generic"]["sa_techofficer_work_twitch_6"] = % sa_assassin_tech_officer_loop;
  level._id_EC85["generic"]["sa_techofficer_work_twitch_7"] = % sa_assassin_tech_officer_loop;
  level._id_E977._id_12ACC["sa_techofficer_work"] = 7;
  level._id_EC85["generic"]["sa_chatting1_loop"] = % sa_assassin_micro_manage_idle_01;
  level._id_EC85["generic"]["sa_chatting2_loop"] = % sa_assassin_micro_manage_idle_02;
  level._id_EC85["generic"]["sa_railchill_enter"] = % shipcrib_hangar_leaning_rail_idle_01_enter;
  level._id_EC85["generic"]["sa_railchill_loop"] = % shipcrib_hangar_leaning_rail_idle_01_loop;
  level._id_EC85["generic"]["sa_railchill_exit"] = % shipcrib_hangar_leaning_rail_idle_01_exit;
  level._id_EC85["generic"]["sa_standtalk1_loop"] = % shipcrib_stand_stationary_talk_idle_03;
  level._id_EC85["generic"]["sa_standtalk2_loop"] = % shipcrib_stand_stationary_talk_idle_05;
  level._id_EC85["generic"]["sa_standtalk3_loop"] = % sa_assassin_ambience_marine_01_idle_01;
  level._id_EC85["generic"]["sa_standtalk4_loop"] = % sa_assassin_ambience_marine_03_idle_01;
  level._id_EC85["generic"]["sa_standtalk5_loop"] = % sa_assassin_ambience_spectator_04_idle_02;
  level._id_EC85["generic"]["sa_standcell1_loop"] = % shipcrib_hangar_phone_idle_02;
  level._id_EC85["generic"]["sa_sitting1_loop"] = % shipcrib_hangar_c12_event_spectator_07_idle_02;
}

_id_91DC() {
  level._id_EC87["generic_human"] = #animtree;
  level._id_EC85["generic_human"]["sdf_commander_conf1"][0] = % ph_un_hq_listening_sitting_loop01;
  level._id_EC85["generic_human"]["sdf_commander_conf2"][0] = % ph_un_hq_listening_sitting_loop02;
  level._id_EC85["generic_human"]["sdf_commander_conf3"][0] = % ph_un_hq_listening_sitting_loop03;
  level._id_EC85["generic_human"]["sdf_commander_conf4"][0] = % ph_un_hq_listening_sitting_loop04;
  level._id_EC85["tech_officer"]["sdf_tech_officer_loop"][0] = % shipcrib_deck_crouch_repair_loop_01;
  level._id_EC85["generic"]["keel_repair_guy"][0] = % hm_grnd_yel_patrol_repairfloorunit_loop;
  level._id_EC85["generic"]["keel_repair_guy_melee"] = % hm_grnd_stealth_exposed_stand_death_melee_01;
  level._id_EC85["generic"]["melee_neck_snap"] = % hm_grnd_stealth_exposed_stand_death_melee_2;
  level._id_EC85["hub_captain"]["sdf_meetup"] = % sa_assassin_sdf_join_commander;
  level._id_EC85["hub_grunt1"]["sdf_meetup"] = % sa_assassin_sdf_join_enemy01;
  level._id_EC85["hub_grunt2"]["sdf_meetup"] = % sa_assassin_sdf_join_enemy02;
  level._id_EC85["boxer_leader"]["sdf_boxers"][0] = % sa_assassin_sdf_boxers_ringleader_loop;
  level._id_EC85["boxer_spect"]["sdf_boxers"][0] = % sa_assassin_sdf_boxers_spectator_loop;
  level._id_EC85["boxer_pupil"]["sdf_boxers"][0] = % sa_assassin_sdf_boxers_pupil_loop;
  level._id_EC85["cart_pusher"]["armory_cart_start"] = % sa_assassin_armory_cart_cguy_start;
  level._id_EC85["cart_pusher"]["armory_cart_loop"][0] = % sa_assassin_armory_cart_cguy_loop;
  level._id_EC85["cart_director"]["typing_guy_start"] = % sa_assassin_armory_cart_tguy_start;
  level._id_EC85["cart_director"]["typing_guy_loop"][0] = % sa_assassin_armory_cart_tguy_loop;
  scripts\sp\anim::_id_17FA("cart_pusher", "buddy_start", "flag_cart_guy_buddy", "armory_cart_start");
  level._id_EC85["generic"]["guy1_barracks_kill"] = % sa_assassin_barrack_kills_meleedeath_sdf01;
  level._id_EC85["generic"]["guy1_barracks_kill_loop"][0] = % sa_assassin_barrack_kills_loop_sdf01;
  level._id_EC85["generic"]["guy1_barracks_kill_react"] = % sa_assassin_barrack_kills_react_sdf01;
  level._id_EC85["barracks_guy2"]["guy2_lifting_loop"][0] = % sa_assassin_barrack_kills_loop_sdf02;
  level._id_EC85["barracks_guy2"]["guy2_lifting_react"] = % sa_assassin_barrack_kills_react_sdf02;
  level._id_EC85["barracks_guy2"]["guy2_lifting_death"] = % sa_assassin_barrack_kills_death_sdf02;
  level._id_EC85["barracks_guy3"]["guy3_barracks_kill"] = % sa_assassin_enter_barracks_sdf_start;
  level._id_EC85["barracks_guy3"]["guy3_barracks_kill_loop"][0] = % sa_assassin_enter_barracks_sdf_loop;
  level._id_EC85["barracks_guy3"]["guy3_barracks_kill_react"] = % sa_assassin_enter_barracks_sdf_react;
  level._id_EC85["barracks_guy3"]["guy3_barracks_kill_death"] = % sa_assassin_enter_barracks_sdf_death;
  level._id_EC85["generic_human"]["commander1_conf_loop"][0] = % sa_assassin_conf_room_gen1_loop;
  level._id_EC85["generic_human"]["commander2_conf_loop"][0] = % sa_assassin_conf_room_gen2_loop;
  level._id_EC85["generic_human"]["commander3_conf_loop"][0] = % sa_assassin_conf_room_gen3_loop;
  level._id_EC85["generic_human"]["commander1_conf_react"] = % sa_assassin_conf_room_gen1_gas;
  level._id_EC85["generic_human"]["commander2_conf_react"] = % sa_assassin_conf_room_gen2_gas;
  level._id_EC85["generic_human"]["commander3_conf_react"] = % sa_assassin_conf_room_gen3_gas;
  level._id_EC85["generic_human"]["commander1_conf_react_loop"][0] = % sa_assassin_conf_room_gen1_gas_loop_end;
  level._id_EC85["generic_human"]["commander2_conf_react_loop"][0] = % sa_assassin_conf_room_gen2_gas_loop_end;
  level._id_EC85["generic_human"]["commander3_conf_react_loop"][0] = % sa_assassin_conf_room_gen3_gas_loop_end;
  level._id_EC85["generic_human"]["commander1_conf_startle"] = % sa_assassin_conf_room_gen1_startle;
  level._id_EC85["generic_human"]["commander2_conf_startle"] = % sa_assassin_conf_room_gen2_startle;
  level._id_EC85["generic_human"]["commander3_conf_startle"] = % sa_assassin_conf_room_gen3_startle;
  level._id_EC85["generic"]["grunt1_conf_loop"][0] = % sa_assassin_conf_room_sdf1_loop1;
  level._id_EC85["generic"]["grunt2_conf_loop"][0] = % sa_assassin_conf_room_sdf2_loop1;
  level._id_EC85["generic"]["grunt1_conf_react"] = % sa_assassin_conf_room_sdf1_gas;
  level._id_EC85["generic"]["grunt2_conf_react"] = % sa_assassin_conf_room_sdf2_gas;
  level._id_EC85["generic"]["grunt3_conf_react"] = % sa_assassin_conf_room_sdf3_gas;
  level._id_EC85["generic"]["grunt4_conf_react"] = % sa_assassin_conf_room_sdf4_gas;
  level._id_EC85["generic"]["grunt1_conf_loop2"][0] = % sa_assassin_conf_room_sdf1_loop2;
  level._id_EC85["generic"]["grunt2_conf_loop2"][0] = % sa_assassin_conf_room_sdf2_loop2;
  level._id_EC85["generic"]["grunt3_conf_loop2"][0] = % sa_assassin_conf_room_sdf3_loop2;
  level._id_EC85["generic"]["grunt4_conf_loop2"][0] = % sa_assassin_conf_room_sdf4_loop2;
}

_id_EA2C() {
  level._id_EC85["salter"]["sa_exfil_salter_mount"] = % moon_jackaltakeoff_salter_getin;
  level._id_EC85["salter"]["keel_enter_xo_start"] = % sa_assassin_keel_enter_xo_start;
  level._id_EC85["salter"]["keel_walk_xo_start"] = % sa_assassin_keel_walk_xo_start;
  level._id_EC85["salter"]["keel_walk_xo_loop_wait"][0] = % sa_assassin_keel_walk_xo_loop_wait;
  level._id_EC85["salter"]["keel_walk_xo_cont"] = % sa_assassin_keel_walk_xo_continue_walk;
  level._id_EC85["salter"]["keel_walk_xo_loop_gas"][0] = % sa_assassin_keel_walk_xo_loop_gas;
  level._id_EC85["salter"]["keel_handoff"] = % sa_assassin_keel_walk_xo_finish;
  level._id_EC85["salter"]["keel_walk_xo_hack_loop"][0] = % sa_assassin_keel_walk_xo_hacking_loop;
  level._id_EC85["salter"]["intro_xo"] = % sa_assassin_intro_xo;
  scripts\sp\anim::_id_17FA("salter", "bomb_grab", "flag_bomb_grab", "keel_walk_xo_cont");
  level._id_EC85["salter"]["intro_xo"] = % sa_assassin_intro_xo;
  level._id_EC85["salter"]["zg_airlock_lift"] = % sa_wounded_zerog_enter_ally_01;
}

#using_animtree("jackal");

_id_A056() {
  level._id_EC85["salter_jackal"]["sa_exfil_salter_mount"] = % jackal_vehicle_mount_01_port;
}

#using_animtree("script_model");

script_model() {
  level._id_EC87["airlock_door"] = #animtree;
  level._id_EC85["airlock_door"]["open_airlock"] = % airlock_open_door;
  level._id_EC85["airlock_door_int"]["door_airlock_int"] = % sa_vips_airlock_pull_airlock;
  level._id_EC87["broken_airlock_door"] = #animtree;
  level._id_EC85["broken_airlock_door"]["broken_airlock_push"] = % moon_broken_airlock_door_push;
  level._id_EC87["j_prop_barracks"] = #animtree;
  level._id_EC8C["j_prop_barracks"] = "generic_prop_x3";
  level._id_EC85["j_prop_barracks"]["jprop_enter_barracks"] = % sa_assassin_enter_barracks_grate_start;
  level._id_EC87["j_prop_barracks_guy1"] = #animtree;
  level._id_EC8C["j_prop_barracks_guy1"] = "generic_prop_x3";
  level._id_EC85["j_prop_barracks_guy1"]["guy1_barracks_kill_loop"][0] = % sa_assassin_barrack_kills_loop_sdf01_bag;
  level._id_EC87["prop_duffle"] = #animtree;
  level._id_EC8C["prop_duffle"] = "equipment_duffle_bag_01";
  level._id_EC87["prop_locker"] = #animtree;
  level._id_EC8C["prop_locker"] = "furniture_space_locker_metal_01_door_dark";
  level._id_EC87["j_prop_locker"] = #animtree;
  level._id_EC8C["j_prop_locker"] = "generic_prop_x3";
  level._id_EC85["j_prop_locker"]["guy3_barracks_kill"] = % sa_assassin_enter_barracks_locker_start;
  level._id_EC87["guy2_weight"] = #animtree;
  level._id_EC8C["guy2_weight"] = "generic_prop_x3";
  level._id_EC85["guy2_weight"]["guy2_lifting_loop"][0] = % sa_assassin_barrack_kills_loop_sdf02_weight;
  level._id_EC85["guy2_weight"]["guy2_lifting_react"] = % sa_assassin_barrack_kills_react_sdf02_weight;
  level._id_EC85["guy2_weight"]["guy2_lifting_death"] = % sa_assassin_barrack_kills_death_sdf02_weight;
  level._id_EC87["prop_weight"] = #animtree;
  level._id_EC8C["prop_weight"] = "p7_weights_metal_gym_25_grey_drk";
  level._id_EC87["prop_gun"] = #animtree;
  level._id_EC8C["prop_gun"] = "weapon_sdfar_wm";
  level._id_EC87["armory_cart"] = #animtree;
  level._id_EC85["armory_cart"]["armory_cart_start"] = % sa_assassin_armory_cart_mcart_start;
  level._id_EC85["armory_cart"]["armory_cart_loop"][0] = % sa_assassin_armory_cart_mcart_loop;
  level._id_EC8C["armory_cart"] = "sdf_cruise_missile_dolly_01_rig";
  level._id_EC87["armory_cart_missile"] = #animtree;
  level._id_EC8C["armory_cart_missile"] = "sdf_cruise_missile_closed_01";
  level._id_EC87["roid_rig"] = #animtree;
  level._id_EC85["roid_rig"]["roid_intro"] = % sa_assassin_intro_rocks;
  level._id_EC8C["roid_rig"] = "generic_prop_x3";
  level._id_EC8C["roid_1"] = "asteroid_grapple_04";
  level._id_EC87["roid_1"] = #animtree;
  level._id_EC8C["roid_2"] = "asteroid_grapple_07";
  level._id_EC87["roid_2"] = #animtree;
  level._id_EC87["hacking_device"] = #animtree;
  level._id_EC85["hacking_device"]["keel_enter_device_start"] = % sa_assassin_keel_enter_device_start;
  level._id_EC8C["hacking_device"] = "weapon_handheld_hacking_device_02_vm";
  level._id_EC87["keel_doors"] = #animtree;
  level._id_EC85["keel_doors"]["keel_open"] = % sa_assassin_keel_enter_door_start;
  level._id_EC8C["keel_doors"] = "generic_prop_x3";
  level._id_EC87["gasplant"] = #animtree;
  level._id_EC85["gasplant"]["plr_gasplant"] = % sa_assassin_prime_vent_bomb;
  level._id_EC8C["gasplant"] = "weapon_gas_bomb_vm";
  scripts\sp\anim::_id_17FA("gasplant", "pin_pulled", "flag_gren_pin_pulled", "plr_gasplant");
  level._id_EC87["j_prop_hvac"] = #animtree;
  level._id_EC8C["j_prop_hvac"] = "generic_prop_x3";
  level._id_EC85["j_prop_hvac"]["plr_gasplant"] = % sa_assassin_prime_vent_door;
  level._id_EC87["prop_hvac"] = #animtree;
  level._id_EC8C["prop_hvac"] = "hvac_unit_door_01";
  level._id_EC87["exfil_door"] = #animtree;
  level._id_EC85["exfil_door"]["exfil_door"] = % sa_assassin_exfil_door;
  level._id_EC8C["exfil_door"] = "sdf_door_airlock_01";
  level._id_EC87["conf_chair1"] = #animtree;
  level._id_EC85["conf_chair1"]["commander1_conf_loop"][0] = % sa_assassin_conf_room_chair1_loop1;
  level._id_EC85["conf_chair1"]["commander1_conf_startle"] = % sa_assassin_conf_room_chair1_startle;
  level._id_EC85["conf_chair1"]["commander1_conf_react"] = % sa_assassin_conf_room_chair1_gas;
  level._id_EC85["conf_chair1"]["commander1_conf_react_loop"][0] = % sa_assassin_conf_room_chair1_loop_end;
  level._id_EC8C["conf_chair1"] = "cnd_office_chair_01_rig";
  level._id_EC87["conf_chair2"] = #animtree;
  level._id_EC85["conf_chair2"]["commander2_conf_loop"][0] = % sa_assassin_conf_room_chair2_loop1;
  level._id_EC85["conf_chair2"]["commander2_conf_startle"] = % sa_assassin_conf_room_chair2_startle;
  level._id_EC85["conf_chair2"]["commander2_conf_react"] = % sa_assassin_conf_room_chair2_gas;
  level._id_EC85["conf_chair2"]["commander2_conf_react_loop"][0] = % sa_assassin_conf_room_chair2_loop_end;
  level._id_EC8C["conf_chair2"] = "cnd_office_chair_01_rig";
  level._id_EC87["conf_chair3"] = #animtree;
  level._id_EC85["conf_chair3"]["commander3_conf_loop"][0] = % sa_assassin_conf_room_chair3_loop1;
  level._id_EC85["conf_chair3"]["commander3_conf_startle"] = % sa_assassin_conf_room_chair3_startle;
  level._id_EC85["conf_chair3"]["commander3_conf_react"] = % sa_assassin_conf_room_chair3_gas;
  level._id_EC85["conf_chair3"]["commander3_conf_react_loop"][0] = % sa_assassin_conf_room_chair3_loop_end;
  level._id_EC8C["conf_chair3"] = "cnd_office_chair_01_rig";
  level._id_EC87["conf_chair4"] = #animtree;
  level._id_EC85["conf_chair4"]["commander3_conf_loop"][0] = % sa_assassin_conf_room_chair4_loop1;
  level._id_EC85["conf_chair4"]["commander3_conf_react"] = % sa_assassin_conf_room_chair4_gas;
  level._id_EC85["conf_chair4"]["commander3_conf_react_loop"][0] = % sa_assassin_conf_room_chair4_loop_end;
  level._id_EC8C["conf_chair4"] = "cnd_office_chair_01_rig";
  level._id_EC87["conf_panel"] = #animtree;
  level._id_EC8C["conf_panel"] = "generic_prop_x3";
  level._id_EC85["conf_panel"]["grunt3_conf_react"] = % sa_assassin_conf_room_panel_gas;
  level._id_EC87["keel_bomb"] = #animtree;
  level._id_EC8C["keel_bomb"] = "weapon_gas_bomb_vm";
  level._id_EC85["keel_bomb"]["keel_walk_xo_cont"] = % sa_assassin_keel_walk_bomb_continue_walk;
  level._id_EC85["keel_bomb"]["keel_walk_xo_loop_gas"][0] = % sa_assassin_keel_walk_bomb_loop_gas;
  level._id_EC85["keel_bomb"]["keel_handoff"] = % sa_assassin_keel_walk_bomb_finish;
}

_id_13267() {}