/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\titan\titan_anim.gsc
************************************************/

main() {
  _id_91DC();
  _id_13267();
  _id_EE25();
  _id_5379();
  _id_CF61();
  _id_31F1();
  _id_3508();
  _id_A056();
}

#using_animtree("generic_human");

_id_91DC() {
  level._id_EC85["dropship1_ally0"]["dropoff1"] = % iw7_scripted_titan_beacon_dropoff_ally01;
  level._id_EC85["dropship1_ally1"]["dropoff1"] = % iw7_scripted_titan_beacon_dropoff_ally02;
  level._id_EC85["dropship1_ally2"]["dropoff1"] = % iw7_scripted_titan_beacon_dropoff_ally03;
  level._id_EC85["dropship1_ally3"]["dropoff1"] = % iw7_scripted_titan_beacon_dropoff_ally04;
  level._id_EC85["dropship1_ally4"]["dropoff1"] = % iw7_scripted_titan_beacon_dropoff_ally05;
  level._id_EC85["dropship1_ally5"]["dropoff1"] = % iw7_scripted_titan_beacon_dropoff_ally06;
  level._id_EC85["dropship1_ally6"]["dropoff1"] = % iw7_scripted_titan_beacon_dropoff_ally07;
  level._id_EC85["dropship1_ally7"]["dropoff1"] = % iw7_scripted_titan_beacon_dropoff_ally08;
  level._id_EC85["omar"]["intro_dropoff_idle"][0] = % titan_dropship_mco_land_idle;
  level._id_EC85["marine1"]["intro_dropoff_idle"][0] = % titan_dropship_mr1_land_idle;
  level._id_EC85["marine2"]["intro_dropoff_idle"][0] = % titan_dropship_mr2_land_idle;
  level._id_EC85["atom"]["intro_dropoff_idle"][0] = % titan_dropship_c6i_land_idle;
  level._id_EC88["marine2"]["sc_titan_ksh_Clear"] = % sc_titan_ksh_clear_face;
  level._id_EC88["omar"]["titan_usf_standclearofthebea"] = % titan_usf_standclearofthebea_face;
  level._id_EC88["marine2"]["titan_ksh_tensecondstotouch"] = % titan_ksh_tensecondstotouch_face;
  level._id_EC85["omar"]["intro_dropoff_scene"] = % titan_dropship_mco_land_into_titan;
  level._id_EC85["atom"]["intro_dropoff_scene"] = % titan_dropship_c6i_land_into_titan;
  level._id_EC85["marine1"]["intro_dropoff_scene"] = % titan_dropship_mr1_land_into_titan;
  level._id_EC85["omar"]["intro_dropoff_scene_1"] = % titan_dropship_mco_land_into_titan_01;
  level._id_EC85["marine2"]["intro_dropoff_scene_1"] = % titan_dropship_mr2_land_into_titan_01;
  level._id_EC85["omar"]["intro_dropoff_scene_2"] = % titan_dropship_mco_land_into_titan_02;
  level._id_EC85["marine2"]["intro_dropoff_scene_2"] = % titan_dropship_mr2_land_into_titan_02;
  scripts\sp\anim::_id_17FC("omar", "pvo_sc_titan_plr_clear", "kashima_clear_vo", "intro_dropoff_scene_2");
  level._id_EC85["omar"]["intro_dropoff_exit"] = % titan_dropship_mco_titan_jump;
  level._id_EC85["marine1"]["intro_dropoff_exit"] = % titan_dropship_mr1_titan_jump;
  level._id_EC85["marine2"]["intro_dropoff_exit"] = % titan_dropship_mr2_titan_jump;
  level._id_EC85["atom"]["intro_dropoff_exit"] = % titan_dropship_c6i_titan_jump;
  level._id_EC85["omar"]["loading_movie_scene"] = % titan_dropship_mco_takeoff_bink;
  level._id_EC85["marine1"]["loading_movie_scene"] = % titan_dropship_mr1_takeoff_bink;
  level._id_EC85["marine2"]["loading_movie_scene"] = % titan_dropship_mr2_takeoff_bink;
  level._id_EC85["atom"]["loading_movie_scene"] = % titan_dropship_c6i_takeoff_bink;
  level._id_EC85["omar"]["point_to_ridge"] = % titan_first_steps_mco_point_to_ridge;
  level._id_EC85["boggs"]["dropship_idle"][0] = % shipcrib_titan_10_boggs_seated_idle;
  level._id_EC88["marine2"]["titan_ksh_thisshitsmessedup"] = % titan_ksh_thisshitsmessedup_face;
  level._id_EC85["omar"]["squeeze_through_intro"] = % titan_stealth2_squeeze_through_hallway_mco_intro;
  level._id_EC85["omar"]["squeeze_through_intro_idle"][0] = % titan_stealth2_squeeze_through_hallway_mco_intro_idle;
  level._id_EC85["omar"]["squeeze_through_enter"] = % titan_stealth2_squeeze_through_hallway_mco_move_into;
  level._id_EC85["omar"]["squeeze_through_enter_idle"][0] = % titan_stealth2_squeeze_through_hallway_mco_move_into_idle;
  level._id_EC85["omar"]["squeeze_through_move_end"] = % titan_stealth2_squeeze_through_hallway_mco_move_end;
  level._id_EC85["omar"]["squeeze_through_move_end_idle"][0] = % titan_stealth2_squeeze_through_hallway_mco_move_end_idle;
  level._id_EC85["atom"]["squeeze_through_exit"] = % titan_stealth2_squeeze_through_hallway_c6i_response;
  level._id_EC85["omar"]["squeeze_through_exit"] = % titan_stealth2_squeeze_through_hallway_mco_response;
  scripts\sp\anim::_id_17F6("omar", "mayhem_start", ::_id_C48D, "squeeze_through_exit");
  scripts\sp\anim::_id_17F6("omar", "mayhem_end", ::_id_C48C, "squeeze_through_exit");
  level._id_EC85["atom"]["building1_exit"] = % titan_abandoned_building_c6i_buddy_door_open;
  level._id_EC85["omar"]["building1_exit"] = % titan_abandoned_building_mco_buddy_door_open;
  level._id_EC85["marine1"]["building1_exit"] = % titan_abandoned_building_mr1_buddy_door_open;
  level._id_EC85["marine2"]["building1_exit"] = % titan_abandoned_building_mr2_buddy_door_open;
  level._id_EC85["atom"]["group_split"] = % titan_stealth_street_group_split_eth3n;
  level._id_EC85["marine1"]["group_split_idle"][0] = % casual_crouch_idle;
  level._id_EC85["marine2"]["group_split_idle"][0] = % casual_crouch_idle;
  level._id_EC85["marine1"]["group_split"] = % titan_stealth_street_group_split_mr1;
  level._id_EC85["marine2"]["group_split"] = % titan_stealth_street_group_split_mr2;
  scripts\sp\anim::_id_17F6("atom", "mr1_start_jump", ::_id_869A, "group_split");
  scripts\sp\anim::_id_17F6("atom", "mr2_start_jump", ::_id_869B, "group_split");
  level._id_EC85["omar"]["pool_slide"] = % titan_stealth_street_mco_slide_into_pool;
  level._id_EC85["omar"]["pool_climb"] = % titan_stealth_street_walk_up_hill_mco;
  level._id_EC85["omar"]["fence_crawl"] = % titan_stealth_street_mco_prone_under_fence;
  level._id_EC85["generic"]["player_knife_kill"] = % titan_stealth_street_enemy01_melee_kill;
  level._id_EC85["generic"]["player_knife_kill_death"] = % titan_stealth_street_enemy01_melee_kill_death;
  level._id_EC85["generic"]["generic_react"] = % exposed_idle_reactb;
  level._id_EC85["generic"]["stealth_lean_idle"] = % titan_stealth_street_enemy_lean_idle;
  level._id_EC85["generic"]["wall_check_right"] = % titan_stealth_street_enemy01_walk_check_right;
  level._id_EC85["omar"]["cliffside_approach"] = % titan_refinery_approach_mco_intro;
  level._id_EC85["atom"]["cliffside_approach"] = % titan_refinery_approach_c6_intro;
  level._id_EC85["marine1"]["cliffside_approach"] = % titan_refinery_approach_marine1_intro;
  level._id_EC85["marine2"]["cliffside_approach"] = % titan_refinery_approach_marine2_intro;
  level._id_EC85["ally1"]["cliffside_approach"] = % titan_refinery_approach_ally05_intro;
  level._id_EC85["ally2"]["cliffside_approach"] = % titan_refinery_approach_ally06_intro;
  level._id_EC85["omar"]["cliffside_idle"][0] = % titan_refinery_approach_mco_idle;
  level._id_EC85["atom"]["cliffside_idle"][0] = % titan_refinery_approach_c6_idle;
  level._id_EC85["marine1"]["cliffside_idle"][0] = % titan_refinery_approach_marine1_idle;
  level._id_EC85["marine2"]["cliffside_idle"][0] = % titan_refinery_approach_marine2_idle;
  level._id_EC85["omar"]["cliffside_exit"] = % titan_refinery_approach_mco_exit;
  level._id_EC85["atom"]["cliffside_exit"] = % titan_refinery_approach_c6_exit;
  level._id_EC85["marine1"]["cliffside_exit"] = % titan_refinery_approach_marine1_exit;
  level._id_EC85["marine2"]["cliffside_exit"] = % titan_refinery_approach_marine2_exit;
  level._id_EC85["marine1"]["cliffside_chat"] = % titan_refinery_approach_marine1_chat;
  level._id_EC85["atom"]["cliffside_chat"] = % titan_refinery_approach_c6_chat;
  scripts\sp\anim::_id_17F6("omar", "titan_refinery_mr1_chat", ::_id_4216);
  scripts\sp\anim::_id_17F6("omar", "titan_refinery_c6i_chat", ::_id_4217);
  scripts\sp\anim::_id_17FA("omar", "trigger_plr_detach", "player_dropship_dismount", "intro_dropoff_scene_2");
  scripts\sp\anim::_id_17FA("marine1", "trigger_door_open", "player_dropship_door_open", "intro_dropoff_scene");
  scripts\sp\anim::_id_17FA("omar", "trigger_land", "intro_land_impact", "intro_dropoff_exit");
  level._id_EC85["omar"]["generic_takedown"] = % titan_stealth_street_ally01_takedown;
  level._id_EC85["atom"]["generic_takedown"] = % titan_stealth_street_ally01_takedown;
  level._id_EC85["enemy"]["generic_takedown"] = % titan_stealth_street_enemy01_takedown;
  scripts\sp\anim::_id_17F6("enemy", "start_ragdoll", ::_id_11463, "generic_takedown");
  scripts\sp\anim::_id_17F5("omar", "knife_on", "tactical_knife_iw7", "TAG_INHAND", "generic_takedown");
  scripts\sp\anim::_id_17FC("omar", "knife_on", "omar_takedown_knife_attached", "generic_takedown");
  scripts\sp\anim::_id_17F7("omar", "knife_off", "tactical_knife_iw7", "TAG_INHAND", "generic_takedown");
  scripts\sp\anim::_id_17FC("omar", "knife_off", "omar_takedown_knife_detached", "generic_takedown");
  scripts\sp\anim::_id_1800("enemy", "blood_spurt", "generic_takedown", "vfx_stab_blood_spurt", "j_neck");
  level._id_EC85["omar"]["water_wade_mid"] = % flood_ally_water_walking_mid;
  level._id_EC85["enemy"]["atom_takedown"] = % titan_stealth_street_enemy_takedown;
  level._id_EC85["atom"]["atom_takedown"] = % titan_stealth_street_eth3n_takedown;
  scripts\sp\anim::_id_17F6("atom", "interrupt_end", ::_id_244E, "atom_takedown");
  scripts\sp\anim::_id_17F6("enemy", "start_ragdoll", ::_id_244D, "atom_takedown");
  level._id_EC85["atom"]["ethan_street3_takedown"] = % titan_stealth_street_building_door_eth3n_takedown;
  level._id_EC85["enemy"]["ethan_street3_takedown"] = % titan_stealth_street_building_door_sdf_takedown;
  scripts\sp\anim::_id_17F6("enemy", "break_helmet", ::_id_11469, "ethan_street3_takedown");
  scripts\sp\anim::_id_17F6("enemy", "head_smash", ::_id_11468, "ethan_street3_takedown");
  var_0 = ["pa_sc_titan_bgs_ClearTwominutesto", "pa_sc_titan_bgs_Holdyourcocksand"];
  level._id_EC85["omar"]["grenade_toss"] = % covercrouch_grenadea;
  scripts\sp\anim::_id_17F6("omar", "grenade_throw", ::_id_C485, "grenade_toss");
  scripts\sp\anim::_id_17FC("omar", "grenade_throw", "grenade_release", "grenade_toss");
  level._id_EC88["omar"]["titan_omr_gottapressupthe"] = % titan_omr_gottapressupthe_face;
  level._id_EC88["omar"]["titan_omr_letsgetthisdoor"] = % titan_omr_letsgetthisdoor_face;
  level._id_EC88["omar"]["titan_usf_brookskashimawerepushing1"] = % titan_usf_brookskashimawerepushing1_face;

  foreach(var_2 in var_0)
  scripts\sp\anim::_id_17F6("omar", var_2, ::_id_5E5A, "intro_dropoff_scene_2");

  scripts\sp\anim::_id_17FA("atom", "vo_sc_titan_atm_Iwontletyou", "dropship_sfx_start", "intro_dropoff_scene");
  scripts\sp\anim::_id_17F6("omar", "vo_titan_usf_breathers", ::_id_6FE0, "intro_dropoff_scene_2");
  level._id_EC85["omar"]["beacon_intro"] = % titan_lz_dropship_call_mco_intro;
  scripts\sp\anim::_id_17F6("omar", "beacon_anim_start_mr1", ::_id_29DE);
  scripts\sp\anim::_id_17F6("omar", "beacon_anim_start_mr2", ::_id_29FA);
  level._id_EC85["atom"]["beacon_intro"] = % titan_lz_dropship_call_c6_intro;
  level._id_EC85["marine1"]["beacon_intro"] = % titan_lz_dropship_call_marine1_intro;
  level._id_EC85["marine2"]["beacon_intro"] = % titan_lz_dropship_call_marine2_intro;
  level._id_EC85["omar"]["beacon_idle"][0] = % titan_lz_dropship_call_mco_idle;
  level._id_EC85["atom"]["beacon_idle"][0] = % titan_lz_dropship_call_c6_idle;
  level._id_EC85["marine1"]["beacon_idle"][0] = % titan_lz_dropship_call_marine1_idle;
  level._id_EC85["marine2"]["beacon_idle"][0] = % titan_lz_dropship_call_marine2_idle;
  level._id_EC85["omar"]["beacon_nag"] = % titan_lz_dropship_call_mco_nag;
  level._id_EC85["omar"]["beacon_exit"] = % titan_lz_dropship_call_mco_exit;
  level._id_EC85["atom"]["beacon_exit"] = % titan_lz_dropship_call_c6_exit;
  level._id_EC85["marine1"]["beacon_exit"] = % titan_lz_dropship_call_marine1_exit;
  level._id_EC85["marine2"]["beacon_exit"] = % titan_lz_dropship_call_marine2_exit;
  scripts\sp\anim::_id_17F6("marine2", "beacon_anim_exit_c6", ::_id_29E0);
  scripts\sp\anim::_id_17F6("marine2", "beacon_anim_exit_mco", ::_id_29FD);
  level._id_EC85["omar"]["apc_dropoff"] = % titan_lzland_mco;
  level._id_EC85["omar"]["apc_dropoff_2"] = % titan_lzland_2_mco;
  level._id_EC85["marine2"]["apc_dropoff"] = % titan_lzland_marine2;
  level._id_EC85["marine1"]["apc_dropoff"] = % titan_lzland_marine1;
  level._id_EC85["apc_drop_redshirt"]["apc_dropoff"] = % titan_lzland_guy1;
  level._id_EC85["nunez"]["apc_dropoff"] = % titan_lzland_guy2;
  level._id_EC85["atom"]["apc_dropoff"] = % titan_lzland_c6;
  level._id_EC85["left_allies"]["c12_unhook"] = % titan_lz_land_guy_unhitch_c12;
  scripts\sp\anim::_id_17F6("omar", "clear", ::_id_1BF9);
  scripts\sp\anim::_id_17F6("omar", "hurrah", ::_id_1BFA);
  scripts\sp\anim::_id_17F6("marine1", "start_guys", ::_id_5D34);
  scripts\sp\anim::_id_17F6("marine1", "start_dropship", ::_id_5D33);
  level._id_EC85["atom"]["c12_revive"] = % titan_c12_fight_alliedc12_event01_getup_eth3n;
  level._id_EC85["bridge_guy_0"]["refinery_bridge_destruction"] = % titan_catwalk_crash_1_a;
  level._id_EC85["bridge_guy_1"]["refinery_bridge_destruction"] = % titan_catwalk_crash_1_b;
  level._id_EC85["bridge_guy_0"]["refinery_bridge_destruction_death"] = % titan_catwalk_crash_1_a_death;
  level._id_EC85["atom"]["bunker_scene"] = % titan_bunker_c6i_pcap;
  level._id_EC85["omar"]["bunker_scene"] = % titan_bunker_mco_pre_answer_pcap;
  level._id_EC85["omar"]["bunker_scene_cont"] = % titan_bunker_mco_post_answer_pcap;
  level._id_EC85["marine1"]["bunker_scene"] = % titan_bunker_mr1_pcap;
  level._id_EC85["marine2"]["bunker_scene"] = % titan_bunker_mr2_pcap;
  level._id_EC85["nunez"]["bunker_scene"] = % titan_bunker_ally01_pcap;
  level._id_EC85["redshirt1"]["bunker_scene"] = % titan_bunker_ally02_pcap;
  level._id_EC85["redshirt2"]["bunker_scene"] = % titan_bunker_ally03_pcap;
  level._id_EC85["redshirt3"]["bunker_scene"] = % titan_bunker_ally04_pcap;
  level._id_EC85["atom"]["bunker_scene_idle"][0] = % titan_bunker_c6i_elevator_idle_pcap;
  level._id_EC85["omar"]["bunker_scene_idle"][0] = % titan_bunker_mco_elevator_idle_pcap;
  level._id_EC85["marine1"]["bunker_scene_idle"][0] = % titan_bunker_mr1_elevator_idle_pcap;
  level._id_EC85["marine2"]["bunker_scene_idle"][0] = % titan_bunker_mr2_elevator_idle_pcap;
  level._id_EC85["redshirt1"]["bunker_scene_idle"][0] = % titan_bunker_ally02_elevator_idle_pcap;
  level._id_EC85["redshirt2"]["bunker_scene_idle"][0] = % titan_bunker_ally03_elevator_idle_pcap;
  level._id_EC85["redshirt3"]["bunker_scene_idle"][0] = % titan_bunker_ally04_elevator_idle_pcap;
  level._id_EC85["omar"]["bunker_nag"] = % titan_bunker_mco_elevator_idle_nag_pcap;
  level._id_EC85["atom"]["bunker_scene_exit"] = % titan_bunker_c6i_elevator_exit_pcap;
  level._id_EC85["omar"]["bunker_scene_exit"] = % titan_bunker_mco_elevator_exit_pcap;
  level._id_EC85["marine1"]["bunker_scene_exit"] = % titan_bunker_mr1_elevator_exit_pcap;
  level._id_EC85["marine2"]["bunker_scene_exit"] = % titan_bunker_mr2_elevator_exit_pcap;
  level._id_EC85["redshirt1"]["bunker_scene_exit"] = % titan_bunker_ally02_elevator_exit_pcap;
  level._id_EC85["redshirt2"]["bunker_scene_exit"] = % titan_bunker_ally03_elevator_exit_pcap;
  level._id_EC85["redshirt3"]["bunker_scene_exit"] = % titan_bunker_ally04_elevator_exit_pcap;
  level._id_EC85["atom"]["mount_jackal"] = % jackal_eth3n_mount_02_starboard;
  scripts\sp\anim::_id_17F6("omar", "pvo_titan_plr_wedontdieon", ::_id_CFA2);
  scripts\sp\anim::_id_17F6("omar", "pvo_titan_plr_weholdhereand", ::_id_D0DE);
}

_id_11463(var_0) {
  if(isDefined(var_0._id_B14F))
    var_0 scripts\sp\utility::_id_1101B();

  var_0 _meth_83A1();
  var_0 _meth_81D0();
  var_0 startragdoll();
}

_id_244D(var_0) {
  thread _id_2450();

  if(isDefined(var_0._id_B14F))
    var_0 scripts\sp\utility::_id_1101B();

  var_0.allowdeath = 1;
  var_0.a.nodeath = 1;
  var_0 scripts\sp\utility::_id_F2DA(0);
  var_0 _meth_81D0();
}

_id_2450() {
  var_0 = scripts\engine\utility::getStructArray("atom_phys_pulse", "targetname");

  foreach(var_2 in var_0)
  physicsexplosionsphere(var_2.origin, 20, 10, 0.15);
}

_id_244E(var_0) {
  var_0._id_38DE = 1;
}

_id_31F1() {
  level._id_EC85["omar"]["wall_response"] = % titan_abandoned_building_ally01_wall_scene_response;
  level._id_EC85["marine1"]["wall_response"] = % titan_abandoned_building_mr1_wall_scene_response;
  level._id_EC85["marine2"]["wall_response"] = % titan_abandoned_building_mr2_wall_scene_response;
}

#using_animtree("jackal");

_id_A056() {
  level._id_EC87["ow_enemy_jackal_00"] = #animtree;
  level._id_EC85["ow_enemy_jackal_00"]["ow_enemy_attack"] = % titan_ow_enemy_jack01_strafe;
  scripts\sp\anim::_id_17F6("ow_enemy_jackal_00", "fire_ally_missiles", ::_id_F226);
  level._id_EC87["ow_enemy_jackal_01"] = #animtree;
  level._id_EC85["ow_enemy_jackal_01"]["ow_enemy_attack"] = % titan_ow_enemy_jack02_strafe;
  level._id_EC87["ow_enemy_jackal_02"] = #animtree;
  level._id_EC85["ow_enemy_jackal_02"]["ow_enemy_attack"] = % titan_ow_enemy_jack03_strafe;
  level._id_EC87["ow_enemy_jackal_03"] = #animtree;
  level._id_EC85["ow_enemy_jackal_03"]["ow_enemy_attack"] = % titan_ow_enemy_jack04_strafe;
  level._id_EC87["ow_enemy_jackal_04"] = #animtree;
  level._id_EC85["ow_enemy_jackal_04"]["ow_enemy_attack"] = % titan_ow_enemy_jack05_strafe;
  level._id_EC87["ow_enemy_jackal_05"] = #animtree;
  level._id_EC85["ow_enemy_jackal_05"]["ow_enemy_attack"] = % titan_ow_enemy_jack06_strafe;
  level._id_EC87["ow_enemy_jackal_06"] = #animtree;
  level._id_EC85["ow_enemy_jackal_06"]["ow_enemy_attack"] = % titan_ow_enemy_jack07_strafe;
  scripts\sp\anim::_id_17F6("ow_enemy_jackal_00", "flyby_fx", ::_id_6FFC);
  scripts\sp\anim::_id_17F6("ow_enemy_jackal_01", "flyby_fx", ::_id_6FFC);
  scripts\sp\anim::_id_17F6("ow_enemy_jackal_02", "flyby_fx", ::_id_6FFC);
  scripts\sp\anim::_id_17F6("ow_enemy_jackal_05", "flyby_fx", ::_id_6FFC);
  scripts\sp\anim::_id_17F6("ow_enemy_jackal_06", "flyby_fx", ::_id_6FFC);
  level._id_EC87["ow_ally_jackal_00"] = #animtree;
  level._id_EC85["ow_ally_jackal_00"]["ow_ally_attack"] = % titan_ow_ally_jack01_flyby;
  level._id_EC87["ow_ally_jackal_01"] = #animtree;
  level._id_EC85["ow_ally_jackal_01"]["ow_ally_attack"] = % titan_ow_ally_jack02_flyby;
  level._id_EC87["ow_ally_jackal_02"] = #animtree;
  level._id_EC85["ow_ally_jackal_02"]["ow_ally_attack"] = % titan_ow_ally_jack03_flyby;
  level._id_EC87["ow_ally_jackal_03"] = #animtree;
  level._id_EC85["ow_ally_jackal_03"]["ow_ally_attack"] = % titan_ow_ally_jack04_flyby;
  level._id_EC87["ow_ally_jackal_04"] = #animtree;
  level._id_EC85["ow_ally_jackal_04"]["ow_ally_attack"] = % titan_ow_ally_jack05_flyby;
  level._id_EC87["ow_ally_jackal_05"] = #animtree;
  level._id_EC85["ow_ally_jackal_05"]["ow_ally_attack"] = % titan_ow_ally_jack06_flyby;
  level._id_EC87["ow_ally_jackal_06"] = #animtree;
  level._id_EC85["ow_ally_jackal_06"]["ow_ally_attack"] = % titan_ow_ally_jack07_flyby;
  level._id_EC87["salter"] = #animtree;
  level._id_EC85["salter"]["ow_ally_arrival"] = % titan_jackal_reveal_salter;
  scripts\sp\anim::_id_17F6("salter", "hover", ::_id_F431);
  level._id_EC87["player_jackal"] = #animtree;
  level._id_EC85["player_jackal"]["ow_ally_arrival"] = % titan_jackal_reveal_vehicle;
  scripts\sp\anim::_id_17F6("player_jackal", "hover", ::_id_F431);
  level._id_EC85["player_jackal"]["ow_ally_arrival_idle"][0] = % titan_jackal_reveal_vehicle_idle;
}

#using_animtree("vehicles");

_id_13267() {
  level._id_EC85["apc"]["dropoff1"] = % iw7_scripted_titan_beacon_dropoff_apc;
  level._id_EC85["dropship"]["dropoff1"] = % iw7_scripted_titan_beacon_dropoff_dropship;
  level._id_EC85["dropship"]["c12_dropoff"] = % titan_c12_fight_dropship_dropoff;
  level._id_EC85["apc"]["second_gate_breakthrough"] = % titan_second_gate_breakthrough_apc;
  level._id_EC85["apc"]["mons_crash_apc"] = % titan_mons_bombardment_apc;
  level._id_EC85["apc"]["gate_crash_1"] = % titan_first_gate_breakthrough_apc01;
  level._id_EC85["apc"]["gate_crash_refinery"] = % titan_refinery_gate_breakthrough_apc;
  level._id_EC85["jeep"]["jeep_punch"] = % titan_hill_refinery_space_jeep_01_toss;
  level._id_EC85["dropship_flyin"]["dropship_door_open"] = % vh_dropship_front_door_right_open_no_stairs;
  level._id_EC85["dropship_flyin"]["dropship_door_close"] = % vh_dropship_front_door_right_close_no_stairs;
  level._id_EC87["apc_anim"] = #animtree;
  level._id_EC8C["apc_anim"] = "veh_mil_lnd_un_apc_drive";
  level._id_EC85["apc_anim"]["mons_door_open"] = % titan_bunker_bombardment_apc_getin;
  level._id_EC87["salter_mons_arrival"] = #animtree;
  level._id_EC8C["salter_mons_arrival"] = "veh_mil_air_un_jackal_02";
  level._id_EC85["salter_mons_arrival"]["salter_arrival"] = % titan_bringinjackal_sltjackal_arrival;
  level._id_EC87["plyr_jackal_mons_arrival"] = #animtree;
  level._id_EC8C["plyr_jackal_mons_arrival"] = "veh_mil_air_un_jackal_02";
  level._id_EC85["plyr_jackal_mons_arrival"]["salter_arrival"] = % titan_bringinjackal_plrjackal_arrival;
  level._id_EC87["mons_intro_jackal"] = #animtree;
  level._id_EC8C["mons_intro_jackal"] = "veh_mil_air_un_jackal_02";
  level._id_EC85["mons_intro_jackal"]["door_crash"] = % titan_bunker_bombardment_jackal_getin;
  level._id_EC85["dropship"]["apc_dropoff"] = % titan_lz_land_dropship_enter;
  scripts\sp\anim::_id_17F6("dropship", "landing", ::_id_2080);
  level._id_EC85["apc"]["apc_dropoff"] = % titan_lz_land_apc_enter;
  level._id_EC85["dropship"]["apc_dropoff_idle"][0] = % titan_lz_land_dropship_idle;
  level._id_EC85["dropship"]["apc_dropoff_exit"] = % titan_lz_land_dropship_exit;
}

#using_animtree("script_model");

_id_EE25() {
  level._id_EC87["light_tower"] = #animtree;
  level._id_EC8C["light_tower"] = "ctl_light_stadium_tower_on";
  level._id_EC85["light_tower"]["fall_down"] = % titan_gate_light_fall;
  level._id_EC87["second_gate"] = #animtree;
  level._id_EC8C["second_gate"] = "gate_perimeter_01";
  level._id_EC85["second_gate"]["gate_crash_1"] = % titan_first_gate_breakthrough_gate;
  level._id_EC85["second_gate"]["gate_crash_refinery"] = % titan_refinery_gate_breakthrough_gate;
  level._id_EC87["refinery_gate"] = #animtree;
  level._id_EC8C["refinery_gate"] = "fence_modular_titan_01";
  level._id_EC85["refinery_gate"]["second_gate_breakthrough"] = % titan_second_gate_breakthrough_gate;
  level._id_EC87["poster_rip"] = #animtree;
  level._id_EC8C["poster_rip"] = "decor_titan_propaganda_poster_01";
  level._id_EC85["poster_rip"]["wall_response"] = % titan_abandoned_building_poster_wall_scene_response;
  level._id_EC87["building1_debris"] = #animtree;
  level._id_EC8C["building1_debris"] = "building_pod_wall_panel_21_thick_titan";
  level._id_EC85["building1_debris"]["building1_exit"] = % titan_abandoned_building_debris_buddy_door_open;
  level._id_EC87["building1_door"] = #animtree;
  level._id_EC8C["building1_door"] = "door_pod_interior_single_01";
  level._id_EC85["building1_door"]["building1_exit"] = % titan_abandoned_building_door_buddy_door_open;
  level._id_EC87["player_helmet"] = #animtree;
  level._id_EC8C["player_helmet"] = "helmet_un_jackal_pilots_generic";
  level._id_EC85["player_helmet"]["visor_down"] = % titan_dropship_helmetplr_exit;
  level._id_EC87["dropship_seat_mount01"] = #animtree;
  level._id_EC8C["dropship_seat_mount01"] = "equipment_industrial_weapon_mount_01";
  level._id_EC85["dropship_seat_mount01"]["seat_mount_ff"] = % titan_dropship_weapon_mount_01;
  level._id_EC87["dropship_seat_mount02"] = #animtree;
  level._id_EC8C["dropship_seat_mount02"] = "equipment_industrial_weapon_mount_01";
  level._id_EC85["dropship_seat_mount02"]["seat_mount_ff"] = % titan_dropship_weapon_mount_02;
  level._id_EC8C["dropship_seat"] = "veh_mil_air_un_dropship_seat";
  level._id_EC85["dropship_seat"]["empty_seat_ff"] = % shipcrib_dropship_seat_closed;
  level._id_EC85["dropship_seat_middle_01"]["dropship_intro"] = % titan_dropship_seat01_intro;
  level._id_EC85["dropship_seat_right_02"]["dropship_intro"] = % titan_dropship_seat03_intro;
  level._id_EC85["dropship_seat_middle_02"]["dropship_intro"] = % titan_dropship_seat06_intro;
  level._id_EC87["dropship_seat07"] = #animtree;
  level._id_EC8C["dropship_seat07"] = "veh_mil_air_un_dropship_seat";
  level._id_EC85["dropship_seat_left_01"]["dropship_intro"] = % titan_dropship_seat07_intro;
  level._id_EC85["dropship_seat07"]["dropship_player_seat_exit"] = % titan_dropship_seat07_exit;
  level._id_EC85["dropship_seat_left_01"]["plr_enter_seat"] = % shipcrib_titan_10_seat07_enter_seat;
  level._id_EC85["dropship_seat_right_01"]["dropship_intro"] = % titan_dropship_seat08_intro;
  level._id_EC87["forklift"] = #animtree;
  level._id_EC8C["forklift"] = "vehicle_forklift";
  level._id_EC85["forklift"]["c12_dropoff"] = % titan_c12_fight_forklift_dropoff;
  level._id_EC87["pallet"] = #animtree;
  level._id_EC8C["pallet"] = "automated_pallet_mover_01";
  level._id_EC85["pallet"]["apc_dropoff"] = % titan_lz_land_pallet_enter;
  level._id_EC85["pallet"]["c12_unhook"] = % titan_lz_land_pallet_unhitch;
  level._id_EC85["second_gate"]["apc_dropoff_gate"] = % titan_first_gate_breakthrough_gate;
  scripts\sp\anim::_id_17F6("second_gate", "fence_wobble_a", ::_id_355C);
  level._id_EC87["side_gate"] = #animtree;
  level._id_EC85["side_gate"]["apc_dropoff_gate"] = % vfx_titan_c12_gate;
  level._id_EC87["retribution"] = #animtree;
  level._id_EC85["retribution"]["ow_arrival"] = % titan_exit_the_bunker_retribution;
  level._id_EC87["ow_gate"] = #animtree;
  level._id_EC8C["ow_gate"] = "tag_origin";
  level._id_EC85["ow_gate"]["bunker_door_lift_intro"] = % titan_exit_the_bunker_door_doorlift_exit;
  level._id_EC87["refinery_destroy_bridge"] = #animtree;
  level._id_EC8C["refinery_destroy_bridge"] = "veh_mil_air_un_dropship_seat";
  level._id_EC85["refinery_destroy_bridge"]["refinery_bridge_destruction"] = % titan_catwalk_crash_bridge_1;
  level._id_EC87["bunker_gate"] = #animtree;
  level._id_EC85["bunker_gate"]["bunker_scene_exit"] = % titan_bunker_gate_mco_kick_doors_open;
  level._id_EC87["elevator_panel_01"] = #animtree;
  level._id_EC85["elevator_panel_01"]["elevator_door_open"] = % titan_bunker_elevator_door_open_pannel_01;
  level._id_EC85["elevator_panel_01"]["elevator_door_close"] = % titan_bunker_elevator_door_close_pannel_01;
  level._id_EC87["elevator_panel_02"] = #animtree;
  level._id_EC85["elevator_panel_02"]["elevator_door_open"] = % titan_bunker_elevator_door_open_pannel_02;
  level._id_EC85["elevator_panel_02"]["elevator_door_close"] = % titan_bunker_elevator_door_close_pannel_02;
  level._id_EC87["elevator_panel_03"] = #animtree;
  level._id_EC85["elevator_panel_03"]["elevator_door_open"] = % titan_bunker_elevator_door_open_pannel_03;
  level._id_EC85["elevator_panel_03"]["elevator_door_close"] = % titan_bunker_elevator_door_close_pannel_03;
  level._id_EC87["elevator_panel_04"] = #animtree;
  level._id_EC85["elevator_panel_04"]["elevator_door_open"] = % titan_bunker_elevator_door_open_pannel_04;
  level._id_EC85["elevator_panel_04"]["elevator_door_close"] = % titan_bunker_elevator_door_close_pannel_04;
  level._id_EC87["elevator_panel_05"] = #animtree;
  level._id_EC85["elevator_panel_05"]["elevator_door_open"] = % titan_bunker_elevator_door_open_pannel_05;
  level._id_EC85["elevator_panel_05"]["elevator_door_close"] = % titan_bunker_elevator_door_close_pannel_05;
}

#using_animtree("destructibles");

_id_5379() {
  level._id_EC87["wind_turbine"] = #animtree;
  level._id_EC85["wind_turbine"]["rotate"] = % tag_rotate_z;
}

#using_animtree("player");

_id_CF61() {
  level._id_EC87["player_rig"] = #animtree;
  level._id_EC8C["player_rig"] = "viewmodel_base_animated_desert";
  level._id_EC85["player_rig"]["plr_enter_seat"] = % shipcrib_titan_10_plr_enter_seat;
  level._id_EC85["player_rig"]["intro_dropoff_scene"] = % titan_dropship_plr_intro;
  level._id_EC85["player_rig"]["intro_dropoff_exit"] = % titan_dropship_plr_exit;
  level._id_EC85["player_rig"]["building1_exit"] = % titan_abandoned_building_plr_buddy_door_open;
  level._id_EC85["player_rig"]["player_knife_kill"] = % titan_stealth_street_plr_melee_kill;
  level._id_EC85["player_rig"]["atm_pick_up"] = % titan_mons_intro_player_pickup;
  level._id_EC85["player_rig"]["mons_knock_down"] = % titan_mons_intro_player_knockback;
  level._id_EC85["player_rig"]["mons_knock_down_idle"][0] = % titan_mons_intro_player_idle;
  level._id_EC85["player_rig"]["knife_swipe"] = % vm_default_knife_slice_scripted;
  level._id_EC85["player_rig"]["squeeze_through_intro"] = % titan_stealth2_squeeze_through_hallway_player_intro;
  level._id_EC85["player_rig"]["squeeze_through"] = % titan_stealth2_squeeze_through_hallway_player;
  scripts\sp\anim::_id_17FF("player_rig", "ps_scn_titan_squeeze_through_mvmt_plr", "squeeze_through", "scn_titan_squeeze_through_mvmt_plr");
  level._id_EC85["player_rig"]["squeeze_through_exit"] = % titan_stealth2_squeeze_through_hallway_player_response;
  level._id_EC85["player_rig"]["bunker_door_lift_intro"] = % titan_exit_the_bunker_plr_doorlift_exit;
  level._id_EC85["player_rig"]["player_rpodeo"] = % titan_c12_rodeo_player_dismount;
  level.player._id_1E9C = scripts\sp\utility::_id_10639("player_rig", level.player.origin, level.player.angles);
  level.player._id_1E9C hide();
}

#using_animtree("c12");

_id_3508() {
  level._id_EC85["friendly_c12"]["c12_dropoff"] = % titan_c12_fight_alliedc12_dropoff;
  level._id_EC85["friendly_c12"]["second_gate_breakthrough"] = % titan_second_gate_breakthrough_c12;
  level._id_EC85["friendly_c12"]["slide_down"] = % titan_hill_refinery_c12_hill_slide;
  level._id_EC85["friendly_c12"]["jeep_punch"] = % titan_hill_refinery_c12_jeep_toss;
  level._id_EC85["friendly_c12"]["apc_dropoff"] = % titan_lz_land_c12_enter;
  level._id_EC85["friendly_c12"]["apc_dropoff_exit"] = % titan_lz_land_c12_exit;
  level._id_EC85["friendly_c12"]["apc_dropoff_idle"][0] = % titan_lz_land_c12_idle;
  level._id_EC85["friendly_c12"]["apc_dropoff_gate"] = % titan_first_gate_breakthrough_c12;
  scripts\sp\anim::_id_17F6("friendly_c12", "start_dropship_guys", ::_id_10C23);
  scripts\sp\anim::_id_17F6("friendly_c12", "start_marine1", ::_id_10C21);
  level._id_EC85["enemy_c12"]["c12_dropoff"] = % titan_c12_fight_enemyc12_dropoff;
  level._id_EC85["stealth_c12"]["stealth_idle"][0] = % titan_stealth_street_c12_idle;
}

_id_5E5A(var_0) {
  level notify("dropship_line");
}

_id_6FE0(var_0) {
  scripts\engine\utility::flag_set("dropship_fly_sfx");
  scripts\engine\utility::flag_set_delayed("freefall_vo_complete", 1.5);
}

_id_29DE(var_0) {
  level._id_B33B notify("beacon_intro");
}

_id_29FA(var_0) {
  level._id_B33E notify("beacon_intro");
}

_id_29E0(var_0) {
  var_1 = scripts\engine\utility::getStruct("apc_drop_script_node", "targetname");
  var_1 notify(level._id_2429._id_1FBB + "stop_beacon_idle");
}

_id_29FD(var_0) {
  var_1 = scripts\engine\utility::getStruct("apc_drop_script_node", "targetname");
  var_1 notify(level._id_C47F._id_1FBB + "stop_beacon_idle");
}

_id_10C21(var_0) {
  level notify("walk_allies_up");
}

_id_10C23(var_0) {
  level notify("start_LZ_dropship_guys");
}

_id_5D34(var_0) {
  level notify("start_dropoff_guys");
}

_id_5D33(var_0) {
  level notify("start_dropoff_dropship");
}

_id_4216(var_0) {
  level._id_B33B._id_1EB7 notify("stop_loop");
  level._id_B33B._id_1EB7 scripts\sp\anim::_id_1F35(level._id_B33B, "cliffside_chat");

  if(scripts\engine\utility::flag("base_alerted") == 0)
    level._id_B33B._id_1EB7 thread scripts\sp\anim::_id_1EEA(level._id_B33B, "cliffside_idle", "stop_loop");
}

_id_4217(var_0) {
  scripts\engine\utility::flag_set("ethan_cliffside_chat");
}

_id_30FA(var_0) {
  wait 1.5;
  level._id_B33B scripts\sp\utility::_id_10346("titan_ksh_Shityeahthatswhat");
}

_id_5E33(var_0) {
  level.player playSound("titan_plt3_Battletaxisonthedeck");
}

_id_2080(var_0) {
  var_1 = scripts\engine\utility::getStructArray("beacon_holo", "targetname");

  foreach(var_3 in var_1)
  var_3 notify("landed");

  level._id_B33B thread scripts\sp\utility::_id_77B7("arm_up");
  wait 0.6;
  level._id_B33E scripts\sp\utility::_id_77B7("arm_up");
  level waittill("apc_dropship_drop_complete");
  wait 6;
}

_id_355C(var_0) {
  var_1 = getEnt("gate_crash_1_sides", "targetname");
  var_1._id_1FBB = "side_gate";
  var_1 scripts\sp\utility::_id_23B7();
  var_1 thread scripts\sp\anim::_id_1F35(var_1, "apc_dropoff_gate");
}

_id_F226(var_0) {
  scripts\engine\utility::flag_set("send_ow_allies");
}

_id_B504(var_0) {
  level._id_C47F scripts\sp\utility::_id_7799(level.player);
}

_id_CFA2(var_0) {
  level.player scripts\sp\utility::_id_D090("ges_titan_bunker");
}

_id_D208(var_0) {
  level.player scripts\sp\utility::_id_D090("ges_nod", 0);
}

_id_D0DE(var_0) {
  level.player scripts\sp\utility::_id_D090("ges_hold_here", 0);
  wait 4;
}

_id_D065(var_0) {
  level._id_EC8E["fallback"] = "titan_plr_ivegotsomemanual";
  level.player scripts\sp\utility::_id_D01E("fallback", 0, "ges_fall_back", 0);
}

_id_1BF9(var_0) {
  level.player scripts\sp\utility::_id_10353("titan_grp_clear");
}

_id_1BFA(var_0) {
  level._id_B33E playSound("titan_ksh_hoorah");
  level.player scripts\sp\utility::_id_10350("titan_plr_hoorah");
}

_id_6FFC(var_0) {
  wait 1;
  var_1 = 1000;
  var_2 = 2.6;
  screenshake(self.origin, var_2 * 0.5, var_2, var_2 * 0.5, 0.5, 0, -1, var_1, 5, 0.2, 2);
}

_id_F431(var_0) {
  var_0 thread _id_0C1A::_id_A3B6("hover", 1.0);
  var_0 thread _id_0C20::_id_A3B7("hover");
}

_id_53F7() {
  foreach(var_1 in level._id_B351)
  var_1 scripts\sp\maps\titan\titan_code::_id_134B7("");
}

#using_animtree("generic_human");

_id_11112() {
  var_0 = [];
  var_0["omar"]["intro"] = % titan_inst_buddy_door_mco_pcap_intro;
  var_0["omar"]["idle"] = % titan_inst_buddy_door_mco_pcap_idle;
  var_0["omar"]["pull"] = % titan_inst_buddy_door_mco_pcap_pull;
  var_0["omar"]["outro"] = % titan_inst_buddy_door_mco_pcap_exit;
  var_0["atom"]["outro"] = % titan_inst_buddy_door_c6i_pcap_exit;
  return var_0;
}

#using_animtree("player");

_id_11113() {
  var_0 = [];
  var_0["door_player_rig"]["intro"] = % titan_inst_buddy_door_plr_pcap_intro;
  var_0["door_player_rig"]["idle"] = % titan_inst_buddy_door_plr_pcap_idle;
  var_0["door_player_rig"]["pull"] = % titan_inst_buddy_door_plr_pcap_pull;
  var_0["door_player_rig"]["outro"] = % titan_inst_buddy_door_plr_pcap_exit;
  return var_0;
}

#using_animtree("script_model");

_id_11111() {
  var_0 = [];
  var_0["door"]["intro"] = % titan_inst_buddy_door_door_pcap_intro;
  var_0["door"]["idle"] = % titan_inst_buddy_door_door_pcap_idle;
  var_0["door"]["pull"] = % titan_inst_buddy_door_door_pcap_pull;
  var_0["door"]["outro"] = % titan_inst_buddy_door_door_pcap_exit;
  return var_0;
}

#using_animtree("generic_human");

_id_3264() {
  var_0 = [];
  var_0["atom"]["intro"] = % titan_bunker_c6i_buddy_door_intro;
  var_0["atom"]["idle"] = % titan_bunker_c6i_buddy_door_idle;
  var_0["atom"]["pull"] = % titan_bunker_c6i_buddy_door_pull;
  var_0["atom"]["outro"] = % titan_bunker_c6i_buddy_door_enter_pcap;
  var_0["marine1"]["outro"] = % titan_bunker_mr1_buddy_door_enter_pcap;
  var_0["marine2"]["outro"] = % titan_bunker_mr2_buddy_door_enter_pcap;
  var_0["omar"]["outro"] = % titan_bunker_mco_buddy_door_enter_pcap;
  var_0["nunez"]["outro"] = % titan_bunker_ally01_buddy_door_enter_pcap;
  var_0["redshirt1"]["outro"] = % titan_bunker_ally02_buddy_door_enter_pcap;
  var_0["redshirt2"]["outro"] = % titan_bunker_ally03_buddy_door_enter_pcap;
  var_0["redshirt3"]["outro"] = % titan_bunker_ally04_buddy_door_enter_pcap;
  return var_0;
}

#using_animtree("player");

_id_3265() {
  var_0 = [];
  var_0["door_player_rig"]["intro"] = % titan_bunker_plr_buddy_door_intro;
  var_0["door_player_rig"]["idle"] = % titan_bunker_plr_buddy_door_idle;
  var_0["door_player_rig"]["pull"] = % titan_bunker_plr_buddy_door_pull;
  var_0["door_player_rig"]["outro"] = % titan_bunker_plr_buddy_door_enter_pcap;
  return var_0;
}

#using_animtree("script_model");

_id_3263() {
  var_0 = [];
  var_0["door"]["idle"] = % titan_bunker_door_buddy_door_idle;
  var_0["door"]["pull"] = % titan_bunker_door_buddy_door_pull;
  var_0["door"]["outro"] = % titan_bunker_door_buddy_door_enter_pcap;
  return var_0;
}

_id_869A(var_0) {
  level._id_B33B notify("stop_group_split_idle");
  var_1 = scripts\engine\utility::getStruct("group_split_animnode", "targetname");
  var_1 scripts\sp\anim::_id_1F35(level._id_B33B, "group_split");
  level._id_B33B scripts\sp\utility::_id_61C7();
}

_id_869B(var_0) {
  level._id_B33E notify("stop_group_split_idle");
  var_1 = scripts\engine\utility::getStruct("group_split_animnode", "targetname");
  var_1 thread scripts\sp\anim::_id_1F35(level._id_B33E, "group_split");
  level._id_B33E scripts\sp\utility::_id_61C7();
}

#using_animtree("generic_human");

_id_C48D(var_0) {
  level._id_C47F _meth_82A2(%mayhem_titan_stealth2_squeeze_through_mco, 1.0, 0.0, 1.0);
  level._id_C47F detach(level._id_C47F.headmodel);
}

_id_C48C(var_0) {
  level._id_C47F clearanim(%mayhem_titan_stealth2_squeeze_through_mco, 0.0);
  level._id_C47F attach(level._id_C47F.headmodel);
}

_id_C485(var_0) {
  var_1 = _id_0F27::_id_79F5("streets3_final");
  var_2 = scripts\engine\utility::getStruct("streets3_grenade_target", "targetname").origin;
  var_3 = level._id_C47F gettagorigin("tag_inhand");
  var_4 = var_2 - var_3;

  foreach(var_0 in var_1) {
    var_0.grenadeawareness = 0;
    var_0.ignoreall = 1;
  }

  var_7 = level._id_C47F _meth_81EE(var_3, var_4 * 2.5, 4);
  wait 1;
  var_8 = scripts\engine\utility::getStruct("streets3_grenade_location", "targetname").origin;
  var_9 = magicgrenade("antigrav", var_8, var_8, 1, 0);
  thread _id_0E21::_id_2013(var_9);
  var_7 delete();

  foreach(var_0 in var_1) {
    if(isalive(var_0)) {
      var_0 scripts\sp\utility::_id_F415(1);
      var_0 scripts\sp\utility::_id_F416(1);
      var_0.health = 45;
    }
  }

  level waittill("antigrav_done");
  var_1 = scripts\sp\utility::array_removedeadvehicles(var_1);

  if(var_1.size > 0 && !scripts\engine\utility::flag("stealth_spotted")) {
    scripts\engine\utility::flag_set("stealth_spotted");

    foreach(var_0 in var_1) {
      var_0 scripts\sp\utility::_id_F415(0);
      var_0 scripts\sp\utility::_id_F416(0);
      var_0.grenadeawareness = 1;
      var_0.health = 150;
      var_0 _meth_84F7("attack", level.player, level.player.origin);
    }
  }
}

_id_11469(var_0) {
  var_0 _id_0C60::_id_8E17();
  earthquake(0.5, 0.4, var_0.origin, 256);
}

_id_11468(var_0) {
  earthquake(0.4, 0.3, var_0.origin, 256);
  scripts\engine\utility::exploder("head_bash_blood");
}