/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\sa_moon\sa_moon_anim.gsc
****************************************************/

main() {
  player();
  _id_13267();
  _id_91DC();
  script_model();
  _id_EE8D();
  _id_3508();
}

#using_animtree("player");

player() {
  level._id_EC87["player_rig"] = #animtree;
  level._id_EC8C["player_rig"] = "viewmodel_base_viewhands_iw7";
  level._id_EC85["player_rig"]["intro"] = % sa_moon_intro_plr;
  level._id_EC85["player_rig"]["intro_bink"] = % sa_moon_intro_bink_plr;
  scripts\sp\anim::_id_17FA("player_rig", "spawn_allies", "flag_allies_landing", "cargobay_transition_exit");
  level._id_EC87["player_rig"] = #animtree;
  level._id_EC8C["player_rig"] = "viewmodel_base_viewhands_iw7";
  level._id_EC85["player_rig"]["exfil"] = % sa_moon_cargobay_outro_plr_start;
  level._id_EC85["player_rig"]["exfil_flyout"] = % sa_moon_flyout_outro_plr_start;
}

#using_animtree("generic_human");

_id_91DC() {
  level._id_EC85["generic"]["console_keyboarding5"][0] = % shipcrib_standing_console_idle_13;
  level._id_EC85["generic"]["console_keyboarding10"][0] = % shipcrib_standing_console_idle_10;
  level._id_EC85["generic"]["console_idle"][0] = % hm_grnd_yel_patrol_idle_radio01_ar;
  level._id_EC85["generic"]["console_repair"][0] = % hm_grnd_yel_patrol_repairwallunit_loop;
  level._id_EC85["generic"]["wave"] = % stand_exposed_wave_move_out;
  level._id_EC85["generic"]["turn_run_panic"] = % run_reaction_180;
  level._id_EC85["generic"]["react_turn_left"] = % hm_grnd_yel_patrol_react_to_combat_2_ar;
  level._id_EC85["generic"]["react_turn_sit_left"] = % shipcrib_bridge_sitting_exit_l_01;
  level._id_EC85["generic"]["react_turn_sit_idle"][0] = % shipcrib_bridge_sitting_officer_idle_01;
  level._id_EC85["generic"]["react_turn_right"] = % hm_grnd_yel_patrol_creepwalk_react_to_seekclear_2_ar;
  level._id_EC85["generic"]["react_turn_radio"][0] = % hm_grnd_yel_patrol_seekclear_idle_radio01_ar;
  level._id_EC85["generic"]["react_cargo_soldier_1"] = % sa_moon_precargo_enemy01;
  level._id_EC85["generic"]["react_cargo_soldier_1_idle"][0] = % sa_moon_precargo_react_enemy01_loop;
  level._id_EC85["generic"]["react_cargo_soldier_2"] = % sa_moon_precargo_enemy02;
  level._id_EC85["generic"]["react_cargo_soldier_2_idle"][0] = % sa_moon_precargo_react_enemy02_loop;
  level._id_EC85["generic"]["react_cargo_soldier_3"] = % sa_moon_precargo_enemy03;
  level._id_EC85["generic"]["react_cargo_soldier_3_idle"][0] = % sa_moon_precargo_enemy03_loop;
  level._id_EC85["ethan"]["intro"] = % sa_moon_intro_c6i;
  level._id_EC85["omar"]["intro"] = % sa_moon_intro_mco;
  level._id_EC85["salter"]["intro"] = % sa_moon_intro_xo;
  level._id_EC85["ethan"]["eject"] = % sa_moon_intro_eject_c6i;
  level._id_EC85["omar"]["eject"] = % sa_moon_intro_eject_mco;
  level._id_EC85["salter"]["eject"] = % sa_moon_intro_eject_xo;
  level._id_EC85["ethan"]["hero_kill"] = % sa_moon_hallway_kill_ethan;
  level._id_EC85["omar"]["hero_kill"] = % sa_moon_hallway_kill_xo;
  level._id_EC85["generic"]["hero_kill_enemy1"] = % sa_moon_hallway_kill_enemy1;
  level._id_EC85["generic"]["hero_kill_enemy2"] = % sa_moon_hallway_kill_enemy2;
  level._id_EC85["generic"]["hall_body"] = % generic_dead_civ_01;
  level._id_EC85["ethan"]["cargobay_point"] = % sa_moon_precargo_ethan;
  level._id_EC85["salter"]["exfil"] = % sa_moon_cargobay_outro_xo_start;
  level._id_EC85["omar"]["exfil"] = % sa_moon_cargobay_outro_mco_start;
  level._id_EC85["ethan"]["exfil"] = % sa_moon_cargobay_outro_eth3n_start;
  level._id_EC85["ethan"]["exfil_loop"][0] = % sa_moon_cargobay_outro_eth3n_loop;
  level._id_EC85["generic"]["exfil_enemy1"] = % sa_moon_cargobay_outro_ememy1_start;
  level._id_EC85["generic"]["exfil_enemy2"] = % sa_moon_cargobay_outro_ememy2_start;
  level._id_EC85["generic"]["exfil_enemy3"] = % sa_moon_cargobay_outro_ememy3_start;
  level._id_EC85["generic"]["exfil_enemy4"] = % sa_moon_cargobay_outro_ememy4_start;
  level._id_EC85["generic"]["exfil_enemy5"] = % sa_moon_cargobay_outro_ememy5_alive_start;
  level._id_EC85["generic"]["exfil_enemy6"] = % sa_moon_cargobay_outro_ememy6_alive_start;
  level._id_EC85["generic"]["exfil_enemy7"] = % sa_moon_cargobay_outro_ememy7_alive_start;
  level._id_EC85["generic"]["choke02"] = % hm_zg_org_grav_grenade_choke02_ar;
}

#using_animtree("script_model");

script_model() {
  level._id_EC87["intro_debris"] = #animtree;
  level._id_EC8C["intro_debris"] = "generic_prop_x30";
  level._id_EC85["intro_debris"]["intro"] = % sa_moon_intro_debris_02;
  level._id_EC87["intro_debris_fx"] = #animtree;
  level._id_EC8C["intro_debris_fx"] = "generic_prop_x30";
  level._id_EC85["intro_debris_fx"]["intro"] = % sa_moon_intro_debris_fx;
  level._id_EC87["tigris"] = #animtree;
  level._id_EC8C["tigris"] = "generic_prop_x5";
  level._id_EC85["tigris"]["intro"] = % sa_moon_intro_tigris;
  level._id_EC87["mco_rope"] = #animtree;
  level._id_EC8C["mco_rope"] = "grapple_rope_250u";
  level._id_EC85["mco_rope"]["eject"] = % sa_moon_intro_rope_mco;
  level._id_EC87["xo_rope"] = #animtree;
  level._id_EC8C["xo_rope"] = "grapple_rope_250u";
  level._id_EC85["xo_rope"]["eject"] = % sa_moon_intro_rope_xo;
  level._id_EC87["hero_kill_window"] = #animtree;
  level._id_EC8C["hero_kill_window"] = "sdf_window_interior_broken_01_rig";
  level._id_EC85["hero_kill_window"]["hero_kill"] = % sa_moon_hallway_kill_window;
  level._id_EC87["c12_01"] = #animtree;
  level._id_EC8C["c12_01"] = "robot_c12";
  level._id_EC85["c12_01"]["exfil"] = % sa_moon_cargobay_outro_robo1_start;
  level._id_EC85["c12_01"]["exfil_loop"][0] = % sa_moon_cargobay_outro_robo1_loop;
  level._id_EC87["c12_02"] = #animtree;
  level._id_EC8C["c12_02"] = "robot_c12";
  level._id_EC85["c12_02"]["exfil"] = % sa_moon_cargobay_outro_robo2_start;
  level._id_EC85["c12_02"]["exfil_loop"][0] = % sa_moon_cargobay_outro_robo2_loop;
  level._id_EC87["buggy_01"] = #animtree;
  level._id_EC8C["buggy_01"] = "veh_mil_lnd_ca_4x4_atv";
  level._id_EC85["buggy_01"]["exfil"] = % sa_moon_cargobay_outro_veh1_start;
  level._id_EC85["buggy_01"]["exfil_loop"][0] = % sa_moon_cargobay_outro_veh1_loop;
  level._id_EC87["buggy_02"] = #animtree;
  level._id_EC8C["buggy_02"] = "veh_mil_lnd_ca_4x4_atv";
  level._id_EC85["buggy_02"]["exfil"] = % sa_moon_cargobay_outro_veh2_start;
  level._id_EC85["buggy_02"]["exfil_loop"][0] = % sa_moon_cargobay_outro_veh2_loop;
  level._id_EC87["buggy_03"] = #animtree;
  level._id_EC8C["buggy_03"] = "veh_mil_lnd_ca_4x4_atv";
  level._id_EC85["buggy_03"]["exfil"] = % sa_moon_cargobay_outro_veh3_start;
  level._id_EC87["cargo_bay_doors"] = #animtree;
  level._id_EC8C["cargo_bay_doors"] = "generic_prop_x3";
  level._id_EC85["cargo_bay_doors"]["exfil"] = % sa_moon_cargobay_outro_doors_start;
  level._id_EC85["cargo_bay_doors"]["exfil_loop"][0] = % sa_moon_cargobay_outro_doors_loop;
  level._id_EC87["cargo_bay_lever"] = #animtree;
  level._id_EC8C["cargo_bay_lever"] = "sdf_console_door_lever_01_anim";
  level._id_EC85["cargo_bay_lever"]["exfil"] = % sa_moon_cargobay_outro_lever_start;
  level._id_EC87["cargo_bay_button"] = #animtree;
  level._id_EC8C["cargo_bay_button"] = "sdf_console_control_panel_04_anim";
  level._id_EC85["cargo_bay_button"]["exfil"] = % sa_moon_cargobay_outro_button_start;
  level._id_EC87["large_props"] = #animtree;
  level._id_EC8C["large_props"] = "generic_prop_x3";
  level._id_EC85["large_props"]["exfil"] = % sa_moon_cargobay_outro_large_obj_start;
  level._id_EC85["large_props"]["exfil_loop"][0] = % sa_moon_cargobay_outro_large_obj_loop;
  level._id_EC87["bounce_props"] = #animtree;
  level._id_EC8C["bounce_props"] = "generic_prop_x3";
  level._id_EC85["bounce_props"]["exfil"] = % sa_moon_cargobay_outro_extra_junk_obj_start;
  level._id_EC85["bounce_props"]["exfil_loop"][0] = % sa_moon_cargobay_outro_extra_junk_obj_loop;
  level._id_EC87["exfil_props"] = #animtree;
  level._id_EC8C["exfil_props"] = "generic_prop_x30";
  level._id_EC85["exfil_props"]["exfil"] = % sa_moon_cargobay_outro_junk_obj_start;
  level._id_EC85["exfil_props"]["exfil_loop"][0] = % sa_moon_cargobay_outro_junk_obj_loop;
  level._id_EC87["small_props"] = #animtree;
  level._id_EC8C["small_props"] = "generic_prop_x10";
  level._id_EC85["small_props"]["exfil"] = % sa_moon_cargobay_outro_small_obj_start;
  level._id_EC87["small_props_cont"] = #animtree;
  level._id_EC8C["small_props_cont"] = "generic_prop_x5";
  level._id_EC85["small_props_cont"]["exfil"] = % sa_moon_cargobay_outro_small_obj_cont_start;
  level._id_EC87["mco_rope_exfil"] = #animtree;
  level._id_EC8C["mco_rope_exfil"] = "grapple_rope_250u";
  level._id_EC85["mco_rope_exfil"]["exfil"] = % sa_moon_cargobay_outro_mco_rope_start;
  level._id_EC87["xo_rope_exfil"] = #animtree;
  level._id_EC8C["xo_rope_exfil"] = "grapple_rope_250u";
  level._id_EC85["xo_rope_exfil"]["exfil"] = % sa_moon_cargobay_outro_xo_rope_start;
  level._id_EC87["capitalships_props"] = #animtree;
  level._id_EC8C["capitalships_props"] = "generic_prop_x3";
  level._id_EC85["capitalships_props"]["exfil_flyout"] = % sa_moon_flyout_outro_lships_start;
  level._id_EC87["missile_hatch"] = #animtree;
  level._id_EC8C["missile_hatch"] = "ship_exterior_ca_missile_hatch_a_rig_190p";
  level._id_EC85["missile_hatch"]["sa_moon_deck_missilebaydoors_open"] = % sa_moon_deck_missilebaydoors_open;
}

_id_EE8D() {}

#using_animtree("jackal");

_id_13267() {
  level._id_EC87["player_jackal"] = #animtree;
  level._id_EC8C["player_jackal"] = "veh_mil_air_un_jackal_02_player";
  level._id_EC85["player_jackal"]["intro"] = % sa_moon_intro_jackal_plr;
  level._id_EC85["player_jackal"]["intro_bink"] = % sa_moon_intro_bink_jackal_plr;
  level._id_EC87["salter_jackal"] = #animtree;
  level._id_EC8C["salter_jackal"] = "veh_mil_air_un_jackal_02_player";
  level._id_EC85["salter_jackal"]["intro"] = % sa_moon_intro_jackal_xo;
  level._id_EC85["salter_jackal"]["intro_bink"] = % sa_moon_intro_bink_jackal_xo;
  level._id_EC87["red_jackal"] = #animtree;
  level._id_EC8C["red_jackal"] = "veh_mil_air_un_jackal_02_player";
  level._id_EC85["red_jackal"]["intro"] = % sa_moon_intro_jackal_ally01;
  level._id_EC85["red_jackal"]["intro_bink"] = % sa_moon_intro_bink_jackal_ally01;
  level._id_EC87["player_jackal_exfil"] = #animtree;
  level._id_EC8C["player_jackal_exfil"] = "veh_mil_air_un_jackal_02_player";
  level._id_EC85["player_jackal_exfil"]["exfil_loop"][0] = % sa_moon_cargobay_outro_jackal_plr_loop;
  level._id_EC85["player_jackal_exfil"]["exfil_start"] = % sa_moon_cargobay_outro_jackal_plr_start;
  level._id_EC85["player_jackal_exfil"]["exfil_flyout"] = % sa_moon_flyout_outro_jackal_plr_start;
  level._id_EC87["ally_jackal_exfil"] = #animtree;
  level._id_EC8C["ally_jackal_exfil"] = "veh_mil_air_un_jackal_02";
  level._id_EC85["ally_jackal_exfil"]["exfil"] = % sa_moon_cargobay_outro_jackal_xo_start;
  level._id_EC85["ally_jackal_exfil"]["exfil_loop"][0] = % sa_moon_cargobay_outro_jackal_xo_loop;
  level._id_EC85["ally_jackal_exfil"]["exfil_flyout"] = % sa_moon_flyout_outro_jackal_xo_start;
}

#using_animtree("c12");

_id_3508() {
  level._id_EC87["combat_c12"] = #animtree;
  level._id_EC8C["combat_c12"] = "robot_c12";
  level._id_EC85["combat_c12"]["c12_start_up"] = % c12_grnd_org_exposed_poweron_01;
  level._id_EC85["combat_c12"]["c12_start_up2"] = % c12_grnd_org_exposed_poweron_storage;
}