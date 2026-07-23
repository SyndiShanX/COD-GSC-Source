/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\ny_harbor_anim.gsc
*******************************************/

main() {
  player_anims();
  body_anims();
  actor_anims();
  prop_anims();
  ss_n_12_anims();
  blackshadow_anims();
  russian_sub_anims();
  ch46e_ny_harbor_anims();
  zodiac_anims();
  dvora_anims();
  script_model_anims();
  squad_vo();
  door();
  missile_key();
  _id_686A::main();
  _id_686B::main();
  building_destruction();
}

#using_animtree("script_model");

missile_key() {
  level.scr_animtree["missile_key_player"] = #animtree;
  level.scr_model["missile_key_player"] = "ny_harbor_missle_key";
  level.scr_anim["missile_key_player"]["sub_turn_key"] = % ny_harbor_missle_key_player_toss;
  level.scr_animtree["missile_key_sandman"] = #animtree;
  level.scr_model["missile_key_sandman"] = "ny_harbor_missle_key";
  level.scr_anim["missile_key_sandman"]["sub_turn_key"] = % ny_harbor_missle_key_sandman_key;
}

#using_animtree("player");

player_anims() {
  level.scr_animtree["player_sdv_rig"] = #animtree;
  level.scr_animtree["player_sdv_legs"] = #animtree;
  level.scr_model["player_sdv_legs"] = "viewlegs_generic";
  level.scr_model["player_sdv_rig"] = "viewhands_player_udt";
  level.scr_anim["player_sdv_rig"]["sdv_idle"][0] = % harbor_player_sdv_idle;
  level.scr_anim["player_sdv_rig"]["sdv"]["idle"] = % harbor_player_sdv_idle;
  level.scr_anim["player_sdv_rig"]["sdv"]["turn_down"] = % harbor_player_sdv_turn_down;
  level.scr_anim["player_sdv_rig"]["sdv"]["turn_up"] = % harbor_player_sdv_turn_up;
  level.scr_anim["player_sdv_rig"]["sdv"]["turn_right"] = % harbor_player_sdv_turn_right;
  level.scr_anim["player_sdv_rig"]["sdv"]["turn_left"] = % harbor_player_sdv_turn_left;
  level.scr_anim["player_sdv_rig"]["tunnel_intro"] = % ny_harbor_underwater_cutting_player;
  maps\_anim::addnotetrack_customfunction("player_sdv_rig", "rumble_medium", ::anim_rumble_medium, "tunnel_intro");
  maps\_anim::addnotetrack_customfunction("player_sdv_rig", "rumble_large", ::anim_rumble_large, "tunnel_intro");
  level.scr_anim["player_sdv_rig"]["tunnel_spline"] = % ny_harbor_underwater_cutting_player_pt2;
  level.scr_anim["player_sdv_rig"]["mine_plant"] = % ny_harbor_wetsub_plantmine_player;
  level.scr_anim["player_sdv_rig"]["ny_harbor_door_breach"] = % ny_harbor_door_breach_player;
  maps\_anim::addnotetrack_customfunction("player_sdv_rig", "Start_slowdown", maps\ny_harbor_code_sub::breach_slow_down, "ny_harbor_door_breach");
  maps\_anim::addnotetrack_customfunction("player_sdv_rig", "Blow_charge", maps\ny_harbor_code_sub::blow_door, "ny_harbor_door_breach");
  maps\_anim::addnotetrack_customfunction("player_sdv_rig", "rumble_large", ::anim_rumble_large, "ny_harbor_door_breach");
  level.scr_anim["player_sdv_rig"]["sub_turn_key"] = % ny_harbor_missle_key_player_turnkey;
  level.scr_anim["player_sdv_rig"]["player_ladder_slide"] = % ny_harbor_ladder_slide_player;
  maps\_anim::addnotetrack_customfunction("player_sdv_rig", "rumble_small", ::anim_rumble_small, "player_ladder_slide");
  maps\_anim::addnotetrack_customfunction("player_sdv_rig", "rumble_meduim", ::anim_rumble_medium, "player_ladder_slide");
  maps\_anim::addnotetrack_customfunction("player_sdv_rig", "rumble_large", ::anim_rumble_large, "player_ladder_slide");
  level.scr_anim["player_sdv_rig"]["surfacing"] = % ny_harbor_sub_surface_player;
  level.scr_anim["player_sdv_rig"]["boarding"] = % ny_harbor_sub_surface_player_pt2;
  level.scr_anim["player_sdv_rig"]["exit_to_zodiac"] = % ny_harbor_sub_exit_player;
  level.scr_anim["player_sdv_legs"]["exit_to_zodiac"] = % ny_harbor_sub_exit_legs;
  level.scr_anim["player_sdv_rig"]["finale_escape"] = % ny_harbor_finale_airlift_player_end;
  level.scr_anim["player_sdv_rig"]["carrier_start"] = % ny_harbor_finale_bump_player_start;
  level.scr_anim["player_sdv_rig"]["carrier_end"] = % ny_harbor_finale_bump_player_end;
}

#using_animtree("generic_human");

body_anims() {
  level.scr_animtree["floating_body"] = #animtree;
  level.scr_anim["generic"]["harbor_drowning_01"] = % harbor_drowning_01;
  level.scr_anim["generic"]["harbor_drowning_01_idle"][0] = % harbor_drowning_01_idle;
  level.scr_anim["generic"]["harbor_drowning_02"] = % harbor_drowning_02;
  level.scr_anim["generic"]["harbor_drowning_02_idle"][0] = % harbor_drowning_02_idle;
  level.scr_anim["generic"]["harbor_drowning_03"] = % harbor_drowning_03;
  level.scr_anim["generic"]["harbor_drowning_03_idle"][0] = % harbor_drowning_03_idle;
  level.scr_anim["generic"]["harbor_floating_idle_01"][0] = % harbor_floating_idle_01;
  level.scr_anim["generic"]["harbor_floating_idle_02"][0] = % harbor_floating_idle_02;
  level.scr_anim["generic"]["harbor_floating_idle_03"][0] = % harbor_floating_idle_03;
  level.scr_anim["generic"]["harbor_floating_idle_04"][0] = % harbor_floating_idle_04;
  level.scr_anim["generic"]["harbor_floating_struggle_01"][0] = % harbor_floating_struggle_01;
  level.scr_anim["generic"]["harbor_floating_struggle_02"][0] = % harbor_floating_struggle_02;
  level.scr_anim["generic"]["zodiac_driver_idle"][0] = % prague_zodiac_driver_idle;
}

actor_anims() {
  var_0 = "lonestar";
  level.scr_anim["generic"]["wetsub_idle"] = % ny_harbor_wetsub_npc_idle;
  level.scr_anim["generic"]["wetsub_idle_alt01"] = % ny_harbor_wetsub_npc_idle_alt01;
  level.scr_anim["generic"]["wetsub_idle_alt02"] = % ny_harbor_wetsub_npc_idle_alt02;
  level.scr_anim["generic"]["wetsub_acknowledge"] = % ny_harbor_wetsub_npc_acknowledge;
  level.scr_anim["generic"]["wetsub_fwd"] = % ny_harbor_wetsub_npc_swim_fwd;
  level.scr_anim["generic"]["wetsub_rt"] = % ny_harbor_wetsub_npc_swim_rt;
  level.scr_anim["generic"]["wetsub_lt"] = % ny_harbor_wetsub_npc_swim_lt;
  level.scr_anim["generic"]["wetsub_up"] = % ny_harbor_wetsub_npc_swim_up;
  level.scr_anim["generic"]["wetsub_dn"] = % ny_harbor_wetsub_npc_swim_dwn;
  level.scr_anim["generic"]["wetsub_fwd_alt"] = % ny_harbor_wetsub_npc_swim_fwd_alt;
  level.scr_anim["generic"]["wetsub_rt_alt"] = % ny_harbor_wetsub_npc_swim_rt_alt;
  level.scr_anim["generic"]["wetsub_lt_alt"] = % ny_harbor_wetsub_npc_swim_lt_alt;
  level.scr_anim["generic"]["balcony_fallloop_onback"][0] = % balcony_fallloop_onback;
  level.scr_anim["generic"]["balcony_fallloop_tumbleforwards"][0] = % balcony_fallloop_tumbleforwards;
  level.scr_anim["generic"]["ny_harbor_slams_bulkhead_door_shut"] = % ny_harbor_slams_bulkhead_door_shut;
  level.scr_anim["generic"]["ny_harbor_door_open"] = % ny_harbor_door_open;
  level.scr_anim["generic"]["ny_harbor_ssbn_coughing_recovery_guy1"] = % ny_harbor_ssbn_coughing_recovery_guy1;
  maps\_anim::addnotetrack_customfunction("generic", "KILL ME", maps\ny_harbor_code_sub::sandman_kill, "ny_harbor_ssbn_coughing_recovery_guy1");
  level.scr_anim["generic"]["ny_harbor_ssbn_coughing_recovery_guy2"] = % ny_harbor_ssbn_coughing_recovery_guy2;
  level.scr_anim["generic"]["ny_harbor_door_breach"] = % ny_harbor_door_breach_guy1;
  level.scr_anim["generic"]["ny_harbor_affected_russian_guy1"] = % ny_harbor_affected_russian_guy1;
  level.scr_anim["generic"]["npc_plant_side"] = % ny_harbor_wetsub_npc_plant_mine_side;
  level.scr_anim["generic"]["npc_plant_up"] = % ny_harbor_wetsub_npc_plant_mine_up;
  level.scr_anim["generic"]["ny_harbor_paried_takedown_sandman_start"] = % ny_harbor_paried_takedown_sandman_start;
  level.scr_anim["lonestar"]["ny_harbor_captain_search_flip_over"] = % ny_harbor_paried_takedown_sandman_flip_over;
  level.scr_anim["lonestar"]["ny_harbor_captain_search_flip_over_b"] = % ny_harbor_paried_takedown_sandman_flip_over_b;
  level.scr_anim["lonestar"]["ny_harbor_captain_search_flip_over_c"] = % ny_harbor_paried_takedown_sandman_flip_over_c;
  maps\_anim::addnotetrack_customfunction("lonestar", "gotkey_dialog", maps\ny_harbor_code_vo::vo_sub_sandman_got_key, "ny_harbor_captain_search_flip_over");
  maps\_anim::addnotetrack_customfunction("lonestar", "sandman_dialog", maps\ny_harbor_code_vo::vo_sub_sandman_captain_flip, "ny_harbor_captain_search_flip_over_b");
  level.scr_anim["generic"]["ny_harbor_delta_bulkhead_open_guy1_v2"] = % ny_harbor_delta_bulkhead_open_guy1_v2;
  level.scr_anim[var_0]["ny_harbor_ladder_slide_sandman"] = % ny_harbor_ladder_slide_sandman;
  level.scr_anim[var_0]["ny_harbor_sandman_drops_frag_inhatch"] = % ny_harbor_sandman_drops_frag_inhatch;
  level.scr_anim[var_0]["open_with_wheel"] = % ny_harbor_delta_bulkhead_open_guy1_v2;
  level.scr_anim[var_0]["open_with_wheel_approach"] = % corner_standl_trans_cqb_in_8;
  level.scr_anim["barracks_2"]["slam_door"] = % ny_harbor_slams_bulkhead_door_shut;
  level.scr_anim["generic"]["launchfacility_b_blast_door_seq_waveidle"] = % launchfacility_b_blast_door_seq_waveidle;
  level.scr_anim[var_0]["barracks_sandman_exit"] = % ny_harbor_door_open;
  level.scr_anim[var_0]["barracks_sandman_exit_idle"][0] = % ny_harbor_door_idle;
  level.scr_anim["generic"]["ny_harbor_doorway_headsmash"] = % ny_harbor_doorway_headsmash_enemy;
  level.scr_anim["generic"]["ny_harbor_doorway_headsmash_enemy_deadpose"] = % ny_harbor_doorway_headsmash_enemy_deadpose;
  level.scr_anim[var_0]["ny_harbor_doorway_headsmash"] = % ny_harbor_doorway_headsmash_sandman;
  level.scr_anim[var_0]["ny_harbor_doorway_headsmash_no_gun_flip"] = % ny_harbor_doorway_headsmash_sandman_no_gun_flip;
  level.scr_anim["guy"]["extinguisher_loop"][0] = % ny_harbor_fire_extinguisher_npc_loop;
  level.scr_anim["generic"]["blow_back_dead"] = % blow_back_dead;
  level.scr_anim["generic"]["hunted_dying_deadguy"] = % hunted_dying_deadguy;
  level.scr_anim["generic"]["death_sitting_pose_v1"][0] = % death_sitting_pose_v1;
  level.scr_anim["generic"]["death_sitting_pose_v1_nl"] = % death_sitting_pose_v1;
  level.scr_anim["generic"]["death_sitting_pose_v2"] = % death_sitting_pose_v2;
  level.scr_anim[var_0]["ny_harbor_door_breach_idle"][0] = % ny_harbor_door_breach_sandman_idle;
  level.scr_face[var_0]["nyharbor_lns_kickercharge"] = % ny_harbor_door_breach_sandman_face;
  level.scr_anim[var_0]["ny_harbor_door_breach_idle_trans"] = % ny_harbor_door_breach_sandman_idle_trans;
  level.scr_anim[var_0]["ny_harbor_door_breach"] = % ny_harbor_door_breach_sandman;
  maps\_anim::addnotetrack_customfunction("lonestar", "Show_Charge_1", maps\ny_harbor_code_sub::show_charge_1, "ny_harbor_door_breach");
  maps\_anim::addnotetrack_customfunction("lonestar", "Detach_Charge_1", maps\ny_harbor_code_sub::detach_charge_1, "ny_harbor_door_breach");
  maps\_anim::addnotetrack_customfunction("lonestar", "Show_Charge_2", maps\ny_harbor_code_sub::show_charge_2, "ny_harbor_door_breach");
  maps\_anim::addnotetrack_customfunction("lonestar", "Detach_Charge_2", maps\ny_harbor_code_sub::detach_charge_2, "ny_harbor_door_breach");
  level.scr_anim["generic"]["breach_enemy_1"] = % patrol_bored_react_walkstop;
  level.scr_anim["breacher1"]["breach_enemy_2"] = % breach_react_push_guy1;
  level.scr_anim["breacher2"]["breach_enemy_2"] = % breach_react_push_guy2;
  level.scr_anim["knife_guy"]["breach_react_knife_idle"] = % breach_react_knife_idle;
  level.scr_anim["knife_guy"]["breach_react_knife_charge"] = % breach_react_knife_charge;
  level.scr_anim["knife_guy"]["breach_react_knife_charge_death"] = % death_shotgun_back_v1;
  maps\_anim::addnotetrack_attach("generic", "attach knife right", "weapon_parabolic_knife", "TAG_INHAND");
  maps\_anim::addnotetrack_detach("generic", "detach knife right", "weapon_parabolic_knife", "TAG_INHAND", "breach_react_knife_charge");
  level.scr_anim["generic"]["ny_harbor_paried_takedown_captain_start"] = % ny_harbor_paried_takedown_captain_start;
  level.scr_anim["generic"]["ny_harbor_paried_takedown_captain_dead_1"] = % ny_harbor_paried_takedown_captain_dead_1;
  level.scr_anim["generic"]["ny_harbor_paried_takedown_captain_die"] = % ny_harbor_paried_takedown_captain_die;
  level.scr_anim["generic"]["ny_harbor_captain_search_flip_over"] = % ny_harbor_paried_takedown_captain_flip_over;
  level.scr_anim["lonestar"]["sub_turn_key"] = % ny_harbor_missle_key_sandman_turnkey;
  level.scr_anim["lonestar"]["sub_turn_key2"] = % ny_harbor_missle_key_sandman_turnkey2;
  level.scr_anim["generic"]["sub_turn_key_idle"][0] = % ny_harbor_missle_key_sandman_idle;
  maps\_anim::addnotetrack_customfunction("lonestar", "green_light_on", maps/ny_harbor_fx::greenlighton_vfx, "sub_turn_key");
  maps\_anim::addnotetrack_customfunction("lonestar", "red_light_off", maps/ny_harbor_fx::redlightoff_vfx, "sub_turn_key2");
  level.scr_anim[var_0]["sub_exit_jump"] = % ny_harbor_sub_exit_sandman_jump;
  level.scr_anim["generic"]["ny_harbor_davora_front_turret_death"] = % ny_harbor_davora_front_turret_death;
  level.scr_anim["generic"]["ny_harbor_davora_side_fall_death"] = % ny_harbor_davora_side_fall_death;
  level.scr_anim["generic"]["stand_death_shoulderback"] = % stand_death_shoulderback;
  level.scr_anim["generic"]["ny_harbor_stand_death_shoulderback_pose"][0] = % ny_harbor_stand_death_shoulderback_pose;
  level.scr_anim["lonestar"]["surfacing"] = % ny_harbor_sub_surface_npc;
  level.scr_anim["lonestar"]["boarding"] = % ny_harbor_sub_surface_npc_pt2;
  level.scr_anim["lonestar"]["tunnel_intro"] = % ny_harbor_underwater_cutting_sandman;
  maps\_anim::addnotetrack_customfunction("lonestar", "vo_grate", maps\ny_harbor_code_vo::vo_sandman_grate, "tunnel_intro");
  level.scr_anim["lonestar"]["exit_to_zodiac"] = % ny_harbor_sub_exit_sandman_trans;
  level.scr_anim["lonestar"]["wave_from_zodiac"] = % ny_harbor_sub_exit_sandman_wave;
  level.scr_anim["lonestar"]["launch_react"] = % ny_harbor_sandman_launch_react;
  level.scr_anim["lonestar"]["finale_escape"] = % ny_harbor_finale_airlift_sandman;
  level.scr_animtree["ch_guy1"] = #animtree;
  level.scr_anim["ch_guy1"]["finale_escape"] = % ny_harbor_finale_airlift_guy1;
  level.scr_anim["ch_guy1"]["chinook_idle"][0] = % ny_harbor_finale_airlift_guy1_idle;
  level.scr_animtree["ch_guy2"] = #animtree;
  level.scr_anim["ch_guy2"]["finale_escape"] = % ny_harbor_finale_airlift_guy2;
  level.scr_anim["ch_guy2"]["chinook_idle"][0] = % ny_harbor_finale_airlift_guy2_idle;
  level.scr_anim["generic"]["exposed_crouch_death_fetal"] = % exposed_crouch_death_fetal;
  level.scr_anim["generic"]["exposed_crouch_death_twist"] = % exposed_crouch_death_twist;
}

#using_animtree("vehicles");

ss_n_12_anims() {
  level.scr_animtree["ss_n_12_missile"] = #animtree;
  level.scr_anim["ss_n_12_missile"]["open"] = % ss_n_12_missile_open;
  level.scr_anim["ss_n_12_missile"]["open_idle"] = % ss_n_12_missile_open_idle;
  level.scr_anim["ss_n_12_missile"]["close_idle"] = % ss_n_12_missile_close_idle;
}

blackshadow_anims() {
  level.scr_animtree["blackshadow"] = #animtree;
  level.scr_anim["blackshadow"]["npc_plant_side"] = % ny_harbor_wetsub_vehicle_plant_mine_side;
  level.scr_anim["blackshadow"]["npc_plant_up"] = % ny_harbor_wetsub_vehicle_plant_mine_up;
  level.scr_anim["blackshadow"]["mine_plant"] = % ny_harbor_wetsub_plantmine_vehicle;
  level.scr_anim["blackshadow"]["surfacing"] = % ny_harbor_sub_surface_vehicle;
  level.scr_anim["blackshadow"]["tunnel_intro"] = % ny_harbor_underwater_cutting_sdv2;
  level.scr_anim["player_sdv"]["tunnel_intro"] = % ny_harbor_underwater_cutting_sdv1;
  level.scr_anim["player_sdv"]["tunnel_spline"] = % ny_harbor_underwater_cutting_sdv1_pt2;
}

ch46e_ny_harbor_anims() {
  level.scr_animtree["ch46e"] = #animtree;
  level.scr_anim["ch46e"]["open_rear"] = % ch46e_ny_harbor_open_rear;
  level.scr_anim["ch46e"]["open_rear_loop"][0] = % ch46e_ny_harbor_open_rear_loop;
  level.scr_anim["ch46e"]["wide_open_rear_loop"][0] = % ch46e_ny_harbor_wide_open_rear_loop;
  level.scr_anim["ch46e"]["chinook_landing"] = % ny_harbor_finale_airlift_ch46_start;
  level.scr_anim["ch46e"]["chinook_pre_idle"] = % ny_harbor_finale_airlift_ch46_idle;
  level.scr_anim["ch46e"]["chinook_idle"][0] = % ny_harbor_finale_airlift_ch46_idle;
  level.scr_anim["ch46e"]["finale_escape"] = % ny_harbor_finale_airlift_ch46_end;
  level.scr_anim["ch46e"]["rotors"] = % sniper_escape_ch46_rotors;
  level.scr_animtree["ch46e2"] = #animtree;
  level.scr_anim["ch46e2"]["chinook_landing"] = % ny_harbor_finale_airlift_ch46_2_start;
  level.scr_anim["ch46e2"]["chinook_idle"][0] = % ny_harbor_finale_airlift_ch46_2_idle;
  level.scr_anim["ch46e2"]["rotors"] = % sniper_escape_ch46_rotors;
}

russian_sub_anims() {
  level.scr_animtree["russian_sub"] = #animtree;
  level.scr_anim["russian_sub"]["surfacing"] = % ny_harbor_sub_surface;
  level.scr_anim["russian_sub"]["propellers"][0] = % russian_oscar2_propellers;
}

zodiac_anims() {
  level.scr_animtree["zodiac"] = #animtree;
  level.scr_anim["zodiac"]["exit_to_zodiac"] = % ny_harbor_sub_exit_zodiac;
  level.scr_anim["zodiac"]["carrier_start"] = % ny_harbor_finale_bump_zodiac_start;
  level.scr_anim["zodiac"]["carrier_breach"] = % ny_harbor_finale_bump_zodiac_breach;
  level.scr_anim["zodiac"]["carrier_end"] = % ny_harbor_finale_bump_zodiac_end;
  level.scr_anim["zodiac_player"]["finale_escape"] = % ny_harbor_finale_airlift_zodiac_end;
}

dvora_anims() {
  level.scr_animtree["dvora"] = #animtree;
  level.scr_anim["dvora"]["carrier_start"] = % ny_harbor_finale_bump_dvora_start;
  level.scr_anim["dvora"]["carrier_breach"] = % ny_harbor_finale_bump_dvora_breach;
  level.scr_anim["dvora"]["carrier_end"] = % ny_harbor_finale_bump_dvora_end;
  level.scr_anim["dvora"]["destory"] = % ny_harbor_finale_bump_dvora_destroy;
  level.scr_anim["dvora"]["destorychunk"] = % ny_harbor_finale_bump_dvora_destroychunk;
}

prop_anims() {}

#using_animtree("script_model");

script_model_anims() {
  level.scr_animtree["door_charge"] = #animtree;
  level.scr_model["door_charge"] = "weapon_frame_charge_iw5";
  level.scr_anim["door_charge"]["ny_harbor_door_breach"] = % ny_harbor_door_breach_player_charge2;
  level.scr_animtree["breach_door"] = #animtree;
  level.scr_model["breach_door"] = "ny_harbor_sub_pressuredoor_bridge";
  level.scr_anim["breach_door"]["ny_harbor_door_breach"] = % ny_harbor_door_breach_pressure_door;
  level.scr_animtree["breach_detonator1"] = #animtree;
  level.scr_model["breach_detonator1"] = "weapon_c4_detonator_iw5";
  level.scr_anim["breach_detonator1"]["ny_harbor_door_breach"] = % ny_harbor_door_breach_detonator_1;
  level.scr_animtree["breach_detonator2"] = #animtree;
  level.scr_model["breach_detonator2"] = "weapon_c4_detonator_iw5";
  level.scr_anim["breach_detonator2"]["ny_harbor_door_breach"] = % ny_harbor_door_breach_detonator_2;
  level.scr_animtree["breach_charge1"] = #animtree;
  level.scr_model["breach_charge1"] = "weapon_frame_charge_iw5_c4";
  level.scr_anim["breach_charge1"]["ny_harbor_door_breach"] = % ny_harbor_door_breach_sandman_charge1;
  level.scr_animtree["breach_charge2"] = #animtree;
  level.scr_model["breach_charge2"] = "weapon_frame_charge_iw5_c4";
  level.scr_anim["breach_charge2"]["ny_harbor_door_breach"] = % ny_harbor_door_breach_sandman_charge2;
  level.scr_animtree["missile_key_panel_box"] = #animtree;
  level.scr_model["missile_key_panel_box"] = "ny_harbor_missle_key_panel";
  level.scr_anim["missile_key_panel_box"]["sub_turn_key"] = % ny_harbor_missle_key_panel;
  level.scr_animtree["missile_key_panel"] = #animtree;
  level.scr_model["missile_key_panel"] = "ny_harbor_missle_key_box";
  level.scr_anim["missile_key_panel"]["sub_turn_key"] = % ny_harbor_missle_key_panel_launch_box;
  level.scr_animtree["tunnel_grate"] = #animtree;
  level.scr_model["tunnel_grate"] = "ny_harbor_tunnel_grate";
  level.scr_anim["tunnel_grate"]["tunnel_intro"] = % ny_harbor_underwater_cutting_grate;
  level.scr_animtree["torch"] = #animtree;
  level.scr_model["torch"] = "weapon_underwater_torch";
  level.scr_anim["torch"]["tunnel_intro"] = % ny_harbor_underwater_cutting_torch;
  level.scr_anim["mine"]["npc_plant_side"] = % ny_harbor_wetsub_mine_plant_mine_side;
  level.scr_anim["mine"]["npc_plant_up"] = % ny_harbor_wetsub_mine_plant_mine_up;
  level.scr_anim["mine"]["mine_plant"] = % ny_harbor_wetsub_plantmine_mine;
  level.scr_anim["mine"]["mine_ref"] = % ny_harbor_wetsub_plantmine_mine_ref;
  level.scr_animtree["mine"] = #animtree;
  level.scr_animtree["wave_front"] = #animtree;
  level.scr_anim["wave_front"]["wave"] = % fx_nyharbor_wave_front_anim;
  level.scr_animtree["wave_crashing"] = #animtree;
  level.scr_anim["wave_crashing"]["wave"] = % fx_nyharbor_wave_crashing_anim;
  level.scr_animtree["wave_side"] = #animtree;
  level.scr_anim["wave_side"]["wave"] = % fx_nyharbor_wave_side_anim;
  level.scr_animtree["explosion_wave"] = #animtree;
  level.scr_anim["explosion_wave"]["wave"] = % fx_nyharbor_explosion_wave_anim;
  level.scr_animtree["wave_displace"] = #animtree;
  level.scr_anim["wave_displace"]["wave"] = % fx_nyharbor_wave_displace_anim;
  level.scr_animtree["smoke_column"] = #animtree;
  level.scr_anim["smoke_column"]["fire"] = % fx_ny_smoke_column_anim;
  level.scr_anim["smoke_column"]["rot"] = % fx_ny_smoke_column_rot_anim;
  level.scr_animtree["missile_door"] = #animtree;
  level.scr_anim["missile_door"]["open"] = % ny_harbor_sub_missile_door_open;
  level.scr_animtree["missile_hatch"] = #animtree;
  level.scr_anim["missile_hatch"]["open"] = % ny_harbor_sub_missile_hatch_open;
  level.scr_animtree["burya"] = #animtree;
  level.scr_anim["burya"]["destruct_front"] = % ny_harbor_burya_corvette_front_blow;
  level.scr_anim["burya"]["destruct_mid"] = % ny_harbor_burya_corvette_mid_blow;
  level.scr_anim["burya"]["destruct_rear"] = % ny_harbor_burya_corvette_rear_blow;
  level.scr_animtree["mask"] = #animtree;
  level.scr_model["mask"] = "ny_harbor_dive_gear_mask";
  level.scr_anim["mask"]["boarding"] = % ny_harbor_sub_surface_mask;
  level.scr_animtree["extinguisher"] = #animtree;
  level.scr_model["extinguisher"] = "com_fire_extinguisher_anim";
  level.scr_anim["extinguisher"]["extinguisher_loop"][0] = % ny_harbor_fire_extinguisher_prop_loop;
}

door() {
  level.scr_animtree["door"] = #animtree;
  level.scr_model["door"] = "ny_harbor_sub_pressuredoor_rigged";
  level.scr_anim["door"]["open_with_wheel"] = % ny_harbor_delta_bulkhead_open_door_v2;
  level.scr_anim["door"]["slam_door"] = % ny_harbor_slams_bulkhead_door_shut_door;
  level.scr_anim["door"]["barracks_sandman_exit"] = % ny_harbor_door_open_door;
}

#using_animtree("generic_human");

squad_vo() {
  var_0 = "lonestar";
  level.scr_radio["nyharbor_rno_inposition"] = "nyharbor_rno_inposition";
  level.scr_radio["nyharbor_lns_radiocheck"] = "nyharbor_lns_radiocheck";
  level.scr_radio["nyharbor_sel_fivebyfive"] = "nyharbor_sel_fivebyfive";
  level.scr_radio["nyharbor_lns_starttheparty"] = "nyharbor_lns_starttheparty";
  level.scr_radio["nyharbor_sel_copythat"] = "nyharbor_sel_copythat";
  level.scr_radio["nyharbor_rno_dontstart"] = "nyharbor_rno_dontstart";
  level.scr_radio["nyharbor_lns_almostthrough"] = "nyharbor_lns_almostthrough";
  level.scr_radio["nyharbor_lns_entrypoint"] = "nyharbor_lns_entrypoint";
  level.scr_radio["nyharbor_lns_linkup"] = "nyharbor_lns_linkup";
  level.scr_radio["nyharbor_rno_gotout"] = "nyharbor_rno_gotout";
  level.scr_radio["nyharbor_lns_forthem"] = "nyharbor_lns_forthem";
  level.scr_radio["nyharbor_sel_ontracker"] = "nyharbor_sel_ontracker";
  level.scr_radio["nyharbor_lns_approachingrv"] = "nyharbor_lns_approachingrv";
  level.scr_radio["nyharbor_lns_upahead"] = "nyharbor_lns_upahead";
  level.scr_radio["nyharbor_rno_iseethem"] = "nyharbor_rno_iseethem";
  level.scr_radio["nyharbor_sel_intercept"] = "nyharbor_sel_intercept";
  level.scr_radio["nyharbor_lns_leadtheway"] = "nyharbor_lns_leadtheway";
  level.scr_radio["nyharbor_sel_watchsonar"] = "nyharbor_sel_watchsonar";
  level.scr_radio["nyharbor_lns_eyesonsonar"] = "nyharbor_lns_eyesonsonar";
  level.scr_radio["nyharbor_rno_mineleft"] = "nyharbor_rno_mineleft";
  level.scr_radio["nyharbor_lns_right"] = "nyharbor_lns_right";
  level.scr_radio["nyharbor_lns_keepitsteady"] = "nyharbor_lns_keepitsteady";
  level.scr_radio["nyharbor_lns_anothermine"] = "nyharbor_lns_anothermine";
  level.scr_radio["nyharbor_lns_right"] = "nyharbor_lns_right";
  level.scr_radio["nyharbor_rno_mine"] = "nyharbor_rno_mine";
  level.scr_radio["nyharbor_lns_clear"] = "nyharbor_lns_clear";
  level.scr_radio["nyharbor_sel_targetapproaching"] = "nyharbor_sel_targetapproaching";
  level.scr_radio["nyharbor_lns_powerdown"] = "nyharbor_lns_powerdown";
  level.scr_radio["nyharbor_sel_steady"] = "nyharbor_sel_steady";
  level.scr_radio["nyharbor_lns_waittilpasses"] = "nyharbor_lns_waittilpasses";
  level.scr_radio["nyharbor_lns_okaygo"] = "nyharbor_lns_okaygo";
  level.scr_radio["nyharbor_lns_frostmove"] = "nyharbor_lns_frostmove";
  level.scr_radio["nyharbor_lns_getinposition"] = "nyharbor_lns_getinposition";
  level.scr_radio["nyharbor_lns_plantjaywick"] = "nyharbor_lns_plantjaywick";
  level.scr_radio["nyharbor_lns_hurryup"] = "nyharbor_lns_hurryup";
  level.scr_radio["nyharbor_sel_planting"] = "nyharbor_sel_planting";
  level.scr_radio["nyharbor_rno_planting"] = "nyharbor_rno_planting";
  level.scr_radio["nyharbor_lns_minesarmed"] = "nyharbor_lns_minesarmed";
  level.scr_radio["nyharbor_sel_goodjob"] = "nyharbor_sel_goodjob";
  level.scr_radio["nyharbor_lns_goingexplosive"] = "nyharbor_lns_goingexplosive";
  level.scr_radio["nyharbor_lns_commencingassault"] = "nyharbor_lns_commencingassault";
  level.scr_radio["nyharbor_hqr_primaryobjective"] = "nyharbor_hqr_primaryobjective";
  level.scr_radio["nyharbor_lns_holdposition"] = "nyharbor_lns_holdposition";
  level.scr_radio["nyharbor_lns_plantyourmine"] = "nyharbor_lns_plantyourmine";
  level.scr_radio["nyharbor_lns_frostgetinposition"] = "nyharbor_lns_frostgetinposition";
  level.scr_radio["nyharbor_lns_hurryup"] = "nyharbor_lns_hurryup";
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
  level.scr_radio["nyharbor_rpa_evacuate"] = "nyharbor_rpa_evacuate";
  level.scr_sound[var_0]["nyharbor_lns_scuttle"] = "nyharbor_lns_scuttle";
  level.scr_sound[var_0]["nyharbor_lns_takepoint"] = "nyharbor_lns_takepoint";
  level.scr_sound["lonestar"]["nyharbor_lns_stairsclear"] = "nyharbor_lns_stairsclear";
  level.scr_sound["lonestar"]["nyharbor_lns_takeleft"] = "nyharbor_lns_takeleft";
  level.scr_sound[var_0]["nyharbor_lns_tothebridge2"] = "nyharbor_lns_tothebridge2";
  level.scr_sound[var_0]["nyharbor_lns_kickercharge"] = "nyharbor_lns_kickercharge";
  level.scr_sound[var_0]["nyharbor_lns_areasecure"] = "nyharbor_lns_areasecure";
  level.scr_sound[var_0]["nyharbor_lns_launchkeys"] = "nyharbor_lns_launchkeys";
  level.scr_sound[var_0]["nyharbor_lns_checkpointneptune"] = "nyharbor_lns_checkpointneptune";
  level.scr_radio["nyharbor_hqr_copyneptune"] = "nyharbor_hqr_copyneptune";
  level.scr_sound[var_0]["nyharbor_lns_missilekey"] = "nyharbor_lns_missilekey";
  level.scr_face[var_0]["nyharbor_lns_missilekey"] = % ny_harbor_paried_takedown_sandman_flip_over_c_face;
  level.scr_radio["nyharbor_hqr_coordinates"] = "nyharbor_hqr_coordinates";
  level.scr_sound[var_0]["nyharbor_lns_launchin30"] = "nyharbor_lns_launchin30";
  level.scr_face[var_0]["nyharbor_lns_launchin30"] = % ny_harbor_missle_key_sandman_idle_face;
  level.scr_sound[var_0]["nyharbor_lns_console"] = "nyharbor_lns_console";
  level.scr_sound[var_0]["nyharbor_lns_overhere"] = "nyharbor_lns_overhere";
  level.scr_sound[var_0]["nyharbor_lns_321turn"] = "nyharbor_lns_321turn";
  level.scr_face[var_0]["nyharbor_lns_321turn"] = % ny_harbor_missle_key_sandman_turnkey_face;
  level.scr_sound[var_0]["nyharbor_lns_missiles"] = "nyharbor_lns_missiles";
  level.scr_radio["nyharbor_hqr_teaminposition"] = "nyharbor_hqr_teaminposition";
  level.scr_sound["lonestar"]["nyharbor_lns_gogo"] = "nyharbor_lns_gogo";
  level.scr_sound["lonestar"]["nyharbor_lns_thisway"] = "nyharbor_lns_thisway";
  level.scr_sound["lonestar"]["nyharbor_lns_letsroll"] = "nyharbor_lns_letsroll";
  level.scr_radio["nyharbor_rno_amentothat"] = "nyharbor_rno_amentothat";
  level.scr_sound[var_0]["nyharbor_lns_missileslaunching"] = "nyharbor_lns_missileslaunching";
  level.scr_sound[var_0]["nyharbor_lns_punchit"] = "nyharbor_lns_punchit";
  level.scr_sound[var_0]["nyharbor_lns_keepup"] = "nyharbor_lns_keepup";
  level.scr_sound[var_0]["nyharbor_lns_gunit"] = "nyharbor_lns_gunit";
  level.scr_sound[var_0]["nyharbor_lns_keepongoing"] = "nyharbor_lns_keepongoing";
  level.scr_sound[var_0]["nyharbor_lns_missilescoming"] = "nyharbor_lns_missilescoming";
  level.scr_sound[var_0]["nyharbor_lns_lookout"] = "nyharbor_lns_lookout";
  level.scr_sound[var_0]["nyharbor_lns_shootmines"] = "nyharbor_lns_shootmines";
  level.scr_radio["nyharbor_plt_feetwet"] = "nyharbor_plt_feetwet";
  level.scr_sound[var_0]["nyharbor_lns_theresourbird"] = "nyharbor_lns_theresourbird";
  level.scr_sound[var_0]["nyharbor_lns_theresheis"] = "nyharbor_lns_theresheis";
  level.scr_sound[var_0]["nyharbor_lns_missioncomplete"] = "nyharbor_lns_missioncomplete";
  level.scr_radio["nyharbor_hqr_oneforbooks"] = "nyharbor_hqr_oneforbooks";
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

building_destruction() {
  level.scr_animtree["building_des"] = #animtree;
  level.scr_anim["building_des"]["ny_manhattan_building_exchange_01_facade_des_anim"] = % ny_manhattan_building_exchange_01_facade_des_anim;
}

anim_rumble_small(var_0) {
  level.player playRumbleOnEntity("viewmodel_small");
}

anim_rumble_medium(var_0) {
  level.player playRumbleOnEntity("viewmodel_medium");
}

anim_rumble_large(var_0) {
  level.player playRumbleOnEntity("viewmodel_large");
}