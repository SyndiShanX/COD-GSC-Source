/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\ny_harbor_anim.gsc
*******************************************/

main() {
  _id_47D9();
  _id_4CAE();
  _id_47DA();
  _id_6872();
  _id_4CAB();
  _id_686D();
  _id_686F();
  _id_686E();
  _id_6870();
  _id_6871();
  _id_4CAC();
  _id_47E3();
  _id_4CAD();
  _id_686C();
  _id_686A::main();
  _id_686B::main();
  _id_47D8();
}

#using_animtree("script_model");

_id_686C() {
  level._id_1245["missile_key_player"] = #animtree;
  level._id_1F90["missile_key_player"] = "ny_harbor_missle_key";
  level._id_0C59["missile_key_player"]["sub_turn_key"] = % ny_harbor_missle_key_player_toss;
  level._id_1245["missile_key_sandman"] = #animtree;
  level._id_1F90["missile_key_sandman"] = "ny_harbor_missle_key";
  level._id_0C59["missile_key_sandman"]["sub_turn_key"] = % ny_harbor_missle_key_sandman_key;
}

#using_animtree("player");

_id_47D9() {
  level._id_1245["player_sdv_rig"] = #animtree;
  level._id_1245["player_sdv_legs"] = #animtree;
  level._id_1F90["player_sdv_legs"] = "viewlegs_generic";
  level._id_1F90["player_sdv_rig"] = "viewhands_player_udt";
  level._id_0C59["player_sdv_rig"]["sdv_idle"][0] = % harbor_player_sdv_idle;
  level._id_0C59["player_sdv_rig"]["sdv"]["idle"] = % harbor_player_sdv_idle;
  level._id_0C59["player_sdv_rig"]["sdv"]["turn_down"] = % harbor_player_sdv_turn_down;
  level._id_0C59["player_sdv_rig"]["sdv"]["turn_up"] = % harbor_player_sdv_turn_up;
  level._id_0C59["player_sdv_rig"]["sdv"]["turn_right"] = % harbor_player_sdv_turn_right;
  level._id_0C59["player_sdv_rig"]["sdv"]["turn_left"] = % harbor_player_sdv_turn_left;
  level._id_0C59["player_sdv_rig"]["tunnel_intro"] = % ny_harbor_underwater_cutting_player;
  maps\_anim::_id_1264("player_sdv_rig", "rumble_medium", ::_id_012B, "tunnel_intro");
  maps\_anim::_id_1264("player_sdv_rig", "rumble_large", ::_id_012C, "tunnel_intro");
  level._id_0C59["player_sdv_rig"]["tunnel_spline"] = % ny_harbor_underwater_cutting_player_pt2;
  level._id_0C59["player_sdv_rig"]["mine_plant"] = % ny_harbor_wetsub_plantmine_player;
  level._id_0C59["player_sdv_rig"]["ny_harbor_door_breach"] = % ny_harbor_door_breach_player;
  maps\_anim::_id_1264("player_sdv_rig", "Start_slowdown", maps\ny_harbor_code_sub::_id_4BBC, "ny_harbor_door_breach");
  maps\_anim::_id_1264("player_sdv_rig", "Blow_charge", maps\ny_harbor_code_sub::_id_4BBA, "ny_harbor_door_breach");
  maps\_anim::_id_1264("player_sdv_rig", "rumble_large", ::_id_012C, "ny_harbor_door_breach");
  level._id_0C59["player_sdv_rig"]["sub_turn_key"] = % ny_harbor_missle_key_player_turnkey;
  level._id_0C59["player_sdv_rig"]["player_ladder_slide"] = % ny_harbor_ladder_slide_player;
  maps\_anim::_id_1264("player_sdv_rig", "rumble_small", ::_id_012A, "player_ladder_slide");
  maps\_anim::_id_1264("player_sdv_rig", "rumble_meduim", ::_id_012B, "player_ladder_slide");
  maps\_anim::_id_1264("player_sdv_rig", "rumble_large", ::_id_012C, "player_ladder_slide");
  level._id_0C59["player_sdv_rig"]["surfacing"] = % ny_harbor_sub_surface_player;
  level._id_0C59["player_sdv_rig"]["boarding"] = % ny_harbor_sub_surface_player_pt2;
  level._id_0C59["player_sdv_rig"]["exit_to_zodiac"] = % ny_harbor_sub_exit_player;
  level._id_0C59["player_sdv_legs"]["exit_to_zodiac"] = % ny_harbor_sub_exit_legs;
  level._id_0C59["player_sdv_rig"]["finale_escape"] = % ny_harbor_finale_airlift_player_end;
  level._id_0C59["player_sdv_rig"]["carrier_start"] = % ny_harbor_finale_bump_player_start;
  level._id_0C59["player_sdv_rig"]["carrier_end"] = % ny_harbor_finale_bump_player_end;
}

#using_animtree("generic_human");

_id_4CAE() {
  level._id_1245["floating_body"] = #animtree;
  level._id_0C59["generic"]["harbor_drowning_01"] = % harbor_drowning_01;
  level._id_0C59["generic"]["harbor_drowning_01_idle"][0] = % harbor_drowning_01_idle;
  level._id_0C59["generic"]["harbor_drowning_02"] = % harbor_drowning_02;
  level._id_0C59["generic"]["harbor_drowning_02_idle"][0] = % harbor_drowning_02_idle;
  level._id_0C59["generic"]["harbor_drowning_03"] = % harbor_drowning_03;
  level._id_0C59["generic"]["harbor_drowning_03_idle"][0] = % harbor_drowning_03_idle;
  level._id_0C59["generic"]["harbor_floating_idle_01"][0] = % harbor_floating_idle_01;
  level._id_0C59["generic"]["harbor_floating_idle_02"][0] = % harbor_floating_idle_02;
  level._id_0C59["generic"]["harbor_floating_idle_03"][0] = % harbor_floating_idle_03;
  level._id_0C59["generic"]["harbor_floating_idle_04"][0] = % harbor_floating_idle_04;
  level._id_0C59["generic"]["harbor_floating_struggle_01"][0] = % harbor_floating_struggle_01;
  level._id_0C59["generic"]["harbor_floating_struggle_02"][0] = % harbor_floating_struggle_02;
  level._id_0C59["generic"]["zodiac_driver_idle"][0] = % prague_zodiac_driver_idle;
}

_id_47DA() {
  var_0 = "lonestar";
  level._id_0C59["generic"]["wetsub_idle"] = % ny_harbor_wetsub_npc_idle;
  level._id_0C59["generic"]["wetsub_idle_alt01"] = % ny_harbor_wetsub_npc_idle_alt01;
  level._id_0C59["generic"]["wetsub_idle_alt02"] = % ny_harbor_wetsub_npc_idle_alt02;
  level._id_0C59["generic"]["wetsub_acknowledge"] = % ny_harbor_wetsub_npc_acknowledge;
  level._id_0C59["generic"]["wetsub_fwd"] = % ny_harbor_wetsub_npc_swim_fwd;
  level._id_0C59["generic"]["wetsub_rt"] = % ny_harbor_wetsub_npc_swim_rt;
  level._id_0C59["generic"]["wetsub_lt"] = % ny_harbor_wetsub_npc_swim_lt;
  level._id_0C59["generic"]["wetsub_up"] = % ny_harbor_wetsub_npc_swim_up;
  level._id_0C59["generic"]["wetsub_dn"] = % ny_harbor_wetsub_npc_swim_dwn;
  level._id_0C59["generic"]["wetsub_fwd_alt"] = % ny_harbor_wetsub_npc_swim_fwd_alt;
  level._id_0C59["generic"]["wetsub_rt_alt"] = % ny_harbor_wetsub_npc_swim_rt_alt;
  level._id_0C59["generic"]["wetsub_lt_alt"] = % ny_harbor_wetsub_npc_swim_lt_alt;
  level._id_0C59["generic"]["balcony_fallloop_onback"][0] = % balcony_fallloop_onback;
  level._id_0C59["generic"]["balcony_fallloop_tumbleforwards"][0] = % balcony_fallloop_tumbleforwards;
  level._id_0C59["generic"]["ny_harbor_slams_bulkhead_door_shut"] = % ny_harbor_slams_bulkhead_door_shut;
  level._id_0C59["generic"]["ny_harbor_door_open"] = % ny_harbor_door_open;
  level._id_0C59["generic"]["ny_harbor_ssbn_coughing_recovery_guy1"] = % ny_harbor_ssbn_coughing_recovery_guy1;
  maps\_anim::_id_1264("generic", "KILL ME", maps\ny_harbor_code_sub::_id_4B78, "ny_harbor_ssbn_coughing_recovery_guy1");
  level._id_0C59["generic"]["ny_harbor_ssbn_coughing_recovery_guy2"] = % ny_harbor_ssbn_coughing_recovery_guy2;
  level._id_0C59["generic"]["ny_harbor_door_breach"] = % ny_harbor_door_breach_guy1;
  level._id_0C59["generic"]["ny_harbor_affected_russian_guy1"] = % ny_harbor_affected_russian_guy1;
  level._id_0C59["generic"]["npc_plant_side"] = % ny_harbor_wetsub_npc_plant_mine_side;
  level._id_0C59["generic"]["npc_plant_up"] = % ny_harbor_wetsub_npc_plant_mine_up;
  level._id_0C59["generic"]["ny_harbor_paried_takedown_sandman_start"] = % ny_harbor_paried_takedown_sandman_start;
  level._id_0C59["lonestar"]["ny_harbor_captain_search_flip_over"] = % ny_harbor_paried_takedown_sandman_flip_over;
  level._id_0C59["lonestar"]["ny_harbor_captain_search_flip_over_b"] = % ny_harbor_paried_takedown_sandman_flip_over_b;
  level._id_0C59["lonestar"]["ny_harbor_captain_search_flip_over_c"] = % ny_harbor_paried_takedown_sandman_flip_over_c;
  maps\_anim::_id_1264("lonestar", "gotkey_dialog", maps\ny_harbor_code_vo::_id_4AE8, "ny_harbor_captain_search_flip_over");
  maps\_anim::_id_1264("lonestar", "sandman_dialog", maps\ny_harbor_code_vo::_id_4AEA, "ny_harbor_captain_search_flip_over_b");
  level._id_0C59["generic"]["ny_harbor_delta_bulkhead_open_guy1_v2"] = % ny_harbor_delta_bulkhead_open_guy1_v2;
  level._id_0C59[var_0]["ny_harbor_ladder_slide_sandman"] = % ny_harbor_ladder_slide_sandman;
  level._id_0C59[var_0]["ny_harbor_sandman_drops_frag_inhatch"] = % ny_harbor_sandman_drops_frag_inhatch;
  level._id_0C59[var_0]["open_with_wheel"] = % ny_harbor_delta_bulkhead_open_guy1_v2;
  level._id_0C59[var_0]["open_with_wheel_approach"] = % corner_standl_trans_cqb_in_8;
  level._id_0C59["barracks_2"]["slam_door"] = % ny_harbor_slams_bulkhead_door_shut;
  level._id_0C59["generic"]["launchfacility_b_blast_door_seq_waveidle"] = % launchfacility_b_blast_door_seq_waveidle;
  level._id_0C59[var_0]["barracks_sandman_exit"] = % ny_harbor_door_open;
  level._id_0C59[var_0]["barracks_sandman_exit_idle"][0] = % ny_harbor_door_idle;
  level._id_0C59["generic"]["ny_harbor_doorway_headsmash"] = % ny_harbor_doorway_headsmash_enemy;
  level._id_0C59["generic"]["ny_harbor_doorway_headsmash_enemy_deadpose"] = % ny_harbor_doorway_headsmash_enemy_deadpose;
  level._id_0C59[var_0]["ny_harbor_doorway_headsmash"] = % ny_harbor_doorway_headsmash_sandman;
  level._id_0C59[var_0]["ny_harbor_doorway_headsmash_no_gun_flip"] = % ny_harbor_doorway_headsmash_sandman_no_gun_flip;
  level._id_0C59["guy"]["extinguisher_loop"][0] = % ny_harbor_fire_extinguisher_npc_loop;
  level._id_0C59["generic"]["blow_back_dead"] = % blow_back_dead;
  level._id_0C59["generic"]["hunted_dying_deadguy"] = % hunted_dying_deadguy;
  level._id_0C59["generic"]["death_sitting_pose_v1"][0] = % death_sitting_pose_v1;
  level._id_0C59["generic"]["death_sitting_pose_v1_nl"] = % death_sitting_pose_v1;
  level._id_0C59["generic"]["death_sitting_pose_v2"] = % death_sitting_pose_v2;
  level._id_0C59[var_0]["ny_harbor_door_breach_idle"][0] = % ny_harbor_door_breach_sandman_idle;
  level._id_11B7[var_0]["nyharbor_lns_kickercharge"] = % ny_harbor_door_breach_sandman_face;
  level._id_0C59[var_0]["ny_harbor_door_breach_idle_trans"] = % ny_harbor_door_breach_sandman_idle_trans;
  level._id_0C59[var_0]["ny_harbor_door_breach"] = % ny_harbor_door_breach_sandman;
  maps\_anim::_id_1264("lonestar", "Show_Charge_1", maps\ny_harbor_code_sub::_id_4BBF, "ny_harbor_door_breach");
  maps\_anim::_id_1264("lonestar", "Detach_Charge_1", maps\ny_harbor_code_sub::_id_4BC0, "ny_harbor_door_breach");
  maps\_anim::_id_1264("lonestar", "Show_Charge_2", maps\ny_harbor_code_sub::_id_4BC1, "ny_harbor_door_breach");
  maps\_anim::_id_1264("lonestar", "Detach_Charge_2", maps\ny_harbor_code_sub::_id_4BC2, "ny_harbor_door_breach");
  level._id_0C59["generic"]["breach_enemy_1"] = % patrol_bored_react_walkstop;
  level._id_0C59["breacher1"]["breach_enemy_2"] = % breach_react_push_guy1;
  level._id_0C59["breacher2"]["breach_enemy_2"] = % breach_react_push_guy2;
  level._id_0C59["knife_guy"]["breach_react_knife_idle"] = % breach_react_knife_idle;
  level._id_0C59["knife_guy"]["breach_react_knife_charge"] = % breach_react_knife_charge;
  level._id_0C59["knife_guy"]["breach_react_knife_charge_death"] = % death_shotgun_back_v1;
  maps\_anim::_id_1261("generic", "attach knife right", "weapon_parabolic_knife", "TAG_INHAND");
  maps\_anim::_id_1262("generic", "detach knife right", "weapon_parabolic_knife", "TAG_INHAND", "breach_react_knife_charge");
  level._id_0C59["generic"]["ny_harbor_paried_takedown_captain_start"] = % ny_harbor_paried_takedown_captain_start;
  level._id_0C59["generic"]["ny_harbor_paried_takedown_captain_dead_1"] = % ny_harbor_paried_takedown_captain_dead_1;
  level._id_0C59["generic"]["ny_harbor_paried_takedown_captain_die"] = % ny_harbor_paried_takedown_captain_die;
  level._id_0C59["generic"]["ny_harbor_captain_search_flip_over"] = % ny_harbor_paried_takedown_captain_flip_over;
  level._id_0C59["lonestar"]["sub_turn_key"] = % ny_harbor_missle_key_sandman_turnkey;
  level._id_0C59["lonestar"]["sub_turn_key2"] = % ny_harbor_missle_key_sandman_turnkey2;
  level._id_0C59["generic"]["sub_turn_key_idle"][0] = % ny_harbor_missle_key_sandman_idle;
  maps\_anim::_id_1264("lonestar", "green_light_on", _id_03C3::_id_4AB0, "sub_turn_key");
  maps\_anim::_id_1264("lonestar", "red_light_off", _id_03C3::_id_4AB4, "sub_turn_key2");
  level._id_0C59[var_0]["sub_exit_jump"] = % ny_harbor_sub_exit_sandman_jump;
  level._id_0C59["generic"]["ny_harbor_davora_front_turret_death"] = % ny_harbor_davora_front_turret_death;
  level._id_0C59["generic"]["ny_harbor_davora_side_fall_death"] = % ny_harbor_davora_side_fall_death;
  level._id_0C59["generic"]["stand_death_shoulderback"] = % stand_death_shoulderback;
  level._id_0C59["generic"]["ny_harbor_stand_death_shoulderback_pose"][0] = % ny_harbor_stand_death_shoulderback_pose;
  level._id_0C59["lonestar"]["surfacing"] = % ny_harbor_sub_surface_npc;
  level._id_0C59["lonestar"]["boarding"] = % ny_harbor_sub_surface_npc_pt2;
  level._id_0C59["lonestar"]["tunnel_intro"] = % ny_harbor_underwater_cutting_sandman;
  maps\_anim::_id_1264("lonestar", "vo_grate", maps\ny_harbor_code_vo::_id_4AD9, "tunnel_intro");
  level._id_0C59["lonestar"]["exit_to_zodiac"] = % ny_harbor_sub_exit_sandman_trans;
  level._id_0C59["lonestar"]["wave_from_zodiac"] = % ny_harbor_sub_exit_sandman_wave;
  level._id_0C59["lonestar"]["launch_react"] = % ny_harbor_sandman_launch_react;
  level._id_0C59["lonestar"]["finale_escape"] = % ny_harbor_finale_airlift_sandman;
  level._id_1245["ch_guy1"] = #animtree;
  level._id_0C59["ch_guy1"]["finale_escape"] = % ny_harbor_finale_airlift_guy1;
  level._id_0C59["ch_guy1"]["chinook_idle"][0] = % ny_harbor_finale_airlift_guy1_idle;
  level._id_1245["ch_guy2"] = #animtree;
  level._id_0C59["ch_guy2"]["finale_escape"] = % ny_harbor_finale_airlift_guy2;
  level._id_0C59["ch_guy2"]["chinook_idle"][0] = % ny_harbor_finale_airlift_guy2_idle;
  level._id_0C59["generic"]["exposed_crouch_death_fetal"] = % exposed_crouch_death_fetal;
  level._id_0C59["generic"]["exposed_crouch_death_twist"] = % exposed_crouch_death_twist;
}

#using_animtree("vehicles");

_id_4CAB() {
  level._id_1245["ss_n_12_missile"] = #animtree;
  level._id_0C59["ss_n_12_missile"]["open"] = % ss_n_12_missile_open;
  level._id_0C59["ss_n_12_missile"]["open_idle"] = % ss_n_12_missile_open_idle;
  level._id_0C59["ss_n_12_missile"]["close_idle"] = % ss_n_12_missile_close_idle;
}

_id_686D() {
  level._id_1245["blackshadow"] = #animtree;
  level._id_0C59["blackshadow"]["npc_plant_side"] = % ny_harbor_wetsub_vehicle_plant_mine_side;
  level._id_0C59["blackshadow"]["npc_plant_up"] = % ny_harbor_wetsub_vehicle_plant_mine_up;
  level._id_0C59["blackshadow"]["mine_plant"] = % ny_harbor_wetsub_plantmine_vehicle;
  level._id_0C59["blackshadow"]["surfacing"] = % ny_harbor_sub_surface_vehicle;
  level._id_0C59["blackshadow"]["tunnel_intro"] = % ny_harbor_underwater_cutting_sdv2;
  level._id_0C59["player_sdv"]["tunnel_intro"] = % ny_harbor_underwater_cutting_sdv1;
  level._id_0C59["player_sdv"]["tunnel_spline"] = % ny_harbor_underwater_cutting_sdv1_pt2;
}

_id_686E() {
  level._id_1245["ch46e"] = #animtree;
  level._id_0C59["ch46e"]["open_rear"] = % ch46e_ny_harbor_open_rear;
  level._id_0C59["ch46e"]["open_rear_loop"][0] = % ch46e_ny_harbor_open_rear_loop;
  level._id_0C59["ch46e"]["wide_open_rear_loop"][0] = % ch46e_ny_harbor_wide_open_rear_loop;
  level._id_0C59["ch46e"]["chinook_landing"] = % ny_harbor_finale_airlift_ch46_start;
  level._id_0C59["ch46e"]["chinook_pre_idle"] = % ny_harbor_finale_airlift_ch46_idle;
  level._id_0C59["ch46e"]["chinook_idle"][0] = % ny_harbor_finale_airlift_ch46_idle;
  level._id_0C59["ch46e"]["finale_escape"] = % ny_harbor_finale_airlift_ch46_end;
  level._id_0C59["ch46e"]["rotors"] = % sniper_escape_ch46_rotors;
  level._id_1245["ch46e2"] = #animtree;
  level._id_0C59["ch46e2"]["chinook_landing"] = % ny_harbor_finale_airlift_ch46_2_start;
  level._id_0C59["ch46e2"]["chinook_idle"][0] = % ny_harbor_finale_airlift_ch46_2_idle;
  level._id_0C59["ch46e2"]["rotors"] = % sniper_escape_ch46_rotors;
}

_id_686F() {
  level._id_1245["russian_sub"] = #animtree;
  level._id_0C59["russian_sub"]["surfacing"] = % ny_harbor_sub_surface;
  level._id_0C59["russian_sub"]["propellers"][0] = % russian_oscar2_propellers;
}

_id_6870() {
  level._id_1245["zodiac"] = #animtree;
  level._id_0C59["zodiac"]["exit_to_zodiac"] = % ny_harbor_sub_exit_zodiac;
  level._id_0C59["zodiac"]["carrier_start"] = % ny_harbor_finale_bump_zodiac_start;
  level._id_0C59["zodiac"]["carrier_breach"] = % ny_harbor_finale_bump_zodiac_breach;
  level._id_0C59["zodiac"]["carrier_end"] = % ny_harbor_finale_bump_zodiac_end;
  level._id_0C59["zodiac_player"]["finale_escape"] = % ny_harbor_finale_airlift_zodiac_end;
}

_id_6871() {
  level._id_1245["dvora"] = #animtree;
  level._id_0C59["dvora"]["carrier_start"] = % ny_harbor_finale_bump_dvora_start;
  level._id_0C59["dvora"]["carrier_breach"] = % ny_harbor_finale_bump_dvora_breach;
  level._id_0C59["dvora"]["carrier_end"] = % ny_harbor_finale_bump_dvora_end;
  level._id_0C59["dvora"]["destory"] = % ny_harbor_finale_bump_dvora_destroy;
  level._id_0C59["dvora"]["destorychunk"] = % ny_harbor_finale_bump_dvora_destroychunk;
}

_id_6872() {}

#using_animtree("script_model");

_id_4CAC() {
  level._id_1245["door_charge"] = #animtree;
  level._id_1F90["door_charge"] = "weapon_frame_charge_iw5";
  level._id_0C59["door_charge"]["ny_harbor_door_breach"] = % ny_harbor_door_breach_player_charge2;
  level._id_1245["breach_door"] = #animtree;
  level._id_1F90["breach_door"] = "ny_harbor_sub_pressuredoor_bridge";
  level._id_0C59["breach_door"]["ny_harbor_door_breach"] = % ny_harbor_door_breach_pressure_door;
  level._id_1245["breach_detonator1"] = #animtree;
  level._id_1F90["breach_detonator1"] = "weapon_c4_detonator_iw5";
  level._id_0C59["breach_detonator1"]["ny_harbor_door_breach"] = % ny_harbor_door_breach_detonator_1;
  level._id_1245["breach_detonator2"] = #animtree;
  level._id_1F90["breach_detonator2"] = "weapon_c4_detonator_iw5";
  level._id_0C59["breach_detonator2"]["ny_harbor_door_breach"] = % ny_harbor_door_breach_detonator_2;
  level._id_1245["breach_charge1"] = #animtree;
  level._id_1F90["breach_charge1"] = "weapon_frame_charge_iw5_c4";
  level._id_0C59["breach_charge1"]["ny_harbor_door_breach"] = % ny_harbor_door_breach_sandman_charge1;
  level._id_1245["breach_charge2"] = #animtree;
  level._id_1F90["breach_charge2"] = "weapon_frame_charge_iw5_c4";
  level._id_0C59["breach_charge2"]["ny_harbor_door_breach"] = % ny_harbor_door_breach_sandman_charge2;
  level._id_1245["missile_key_panel_box"] = #animtree;
  level._id_1F90["missile_key_panel_box"] = "ny_harbor_missle_key_panel";
  level._id_0C59["missile_key_panel_box"]["sub_turn_key"] = % ny_harbor_missle_key_panel;
  level._id_1245["missile_key_panel"] = #animtree;
  level._id_1F90["missile_key_panel"] = "ny_harbor_missle_key_box";
  level._id_0C59["missile_key_panel"]["sub_turn_key"] = % ny_harbor_missle_key_panel_launch_box;
  level._id_1245["tunnel_grate"] = #animtree;
  level._id_1F90["tunnel_grate"] = "ny_harbor_tunnel_grate";
  level._id_0C59["tunnel_grate"]["tunnel_intro"] = % ny_harbor_underwater_cutting_grate;
  level._id_1245["torch"] = #animtree;
  level._id_1F90["torch"] = "weapon_underwater_torch";
  level._id_0C59["torch"]["tunnel_intro"] = % ny_harbor_underwater_cutting_torch;
  level._id_0C59["mine"]["npc_plant_side"] = % ny_harbor_wetsub_mine_plant_mine_side;
  level._id_0C59["mine"]["npc_plant_up"] = % ny_harbor_wetsub_mine_plant_mine_up;
  level._id_0C59["mine"]["mine_plant"] = % ny_harbor_wetsub_plantmine_mine;
  level._id_0C59["mine"]["mine_ref"] = % ny_harbor_wetsub_plantmine_mine_ref;
  level._id_1245["mine"] = #animtree;
  level._id_1245["wave_front"] = #animtree;
  level._id_0C59["wave_front"]["wave"] = % fx_nyharbor_wave_front_anim;
  level._id_1245["wave_crashing"] = #animtree;
  level._id_0C59["wave_crashing"]["wave"] = % fx_nyharbor_wave_crashing_anim;
  level._id_1245["wave_side"] = #animtree;
  level._id_0C59["wave_side"]["wave"] = % fx_nyharbor_wave_side_anim;
  level._id_1245["explosion_wave"] = #animtree;
  level._id_0C59["explosion_wave"]["wave"] = % fx_nyharbor_explosion_wave_anim;
  level._id_1245["wave_displace"] = #animtree;
  level._id_0C59["wave_displace"]["wave"] = % fx_nyharbor_wave_displace_anim;
  level._id_1245["smoke_column"] = #animtree;
  level._id_0C59["smoke_column"]["fire"] = % fx_ny_smoke_column_anim;
  level._id_0C59["smoke_column"]["rot"] = % fx_ny_smoke_column_rot_anim;
  level._id_1245["missile_door"] = #animtree;
  level._id_0C59["missile_door"]["open"] = % ny_harbor_sub_missile_door_open;
  level._id_1245["missile_hatch"] = #animtree;
  level._id_0C59["missile_hatch"]["open"] = % ny_harbor_sub_missile_hatch_open;
  level._id_1245["burya"] = #animtree;
  level._id_0C59["burya"]["destruct_front"] = % ny_harbor_burya_corvette_front_blow;
  level._id_0C59["burya"]["destruct_mid"] = % ny_harbor_burya_corvette_mid_blow;
  level._id_0C59["burya"]["destruct_rear"] = % ny_harbor_burya_corvette_rear_blow;
  level._id_1245["mask"] = #animtree;
  level._id_1F90["mask"] = "ny_harbor_dive_gear_mask";
  level._id_0C59["mask"]["boarding"] = % ny_harbor_sub_surface_mask;
  level._id_1245["extinguisher"] = #animtree;
  level._id_1F90["extinguisher"] = "com_fire_extinguisher_anim";
  level._id_0C59["extinguisher"]["extinguisher_loop"][0] = % ny_harbor_fire_extinguisher_prop_loop;
}

_id_4CAD() {
  level._id_1245["door"] = #animtree;
  level._id_1F90["door"] = "ny_harbor_sub_pressuredoor_rigged";
  level._id_0C59["door"]["open_with_wheel"] = % ny_harbor_delta_bulkhead_open_door_v2;
  level._id_0C59["door"]["slam_door"] = % ny_harbor_slams_bulkhead_door_shut_door;
  level._id_0C59["door"]["barracks_sandman_exit"] = % ny_harbor_door_open_door;
}

#using_animtree("generic_human");

_id_47E3() {
  var_0 = "lonestar";
  level._id_11BB["nyharbor_rno_inposition"] = "nyharbor_rno_inposition";
  level._id_11BB["nyharbor_lns_radiocheck"] = "nyharbor_lns_radiocheck";
  level._id_11BB["nyharbor_sel_fivebyfive"] = "nyharbor_sel_fivebyfive";
  level._id_11BB["nyharbor_lns_starttheparty"] = "nyharbor_lns_starttheparty";
  level._id_11BB["nyharbor_sel_copythat"] = "nyharbor_sel_copythat";
  level._id_11BB["nyharbor_rno_dontstart"] = "nyharbor_rno_dontstart";
  level._id_11BB["nyharbor_lns_almostthrough"] = "nyharbor_lns_almostthrough";
  level._id_11BB["nyharbor_lns_entrypoint"] = "nyharbor_lns_entrypoint";
  level._id_11BB["nyharbor_lns_linkup"] = "nyharbor_lns_linkup";
  level._id_11BB["nyharbor_rno_gotout"] = "nyharbor_rno_gotout";
  level._id_11BB["nyharbor_lns_forthem"] = "nyharbor_lns_forthem";
  level._id_11BB["nyharbor_sel_ontracker"] = "nyharbor_sel_ontracker";
  level._id_11BB["nyharbor_lns_approachingrv"] = "nyharbor_lns_approachingrv";
  level._id_11BB["nyharbor_lns_upahead"] = "nyharbor_lns_upahead";
  level._id_11BB["nyharbor_rno_iseethem"] = "nyharbor_rno_iseethem";
  level._id_11BB["nyharbor_sel_intercept"] = "nyharbor_sel_intercept";
  level._id_11BB["nyharbor_lns_leadtheway"] = "nyharbor_lns_leadtheway";
  level._id_11BB["nyharbor_sel_watchsonar"] = "nyharbor_sel_watchsonar";
  level._id_11BB["nyharbor_lns_eyesonsonar"] = "nyharbor_lns_eyesonsonar";
  level._id_11BB["nyharbor_rno_mineleft"] = "nyharbor_rno_mineleft";
  level._id_11BB["nyharbor_lns_right"] = "nyharbor_lns_right";
  level._id_11BB["nyharbor_lns_keepitsteady"] = "nyharbor_lns_keepitsteady";
  level._id_11BB["nyharbor_lns_anothermine"] = "nyharbor_lns_anothermine";
  level._id_11BB["nyharbor_lns_right"] = "nyharbor_lns_right";
  level._id_11BB["nyharbor_rno_mine"] = "nyharbor_rno_mine";
  level._id_11BB["nyharbor_lns_clear"] = "nyharbor_lns_clear";
  level._id_11BB["nyharbor_sel_targetapproaching"] = "nyharbor_sel_targetapproaching";
  level._id_11BB["nyharbor_lns_powerdown"] = "nyharbor_lns_powerdown";
  level._id_11BB["nyharbor_sel_steady"] = "nyharbor_sel_steady";
  level._id_11BB["nyharbor_lns_waittilpasses"] = "nyharbor_lns_waittilpasses";
  level._id_11BB["nyharbor_lns_okaygo"] = "nyharbor_lns_okaygo";
  level._id_11BB["nyharbor_lns_frostmove"] = "nyharbor_lns_frostmove";
  level._id_11BB["nyharbor_lns_getinposition"] = "nyharbor_lns_getinposition";
  level._id_11BB["nyharbor_lns_plantjaywick"] = "nyharbor_lns_plantjaywick";
  level._id_11BB["nyharbor_lns_hurryup"] = "nyharbor_lns_hurryup";
  level._id_11BB["nyharbor_sel_planting"] = "nyharbor_sel_planting";
  level._id_11BB["nyharbor_rno_planting"] = "nyharbor_rno_planting";
  level._id_11BB["nyharbor_lns_minesarmed"] = "nyharbor_lns_minesarmed";
  level._id_11BB["nyharbor_sel_goodjob"] = "nyharbor_sel_goodjob";
  level._id_11BB["nyharbor_lns_goingexplosive"] = "nyharbor_lns_goingexplosive";
  level._id_11BB["nyharbor_lns_commencingassault"] = "nyharbor_lns_commencingassault";
  level._id_11BB["nyharbor_hqr_primaryobjective"] = "nyharbor_hqr_primaryobjective";
  level._id_11BB["nyharbor_lns_holdposition"] = "nyharbor_lns_holdposition";
  level._id_11BB["nyharbor_lns_plantyourmine"] = "nyharbor_lns_plantyourmine";
  level._id_11BB["nyharbor_lns_frostgetinposition"] = "nyharbor_lns_frostgetinposition";
  level._id_11BB["nyharbor_lns_hurryup"] = "nyharbor_lns_hurryup";
  level.scr_sound["sub_truck"]["nyharbor_trk_decksecured"] = "nyharbor_trk_decksecured";
  level.scr_sound["sub_truck"]["nyharbor_trk_jobtodo"] = "nyharbor_trk_jobtodo";
  level.scr_sound["sub_grinch"]["nyharbor_rno_headdown"] = "nyharbor_rno_headdown";
  level.scr_sound["sub_grinch"]["nyharbor_rno_downthere"] = "nyharbor_rno_downthere";
  level.scr_sound["sub_truck"]["nyharbor_trk_incominghind"] = "nyharbor_trk_incominghind";
  level.scr_sound["lonestar"]["nyharbor_lns_hatchopening"] = "nyharbor_lns_hatchopening";
  level.scr_sound["lonestar"]["nyharbor_lns_comingout"] = "nyharbor_lns_comingout";
  level.scr_sound["lonestar"]["nyharbor_lns_fragout"] = "nyharbor_lns_fragout";
  level.scr_sound["lonestar"]["nyharbor_lns_clearheaddown"] = "nyharbor_lns_clearheaddown";
  level.scr_sound["lonestar"]["nyharbor_lns_atthedoor2"] = "nyharbor_lns_atthedoor2";
  level.scr_sound[var_0]["nyharbor_lns_unknowns"] = "nyharbor_lns_unknowns";
  level.scr_sound["lonestar"]["nyharbor_lns_rvdownstairs"] = "nyharbor_lns_rvdownstairs";
  level.scr_sound["lonestar"]["nyharbor_snd_downstairs"] = "nyharbor_snd_downstairs";
  level._id_11BB["nyharbor_rpa_evacuate"] = "nyharbor_rpa_evacuate";
  level.scr_sound[var_0]["nyharbor_lns_scuttle"] = "nyharbor_lns_scuttle";
  level.scr_sound[var_0]["nyharbor_lns_takepoint"] = "nyharbor_lns_takepoint";
  level.scr_sound["lonestar"]["nyharbor_lns_stairsclear"] = "nyharbor_lns_stairsclear";
  level.scr_sound["lonestar"]["nyharbor_lns_takeleft"] = "nyharbor_lns_takeleft";
  level.scr_sound[var_0]["nyharbor_lns_tothebridge2"] = "nyharbor_lns_tothebridge2";
  level.scr_sound[var_0]["nyharbor_lns_kickercharge"] = "nyharbor_lns_kickercharge";
  level.scr_sound[var_0]["nyharbor_lns_areasecure"] = "nyharbor_lns_areasecure";
  level.scr_sound[var_0]["nyharbor_lns_launchkeys"] = "nyharbor_lns_launchkeys";
  level.scr_sound[var_0]["nyharbor_lns_checkpointneptune"] = "nyharbor_lns_checkpointneptune";
  level._id_11BB["nyharbor_hqr_copyneptune"] = "nyharbor_hqr_copyneptune";
  level.scr_sound[var_0]["nyharbor_lns_missilekey"] = "nyharbor_lns_missilekey";
  level._id_11B7[var_0]["nyharbor_lns_missilekey"] = % ny_harbor_paried_takedown_sandman_flip_over_c_face;
  level._id_11BB["nyharbor_hqr_coordinates"] = "nyharbor_hqr_coordinates";
  level.scr_sound[var_0]["nyharbor_lns_launchin30"] = "nyharbor_lns_launchin30";
  level._id_11B7[var_0]["nyharbor_lns_launchin30"] = % ny_harbor_missle_key_sandman_idle_face;
  level.scr_sound[var_0]["nyharbor_lns_console"] = "nyharbor_lns_console";
  level.scr_sound[var_0]["nyharbor_lns_overhere"] = "nyharbor_lns_overhere";
  level.scr_sound[var_0]["nyharbor_lns_321turn"] = "nyharbor_lns_321turn";
  level._id_11B7[var_0]["nyharbor_lns_321turn"] = % ny_harbor_missle_key_sandman_turnkey_face;
  level.scr_sound[var_0]["nyharbor_lns_missiles"] = "nyharbor_lns_missiles";
  level._id_11BB["nyharbor_hqr_teaminposition"] = "nyharbor_hqr_teaminposition";
  level.scr_sound["lonestar"]["nyharbor_lns_gogo"] = "nyharbor_lns_gogo";
  level.scr_sound["lonestar"]["nyharbor_lns_thisway"] = "nyharbor_lns_thisway";
  level.scr_sound["lonestar"]["nyharbor_lns_letsroll"] = "nyharbor_lns_letsroll";
  level._id_11BB["nyharbor_rno_amentothat"] = "nyharbor_rno_amentothat";
  level.scr_sound[var_0]["nyharbor_lns_missileslaunching"] = "nyharbor_lns_missileslaunching";
  level.scr_sound[var_0]["nyharbor_lns_punchit"] = "nyharbor_lns_punchit";
  level.scr_sound[var_0]["nyharbor_lns_keepup"] = "nyharbor_lns_keepup";
  level.scr_sound[var_0]["nyharbor_lns_gunit"] = "nyharbor_lns_gunit";
  level.scr_sound[var_0]["nyharbor_lns_keepongoing"] = "nyharbor_lns_keepongoing";
  level.scr_sound[var_0]["nyharbor_lns_missilescoming"] = "nyharbor_lns_missilescoming";
  level.scr_sound[var_0]["nyharbor_lns_lookout"] = "nyharbor_lns_lookout";
  level.scr_sound[var_0]["nyharbor_lns_shootmines"] = "nyharbor_lns_shootmines";
  level._id_11BB["nyharbor_plt_feetwet"] = "nyharbor_plt_feetwet";
  level.scr_sound[var_0]["nyharbor_lns_theresourbird"] = "nyharbor_lns_theresourbird";
  level.scr_sound[var_0]["nyharbor_lns_theresheis"] = "nyharbor_lns_theresheis";
  level.scr_sound[var_0]["nyharbor_lns_missioncomplete"] = "nyharbor_lns_missioncomplete";
  level._id_11BB["nyharbor_hqr_oneforbooks"] = "nyharbor_hqr_oneforbooks";
  level.scr_sound[var_0]["nyharbor_lns_easyday"] = "nyharbor_lns_easyday";
  level.scr_sound["barracks_1"]["nyharbor_ru1_americans"] = "nyharbor_ru1_americans";
  level.scr_sound["barracks_2"]["nyharbor_ru2_behinddoor"] = "nyharbor_ru2_behinddoor";
  level.scr_sound["extinguisher"]["nyharbor_ru1_extinguisher"] = "nyharbor_ru1_extinguisher";
  level.scr_sound["reactor"]["nyharbor_ru2_reactorroom"] = "nyharbor_ru2_reactorroom";
  level.scr_sound["stairs"]["nyharbor_ru3_rushthem"] = "nyharbor_ru3_rushthem";
  level.scr_sound["missile_1"]["nyharbor_ru3_intruders"] = "nyharbor_ru3_intruders";
  level.scr_sound["missile_2"]["nyharbor_ru3_fireyourweapon"] = "nyharbor_ru3_fireyourweapon";
  level.scr_sound["missile_3"]["nyharbor_ru3_outofammo"] = "nyharbor_ru3_outofammo";
}

#using_animtree("script_model");

_id_47D8() {
  level._id_1245["building_des"] = #animtree;
  level._id_0C59["building_des"]["ny_manhattan_building_exchange_01_facade_des_anim"] = % ny_manhattan_building_exchange_01_facade_des_anim;
}

_id_012A(var_0) {
  level.player playrumbleonentity("viewmodel_small");
}

_id_012B(var_0) {
  level.player playrumbleonentity("viewmodel_medium");
}

_id_012C(var_0) {
  level.player playrumbleonentity("viewmodel_large");
}