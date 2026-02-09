/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\flood_anim.gsc
*****************************************************/

main() {
  flag_inits();
  player_anims();
  generic_human();
  dialogue();
  script_models();
  vehicles();
  level thread vignettes();
}

anim_precache() {
  precachemodel("viewhands_player_gs_flood");
  precachemodel("vehicle_nh90_interior");
  precachemodel("vehicle_nh90_blood_windshield");
  precachemodel("viewmodel_knife_iw6");
}

vignettes() {
  level thread maps\_vignette_util::vignette_register(::skybridge_doorbreach_spawn, "vignette_skybridge_doorbreach_trigger");
  level thread maps\_vignette_util::vignette_register(::skybridge_ally_approach, "vignette_skybridge_approach");
  level thread maps\_vignette_util::vignette_register(::skybridge_scene_spawn, "vignette_skybridge_flag");
  level thread maps\_vignette_util::vignette_register(::debris_bridge_spawn, "vignette_debris_bridge_loop1_flag");
  level thread maps\_vignette_util::vignette_register(::building_01_debri_anim_spawn, "building_01_debri");
  level thread maps\_vignette_util::vignette_register(::ending_breach_spawn, "vignette_ending_doorbreach_flag");
  level thread maps\_vignette_util::vignette_register(::ending_pt1_player_sequence_start, "vignette_ending_player_jumped_flag");
  level thread maps\_vignette_util::vignette_register(::ending_pt1_sequence, "vignette_ending_scene_start");
  level thread maps\_vignette_util::vignette_register(::ending_pt2_player_sequence_save, "vignette_ending_crash_flag");
  var_0 = getent("dam_break_m880", "targetname");

  if(isDefined(var_0)) {
    level thread dam_break_m880_init();
    level thread dam_break_m880_shadows_init();
  }

  level thread church_destruction_init();
  level thread init_dam_destruction_anim();
  level thread dam_break_street_water_init();
  level thread street_stop_sign_01_spawn();
  level thread maps\_vignette_util::vignette_register(::dam_break_m880_launch_prep_spawn, "vignette_dam_break_m880_launch_prep");

  if(level.start_point != "flooding_ext")
    level thread maps\_vignette_util::vignette_register(::dam_break_spawn, "vignette_dam_break");
}

flag_inits() {
  common_scripts\utility::flag_init("vignette_debris_bridge_vign2_flag");
  common_scripts\utility::flag_init("vignette_debris_bridge_loop3_flag");
  common_scripts\utility::flag_init("vignette_dam_break_end_flag");
  common_scripts\utility::flag_init("vignette_ending_player_jumped_flag");
  common_scripts\utility::flag_init("vignette_ending_scene_start");
  common_scripts\utility::flag_init("vignette_ending_qte_success");
  common_scripts\utility::flag_init("vignette_ending_qte_failure");
  common_scripts\utility::flag_init("vignette_ending_qte_pickup_gun");
  common_scripts\utility::flag_init("vignette_ending_reached");
  common_scripts\utility::flag_init("skybridge_ally_done");
  common_scripts\utility::flag_init("rooftops_water_truck_intro_done");
  common_scripts\utility::flag_init("rooftops_water_flare_intro_done");
  common_scripts\utility::flag_init("debrisbridge_ally_0_ready");
  common_scripts\utility::flag_init("debrisbridge_ally_1_ready");
  common_scripts\utility::flag_init("debrisbridge_ally_2_ready");
  common_scripts\utility::flag_init("ending_let_go");
}

#using_animtree("player");

player_anims() {
  level.scr_animtree["player_rig"] = #animtree;
  level.scr_model["player_rig"] = "viewhands_player_gs_flood";
  level.scr_anim["player_rig"]["flood_water_death"][0] = % flood_sweptaway_player;
  level.scr_anim["player_rig"]["infil"] = % flood_infil_player;
  level.scr_anim["player_rig"]["mlrs_kill1_start"] = % flood_mlrs_kill1_player_start;
  maps\_anim::addnotetrack_customfunction("player_rig", "start_qte", maps\flood_streets::mlrs_start_qte, "mlrs_kill1_start");
  level.scr_anim["player_rig"]["mlrs_kill1_end"] = % flood_mlrs_kill1_player_kill;
  level.scr_anim["player_rig"]["m880_kill1_fail"] = % flood_mlrs_kill1_player_fail;
  level.scr_anim["player_rig"]["dam_break"] = % flood_dam_break_player;
  maps\_anim::addnotetrack_customfunction("player_rig", "opfor_m880_escape", ::opfor_m880_escape_spawn);
  maps\_anim::addnotetrack_customfunction("player_rig", "play_cone_anims", ::play_cone_anims);
  maps\_anim::addnotetrack_customfunction("player_rig", "sfx_dam_break", maps\flood_audio::sfx_rocket_explosion_sound);
  maps\_anim::addnotetrack_customfunction("player_rig", "start_street_water", ::dam_break_street_water);
  maps\_anim::addnotetrack_customfunction("player_rig", "start_church_destruction", ::start_church_destruction);
  level.scr_animtree["swept_path_rig"] = #animtree;
  level.scr_anim["swept_path_rig"]["flood_sweptaway_player_path"] = % flood_sweptaway_player_path;
  level.scr_model["swept_path_rig"] = "viewhands_player_gs_flood";
  maps\_anim::addnotetrack_customfunction("swept_path_rig", "swept_fall_dunk", maps\flood_fx::swept_fall_dunk);
  maps\_anim::addnotetrack_customfunction("swept_path_rig", "swept_coming_out_01", maps\flood_fx::swept_coming_out_01);
  maps\_anim::addnotetrack_customfunction("swept_path_rig", "quick_dunk", maps\flood_fx::quick_dunk);
  maps\_anim::addnotetrack_customfunction("swept_path_rig", "trucks_hit", maps\flood_util::play_rumble_light);
  maps\_anim::addnotetrack_customfunction("swept_path_rig", "trucks_hit2", maps\flood_util::play_rumble_light);
  maps\_anim::addnotetrack_customfunction("swept_path_rig", "car_hit", maps\flood_util::play_rumble_light);
  maps\_anim::addnotetrack_customfunction("swept_path_rig", "truck_hit_bridge", maps\flood_util::play_rumble_light);
  maps\_anim::addnotetrack_customfunction("swept_path_rig", "swept_plunge_01", maps\flood_fx::swept_plunge_01);
  maps\_anim::addnotetrack_customfunction("swept_path_rig", "swept_emerge_02", maps\flood_fx::swept_emerge_02);
  maps\_anim::addnotetrack_customfunction("swept_path_rig", "swept_plunge_02", maps\flood_fx::swept_plunge_02);
  maps\_anim::addnotetrack_customfunction("swept_path_rig", "swept_emerge_03", maps\flood_fx::swept_emerge_03);
  maps\_anim::addnotetrack_customfunction("swept_path_rig", "swept_plunge_2_5", maps\flood_fx::swept_plunge_2_5);
  maps\_anim::addnotetrack_customfunction("swept_path_rig", "swept_blur", maps\flood_fx::swept_blur);
  level.scr_anim["player_rig"]["flood_sweptaway"] = % flood_sweptaway_player;
  level.scr_anim["player_rig"]["flood_sweptaway_L"] = % flood_sweptaway_player_l;
  level.scr_anim["player_rig"]["flood_sweptaway_R"] = % flood_sweptaway_player_r;
  level.scr_anim["player_rig"]["sweptaway_end_b"] = % flood_sweptaway_end_player;
  maps\_anim::addnotetrack_customfunction("player_rig", "rumble_antenna", maps\flood_swept::antenna_rumble);
  maps\_anim::addnotetrack_customfunction("player_rig", "rumble", maps\flood_swept::truck_rumble);
  maps\_anim::addnotetrack_customfunction("player_rig", "swept_plunge_03", maps\flood_fx::swept_plunge_03);
  maps\_anim::addnotetrack_customfunction("player_rig", "hand_grab", maps\flood_util::play_rumble_light);
  maps\_anim::addnotetrack_customfunction("player_rig", "pole_hit", maps\flood_swept::play_rumble_pole_hit);
  maps\_anim::addnotetrack_customfunction("player_rig", "sfx_end_sounds", maps\flood_audio::sfx_flood_end_notetrack);
  level.scr_anim["player_rig"]["stealth_knife_pullout"] = % viewmodel_flood_knife_rh_pullout;
  level.scr_anim["player_rig"]["stealth_kill_02"] = % flood_stealthkill_02_player;
  level.scr_anim["player_rig"]["mall_roofcollapse_player01"] = % flood_roofcollapse_player_01;
  level.scr_anim["player_rig"]["stealth_traverse"] = % flood_stealthkill_02_player_traverse;
  maps\_anim::addnotetrack_customfunction("player_rig", "fx_stealthkill_02_blood_01", maps\flood_fx::fx_stealthkill_02_blood_01);
  maps\_anim::addnotetrack_customfunction("player_rig", "fx_stealthkill_02_blood_01", maps\flood_util::play_rumble_light);
  maps\_anim::addnotetrack_customfunction("player_rig", "second_stab", maps\flood_util::play_rumble_light);
  level.scr_anim["player_rig"]["skybridge_flinch"] = % flood_skybridge_skybridgewalk_player;
  maps\_anim::addnotetrack_customfunction("player_rig", "lookingdown", ::skybridge_ally_cross);
  level thread ending_player_anims();
}

ending_player_anims() {
  maps\_anim::addnotetrack_customfunction("player_rig", "start_ally_vignette", ::ending_pt1_allies_sequence_start, "outro_pt1_breach");
  common_scripts\utility::flag_wait("flood_end_tr_loaded");
  level.scr_anim["player_rig"]["outro_pt1_breach"] = % flood_outro_pt1_breach_player;
  level.scr_anim["player_rig"]["outro_pt1_melee_player"] = % flood_outro_pt1_melee_player;
  level.scr_anim["player_rig"]["outro_pt1_melee_win"] = % flood_outro_pt1_melee_win_player;
  level.scr_anim["player_rig"]["outro_pt1_melee_fail"] = % flood_outro_pt1_melee_fail_player;
  level.scr_anim["player_rig"]["outro_pt1_garcia_punch"] = % flood_outro_pt1_garcia_punch_player;
  level.scr_anim["player_rig"]["outro_pt1_garcia_punch_player_additive"] = % flood_outro_pt1_garcia_punch_player_additive;
  level.scr_anim["player_rig"]["outro_pt1_garcia_kill_pt1"] = % flood_outro_pt1_garcia_kill_pt1_player;
  level.scr_anim["player_rig"]["outro_pt1_garcia_kill_pt2"] = % flood_outro_pt1_garcia_kill_pt2_player;
  level.scr_anim["player_rig"]["outro_pt1_crash"] = % flood_outro_pt1_crash_player;
  maps\_anim::addnotetrack_customfunction("player_rig", "start_interior", ::ending_pt1_scene_start, "outro_pt1_melee_player");
  maps\_anim::addnotetrack_customfunction("player_rig", "hit_small", maps\flood_ending::ending_player_take_damage, "outro_pt1_melee_player");
  maps\_anim::addnotetrack_customfunction("player_rig", "nose_break", maps\flood_ending::ending_player_enemy_broken_nose, "outro_pt1_melee_player");
  maps\_anim::addnotetrack_customfunction("player_rig", "start_kill_opfor01", ::ending_qte_0_start, "outro_pt1_melee_player");
  maps\_anim::addnotetrack_customfunction("player_rig", "sfx_heli_jump", maps\flood_audio::sfx_heli_jump_script);
  maps\_anim::addnotetrack_customfunction("player_rig", "hit_big", maps\flood_ending::ending_player_failed_qte_0, "outro_pt1_melee_fail");
  maps\_anim::addnotetrack_customfunction("player_rig", "sfx_slomo", maps\flood_audio::sfx_slomo_script);
  maps\_anim::addnotetrack_customfunction("player_rig", "slowmo_start", maps\flood_ending::ending_player_slowmo_start, "outro_pt1_garcia_punch");
  maps\_anim::addnotetrack_customfunction("player_rig", "hit_big", maps\flood_ending::ending_player_broken_nose, "outro_pt1_garcia_punch");
  maps\_anim::addnotetrack_customfunction("player_rig", "hit_small", maps\flood_ending::ending_player_take_damage, "outro_pt1_garcia_punch");
  maps\_anim::addnotetrack_customfunction("player_rig", "slowmo_end", maps\flood_ending::ending_player_slowmo_end, "outro_pt1_garcia_punch");
  maps\_anim::addnotetrack_customfunction("player_rig", "player_can_fire", ::ending_harmless_shots_logic, "outro_pt1_garcia_punch");
  maps\_anim::addnotetrack_customfunction("player_rig", "fade_to_black", maps\flood_ending::ending_player_fade, "outro_pt1_crash");
  maps\_anim::addnotetrack_customfunction("player_rig", "sfx_plane_crash", maps\flood_audio::sfx_plane_crash_script, "outro_pt1_crash");
  maps\_anim::addnotetrack_customfunction("player_rig", "sfx_ally_grab", maps\flood_audio::sfx_ally_grab_script);
  maps\_anim::addnotetrack_customfunction("player_rig", "sfx_gun_grab", maps\flood_audio::sfx_gun_grab_script);
  maps\_anim::addnotetrack_customfunction("player_rig", "sfx_alarms", maps\flood_audio::sfx_alarms_script);
  maps\_anim::addnotetrack_customfunction("player_rig", "sfx_stop_alarms", maps\flood_audio::sfx_stop_alarms_script);
  maps\_anim::addnotetrack_customfunction("player_rig", "land_dust", maps\flood_fx::ending_fx_land_dust);
  maps\_anim::addnotetrack_customfunction("player_rig", "screen_shock", maps\flood_fx::screen_shock);
  maps\_anim::addnotetrack_customfunction("player_rig", "fiery_smoke", maps\flood_fx::ending_fx_fiery_smoke);
  maps\_anim::addnotetrack_customfunction("player_rig", "ending_dof_01", maps\flood_fx::ending_dof_01);
  maps\_anim::addnotetrack_customfunction("player_rig", "ending_dof_02", maps\flood_fx::ending_dof_02);
  maps\_anim::addnotetrack_customfunction("player_rig", "ending_dof_03", maps\flood_fx::ending_dof_03);
  maps\_anim::addnotetrack_customfunction("player_rig", "ending_dof_07", maps\flood_fx::ending_dof_07);
  maps\_anim::addnotetrack_customfunction("player_rig", "ending_dof_08", maps\flood_fx::ending_dof_08);
  maps\_anim::addnotetrack_customfunction("player_rig", "blood_wall", maps\flood_fx::ending_blood_wall);
  level.scr_anim["player_rig"]["outro_pt2_start"] = % flood_outro_pt2_start_player;
  level.scr_anim["player_rig"]["outro_pt2_start_fail"] = % flood_outro_pt2_start_player_fail;
  level.scr_anim["player_rig"]["outro_pt2_save_vargas"] = % flood_outro_pt2_save_vargas_player;
  level.scr_anim["player_rig"]["outro_pt2_save_vargas_loop"][0] = % flood_outro_pt2_save_vargas_loop_player;
  level.scr_anim["player_rig"]["outro_pt2_save_vargas_loop_additive"] = % flood_outro_pt2_save_vargas_loop_player_add;
  level.scr_anim["player_rig"]["outro_pt2_save_vargas_loop_additive_parent"] = % flood_outro_pt2_save_vargas_loop_parent;
  level.scr_anim["player_rig"]["outro_pt2_save_vargas_win_01"] = % flood_outro_pt2_save_vargas_win_01_player;
  level.scr_anim["player_rig"]["outro_pt2_save_vargas_win_02"] = % flood_outro_pt2_save_vargas_win_02_player;
  level.scr_anim["player_rig"]["outro_pt2_save_vargas_fail_01"] = % flood_outro_pt2_save_vargas_fail_01_player;
  level.scr_anim["player_rig"]["outro_pt2_save_vargas_fail_02"] = % flood_outro_pt2_save_vargas_fail_02_player;
  level.scr_anim["player_rig"]["outro_pt2_vargas_death"] = % flood_outro_pt2_vargas_death_player;
  level.scr_anim["player_rig"]["outro_pt2_vargas_death_end"] = % flood_outro_pt2_vargas_death_end_player;
  level.scr_anim["player_rig"]["outro_pt2_vargas_death_end_fail"] = % flood_outro_pt2_vargas_death_end_fail_player;
  maps\_anim::addnotetrack_customfunction("player_rig", "dof_01", maps\flood_fx::dof_outro_pt2, "outro_pt2_vargas_death");
  maps\_anim::addnotetrack_customfunction("player_rig", "player_grab_vargas", maps\flood_ending::ending_player_qte_reach_logic, "outro_pt2_save_vargas");
  maps\_anim::addnotetrack_customfunction("player_rig", "sfx_wake_up", maps\flood_audio::sfx_wake_up_script);
  maps\_anim::addnotetrack_customfunction("player_rig", "sfx_save", maps\flood_audio::sfx_save_script);
  maps\_anim::addnotetrack_customfunction("player_rig", "let_go", maps\flood_ending::ending_player_let_go_interaction);
}

#using_animtree("generic_human");

generic_human() {
  maps\_patrol_anims::main();
  maps\_patrol_anims_gundown::main();
  maps\_patrol_anims_creepwalk::main();
  maps\_hand_signals::inithandsignals();
  level.scr_anim["generic"]["active_patrolwalk_gundown"] = % active_patrolwalk_gundown;
  level thread infil_generic_human();
  level.scr_anim["mlrs_kill1_opfor"]["mlrs_kill1_start"] = % flood_mlrs_kill1_opfor_start;
  level.scr_anim["mlrs_kill1_opfor"]["mlrs_kill1_end"] = % flood_mlrs_kill1_opfor_kill;
  level.scr_anim["mlrs_kill1_end_player_legs"]["mlrs_kill1_end"] = % flood_mlrs_kill1_playerlegs_kill;
  level.scr_anim["mlrs_kill1_opfor"]["m880_kill1_fail"] = % flood_mlrs_kill1_opfor_fail;
  level.scr_anim["ally_0"]["dam_break"] = % flood_dam_break_ally_03;
  level.scr_anim["ally_1"]["dam_break"] = % flood_dam_break_ally_01;
  level.scr_anim["ally_2"]["dam_break"] = % flood_dam_break_ally_02;
  level.scr_anim["dam_break_player_legs"]["dam_break"] = % flood_dam_break_player_legs;
  level.scr_anim["dam_break_opfor_m880"]["opfor_m880_escape"] = % flood_dam_break_opfor_m880;
  level.scr_anim["ally_0"]["ally_hold_01"] = % flood_ally_hold_signal_ally_01;
  level.scr_anim["convoy_checkpoint_opfor01"]["convoy_checkpoint"] = % flood_convoy_checkpoint_opfor01;
  level.scr_anim["convoy_checkpoint_opfor02"]["convoy_checkpoint"] = % flood_convoy_checkpoint_opfor02;
  level.scr_anim["convoy_checkpoint_opfor03"]["convoy_checkpoint"] = % flood_convoy_checkpoint_opfor03;
  level.scr_anim["convoy_checkpoint_opfor04"]["convoy_checkpoint"] = % flood_convoy_checkpoint_opfor04;
  level.scr_anim["launcher_callout_ally01"]["launcher_callout_ally01"] = % flood_launcher_callout_ally01;
  level.scr_anim["launcher_callout_ally02"]["launcher_callout_ally02"] = % flood_launcher_callout_ally02;
  level.scr_anim["launcher_callout_ally03"]["launcher_callout_ally03"] = % flood_launcher_callout_ally03;
  level.scr_anim["generic"]["ch_pragueb_7_5_crosscourt_aimantle_a"] = % ch_pragueb_7_5_crosscourt_aimantle_a;
  level.scr_anim["ally_0"]["warehouse_stairs_start"] = % flood_warehouse_stairs_start_ally_01;
  level.scr_anim["ally_1"]["warehouse_stairs_start"] = % flood_warehouse_stairs_start_ally_02;
  level.scr_anim["ally_2"]["warehouse_stairs_start"] = % flood_warehouse_stairs_start_ally_03;
  level.scr_anim["ally_0"]["warehouse_stairs_loop"][0] = % flood_warehouse_stairs_loop_ally_01;
  level.scr_anim["ally_1"]["warehouse_stairs_loop"][0] = % flood_warehouse_stairs_loop_ally_02;
  level.scr_anim["ally_2"]["warehouse_stairs_loop"][0] = % flood_warehouse_stairs_loop_ally_03;
  level.scr_anim["ally_0"]["warehouse_stairs_end"] = % flood_warehouse_stairs_end_ally_01;
  level.scr_anim["ally_1"]["warehouse_stairs_end"] = % flood_warehouse_stairs_end_ally_02;
  level.scr_anim["ally_2"]["warehouse_stairs_end"] = % flood_warehouse_stairs_end_ally_03;
  maps\_anim::addnotetrack_customfunction("ally_0", "event_quaker_big", maps\flood_mall::event_quaker_big);
  level.scr_anim["generic"]["mall_breach_enemy_1"] = % breach_chair_hide_reaction_v1;
  level.scr_anim["breacher2"]["mall_breach_enemy_2"] = % breach_react_push_guy1;
  level.scr_anim["breacher3"]["mall_breach_enemy_2"] = % breach_react_push_guy2;
  level.scr_anim["ally_0"]["flood_warehouse_breach"] = % flood_warehouse_breach_ally1;
  maps\_anim::addnotetrack_customfunction("ally_0", "door_open", maps\flood_flooding::open_loading_dock_doors, "flood_warehouse_breach");
  level.scr_anim["ally_2"]["flood_mall_roof_door_walkup"] = % flood_entering_mall_rooftop_ally2_walkup;
  level.scr_anim["ally_0"]["flood_mall_roof_door"] = % flood_entering_mall_rooftop_ally1;
  level.scr_anim["ally_2"]["flood_mall_roof_door"] = % flood_entering_mall_rooftop_ally2;
  level.scr_anim["ally_1"]["flood_mall_roof_door"] = % flood_entering_mall_rooftop_ally3;
  level.scr_anim["ally_1"]["flood_mall_roof_door_loop"][0] = % flood_entering_mall_rooftop_ally3_loop1;
  level.scr_anim["ally_0"]["flood_mall_roof_door_loop"][0] = % flood_entering_mall_rooftop_ally1_loop1;
  level.scr_anim["ally_2"]["flood_mall_roof_door_loop"][0] = % flood_entering_mall_rooftop_ally2_loop1;
  level.scr_anim["ally_1"]["flood_mall_roof_door_open_loop"][0] = % flood_entering_mall_rooftop_ally3_loop2;
  level.scr_anim["ally_1"]["flood_mall_roof_door_outdoor"] = % flood_entering_mall_rooftop_ally3_outdoor;
  level.scr_anim["ally_0"]["flood_mall_roof_fall"] = % flood_mall_roofcollapse_fall_ally01;
  level.scr_anim["ally_1"]["flood_mall_roof_fall"] = % flood_mall_roofcollapse_fall_ally02;
  level.scr_anim["ally_2"]["flood_mall_roof_fall"] = % flood_mall_roofcollapse_fall_ally03;
  level.scr_anim["swept_opfor_floater"]["sweptaway"] = % flood_sweptaway_opfor_floating;
  level.scr_anim["swept_opfor_tree"]["sweptaway"] = % flood_sweptaway_opfor_tree;
  level.scr_anim["ally_0"]["sweptaway_end_b"] = % flood_sweptaway_end_ally1;
  level.scr_anim["sweptaway_end_opfor_floater"]["sweptaway_end_b"] = % flood_sweptaway_end_opfor_floating;
  level.scr_anim["sweptaway_end_opfor_pinned"]["sweptaway_end_b"] = % flood_sweptaway_end_opfor_pinned;
  maps\_anim::addnotetrack_customfunction("ally_0", "rorke_hand_bubbles", maps\flood_fx::rorke_hand_bubbles);
  level thread stealth_generic_human();
  level.scr_anim["ally_0"]["skybridge_doorbreach"] = % flood_skybridge_doorbreach_ally;
  level.scr_anim["ally_0"]["skybridge_ally_approach"] = % flood_skybridge_skybridgewalk_ally_front_start;
  level.scr_anim["ally_0"]["skybridge_ally_loop"][0] = % flood_skybridge_skybridgewalk_ally_front_loop;
  level.scr_anim["ally_0"]["skybridge_cross_behind"] = % flood_skybridge_skybridgewalk_ally_back;
  level.scr_anim["ally_0"]["skybridge_cross_ahead"] = % flood_skybridge_skybridgewalk_ally_front;
  level.scr_anim["generic"]["hacking"][0] = % london_warehouse_computer_idle;
  level.scr_anim["opfor_0"]["hacking"][0] = % london_warehouse_computer_idle;
  level.scr_anim["opfor_1"]["hacking"][0] = % london_warehouse_computer_idle;
  level.scr_anim["generic"]["stand_idle"][0] = % readystand_idle_twitch_1;
  level.scr_anim["ally_0"]["ally_hold_01"] = % flood_ally_hold_signal_ally_01;
  level.scr_anim["ally_0"]["rooftops_traversal_01"] = % flood_rooftop_traversal_ally01;
  level.scr_anim["ally_0"]["rooftops_traversal_03"] = % flood_rooftop_traversal_ally03;
  level.scr_anim["opfor_0"]["rooftops_heli_ropeladder_loop"][0] = % flood_rooftops_01_opfor01_loop;
  level.scr_anim["opfor_1"]["rooftops_heli_ropeladder_loop"][0] = % flood_rooftops_01_opfor02_loop;
  level.scr_goaltime["opfor_0"]["rooftops_heli_ropeladder"] = 0.4;
  level.scr_goaltime["opfor_1"]["rooftops_heli_ropeladder"] = 0.4;
  level.scr_anim["opfor_0"]["rooftops_heli_ropeladder"] = % flood_rooftops_01_opfor01;
  level.scr_anim["opfor_1"]["rooftops_heli_ropeladder"] = % flood_rooftops_01_opfor02;
  level thread rooftop1_generic_human();
  level.scr_anim["ally_0"]["rooftops_idle_loop_0"][0] = % flood_rooftop_traversal_ally01_loop1;
  level.scr_anim["ally_0"]["rooftops_idle_loop_1"][0] = % flood_rooftop_traversal_ally01_loop2;
  level.scr_anim["ally_0"]["rooftops_wall_kick"] = % flood_rooftop_traversal_ally01_walktowall;
  level.scr_anim["ally_0"]["rooftops_water_long_jump"] = % flood_rooftop_traversal_ally02;
  level.scr_anim["ally_0"]["rooftops_water_stumble_and_jump"] = % flood_rooftop_traversal_ally03_secondjump;
  level.scr_anim["ally_0"]["rooftops_water_approach_stumble"] = % flood_rooftop_traversal_ally02_merge;
  level.scr_anim["ally_0"]["rooftops_water_approach_loop"][0] = % flood_rooftop_traversal_ally02_loop;
  level.scr_anim["ally_0"]["rooftops_water_approach_jump"] = % flood_rooftop_traversal_ally02_secondjump;
  level.scr_anim["opfor_0"]["rooftops_water_reveal"] = % flood_rooftops_02_encounter_opfor_01;
  level thread rooftop2_generic_human();
  level.scr_anim["opfor_1"]["rooftops_water_reveal_flare"][0] = % flood_rooftop_waving_flares_opfor_loop;
  level.scr_goaltime["ally_0"]["debris_bridge_vign2_loc0"] = 0.5;
  level.scr_goaltime["ally_0"]["debris_bridge_vign2_loc1"] = 0.5;
  level.scr_goaltime["ally_0"]["debris_bridge_vign2_loc2"] = 0.5;
  level.scr_goaltime["ally_1"]["debris_bridge_vign2_loc0"] = 0.5;
  level.scr_goaltime["ally_1"]["debris_bridge_vign2_loc1"] = 0.5;
  level.scr_goaltime["ally_1"]["debris_bridge_vign2_loc2"] = 0.5;
  level.scr_goaltime["ally_2"]["debris_bridge_vign2_loc0"] = 0.5;
  level.scr_goaltime["ally_2"]["debris_bridge_vign2_loc1"] = 0.5;
  level.scr_goaltime["ally_2"]["debris_bridge_vign2_loc2"] = 0.5;
  level.scr_anim["ally_0"]["debris_bridge_vign2_loc0"] = % flood_debrisbridge_vign2_ally1;
  level.scr_anim["ally_0"]["debris_bridge_vign2_loc1"] = % flood_debrisbridge_vign2_ally2;
  level.scr_anim["ally_0"]["debris_bridge_vign2_loc2"] = % flood_debrisbridge_vign2_ally3;
  level.scr_anim["ally_1"]["debris_bridge_vign2_loc0"] = % flood_debrisbridge_vign2_ally1;
  level.scr_anim["ally_1"]["debris_bridge_vign2_loc1"] = % flood_debrisbridge_vign2_ally2;
  level.scr_anim["ally_1"]["debris_bridge_vign2_loc2"] = % flood_debrisbridge_vign2_ally3;
  level.scr_anim["ally_2"]["debris_bridge_vign2_loc0"] = % flood_debrisbridge_vign2_ally1;
  level.scr_anim["ally_2"]["debris_bridge_vign2_loc1"] = % flood_debrisbridge_vign2_ally2;
  level.scr_anim["ally_2"]["debris_bridge_vign2_loc2"] = % flood_debrisbridge_vign2_ally3;
  level.scr_goaltime["ally_0"]["debrisbridge_loop0"] = 0.5;
  level.scr_goaltime["ally_0"]["debrisbridge_loop1"] = 0.5;
  level.scr_goaltime["ally_0"]["debrisbridge_loop2"] = 0.5;
  level.scr_goaltime["ally_1"]["debrisbridge_loop0"] = 0.5;
  level.scr_goaltime["ally_1"]["debrisbridge_loop1"] = 0.5;
  level.scr_goaltime["ally_1"]["debrisbridge_loop2"] = 0.5;
  level.scr_goaltime["ally_2"]["debrisbridge_loop0"] = 0.5;
  level.scr_goaltime["ally_2"]["debrisbridge_loop1"] = 0.5;
  level.scr_goaltime["ally_2"]["debrisbridge_loop2"] = 0.5;
  level.scr_anim["ally_0"]["debrisbridge_loop0"][0] = % flood_debrisbridge_loop_3_ally1;
  level.scr_anim["ally_0"]["debrisbridge_loop1"][0] = % flood_debrisbridge_loop_3_ally2;
  level.scr_anim["ally_0"]["debrisbridge_loop2"][0] = % flood_debrisbridge_loop_3_ally3;
  level.scr_anim["ally_1"]["debrisbridge_loop0"][0] = % flood_debrisbridge_loop_3_ally1;
  level.scr_anim["ally_1"]["debrisbridge_loop1"][0] = % flood_debrisbridge_loop_3_ally2;
  level.scr_anim["ally_1"]["debrisbridge_loop2"][0] = % flood_debrisbridge_loop_3_ally3;
  level.scr_anim["ally_2"]["debrisbridge_loop0"][0] = % flood_debrisbridge_loop_3_ally1;
  level.scr_anim["ally_2"]["debrisbridge_loop1"][0] = % flood_debrisbridge_loop_3_ally2;
  level.scr_anim["ally_2"]["debrisbridge_loop2"][0] = % flood_debrisbridge_loop_3_ally3;
  level.scr_anim["garage_jump_01_opfor"]["garage_jump_01"] = % flood_garage_jump_opfor_01;
  level.scr_anim["opfor_1"]["flood_mall_roof_opfor"][0] = % flood_mall_rooftop_opfor1_loop;
  level.scr_anim["opfor_2"]["flood_mall_roof_opfor"][0] = % flood_mall_rooftop_opfor2_loop;
  level.scr_anim["opfor_1"]["flood_mall_roof_opfor_shot"][0] = % blackice_baker_hold2;
  level.scr_anim["opfor_2"]["flood_mall_roof_opfor_shot"] = % flood_mall_rooftop_opfor2_shot;
  level.scr_anim["ally_0"]["flood_warehouse_mantle"] = % flood_warehouse_traversal_ally2;
  level.scr_anim["ally_1"]["flood_warehouse_mantle"] = % flood_warehouse_traversal_ally1;
  level.scr_anim["ally_2"]["flood_warehouse_mantle"] = % traverse_stepup_52;
  level.scr_anim["generic"]["run_react_stumble_non_loop"] = % run_react_stumble_non_loop;
  level.scr_anim["generic"]["readystand_idle_twitch_1"][0] = % readystand_idle_twitch_1;
  level.scr_anim["generic"]["run_trans_2_readystand_1"] = % run_trans_2_readystand_1;
  level.scr_anim["ally_1"]["flood_cornerwaving_loop"][0] = % readystand_idle_twitch_1;
  level.scr_anim["ally_0"]["flood_cornerwaving_loop"][0] = % flood_cornerwaving_ally06_loop;
  level.scr_anim["ally_0"]["flood_cornerwaving_run"] = % flood_cornerwaving_ally06_run;
  level.scr_anim["ally_0"]["flood_cornerwaving_enter"] = % flood_cornerwaving_ally06_run_enter;
  level.scr_anim["generic"]["ending_door_kick"] = % doorkick_2_cqbrun;
  level thread ending_generic_human();
}

infil_generic_human() {
  common_scripts\utility::flag_wait("flood_intro_tr_loaded");
  level.scr_anim["generic"]["rpg_reload"] = % rpg_stand_reload;
  level.scr_anim["generic"]["heli_idle1"][0] = % little_bird_alert_idle_guy3;
  level.scr_anim["generic"]["heli_idle2"][0] = % little_bird_alert_idle_guy2;
  level.scr_anim["ally_0"]["anim_reach"] = % flood_cornerwaving_ally06_loop;
  level.scr_anim["ally_1"]["anim_reach"] = % flood_cornerwaving_ally06_loop;
  level.scr_anim["ally_2"]["anim_reach"] = % flood_cornerwaving_ally06_loop;
  level.scr_anim["ally_0"]["infil_loop"][0] = % flood_infil_ally1_loop;
  level.scr_anim["ally_0"]["infil_vo"] = % flood_infil_ally1_vo;
  level.scr_anim["ally_1"]["infil_jumpout"] = % flood_infil_ally2_jumpout;
  level.scr_anim["ally_0"]["infil"] = % flood_infil_heli_01_ally_01;
  level.scr_anim["heli_01_copilot"]["infil"] = % flood_infil_heli_01_copilot;
  level.scr_anim["heli_02_ally_01"]["infil"] = % flood_infil_heli_02_ally_01;
  level.scr_anim["heli_02_ally_02"]["infil"] = % flood_infil_heli_02_ally_02;
  level.scr_anim["heli_02_ally_03"]["infil"] = % flood_infil_heli_02_ally_03;
  level.scr_anim["heli_02_ally_04"]["infil"] = % flood_infil_heli_02_ally_04;
  level.scr_anim["heli_02_gunner_01"]["infil"] = % flood_infil_heli_02_gunner_01;
  level.scr_anim["heli_02_gunner_02"]["infil"] = % flood_infil_heli_02_gunner_02;
  level.scr_anim["heli_02_pilot"]["infil"] = % flood_infil_heli_02_pilot;
  level.scr_anim["heli_02_copilot"]["infil"] = % flood_infil_heli_02_copilot;
  level.scr_anim["heli_02_ally_01"]["infil_dismount"] = % flood_infil_heli_02_ally_01_dismount;
  level.scr_anim["heli_02_ally_02"]["infil_dismount"] = % flood_infil_heli_02_ally_02_dismount;
  level.scr_anim["heli_02_ally_03"]["infil_dismount"] = % flood_infil_heli_02_ally_01_dismount;
  level.scr_anim["heli_02_ally_04"]["infil_dismount"] = % flood_infil_heli_02_ally_02_dismount;
  maps\_anim::addnotetrack_customfunction("ally_0", "unlink", maps\flood_infil::unlink_ally_from_heli);
  level.scr_anim["ally_0"]["price_exit_chopper_wave"] = % flood_move_forward_and_wave;
  level.scr_anim["generic"]["run_root"] = % combatrun_forward;
  level.scr_anim["generic"]["run_duck"] = % run_react_duck;
  level.scr_anim["generic"]["run_flinch"] = % run_react_flinch;
  level.scr_anim["generic"]["run_stumble"] = % run_react_stumble;
  level.scr_anim["generic"]["run_stumble_non_loop"] = % run_react_stumble_non_loop;
  level.scr_goaltime["generic"]["garage_waving"] = 0.6;
  level.scr_anim["generic"]["garage_waving"][0] = % flood_garage_waving_ally_01;
}

stealth_generic_human() {
  common_scripts\utility::flag_wait("flood_mid_tr_loaded");
  level.scr_anim["ally_0"]["stealth_busted_idle"][0] = % unarmed_cowercrouch_idle_duck;
  level.scr_anim["ally_0"]["stealth_kill_01"] = % flood_stealthkill_01_ally1;
  level.scr_anim["stealth_enemy_flash"]["stealth_kill_01"] = % flood_stealthkill_01_opfor1;
  level.scr_anim["stealth_enemy_debris"]["stealth_kill_01"] = % flood_stealthkill_01_opfor2;
  level.scr_anim["stealth_enemy_3"]["stealth_kill_01"] = % flood_stealthkill_01_opfor3;
  level.scr_anim["ally_0"]["stealth_kill_idle"][0] = % flood_stealthkill_01_loop_02_ally1;
  maps\_anim::addnotetrack_customfunction("ally_0", "go_under_water", maps\flood_roof_stealth::enemy_start_vo, "stealth_kill_01");
  maps\_anim::addnotetrack_customfunction("ally_0", "attach_script_hatchet", maps\flood_roof_stealth::give_hatchet, "stealth_kill_01");
  maps\_anim::addnotetrack_customfunction("ally_0", "play_face_partial_1", maps\flood_roof_stealth::stealth_kill_01_facial, "stealth_kill_01");
  maps\_anim::addnotetrack_customfunction("ally_0", "rorke_face_start", maps\flood_roof_stealth::stealth_kill_01_facial_start, "stealth_kill_01");
  maps\_anim::addnotetrack_customfunction("ally_0", "holdup", maps\flood_roof_stealth::ally0_instruction_vo_holdup);
  maps\_anim::addnotetrack_customfunction("ally_0", "go_under_water2", maps\flood_roof_stealth::ally0_instruction_vo);
  maps\_anim::addnotetrack_customfunction("ally_0", "allie1_tussbubbs", maps\flood_fx::allie1_tussbubbs);
  maps\_anim::addnotetrack_customfunction("stealth_enemy_3", "flashlight_underwater", maps\flood_roof_stealth::off_flashlight);
  maps\_anim::addnotetrack_customfunction("stealth_enemy_3", "dead", maps\flood_roof_stealth::enemy_dead);
  maps\_anim::addnotetrack_customfunction("stealth_enemy_3", "opfor3_tussbubbs", maps\flood_fx::opfor3_tussbubbs);
  maps\_anim::addnotetrack_customfunction("stealth_enemy_3", "opfor3_facial_1", maps\flood_roof_stealth::stealth_kill_01_opfor_facial);
  level.scr_anim["stealth_enemy_flash"]["stealth_kill_02"] = % flood_stealthkill_02_opfor1;
  level.scr_anim["stealth_enemy_debris"]["stealth_kill_02"] = % flood_stealthkill_02_opfor2;
  level.scr_anim["ally_0"]["stealth_kill_02"] = % flood_stealthkill_02_ally1;
  level.scr_anim["stealth_enemy_flash"]["stealth_kill_02_idle"][0] = % flood_stealthkill_02_opfor1_loop;
  level.scr_anim["stealth_enemy_flash"]["stealth_kill_02_into_idle2"] = % flood_stealthkill_02_opfor1_into_loop;
  level.scr_anim["stealth_enemy_flash"]["stealth_kill_02_idle2"][0] = % flood_stealthkill_02_opfor1_loop2;
  level.scr_anim["stealth_enemy_debris"]["stealth_kill_02_idle"][0] = % flood_stealthkill_02_opfor2_loop;
  maps\_anim::addnotetrack_customfunction("ally_0", "start_ally1_bubbles", maps\flood_fx::start_ally1_bubbles);
  maps\_anim::addnotetrack_customfunction("ally_0", "start_ally1_submerge_bubbles", maps\flood_fx::start_ally1_submerge_bubbles);
  maps\_anim::addnotetrack_customfunction("ally_0", "kill_ally1_submerge_bubbles", maps\flood_fx::kill_ally1_submerge_bubbles);
  maps\_anim::addnotetrack_customfunction("ally_0", "fx_ally1_kill_upper_bubbles", maps\flood_fx::fx_ally1_kill_upper_bubbles);
  maps\_anim::addnotetrack_customfunction("ally_0", "fx_ally1_kill_tussle_bubbles_02", maps\flood_fx::fx_ally1_kill_tussle_bubbles_02);
  maps\_anim::addnotetrack_customfunction("stealth_enemy_3", "fx_opfor3_tussle_bubbles", maps\flood_fx::fx_opfor3_tussle_bubbles);
  maps\_anim::addnotetrack_customfunction("stealth_enemy_3", "fx_opfor3_pushdown_bubbles", maps\flood_fx::fx_opfor3_pushdown_bubbles);
  maps\_anim::addnotetrack_customfunction("stealth_enemy_flash", "fx_stealthkill_02_blood_02", maps\flood_fx::fx_stealthkill_02_blood_02);
  maps\_anim::addnotetrack_customfunction("stealth_enemy_debris", "fx_stealthkill_02_opfor2_blood_01", maps\flood_fx::fx_stealthkill_02_opfor2_blood_01);
  maps\_anim::addnotetrack_customfunction("stealth_enemy_debris", "fx_stealthkill_02_opfor2_blood_02", maps\flood_fx::fx_stealthkill_02_opfor2_blood_02);
  maps\_anim::addnotetrack_customfunction("ally_0", "hatchet_face_1", maps\flood_fx::fx_hatchet_face_1);
  maps\_anim::addnotetrack_customfunction("ally_0", "detach_hatchet", maps\flood_roof_stealth::detach_hatchet);
}

rooftop1_generic_human() {
  common_scripts\utility::flag_wait("flood_mid_tr_loaded");
  maps\_anim::addnotetrack_customfunction("opfor_0", "killme", ::rooftops_heli_ropeladder_cleanup, "rooftops_heli_ropeladder");
}

rooftop2_generic_human() {
  common_scripts\utility::flag_wait("flood_mid_tr_loaded");
  maps\_anim::addnotetrack_customfunction("opfor_0", "fire", maps\flood_rooftops::rooftops_water_reveal_shoot, "rooftops_water_reveal");
  maps\_anim::addnotetrack_customfunction("ally_0", "gun_shot_01", maps\flood_rooftops::debrisbridge_combat_crossing, "debris_bridge_vign2_loc0");
  maps\_anim::addnotetrack_customfunction("ally_0", "gun_shot_02", maps\flood_rooftops::debrisbridge_combat_crossing, "debris_bridge_vign2_loc0");
  maps\_anim::addnotetrack_customfunction("ally_0", "gun_shot_03", maps\flood_rooftops::debrisbridge_combat_crossing, "debris_bridge_vign2_loc0");
  maps\_anim::addnotetrack_customfunction("ally_1", "gun_shot_01", maps\flood_rooftops::debrisbridge_combat_crossing, "debris_bridge_vign2_loc0");
  maps\_anim::addnotetrack_customfunction("ally_1", "gun_shot_02", maps\flood_rooftops::debrisbridge_combat_crossing, "debris_bridge_vign2_loc0");
  maps\_anim::addnotetrack_customfunction("ally_1", "gun_shot_03", maps\flood_rooftops::debrisbridge_combat_crossing, "debris_bridge_vign2_loc0");
  maps\_anim::addnotetrack_customfunction("ally_2", "gun_shot_01", maps\flood_rooftops::debrisbridge_combat_crossing, "debris_bridge_vign2_loc0");
  maps\_anim::addnotetrack_customfunction("ally_2", "gun_shot_02", maps\flood_rooftops::debrisbridge_combat_crossing, "debris_bridge_vign2_loc0");
  maps\_anim::addnotetrack_customfunction("ally_2", "gun_shot_03", maps\flood_rooftops::debrisbridge_combat_crossing, "debris_bridge_vign2_loc0");
  maps\_anim::addnotetrack_customfunction("generic", "kick", ::notetrack_open_gate, "ending_door_kick");
}

ending_generic_human() {
  common_scripts\utility::flag_wait("flood_end_tr_loaded");
  level.scr_anim["ally_0"]["outro_pt1_breach"] = % flood_outro_pt1_breach_price;
  level.scr_anim["ally_0"]["outro_pt1_breach_nearby"] = % flood_outro_pt1_breach_price_corner_stand;
  level.scr_anim["ally_1"]["outro_pt1_breach"] = % flood_outro_pt1_breach_vargas;
  level.scr_anim["generic"]["outro_pt1_garcia_punch"] = % flood_outro_pt1_garcia_punch_garcia;
  level.scr_anim["generic"]["outro_pt1_garcia_kill_pt1"] = % flood_outro_pt1_garcia_kill_pt1_garcia;
  level.scr_anim["generic"]["outro_pt1_garcia_kill_pt2"] = % flood_outro_pt1_garcia_kill_pt2_garcia;
  level.scr_anim["generic"]["outro_pt1_crash"] = % flood_outro_pt1_crash_garcia;
  level.scr_anim["ally_0"]["outro_pt1_start"] = % flood_outro_pt1_start_price;
  level.scr_anim["ally_0"]["outro_pt1_start_loop_price"][0] = % flood_outro_pt1_start_loop_price;
  level.scr_anim["ally_0"]["outro_pt1_garcia_punch"] = % flood_outro_pt1_garcia_punch_price;
  level.scr_anim["ally_0"]["outro_pt1_garcia_kill_pt1"] = % flood_outro_pt1_garcia_kill_pt1_price;
  level.scr_anim["ally_0"]["outro_pt1_garcia_kill_pt2"] = % flood_outro_pt1_garcia_kill_pt2_price;
  level.scr_anim["ally_0"]["outro_pt1_crash"] = % flood_outro_pt1_crash_price;
  level.scr_anim["ally_1"]["outro_pt1_start"] = % flood_outro_pt1_start_vargas;
  level.scr_anim["ally_1"]["outro_pt1_start_loop_vargas"][0] = % flood_outro_pt1_start_loop_vargas;
  level.scr_anim["ally_1"]["outro_pt1_melee_vargas"] = % flood_outro_pt1_melee_vargas;
  level.scr_anim["ally_1"]["outro_pt1_pilot_kill"] = % flood_outro_pt1_pilot_kill_vargas;
  level.scr_anim["ally_1"]["outro_pt1_crash"] = % flood_outro_pt1_crash_vargas;
  level.scr_anim["opfor_0"]["outro_pt1_breach"] = % flood_outro_pt1_start_opfor01;
  level.scr_anim["opfor_0"]["outro_pt1_start"] = % flood_outro_pt1_start_opfor01;
  level.scr_anim["opfor_0"]["outro_pt1_start_loop_vargas"][0] = % flood_outro_pt1_start_loop_opfor01;
  level.scr_anim["opfor_0"]["outro_pt1_melee_player"] = % flood_outro_pt1_melee_opfor01;
  level.scr_anim["opfor_0"]["outro_pt1_melee_win"] = % flood_outro_pt1_melee_win_opfor01;
  level.scr_anim["opfor_0"]["outro_pt1_melee_fail"] = % flood_outro_pt1_melee_fail_opfor01;
  level.scr_anim["opfor_0"]["outro_pt1_garcia_punch"] = % flood_outro_pt1_garcia_punch_opfor01;
  maps\_anim::addnotetrack_customfunction("opfor_0", "opfor_01_headblood", maps\flood_fx::ending_fx_opfor01_headblood);
  level.scr_anim["opfor_1"]["outro_pt1_breach"] = % flood_outro_pt1_start_opfor02;
  level.scr_anim["opfor_1"]["outro_pt1_start"] = % flood_outro_pt1_start_opfor02;
  level.scr_anim["opfor_1"]["outro_pt1_start_loop_price"][0] = % flood_outro_pt1_start_loop_opfor02;
  level.scr_anim["opfor_1"]["outro_pt1_garcia_punch"] = % flood_outro_pt1_garcia_punch_opfor02;
  level.scr_anim["opfor_1"]["outro_pt1_garcia_kill_pt1"] = % flood_outro_pt1_garcia_kill_pt1_opfor02;
  level.scr_anim["opfor_1"]["outro_pt1_garcia_kill_pt2"] = % flood_outro_pt1_garcia_kill_pt2_opfor02;
  level.scr_anim["opfor_1"]["outro_pt1_crash"] = % flood_outro_pt1_crash_opfor02;
  level.scr_anim["opfor_2"]["outro_pt1_breach"] = % flood_outro_pt1_start_opfor03;
  level.scr_anim["opfor_2"]["outro_pt1_melee_vargas"] = % flood_outro_pt1_melee_opfor03;
  level.scr_anim["opfor_2"]["outro_pt1_pilot_kill"] = % flood_outro_pt1_pilot_kill_opfor03;
  maps\_anim::addnotetrack_customfunction("opfor_2", "opfor03_fire_pilot", maps\flood_fx::ending_fx_opfor03_fire_pilot);
  maps\_anim::addnotetrack_customfunction("opfor_2", "ending_dof_04", maps\flood_fx::ending_dof_04);
  maps\_anim::addnotetrack_customfunction("opfor_2", "ending_dof_05", maps\flood_fx::ending_dof_05);
  maps\_anim::addnotetrack_customfunction("opfor_2", "ending_dof_06", maps\flood_fx::ending_dof_06);
  level.scr_anim["opfor_3"]["outro_pt1_pilot_kill"] = % flood_outro_pt1_pilot_kill_pilot;
  level.scr_anim["opfor_3"]["outro_pt1_garcia_kill_pt1"] = % flood_outro_pt1_garcia_kill_pt1_pilot;
  level.scr_anim["opfor_3"]["outro_pt1_garcia_kill_pt2"] = % flood_outro_pt1_garcia_kill_pt2_pilot;
  level.scr_anim["opfor_3"]["outro_pt1_crash"] = % flood_outro_pt1_crash_pilot;
  maps\_anim::addnotetrack_customfunction("opfor_3", "pilot_shot", ::outro_pt1_blood, "outro_pt1_pilot_kill");
  level.scr_anim["generic"]["outro_pt2_start"] = % flood_outro_pt2_start_garcia;
  level.scr_anim["ally_0"]["outro_pt2_start"] = % flood_outro_pt2_start_vargas;
  level.scr_anim["ally_0"]["outro_pt2_save_vargas"] = % flood_outro_pt2_save_vargas_vargas;
  level.scr_anim["ally_0"]["outro_pt2_save_vargas_win_01"] = % flood_outro_pt2_save_vargas_win_01_vargas;
  level.scr_anim["ally_0"]["outro_pt2_save_vargas_win_02"] = % flood_outro_pt2_save_vargas_win_02_vargas;
  level.scr_anim["ally_0"]["outro_pt2_save_vargas_fail_01"] = % flood_outro_pt2_save_vargas_fail_01_vargas;
  level.scr_anim["ally_0"]["outro_pt2_save_vargas_fail_02"] = % flood_outro_pt2_save_vargas_fail_02_vargas;
  level.scr_anim["ally_0"]["outro_pt2_save_vargas_loop"][0] = % flood_outro_pt2_save_vargas_loop_vargas;
  level.scr_anim["ally_0"]["outro_pt2_vargas_death"] = % flood_outro_pt2_vargas_death_vargas;
  level.scr_anim["ally_0"]["outro_pt2_vargas_death_end"] = % flood_outro_pt2_vargas_death_end_vargas;
  level.scr_anim["ally_0"]["outro_pt2_vargas_death_end_fail"] = % flood_outro_pt2_vargas_death_end_fail_vargas;
  maps\_anim::addnotetrack_customfunction("ally_0", "face_01", ::outro_pt2_face_01, "outro_pt2_start");
  maps\_anim::addnotetrack_customfunction("ally_0", "face_02", ::outro_pt2_face_02, "outro_pt2_save_vargas");
  maps\_anim::addnotetrack_customfunction("ally_0", "face_03", ::outro_pt2_face_03, "outro_pt2_save_vargas_loop");
  maps\_anim::addnotetrack_customfunction("ally_0", "face_04", ::outro_pt2_face_04, "outro_pt2_vargas_death");
  maps\_anim::addnotetrack_customfunction("ally_0", "face_05", ::outro_pt2_face_05, "outro_pt2_vargas_death_end");
  level.scr_anim["ally_1"]["outro_pt2_start"] = % flood_outro_pt2_start_merrick;
  level.scr_anim["ally_1"]["outro_pt2_save_vargas_loop"][0] = % flood_outro_pt2_save_vargas_loop_merrick;
  level.scr_anim["ally_1"]["outro_pt2_vargas_death"] = % flood_outro_pt2_vargas_death_merrick;
  level.scr_anim["ally_1"]["outro_pt2_vargas_death_end"] = % flood_outro_pt2_vargas_death_end_merrick;
  level.scr_anim["outro_player_legs"]["outro_pt2_start"] = % flood_outro_pt2_start_player_legs;
  level.scr_anim["outro_player_legs"]["outro_pt2_start_fail"] = % flood_outro_pt2_start_legs_fail;
  level.scr_anim["outro_player_legs"]["outro_pt2_save_vargas"] = % flood_outro_pt2_save_vargas_legs;
  level.scr_anim["outro_player_legs"]["outro_pt2_save_vargas_loop"][0] = % flood_outro_pt2_save_vargas_loop_legs;
  level.scr_anim["outro_player_legs"]["outro_pt2_vargas_death"] = % flood_outro_pt2_vargas_death_legs;
  level.scr_anim["outro_player_legs"]["outro_pt2_vargas_death_end"] = % flood_outro_pt2_vargas_death_end_legs;
  level.scr_anim["outro_player_legs"]["outro_pt2_save_vargas_win_01"] = % flood_outro_pt2_save_vargas_win_01_legs;
  level.scr_anim["outro_player_legs"]["outro_pt2_save_vargas_fail_01"] = % flood_outro_pt2_save_vargas_fail_01_legs;
  level.scr_anim["outro_player_legs"]["outro_pt2_save_vargas_win_02"] = % flood_outro_pt2_save_vargas_win_02_legs;
  level.scr_anim["outro_player_legs"]["outro_pt2_save_vargas_fail_02"] = % flood_outro_pt2_save_vargas_fail_02_legs;
}

dialogue() {
  level.scr_sound["ally_0"]["flood_pri_keepupwithteam"] = "flood_pri_keepupwithteam";
  level.scr_sound["ally_1"]["flood_vrg_cmoneliaskeepup"] = "flood_vrg_cmoneliaskeepup";
  level.scr_sound["ally_1"]["flood_mrk_makearunfor"] = "flood_mrk_makearunfor";
  level.scr_sound["ally_0"]["flood_pri_werepinneddownby"] = "flood_pri_werepinneddownby";
  level.scr_face["ally_0"]["flood_pri_werepinneddownby"] = % flood_tank_battle_rorke_pinned;
  level.scr_sound["ally_0"]["flood_pri_helixonewevegot"] = "flood_pri_helixonewevegot";
  level.scr_face["ally_0"]["flood_pri_helixonewevegot"] = % flood_pri_helixonewevegot;
  level.scr_sound["ally_0"]["flood_pri_getreadyforthe"] = "flood_pri_getreadyforthe";
  level.scr_face["ally_0"]["flood_pri_getreadyforthe"] = % flood_pri_getreadyforthe;
  level.scr_sound["ally_0"]["flood_vrg_eliastakeoutthe"] = "flood_vrg_eliastakeoutthe";
  level.scr_sound["ally_0"]["flood_vrg_thedriversstillalive"] = "flood_vrg_thedriversstillalive";
  level.scr_sound["ally_0"]["flood_vrg_eliasstopthemissile"] = "flood_vrg_eliasstopthemissile";
  level.scr_sound["ally_0"]["flood_vrg_theresaladderon"] = "flood_vrg_theresaladderon";
  level.scr_sound["ally_0"]["flood_bkr_gotyoucovered"] = "flood_bkr_gotyoucovered";
  level.scr_sound["ally_0"]["flood_bkr_takelauncherout"] = "flood_bkr_takelauncherout";
  level.scr_sound["ally_0"]["flood_bkr_stopsequence"] = "flood_bkr_stopsequence";
  level.scr_sound["ally_0"]["flood_bkr_getoffstreet"] = "flood_bkr_getoffstreet";
  level.scr_sound["ally_2"]["flood_kgn_letsmoveit"] = "flood_kgn_letsmoveit";
  level.scr_sound["ally_1"]["flood_diz_floodwaters"] = "flood_diz_floodwaters";
  level.scr_sound["ally_0"]["flood_bkr_moverook"] = "flood_bkr_moverook";
  level.scr_sound["ally_0"]["flood_bkr_keepmoving"] = "flood_bkr_keepmoving";
  level.scr_sound["ally_0"]["flood_bkr_pickuppace"] = "flood_bkr_pickuppace";
  level.scr_sound["ally_1"]["flood_bkr_downthealley"] = "flood_bkr_downthealley";
  level.scr_sound["ally_2"]["flood_kgn_onourtail"] = "flood_kgn_onourtail";
  level.scr_sound["ally_1"]["flood_kgn_weretrapped"] = "flood_kgn_weretrapped";
  level.scr_sound["ally_0"]["flood_diz_inhere"] = "flood_diz_inhere";
  level.scr_sound["ally_0"]["flood_bkr_notsafehere"] = "flood_bkr_notsafehere";
  level.scr_sound["ally_1"]["flood_diz_dontstoprunning"] = "flood_diz_dontstoprunning";
  level.scr_sound["ally_1"]["flood_kgn_keepmoving2"] = "flood_kgn_keepmoving2";
  level.scr_sound["ally_0"]["flood_bkr_upthestairs"] = "flood_bkr_upthestairs";
  level.scr_sound["ally_0"]["flood_bkr_catchyourbreath"] = "flood_bkr_catchyourbreath";
  level.scr_sound["ally_0"]["flood_vrg_commentarylieutenant"] = "flood_vrg_commentarylieutenant";
  level.scr_sound["ally_1"]["flood_mrk_ithinkitsbad"] = "flood_mrk_ithinkitsbad";
  level.scr_sound["ally_0"]["flood_vrg_runofthemill"] = "flood_vrg_runofthemill";
  level.scr_sound["ally_1"]["flood_mrk_sir"] = "flood_mrk_sir";
  level.scr_sound["ally_0"]["flood_vrg_thatwouldbesitrep"] = "flood_vrg_thatwouldbesitrep";
  level.scr_sound["ally_1"]["flood_mrk_sitrepconfirmedsir"] = "flood_mrk_sitrepconfirmedsir";
  level.scr_sound["ally_1"]["flood_mrk_whatkindofman"] = "flood_mrk_whatkindofman";
  level.scr_sound["ally_0"]["flood_vrg_amanwhowont"] = "flood_vrg_amanwhowont";
  level.scr_sound["ally_2"]["flood_bkr_thisplaceisntgonna"] = "flood_bkr_thisplaceisntgonna";
  level.scr_sound["ally_0"]["flood_vrg_itshotoutthere"] = "flood_vrg_itshotoutthere";
  level.scr_sound["ally_0"]["flood_vrg_anyobjectionstofinishing"] = "flood_vrg_anyobjectionstofinishing";
  level.scr_sound["ally_0"]["flood_vrg_allrightletsgo"] = "flood_vrg_allrightletsgo";
  level.scr_face["ally_0"]["flood_vrg_allrightletsgo"] = % flood_entering_mall_rooftop_ally1_sob;
  level.scr_sound["opfor_1"]["flood_vs2_weloseanyoneto"] = "flood_vs2_weloseanyoneto";
  level.scr_sound["opfor_1"]["flood_vs4_everyonesaccountedforsir"] = "flood_vs4_everyonesaccountedforsir";
  level.scr_sound["opfor_1"]["flood_vs3_thereportsaidwe"] = "flood_vs3_thereportsaidwe";
  level.scr_sound["opfor_1"]["flood_vs3_sincethiswasa"] = "flood_vs3_sincethiswasa";
  level.scr_sound["opfor_1"]["flood_vs2_startpreppingthelanding"] = "flood_vs2_startpreppingthelanding";
  level.scr_sound["opfor_1"]["flood_vs2_getthesuppliestogether"] = "flood_vs2_getthesuppliestogether";
  level.scr_sound["opfor_1"]["flood_vs2_keepaneyeout"] = "flood_vs2_keepaneyeout";
  level.scr_sound["opfor_1"]["flood_vs3_makesureyouhave"] = "flood_vs3_makesureyouhave";
  level.scr_sound["opfor_1"]["flood_vs1_didyouhearthat"] = "flood_vs1_didyouhearthat";
  level.scr_sound["opfor_1"]["flood_vs4_icanbarelyhear"] = "flood_vs4_icanbarelyhear";
  level.scr_sound["opfor_1"]["flood_vs5_thewaterjammedup"] = "flood_vs5_thewaterjammedup";
  level.scr_sound["opfor_1"]["flood_vs1_icantbelievethey"] = "flood_vs1_icantbelievethey";
  level.scr_sound["opfor_1"]["flood_vs2_everyonecheckyour"] = "flood_vs2_everyonecheckyour";
  level.scr_sound["opfor_1"]["flood_vs2_jimenezramosgarciacheck"] = "flood_vs2_jimenezramosgarciacheck";
  level.scr_sound["opfor_1"]["flood_vs1_onit"] = "flood_vs1_onit";
  level.scr_sound["opfor_1"]["flood_vs2_howmuchlongerfor"] = "flood_vs2_howmuchlongerfor";
  level.scr_sound["opfor_1"]["flood_vs3_5minutes"] = "flood_vs3_5minutes";
  level.scr_sound["opfor_1"]["flood_vs2_wemightnotbe"] = "flood_vs2_wemightnotbe";
  level.scr_sound["opfor_1"]["flood_vs2_makesuretheyunderstand"] = "flood_vs2_makesuretheyunderstand";
  level.scr_sound["opfor_1"]["flood_vs2_rodriguezineedyou"] = "flood_vs2_rodriguezineedyou";
  level.scr_sound["opfor_1"]["flood_vs4_imabitbusy"] = "flood_vs4_imabitbusy";
  level.scr_sound["opfor_1"]["flood_vs2_hurryupandpull"] = "flood_vs2_hurryupandpull";
  level.scr_sound["opfor_1"]["flood_vs2_sanchezandcastillomake"] = "flood_vs2_sanchezandcastillomake";
  level.scr_sound["opfor_1"]["flood_vs2_idontwantanything"] = "flood_vs2_idontwantanything";
  level.scr_sound["opfor_1"]["flood_vs6_yessir"] = "flood_vs6_yessir";
  level.scr_sound["opfor_1"]["flood_vs2_anyupdateonthat"] = "flood_vs2_anyupdateonthat";
  level.scr_sound["opfor_1"]["flood_vs3_theoperatorsare"] = "flood_vs3_theoperatorsare";
  level.scr_sound["opfor_1"]["flood_vs2_anyoneseeingasafe"] = "flood_vs2_anyoneseeingasafe";
  level.scr_sound["opfor_1"]["flood_vs2_howrethingslookingon"] = "flood_vs2_howrethingslookingon";
  level.scr_sound["opfor_1"]["flood_vs6_itfeelslikethe"] = "flood_vs6_itfeelslikethe";
  level.scr_sound["opfor_1"]["flood_vs4_holdon"] = "flood_vs4_holdon";
  level.scr_sound["opfor_2"]["flood_vs5_holdingon"] = "flood_vs5_holdingon";
  level.scr_sound["opfor_2"]["flood_vs5_pullmeup"] = "flood_vs5_pullmeup";
  level.scr_sound["opfor_1"]["flood_vs4_getanyleverage"] = "flood_vs4_getanyleverage";
  level.scr_sound["opfor_2"]["flood_vs5_imslipping"] = "flood_vs5_imslipping";
  level.scr_sound["generic"]["flood_vz2_americans"] = "flood_vz2_americans";
  level.scr_sound["generic"]["flood_vz2_notalone"] = "flood_vz2_notalone";
  level.scr_sound["ally_0"]["flood_diz_gunsready"] = "flood_diz_gunsready";
  level.scr_sound["ally_0"]["flood_diz_tangosoutthere"] = "flood_diz_tangosoutthere";
  level.scr_sound["ally_1"]["flood_diz_staylowandquiet"] = "flood_diz_staylowandquiet";
  level.scr_sound["ally_1"]["flood_diz_outthererook"] = "flood_bkr_outthererook";
  level.scr_sound["ally_1"]["flood_diz_bespotted"] = "flood_bkr_bespotted";
  level.scr_radio["flood_bkr_hotonrooksmark"] = "flood_bkr_hotonrooksmark";
  level.scr_radio["flood_bkr_thejump"] = "flood_bkr_thejump";
  level.scr_radio["flood_bkr_cantwait"] = "flood_bkr_cantwait";
  level.scr_sound["ally_0"]["flood_bkr_weaponsfree"] = "flood_bkr_weaponsfree";
  level.scr_sound["ally_0"]["flood_bkr_spottedus"] = "flood_bkr_spottedus";
  level.scr_sound["ally_1"]["flood_kgn_keepmoving"] = "flood_kgn_keepmoving";
  level.scr_sound["ally_2"]["flood_diz_gettingshotat"] = "flood_diz_gettingshotat";
  level.scr_sound["ally_0"]["flood_diz_engagingtargets"] = "flood_diz_engagingtargets";
  level.scr_sound["ally_2"]["flood_mrk_halftheroofsgone"] = "flood_mrk_halftheroofsgone";
  level.scr_sound["ally_0"]["flood_pri_wellihopeyou"] = "flood_pri_wellihopeyou";
  level thread stealth_dialog();
  level.scr_sound["ally_0"]["flood_pri_garciasgottobe"] = "flood_pri_garciasgottobe";
  level.scr_sound["ally_2"]["flood_mrk_whatarearethese"] = "flood_mrk_whatarearethese";
  level.scr_sound["ally_2"]["flood_pri_welldealwiththat"] = "flood_pri_welldealwiththat";
  level.scr_sound["ally_1"]["flood_diz_stabelground"] = "flood_diz_stabelground";
  level.scr_sound["ally_1"]["flood_diz_onlywaytogo"] = "flood_diz_onlywaytogo";
  level.scr_sound["ally_1"]["flood_diz_barelyholding"] = "flood_diz_barelyholding";
  level.scr_sound["ally_1"]["flood_diz_keepmoving2"] = "flood_diz_keepmoving2";
  level.scr_sound["ally_1"]["flood_diz_rightforus"] = "flood_diz_rightforus";
  level.scr_sound["ally_1"]["flood_diz_hurry"] = "flood_diz_hurry";
  level.scr_sound["generic"]["flood_vs10_hearme"] = "flood_vs10_hearme";
  level.scr_sound["generic"]["flood_vz11_downloaddata"] = "flood_vz11_downloaddata";
  level.scr_sound["generic"]["flood_vs10_priorityalert"] = "flood_vs10_priorityalert";
  level.scr_sound["generic"]["flood_vs11_rewire"] = "flood_vs11_rewire";
  level.scr_sound["generic"]["flood_vs10_setupfine"] = "flood_vs10_setupfine";
  level.scr_sound["generic"]["flood_vz11_goargue"] = "flood_vz11_goargue";
  level.scr_sound["generic"]["flood_vz11_enemies"] = "flood_vz11_enemies";
  level.scr_sound["generic"]["flood_vz12_getguns"] = "flood_vz12_getguns";
  level.scr_sound["ally_1"]["flood_diz_hostileahead"] = "flood_diz_hostileahead";
  level.scr_sound["ally_1"]["flood_diz_holdup"] = "flood_diz_holdup";
  level.scr_sound["ally_1"]["flood_diz_gohotmark"] = "flood_diz_gohotmark";
  level.scr_sound["ally_1"]["flood_diz_upthestairs2"] = "flood_diz_upthestairs2";
  level.scr_sound["ally_1"]["flood_diz_getsomebearings"] = "flood_diz_getsomebearings";
  level.scr_sound["ally_0"]["flood_diz_gethimselfkilled"] = "flood_diz_gethimselfkilled";
  level.scr_radio["flood_pri_thisghostzerooneif"] = "flood_pri_thisghostzerooneif";
  level.scr_radio["flood_pri_vargaswereunderheavy"] = "flood_pri_vargaswereunderheavy";
  level.scr_face["ally_0"]["flood_vrg_thisisghostzerotwo"] = % flood_rooftop_traversal_ally01_thisisghostzerotwo;
  level.scr_face["ally_0"]["flood_vrg_ineedtoknow"] = % flood_rooftop_traversal_ally01_ineedtoknow;
  level.scr_face["ally_0"]["flood_diz_gethimselfkilled"] = % flood_rooftop_traversal_ally01_gethimselfkilled;
  level.scr_sound["ally_0"]["flood_diz_dropdown"] = "flood_diz_dropdown";
  level.scr_sound["ally_0"]["flood_diz_jumpthegap"] = "flood_diz_jumpthegap";
  level.scr_sound["ally_0"]["flood_diz_keepmoving3"] = "flood_diz_keepmoving3";
  level.scr_sound["ally_0"]["flood_vrg_downhereelias"] = "flood_vrg_downhereelias";
  level.scr_sound["ally_0"]["flood_diz_getdownhere"] = "flood_diz_getdownhere";
  level.scr_sound["ally_0"]["flood_diz_getdownhereneedsupport"] = "flood_diz_getdownhereneedsupport";
  level.scr_sound["ally_0"]["flood_diz_cominginfromabove"] = "flood_diz_cominginfromabove";
  level.scr_sound["ally_0"]["flood_diz_infromabove"] = "flood_diz_infromabove";
  level.scr_sound["ally_0"]["flood_diz_usethewater"] = "flood_diz_usethewater";
  level.scr_sound["ally_0"]["flood_diz_flankingus"] = "flood_diz_flankingus";
  level.scr_sound["ally_2"]["flood_kgn_barelystaying"] = "flood_kgn_barelystaying";
  level.scr_sound["ally_0"]["flood_bkr_dropdownhere"] = "flood_bkr_dropdownhere";
  level.scr_sound["ally_2"]["flood_kgn_needsupport"] = "flood_kgn_needsupport";
  level.scr_sound["ally_1"]["flood_diz_watchyourfooting"] = "flood_diz_watchyourfooting";
  level.scr_sound["ally_2"]["flood_diz_getacrossnow"] = "flood_diz_getacrossnow";
  level.scr_sound["ally_0"]["flood_pri_eliasgetthedoor"] = "flood_pri_eliasgetthedoor";
  level.scr_face["ally_0"]["flood_pri_eliasgetthedoor"] = % flood_pri_eliasgetthedoor;
  level.scr_sound["ally_0"]["flood_pri_openthedoorwell"] = "flood_pri_openthedoorwell";
  level.scr_face["ally_0"]["flood_pri_openthedoorwell"] = % flood_pri_openthedoorwell;
  level.scr_sound["ally_0"]["flood_pri_weregonnalosegarcia"] = "flood_pri_weregonnalosegarcia";
  level.scr_face["ally_0"]["flood_pri_weregonnalosegarcia"] = % flood_pri_weregonnalosegarcia;
  level.scr_sound["ally_0"]["outro_pt2_start_face"] = "flood_face_null";
  level.scr_sound["ally_0"]["outro_pt2_save_vargas_face"] = "flood_face_null";
  level.scr_sound["ally_0"]["outro_pt2_save_vargas_loop_face"] = "flood_face_null";
  level.scr_sound["ally_0"]["outro_pt2_vargas_death_face"] = "flood_face_null";
  level.scr_sound["ally_0"]["outro_pt2_vargas_death_end_face"] = "flood_face_null";
  level.scr_face["ally_0"]["outro_pt2_start_face"] = % flood_outro_pt2_start_vargas_face;
  level.scr_face["ally_0"]["outro_pt2_save_vargas_face"] = % flood_outro_pt2_save_vargas_vargas_face;
  level.scr_face["ally_0"]["outro_pt2_save_vargas_loop_face"] = % flood_outro_pt2_save_vargas_loop_vargas_face;
  level.scr_face["ally_0"]["outro_pt2_vargas_death_face"] = % flood_outro_pt2_vargas_death_vargas_face;
  level.scr_face["ally_0"]["outro_pt2_vargas_death_end_face"] = % flood_outro_pt2_vargas_death_end_vargas_face;
}

stealth_dialog() {
  level.scr_sound["ally_0"]["flood_vrg_walker"] = "flood_vrg_walker";
  level.scr_sound["ally_0"]["flood_vrg_holdon"] = "flood_vrg_holdon";
  level.scr_sound["ally_0"]["flood_vrg_eliasigotcha"] = "flood_vrg_eliasigotcha";
  level.scr_sound["ally_0"]["flood_vrg_itlookslikeits"] = "flood_vrg_itlookslikeits";
  level.scr_face["ally_0"]["flood_vrg_itlookslikeits"] = % flood_stealthkill_01_ally1_itlookslikeits;
  level.scr_sound["ally_0"]["flood_vrg_grabmyhandwalker"] = "flood_vrg_grabmyhandwalker";
  level.scr_sound["ally_0"]["flood_vrg_theyrecomingthisway"] = "flood_vrg_theyrecomingthisway";
  level.scr_face["ally_0"]["flood_vrg_theyrecomingthisway"] = % flood_stealthkill_01_ally1_theyrecoming;
  level.scr_radio["flood_vrg_folowmyleashit"] = "flood_vrg_folowmyleashit";
  level.scr_sound["stealth_enemy_flash"]["flood_vs8_duartecheckinthere"] = "flood_vs8_duartecheckinthere";
  level.scr_sound["stealth_enemy_3"]["flood_vs7_yessir"] = "flood_vs7_yessir";
  level.scr_sound["stealth_enemy_flash"]["flood_vs8_castilloyourewithme"] = "flood_vs8_castilloyourewithme";
  level.scr_sound["stealth_enemy_debris"]["flood_vs9_whatsthatupahead"] = "flood_vs9_whatsthatupahead";
  level.scr_sound["stealth_enemy_flash"]["flood_vs8_ithinkthatsanother"] = "flood_vs8_ithinkthatsanother";
  level.scr_sound["stealth_enemy_flash"]["flood_vs8_castillotryandclear"] = "flood_vs8_castillotryandclear";
  level.scr_sound["stealth_enemy_debris"]["flood_vs9_couldigetsome"] = "flood_vs9_couldigetsome";
  level.scr_sound["stealth_enemy_flash"]["flood_vs8_sure"] = "flood_vs8_sure";
  level.scr_sound["stealth_enemy_debris"]["flood_vs9_getthrough"] = "flood_vs9_getthrough";
  level.scr_sound["stealth_enemy_flash"]["flood_vs8_dontgiveup"] = "flood_vs8_dontgiveup";
  level.scr_sound["stealth_enemy_debris"]["flood_vs9_makingprogress"] = "flood_vs9_makingprogress";
  level.scr_sound["stealth_enemy_debris"]["flood_vs9_goodgrip"] = "flood_vs9_goodgrip";
  level.scr_sound["stealth_enemy_debris"]["flood_vs9_lightsteady"] = "flood_vs9_lightsteady";
  level.scr_sound["stealth_enemy_flash"]["flood_vs8_keepthelight"] = "flood_vs8_keepthelight";
  level.scr_sound["stealth_enemy_debris"]["flood_vs9_finejustkeep"] = "flood_vs9_finejustkeep";
  level.scr_sound["stealth_enemy_flash"]["flood_vs8_thinksomething"] = "flood_vs8_thinksomething";
  level.scr_sound["stealth_enemy_debris"]["flood_vs9_thelight"] = "flood_vs9_thelight";
  level.scr_sound["stealth_enemy_flash"]["flood_vs8_ohright"] = "flood_vs8_ohright";
  level.scr_sound["ally_0"]["flood_diz_theyseeyou"] = "flood_diz_theyseeyou";
  level.scr_sound["stealth_enemy_flash"]["flood_vz8_americanshere"] = "flood_vz8_americanshere";
  level.scr_sound["stealth_enemy_debris"]["flood_vz9_americanshere"] = "flood_vz9_americanshere";
  level.scr_sound["ally_0"]["flood_vrg_thiswillbeuseful"] = "flood_vrg_thiswillbeuseful";
  level.scr_face["ally_0"]["flood_vrg_thiswillbeuseful"] = % flood_stealthkill_01_ally1_thiswillbeuseful;
  level.scr_sound["ally_0"]["flood_vrg_holdup"] = "flood_vrg_holdup";
  level.scr_face["ally_0"]["flood_vrg_holdup"] = % flood_stealthkill_01_ally1_holdup;
  level.scr_radio["flood_vrg_holdup_2"] = "flood_vrg_holdup_2";
  level.scr_sound["ally_0"]["flood_diz_yougoleft"] = "flood_diz_yougoleft";
  level.scr_face["ally_0"]["flood_diz_yougoleft"] = % flood_stealthkill_01_ally1_twomoreupahead;
  level.scr_radio["flood_vrg_onlytwomoreup"] = "flood_vrg_onlytwomoreup";
  level.scr_radio["flood_vrg_welltakethemout"] = "flood_vrg_welltakethemout";
  level.scr_sound["ally_0"]["flood_diz_getbelow"] = "flood_diz_getbelow";
  level.scr_face["ally_0"]["flood_diz_getbelow"] = % flood_stealthkill_01_ally1_getbelow;
  level.scr_sound["ally_0"]["flood_diz_gounderwater"] = "flood_diz_gounderwater";
  level.scr_face["ally_0"]["flood_diz_gounderwater"] = % flood_stealthkill_01_ally1_gounder;
  level.scr_radio["flood_vrg_getbelowthewater"] = "flood_vrg_getbelowthewater";
  level.scr_radio["flood_vrg_gounderwaterandwell"] = "flood_vrg_gounderwaterandwell";
  level.scr_sound["ally_0"]["flood_diz_grabagun"] = "flood_diz_grabagun";
}

#using_animtree("script_model");

script_models() {
  level.scr_animtree["flood_stop_sign_01"] = #animtree;
  level.scr_anim["flood_stop_sign_01"]["street_stop_sign_01"] = % flood_streets_stop_sign;
  level.scr_model["flood_stop_sign_01"] = "flood_stop_sign";
  level.scr_animtree["lynx_smash"] = #animtree;
  level.scr_anim["lynx_smash"]["lynx_smash"] = % flood_tank_battle_lynx_smash_lynx;
  level.scr_model["lynx_smash"] = "flood_smashed_lynx";
  level.scr_animtree["lynx_smash_debris"] = #animtree;
  level.scr_anim["lynx_smash_debris"]["lynx_smash"] = % flood_tank_battle_lynx_smash_wall;
  level.scr_model["lynx_smash_debris"] = "flood_convoy_debris_lynx";
  level.scr_animtree["flood_tank_battle_barrier_01"] = #animtree;
  level.scr_anim["flood_tank_battle_barrier_01"]["tank_window"] = % flood_tank_battle_window_barrier_01;
  level.scr_model["flood_tank_battle_barrier_01"] = "flood_tank_battle_barrier_01";
  level.scr_animtree["flood_tank_battle_barrier_02"] = #animtree;
  level.scr_anim["flood_tank_battle_barrier_02"]["tank_window"] = % flood_tank_battle_window_barrier_02;
  level.scr_model["flood_tank_battle_barrier_02"] = "flood_tank_battle_barrier_02";
  level.scr_animtree["flood_tank_battle_window_frame"] = #animtree;
  level.scr_anim["flood_tank_battle_window_frame"]["tank_window"] = % flood_tank_battle_window_windowframe;
  level.scr_model["flood_tank_battle_window_frame"] = "flood_tank_battle_window_frame";
  level.scr_animtree["flood_tank_battle_tankdebris"] = #animtree;
  level.scr_anim["flood_tank_battle_tankdebris"]["tank_window"] = % flood_tank_battle_window_tankdebris;
  level.scr_model["flood_tank_battle_tankdebris"] = "flood_tank_battle_tankdebris";
  level.scr_animtree["convoy_debris_cone_01"] = #animtree;
  level.scr_anim["convoy_debris_cone_01"]["m880_crash_debris"] = % flood_convoy_crash_debris_cone_01;
  level.scr_model["convoy_debris_cone_01"] = "com_trafficcone01";
  level.scr_animtree["convoy_debris_cone_02"] = #animtree;
  level.scr_anim["convoy_debris_cone_02"]["m880_crash_debris"] = % flood_convoy_crash_debris_cone_02;
  level.scr_model["convoy_debris_cone_02"] = "com_trafficcone01";
  level.scr_animtree["convoy_debris_cone_03"] = #animtree;
  level.scr_anim["convoy_debris_cone_03"]["m880_crash_debris"] = % flood_convoy_crash_debris_cone_03;
  level.scr_model["convoy_debris_cone_03"] = "com_trafficcone01";
  level.scr_animtree["convoy_plastic_barricade_01"] = #animtree;
  level.scr_anim["convoy_plastic_barricade_01"]["m880_crash_debris"] = % flood_convoy_crash_debris_plastic_barricade_01;
  level.scr_model["convoy_plastic_barricade_01"] = "plastic_jersey_barrier_01";
  level.scr_animtree["convoy_plastic_barricade_02"] = #animtree;
  level.scr_anim["convoy_plastic_barricade_02"]["m880_crash_debris"] = % flood_convoy_crash_debris_plastic_barricade_02;
  level.scr_model["convoy_plastic_barricade_02"] = "plastic_jersey_barrier_01";
  level.scr_animtree["convoy_plastic_barricade_03"] = #animtree;
  level.scr_anim["convoy_plastic_barricade_03"]["m880_crash_debris"] = % flood_convoy_crash_debris_plastic_barricade_03;
  level.scr_model["convoy_plastic_barricade_03"] = "plastic_jersey_barrier_01";
  level.scr_animtree["convoy_plastic_barricade_04"] = #animtree;
  level.scr_anim["convoy_plastic_barricade_04"]["m880_crash_debris"] = % flood_convoy_crash_debris_plastic_barricade_04;
  level.scr_model["convoy_plastic_barricade_04"] = "plastic_jersey_barrier_01";
  level.scr_animtree["convoy_tall_barricade_01"] = #animtree;
  level.scr_anim["convoy_tall_barricade_01"]["m880_crash_debris"] = % flood_convoy_crash_debris_tall_barricade_01;
  level.scr_model["convoy_tall_barricade_01"] = "com_barrier_tall1";
  level.scr_animtree["convoy_tall_barricade_02"] = #animtree;
  level.scr_anim["convoy_tall_barricade_02"]["m880_crash_debris"] = % flood_convoy_crash_debris_tall_barricade_02;
  level.scr_model["convoy_tall_barricade_02"] = "com_barrier_tall1";
  level.scr_animtree["convoy_short_barricade_01"] = #animtree;
  level.scr_anim["convoy_short_barricade_01"]["m880_crash_debris"] = % flood_convoy_crash_debris_short_barricade_01;
  level.scr_model["convoy_short_barricade_01"] = "concrete_barrier_damaged_1";
  level.scr_animtree["convoy_debris_barrel_01"] = #animtree;
  level.scr_anim["convoy_debris_barrel_01"]["m880_crash_barrels"] = % flood_convoy_crash_debris_barrel_01;
  level.scr_model["convoy_debris_barrel_01"] = "com_barrel_green";
  level.scr_animtree["convoy_debris_barrel_02"] = #animtree;
  level.scr_anim["convoy_debris_barrel_02"]["m880_crash_barrels"] = % flood_convoy_crash_debris_barrel_02;
  level.scr_model["convoy_debris_barrel_02"] = "com_barrel_green";
  level.scr_animtree["convoy_debris_barrel_03"] = #animtree;
  level.scr_anim["convoy_debris_barrel_03"]["m880_crash_barrels"] = % flood_convoy_crash_debris_barrel_03;
  level.scr_model["convoy_debris_barrel_03"] = "com_barrel_green";
  level.scr_animtree["convoy_debris_barrel_04"] = #animtree;
  level.scr_anim["convoy_debris_barrel_04"]["m880_crash_barrels"] = % flood_convoy_crash_debris_barrel_04;
  level.scr_model["convoy_debris_barrel_04"] = "com_barrel_green";
  level.scr_animtree["convoy_debris_barrel_05"] = #animtree;
  level.scr_anim["convoy_debris_barrel_05"]["m880_crash_barrels"] = % flood_convoy_crash_debris_barrel_05;
  level.scr_model["convoy_debris_barrel_05"] = "com_barrel_green";
  level.scr_animtree["convoy_debris_barrel_06"] = #animtree;
  level.scr_anim["convoy_debris_barrel_06"]["m880_crash_barrels"] = % flood_convoy_crash_debris_barrel_06;
  level.scr_model["convoy_debris_barrel_06"] = "com_barrel_green";
  level.scr_animtree["convoy_debris_barrel_07"] = #animtree;
  level.scr_anim["convoy_debris_barrel_07"]["m880_crash_barrels"] = % flood_convoy_crash_debris_barrel_07;
  level.scr_model["convoy_debris_barrel_07"] = "com_barrel_green";
  level.scr_animtree["convoy_debris_lynx"] = #animtree;
  level.scr_anim["convoy_debris_lynx"]["m880_crash_debris"] = % flood_convoy_crash_debris_lynx;
  level.scr_model["convoy_debris_lynx"] = "flood_convoy_debris_lynx";
  level.scr_animtree["convoy_debris_m880_01"] = #animtree;
  level.scr_anim["convoy_debris_m880_01"]["m880_crash_debris"] = % flood_convoy_crash_debris_m880_01;
  level.scr_model["convoy_debris_m880_01"] = "flood_convoy_debris_m880_01";
  level.scr_animtree["convoy_debris_m880_02"] = #animtree;
  level.scr_anim["convoy_debris_m880_02"]["m880_crash_debris"] = % flood_convoy_crash_debris_m880_02;
  level.scr_model["convoy_debris_m880_02"] = "flood_convoy_debris_m880_02";
  level.scr_animtree["convoy_debris_m880_03"] = #animtree;
  level.scr_anim["convoy_debris_m880_03"]["m880_crash_debris"] = % flood_convoy_crash_debris_m880_03;
  level.scr_model["convoy_debris_m880_03"] = "flood_convoy_debris_m880_03";
  level.scr_animtree["m880_radiation_gate"] = #animtree;
  level.scr_anim["m880_radiation_gate"]["m880_crash_debris"] = % flood_convoy_crash_radiation_gate;
  level.scr_model["m880_radiation_gate"] = "flood_radiation_portal";
  level.scr_animtree["convoy_tall_barricade_01"] = #animtree;
  level.scr_anim["convoy_tall_barricade_01"]["m880_crash_loop"][0] = % flood_convoy_crash_debris_tall_barricade_loop_01;
  level.scr_model["convoy_tall_barricade_01"] = "com_barrier_tall1";
  level.scr_animtree["convoy_tall_barricade_02"] = #animtree;
  level.scr_anim["convoy_tall_barricade_02"]["m880_crash_loop"][0] = % flood_convoy_crash_debris_tall_barricade_loop_02;
  level.scr_model["convoy_tall_barricade_02"] = "com_barrier_tall1";
  level.scr_animtree["m880_radiation_gate"] = #animtree;
  level.scr_anim["m880_radiation_gate"]["m880_crash_loop"][0] = % flood_convoy_crash_radiation_gate_loop;
  level.scr_model["m880_radiation_gate"] = "flood_radiation_portal";
  level.scr_animtree["mlrs_kill1_knife"] = #animtree;
  level.scr_anim["mlrs_kill1_knife"]["mlrs_kill1_start"] = % flood_mlrs_kill1_knife_start;
  level.scr_model["mlrs_kill1_knife"] = "viewmodel_knife_iw6";
  level.scr_animtree["mlrs_kill1_gun"] = #animtree;
  level.scr_anim["mlrs_kill1_gun"]["mlrs_kill1_start"] = % flood_mlrs_kill1_gun_start;
  level.scr_model["mlrs_kill1_gun"] = "weapon_m9a1_iw6";
  level.scr_animtree["m880_radiation_gate"] = #animtree;
  level.scr_anim["m880_radiation_gate"]["mlrs_kill1_start"] = % flood_mlrs_kill1_radiation_gate_start;
  level.scr_model["m880_radiation_gate"] = "flood_radiation_portal";
  level.scr_animtree["mlrs_kill1_knife"] = #animtree;
  level.scr_anim["mlrs_kill1_knife"]["mlrs_kill1_end"] = % flood_mlrs_kill1_knife_end;
  level.scr_model["mlrs_kill1_knife"] = "viewmodel_knife_iw6";
  level.scr_animtree["mlrs_kill1_end_grenade"] = #animtree;
  level.scr_anim["mlrs_kill1_end_grenade"]["mlrs_kill1_end"] = % flood_mlrs_kill1_grenade;
  level.scr_model["mlrs_kill1_end_grenade"] = "viewmodel_m67";
  level.scr_animtree["m880_radiation_gate"] = #animtree;
  level.scr_anim["m880_radiation_gate"]["mlrs_kill1_end"] = % flood_mlrs_kill1_radiation_gate_kill;
  level.scr_model["m880_radiation_gate"] = "flood_radiation_portal";
  level.scr_animtree["mlrs_kill1_gun"] = #animtree;
  level.scr_anim["mlrs_kill1_gun"]["mlrs_kill1_end"] = % flood_mlrs_kill1_gun_end;
  level.scr_model["mlrs_kill1_gun"] = "weapon_m9a1_iw6";
  level.scr_animtree["mlrs_kill1_barricade_01"] = #animtree;
  level.scr_anim["mlrs_kill1_barricade_01"]["mlrs_kill1_barricades"] = % flood_mlrs_kill1_debris_gate_01;
  level.scr_model["mlrs_kill1_barricade_01"] = "ny_barrier_pedestrian_01";
  level.scr_animtree["mlrs_kill1_barricade_02"] = #animtree;
  level.scr_anim["mlrs_kill1_barricade_02"]["mlrs_kill1_barricades"] = % flood_mlrs_kill1_debris_gate_02;
  level.scr_model["mlrs_kill1_barricade_02"] = "ny_barrier_pedestrian_01";
  level.scr_animtree["mlrs_kill1_knife"] = #animtree;
  level.scr_anim["mlrs_kill1_knife"]["m880_kill1_fail"] = % flood_mlrs_kill1_knife_fail;
  level.scr_model["mlrs_kill1_knife"] = "viewmodel_knife_iw6";
  level.scr_animtree["mlrs_kill1_gun"] = #animtree;
  level.scr_anim["mlrs_kill1_gun"]["m880_kill1_fail"] = % flood_mlrs_kill1_gun_fail;
  level.scr_model["mlrs_kill1_gun"] = "weapon_m9a1_iw6";
  level.scr_animtree["dam_break_missile_01"] = #animtree;
  level.scr_anim["dam_break_missile_01"]["dam_break_missile_01"] = % flood_dam_break_missile_01;
  level.scr_model["dam_break_missile_01"] = "projectile_slamraam_missile";
  level.scr_animtree["dam_break_missile_02"] = #animtree;
  level.scr_anim["dam_break_missile_02"]["dam_break_missile_02"] = % flood_dam_break_missile_02;
  level.scr_model["dam_break_missile_02"] = "projectile_slamraam_missile";
  level.scr_animtree["dam_break_missile_03"] = #animtree;
  level.scr_anim["dam_break_missile_03"]["dam_break_missile_03"] = % flood_dam_break_missile_03;
  level.scr_model["dam_break_missile_03"] = "projectile_slamraam_missile";
  level.scr_animtree["dam_break_missile_04"] = #animtree;
  level.scr_anim["dam_break_missile_04"]["dam_break_missile_04"] = % flood_dam_break_missile_04;
  level.scr_model["dam_break_missile_04"] = "projectile_slamraam_missile";
  level.scr_animtree["dam_break_dam"] = #animtree;
  level.scr_anim["dam_break_dam"]["dam_break_dam_destruction"] = % flood_dam_break_dam;
  level.scr_model["dam_break_dam"] = "flood_dam_break_dam";
  level.scr_animtree["dam_break_street_debris"] = #animtree;
  level.scr_anim["dam_break_street_debris"]["dam_break_street_water"] = % flood_dam_break_street_debris_01;
  level.scr_model["dam_break_street_debris"] = "flood_dam_street_street_debris";
  level.scr_animtree["dam_break_helmet"] = #animtree;
  level.scr_anim["dam_break_helmet"]["dam_break"] = % flood_dam_break_helmet;
  level.scr_model["dam_break_helmet"] = "flood_dam_break_helmet";
  level.scr_animtree["dam_break_cone_01"] = #animtree;
  level.scr_anim["dam_break_cone_01"]["dam_break_cones"] = % flood_dam_break_cone_01;
  level.scr_model["dam_break_cone_01"] = "flood_dam_break_cone_01";
  level.scr_animtree["dam_break_cone_02"] = #animtree;
  level.scr_anim["dam_break_cone_02"]["dam_break_cones"] = % flood_dam_break_cone_02;
  level.scr_model["dam_break_cone_02"] = "flood_dam_break_cone_01";
  level.scr_animtree["dam_break_cone_03"] = #animtree;
  level.scr_anim["dam_break_cone_03"]["dam_break_cones"] = % flood_dam_break_cone_03;
  level.scr_model["dam_break_cone_03"] = "com_trafficcone01";
  level.scr_animtree["dam_break_barrier_01"] = #animtree;
  level.scr_anim["dam_break_barrier_01"]["dam_break_cones"] = % flood_dam_break_barricade_01;
  level.scr_model["dam_break_barrier_01"] = "ny_barrier_pedestrian_01";
  level.scr_animtree["dam_break_barrier_02"] = #animtree;
  level.scr_anim["dam_break_barrier_02"]["dam_break_cones"] = % flood_dam_break_barricade_02;
  level.scr_model["dam_break_barrier_02"] = "ny_barrier_pedestrian_01";
  level.scr_animtree["dam_break_barrier_03"] = #animtree;
  level.scr_anim["dam_break_barrier_03"]["dam_break_cones"] = % flood_dam_break_barricade_03;
  level.scr_model["dam_break_barrier_03"] = "ny_barrier_pedestrian_01";
  level.scr_animtree["dam_break_church_spire"] = #animtree;
  level.scr_anim["dam_break_church_spire"]["start_church_destruction"] = % flood_dam_break_church_destruction;
  level.scr_model["dam_break_church_spire"] = "flood_church_spire";
  level.scr_animtree["convoy_checkpoint_radio"] = #animtree;
  level.scr_anim["convoy_checkpoint_radio"]["convoy_checkpoint"] = % flood_convoy_checkpoint_radio;
  level.scr_model["convoy_checkpoint_radio"] = "com_hand_radio";
  level.scr_animtree["alley_flood_debris"] = #animtree;
  level.scr_anim["alley_flood_debris"]["alley_flood"] = % flood_alley_debris;
  level.scr_model["alley_flood_debris"] = "flood_alley_flood_debris";
  level.scr_animtree["warehouse_door_burst"] = #animtree;
  level.scr_anim["warehouse_door_burst"]["flood_warehouse_doorbuckling_door"] = % flood_warehouse_doorbuckling_door;
  level.scr_anim["warehouse_door_burst"]["flood_warehouse_doorbuckling_door_alt"] = % flood_warehouse_doorbuckling_door_alt;
  level.scr_anim["warehouse_door_burst"]["flood_warehouse_doorbuckling_door_loop1"][0] = % flood_warehouse_doorbuckling_door_loop1;
  level.scr_anim["warehouse_door_burst"]["flood_warehouse_doorbuckling_door_loop2"][0] = % flood_warehouse_doorbuckling_door_loop2;
  level.scr_anim["warehouse_door_burst"]["flood_warehouse_doorbuckling_door_loop2_alt"][0] = % flood_warehouse_doorbuckling_door_loop2_alt;
  level.scr_animtree["warehouse_double_doorl"] = #animtree;
  level.scr_anim["warehouse_double_doorl"]["warehouse_double_door"][0] = % flood_warehouse_double_door_left;
  level.scr_model["warehouse_double_doorl"] = "flood_warehouse_door_left";
  level.scr_animtree["warehouse_double_doorr"] = #animtree;
  level.scr_anim["warehouse_double_doorr"]["warehouse_double_door"][0] = % flood_warehouse_double_door_right;
  level.scr_model["warehouse_double_doorr"] = "flood_warehouse_door_right";
  level.scr_animtree["building_01_debri"] = #animtree;
  level.scr_anim["building_01_debri"]["building_01_debri_anim"] = % building_01_debri_anim;
  level.scr_model["building_01_debri"] = "building_01_debri";
  level.scr_animtree["flood_mall_roof_door_model"] = #animtree;
  level.scr_anim["flood_mall_roof_door_model"]["flood_mall_roof_door"] = % flood_entering_mall_rooftop_door;
  level.scr_anim["flood_mall_roof_door_model"]["flood_mall_roof_door_outdoor"] = % flood_entering_mall_rooftop_door_outdoor;
  level.scr_model["flood_mall_roof_door_model"] = "tag_origin";
  level.scr_animtree["sweptaway_lynx_01"] = #animtree;
  level.scr_anim["sweptaway_lynx_01"]["sweptaway"] = % flood_sweptaway_lynx_01;
  level.scr_model["sweptaway_lynx_01"] = "vehicle_iveco_lynx_iw6";
  level.scr_animtree["sweptaway_lynx_02"] = #animtree;
  level.scr_anim["sweptaway_lynx_02"]["sweptaway"] = % flood_sweptaway_lynx_02;
  level.scr_model["sweptaway_lynx_02"] = "vehicle_iveco_lynx_iw6";
  level.scr_animtree["sweptaway_lynx_03"] = #animtree;
  level.scr_anim["sweptaway_lynx_03"]["sweptaway"] = % flood_sweptaway_lynx_03;
  level.scr_model["sweptaway_lynx_03"] = "vehicle_iveco_lynx_iw6";
  level.scr_animtree["sweptaway_coupe"] = #animtree;
  level.scr_anim["sweptaway_coupe"]["sweptaway"] = % flood_sweptaway_coupe;
  level.scr_model["sweptaway_coupe"] = "vehicle_civilian_sedan_blue_iw6";
  level.scr_animtree["sweptaway_tower_01"] = #animtree;
  level.scr_anim["sweptaway_tower_01"]["sweptaway"] = % flood_sweptaway_debris_tower_01;
  level.scr_model["sweptaway_tower_01"] = "flood_fallen_antennae_01";
  level.scr_animtree["sweptaway_tower_02"] = #animtree;
  level.scr_anim["sweptaway_tower_02"]["sweptaway"] = % flood_sweptaway_debris_tower_02;
  level.scr_model["sweptaway_tower_02"] = "flood_fallen_antennae_01";
  level.scr_animtree["sweptaway_tower_03"] = #animtree;
  level.scr_anim["sweptaway_tower_03"]["sweptaway"] = % flood_sweptaway_debris_tower_03;
  level.scr_model["sweptaway_tower_03"] = "flood_fallen_antennae_01";
  level.scr_animtree["sweptaway_tower_04"] = #animtree;
  level.scr_anim["sweptaway_tower_04"]["sweptaway"] = % flood_sweptaway_debris_tower_04;
  level.scr_model["sweptaway_tower_04"] = "flood_fallen_antennae_01";
  level.scr_animtree["sweptaway_palm"] = #animtree;
  level.scr_anim["sweptaway_palm"]["sweptaway"] = % flood_sweptaway_debris_palm;
  level.scr_model["sweptaway_palm"] = "foliage_tree_palm_tall_2";
  level.scr_animtree["sweptaway_street_sign"] = #animtree;
  level.scr_anim["sweptaway_street_sign"]["sweptaway"] = % flood_sweptaway_debris_street_light;
  level.scr_model["sweptaway_street_sign"] = "signal_light_traffic_sign";
  level.scr_animtree["sweptaway_antenna_01"] = #animtree;
  level.scr_anim["sweptaway_antenna_01"]["sweptaway_end_b"] = % flood_sweptaway_end_antenna_01;
  level.scr_model["sweptaway_antenna_01"] = "flood_antenna_01";
  level.scr_animtree["sweptaway_antenna_02"] = #animtree;
  level.scr_anim["sweptaway_antenna_02"]["sweptaway_end_b"] = % flood_sweptaway_end_antenna_02;
  level.scr_model["sweptaway_antenna_02"] = "flood_antenna_02";
  level.scr_animtree["sweptaway_macktruck"] = #animtree;
  level.scr_anim["sweptaway_macktruck"]["sweptaway_end_b"] = % flood_sweptaway_end_macktruck;
  level.scr_model["sweptaway_macktruck"] = "vehicle_mack_truck_short_destroy";
  level.scr_animtree["sweptaway_end_chair"] = #animtree;
  level.scr_anim["sweptaway_end_chair"]["sweptaway_end_b"] = % flood_sweptaway_end_debris_chair;
  level.scr_model["sweptaway_end_chair"] = "com_office_chair_killhouse";
  level.scr_animtree["sweptaway_end_ibeam"] = #animtree;
  level.scr_anim["sweptaway_end_ibeam"]["sweptaway_end_b"] = % flood_sweptaway_end_debris_ibeam;
  level.scr_model["sweptaway_end_ibeam"] = "flood_debris_i_beam";
  level.scr_animtree["sweptaway_end_pinned"] = #animtree;
  level.scr_anim["sweptaway_end_pinned"]["sweptaway_end_b"] = % flood_sweptaway_end_debris_pinned;
  level.scr_model["sweptaway_end_pinned"] = "flood_debris_wall_chunk";
  level.scr_animtree["skybridge_door_breach_door"] = #animtree;
  level.scr_model["skybridge_door_breach_door"] = "fac_rooftop_exit_door_r";
  level.scr_anim["skybridge_door_breach_door"]["skybridge_doorbreach"] = % flood_skybridge_doorbreach_door;
  level.scr_animtree["sweptaway_skybridge_01"] = #animtree;
  level.scr_model["sweptaway_skybridge_01"] = "flood_skybridge1_update";
  level.scr_anim["sweptaway_skybridge_01"]["sweptaway_end_b"] = % flood_sweptaway_end_skybridge_01;
  level.scr_anim["sweptaway_skybridge_01"]["skybridge_scene"] = % flood_skybridge_skybridge;
  level.scr_anim["sweptaway_skybridge_01"]["flood_skybridge_skybridge_loop"][0] = % flood_skybridge_skybridge_loop;
  level.scr_anim["sweptaway_skybridge_01"]["flood_skybridge_skybridge_part2"] = % flood_skybridge_skybridge_part2;
  level thread skybridge_script_models();
  level.scr_animtree["skybridge_building03"] = #animtree;
  level.scr_model["skybridge_building03"] = "flood_skybridge_building03";
  level.scr_anim["skybridge_building03"]["skybridge_scene"] = % flood_skybridge_bulding;
  level.scr_anim["skybridge_building03"]["flood_skybridge_building_loop"][0] = % flood_skybridge_bulding_loop;
  level.scr_anim["skybridge_building03"]["flood_skybridge_building_part2"] = % flood_skybridge_bulding_part2;
  level.scr_animtree["skybridge_bus"] = #animtree;
  level.scr_anim["skybridge_bus"]["skybridge_scene"] = % flood_skybridge_bus;
  level.scr_model["skybridge_bus"] = "mp_dart_bus";
  level.scr_animtree["skybridge_sect_0"] = #animtree;
  level.scr_model["skybridge_sect_0"] = "flood_skybridge1_update_piece1";
  level.scr_anim["skybridge_sect_0"]["skybridge_sway"][0] = % flood_skybridge_skybridgewalk_loop1_piece1;
  level.scr_anim["skybridge_sect_0"]["skybridge_break"] = % flood_skybridge_skybridgewalk_piece1;
  level.scr_animtree["skybridge_sect_1"] = #animtree;
  level.scr_model["skybridge_sect_1"] = "flood_skybridge1_update_piece2";
  level.scr_anim["skybridge_sect_1"]["skybridge_sway"][0] = % flood_skybridge_skybridgewalk_loop1_piece2;
  level.scr_anim["skybridge_sect_1"]["skybridge_break"] = % flood_skybridge_skybridgewalk_piece2;
  level.scr_animtree["skybridge_sect_2"] = #animtree;
  level.scr_model["skybridge_sect_2"] = "flood_skybridge1_update_piece3";
  level.scr_anim["skybridge_sect_2"]["skybridge_sway"][0] = % flood_skybridge_skybridgewalk_loop1_piece3;
  level.scr_anim["skybridge_sect_2"]["skybridge_break"] = % flood_skybridge_skybridgewalk_piece3;
  level.scr_animtree["mallroof_back"] = #animtree;
  level.scr_anim["mallroof_back"]["mallroof_collapse"] = % flood_mallroof_back1;
  level.scr_model["mallroof_back"] = "flood_mallroof_back";
  maps\_anim::addnotetrack_flag("mallroof_back", "enemy_area_falling", "enemy_area_falling", "mallroof_collapse");
  maps\_anim::addnotetrack_flag("mallroof_back", "player_area_falling", "player_area_falling", "mallroof_collapse");
  maps\_anim::addnotetrack_flag("mallroof_back", "ally_area_falling", "ally_area_falling", "mallroof_collapse");
  level.scr_animtree["mallroof_center"] = #animtree;
  level.scr_anim["mallroof_center"]["mallroof_collapse"] = % flood_mallroof_center1;
  level.scr_model["mallroof_center"] = "flood_mallroof_center";
  level.scr_animtree["mallroof_far"] = #animtree;
  level.scr_anim["mallroof_far"]["mallroof_collapse"] = % flood_mallroof_far1;
  level.scr_model["mallroof_far"] = "flood_mallroof_far";
  level.scr_animtree["mallroof_impact"] = #animtree;
  level.scr_anim["mallroof_impact"]["mallroof_collapse"] = % flood_mallroof_impact1;
  level.scr_anim["mallroof_impact"]["mallroof_idle"][0] = % flood_mallroof_impact_idle;
  level.scr_model["mallroof_impact"] = "flood_mallroof_impact";
  level.scr_animtree["mallroof_rafters1"] = #animtree;
  level.scr_anim["mallroof_rafters1"]["mallroof_collapse"] = % flood_mallroof_rafters11;
  level.scr_model["mallroof_rafters1"] = "flood_mallroof_rafters1";
  level.scr_animtree["mallroof_rafters2"] = #animtree;
  level.scr_anim["mallroof_rafters2"]["mallroof_collapse"] = % flood_mallroof_rafters21;
  level.scr_model["mallroof_rafters2"] = "flood_mallroof_rafters2";
  level.scr_animtree["mallroof_acboxes"] = #animtree;
  level.scr_anim["mallroof_acboxes"]["mallroof_collapse"] = % flood_mallroof_acboxes1;
  level.scr_model["mallroof_acboxes"] = "flood_mallroof_acboxes";
  level.scr_animtree["mallroof_smallrubble"] = #animtree;
  level.scr_anim["mallroof_smallrubble"]["mallroof_collapse"] = % flood_mallroof_smallrubble1;
  level.scr_model["mallroof_smallrubble"] = "flood_mallroof_smallrubble";
  level.scr_animtree["mallroof_cables"] = #animtree;
  level.scr_anim["mallroof_cables"]["mallroof_collapse"] = % flood_mallroof_cables1;
  level.scr_model["mallroof_cables"] = "flood_mallroof_cables";
  level.scr_animtree["swept_start_debris"] = #animtree;
  level.scr_anim["swept_start_debris"]["flood_sweptaway_player_start_underwater"] = % flood_sweptaway_start_underwater_debris_01;
  level.scr_model["swept_start_debris"] = "flood_sweptaway_start_underwater_debris";
  level.scr_animtree["mall_roof_opfor_geo"] = #animtree;
  level.scr_anim["mall_roof_opfor_geo"]["flood_mall_roof_opfor"][0] = % flood_mall_rooftop_floor_loop;
  level.scr_anim["mall_roof_opfor_geo"]["flood_mall_roof_opfor_shot"] = % flood_mall_rooftop_floor_shot;
  level.scr_model["mall_roof_opfor_geo"] = "flood_rooftop_collapse_opfor_loop";
  level.scr_animtree["mall_roof_opfor_geo_vign"] = #animtree;
  level.scr_anim["mall_roof_opfor_geo_vign"]["flood_mall_roof_opfor_vign1"] = % flood_mall_rooftop_floor_vign1;
  level.scr_model["mall_roof_opfor_geo_vign"] = "roof_collapse_faling_floor_vign1";
  level.scr_animtree["flood_stealthkill_02_filecabinet_01"] = #animtree;
  level.scr_anim["flood_stealthkill_02_filecabinet_01"]["stealth_kill_02"] = % flood_stealthkill_02_filecabinet_01;
  level.scr_model["flood_stealthkill_02_filecabinet_01"] = "com_filecabinetblackclosed";
  level.scr_animtree["flood_stealthkill_02_filecabinet_02"] = #animtree;
  level.scr_anim["flood_stealthkill_02_filecabinet_02"]["stealth_kill_02"] = % flood_stealthkill_02_filecabinet_02;
  level.scr_model["flood_stealthkill_02_filecabinet_02"] = "com_filecabinetblackclosed_dam";
  level.scr_animtree["stealthkill_photocopier"] = #animtree;
  level.scr_anim["stealthkill_photocopier"]["stealth_kill_02"] = % flood_stealthkill_02_copier_01;
  level.scr_model["stealthkill_photocopier"] = "com_photocopier_dtr";
  level.scr_animtree["stealth_flashlight"] = #animtree;
  level.scr_model["stealth_flashlight"] = "com_flashlight_on";
  level.scr_animtree["stealth_hatchet"] = #animtree;
  level.scr_model["stealth_hatchet"] = "com_hatchet";
  level.scr_animtree["stealth_axebox"] = #animtree;
  level.scr_anim["stealth_axebox"]["stealth_kill_01"] = % flood_stealthkill_01_axebox;
  level.scr_model["stealth_axebox"] = "flood_stealthkill_axebox";
  level.scr_animtree["skybridge_player"] = #animtree;
  level.scr_model["skybridge_player"] = "flood_skybridge1_update";
  level.scr_anim["skybridge_player"]["skybridgewalk_vignette"] = % flood_skybridge_skybridgewalk;
  level.scr_anim["skybridge_player"]["skybridgewalk_loop"] = % flood_skybridge_skybridgewalk_loop1;
  level thread rooftops_script_models();
  level thread ending_script_models();
}

skybridge_script_models() {
  common_scripts\utility::flag_wait("flood_mid_tr_loaded");
  maps\_anim::addnotetrack_customfunction("sweptaway_skybridge_01", "boom1", maps\flood_rooftops::skybridge_debris_hit_large, "flood_skybridge_skybridge_part2");
  maps\_anim::addnotetrack_customfunction("sweptaway_skybridge_01", "boom2", maps\flood_rooftops::skybridge_debris_hit_med, "flood_skybridge_skybridge_part2");
  maps\_anim::addnotetrack_customfunction("sweptaway_skybridge_01", "boom3", maps\flood_rooftops::skybridge_debris_hit_large, "flood_skybridge_skybridge_part2");
}

rooftops_script_models() {
  common_scripts\utility::flag_wait("flood_mid_tr_loaded");
  level.scr_animtree["rooftops_ropeladder"] = #animtree;
  level.scr_model["rooftops_ropeladder"] = "blackice_rope_ladder";
  level.scr_goaltime["rooftops_ropeladder"]["rooftops_heli_ropeladder"] = 0.4;
  level.scr_anim["rooftops_ropeladder"]["rooftops_heli_ropeladder"] = % flood_rooftops_01_rope_ladder;
  level.scr_anim["rooftops_ropeladder"]["rooftops_heli_ropeladder_loop"][0] = % flood_rooftops_01_rope_ladder_loop;
  level.scr_animtree["rooftops_brickwall"] = #animtree;
  level.scr_model["rooftops_brickwall"] = "flood_traversal_01_wall";
  level.scr_anim["rooftops_brickwall"]["rooftops_wall_kick"] = % flood_rooftop_traversal_wall;
  level.scr_animtree["flare_left_01"] = #animtree;
  level.scr_anim["flare_left_01"]["rooftops_water_reveal_flare"][0] = % flood_rooftop_waving_flares_flare_left_loop;
  level.scr_model["flare_left_01"] = "ctl_emergency_flare_animated";
  level.scr_animtree["flare_right_01"] = #animtree;
  level.scr_anim["flare_right_01"]["rooftops_water_reveal_flare"][0] = % flood_rooftop_waving_flares_flare_right_loop;
  level.scr_model["flare_right_01"] = "ctl_emergency_flare_animated";
  level.scr_animtree["debris_debrissmall"] = #animtree;
  level.scr_model["debris_debrissmall"] = "flood_debris_small_01";
  level.scr_anim["debris_debrissmall"]["debris_bridge_loop1"][0] = % flood_debrisbridge_loop1_debris;
  level.scr_anim["debris_debrissmall"]["debris_bridge_vign1"] = % flood_debrisbridge_vign1_debris;
  level.scr_animtree["debris_movingtruck"] = #animtree;
  level.scr_model["debris_movingtruck"] = "moving_truck_iw6";
  level.scr_anim["debris_movingtruck"]["debris_bridge_loop1"][0] = % flood_debrisbridge_loop1_movingtruck;
  level.scr_anim["debris_movingtruck"]["debris_bridge_vign1"] = % flood_debrisbridge_vign1_movingtruck;
  level.scr_anim["debris_movingtruck"]["debris_bridge_loop2"][0] = % flood_debrisbridge_loop2_movingtruck;
  level.scr_animtree["debris_vanblue"] = #animtree;
  level.scr_model["debris_vanblue"] = "vehicle_civilian_van_blue_iw6";
  level.scr_anim["debris_vanblue"]["debris_bridge_loop1"][0] = % flood_debrisbridge_loop1_vanblue;
  level.scr_anim["debris_vanblue"]["debris_bridge_vign1"] = % flood_debrisbridge_vign1_vanblue;
  level.scr_anim["debris_vanblue"]["debris_bridge_loop2"][0] = % flood_debrisbridge_loop2_vanblue;
  level.scr_animtree["debris_00"] = #animtree;
  level.scr_model["debris_00"] = "flood_debris_small_01";
  level.scr_anim["debris_00"]["debris_bridge_loop1"][0] = % flood_debrisbridge_loop1_debris_01;
  level.scr_anim["debris_00"]["debris_bridge_vign1"] = % flood_debrisbridge_vign1_debris_01;
  level.scr_anim["debris_00"]["debris_bridge_loop2"][0] = % flood_debrisbridge_loop2_debris_01;
  level.scr_animtree["debris_bus"] = #animtree;
  level.scr_model["debris_bus"] = "mp_dart_bus";
  level.scr_anim["debris_bus"]["debris_bridge_vign1"] = % flood_debrisbridge_vign1_bus;
  level.scr_anim["debris_bus"]["debris_bridge_loop2"][0] = % flood_debrisbridge_loop2_bus;
  maps\_anim::addnotetrack_customfunction("debris_bus", "wall_busted", maps\flood_util::play_rumble_light_3s);
  maps\_anim::addnotetrack_customfunction("debris_bus", "debris_bridge_veh_foam", maps\flood_fx::debris_bridge_fx);
  maps\_anim::addnotetrack_customfunction("debris_bus", "bus_sparks", maps\flood_fx::debris_bridge_bus_sparks);
  level.scr_animtree["debris_cargocontainer"] = #animtree;
  level.scr_model["debris_cargocontainer"] = "ny_harbor_cargocontainer_destroyed02";
  level.scr_anim["debris_cargocontainer"]["debris_bridge_vign1"] = % flood_debrisbridge_vign1_cargocontainer;
  level.scr_anim["debris_cargocontainer"]["debris_bridge_loop2"][0] = % flood_debrisbridge_loop2_cargocontainer;
  level.scr_animtree["debris_coupeblue"] = #animtree;
  level.scr_model["debris_coupeblue"] = "vehicle_civilian_sedan_blue_iw6";
  level.scr_anim["debris_coupeblue"]["debris_bridge_vign1"] = % flood_debrisbridge_vign1_coupeblue;
  level.scr_anim["debris_coupeblue"]["debris_bridge_loop2"][0] = % flood_debrisbridge_loop2_coupeblue;
  level.scr_animtree["debris_coupedeepblue"] = #animtree;
  level.scr_model["debris_coupedeepblue"] = "vehicle_civilian_sedan_bronze_iw6";
  level.scr_anim["debris_coupedeepblue"]["debris_bridge_vign1"] = % flood_debrisbridge_vign1_coupedeepblue;
  level.scr_anim["debris_coupedeepblue"]["debris_bridge_loop2"][0] = % flood_debrisbridge_loop2_coupedeepblue;
  level.scr_animtree["debris_vangold"] = #animtree;
  level.scr_model["debris_vangold"] = "vehicle_civilian_van_white_iw6";
  level.scr_anim["debris_vangold"]["debris_bridge_vign1"] = % flood_debrisbridge_vign1_vangold;
  level.scr_anim["debris_vangold"]["debris_bridge_loop2"][0] = % flood_debrisbridge_loop2_vangold;
  level.scr_animtree["debris_coupegreen"] = #animtree;
  level.scr_model["debris_coupegreen"] = "vehicle_civilian_sedan_black_iw6";
  level.scr_anim["debris_coupegreen"]["debris_bridge_vign1"] = % flood_debrisbridge_vign1_coupegreen;
  level.scr_anim["debris_coupegreen"]["debris_bridge_loop2"][0] = % flood_debrisbridge_loop2_coupegreen;
  level.scr_animtree["debris_macktruck"] = #animtree;
  level.scr_model["debris_macktruck"] = "flood_mack_truck_short";
  level.scr_anim["debris_macktruck"]["debris_bridge_vign1"] = % flood_debrisbridge_vign1_macktruck;
  level.scr_anim["debris_macktruck"]["debris_bridge_loop2"][0] = % flood_debrisbridge_loop2_macktruck;
  level.scr_animtree["debris_subcompgreen"] = #animtree;
  level.scr_model["debris_subcompgreen"] = "vehicle_civilian_sedan_white_iw6";
  level.scr_anim["debris_subcompgreen"]["debris_bridge_vign1"] = % flood_debrisbridge_vign1_subcompgreen;
  level.scr_anim["debris_subcompgreen"]["debris_bridge_loop2"][0] = % flood_debrisbridge_loop2_subcompgreen;
  level.scr_animtree["debris_truckbm21"] = #animtree;
  level.scr_model["debris_truckbm21"] = "vehicle_man_7t_destroy_iw6";
  level.scr_anim["debris_truckbm21"]["debris_bridge_vign1"] = % flood_debrisbridge_vign1_truckmb21;
  level.scr_anim["debris_truckbm21"]["debris_bridge_loop2"][0] = % flood_debrisbridge_loop2_truckmb21;
  level.scr_animtree["debris_utiltruck"] = #animtree;
  level.scr_model["debris_utiltruck"] = "vehicle_uk_utility_truck_static";
  level.scr_anim["debris_utiltruck"]["debris_bridge_vign1"] = % flood_debrisbridge_vign1_utiltruck;
  level.scr_anim["debris_utiltruck"]["debris_bridge_loop2"][0] = % flood_debrisbridge_loop2_utiltruck;
  level.scr_animtree["debris_vangreen"] = #animtree;
  level.scr_model["debris_vangreen"] = "vehicle_civilian_van_red_iw6";
  level.scr_anim["debris_vangreen"]["debris_bridge_vign1"] = % flood_debrisbridge_vign1_vangreen;
  level.scr_anim["debris_vangreen"]["debris_bridge_loop2"][0] = % flood_debrisbridge_loop2_vangreen;
  level.scr_animtree["debris_01"] = #animtree;
  level.scr_model["debris_01"] = "flood_debris_small_01";
  level.scr_anim["debris_01"]["debris_bridge_vign1"] = % flood_debrisbridge_vign1_debris_02;
  level.scr_anim["debris_01"]["debris_bridge_loop2"][0] = % flood_debrisbridge_loop2_debris_02;
  level.scr_animtree["debris_02"] = #animtree;
  level.scr_model["debris_02"] = "flood_debris_small_01";
  level.scr_anim["debris_02"]["debris_bridge_vign1"] = % flood_debrisbridge_vign1_debris_03;
  level.scr_anim["debris_02"]["debris_bridge_loop2"][0] = % flood_debrisbridge_loop2_debris_03;
  level.scr_animtree["debris_antenna"] = #animtree;
  level.scr_model["debris_antenna"] = "flood_antenna_02";
  level.scr_anim["debris_antenna"]["debris_bridge_vign1"] = % flood_debrisbridge_vign1_antenna;
  level.scr_anim["debris_antenna"]["debris_bridge_loop2"][0] = % flood_debrisbridge_loop2_antenna;
  level.scr_animtree["debris_wall"] = #animtree;
  level.scr_model["debris_wall"] = "flood_debris_bridge_busted_wall";
  level.scr_anim["debris_wall"]["debris_bridge_vign1"] = % flood_debrisbridge_vign1_busted_wall;
  level.scr_animtree["debris_clip"] = #animtree;
  level.scr_model["debris_clip"] = "tag_origin";
  level.scr_anim["debris_clip"]["debris_bridge_vign1"] = % flood_debrisbridge_vign1_collision;
  level.scr_anim["debris_clip"]["debris_bridge_loop2"][0] = % flood_debrisbridge_loop2_collision;
  level.scr_animtree["ending_breach_door_l"] = #animtree;
  level.scr_model["ending_breach_door_l"] = "tag_origin";
  level.scr_anim["ending_breach_door_l"]["outro_pt1_breach"] = % flood_outro_pt1_breach_door_left;
  level.scr_animtree["ending_breach_door_r"] = #animtree;
  level.scr_model["ending_breach_door_r"] = "tag_origin";
  level.scr_anim["ending_breach_door_r"]["outro_pt1_breach"] = % flood_outro_pt1_breach_door_right;
}

ending_script_models() {
  common_scripts\utility::flag_wait("flood_end_tr_loaded");
  level.scr_animtree["outro_gun_player"] = #animtree;
  level.scr_model["outro_gun_player"] = "weapon_p226";
  level.scr_anim["outro_gun_player"]["outro_pt1_melee_player"] = % flood_outro_pt1_melee_pistol;
  level.scr_anim["outro_gun_player"]["outro_pt1_melee_win"] = % flood_outro_pt1_melee_win_pistol;
  level.scr_anim["outro_gun_player"]["outro_pt1_melee_fail"] = % flood_outro_pt1_melee_fail_pistol;
  level.scr_anim["outro_gun_player"]["outro_pt1_garcia_punch"] = % flood_outro_pt1_garcia_punch_pistol;
  level.scr_anim["outro_gun_player"]["outro_pt1_garcia_kill_pt1"] = % flood_outro_pt1_garcia_kill_pt1_p_pistol;
  level.scr_anim["outro_gun_player"]["outro_pt1_garcia_kill_pt2"] = % flood_outro_pt1_garcia_kill_pt2_p_pistol;
  level.scr_anim["outro_gun_player"]["outro_pt1_crash"] = % flood_outro_pt1_crash_p_pistol;
  level.scr_animtree["outro_gun_garcia"] = #animtree;
  level.scr_model["outro_gun_garcia"] = "weapon_p226";
  level.scr_anim["outro_gun_garcia"]["outro_pt1_garcia_kill_pt1"] = % flood_outro_pt1_garcia_kill_pt1_g_pistol;
  level.scr_anim["outro_gun_garcia"]["outro_pt1_garcia_kill_pt2"] = % flood_outro_pt1_garcia_kill_pt2_g_pistol;
  level.scr_anim["outro_gun_garcia"]["outro_pt1_crash"] = % flood_outro_pt1_crash_g_pistol;
  level.scr_animtree["outro_pt1_heli"] = #animtree;
  level.scr_model["outro_pt1_heli"] = "vehicle_nh90_interior";
  level.scr_anim["outro_pt1_heli"]["outro_pt1_heli"] = % flood_outro_pt1_helicopter;
  level.scr_animtree["outro_heli_front"] = #animtree;
  level.scr_model["outro_heli_front"] = "vehicle_nh90_flood_front";
  level.scr_anim["outro_heli_front"]["outro_pt2_start"] = % flood_outro_pt2_start_heli_front;
  level.scr_anim["outro_heli_front"]["outro_pt2_save_vargas_loop"][0] = % flood_outro_pt2_save_vargas_loop_heli_front;
  level.scr_anim["outro_heli_front"]["outro_pt2_vargas_death"] = % flood_outro_pt2_vargas_death_heli_front;
  level.scr_anim["outro_heli_front"]["outro_pt2_vargas_death_end"] = % flood_outro_pt2_vargas_death_end_heli_front;
  maps\_anim::addnotetrack_customfunction("outro_heli_front", "dof_01", maps\flood_fx::ending2_dof_01);
  maps\_anim::addnotetrack_customfunction("outro_heli_front", "impact_break_01", maps\flood_fx::ending2_impact_break_01);
  maps\_anim::addnotetrack_customfunction("outro_heli_front", "window_break", maps\flood_fx::ending2_window_break);
  maps\_anim::addnotetrack_customfunction("outro_heli_front", "debri_fall", maps\flood_fx::ending2_debri_fall);
  maps\_anim::addnotetrack_customfunction("outro_heli_front", "fall_sparks", maps\flood_fx::ending2_fall_sparks);
  level.scr_animtree["outro_heli_mid"] = #animtree;
  level.scr_model["outro_heli_mid"] = "vehicle_nh90_flood_mid";
  level.scr_anim["outro_heli_mid"]["outro_pt2_start"] = % flood_outro_pt2_start_heli_mid;
  level.scr_anim["outro_heli_mid"]["outro_pt2_save_vargas_loop"][0] = % flood_outro_pt2_save_vargas_loop_heli_mid;
  level.scr_anim["outro_heli_mid"]["outro_pt2_vargas_death"] = % flood_outro_pt2_vargas_death_heli_mid;
  level.scr_anim["outro_heli_mid"]["outro_pt2_vargas_death_end"] = % flood_outro_pt2_vargas_death_end_heli_mid;
  level.scr_animtree["outro_heli_rear"] = #animtree;
  level.scr_model["outro_heli_rear"] = "vehicle_nh90_flood_mid";
  level.scr_anim["outro_heli_rear"]["outro_pt2_start"] = % flood_outro_pt2_start_heli_rear;
  level.scr_anim["outro_heli_rear"]["outro_pt2_save_vargas_loop"][0] = % flood_outro_pt2_save_vargas_loop_heli_rear;
  level.scr_anim["outro_heli_rear"]["outro_pt2_vargas_death"] = % flood_outro_pt2_vargas_death_heli_rear;
  level.scr_anim["outro_heli_rear"]["outro_pt2_vargas_death_end"] = % flood_outro_pt2_vargas_death_end_heli_rear;
  maps\_anim::addnotetrack_customfunction("outro_heli_rear", "kill_ending_heli_fx", maps\flood_fx::kill_ending_heli_fx);
  level.scr_animtree["outro_gate"] = #animtree;
  level.scr_model["outro_gate"] = "flood_outro_gate";
  level.scr_anim["outro_gate"]["outro_pt2_start"] = % flood_outro_pt2_start_gate;
  level.scr_anim["outro_gate"]["outro_pt2_save_vargas_loop"][0] = % flood_outro_pt2_save_vargas_loop_gate;
  level.scr_anim["outro_gate"]["outro_pt2_vargas_death"] = % flood_outro_pt2_vargas_death_gate;
  level.scr_anim["outro_gate"]["outro_pt2_vargas_death_end"] = % flood_outro_pt2_vargas_death_end_gate;
  level.scr_animtree["outro_wire_grab"] = #animtree;
  level.scr_model["outro_wire_grab"] = "flood_outro_wire";
  level.scr_anim["outro_wire_grab"]["outro_pt2_start"] = % flood_outro_pt2_wire;
  level.scr_animtree["outro_pt1_blood"] = #animtree;
  level.scr_anim["outro_pt1_blood"]["outro_pt1_blood"] = % flood_outro_pt1_blood;
  level.scr_model["outro_pt1_blood"] = "vehicle_nh90_blood_windshield";
}

#using_animtree("vehicles");

vehicles() {
  level.scr_anim["infil_heli_player"]["infil"] = % flood_infil_heli_01;
  level.scr_anim["infil_heli_ally"]["infil"] = % flood_infil_heli_02;
  level.scr_anim["lynx_smash"]["lynx_smash_tank"] = % flood_tank_battle_lynx_smash_tank;
  level.scr_anim["m880_crash_m880"]["m880_crash"] = % flood_convoy_crash_m880;
  level.scr_anim["convoy_lynx"]["m880_crash"] = % flood_convoy_crash_lynx;
  maps\_anim::addnotetrack_customfunction("convoy_lynx", "lynx_sparks", maps\flood_fx::fx_lynx_sparks);
  level.scr_anim["m880_crash_m880"]["m880_crash_loop"][0] = % flood_convoy_crash_m880_stuck_loop;
  level.scr_anim["mlrs_kill1_m880"]["mlrs_kill1_start"] = % flood_mlrs_kill1_m880_start;
  level.scr_anim["mlrs_kill1_m880"]["mlrs_kill1_end"] = % flood_mlrs_kill1_m880_kill;
  level.scr_anim["dam_break_m880"]["dam_break_m880_launch_prep"] = % flood_dam_break_m880_launch_prep;
  level.scr_anim["dam_break_m880"]["dam_break"] = % flood_dam_break_mrls;
  maps\_anim::addnotetrack_customfunction("dam_break_m880", "fire_missile_01", ::dam_break_missile_01);
  maps\_anim::addnotetrack_customfunction("dam_break_m880", "fire_missile_02", ::dam_break_missile_02);
  maps\_anim::addnotetrack_customfunction("dam_break_m880", "fire_missile_03", ::dam_break_missile_03);
  maps\_anim::addnotetrack_customfunction("dam_break_m880", "fire_missile_04", ::dam_break_missile_04);
  level.scr_animtree["alley_flood_man7t"] = #animtree;
  level.scr_anim["alley_flood_man7t"]["alley_flood"] = % flood_alley_man7t;
  level.scr_anim["sweptaway_m880"]["sweptaway"] = % flood_sweptaway_m880;
  level.scr_anim["sweptaway_man7t"]["sweptaway"] = % flood_sweptaway_man7t;
  level.scr_anim["sweptaway_end_man7t"]["sweptaway_end_b"] = % flood_sweptaway_end_man7t;
  level.scr_goaltime["rooftops_hind"]["rooftops_heli_ropeladder"] = 0.4;
  level.scr_anim["rooftops_hind"]["rooftops_heli_ropeladder"] = % flood_rooftops_01_hind;
  level.scr_anim["rooftops_hind"]["rooftops_heli_ropeladder_loop"][0] = % flood_rooftops_01_hind_loop;
}

vignette_actor_aware_everything() {
  self.ignoreall = 0;
  self.ignoreme = 0;
  self.grenadeawareness = 1;
  self.ignoreexplosionevents = 0;
  self.ignorerandombulletdamage = 0;
  self.ignoresuppression = 0;
  self.fixednode = 1;
  self.disablebulletwhizbyreaction = 0;
  maps\_utility::enable_pain();
  self.dontavoidplayer = 0;

  if(isDefined(self.og_newenemyreactiondistsq))
    self.newenemyreactiondistsq = self.og_newenemyreactiondistsq;
}

dam_break_m880_init() {
  if(level.start_point == "infil" || level.start_point == "streets_to_dam") {
    var_0 = getent("streets_to_dam_garage_exit", "targetname");
    var_0 waittill("trigger");
  }

  if(level.start_point == "infil" || level.start_point == "streets_to_dam" || level.start_point == "streets_to_dam_2" || level.start_point == "dam" || level.start_point == "flooding_ext") {
    level.dam_break_m880 = maps\_vignette_util::vignette_vehicle_spawn("dam_break_m880", "dam_break_m880");
    var_1 = common_scripts\utility::getstruct("vignette_dam_break", "script_noteworthy");
    var_1.origin = var_1.origin + (0, 0, 3);
    var_1 maps\_anim::anim_first_frame_solo(level.dam_break_m880, "dam_break_m880_launch_prep");
    var_2 = level.scr_anim["dam_break_m880"]["dam_break_m880_launch_prep"];
    var_3 = var_1;
    var_4 = spawnStruct();
    var_4.origin = getstartorigin(var_3.origin, var_3.angles, var_2);
    var_4.angles = getstartangles(var_3.origin, var_3.angles, var_2);
    level.dam_break_m880 vehicle_orientto(var_4.origin, var_4.angles, 25.0, 0.0);
    level.dam_break_m880 waittill("orientto_complete");
    level.dam_break_m880 notify("suspend_drive_anims");
    var_1 maps\_anim::anim_first_frame_solo(level.dam_break_m880, "dam_break_m880_launch_prep");
  }
}

dam_break_m880_shadows_init() {
  var_0 = getEntArray("m880_shadow_brush_after", "targetname");

  foreach(var_2 in var_0)
  var_2 hide();

  dam_break_m880_shadows_switch();
}

dam_break_m880_shadows_switch() {
  level waittill("dam_break_start");
  wait 2.0;
  var_0 = getEntArray("m880_shadow_brush_before", "targetname");

  foreach(var_2 in var_0)
  var_2 hide();

  var_0 = getEntArray("m880_shadow_brush_after", "targetname");

  foreach(var_2 in var_0)
  var_2 show();
}

dam_break_m880_launch_prep_spawn() {
  dam_break_m880_launch_prep(level.dam_break_m880);
}

dam_break_m880_launch_prep(var_0) {
  wait 2.5;
  var_1 = common_scripts\utility::getstruct("vignette_dam_break", "script_noteworthy");
  var_2 = [];
  var_2["dam_break_m880"] = var_0;
  var_1 thread maps\_anim::anim_single(var_2, "dam_break_m880_launch_prep");
  var_1.origin = var_1.origin - (0, 0, 3);
}

dam_break_spawn() {
  var_0 = maps\_vignette_util::vignette_actor_spawn("vignette_dam_break_player_legs", "dam_break_player_legs");
  dam_break(var_0, level.dam_break_m880);
  var_0 maps\_vignette_util::vignette_actor_delete();
}

dam_break(var_0, var_1) {
  level.player endon("death");
  thread maps\flood_fx::fx_dam_missile_launch_01();
  thread maps\flood_fx::fx_dam_missile_dust();
  maps\_utility::battlechatter_off("axis");
  maps\_utility::battlechatter_off("allies");
  maps\_utility::flavorbursts_off("allies");
  wait 0.3;
  var_2 = maps\_utility::spawn_anim_model("dam_break_helmet");
  var_3 = getdvarint("g_friendlyNameDist");
  setsaveddvar("g_friendlyNameDist", 0);
  level.player freezecontrols(1);
  level.player stopsliding();

  if(level.player getstance() == "prone") {
    level.player setstance("crouch");

    while(level.player getstance() != "crouch")
      common_scripts\utility::waitframe();
  }

  if(level.player getstance() == "crouch") {
    level.player setstance("stand");

    while(level.player getstance() != "stand")
      common_scripts\utility::waitframe();
  }

  level.player allowprone(0);
  level.player allowcrouch(0);
  var_4 = maps\_utility::spawn_anim_model("player_rig");
  level.player hideviewmodel();
  var_5 = [];
  var_5["dam_break_player_legs"] = var_0;
  var_5["player_rig"] = var_4;
  var_5["dam_break_m880"] = var_1;
  var_5["dam_break_helmet"] = var_2;
  var_6 = 0;
  level.player playerlinktoblend(var_4, "tag_player", 0.25, 0.125, 0.125);
  level.player disableweapons();
  level.player disableoffhandweapons();
  var_7 = common_scripts\utility::getstruct("vignette_dam_and_church_destruction", "script_noteworthy");
  thread play_dam_break_water(var_7);
  thread play_dam_destruction_anim();
  var_7 = common_scripts\utility::getstruct("vignette_dam_break", "script_noteworthy");
  thread maps\flood_fx::dof_dam_break();
  thread enable_player_control(var_4);
  thread enable_lens_vignette(var_4);
  level notify("dam_break_start");

  foreach(var_9 in level.allies)
  var_9 thread dam_break_ally(var_7);

  setsaveddvar("compass", 0);
  setsaveddvar("ammoCounterHide", 1);
  setsaveddvar("actionSlotsHide", 1);
  setsaveddvar("hud_showStance", 0);
  level thread maps\flood_streets::add_dam_vignette_hud_overlay();
  var_7 maps\_anim::anim_single(var_5, "dam_break");
  level.player showviewmodel();
  level.player unlink();
  var_4 delete();

  if(weaponclass(level.player getcurrentprimaryweapon()) != "rifle") {
    var_11 = level.player getweaponslistprimaries();

    foreach(var_13 in var_11) {
      if(weaponclass(var_13) == "rifle") {
        level.player switchtoweaponimmediate(var_13);
        break;
      }
    }
  }

  level.player enableweapons();
  level.player enableoffhandweapons();
  level.player freezecontrols(0);
  level.player allowprone(1);
  level.player allowcrouch(1);
  setsaveddvar("compass", 1);
  setsaveddvar("ammoCounterHide", 0);
  setsaveddvar("actionSlotsHide", 0);
  setsaveddvar("hud_showStance", 1);
  setsaveddvar("hud_drawhud", 1);
  setsaveddvar("g_friendlyNameDist", var_3);
  common_scripts\utility::flag_set("vignette_dam_break_end_flag");
}

dam_break_ally(var_0) {
  self endon("death");
  thread dam_break_ally_hide(3);

  switch (self.animname) {
    case "ally_0":
      self setgoalpos(common_scripts\utility::getstruct("ally0_flee_face", "targetname").origin);
      var_0 maps\_anim::anim_single_solo(self, "dam_break");
      thread maps\flood_flooding::ally0_main();
      break;
    case "ally_1":
      self setgoalnode(getnode("ally1_flee_face", "targetname"));
      var_0 maps\_anim::anim_single_solo(self, "dam_break");
      thread maps\flood_flooding::ally1_main();
      break;
    case "ally_2":
      self setgoalnode(getnode("ally2_flee_face", "targetname"));
      var_0 maps\_anim::anim_single_solo(self, "dam_break");
      thread maps\flood_flooding::ally2_main();
      break;
  }
}

dam_break_ally_hide(var_0) {
  self hide();
  wait(var_0);
  self show();
}

opfor_m880_escape_spawn(var_0) {
  var_1 = maps\_vignette_util::vignette_actor_spawn("vignette_dam_break_opfor_m880", "dam_break_opfor_m880");
  opfor_m880_escape(var_0, var_1);
  var_1 maps\_vignette_util::vignette_actor_delete();
}

opfor_m880_escape(var_0, var_1) {
  var_2 = common_scripts\utility::getstruct("vignette_dam_break", "script_noteworthy");
  var_0 = [];
  var_0["dam_break_opfor_m880"] = var_1;
  var_2 maps\_anim::anim_single(var_0, "opfor_m880_escape");
}

init_dam_destruction_anim() {
  var_0 = common_scripts\utility::getstruct("vignette_dam_and_church_destruction", "script_noteworthy");
  level.dam_break_dam = maps\_utility::spawn_anim_model("dam_break_dam");
  var_1 = getent("flood_dam", "targetname");

  if(isDefined(var_1))
    var_1 hide();

  var_2 = [];
  var_2["dam_break_dam"] = level.dam_break_dam;
  var_0 maps\_anim::anim_first_frame(var_2, "dam_break_dam_destruction");
}

play_dam_destruction_anim() {
  var_0 = common_scripts\utility::getstruct("vignette_dam_and_church_destruction", "script_noteworthy");

  if(!isDefined(level.dam_break_dam))
    level.dam_break_dam = maps\_utility::spawn_anim_model("dam_break_dam");

  var_1 = [];
  var_1["dam_break_dam"] = level.dam_break_dam;
  thread maps\flood_fx::fx_dam_explosion();
  thread maps\flood_streets::dam_waterfall_hide();
  var_0 maps\_anim::anim_single(var_1, "dam_break_dam_destruction");
}

play_cone_anims(var_0) {
  var_1 = common_scripts\utility::getstruct("vignette_dam_break", "script_noteworthy");
  var_2 = maps\_utility::spawn_anim_model("dam_break_cone_01");
  var_3 = getent("cone_collision1", "targetname");
  var_3.origin = var_2 gettagorigin("com_trafficcone02");
  var_3.angles = var_2 gettagangles("com_trafficcone02");
  var_3 linkto(var_2, "com_trafficcone02", (0, 0, 20), (0, 0, 0));
  var_4 = maps\_utility::spawn_anim_model("dam_break_cone_02");
  var_3 = getent("cone_collision2", "targetname");
  var_3.origin = var_4 gettagorigin("com_trafficcone02");
  var_3.angles = var_4 gettagangles("com_trafficcone02");
  var_3 linkto(var_4, "com_trafficcone02", (0, 0, 20), (0, 0, 0));
  var_5 = maps\_utility::spawn_anim_model("dam_break_cone_03");
  var_6 = maps\_utility::spawn_anim_model("dam_break_barrier_01");
  var_7 = maps\_utility::spawn_anim_model("dam_break_barrier_02");
  var_8 = maps\_utility::spawn_anim_model("dam_break_barrier_03");
  var_0 = [];
  var_0["dam_break_cone_01"] = var_2;
  var_0["dam_break_cone_02"] = var_4;
  var_0["dam_break_cone_03"] = var_5;
  var_0["dam_break_barrier_01"] = var_6;
  var_0["dam_break_barrier_02"] = var_7;
  var_0["dam_break_barrier_03"] = var_8;
  var_1 maps\_anim::anim_single(var_0, "dam_break_cones");
  common_scripts\utility::flag_wait("player_at_stairs_stop_nag");
  var_9 = [var_2, var_4, var_5, var_6, var_7, var_8];
  maps\_utility::array_delete(var_9);
}

enable_player_control(var_0) {
  var_0 maps\_utility::waittill_notetrack_or_damage("player_control");
  var_1 = 15;
  level.player playerlinktodelta(var_0, "tag_player", 1, var_1, var_1, var_1, var_1, 1);
  level.player springcamenabled(1.0, 3.2, 1.6);
}

enable_lens_vignette(var_0) {
  self endon("death");
  var_0 waittillmatch("single anim", "start_vignetting");
  common_scripts\utility::flag_set("vignette_lens");
  var_0 waittillmatch("single anim", "end_vignetting");
  common_scripts\utility::flag_set("vignette_lens_fade_out");
}

change_dof() {
  maps\_art::dof_enable_script(0, 184, 4, 777, 11650, 0, 0.25);
  wait 11.67;
  maps\_art::dof_disable_script(1.5);
}

dam_break_missile_01(var_0) {
  var_1 = common_scripts\utility::getstruct("vignette_dam_break", "script_noteworthy");
  var_2 = maps\_utility::spawn_anim_model("dam_break_missile_01");
  var_2 hide();
  var_0 = [];
  var_0["dam_break_missile_01"] = var_2;
  thread maps\flood_fx::fx_dam_missile_afterburn_01();
  var_1 thread maps\_anim::anim_single(var_0, "dam_break_missile_01");
  var_3 = common_scripts\utility::getfx("flood_m880_missile_trail_01");
  var_4 = common_scripts\utility::getfx("flood_m880_missile_begin");
  playFXOnTag(var_3, var_2, "tag_fx");
}

dam_break_missile_02(var_0) {
  var_1 = common_scripts\utility::getstruct("vignette_dam_break", "script_noteworthy");
  var_2 = maps\_utility::spawn_anim_model("dam_break_missile_02");
  var_2 hide();
  var_0 = [];
  var_0["dam_break_missile_02"] = var_2;
  var_1 thread maps\_anim::anim_single(var_0, "dam_break_missile_02");
  var_3 = common_scripts\utility::getfx("flood_m880_missile_trail_01");
  var_4 = common_scripts\utility::getfx("flood_m880_missile_begin");
  playFXOnTag(var_3, var_2, "tag_fx");
}

dam_break_missile_03(var_0) {
  var_1 = common_scripts\utility::getstruct("vignette_dam_break", "script_noteworthy");
  var_2 = maps\_utility::spawn_anim_model("dam_break_missile_03");
  var_2 hide();
  var_0 = [];
  var_0["dam_break_missile_03"] = var_2;
  var_1 thread maps\_anim::anim_single(var_0, "dam_break_missile_03");
  var_3 = common_scripts\utility::getfx("flood_m880_missile_trail_01");
  var_4 = common_scripts\utility::getfx("flood_m880_missile_begin");
  playFXOnTag(var_3, var_2, "tag_fx");
}

dam_break_missile_04(var_0) {
  var_1 = common_scripts\utility::getstruct("vignette_dam_break", "script_noteworthy");
  var_2 = maps\_utility::spawn_anim_model("dam_break_missile_04");
  var_2 hide();
  var_0 = [];
  var_0["dam_break_missile_04"] = var_2;
  var_1 thread maps\_anim::anim_single(var_0, "dam_break_missile_04");
  var_3 = common_scripts\utility::getfx("flood_m880_missile_trail_01");
  var_4 = common_scripts\utility::getfx("flood_m880_missile_begin");
  playFXOnTag(var_3, var_2, "tag_fx");
}

play_dam_break_water(var_0) {
  thread maps\flood_fx::dam_flood_fx();
}

dam_break_street_water_init() {
  if(level.start_point == "infil" || level.start_point == "streets_to_dam") {
    if(!common_scripts\utility::flag_exist("player_on_ladder"))
      common_scripts\utility::flag_init("player_on_ladder");

    common_scripts\utility::flag_wait("player_on_ladder");
  }

  if(level.start_point == "infil" || level.start_point == "streets_to_dam" || level.start_point == "streets_to_dam_2" || level.start_point == "dam" || level.start_point == "flooding_ext") {
    var_0 = common_scripts\utility::getstruct("vignette_dam_break_floating_objects", "script_noteworthy");
    var_1 = maps\_utility::spawn_anim_model("dam_break_street_debris");
    attach_fx_anim_model(var_1, "com_trafficcone01", "j_flood_dam_street_street_debris_com_trafficcone01_1", "angry_flood_cleanup");
    attach_fx_anim_model(var_1, "com_trafficcone01", "j_flood_dam_street_street_debris_com_trafficcone01_2", "angry_flood_cleanup");
    attach_fx_anim_model(var_1, "com_trafficcone01", "j_flood_dam_street_street_debris_com_trafficcone01_3", "angry_flood_cleanup");
    attach_fx_anim_model(var_1, "vehicle_iveco_lynx_iw6", "j_flood_dam_street_street_debris_vehicle_iveco_lynx_iw6_4", "angry_flood_cleanup");
    attach_fx_anim_model(var_1, "vehicle_iveco_lynx_iw6", "j_flood_dam_street_street_debris_vehicle_iveco_lynx_iw6_6", "angry_flood_cleanup");
    attach_fx_anim_model(var_1, "flood_light_generator", "j_flood_dam_street_street_debris_flood_light_generator_7", "angry_flood_cleanup");
    attach_fx_anim_model(var_1, "flood_light_generator", "j_flood_dam_street_street_debris_flood_light_generator_8", "angry_flood_cleanup");
    attach_fx_anim_model(var_1, "com_trafficcone02", "j_flood_dam_street_street_debris_com_trafficcone02_9", "angry_flood_cleanup");
    attach_fx_anim_model(var_1, "com_trafficcone02", "j_flood_dam_street_street_debris_com_trafficcone02_11", "angry_flood_cleanup");
    attach_fx_anim_model(var_1, "com_trafficcone02", "j_flood_dam_street_street_debris_com_trafficcone02_12", "angry_flood_cleanup");
    attach_fx_anim_model(var_1, "com_trafficcone02", "j_flood_dam_street_street_debris_com_trafficcone02_13", "angry_flood_cleanup");
    attach_fx_anim_model(var_1, "com_trafficcone02", "j_flood_dam_street_street_debris_com_trafficcone02_14", "angry_flood_cleanup");
    attach_fx_anim_model(var_1, "com_trafficcone02", "j_flood_dam_street_street_debris_com_trafficcone02_15", "angry_flood_cleanup");
    attach_fx_anim_model(var_1, "com_trafficcone02", "j_flood_dam_street_street_debris_com_trafficcone02_16", "angry_flood_cleanup");
    attach_fx_anim_model(var_1, "com_trafficcone02", "j_flood_dam_street_street_debris_com_trafficcone02_17", "angry_flood_cleanup");
    attach_fx_anim_model(var_1, "com_trafficcone02", "j_flood_dam_street_street_debris_com_trafficcone02_18", "angry_flood_cleanup");
    attach_fx_anim_model(var_1, "com_trafficcone02", "j_flood_dam_street_street_debris_com_trafficcone02_19", "angry_flood_cleanup");
    attach_fx_anim_model(var_1, "com_trafficcone02", "j_flood_dam_street_street_debris_com_trafficcone02_20", "angry_flood_cleanup");
    attach_fx_anim_model(var_1, "com_trafficcone02", "j_flood_dam_street_street_debris_com_trafficcone02_21", "angry_flood_cleanup");
    attach_fx_anim_model(var_1, "com_trafficcone02", "j_flood_dam_street_street_debris_com_trafficcone02_22", "angry_flood_cleanup");
    attach_fx_anim_model(var_1, "vehicle_man_7t_iw6", "j_flood_dam_street_street_debris_vehicle_man_7t_iw6_23", "angry_flood_cleanup");
    attach_fx_anim_model(var_1, "flood_light_generator", "j_flood_dam_street_street_debris_flood_light_generator_24", "angry_flood_cleanup");
    attach_fx_anim_model(var_1, "vehicle_iveco_lynx_iw6", "j_flood_dam_street_street_debris_vehicle_iveco_lynx_iw6_26", "angry_flood_cleanup");
    attach_fx_anim_model(var_1, "flood_light_generator", "j_flood_dam_street_street_debris_flood_light_generator_27", "angry_flood_cleanup");
    attach_fx_anim_model(var_1, "com_trafficcone02", "j_flood_dam_street_street_debris_com_trafficcone02_28", "angry_flood_cleanup");
    attach_fx_anim_model(var_1, "com_trafficcone02", "j_flood_dam_street_street_debris_com_trafficcone02_29", "angry_flood_cleanup");
    var_1 hide();
    var_2 = [];
    var_2["dam_break_street_debris"] = var_1;
    level.dam_break_street_debris = var_1;
    var_0 maps\_anim::anim_first_frame(var_2, "dam_break_street_water");
  }
}

dam_break_street_water(var_0) {
  var_1 = common_scripts\utility::getstruct("vignette_dam_break_floating_objects", "script_noteworthy");
  attach_fx_anim_model(level.dam_break_street_debris, "vehicle_iveco_lynx_iw6", "j_flood_dam_street_street_debris_vehicle_iveco_lynx_iw6_5");
  attach_fx_anim_model(level.dam_break_street_debris, "vehicle_man_7t_iw6", "j_flood_dam_street_street_debris_vehicle_man_7t_iw6_10");
  attach_fx_anim_model(level.dam_break_street_debris, "vehicle_man_7t_iw6", "j_flood_dam_street_street_debris_vehicle_man_7t_iw6_25");
  var_0 = [];
  var_0["dam_break_street_water_01"] = level.dam_break_street_water_01;
  var_0["dam_break_street_water_02"] = level.dam_break_street_water_02;
  var_0["dam_break_street_water_03"] = level.dam_break_street_water_03;
  var_0["dam_break_street_water_04"] = level.dam_break_street_water_04;
  var_0["dam_break_street_debris"] = level.dam_break_street_debris;
  level thread maps\flood_flooding::angry_flood_rumble();
  maps\_utility::delaythread(6, maps\flood_fx::fx_bokehdots_and_waterdrops_heavy, 4);
  maps\_utility::delaythread(7, maps\flood_fx::fx_bokehdots_and_waterdrops_heavy, 4);
  maps\_utility::delaythread(8, maps\flood_fx::fx_bokehdots_and_waterdrops_heavy, 4);
  maps\_utility::delaythread(6, maps\flood_flooding::angry_flood_collision_cheater, "waterball_path_1");
  maps\_utility::delaythread(8, maps\flood_fx::alley_fill_shallow, "alley_fill_shallow_start", "alley_rising_water_start", (-650, -4104, -58), 9.4, "flood_water_alley_fill_shallow_left");
  thread maps\flood_fx::angry_flood_water();
  var_1 maps\_anim::anim_single(var_0, "dam_break_street_water");
}

church_destruction_init() {
  level.dam_break_church_spire = maps\_utility::spawn_anim_model("dam_break_church_spire");
  var_0 = common_scripts\utility::getstruct("vignette_dam_and_church_destruction", "script_noteworthy");
  var_0 maps\_anim::anim_first_frame_solo(level.dam_break_church_spire, "start_church_destruction");
}

start_church_destruction(var_0) {
  var_1 = common_scripts\utility::getstruct("vignette_dam_and_church_destruction", "script_noteworthy");
  var_0 = [];
  var_0["dam_break_church_spire"] = level.dam_break_church_spire;
  thread maps\flood_fx::dam_street_flood_church_hits();
  wait 3.5;
  var_1 maps\_anim::anim_single(var_0, "start_church_destruction");
}

palm_tree_spawn() {
  palm_tree();
}

palm_tree() {
  var_0 = common_scripts\utility::getstruct("vignette_plam_tree", "script_noteworthy");
  var_1 = maps\_utility::spawn_anim_model("palm_tree_01");
  var_2 = [];
  var_2["palm_tree_01"] = var_1;
  var_0 maps\_anim::anim_single(var_2, "palm_tree");
}

street_stop_sign_01_spawn() {
  var_0 = common_scripts\utility::getstruct("vignette_street_stop_sign_01", "script_noteworthy");
  var_1 = maps\_utility::spawn_anim_model("flood_stop_sign_01");
  var_1.script_noteworthy = "tanks_cleanup";
  var_2 = [];
  var_2["flood_stop_sign_01"] = var_1;
  var_0 maps\_anim::anim_first_frame(var_2, "street_stop_sign_01");
  common_scripts\utility::flag_wait("vignette_streets_stop_sign_01");
  street_stop_sign_01(var_1);
}

street_stop_sign_01(var_0) {
  var_1 = common_scripts\utility::getstruct("vignette_street_stop_sign_01", "script_noteworthy");
  var_2 = [];
  var_2["flood_stop_sign_01"] = var_0;
  var_1 maps\_anim::anim_single(var_2, "street_stop_sign_01");
}

convoy_checkpoint_spawn() {
  var_0 = maps\_vignette_util::vignette_actor_spawn("convoy_checkpoint_opfor01", "convoy_checkpoint_opfor01");
  var_1 = maps\_vignette_util::vignette_actor_spawn("convoy_checkpoint_opfor02", "convoy_checkpoint_opfor02");
  var_2 = maps\_vignette_util::vignette_actor_spawn("convoy_checkpoint_opfor03", "convoy_checkpoint_opfor03");
  var_3 = maps\_vignette_util::vignette_actor_spawn("convoy_checkpoint_opfor04", "convoy_checkpoint_opfor04");
  convoy_checkpoint(var_0, var_1, var_2, var_3);
  var_0 maps\_vignette_util::vignette_actor_delete();
  var_1 maps\_vignette_util::vignette_actor_delete();
  var_2 maps\_vignette_util::vignette_actor_delete();
  var_3 maps\_vignette_util::vignette_actor_delete();
}

convoy_checkpoint(var_0, var_1, var_2, var_3) {
  var_4 = common_scripts\utility::getstruct("vignette_convoy_checkpoint_node", "script_noteworthy");
  var_5 = maps\_utility::spawn_anim_model("convoy_checkpoint_radio");
  var_5 thread maps\flood_streets::delete_on_flag("enemy_alerted");
  var_6 = [];

  if(isDefined(var_1) && isalive(var_1)) {
    var_6["convoy_checkpoint_opfor02"] = var_1;
    var_4.origin = var_4.origin + (60, 0, 0);
    var_4 thread maps\_anim::anim_single(var_6, "convoy_checkpoint");
    var_4.origin = var_4.origin + (-60, 0, 0);
  }

  var_6 = [];

  if(isDefined(var_0) && isalive(var_0))
    var_6["convoy_checkpoint_opfor01"] = var_0;

  if(isDefined(var_2) && isalive(var_2))
    var_6["convoy_checkpoint_opfor03"] = var_2;

  if(isDefined(var_3) && isalive(var_3))
    var_6["convoy_checkpoint_opfor04"] = var_3;

  if(isDefined(var_5))
    var_6["convoy_checkpoint_radio"] = var_5;

  var_4 maps\_anim::anim_single(var_6, "convoy_checkpoint");
}

m880_crash_spawn(var_0, var_1) {
  m880_crash(var_0, var_1);
}

m880_crash(var_0, var_1) {
  var_2 = common_scripts\utility::getstruct("vignette_m880_crash", "script_noteworthy");
  var_2 notify("start_crash_debris");
  var_2 notify("start_crash_barrels");
  var_3 = [];
  var_3["m880_crash_m880"] = var_0;
  var_1 thread m880_lynx_crash();
  var_4 = level.scr_anim["m880_crash_m880"]["m880_crash"];
  var_5 = var_2;
  var_6 = spawnStruct();
  var_6.origin = getstartorigin(var_5.origin, var_5.angles, var_4);
  var_6.angles = getstartangles(var_5.origin, var_5.angles, var_4);
  var_0 vehicle_orientto(var_6.origin, var_6.angles, 25.0, 0.0);
  var_0 waittill("orientto_complete");
  var_0 notify("suspend_drive_anims");
  var_2 maps\_anim::anim_single(var_3, "m880_crash");
}

m880_lynx_crash() {
  var_0 = [];
  var_0["convoy_lynx"] = self;
  var_1 = level.scr_anim["convoy_lynx"]["m880_crash"];
  var_2 = common_scripts\utility::getstruct("vignette_m880_crash", "script_noteworthy");
  var_3 = spawnStruct();
  var_3.origin = getstartorigin(var_2.origin, var_2.angles, var_1);
  var_3.angles = getstartangles(var_2.origin, var_2.angles, var_1);
  var_4 = self;
  var_4 vehicle_orientto(var_3.origin, var_3.angles, 25.0, 0.0);
  var_4 waittill("orientto_complete");
  var_4 notify("suspend_drive_anims");
  level notify("lynx_crash_start");
  var_2 maps\_anim::anim_single(var_0, "m880_crash");
  level notify("lynx_crash_end");
}

m880_crash_loop(var_0) {
  var_0 endon("stop_crash_loop");
  var_1 = common_scripts\utility::getstruct("vignette_m880_crash", "script_noteworthy");
  var_2 = [];
  var_2["m880_crash_m880"] = var_0;
  var_2["convoy_barrier_tall_01"] = level.convoy_tall_barricade_01;
  var_2["convoy_barrier_tall_02"] = level.convoy_tall_barricade_02;
  var_2["m880_radiation_gate"] = level.m880_radiation_gate;
  var_1 thread maps\_anim::anim_loop(var_2, "m880_crash_loop", "stop_crash_loop");
  thread maps\flood_audio::mssl_launch_front_wheels();
}

m880_crash_anim_init() {
  wait 0.1;
  var_0 = common_scripts\utility::getstruct("vignette_m880_crash", "script_noteworthy");
  thread m880_crash_barrels(var_0);
  thread m880_crash_debris(var_0);
}

m880_crash_debris(var_0) {
  var_1 = maps\_utility::spawn_anim_model("convoy_debris_cone_01");
  var_1.script_noteworthy = "m880_cleanup";
  var_2 = maps\_utility::spawn_anim_model("convoy_debris_cone_02");
  var_2.script_noteworthy = "m880_cleanup";
  var_3 = maps\_utility::spawn_anim_model("convoy_debris_cone_03");
  var_3.script_noteworthy = "m880_cleanup";
  var_4 = maps\_utility::spawn_anim_model("convoy_plastic_barricade_01");
  var_4.script_noteworthy = "m880_cleanup";
  var_5 = maps\_utility::spawn_anim_model("convoy_plastic_barricade_02");
  var_5.script_noteworthy = "m880_cleanup";
  var_6 = maps\_utility::spawn_anim_model("convoy_plastic_barricade_03");
  var_6.script_noteworthy = "m880_cleanup";
  var_7 = maps\_utility::spawn_anim_model("convoy_plastic_barricade_04");
  var_7.script_noteworthy = "m880_cleanup";
  level.convoy_tall_barricade_01 = maps\_utility::spawn_anim_model("convoy_tall_barricade_01");
  level.convoy_tall_barricade_01.script_noteworthy = "m880_cleanup";
  level.convoy_tall_barricade_02 = maps\_utility::spawn_anim_model("convoy_tall_barricade_02");
  level.convoy_tall_barricade_02.script_noteworthy = "m880_cleanup";
  var_8 = maps\_utility::spawn_anim_model("convoy_short_barricade_01");
  var_8.script_noteworthy = "m880_cleanup";
  var_9 = maps\_utility::spawn_anim_model("convoy_debris_lynx");
  var_9.script_noteworthy = "m880_cleanup";
  var_10 = maps\_utility::spawn_anim_model("convoy_debris_m880_01");
  var_10.script_noteworthy = "m880_cleanup";
  var_11 = maps\_utility::spawn_anim_model("convoy_debris_m880_02");
  var_11.script_noteworthy = "m880_cleanup";
  var_12 = maps\_utility::spawn_anim_model("convoy_debris_m880_03");
  var_12.script_noteworthy = "m880_cleanup";
  level.m880_radiation_gate = getent("checkpoint_gate", "targetname");
  level.m880_radiation_gate.animname = "m880_radiation_gate";
  level.m880_radiation_gate maps\_utility::assign_animtree();
  var_13 = [];
  var_13["convoy_debris_cone_01"] = var_1;
  var_13["convoy_debris_cone_02"] = var_2;
  var_13["convoy_debris_cone_03"] = var_3;
  var_13["convoy_plastic_barricade_01"] = var_4;
  var_13["convoy_plastic_barricade_02"] = var_5;
  var_13["convoy_plastic_barricade_03"] = var_6;
  var_13["convoy_plastic_barricade_04"] = var_7;
  var_13["convoy_tall_barricade_01"] = level.convoy_tall_barricade_01;
  var_13["convoy_tall_barricade_02"] = level.convoy_tall_barricade_02;
  var_13["convoy_short_barricade_01"] = var_8;
  var_13["convoy_debris_lynx"] = var_9;
  var_13["convoy_debris_m880_01"] = var_10;
  var_13["convoy_debris_m880_03"] = var_12;
  var_13["m880_radiation_gate"] = level.m880_radiation_gate;
  var_0 maps\_anim::anim_first_frame(var_13, "m880_crash_debris");
  var_14 = getent("checkpoint_concrete_swap_barrier_1", "targetname");
  var_15 = getent("checkpoint_concrete_swap_barrier_2", "targetname");
  var_15 delete();
  var_16 = getent("checkpoint_concrete_swap_barrier_3", "targetname");
  var_10 hide();
  var_12 hide();
  var_0 thread m880_crash_debris_collision_change();
  var_0 waittill("start_crash_debris");
  var_17 = [var_10, var_12];
  var_18 = [var_14, var_16];
  thread wait_show_and_delete_debris(2.5, var_17, var_18);
  var_0 maps\_anim::anim_single(var_13, "m880_crash_debris");
  var_0 notify("change_collision");
}

wait_show_and_delete_debris(var_0, var_1, var_2) {
  wait(var_0);

  foreach(var_4 in var_1)
  var_4 show();

  foreach(var_4 in var_2)
  var_4 delete();
}

m880_crash_debris_left_side(var_0) {
  var_0 waittill("start_crash_debris");
  wait 4.0;
  var_0 = common_scripts\utility::getstruct("vignette_m880_crash_left", "script_noteworthy");
  var_1 = maps\_utility::spawn_anim_model("convoy_debris_m880_02");
  var_2 = [];
  var_2["convoy_debris_m880_02"] = var_1;
  var_0.origin = var_0.origin + (0, -25, 0);
  var_0 maps\_anim::anim_last_frame_solo(var_1, "m880_crash_debris");
}

m880_crash_debris_collision_change() {
  var_0 = getEntArray("clip_after_m880_crash", "targetname");

  foreach(var_2 in var_0) {
    var_2 hide();
    var_2 notsolid();
  }

  self waittill("start_crash_debris");
  wait 2.9;
  var_0 = getEntArray("clip_before_m880_crash", "targetname");

  foreach(var_2 in var_0)
  var_2 delete();

  var_0 = getEntArray("clip_after_m880_crash", "targetname");

  foreach(var_2 in var_0) {
    if(level.player istouching(var_2)) {
      var_2 thread push_player_out_of_brush((20, 0, 0));
      continue;
    }

    var_2 show();
    var_2 solid();
  }
}

push_player_out_of_brush(var_0) {
  while(level.player istouching(self)) {
    level.player pushplayervector(var_0, 1);
    common_scripts\utility::waitframe();
  }

  level.player pushplayervector((0, 0, 0));
  self show();
  self solid();
}

m880_crash_barrels(var_0) {
  var_1 = maps\_utility::spawn_anim_model("convoy_debris_barrel_01");
  var_1.script_noteworthy = "m880_cleanup";
  var_2 = maps\_utility::spawn_anim_model("convoy_debris_barrel_02");
  var_2.script_noteworthy = "m880_cleanup";
  var_3 = maps\_utility::spawn_anim_model("convoy_debris_barrel_03");
  var_3.script_noteworthy = "m880_cleanup";
  var_4 = maps\_utility::spawn_anim_model("convoy_debris_barrel_04");
  var_4.script_noteworthy = "m880_cleanup";
  var_5 = maps\_utility::spawn_anim_model("convoy_debris_barrel_06");
  var_5.script_noteworthy = "m880_cleanup";
  var_6 = maps\_utility::spawn_anim_model("convoy_debris_barrel_07");
  var_6.script_noteworthy = "m880_cleanup";
  var_7 = [];
  var_7["convoy_debris_barrel_01"] = var_1;
  var_7["convoy_debris_barrel_02"] = var_2;
  var_7["convoy_debris_barrel_03"] = var_3;
  var_7["convoy_debris_barrel_04"] = var_4;
  var_7["convoy_debris_barrel_06"] = var_5;
  var_7["convoy_debris_barrel_07"] = var_6;
  var_0 maps\_anim::anim_first_frame(var_7, "m880_crash_barrels");
  var_0 waittill("start_crash_barrels");
  var_0 maps\_anim::anim_single(var_7, "m880_crash_barrels");
}

m880_cleanup() {
  var_0 = getEntArray("m880_cleanup", "script_noteworthy");
  maps\_utility::array_delete(var_0);
}

launcher_callout_ally01_spawn() {
  var_0 = maps\_vignette_util::vignette_actor_spawn("launcher_callout_ally01", "launcher_callout_ally01");
  launcher_callout_ally01(var_0);
  var_0 maps\_vignette_util::vignette_actor_delete();
}

launcher_callout_ally01(var_0, var_1, var_2) {
  var_3 = common_scripts\utility::getstruct("vignette_launcher_callout_ally01_node", "script_noteworthy");

  if(isDefined(var_1) && isDefined(var_2)) {
    var_3.origin = var_1;
    var_3.angles = var_2;
  }

  var_4 = [];
  var_4["launcher_callout_ally01"] = var_0;
  var_3 maps\_anim::anim_single(var_4, "launcher_callout_ally01");
}

launcher_callout_ally02_spawn() {
  var_0 = maps\_vignette_util::vignette_actor_spawn("launcher_callout_ally02", "launcher_callout_ally02");
  launcher_callout_ally02(var_0);
  var_0 maps\_vignette_util::vignette_actor_delete();
}

launcher_callout_ally02(var_0, var_1, var_2) {
  var_3 = common_scripts\utility::getstruct("vignette_launcher_callout_ally02_node", "script_noteworthy");

  if(isDefined(var_1) && isDefined(var_2)) {
    var_3.origin = var_1;
    var_3.angles = var_2;
  }

  var_4 = [];
  var_4["launcher_callout_ally02"] = var_0;
  var_3 maps\_anim::anim_single(var_4, "launcher_callout_ally02");
}

launcher_callout_ally03_spawn() {
  var_0 = maps\_vignette_util::vignette_actor_spawn("launcher_callout_ally03", "launcher_callout_ally03");
  launcher_callout_ally03(var_0);
  var_0 maps\_vignette_util::vignette_actor_delete();
}

launcher_callout_ally03(var_0, var_1, var_2) {
  var_3 = common_scripts\utility::getstruct("vignette_launcher_callout_ally03_node", "script_noteworthy");

  if(isDefined(var_1) && isDefined(var_2)) {
    var_3.origin = var_1;
    var_3.angles = var_2;
  }

  var_4 = [];
  var_4["launcher_callout_ally03"] = var_0;
  var_3 maps\_anim::anim_single(var_4, "launcher_callout_ally03");
}

alley_flood_spawn() {
  alley_flood();
}

alley_flood() {
  var_0 = common_scripts\utility::getstruct("vignette_alley_flood", "script_noteworthy");
  maps\_utility::delaythread(7.5, maps\flood_flooding::alley_flood_collision_cheater, "waterball_path_4");
  maps\_utility::delaythread(8.5, maps\flood_flooding::angry_flood_rumble_loop, "alley_flood_door_rumble_ent");
  var_1 = 0.0;
  thread alley_flood_vehicles_spawn(var_0, var_1);
  thread maps\flood_fx::alley_flood_fx();
  thread maps\flood_fx::alley_flood_water();
}

alley_flood_vehicles_spawn(var_0, var_1) {
  var_2 = maps\_vignette_util::vignette_vehicle_spawn("alley_flood_man7t", "alley_flood_man7t");
  var_3 = maps\_utility::spawn_anim_model("alley_flood_debris");
  var_2 maps\_vehicle::godon();
  var_4 = [];
  var_4["alley_flood_man7t"] = var_2;
  var_4["alley_flood_debris"] = var_3;
  var_5 = getent("alley_flood_rumble_ent", "targetname");
  var_5 common_scripts\utility::delaycall(3.25, ::playrumbleonentity, "heavy_1s");
  var_0 thread maps\_anim::anim_single(var_4, "alley_flood", undefined, 10);
  common_scripts\utility::flag_wait("player_at_stairs_stop_nag");
  var_2 maps\_vehicle::godoff();
  var_2 delete();
  var_3 delete();
}

warehouse_stairs_start_spawn() {
  var_0 = maps\_vignette_util::vignette_actor_spawn("vignette_warehouse_stairs_ally_01", "warehouse_stairs_ally_01");
  var_1 = maps\_vignette_util::vignette_actor_spawn("vignette_warehouse_stairs_ally_02", "warehouse_stairs_ally_02");
  var_2 = maps\_vignette_util::vignette_actor_spawn("vignette_warehouse_stairs_ally_03", "warehouse_stairs_ally_03");
  warehouse_stairs_start(var_0, var_1, var_2);
  var_0 maps\_vignette_util::vignette_actor_delete();
  var_1 maps\_vignette_util::vignette_actor_delete();
  var_2 maps\_vignette_util::vignette_actor_delete();
}

warehouse_stairs_start(var_0, var_1, var_2) {
  var_3 = common_scripts\utility::getstruct("vignette_warehouse_stairs", "script_noteworthy");
  var_4 = [];
  var_4["warehouse_stairs_ally_01"] = var_0;
  var_4["warehouse_stairs_ally_02"] = var_1;
  var_4["warehouse_stairs_ally_03"] = var_2;
  var_3 maps\_anim::anim_single(var_4, "warehouse_stairs_start");
  var_3 maps\_anim::anim_single(var_4, "warehouse_stairs_loop");
  var_3 maps\_anim::anim_single(var_4, "warehouse_stairs_end");
}

flood_mall_roof_door_spawn() {
  var_0 = maps\_vignette_util::vignette_actor_spawn("vignette_mall_roof_door_ally1", "vignette_mall_roof_door_ally1");
  var_1 = maps\_vignette_util::vignette_actor_spawn("vignette_mall_roof_door_ally2", "vignette_mall_roof_door_ally2");
  var_2 = maps\_vignette_util::vignette_actor_spawn("vignette_mall_roof_door_ally3", "vignette_mall_roof_door_ally3");
  flood_mall_roof_door(var_0, var_1, var_2);
  var_0 maps\_vignette_util::vignette_actor_delete();
  var_1 maps\_vignette_util::vignette_actor_delete();
  var_2 maps\_vignette_util::vignette_actor_delete();
}

flood_mall_roof_door(var_0, var_1, var_2, var_3) {
  var_4 = common_scripts\utility::getstruct("mall_breach_origin", "targetname");
  var_5 = [];
  var_5["vignette_mall_roof_door_ally1"] = var_1;
  var_5["vignette_mall_roof_door_ally2"] = var_2;
  var_5["vignette_mall_roof_door_ally3"] = var_0;
  var_5["flood_mall_roof_door_model"] = var_3;
  var_4 maps\_anim::anim_single(var_5, "flood_mall_roof_door");
}

flood_sweptaway() {
  var_0 = common_scripts\utility::getstruct("flood_sweptaway", "script_noteworthy");
  level.player freezecontrols(1);
  level.player allowprone(0);
  level.player allowcrouch(0);
  var_1 = maps\_utility::spawn_anim_model("player_rig");
  var_2 = [];
  var_2["player_rig"] = var_1;
  var_3 = 15;
  level.player playerlinktodelta(var_1, "tag_player", 1, var_3, var_3, var_3, var_3, 1);
  level.player disableweapons();
  var_0 maps\_anim::anim_single(var_2, "flood_sweptaway");
  level.player unlink();
  var_1 delete();
  level.player freezecontrols(0);
  level.player allowprone(1);
  level.player allowcrouch(1);
  level.player enableweapons();
}

sweptaway_spawn() {
  var_0 = maps\_vignette_util::vignette_actor_spawn("swept_opfor_floater", "swept_opfor_floater");
  var_1 = maps\_vignette_util::vignette_actor_spawn("swept_opfor_tree", "swept_opfor_tree");
  var_2 = maps\_vignette_util::vignette_vehicle_spawn("sweptaway_man7t_2", "sweptaway_m880");
  var_3 = maps\_vignette_util::vignette_vehicle_spawn("sweptaway_man7t", "sweptaway_man7t");
  sweptaway(var_0, var_1, var_2, var_3);
  var_0 maps\_vignette_util::vignette_actor_delete();
  var_1 maps\_vignette_util::vignette_actor_delete();
  var_2 maps\_vignette_util::vignette_vehicle_delete();
  var_3 maps\_vignette_util::vignette_vehicle_delete();
}

sweptaway(var_0, var_1, var_2, var_3) {
  var_4 = common_scripts\utility::getstruct("vignette_sweptaway", "script_noteworthy");
  var_5 = maps\_utility::spawn_anim_model("sweptaway_lynx_01");
  var_6 = maps\_utility::spawn_anim_model("sweptaway_lynx_02");
  var_7 = maps\_utility::spawn_anim_model("sweptaway_lynx_03");
  var_8 = maps\_utility::spawn_anim_model("sweptaway_coupe");
  var_9 = maps\_utility::spawn_anim_model("sweptaway_tower_01");
  var_10 = maps\_utility::spawn_anim_model("sweptaway_tower_02");
  var_11 = maps\_utility::spawn_anim_model("sweptaway_tower_03");
  var_12 = maps\_utility::spawn_anim_model("sweptaway_tower_04");
  var_13 = maps\_utility::spawn_anim_model("sweptaway_palm");
  var_14 = maps\_utility::spawn_anim_model("sweptaway_street_sign");
  var_15 = [];
  var_15["swept_opfor_floater"] = var_0;
  var_15["sweptaway_lynx_01"] = var_5;
  var_15["sweptaway_lynx_02"] = var_6;
  var_15["sweptaway_lynx_03"] = var_7;
  var_15["sweptaway_coupe"] = var_8;
  var_15["sweptaway_m880"] = var_2;
  var_15["sweptaway_man7t"] = var_3;
  var_15["sweptaway_tower_01"] = var_9;
  var_15["sweptaway_tower_02"] = var_10;
  var_15["sweptaway_tower_03"] = var_11;
  var_15["sweptaway_tower_04"] = var_12;
  var_15["sweptaway_palm"] = var_13;
  var_15["sweptaway_street_sign"] = var_14;
  playFXOnTag(level._effect["light_car_wide_underwater"], var_5, "tag_headlight_left");
  playFXOnTag(level._effect["light_car_wide_underwater"], var_5, "tag_headlight_right");
  common_scripts\utility::waitframe();
  playFXOnTag(level._effect["lynx_brakelight"], var_5, "tag_brakelight_left");
  playFXOnTag(level._effect["lynx_brakelight"], var_5, "tag_brakelight_right");
  var_4 maps\_anim::anim_single(var_15, "sweptaway");
  var_5 maps\_vignette_util::vignette_vehicle_delete();
  var_6 maps\_vignette_util::vignette_vehicle_delete();
  var_7 maps\_vignette_util::vignette_vehicle_delete();
  var_8 maps\_vignette_util::vignette_vehicle_delete();
  var_10 delete();
  var_12 delete();
  var_13 delete();
  var_14 delete();
}

sweptaway_test() {
  var_0 = common_scripts\utility::getstruct("vignette_sweptaway", "script_noteworthy");
  var_1 = maps\_vignette_util::vignette_actor_spawn("swept_opfor_tree", "swept_opfor_tree");
  var_2 = maps\_utility::spawn_anim_model("sweptaway_coupe");
  var_3 = [];
  var_3["swept_opfor_tree"] = var_1;
  var_3["sweptaway_coupe"] = var_2;
  var_0 maps\_anim::anim_single(var_3, "sweptaway");
}

skybridge_doorbreach_setup() {
  var_0 = common_scripts\utility::getstruct("vignette_skybridge_doorbreach_node", "script_noteworthy");

  if(!isDefined(level.skybridge_door)) {
    var_1 = common_scripts\utility::getstruct("skybridge_doorbreach_struct", "targetname");
    level.skybridge_door = maps\_utility::spawn_anim_model("skybridge_door_breach_door", var_1.origin);
    var_2 = spawn("script_origin", var_1.origin);
    var_2 linkto(level.skybridge_door);
    var_3 = getent("skybridge_doorbreach_clip", "targetname");
    var_3 linkto(var_2);
  }

  var_0 maps\_anim::anim_first_frame_solo(level.skybridge_door, "skybridge_doorbreach");
}

skybridge_doorbreach_spawn() {
  var_0 = common_scripts\utility::getstruct("vignette_skybridge_doorbreach_node", "script_noteworthy");
  level.allies[0] maps\_utility::clear_archetype();

  if(!isDefined(level.skybridge_door)) {
    var_1 = common_scripts\utility::getstruct("skybridge_doorbreach_struct", "targetname");
    level.skybridge_door = maps\_utility::spawn_anim_model("skybridge_door_breach_door", var_1.origin);
    var_2 = spawn("script_origin", var_1.origin);
    var_2 linkto(level.skybridge_door);
    var_3 = getent("skybridge_doorbreach_clip", "targetname");
    var_3 linkto(var_2);
  }

  var_4 = [];
  var_4["ally_0"] = level.allies[0];
  var_4["skybridge_door_breach_door"] = level.skybridge_door;

  if(!level.allies[0] nearnode(getnode("skybridge_breach_node", "targetname")))
    var_0 maps\_anim::anim_reach_solo(level.allies[0], "skybridge_doorbreach");

  thread maps\flood_audio::skybridge_door_bump();
  maps\_utility::delaythread(3.75, common_scripts\utility::flag_set, "skybridge_vo_0");
  var_0 maps\_anim::anim_single(var_4, "skybridge_doorbreach");
  level.allies[0] maps\_utility::disable_turnanims();
  common_scripts\utility::flag_set("skybridge_vo_1");

  if(!common_scripts\utility::flag("vignette_skybridge_approach"))
    level.allies[0] maps\_utility::set_force_color("r");
}

skybridge_ally_approach() {
  level.allies[0] endon("player_on_skybridge");
  level.allies[0] maps\_utility::disable_ai_color();
  level.allies[0] maps\_vignette_util::vignette_actor_ignore_everything();
  var_0 = common_scripts\utility::getstruct("vignette_skybridge_node", "script_noteworthy");
  var_0 maps\_anim::anim_reach_solo(level.allies[0], "skybridge_ally_approach");
  level.allies[0] maps\_utility::enable_turnanims();
  var_0 maps\_anim::anim_single_solo(level.allies[0], "skybridge_ally_approach");
  common_scripts\utility::flag_set("skybridge_vo_2");
  level thread skybridge_restart_player_bridge_loop();
  var_0 thread maps\_anim::anim_loop_solo(level.allies[0], "skybridge_ally_loop", "player_on_skybridge");
}

skybridge_scene_firstframe() {
  thread skybridge_restart_player_bridge_loop();
  var_0 = common_scripts\utility::getstruct("vignette_skybridge_node", "script_noteworthy");

  if(!isDefined(level.skybridge_building))
    level.skybridge_building = maps\_utility::spawn_anim_model("skybridge_building03");

  if(!isDefined(level.skybridge_bus))
    level.skybridge_bus = maps\_utility::spawn_anim_model("skybridge_bus");

  if(!isDefined(level.skybridge_model))
    level.skybridge_model = maps\_utility::spawn_anim_model("sweptaway_skybridge_01");

  var_1 = [];
  var_1["skybridge_building03"] = level.skybridge_building;
  var_1["skybridge_bus"] = level.skybridge_bus;
  var_1["sweptaway_skybridge_01"] = level.skybridge_model;
  var_0 thread maps\_anim::anim_first_frame(var_1, "skybridge_scene");
}

skybridge_scene_spawn() {
  var_0 = common_scripts\utility::getstruct("vignette_skybridge_node", "script_noteworthy");
  var_0 thread skybridge_player_bridge_vignette();

  if(!isDefined(level.skybridge_building))
    level.skybridge_building = maps\_utility::spawn_anim_model("skybridge_building03");

  if(!isDefined(level.skybridge_bus))
    level.skybridge_bus = maps\_utility::spawn_anim_model("skybridge_bus");

  if(!isDefined(level.skybridge_model))
    level.skybridge_model = maps\_utility::spawn_anim_model("sweptaway_skybridge_01");

  var_1 = [];
  var_1["sweptaway_skybridge_01"] = level.skybridge_model;
  var_1["skybridge_building03"] = level.skybridge_building;
  var_1["skybridge_bus"] = level.skybridge_bus;
  var_0 thread maps\_anim::anim_first_frame(var_1, "skybridge_scene");
  common_scripts\utility::flag_wait("skybridge_player_outside");
  thread maps\flood_audio::skybridge_logic();
  var_0 thread maps\_anim::anim_single(var_1, "skybridge_scene");
  common_scripts\utility::wait_for_flag_or_time_elapses("on_skybridge", getanimlength(level.scr_anim["skybridge_building03"]["skybridge_scene"]));

  if(!common_scripts\utility::flag("on_skybridge")) {
    var_0 thread maps\_anim::anim_loop_solo(var_1["sweptaway_skybridge_01"], "flood_skybridge_skybridge_loop", "player_land");
    var_0 thread maps\_anim::anim_loop_solo(var_1["skybridge_building03"], "flood_skybridge_building_loop", "player_land");
  }

  common_scripts\utility::flag_wait("on_skybridge");
  thread maps\flood_audio::skybridge_wash_away();
  var_0 notify("player_land");
  var_1["sweptaway_skybridge_01"] stopanimscripted();
  var_1["skybridge_building03"] stopanimscripted();
  var_0 thread maps\_anim::anim_single_solo(var_1["sweptaway_skybridge_01"], "flood_skybridge_skybridge_part2");
  var_0 thread maps\_anim::anim_single_solo(var_1["skybridge_building03"], "flood_skybridge_building_part2");
}

skybridge_player_bridge_vignette() {
  common_scripts\utility::flag_wait("flood_mid_tr_loaded");
  level thread skybridge_restart_player_bridge_loop(undefined, 1);
  common_scripts\utility::flag_wait("on_skybridge");
  thread skybridge_player_flinch();
  self notify("player_bridge_restart");

  foreach(var_1 in level.skybridge_sections)
  var_1 stopanimscripted();

  foreach(var_4 in level.skybridge_sections)
  thread maps\_anim::anim_first_frame_solo(var_4, "skybridge_break");

  wait 0.866;

  foreach(var_4 in level.skybridge_sections)
  thread maps\_anim::anim_single_solo(var_4, "skybridge_break");

  thread maps\flood_fx::fx_skybridge_event();
}

skybridge_restart_player_bridge_loop(var_0, var_1) {
  if(!isDefined(level.skybridge_sections)) {
    level.skybridge_sections = [];
    level.skybridge_origins = [];
  }

  var_2 = undefined;
  var_3 = 0.0;
  var_4 = common_scripts\utility::getstruct("vignette_skybridge_node", "script_noteworthy");
  var_4 notify("player_bridge_restart");

  if(0 < level.skybridge_sections.size) {
    foreach(var_6 in level.skybridge_sections)
    var_6 stopanimscripted();

    var_4 thread maps\_anim::anim_loop(level.skybridge_sections, "skybridge_sway", "player_bridge_restart");
  } else {
    for(var_8 = 0; var_8 < 3; var_8++) {
      var_9 = common_scripts\utility::getstruct("skybridge_clip_loc_" + var_8, "script_noteworthy");
      level.skybridge_sections[var_8] = maps\_utility::spawn_anim_model("skybridge_sect_" + var_8, var_9.origin);

      if(isDefined(var_1)) {
        level.skybridge_origins[var_8] = spawn("script_origin", var_9.origin);

        switch (var_8) {
          case 0:
            level.skybridge_origins[var_8] linktoblendtotag(level.skybridge_sections[var_8], "j_bridge_001");
            break;
          case 1:
            level.skybridge_origins[var_8] linktoblendtotag(level.skybridge_sections[var_8], "j_bridge_003");
            break;
          case 2:
            level.skybridge_origins[var_8] linktoblendtotag(level.skybridge_sections[var_8], "j_bridge_008");
            break;
        }

        var_10 = getent("skybridge_clip_" + var_8, "targetname");
        var_10 linkto(level.skybridge_origins[var_8]);
      }
    }

    var_4 thread maps\_anim::anim_loop(level.skybridge_sections, "skybridge_sway", "player_bridge_restart");
  }

  if(isDefined(var_0)) {
    waittillframeend;

    for(var_8 = 0; var_8 < level.skybridge_sections.size; var_8++) {
      var_2 = level.scr_anim["skybridge_sect_" + var_8]["skybridge_sway"][0];
      var_3 = getanimlength(var_2);
      level.skybridge_sections[var_8] setanimtime(var_2, (var_3 - var_0) / var_3);
    }
  }
}

skybridge_player_flinch() {
  if(level.player issprinting() || level.player ismeleeing() || level.player isthrowinggrenade())
    level.player hideviewmodel();

  level.player disableweapons();
  level.player freezecontrols(1);
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player allowsprint(0);
  level.player stopsliding();
  level.player setstance("stand");

  while("stand" != level.player getstance())
    wait 0.05;

  var_0 = maps\_utility::spawn_anim_model("player_rig", level.player.origin, level.player.angles);
  var_0 hide();
  var_0 common_scripts\utility::delaycall(0.2, ::show);
  var_1 = [];
  var_1["player_rig"] = var_0;
  level.player playerlinktoblend(var_0, "tag_player", 0.3);
  thread maps\_anim::anim_single(var_1, "skybridge_flinch");
  wait 0.75;
  level.player playrumbleonentity("light_1s");
  wait 0.25;
  level.player playrumbleonentity("heavy_2s");
  wait 0.66;
  level.player unlink();
  var_0 delete();
  level.player freezecontrols(0);
  level.player allowcrouch(1);
  level.player allowsprint(1);
  level.player enableweapons();
  level.player showviewmodel();
  level.player thread maps\flood_rooftops::skybridge_rumble_logic();
}

skybridge_ally_cross(var_0) {
  var_1 = getent("backwards_blocker", "targetname");
  var_1 movez(-416, 0.05);
  var_2 = common_scripts\utility::getstruct("vignette_skybridge_node", "script_noteworthy");
  level.allies[0] notify("player_on_skybridge");
  var_2 notify("player_on_skybridge");
  level.allies[0] stopanimscripted();
  var_3 = getent("ally_in_front_vol", "targetname");

  if(level.allies[0] istouching(var_3))
    var_2 thread maps\_anim::anim_single_solo(level.allies[0], "skybridge_cross_ahead");
  else
    var_2 thread maps\_anim::anim_single_solo(level.allies[0], "skybridge_cross_behind");

  wait 0.75;
  common_scripts\utility::flag_set("skybridge_vo_3");
  level.allies[0] maps\_utility::enable_cqbwalk();
  wait 6.55;
  level.allies[0] vignette_actor_aware_everything();
  level.allies[0] maps\_utility::enable_ai_color();
  level.allies[0] maps\_utility::set_force_color("r");
  common_scripts\utility::flag_set("skybridge_ally_done");
}

rooftops_ally_holdup() {
  self endon("interrupt");
  thread rooftops_ally_holdup_interrupt();
  var_0 = common_scripts\utility::getstruct("ally_hold_01_node", "script_noteworthy");
  var_0 maps\_anim::anim_reach_solo(self, "ally_hold_01");
  var_0 maps\_anim::anim_single_solo(self, "ally_hold_01");
  maps\_utility::set_force_color("r");
  self notify("holdup_complete");
}

rooftops_ally_holdup_interrupt() {
  self endon("holdup_complete");
  common_scripts\utility::flag_wait("rooftops_interior_encounter_start");
  self notify("interrupt");
  self stopanimscripted();
  maps\_utility::set_force_color("r");
}

rooftops_enemy_exfil_setup_heli() {
  var_0 = common_scripts\utility::getstruct("vignette_rooftops_ropeladder_node", "script_noteworthy");
  common_scripts\utility::flag_wait("rooftops_heli_spawned");
  common_scripts\utility::exploder("rooftop1_heli_debri");
  thread maps\flood_audio::sfx_heli_rooftops_sequence(level.rooftop_heli);
  level.rooftop_heli.animname = "rooftops_hind";
  level.rooftops_exfil_anim_guys = [];
  level.rooftops_exfil_anim_guys["rooftops_hind"] = level.rooftop_heli;
  level.rooftops_exfil_anim_guys["rooftops_ropeladder"] = maps\_utility::spawn_anim_model("rooftops_ropeladder");
  level.rooftops_exfil_anim_guys["opfor_0"] = level.rooftop_heli_opfor[0];
  level.rooftops_exfil_anim_guys["opfor_1"] = level.rooftop_heli_opfor[1];
  var_0 thread maps\_anim::anim_loop(level.rooftops_exfil_anim_guys, "rooftops_heli_ropeladder_loop", "exfil_abort");
}

rooftops_enemy_exfil_spawn() {
  common_scripts\utility::flag_wait("rooftops_heli_spawned");
  var_0 = common_scripts\utility::getstruct("vignette_rooftops_ropeladder_node", "script_noteworthy");
  common_scripts\utility::flag_wait("rooftops_exterior_encounter_start");
  wait 0.5;
  var_0 notify("exfil_abort");

  foreach(var_2 in level.rooftops_exfil_anim_guys)
  var_2 stopanimscripted();

  if(!isalive(level.rooftop_heli_opfor[0]))
    level.rooftops_exfil_anim_guys = common_scripts\utility::array_remove(level.rooftops_exfil_anim_guys, level.rooftop_heli_opfor[0]);

  if(!isalive(level.rooftop_heli_opfor[1]))
    level.rooftops_exfil_anim_guys = common_scripts\utility::array_remove(level.rooftops_exfil_anim_guys, level.rooftop_heli_opfor[1]);

  var_0 thread maps\_anim::anim_single(level.rooftops_exfil_anim_guys, "rooftops_heli_ropeladder");
  maps\_utility::stop_exploder("rooftop1_heli_debri");
  wait 2.05;
  level.rooftop_heli_opfor[1] notify("fight");
  wait 9.1;

  foreach(var_5 in level.rooftops_exfil_anim_guys) {
    if(isDefined(var_5) && (issubstr("vehicle", var_5.classname) || issubstr("vehicle", var_5.classname)))
      var_5 delete();
  }
}

rooftops_heli_ropeladder_cleanup(var_0) {
  var_0 thread maps\_vignette_util::vignette_actor_kill();
}

rooftops_enemy_exfil_spawn_actors(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_0[var_1].script_forcespawn = 1;
    level.rooftop_heli_opfor[var_1] = var_0[var_1] maps\_utility::spawn_ai();
    level.rooftop_heli_opfor[var_1].animname = "opfor_" + var_1;
    level.rooftop_heli_opfor[var_1].health = 1;
    level.rooftop_heli_opfor[var_1].allowdeath = 1;

    if(!isDefined(var_0[var_1].script_noteworthy))
      level.rooftop_heli_opfor[var_1].ragdoll_immediate = 1;
  }
}

rooftops_outro_scene_setup() {
  common_scripts\utility::flag_wait("flood_mid_tr_loaded");
  var_0 = common_scripts\utility::getstruct("vignette_rooftops_outro", "script_noteworthy");
  level.rooftop_outro_props["rooftops_brickwall"] = maps\_utility::spawn_anim_model("rooftops_brickwall");
  var_0 maps\_anim::anim_first_frame(level.rooftop_outro_props, "rooftops_wall_kick");
}

rooftops_outro_scene_spawn() {
  var_0 = common_scripts\utility::getstruct("vignette_rooftops_outro", "script_noteworthy");
  var_1 = [];
  var_1["rooftops_brickwall"] = level.rooftop_outro_props["rooftops_brickwall"];
  var_1["ally_0"] = level.allies[0];
  var_0 maps\_anim::anim_reach_solo(level.allies[0], "rooftops_wall_kick");
  level.rooftop_outro_props["rooftops_brickwall"] thread maps\flood_audio::sfx_rooftops_wall_kick();
  thread maps\flood_fx::fx_rooftops_wall_kick();
  var_0 maps\_anim::anim_single(var_1, "rooftops_wall_kick");
  var_0 thread maps\_anim::anim_loop_solo(level.allies[0], "rooftops_idle_loop_1", "push_forward");
  common_scripts\utility::flag_wait("rooftops_vo_check_drop");
  common_scripts\utility::flag_wait_any("player_in_sight_of_ally", "rooftops_player_dropped_down", "rooftops_player_pushing");
  var_0 notify("push_forward");
  level.allies[0] thread maps\flood_audio::sfx_rooftops_ally_jumpdown();
  var_0 maps\_anim::anim_single_solo(level.allies[0], "rooftops_traversal_01");
  level.allies[0] maps\_utility::disable_turnanims();
  level.allies[0] maps\_utility::set_force_color("r");
}

rooftops_water_long_jump_spawn() {
  var_0 = common_scripts\utility::getstruct("rooftops_water_long_jump", "targetname");
  var_0 maps\_anim::anim_reach_solo(level.allies[0], "rooftops_water_long_jump");
  level.allies[0] thread maps\flood_audio::sfx_rooftops_ally_jump();
  var_0 maps\_anim::anim_single_solo(level.allies[0], "rooftops_water_long_jump");

  if(common_scripts\utility::flag("rooftops_water_player_followed"))
    var_0 maps\_anim::anim_single_solo(level.allies[0], "rooftops_water_stumble_and_jump");
  else {
    var_0 maps\_anim::anim_single_solo(level.allies[0], "rooftops_water_approach_stumble");

    if(!common_scripts\utility::flag("rooftops_water_player_followed")) {
      var_0 thread maps\_anim::anim_loop_solo(level.allies[0], "rooftops_water_approach_loop", "player_followed");
      common_scripts\utility::flag_wait("rooftops_water_player_followed");
      var_0 notify("player_followed");
      level.allies[0] stopanimscripted();
    }

    var_0 maps\_anim::anim_single_solo(level.allies[0], "rooftops_water_approach_jump");
  }

  level.allies[0] maps\_utility::enable_turnanims();
  level.allies[0] maps\_utility::set_force_color("r");
}

rooftops_water_intro_spawn_actors(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_0[var_1].script_forcespawn = 1;
    var_2 = var_0[var_1] maps\_utility::spawn_ai();
    var_2.animname = "opfor_" + var_1;
    var_2.health = 1;
    var_2.allowdeath = 1;

    if(var_2.target == "truck_reveal_a")
      var_2.ragdoll_immediate = 1;

    var_2.ignoreme = 1;
    level.rooftops_water_opfor[var_1] = var_2;
  }
}

rooftops_water_intro() {
  thread rooftops_water_intro_flare_scene();
  thread rooftops_water_intro_truck_scene();
}

rooftops_water_intro_flare_scene() {
  var_0 = common_scripts\utility::getstruct("vignette_opfor_waving_flares", "script_noteworthy");
  var_1 = [];
  var_1["opfor_1"] = level.rooftops_water_opfor[1];
  var_1["flare_left_01"] = maps\_utility::spawn_anim_model("flare_left_01");
  var_1["flare_right_01"] = maps\_utility::spawn_anim_model("flare_right_01");
  level.rooftops_water_opfor[1] thread maps\flood_rooftops::rooftops_water_intro_flare_setup(var_1["flare_left_01"], var_1["flare_right_01"]);
  level.rooftops_water_opfor[1] thread maps\flood_rooftops::rooftops_water_intro_flare_actor_cleanup();
  var_0 thread maps\_anim::anim_loop(var_1, "rooftops_water_reveal_flare", "spotted");
  common_scripts\utility::flag_wait("rooftops_water_encounter_start");
  level common_scripts\utility::waittill_notify_or_timeout("firing_at_player", 5.0);
  var_0 notify("spotted");

  if(isalive(level.rooftops_water_opfor[1])) {
    level.rooftops_water_opfor[1] stopanimscripted();
    level.rooftops_water_opfor[1].health = 150;
    level.rooftops_water_opfor[1].ignoreme = 0;
    level.rooftops_water_opfor[1] notify("fight");
  }

  common_scripts\utility::flag_set("rooftops_water_flare_intro_done");
}

rooftops_water_intro_truck_scene() {
  var_0 = common_scripts\utility::getstruct("vignette_rooftops_02_encounter_node", "script_noteworthy");
  var_1 = [];
  var_1["opfor_0"] = level.rooftops_water_opfor[0];
  var_0 thread maps\_anim::anim_first_frame(var_1, "rooftops_water_reveal");
  common_scripts\utility::flag_wait("rooftops_water_encounter_start");
  var_0 thread maps\_anim::anim_single(var_1, "rooftops_water_reveal");
  wait 0.05;
  var_2 = randomfloat(1.0);
  wait(3.05 + var_2);
  level notify("firing_at_player");
  wait(3.266 - var_2);

  foreach(var_4 in var_1) {
    if(isalive(var_4)) {
      var_4.health = 150;
      var_4.ignoreme = 0;
      var_4.ragdoll_immediate = 0;
      var_4 notify("fight");
    }
  }

  common_scripts\utility::flag_set("rooftops_water_truck_intro_done");
}

debris_bridge_spawn() {
  level.debris_props = [];
  var_0 = debris_bridge_loop1();
  common_scripts\utility::flag_wait("vignette_debris_bridge_vign1_flag");
  thread maps\flood_audio::debris_bridge_sfx();
  level thread debris_bridge_vign2_and_loop3_ally();
  var_0 = debris_bridge_vign1_and_loop2(var_0);
  debris_bridge_vign2_and_loop3(var_0);
}

debris_bridge_loop1() {
  var_0 = common_scripts\utility::getstruct("vignette_debris_bridge_node", "script_noteworthy");
  var_1 = [];
  var_1[var_1.size] = maps\_utility::spawn_anim_model("debris_debrissmall");
  var_1[var_1.size] = maps\_utility::spawn_anim_model("debris_wall");
  var_1[var_1.size] = maps\_utility::spawn_anim_model("debris_movingtruck");
  var_1[var_1.size] = maps\_utility::spawn_anim_model("debris_vanblue");
  var_1[var_1.size] = maps\_utility::spawn_anim_model("debris_00");
  level.debris_props = var_1;
  var_0 thread maps\_anim::anim_loop(var_1, "debris_bridge_loop1", "pile_up");
  var_0 thread maps\_anim::anim_first_frame(maps\_utility::make_array(var_1[1]), "debris_bridge_vign1");
  return var_1;
}

debris_bridge_vign1_and_loop2(var_0) {
  var_1 = common_scripts\utility::getstruct("vignette_debris_bridge_node", "script_noteworthy");
  var_1 notify("pile_up");
  level.debrisbridge_origins = [];
  var_2 = [];
  var_2[var_2.size] = "debris_bus";
  var_2[var_2.size] = "debris_cargocontainer";
  var_2[var_2.size] = "debris_coupeblue";
  var_2[var_2.size] = "debris_coupedeepblue";
  var_2[var_2.size] = "debris_vangold";
  var_2[var_2.size] = "debris_coupegreen";
  var_2[var_2.size] = "debris_macktruck";
  var_2[var_2.size] = "debris_subcompgreen";
  var_2[var_2.size] = "debris_truckbm21";
  var_2[var_2.size] = "debris_utiltruck";
  var_2[var_2.size] = "debris_vangreen";
  var_2[var_2.size] = "debris_01";
  var_2[var_2.size] = "debris_02";
  var_2[var_2.size] = "debris_antenna";

  foreach(var_4 in var_2) {
    if("debris_vangreen" == var_4 || "debris_01" == var_4) {
      if("debris_vangreen" == var_4)
        var_5 = 14;
      else
        var_5 = 15;

      var_6 = common_scripts\utility::getstruct("debrisbridge_struct_" + var_5, "script_noteworthy");
      var_7 = maps\_utility::spawn_anim_model(var_4, var_6.origin);
      var_8 = spawn("script_origin", var_6.origin);
      var_9 = getent("debrisbridge_prop_" + var_5, "targetname");
      var_8 linkto(var_7);
      var_9 linkto(var_8);
      var_0[var_0.size] = var_7;
      level.debrisbridge_origins[level.debrisbridge_origins.size] = var_8;
      continue;
    }

    var_0[var_0.size] = maps\_utility::spawn_anim_model(var_4);
  }

  level.debris_props = var_0;
  level thread maps\flood_rooftops::debrisbridge_hide_glass_parts(var_0);
  level thread maps\flood_rooftops::debrisbridge_wall_break_logic();
  maps\_utility::delaythread(24, maps\flood_util::jkuprint, "debrisbridge soft ready");
  maps\_utility::delaythread(24, common_scripts\utility::flag_set, "debrisbridge_soft_ready");
  var_1 maps\_anim::anim_single(var_0, "debris_bridge_vign1");
  common_scripts\utility::flag_set("debrisbridge_ready");
  var_0[0] delete();
  var_0 = common_scripts\utility::array_removeundefined(var_0);
  var_11 = var_0[0];
  var_0 = common_scripts\utility::array_remove(var_0, var_11);
  var_0["debris_clip"] = maps\_utility::spawn_anim_model("debris_clip");
  var_1 maps\_anim::anim_first_frame_solo(var_0["debris_clip"], "debris_bridge_vign1");
  var_12 = getent("debrisbridge_clip_all", "targetname");
  var_12 linkto(var_0["debris_clip"]);
  var_1 thread maps\_anim::anim_loop(var_0, "debris_bridge_loop2", "bridge_crossing");
  level thread debris_bridge_cleanup(var_0);
  return var_0;
}

debris_bridge_final_loop() {
  var_0 = common_scripts\utility::getstruct("vignette_debris_bridge_node", "script_noteworthy");
  var_1 = [];
  var_1[var_1.size] = maps\_utility::spawn_anim_model("debris_movingtruck");
  var_1[var_1.size] = maps\_utility::spawn_anim_model("debris_vanblue");
  var_1[var_1.size] = maps\_utility::spawn_anim_model("debris_00");
  var_1[var_1.size] = maps\_utility::spawn_anim_model("debris_bus");
  var_1[var_1.size] = maps\_utility::spawn_anim_model("debris_cargocontainer");
  var_1[var_1.size] = maps\_utility::spawn_anim_model("debris_coupeblue");
  var_1[var_1.size] = maps\_utility::spawn_anim_model("debris_coupedeepblue");
  var_1[var_1.size] = maps\_utility::spawn_anim_model("debris_vangold");
  var_1[var_1.size] = maps\_utility::spawn_anim_model("debris_coupegreen");
  var_1[var_1.size] = maps\_utility::spawn_anim_model("debris_macktruck");
  var_1[var_1.size] = maps\_utility::spawn_anim_model("debris_subcompgreen");
  var_1[var_1.size] = maps\_utility::spawn_anim_model("debris_truckbm21");
  var_1[var_1.size] = maps\_utility::spawn_anim_model("debris_utiltruck");
  var_1[var_1.size] = maps\_utility::spawn_anim_model("debris_vangreen");
  var_1[var_1.size] = maps\_utility::spawn_anim_model("debris_01");
  var_1[var_1.size] = maps\_utility::spawn_anim_model("debris_02");
  var_1[var_1.size] = maps\_utility::spawn_anim_model("debris_antenna");
  var_0 thread maps\_anim::anim_loop(var_1, "debris_bridge_loop2", "bridge_crossing");
  level thread debris_bridge_cleanup(var_1);
}

debris_bridge_vign2_and_loop3(var_0) {
  var_1 = common_scripts\utility::getstruct("vignette_debris_bridge_node", "script_noteworthy");
  var_1 notify("bridge_crossing");

  foreach(var_3 in var_0)
  var_3 stopanimscripted();

  waittillframeend;
  var_1 thread maps\_anim::anim_loop(var_0, "debris_bridge_loop2");
  level thread debris_bridge_cleanup(var_0);
  level thread maps\flood_rooftops::debrisbridge_crossing();
}

debris_bridge_vign2_and_loop3_ally() {
  var_0 = common_scripts\utility::getstruct("vignette_debris_bridge_node", "script_noteworthy");
  common_scripts\utility::flag_wait_all("debrisbridge_ally_0_ready", "debrisbridge_ally_1_ready");
  var_0 notify("move_across");

  foreach(var_2 in level.allies) {
    if(2 != var_2.debrisbridge_loc)
      var_2 stopanimscripted();
  }

  var_4 = undefined;

  foreach(var_2 in level.allies) {
    if(2 == var_2.debrisbridge_loc) {
      var_4 = var_2;
      var_4.ignoreall = 1;
      continue;
    }

    var_2 thread debris_bridge_actor_vign_and_transition_to_combat(var_0);
  }

  wait 1.0;
  common_scripts\utility::flag_set("debrisbridge_vo_1");
  wait 7.666;
  var_4.ignoreall = 0;
  var_4.ignoresuppression = 0;

  while(!common_scripts\utility::flag("debrisbridge_player_advancing"))
    wait 4.333;

  var_0 notify("move_across_late");
  var_4 stopanimscripted();
  var_4 thread debris_bridge_actor_vign_and_transition_to_combat(var_0);
}

debris_bridge_actor_vign_and_transition_to_combat(var_0) {
  level endon("garage_done");
  self.ondebrisbridge = 1;
  self.ignoreall = 1;
  maps\flood_util::jkuprint(self.animname + " why so slow " + gettime());

  if(isalive(level.db_faux_enemy))
    level.db_faux_enemy freeentitysentient();

  var_0 maps\_anim::anim_reach_solo(self, "debrisbridge_loop" + self.debrisbridge_loc);
  var_0 maps\_anim::anim_single_solo(self, "debris_bridge_vign2_loc" + self.debrisbridge_loc);
  self.maxfaceenemydist = self.og_facedist;
  vignette_actor_aware_everything();
  maps\_utility::enable_ai_color();
  self.ondebrisbridge = 0;

  switch (self.animname) {
    case "ally_0":
      if(!isDefined(self.garage_teleported))
        thread maps\flood_garage::ally_garage_sneak("r", "garage_ally0_cover_crouch", "r_end_node");

      break;
    case "ally_1":
      if(!isDefined(self.garage_teleported))
        thread maps\flood_garage::ally_garage_sneak("y", "garage_ally1_cover_crouch", "y_end_node");

      break;
    case "ally_2":
      if(!isDefined(self.garage_teleported))
        thread maps\flood_garage::ally_garage_sneak("g", "garage_ally2_cover_crouch", "g_end_node");

      break;
    default:
  }
}

debris_bridge_cleanup(var_0) {
  common_scripts\utility::flag_wait("ending_transient_trigger");

  foreach(var_2 in var_0) {
    if(isDefined(var_2))
      var_2 delete();
  }
}

garage_jump_01_spawn() {
  var_0 = maps\_vignette_util::vignette_actor_spawn("garage_jump_01_opfor", "garage_jump_01_opfor");
  garage_jump_01(var_0);
  var_0 maps\_vignette_util::vignette_actor_delete();
}

garage_jump_01(var_0) {
  var_1 = common_scripts\utility::getstruct("vignette_garage_jump_01", "script_noteworthy");
  var_2 = [];
  var_2["garage_jump_01_opfor"] = var_0;
  var_1 maps\_anim::anim_single(var_2, "garage_jump_01");
}

garage_jump_02_spawn() {
  var_0 = maps\_vignette_util::vignette_actor_spawn("garage_jump_02_opfor", "garage_jump_02_opfor");
  garage_jump_02(var_0);
  var_0 maps\_vignette_util::vignette_actor_delete();
}

garage_jump_02(var_0) {
  var_1 = common_scripts\utility::getstruct("vignette_garage_jump_02", "script_noteworthy");
  var_2 = [];
  var_2["garage_jump_02_opfor"] = var_0;
  var_1 maps\_anim::anim_single(var_2, "garage_jump_02");
}

rooftops_traversal_01_spawn() {
  var_0 = common_scripts\utility::getstruct("vignette_rooftops_traversal_01", "script_noteworthy");
  var_0 maps\_anim::anim_single(maps\_utility::make_array(level.allies[0]), "rooftops_traversal_01");
}

rooftops_traversal_02_spawn() {}

rooftops_traversal_02(var_0) {
  var_1 = common_scripts\utility::getstruct("rooftops_traversal_02_ally_node", "script_noteworthy");
  var_2 = [];
  var_2["rooftops_traversal_02_ally"] = var_0;
  var_1 maps\_anim::anim_single(var_2, "rooftops_traversal_02");
}

rooftops_traversal_03_spawn() {}

rooftops_traversal_03(var_0) {
  var_1 = common_scripts\utility::getstruct("rooftops_traversal_03_ally_node", "script_noteworthy");
  var_2 = [];
  var_2["rooftops_traversal_03_ally"] = var_0;
  var_1 maps\_anim::anim_single(var_2, "rooftops_traversal_03");
}

attach_fx_anim_model(var_0, var_1, var_2, var_3) {
  var_4 = var_0 gettagorigin(var_2);
  var_5 = var_0 gettagangles(var_2);
  var_6 = spawn("script_model", var_4);
  var_6.angles = var_5;
  var_6.origin = var_4;
  var_6 setModel(var_1);
  var_6 linkto(var_0, var_2);

  if(isDefined(var_3))
    var_6.script_noteworthy = var_3;

  return var_6;
}

ending_animatic_setup() {
  common_scripts\utility::flag_wait("flood_end_tr_loaded");
  wait 0.05;
  level.ending_door_l = maps\_utility::spawn_anim_model("ending_breach_door_l");
  level.ending_door_r = maps\_utility::spawn_anim_model("ending_breach_door_r");
  level.ending_heli = maps\_utility::spawn_anim_model("outro_pt1_heli");
  var_0 = getent("nh90_collision", "targetname");
  var_0 linkto(level.ending_heli);
  level.ending_hvt = maps\_vignette_util::vignette_actor_spawn("garcia_spawner", "generic");
  level.ending_hvt maps\_utility::gun_remove();
  level.ending_opfor_0 = maps\_vignette_util::vignette_actor_spawn("vignette_ending_opfor01", "opfor_0");
  level.ending_opfor_0 maps\_utility::stop_magic_bullet_shield();
  level.ending_opfor_0 maps\_utility::gun_remove();
  level.ending_opfor_0.nodrop = 1;
  level.ending_opfor_0.health = 5;
  level.ending_opfor_0.allowdeath = 1;
  level.ending_opfor_1 = maps\_vignette_util::vignette_actor_spawn("vignette_ending_opfor02", "opfor_1");
  level.ending_opfor_1 maps\_utility::stop_magic_bullet_shield();
  level.ending_opfor_1 maps\_utility::gun_remove();
  level.ending_opfor_1.nodrop = 1;
  level.ending_opfor_1.health = 5;
  level.ending_opfor_1.allowdeath = 1;
  level.ending_opfor_2 = maps\_vignette_util::vignette_actor_spawn("vignette_outro_opfor03", "opfor_2");
  level.ending_opfor_2 maps\_utility::stop_magic_bullet_shield();
  level.ending_opfor_2.nodrop = 1;
  level.ending_opfor_2.health = 5;
  level.ending_opfor_2.allowdeath = 1;
  level.ending_opfor_3 = maps\_vignette_util::vignette_actor_spawn("vignette_outro_pilot", "opfor_3");
  level.ending_opfor_3 maps\_utility::gun_remove();
  level.ending_opfor_3.nodrop = 1;
  level.outro_node = common_scripts\utility::getstruct("vignette_outro", "script_noteworthy");
  level.outro_node maps\_anim::anim_first_frame(maps\_utility::make_array(level.ending_door_l, level.ending_door_r, level.ending_opfor_0, level.ending_opfor_1, level.ending_opfor_2), "outro_pt1_breach");
  level.outro_node maps\_anim::anim_first_frame_solo(level.ending_heli, "outro_pt1_heli");
  level.outro_node maps\_anim::anim_first_frame(maps\_utility::make_array(level.ending_opfor_0, level.ending_opfor_1), "outro_pt1_start");
  level.outro_node maps\_anim::anim_first_frame_solo(level.ending_opfor_2, "outro_pt1_melee_vargas");
  level.outro_node maps\_anim::anim_first_frame_solo(level.ending_opfor_3, "outro_pt1_pilot_kill");
  level.outro_node maps\_anim::anim_first_frame_solo(level.ending_hvt, "outro_pt1_garcia_punch");
  level.ending_opfor_3 hide();
  level.ending_hvt hide();
  maps\_utility::battlechatter_off("axis");
  maps\_utility::battlechatter_off("allies");
  var_1 = getEntArray("upper_garage_door_l", "targetname");

  foreach(var_3 in var_1)
  var_3 linkto(level.ending_door_l);

  var_1 = getEntArray("upper_garage_door_r", "targetname");

  foreach(var_3 in var_1)
  var_3 linkto(level.ending_door_r);

  common_scripts\utility::flag_set("ending_anims_ready");
}

ending_pt1_heli() {
  var_0 = [];
  var_0["outro_pt1_heli"] = self;
  thread maps\flood_fx::end_heli_treadfx();
  level.outro_node maps\_anim::anim_single(var_0, "outro_pt1_heli");
}

ending_breach_spawn() {
  common_scripts\utility::flag_wait("ending_anims_ready");

  if(level.player issprinting() || level.player ismeleeing() || level.player isthrowinggrenade())
    level.player hideviewmodel();

  level.player disableweapons();
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player allowsprint(0);
  level.player allowjump(0);
  level.player setstance("stand");

  while("stand" != level.player getstance())
    wait 0.05;

  common_scripts\utility::flag_set("player_entering_final_area");
  maps\_utility::autosave_by_name_silent("ending_breach");
  level.g_friendlynamedist_old = getdvarint("g_friendlyNameDist");
  setsaveddvar("g_friendlyNameDist", 0);
  level.ending_heli thread ending_pt1_heli();
  level.allies[1] thread ending_pt1_ally_1_sequence();
  level.player thread maps\flood_ending::heli_jump_fire_fail();
  level.player thread maps\flood_ending::ending_player_reach_final_sequence();
  level.player thread maps\flood_ending::ending_lower_raise_weapon_logic();
  level.player thread maps\flood_ending::ending_rush_vo();
  var_0 = maps\_utility::spawn_anim_model("player_rig");
  var_1 = [];
  var_1["opfor_0"] = level.ending_opfor_0;
  var_1["opfor_1"] = level.ending_opfor_1;
  var_1["opfor_2"] = level.ending_opfor_2;
  var_1["ending_breach_door_l"] = level.ending_door_l;
  var_1["ending_breach_door_r"] = level.ending_door_r;
  var_1["player_rig"] = var_0;
  level.player playerlinktoblend(var_0, "tag_player", 0.2, 0.1, 0.1);
  var_2 = "outro_pt1_breach";
  level.outro_node thread maps\_anim::anim_single(var_1, var_2);
  level.outro_node waittill(var_2);
  common_scripts\utility::flag_set("ending_vo_1");
  level.player showviewmodel();
  level.player unlink();
  level.player allowcrouch(1);
  level.player allowprone(1);
  level.player allowsprint(1);
  level.player allowjump(1);
  level.player enableweapons();
  var_0 delete();
  level.player thread maps\flood_ending::final_sequence_fail_condition();
}

ending_pt1_allies_sequence_start(var_0) {
  common_scripts\utility::flag_wait("ending_anims_ready");
  thread maps\flood_audio::play_helicopter_leaving_sound();

  foreach(var_2 in level.allies) {
    var_2 maps\_utility::disable_ai_color();
    var_2 maps\_vignette_util::vignette_actor_ignore_everything();
  }

  var_4 = [];
  var_4["ally_0"] = level.allies[0];
  var_4["ally_1"] = level.allies[1];
  var_5 = "outro_pt1_breach";
  level.outro_node thread maps\_anim::anim_single(var_4, var_5);
  maps\_utility::music_play("mus_flood_exfil_chase_ss", 0.2);
  level.allies[0] thread ending_pt1_ally_0_sequence();
  level.allies[1] thread ending_pt1_ally_1_sequence();
}

ending_pt1_ally_0_sequence() {
  common_scripts\utility::flag_wait("ending_anims_ready");
  var_0 = maps\_utility::make_array(self, level.ending_opfor_1);
  common_scripts\utility::flag_wait("vignette_ending_scene_start");

  foreach(var_2 in var_0) {
    var_2 stopanimscripted();
    var_2 linkto(level.ending_heli);
  }

  maps\_utility::gun_remove();
  level.allies[0] maps\_utility::gun_remove();
  var_4 = "outro_pt1_start_loop_price";
  level.ending_heli thread maps\_anim::anim_loop(var_0, var_4, "player_passed_first_action", "tag_origin");
  common_scripts\utility::flag_wait("vignette_ending_qte_success");
  level.ending_heli notify("player_passed_first_action");
}

ending_pt1_ally_1_sequence() {
  common_scripts\utility::flag_wait("ending_anims_ready");
  var_0 = maps\_utility::make_array(self, level.ending_opfor_0, level.ending_opfor_2);
  common_scripts\utility::flag_wait("vignette_ending_scene_start");

  foreach(var_2 in var_0) {
    var_2 stopanimscripted();
    var_2 linkto(level.ending_heli);
  }

  maps\_utility::gun_remove();
  var_0 = common_scripts\utility::array_remove(var_0, level.ending_opfor_0);
  var_4 = "outro_pt1_melee_vargas";
  var_5 = maps\_utility::getanim(var_4);
  var_6 = getanimlength(var_5);
  level.ending_heli thread maps\_anim::anim_single(var_0, var_4, "tag_origin");
  common_scripts\utility::flag_wait_or_timeout("vignette_ending_qte_success", var_6);

  if(!common_scripts\utility::flag("vignette_ending_qte_success")) {
    level.ending_heli maps\_anim::anim_last_frame_solo(self, var_4, "tag_origin");
    level.ending_heli maps\_anim::anim_last_frame_solo(level.ending_opfor_2, var_4, "tag_origin");
    return;
  }

  level.ending_opfor_3 show();
  level.ending_opfor_3 linkto(level.ending_heli);
  var_0["opfor_3"] = level.ending_opfor_3;
  var_4 = "outro_pt1_pilot_kill";
  level.ending_heli thread maps\_anim::anim_single(var_0, var_4, "tag_origin");
  level.ending_heli waittill(var_4);
  level.ending_heli maps\_anim::anim_last_frame_solo(self, var_4, "tag_origin");
  self hide();
  level.ending_opfor_2 maps\_vignette_util::vignette_actor_kill();
  level.ending_opfor_2 hide();
}

ending_pt1_player_sequence_start() {
  if(level.player isthrowinggrenade())
    level.player hideviewmodel();

  level.player disableweapons();
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player allowsprint(0);
  level.player allowjump(0);
  setsaveddvar("compass", 0);
  setsaveddvar("ammoCounterHide", 1);
  setsaveddvar("actionSlotsHide", 1);
  setsaveddvar("hud_showStance", 0);
  level.ending_arms = maps\_utility::spawn_anim_model("player_rig");
  level.ending_arms hide();
  level.ending_arms linkto(level.ending_heli);
  level.player thread maps\flood_ending::ending_player_camera_logic();
  level.player thread maps\flood_ending::ending_player_qte_0_logic();
  level.player thread maps\flood_ending::ending_player_weapon_logic();
  var_0 = "outro_pt1_melee_player";
  level.ending_heli thread maps\_anim::anim_single_solo(level.ending_arms, var_0, "tag_origin");
  thread maps\flood_fx::set_vf_end1();
  wait 0.3;
  level.ending_arms show();
}

ending_pt1_scene_start(var_0) {
  common_scripts\utility::flag_set("vignette_ending_scene_start");
}

ending_qte_0_start(var_0) {
  level.player notify("qte_0_start");
}

ending_pt1_sequence() {
  level.ending_gun = maps\_utility::spawn_anim_model("outro_gun_player");
  level.enemy_gun = maps\_utility::spawn_anim_model("outro_gun_garcia");
  var_0 = [];
  common_scripts\utility::flag_clear("vignette_ending_qte_success");
  level.player thread maps\flood_ending::ending_player_land_on_heli_effects();
  level.ending_gun linkto(level.ending_heli);
  level.ending_opfor_0 linkto(level.ending_heli);
  var_0["outro_gun_player"] = level.ending_gun;
  var_0["opfor_0"] = level.ending_opfor_0;
  var_1 = "outro_pt1_melee_player";
  var_2 = level.ending_gun maps\_utility::getanim(var_1);
  var_3 = getanimlength(var_2);
  level.ending_heli thread maps\_anim::anim_single(var_0, var_1, "tag_origin");
  common_scripts\utility::flag_wait_or_timeout("vignette_ending_qte_success", var_3);
  level.player notify("qte_0_fail");
  var_0["player_rig"] = level.ending_arms;

  if(!common_scripts\utility::flag("vignette_ending_qte_success")) {
    var_1 = "outro_pt1_melee_fail";
    level.ending_heli thread maps\_anim::anim_single(var_0, var_1, "tag_origin");
    level.ending_heli waittill(var_1);
    level.ending_heli maps\_anim::anim_last_frame_solo(level.ending_opfor_0, var_1, "tag_origin");
    return;
  }

  level.ending_hvt show();
  level.ending_hvt linkto(level.ending_heli);
  level.ending_gun stopanimscripted();
  level.ending_gun unlink();
  level.ending_gun linkto(level.ending_arms, "tag_knife_attach2");
  var_0 = common_scripts\utility::array_remove(var_0, level.ending_gun);
  var_0["ally_0"] = level.allies[0];
  var_0["opfor_1"] = level.ending_opfor_1;
  var_0["generic"] = level.ending_hvt;
  var_1 = "outro_pt1_garcia_punch";
  maps\_utility::delaythread(1.2, common_scripts\utility::flag_set, "ending_vo_3");
  level.ending_heli thread maps\_anim::anim_single(var_0, var_1, "tag_origin");
  level.ending_heli waittill(var_1);
  level.ending_opfor_0 maps\_vignette_util::vignette_actor_kill();
  level.ending_opfor_0 hide();
  level.enemy_gun.origin = level.ending_hvt gettagorigin("TAG_INHAND");
  level.enemy_gun.angles = level.ending_hvt gettagangles("TAG_INHAND");
  level.enemy_gun linkto(level.ending_hvt, "TAG_INHAND");
  common_scripts\utility::flag_clear("vignette_ending_qte_success");
  var_0 = common_scripts\utility::array_remove(var_0, level.ending_opfor_0);
  var_0["opfor_3"] = level.ending_opfor_3;
  var_1 = "outro_pt1_garcia_kill_pt1";
  level.player thread maps\flood_ending::ending_price_gets_capped(level.allies[1]);
  level.ending_heli thread maps\_anim::anim_single(var_0, var_1, "tag_origin");
  common_scripts\utility::flag_wait_any("vignette_ending_qte_success", "vignette_ending_qte_failure");

  if(!common_scripts\utility::flag("vignette_ending_qte_success")) {
    if(!common_scripts\utility::flag("already_failing")) {
      common_scripts\utility::flag_set("already_failing");
      setDvar("ui_deadquote", &"FLOOD_ENDING_QTE_0_FAILED");
      level maps\_utility::missionfailedwrapper();
    }

    level.ending_heli maps\_utility::delaythread(1.0, maps\_anim::anim_set_time, maps\_utility::make_array(level.ending_hvt), var_1, 0.8);
    level.ending_heli maps\_utility::delaythread(1.0, maps\_anim::anim_set_time, maps\_utility::make_array(level.allies[0]), var_1, 0.9);
    return;
  }

  level.allies[1] show();
  var_0["ally_1"] = level.allies[1];
  level.ending_hvt stopanimscripted();
  level.player common_scripts\utility::delaycall(0.4, ::disableweapons);
  level.allies[0] maps\_utility::delaythread(1.0, maps\_utility::smart_dialogue, "flood_mrk_weregoingdown");
  level.allies[0] maps\_utility::delaythread(2.5, maps\_utility::smart_dialogue, "flood_oby_holdon");
  var_1 = "outro_pt1_crash";
  level thread maps\flood_ending::ending_shake_effects();
  level.ending_heli thread maps\_anim::anim_single(var_0, var_1, "tag_origin");
  level.ending_heli waittill(var_1);
  stopallrumbles();
  level.player notify("earthquake_end");
  level.ending_gun delete();
  level.enemy_gun delete();
  level.allies[2] maps\_vignette_util::vignette_actor_kill();
  level.ending_opfor_0 maps\_vignette_util::vignette_actor_kill();
  level.ending_opfor_1 maps\_vignette_util::vignette_actor_kill();
  level.ending_opfor_2 maps\_vignette_util::vignette_actor_kill();
  level.ending_opfor_3 maps\_vignette_util::vignette_actor_kill();
  level.ending_opfor_1 delete();
  level.ending_opfor_3 delete();
  level.ending_heli delete();
  common_scripts\utility::flag_set("vignette_ending_crash_flag");
}

ending_player_hvt_aim() {}

ending_harmless_shots_logic(var_0) {
  level.ending_arms endon("shot_window_done");
  var_1 = "outro_pt1_garcia_punch";
  var_2 = level.ending_arms maps\_utility::getanim(var_1);
  var_3 = getanimlength(var_2);
  var_4 = getnotetracktimes(var_2, "player_can_fire");
  var_5 = getnotetracktimes(var_2, "slowmo_end");
  level.ending_arms thread maps\_utility::notify_delay("shot_window_done", var_3 * (var_5[0] - var_4[0]));
  level.ending_gun thread common_scripts\utility::delaycall(0.5 + var_3 * (var_5[0] - var_4[0]), ::linkto, level.ending_arms, "tag_knife_attach");

  for(;;) {
    while(!level.player attackbuttonpressed())
      wait 0.05;

    level.player thread ending_player_shoot_gun();

    while(level.player attackbuttonpressed())
      wait 0.05;
  }
}

ending_player_shoot_gun() {
  self playrumbleonentity("heavygun_fire");
  playFXOnTag(level._effect["fx_usp_muzzle_flash"], level.ending_gun, "tag_flash");
  var_0 = level.ending_gun gettagorigin("tag_flash");
  var_1 = anglesToForward(level.ending_gun gettagangles("tag_flash"));
  var_2 = var_1 * 1000 + var_0;
  magicbullet("p226", var_0, var_2);
  var_3 = level.ending_arms maps\_utility::getanim("outro_pt1_garcia_punch_player_additive");
  var_4 = getanimlength(var_3);
  level.ending_arms setanimrestart(var_3, 1, 0, 1);
  wait(var_4);
}

outro_pt1_blood(var_0) {
  var_1 = maps\_utility::spawn_anim_model("outro_pt1_blood");
  var_0 = [];
  var_0["outro_pt1_blood"] = var_1;
  var_1 linkto(level.ending_heli);
  level.ending_heli maps\_anim::anim_single(var_0, "outro_pt1_blood");
}

ending_pt2_player_sequence_save() {
  setDvar("ui_deadquote", "");
  common_scripts\utility::flag_clear("vignette_ending_qte_success");
  common_scripts\utility::flag_clear("vignette_ending_scene_start");
  var_0 = maps\_vignette_util::vignette_actor_spawn("vignette_outro_player_legs", "outro_player_legs");
  level.outro_heli_front = maps\_utility::spawn_anim_model("outro_heli_front");
  level.outro_heli_mid = maps\_utility::spawn_anim_model("outro_heli_mid");
  level.outro_heli_rear = maps\_utility::spawn_anim_model("outro_heli_rear");
  level.outro_gate = maps\_utility::spawn_anim_model("outro_gate");
  var_1 = [];
  var_1["player_rig"] = level.ending_arms;
  var_1["outro_player_legs"] = var_0;
  var_1["outro_heli_front"] = level.outro_heli_front;
  var_1["outro_heli_mid"] = level.outro_heli_mid;
  var_1["outro_heli_rear"] = level.outro_heli_rear;
  var_1["ally_0"] = level.allies[0];
  var_1["ally_1"] = level.allies[1];
  var_1["outro_gate"] = level.outro_gate;
  var_2 = [];
  var_2["ally_0"] = level.allies[0];
  var_2["player_rig"] = level.ending_arms;
  var_2["outro_player_legs"] = var_0;
  var_3 = 4.0;
  level.outro_node = common_scripts\utility::getstruct("vignette_outro_end", "script_noteworthy");
  thread maps\flood_fx::set_vf_end2();
  level thread ending_pt2_hvt();
  level.player common_scripts\utility::delaycall(var_3 + 4.25, ::playrumbleonentity, "light_1s");
  level.player common_scripts\utility::delaycall(var_3 + 5.4, ::playrumbleonentity, "heavy_2s");
  level.player common_scripts\utility::delaycall(var_3 + 7.0, ::playrumbleonentity, "light_1s");
  var_4 = "outro_pt2_start";
  level.outro_node thread maps\_anim::anim_first_frame(var_1, var_4);
  level.player thread maps\flood_ending::ending_qte_catch(var_4);
  maps\_utility::delaythread(var_3 - 3.0, common_scripts\utility::flag_set, "ending_vo_pt2_start");
  wait(var_3);
  maps\_utility::autosave_by_name("ending_crash");
  common_scripts\utility::flag_set("vignette_ending_scene_start");
  maps\_utility::delaythread(5.3, common_scripts\utility::flag_set, "ending_qte_catch_active");
  level.outro_node thread maps\_anim::anim_single(var_1, var_4);
  level.outro_node waittill(var_4);

  if(common_scripts\utility::flag("vignette_ending_qte_success")) {
    thread maps\flood_audio::sfx_wakeup();
    level.player common_scripts\utility::delaycall(0.5, ::playrumbleonentity, "heavy_2s");
    var_4 = "outro_pt2_save_vargas";
    level.outro_node thread maps\_anim::anim_single(var_2, var_4);
    level.outro_node waittill(var_4);
  } else {
    thread maps\flood_audio::sfx_fail01();
    var_2 = common_scripts\utility::array_remove(var_2, level.allies[0]);
    common_scripts\utility::flag_set("missionfailed");
    level.player maps\_utility::delaythread(2.12, maps\flood_util::fell_in_water_fail, 1);
    level.outro_node thread maps\_anim::anim_single(var_2, "outro_pt2_start_fail");
    level.outro_node thread maps\_anim::anim_single_solo(level.allies[0], "outro_pt2_save_vargas");
    return;
  }

  var_5 = common_scripts\utility::array_remove(var_1, level.ending_arms);
  thread maps\flood_audio::sfx_looping_rorke();

  foreach(var_7 in var_5)
  level.outro_node thread maps\_anim::anim_loop_solo(var_7, "outro_pt2_save_vargas_loop");

  ending_pt2_player_reach();
  common_scripts\utility::flag_set("vignette_ending_reached");
  level waittill("end_of_vargas_loop");
  common_scripts\utility::flag_set("vignette_ending_qte_grabbed");
  common_scripts\utility::flag_set("vignette_ending_qte_success");
  maps\_utility::autosave_by_name_silent("ending_ally_grab");
  level.player playrumbleonentity("heavy_2s");
  level.player thread maps\flood_util::earthquake_w_fade(0.2, 2, 1, 1);
  var_4 = "outro_pt2_vargas_death";
  thread maps\flood_audio::sfx_change_zone();
  level thread ending_let_go_scene(var_1, var_4);
  level thread maps\flood_ending::ending_let_go_scene_player_experience();
  level waittill("ending_scene_ended");
  stopallrumbles();
  level.player notify("earthquake_end");

  if(!common_scripts\utility::flag("ending_let_go")) {
    maps\flood_ending::ending_destroy_qte_prompt();
    thread maps\flood_audio::sfx_let_go_fail();
    level notify("ending_player_failed");
    var_9 = common_scripts\utility::array_remove(var_1, level.ending_arms);
    common_scripts\utility::flag_set("missionfailed");
    level.player maps\_utility::delaythread(2.12, maps\flood_util::fell_in_water_fail, 1);
    level.outro_node thread maps\_anim::anim_single(var_9, "outro_pt2_vargas_death_end");
    var_10 = common_scripts\utility::array_remove(var_2, var_0);
    level.outro_node thread maps\_anim::anim_single(var_10, "outro_pt2_vargas_death_end_fail");
    return;
  } else {
    thread maps\flood_audio::sfx_last_pass();
    level notify("ending_player_success");
    var_4 = "outro_pt2_vargas_death_end";
    level.outro_node thread maps\_anim::anim_single(var_1, var_4);
    level.outro_node waittill(var_4);
  }

  level.allies[0] maps\_vignette_util::vignette_actor_kill();
  level.allies[0] hide();
  level.allies[1] maps\_vignette_util::vignette_actor_kill();
  level.allies[1] hide();
  level.outro_heli_front delete();
  level.outro_heli_mid delete();
  level.outro_heli_rear delete();
  level.outro_gate delete();
  setsaveddvar("compass", 1);
  setsaveddvar("ammoCounterHide", 0);
  setsaveddvar("actionSlotsHide", 0);
  setsaveddvar("hud_showStance", 1);
  setsaveddvar("g_friendlyNameDist", level.g_friendlynamedist_old);
}

ending_pt2_player_reach() {
  var_0 = level.ending_arms maps\_utility::getanim("outro_pt2_save_vargas_loop")[0];
  var_1 = level.ending_arms maps\_utility::getanim("outro_pt2_save_vargas_loop_additive");
  var_2 = level.ending_arms maps\_utility::getanim("outro_pt2_save_vargas_loop_additive_parent");
  level.ending_arms setanim(var_0);
  level.ending_arms setanim(var_1);
  level.ending_arms setanimlimited(var_2, 0.0);
  var_3 = 0.0;
  var_4 = 0;

  while(var_4 < 20) {
    if(!common_scripts\utility::flag("smash_rate_bad")) {
      if(var_3 < 1.0)
        var_3 = var_3 + 0.04;
    } else if(var_3 > 0.04) {
      var_3 = var_3 - 0.04;
      var_4 = 0;
    }

    var_5 = 1.0 - var_3;
    var_5 = clamp(var_5, 0.001, 1.0);
    var_3 = clamp(var_3, 0.0, 1.0);
    level.ending_arms setanimlimited(var_1, var_5, 0.05);
    level.ending_arms setanimlimited(var_2, var_3, 0.05);

    if(var_3 == 1.0)
      var_4 = var_4 + 1;

    wait 0.05;
  }
}

ending_let_go_scene(var_0, var_1) {
  level.outro_node thread maps\_anim::anim_single(var_0, var_1);
  level.outro_node waittill(var_1);
  level notify("ending_scene_ended");
}

ending_blur_logic() {
  setblur(2, 0.05);
  wait 0.5;
  setblur(0, 7.0);
}

ending_pt2_hvt() {
  var_0 = maps\_utility::spawn_anim_model("outro_wire_grab");
  var_1 = [];
  var_1["generic"] = level.ending_hvt;
  var_1["outro_wire_grab"] = var_0;
  var_2 = "outro_pt2_start";
  level.outro_node maps\_anim::anim_first_frame(var_1, var_2);
  common_scripts\utility::flag_wait("vignette_ending_scene_start");
  level.outro_node thread maps\_anim::anim_single(var_1, var_2);
  level.outro_node waittill(var_2);
  level.ending_hvt maps\_vignette_util::vignette_actor_kill();
}

building_01_debri_anim_spawn() {
  building_01_debri_anim();
}

building_01_debri_anim() {
  var_0 = [];
  var_1 = common_scripts\utility::getstruct("building_01_debri_anim", "script_noteworthy");
  var_2 = maps\_utility::spawn_anim_model("building_01_debri");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardsmall03_dark", "j_building_01_debri_com_wallchunk_boardsmall03_1");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardsmall04_dark", "j_building_01_debri_com_wallchunk_boardsmall04_2");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_plastic_crate_pallet", "j_building_01_debri_com_plastic_crate_pallet_3");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_pallet_2", "j_building_01_debri_com_pallet_2_4");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardmedium02_dark", "j_building_01_debri_com_wallchunk_boardmedium02_5");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardmedium02_dark", "j_building_01_debri_com_wallchunk_boardmedium02_6");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardlarge01_dark", "j_building_01_debri_com_wallchunk_boardlarge01_7");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "street_trashcan_open_iw6", "j_building_01_debri_com_trashcan_metal_with_trash_8");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardmedium01_dark", "j_building_01_debri_com_wallchunk_boardmedium01_9");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardmedium01_dark", "j_building_01_debri_com_wallchunk_boardmedium01_10");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardsmall03_dark", "j_building_01_debri_com_wallchunk_boardsmall03_11");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardsmall04_dark", "j_building_01_debri_com_wallchunk_boardsmall04_12");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardsmall03_dark", "j_building_01_debri_com_wallchunk_boardsmall03_13");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardmedium01_dark", "j_building_01_debri_com_wallchunk_boardmedium01_14");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_plasticcase_beige_big_iw6", "j_building_01_debri_pb_weaponscase_15");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "street_trashcan_open_iw6", "j_building_01_debri_com_trashcan_metal_with_trash_16");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardlarge01_dark", "j_building_01_debri_com_wallchunk_boardlarge01_17");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardsmall03_dark", "j_building_01_debri_com_wallchunk_boardsmall03_18");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardlarge01_dark", "j_building_01_debri_com_wallchunk_boardlarge01_19");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardlarge01_dark", "j_building_01_debri_com_wallchunk_boardlarge01_20");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_pallet_2", "j_building_01_debri_com_pallet_2_21");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "street_trashcan_open_iw6", "j_building_01_debri_com_trashcan_metal_with_trash_22");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardsmall04_dark", "j_building_01_debri_com_wallchunk_boardsmall04_23");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardlarge01_dark", "j_building_01_debri_com_wallchunk_boardlarge01_24");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardsmall03_dark", "j_building_01_debri_com_wallchunk_boardsmall03_25");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardmedium02_dark", "j_building_01_debri_com_wallchunk_boardmedium02_26");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardmedium01_dark", "j_building_01_debri_com_wallchunk_boardmedium01_27");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardsmall03_dark", "j_building_01_debri_com_wallchunk_boardsmall03_28");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardlarge01_dark", "j_building_01_debri_com_wallchunk_boardlarge01_29");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_trashbin01", "j_building_01_debri_com_trashbin01_30");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardsmall04_dark", "j_building_01_debri_com_wallchunk_boardsmall04_31");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardmedium01_dark", "j_building_01_debri_com_wallchunk_boardmedium01_32");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardmedium01_dark", "j_building_01_debri_com_wallchunk_boardmedium01_33");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardmedium02_dark", "j_building_01_debri_com_wallchunk_boardmedium02_34");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardsmall03_dark", "j_building_01_debri_com_wallchunk_boardsmall03_35");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardsmall04_dark", "j_building_01_debri_com_wallchunk_boardsmall04_36");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardlarge01_dark", "j_building_01_debri_com_wallchunk_boardlarge01_37");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardmedium01_dark", "j_building_01_debri_com_wallchunk_boardmedium01_38");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "street_trashcan_open_iw6", "j_building_01_debri_com_trashcan_metal_with_trash_39");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardmedium02_dark", "j_building_01_debri_com_wallchunk_boardmedium02_40");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardsmall04_dark", "j_building_01_debri_com_wallchunk_boardsmall04_41");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardmedium01_dark", "j_building_01_debri_com_wallchunk_boardmedium01_42");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardmedium01_dark", "j_building_01_debri_com_wallchunk_boardmedium01_43");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_trashbin01", "j_building_01_debri_com_trashbin01_44");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardmedium01_dark", "j_building_01_debri_com_wallchunk_boardmedium01_45");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_plastic_crate_pallet", "j_building_01_debri_com_plastic_crate_pallet_46");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardsmall04_dark", "j_building_01_debri_com_wallchunk_boardsmall04_47");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardmedium02_dark", "j_building_01_debri_com_wallchunk_boardmedium02_48");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardsmall03_dark", "j_building_01_debri_com_wallchunk_boardsmall03_49");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardmedium02_dark", "j_building_01_debri_com_wallchunk_boardmedium02_50");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardmedium01_dark", "j_building_01_debri_com_wallchunk_boardmedium01_51");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardlarge01_dark", "j_building_01_debri_com_wallchunk_boardlarge01_52");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_barrel_green", "j_building_01_debri_com_barrel_green_53");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardmedium02_dark", "j_building_01_debri_com_wallchunk_boardmedium02_54");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_trashbin01", "j_building_01_debri_com_trashbin01_55");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_plasticcase_beige_big_iw6", "j_building_01_debri_pb_weaponscase_56");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardmedium02_dark", "j_building_01_debri_com_wallchunk_boardmedium02_57");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "street_trashcan_open_iw6", "j_building_01_debri_com_trashcan_metal_with_trash_58");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardlarge01_dark", "j_building_01_debri_com_wallchunk_boardlarge01_59");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardlarge01_dark", "j_building_01_debri_com_wallchunk_boardlarge01_60");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardsmall04_dark", "j_building_01_debri_com_wallchunk_boardsmall04_61");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_pallet_2", "j_building_01_debri_com_pallet_2_62");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_folding_chair", "j_building_01_debri_com_folding_chair_63");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardsmall03_dark", "j_building_01_debri_com_wallchunk_boardsmall03_64");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardsmall04_dark", "j_building_01_debri_com_wallchunk_boardsmall04_65");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_folding_chair", "j_building_01_debri_com_folding_chair_66");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_folding_chair", "j_building_01_debri_com_folding_chair_67");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_trashbin01", "j_building_01_debri_com_trashbin01_68");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardmedium02_dark", "j_building_01_debri_com_wallchunk_boardmedium02_69");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardsmall03_dark", "j_building_01_debri_com_wallchunk_boardsmall03_70");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardsmall03_dark", "j_building_01_debri_com_wallchunk_boardsmall03_71");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardmedium01_dark", "j_building_01_debri_com_wallchunk_boardmedium01_72");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardsmall04_dark", "j_building_01_debri_com_wallchunk_boardsmall04_73");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardsmall04_dark", "j_building_01_debri_com_wallchunk_boardsmall04_74");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_plastic_crate_pallet", "j_building_01_debri_com_plastic_crate_pallet_75");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardsmall03_dark", "j_building_01_debri_com_wallchunk_boardsmall03_76");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardlarge01_dark", "j_building_01_debri_com_wallchunk_boardlarge01_77");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_barrel_green", "j_building_01_debri_com_barrel_green_78");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_folding_chair", "j_building_01_debri_com_folding_chair_79");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_plasticcase_beige_big_iw6", "j_building_01_debri_pb_weaponscase_83");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_folding_chair", "j_building_01_debri_com_folding_chair_84");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_trashbin01", "j_building_01_debri_com_trashbin01_85");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardsmall04_dark", "j_building_01_debri_com_wallchunk_boardsmall04_86");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardsmall03_dark", "j_building_01_debri_com_wallchunk_boardsmall03_87");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardmedium02_dark", "j_building_01_debri_com_wallchunk_boardmedium02_88");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_folding_chair", "j_building_01_debri_com_folding_chair_90");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardmedium02_dark", "j_building_01_debri_com_wallchunk_boardmedium02_91");
  var_0[var_0.size] = attach_fx_anim_model(var_2, "com_wallchunk_boardlarge01_dark", "j_building_01_debri_com_wallchunk_boardlarge01_92");
  var_3 = spawn("script_model", (5827, -2574, 207));

  foreach(var_5 in var_0)
  var_5 retargetscriptmodellighting(var_3);

  var_2 hide();
  var_7 = [];
  var_7["building_01_debri"] = var_2;
  var_1 maps\_anim::anim_single(var_7, "building_01_debri_anim");
}

setup_enemies_open_gate() {
  level.ending_gate_l = maps\_utility::spawn_anim_model("ending_breach_door_l");
  level.ending_gate_r = maps\_utility::spawn_anim_model("ending_breach_door_r");
  level.ending_gate_node_left = common_scripts\utility::getstruct("ending_gate_node_left", "targetname");
  level.ending_gate_node_left maps\_anim::anim_first_frame_solo(level.ending_gate_l, "outro_pt1_breach");
  level.ending_gate_node_right = common_scripts\utility::getstruct("ending_gate_node_right", "targetname");
  level.ending_gate_node_right maps\_anim::anim_first_frame_solo(level.ending_gate_r, "outro_pt1_breach");
  var_0 = getEntArray("garage_door_r", "targetname");

  foreach(var_2 in var_0)
  var_2 linkto(level.ending_gate_l);

  var_0 = getEntArray("garage_door_l", "targetname");

  foreach(var_2 in var_0)
  var_2 linkto(level.ending_gate_r);
}

enemies_open_gate() {
  var_0 = getEntArray("ending_enemies", "targetname");
  common_scripts\utility::array_thread(var_0, maps\_utility::add_spawn_function, maps\_utility::disable_long_death);
  common_scripts\utility::array_thread(var_0, maps\_utility::add_spawn_function, maps\_utility::enable_cqbwalk);
  common_scripts\utility::array_thread(var_0, maps\_utility::add_spawn_function, maps\flood_ending::ending_temp_ignore);
  common_scripts\utility::array_thread(var_0, maps\_utility::spawn_ai, 1);
  var_1 = getent("gate_keeper", "targetname");
  var_1 maps\_utility::add_spawn_function(maps\_utility::disable_long_death);
  var_1 maps\_utility::add_spawn_function(maps\flood_ending::ending_temp_ignore);
  var_1 maps\_utility::add_spawn_function(maps\flood_ending::ending_remove_gate_keepers);
  var_2 = var_1 maps\_utility::spawn_ai(1);
  var_2.animname = "generic";
  var_3 = common_scripts\utility::getstruct("ending_open_door", "targetname");
  var_3 maps\_anim::anim_reach_solo(var_2, "ending_door_kick");
  var_3 thread maps\_anim::anim_single_solo(var_2, "ending_door_kick");
  wait 0.1;
  level.ending_gate_node_left thread maps\_anim::anim_single_solo(level.ending_gate_l, "outro_pt1_breach");
  level.ending_gate_node_right thread maps\_anim::anim_single_solo(level.ending_gate_r, "outro_pt1_breach");
}

outro_pt2_face_01(var_0) {
  level.allies[0] maps\_utility::dialogue_queue("outro_pt2_start_face");
}

outro_pt2_face_02(var_0) {
  level.allies[0] maps\_utility::dialogue_queue("outro_pt2_save_vargas_face");
}

outro_pt2_face_03(var_0) {
  while(!common_scripts\utility::flag("vignette_ending_reached"))
    level.allies[0] maps\_utility::dialogue_queue("outro_pt2_save_vargas_loop_face");

  wait 0.5;
  level notify("end_of_vargas_loop");
}

outro_pt2_face_04(var_0) {
  level.allies[0] maps\_utility::dialogue_queue("outro_pt2_vargas_death_face");
}

outro_pt2_face_05(var_0) {
  level.allies[0] maps\_utility::dialogue_queue("outro_pt2_vargas_death_end_face");
}

notetrack_open_gate(var_0) {
  maps\flood_ending::ending_swing_doors_open();
  common_scripts\utility::flag_set("ending_gate_open");
}