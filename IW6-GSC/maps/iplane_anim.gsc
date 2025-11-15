/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\iplane_anim.gsc
*****************************************************/

main() {
  precacheanims();
}

precacheanims() {
  human_anims();
  player_animations();
  model_anims();
  tarps();
  new_interrogation();
  vehicles();
}

#using_animtree("generic_human");

new_interrogation() {
  level.scr_anim["vargas"]["int_intro"] = % plane_new_rorke_intro;
  level.scr_anim["vargas"]["int_intro_idle"][0] = % plane_new_rorke_intro_idle;
  level.scr_anim["vargas"]["int_drag"] = % plane_new_rorke_drag;
  level.scr_anim["vargas"]["int_slam"] = % plane_new_rorke_end;
  level.scr_anim["elias"]["int_intro"] = % plane_new_elias_intro;
  level.scr_anim["elias"]["int_intro_idle"][0] = % plane_new_elias_intro_idle;
  level.scr_anim["elias"]["int_nag"] = % plane_new_elias_intro_nag_a;
  level.scr_anim["elias"]["int_drag"] = % plane_new_elias_drag;
  level.scr_anim["elias"]["int_drag_idle"][0] = % plane_new_elias_drag_idle;
  level.scr_anim["elias"]["int_slam"] = % plane_new_elias_end;
  maps\_anim::addnotetrack_notify("elias", "elias_lookup", "start_plane_attack", "int_slam");
  maps\_anim::addnotetrack_notify("elias", "pistol_pickup", "equip_pistol", "int_slam");
  maps\_anim::addnotetrack_notify("elias", "start_headlook", "headlook_start", "int_drag");
  maps\_anim::addnotetrack_notify("elias", "end_headlook", "end_headlook", "int_drag");
  level.scr_anim["hesh"]["int_intro"] = % plane_new_hesh_intro;
  level.scr_anim["hesh"]["int_intro_idle"][0] = % plane_new_hesh_intro_idle;
  level.scr_anim["hesh"]["int_drag"] = % plane_new_hesh_drag;
  level.scr_anim["hesh"]["int_slam"] = % plane_new_hesh_end;
  level.scr_anim["merrick"]["int_intro"] = % plane_new_merrick_intro;
  level.scr_anim["merrick"]["int_intro_idle"][0] = % plane_new_merrick_intro_idle;
  level.scr_anim["keegan"]["int_intro"] = % plane_new_keegan_intro;
  level.scr_anim["keegan"]["int_intro_idle"][0] = % plane_new_keegan_intro_idle;
}

human_anims() {
  level.scr_anim["generic"]["int_unarmed_walk"][0] = % civilian_walk_cool;
  level.scr_anim["hesh"]["hesh_intro_idle_1"][0] = % nml_vargas_idle;
  level.scr_anim["hesh"]["hesh_hold_vargas"] = % payback_city_truck_push_a;
  level.scr_anim["elias"]["elias_intro_idle_1"] = % village_interrogationb_price;
  level.scr_anim["elias"]["elias_door_open"][0] = % nml_vargas_idle;
  level.scr_anim["elias"]["elias_drop_vargas"] = % payback_city_truck_push_a;
  level.scr_anim["merrick"]["merrick_wait_at_door"][0] = % nml_vargas_idle;
  level.scr_anim["keegan"]["elias_door_open"][0] = % nml_vargas_idle;
  level.scr_anim["vargas"]["hostage_chair_idle"][0] = % hostage_chair_twitch;
  level.scr_anim["vargas"]["hostage_chair_idle"][0] = % hostage_chair_idle;
  level.scr_anim["generic"]["p_soldier_a_idle"][0] = % plane_soldier_a_idle;
  level.scr_anim["generic"]["p_soldier_a_in"] = % plane_soldier_a_in;
  level.scr_anim["generic"]["p_soldier_a_out"] = % plane_soldier_a_out;
  level.scr_anim["generic"]["p_soldier_b_idle"][0] = % plane_soldier_b_idle;
  level.scr_anim["generic"]["p_soldier_b_in"] = % plane_soldier_b_in;
  level.scr_anim["generic"]["p_soldier_b_out"] = % plane_soldier_b_out;
  level.scr_anim["generic"]["p_soldier_c_idle"][0] = % plane_soldier_c_idle;
  level.scr_anim["generic"]["p_soldier_c_in"] = % plane_soldier_c_in;
  level.scr_anim["generic"]["p_soldier_c_out"] = % plane_soldier_c_out;
  level.scr_anim["generic"]["p_soldier_d_idle"][0] = % plane_soldier_d_idle;
  level.scr_anim["generic"]["p_soldier_d_in"] = % plane_soldier_d_in;
  level.scr_anim["generic"]["p_soldier_d_out"] = % plane_soldier_d_out;
  level.scr_anim["vargas"]["vargas_fall_1"] = % plane_hostage_fall;
  maps\_anim::addnotetrack_sound("vargas", "start", "vargas_fall_1", "scn_iplane_rorke_in_land");
  level.scr_anim["generic"]["plane_friendly_r"] = % plane_friendly_rescue;
  level.scr_anim["vargas"]["plane_friendly_r"] = % plane_hostage_rescue;
  level.scr_anim["vargas"]["plane_hostage_talk_i"][0] = % plane_hostage_talk_idle;
}

_setup_chair() {}

#using_animtree("script_model");

model_anims() {
  level.scr_animtree["chair_real"] = #animtree;
  level.scr_model["chair_real"] = "com_folding_chair";
  level.scr_anim["chair_real"]["int_intro"] = % plane_new_chair_intro;
  level.scr_anim["chair_real"]["int_intro_idle"][0] = % plane_new_chair_intro_idle;
  level.scr_anim["chair_real"]["int_drag_idle"][0] = % plane_new_chair_drag;
  level.scr_anim["chair_real"]["int_slam"] = % plane_new_chair_end;
  level.scr_anim["chair_real"]["vargas_fall_1"] = % plane_chair_fall;
  level.scr_goaltime["chair_real"]["vargas_fall_1"] = 0.75;
  level.scr_animtree["sky_anim"] = #animtree;
  level.scr_model["sky_anim"] = "jungle_sky_model";
  level.scr_animtree["bottom_ramp"] = #animtree;
  level.scr_model["bottom_ramp"] = "tag_origin";
  level.scr_animtree["enemy_plane"] = #animtree;
  level.scr_model["enemy_plane"] = "vehicle_Y_8";
  level.scr_animtree["top_ramp"] = #animtree;
  level.scr_model["top_ramp"] = "tag_origin";
  level.scr_animtree["ramp_model_tarp"] = #animtree;
  level.scr_model["ramp_model_tarp"] = "highrise_fencetarp_03";
  level.scr_anim["ramp_model_tarp"]["tarp_flapping"] = % payback_sstorm_tarp_03_wind_2;
  level.scr_animtree["tail"] = #animtree;
  level.scr_model["tail"] = "tag_origin";
  level.scr_anim["tail"]["tail_ripoff"] = % plane_tail_ripoff;
  level.scr_animtree["wing_L"] = #animtree;
  level.scr_model["wing_L"] = "tag_origin";
  level.scr_anim["wing_L"]["wing_L_ripoff"] = % plane_wing_l_ripoff;
  level.scr_animtree["plane_body"] = #animtree;
  level.scr_model["plane_body"] = "tag_origin";
  level.scr_anim["plane_body"]["body_turn_up"] = % plane_body_turn_up;
  maps\_anim::addnotetrack_customfunction("plane_body", "tail_ripoff", ::rotate_secondary_player_enemy, "body_turn_up");
  level.scr_animtree["rope"] = #animtree;
  level.scr_model["rope"] = "tag_origin";
  level.scr_anim["rope"]["rope_fire"] = % blackice_allyrope1_shoot;
  level.scr_animtree["firework"] = #animtree;
  level.scr_model["firework"] = "tag_origin";
  level.scr_anim["firework"]["start_firework"] = % plane_fireworks;
}

rotate_secondary_player_enemy(var_0) {
  thread maps\iplane::rip_tail_off();
}

#using_animtree("player");

player_animations() {
  level.scr_animtree["player_rig"] = #animtree;
  level.scr_model["player_rig"] = "viewhands_player_gs_jungle_b";
  level.scr_anim["player_rig"]["player_fall"] = % plane_player_fall;
  level.scr_anim["player_rig"]["player_fall_2"] = % plane_player_fall_2;
  level.scr_anim["player_rig"]["death_fall"] = % sw_player_fallofftrain;
  level.scr_anim["player_rig"]["parachute_fall"] = % castle_truck_escape_player_deploy_chute;
  level.scr_anim["player_rig"]["highfive_sky"] = % ship_graveyard_lighthouse_fall_player_lurp;
  level.scr_anim["player_rig"]["intro_punch"] = % plane_new_player_punch;
  level.scr_anim["player_rig"]["int_intro"] = % plane_new_player_push_in;
  level.scr_anim["player_rig"]["int_drag_idle"][0] = % plane_new_player_push_idle;
  level.scr_anim["player_rig"]["int_slam"] = % plane_new_player_push_out;
  level.scr_anim["player_rig"]["hanging_idle"][0] = % plane_player_fall_idle;
  maps\_anim::addnotetrack_notify("player_rig", "fade_in", "punch_notetrack_fade_in", "intro_punch");
}

#using_animtree("animated_props");

tarps() {
  level.scr_animtree["taprs0_rock"] = #animtree;
  level.scr_model["taprs0_rock"] = "payback_tarp_crate_wind";
  level.scr_anim["taprs0_rock"]["taprs0_anim"][0] = % mp_cement_tarp4_anim_b;
  level.scr_animtree["crates_tarp"] = #animtree;
  level.scr_model["crates_tarp"] = "mp_cement_tarp4";
  level.scr_anim["crates_tarp"]["tarps_anim"][0] = % payback_tarp_crate_heavy_wind;
  level.scr_anim["crates_tarp"]["tarps_light_anim"][0] = % payback_tarp_crate_light_wind;
  level.scr_animtree["exfil_ripcord_player"] = #animtree;
  level.scr_model["exfil_ripcord_player"] = "viewmodel_parachute_ripcord";
  level.scr_anim["exfil_ripcord_player"]["parachute_fall"] = % castle_truck_escape_player_deploy_chute_ripcord;
  level.scr_animtree["rappel_rope"] = #animtree;
  level.scr_model["rappel_rope"] = "generic_rope_A_animated";
  level.scr_anim["rappel_rope"]["rope_idle_1"][0] = % plane_soldier_a_idle_rope;
  level.scr_anim["rappel_rope"]["rope_in_1"] = % plane_soldier_a_in_rope;
  level.scr_anim["rappel_rope"]["rope_out_1"] = % plane_soldier_a_out_rope;
  level.scr_anim["rappel_rope"]["rope_idle_2"][0] = % plane_soldier_b_idle_rope;
  level.scr_anim["rappel_rope"]["rope_in_2"] = % plane_soldier_b_in_rope;
  level.scr_anim["rappel_rope"]["rope_out_2"] = % plane_soldier_b_out_rope;
  level.scr_anim["rappel_rope"]["rope_idle_3"][0] = % plane_soldier_c_idle_rope;
  level.scr_anim["rappel_rope"]["rope_in_3"] = % plane_soldier_c_in_rope;
  level.scr_anim["rappel_rope"]["rope_out_3"] = % plane_soldier_c_out_rope;
  level.scr_anim["rappel_rope"]["rope_idle_4"][0] = % plane_soldier_d_idle_rope;
  level.scr_anim["rappel_rope"]["rope_in_4"] = % plane_soldier_d_in_rope;
  level.scr_anim["rappel_rope"]["rope_out_4"] = % plane_soldier_d_out_rope;
  level.scr_anim["rappel_rope"]["plane_friendly_r"] = % plane_friendly_rescue_rope;
  level.scr_anim["rappel_rope"]["rope_chair"] = % plane_chair_fall_rope;
}

#using_animtree("vehicles");

vehicles() {
  level.scr_animtree["hummer"] = #animtree;
  level.scr_model["hummer"] = "vehicle_matv_no_top";
  level.scr_anim["hummer"]["hummer_large_rocking"][0] = % hovercraft_rocking;
  level.scr_anim["hummer"]["hummer_small_rocking"][0] = % snowmobile_vehicle_driving_idle;
}