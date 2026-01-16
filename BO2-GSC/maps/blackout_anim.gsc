/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\blackout_anim.gsc
**************************************/

#include maps\_utility;
#include maps\_dialog;
#include maps\_scene;
#include maps\_anim;
#include maps\_turret;
#include common_scripts\utility;
#include maps\blackout_util;
#include maps\_music;
#include maps\voice\voice_blackout;
#include maps\blackout_interrogation;
#include maps\createart\blackout_art;
#include maps\blackout_bridge;
#include maps\blackout_security;
#include maps\blackout_server_room;
#include maps\blackout_menendez_start;
#include maps\blackout_hangar;
#include maps\blackout_deck;

main() {
  maps\voice\voice_blackout::init_voice();
  scene_intro_cctv();
  scene_intro_nag();
  init_hacking_anims();
  init_corpse_poses();
  init_custom_traversals();
  precache_assets();
}

mason_intro_animations() {
  scene_intro_interrogation();
  scene_wakeup();
  scene_mason_taser_knuckles();
}

mason_bridge_animations() {
  scene_bridge_entry();
  scene_bridge();
}

mason_part_1_animations() {
  scene_intro_interrogation();
  scene_wakeup();
  scene_mason_taser_knuckles();
  scene_hallway_devestation();
  scene_bridge_entry();
  scene_bridge();
  scene_security_level();
  torch_wall_scene();
  salazar_kill_animations();
  f38_crash_into_bridge();
  level thread scene_menendez_cctv();
}

menendez_animations() {
  flag_wait("story_stats_loaded");
  salazar_kill_animations();
  scene_server_room_super_kill();
  meat_shield_sequence();
  kneecap_sequence();
  scene_menendez_hack();
  player_kick_anim();
  precache_assets(1);
}

mason_part_2_animations() {
  flag_wait("story_stats_loaded");
  cctv_room_computer_guy();
  aftermath_scene();
  betrayal_scene();
  brute_force();
  precache_assets(1);
}

#using_animtree("generic_human");

init_custom_traversals() {
  level.scr_anim["generic"]["mantle_window_36_stop"] = % ai_mantle_window_36_stop;
  level.scr_anim["generic"]["roll_over_bar_44_in"] = % ai_roll_over_bar_44_in;
}

init_hacking_anims() {
  level.scr_anim["generic"]["hack_loop_left"][0] = % ch_command_03_03_obs_deck_hacker_hacker01_idle;
  level.scr_anim["generic"]["hack_react_left"] = % ch_command_03_03_obs_deck_hacker_hacker01_react_left;
  level.scr_anim["generic"]["hack_loop_right"][0] = % ch_command_03_03_obs_deck_hacker_hacker02_idle;
  level.scr_anim["generic"]["hack_react_right"] = % ch_command_03_03_obs_deck_hacker_hacker02_react_right;
  level.scr_anim["generic"]["hack_loop_back"][0] = % ch_command_03_03_obs_deck_hacker_hacker03_idle;
  level.scr_anim["generic"]["hack_react_back"] = % ch_command_03_03_obs_deck_hacker_hacker03_react_back;
}

#using_animtree("animated_props");
#using_animtree("player");

scene_intro_cctv() {
  add_scene("intro_cctv", "intro_interrogation_mirror_node");
  add_actor_anim("menendez", % ch_command_01_01_observation_cctv_menendez, 1, 0);
  add_actor_anim("salazar", % ch_command_01_01_observation_cctv_salazar, 1, 0);
  add_prop_anim("intro_handcuffs", % o_command_01_01_observation_cctv_handcuffs, "p6_handcuffs", 0, 0);
  add_notetrack_custom_function("menendez", "turn_around", maps\blackout_interrogation::notetrack_player_leaves_monitor);
  add_notetrack_custom_function("menendez", "punched", maps\blackout_interrogation::notetrack_menendez_punched_in_the_face);
  add_scene("intro_player_loop", "intro_interrogation_mirror_node", 0, 0, 1);
  add_player_anim("player_body", % p_command_01_02_observation_loop, 0);
  add_scene("intro_playerturn", "intro_interrogation_mirror_node");
  add_player_anim("player_body", % p_command_01_02_observation_playerturnaround, 1);
}

#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("player");

scene_intro_nag() {
  add_scene("intro_nag_loop", "intro_interrogation_mirror_node", 0, 0, 1);
  add_actor_anim("menendez", % ch_command_01_03_returntointerrogation_menendez_wait, 1, 0);
  add_actor_anim("salazar", % ch_command_01_03_returntointerrogation_salazar_wait, 1, 0);
  add_actor_anim("briggs", % ch_command_01_03_returntointerrogation_briggs_wait, 1, 0);
  add_actor_anim("room_guard_01", % ch_command_01_03_returntointerrogation_sailor_01_wait, 0, 1, 0, 1, undefined, "navy_shotgun_guy");
  add_prop_anim("intro_handcuffs", % o_command_01_03_returntointerrogation_handcuffs_wait, "p6_handcuffs", 0, 0);
  add_scene("intro_guard_2", "intro_interrogation_mirror_node", 0, 0, 1);
  add_actor_anim("room_guard_02", % ch_command_01_03_returntointerrogation_sailor_02_wait, 0, 1, 1, 1, undefined, "navy_shotgun_guy");
  add_scene("enter_interrogation_room", "intro_interrogation_mirror_node");
  add_actor_anim("menendez", % ch_command_01_03_returntointerrogation_menendez, 1, 0);
  add_actor_anim("salazar", % ch_command_01_03_returntointerrogation_salazar, 1);
  add_actor_anim("briggs", % ch_command_01_03_returntointerrogation_briggs, 1, 0);
  add_prop_anim("interrogation_door_lower", % o_command_01_02_returntointerrogation_door, undefined, 0, 0);
  add_prop_anim("interrogation_chair_model", % o_command_01_03_returntointerrogation_chair, "com_folding_chair");
  add_prop_anim("intro_handcuffs", % o_command_01_03_returntointerrogation_handcuffs, "p6_handcuffs", 0, 0);
  add_player_anim("player_body", % p_command_01_03_returntointerrogation_player_enter_room, 0, 0, undefined, 1, 1, 20, 20, 15, 0);
  add_notetrack_custom_function("player_body", undefined, ::data_glove_on_with_light);
  add_notetrack_custom_function("player_body", undefined, ::mason_shadow_rig);
  add_notetrack_custom_function("player_body", "attach_head_shadow", ::mason_shadow_head_show, 1);
  add_notetrack_custom_function("player_body", "detach_head_shadow", ::mason_shadow_head_hide, 1);
  add_notetrack_custom_function("player_body", "dof_eye_scan", maps\createart\blackout_art::notetrack_intro_dof_eye_scan);
  add_notetrack_custom_function("player_body", "dof_open_door", maps\createart\blackout_art::notetrack_intro_dof_open_door);
  add_notetrack_custom_function("player_body", "dof_talk_to_briggs", maps\createart\blackout_art::notetrack_intro_dof_talk_to_briggs);
  add_notetrack_custom_function("player_body", "dof_look_at_menendez", maps\createart\blackout_art::notetrack_intro_dof_look_at_menendez);
  add_notetrack_custom_function("player_body", "dof_pickup_chair", maps\createart\blackout_art::notetrack_intro_dof_pick_up_chair);
  add_notetrack_custom_function("player_body", "dof_look_at_menendez_2", maps\createart\blackout_art::notetrack_intro_dof_look_at_menendez_2);
  add_scene("intro_briggs_leave", "intro_interrogation_mirror_node");
  add_actor_anim("briggs", % ch_command_01_03_returntointerrogation_briggs_stepasideandleave, 1, 0, 1);
  add_scene("enter_interrogation_room_part_2", "intro_interrogation_mirror_node");
  add_actor_anim("menendez", % ch_command_01_05_monolouge_menendez, 1, 0);
  add_actor_anim("salazar", % ch_command_01_05_monolouge_salazar, 1);
  add_prop_anim("intro_handcuffs", % o_command_01_05_monolouge_handcuffs, "p6_handcuffs", 0, 0);
  add_player_anim("player_body", % p_command_01_05_monolouge_player, 0, 0, undefined, 1, 1, 20, 20, 15, 0);
  add_scene("enter_interrogation_room_part_3", "intro_interrogation_mirror_node");
  add_actor_anim("menendez", % ch_command_01_05_monolouge_end_menendez, 1, 0);
  add_actor_anim("salazar", % ch_command_01_05_monolouge_end_salazar, 1);
  add_prop_anim("intro_handcuffs", % o_command_01_05_monolouge_end_handcuffs, "p6_handcuffs", 0, 0);
  add_player_anim("player_body", % p_command_01_05_monolouge_end_player, 0, 0, undefined, 1, 1, 20, 20, 15, 0);
  add_notetrack_custom_function("player_body", "dof_menendez_to_arm", maps\createart\blackout_art::notetrack_intro_dof_menendez_to_arm);
  add_notetrack_custom_function("player_body", "dof_arm_to_menendez", maps\createart\blackout_art::notetrack_intro_dof_arm_to_menendez);
  add_notetrack_custom_function("player_body", "dof_menendez_to_arm_2", maps\createart\blackout_art::notetrack_intro_dof_menendez_to_arm_2);
  add_notetrack_custom_function("player_body", "dof_arm_to_menendez_2", maps\createart\blackout_art::notetrack_intro_dof_arm_to_menendez_2);
  add_notetrack_custom_function("player_body", "dof_stand_up", maps\createart\blackout_art::notetrack_intro_dof_stand_up);
  add_notetrack_custom_function("player_body", "dof_point_at_menendez", maps\createart\blackout_art::notetrack_intro_dof_point_at_menendez);
  add_notetrack_custom_function("player_body", "dof_turn_to_door", maps\createart\blackout_art::notetrack_intro_dof_turn_to_door);
  add_notetrack_custom_function("player_body", undefined, maps\blackout_interrogation::notetrack_briggs_transmission);
  add_notetrack_custom_function("player_body", "boom", maps\blackout_interrogation::notetrack_interrogation_explosion);
}

mason_shadow_rig(m_player_body) {
  m_player_body setmodel("c_usa_cia_masonjr_armlaunch_viewbody_s");
  mason_shadow_head_show(m_player_body);
}

mason_shadow_head_show(m_player_body) {
  if(!isDefined(m_player_body.head_showing))
    m_player_body.head_showing = 0;

  if(!m_player_body.head_showing) {
    m_player_body attach("c_usa_cia_combat_masonjr_head_shadow");
    m_player_body.head_showing = 1;
  }
}

mason_shadow_head_hide(m_player_body) {
  if(!isDefined(m_player_body.head_showing))
    m_player_body.head_showing = 0;

  if(m_player_body.head_showing) {
    m_player_body detach("c_usa_cia_combat_masonjr_head_shadow");
    m_player_body.head_showing = 0;
  }
}

#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("player");
#using_animtree("animated_props");

scene_intro_interrogation() {
  add_scene("intro_table", "intro_interrogation_mirror_node");
  add_prop_anim("interrogation_table", % o_command_01_03_theprestige_table, "tag_origin_animate", 0, 1);
  add_notetrack_custom_function("interrogation_table", undefined, maps\blackout_interrogation::notetrack_setup_table);
  add_scene("wakeup_table", "intro_interrogation_node");
  add_prop_anim("interrogation_table_upper", % o_command_01_03_theprestige_table, "tag_origin_animate", 0, 1);
  add_notetrack_custom_function("interrogation_table_upper", undefined, maps\blackout_interrogation::notetrack_setup_table);
  add_scene("intro_setup_chair", "intro_interrogation_mirror_node");
  add_prop_anim("interrogation_chair_model", % o_command_01_03_returntointerrogation_chair, "com_folding_chair", 1);
  add_scene("intro_fight_sailors", "intro_interrogation_mirror_node");
  add_actor_anim("room_guard_01", % ch_command_01_03_theprestige_sailor_01, 0, 1, 1, 1, undefined, "navy_shotgun_guy");
  add_notetrack_custom_function("room_guard_01", "shot", maps\blackout_interrogation::notetrack_prestige_sailor_shot);
  add_scene("intro_fight", "intro_interrogation_mirror_node");
  add_actor_anim("menendez", % ch_command_01_05_theprestige_menendez, 1, 0, 1);
  add_actor_anim("salazar", % ch_command_01_05_theprestige_salazar, 0);
  add_prop_anim("intro_handcuffs", % o_command_01_05_theprestige_handcuffs, "p6_handcuffs", 1, 0);
  add_prop_anim("interrogation_door_lower", % o_command_01_02_theprestige_door, undefined, 1, 0);
  add_prop_anim("interrogation_table", % o_command_01_05_theprestige_table, "tag_origin_animate", 1, 1);
  add_player_anim("player_body", % p_command_01_05_theprestige_player, 1, 0, undefined, 1, 1, 15, 15, 12, 10, 1, 1);
  add_prop_anim("prestige_player_gun", % o_command_01_05_theprestige_gun_fiveseven, "t6_wpn_pistol_fiveseven_prop", 1);
  add_notetrack_custom_function("player_body", "hit", maps\blackout_interrogation::callback_player_knocked_out);
  add_notetrack_flag("salazar", "switch_off", "intro_disable_camera");
  add_notetrack_flag("menendez", "cuff_light", "intro_disable_handcuffs");
  add_notetrack_custom_function("menendez", "light_off", maps\blackout_interrogation::notetrack_lights_out);
  add_notetrack_custom_function("menendez", "light_on", maps\blackout_interrogation::notetrack_lights_on);
  add_notetrack_custom_function("menendez", "table_shake", maps\blackout_interrogation::notetrack_table_shake);
  add_notetrack_custom_function("menendez", "light_flicker", maps\blackout_interrogation::notetrack_light_flicker);
  add_notetrack_custom_function("player_body", "dof_shoot_guard", maps\createart\blackout_art::notetrack_intro_dof_shoot_guard);
  add_notetrack_custom_function("player_body", "dof_look_at_menedez_3 ", maps\createart\blackout_art::notetrack_intro_dof_look_at_menendez_3);
  add_notetrack_custom_function("player_body", "dof_hands_up", maps\createart\blackout_art::notetrack_intro_dof_hands_up);
  add_notetrack_custom_function("player_body", "dof_place_gun_on_table ", maps\createart\blackout_art::notetrack_intro_dof_place_gun_on_table);
  add_notetrack_custom_function("player_body", "dof_put _on_hand_cuffs ", maps\createart\blackout_art::notetrack_intro_dof_put_on_hand_cuffs);
  add_notetrack_custom_function("player_body", "dof_look_at_menendez_5", maps\createart\blackout_art::notetrack_intro_dof_look_at_menendez_4);
  add_notetrack_custom_function("player_body", "dof_look_at_wall", maps\createart\blackout_art::notetrack_intro_dof_look_at_wall);
  add_notetrack_custom_function("player_body", "hit_ground", maps\createart\blackout_art::notetrack_intro_dof_hit_ground);
  precache_assets(1);
}

#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");

scene_wakeup() {
  add_scene("getup_decide", "intro_interrogation_node", 0, 0, 1);
  add_player_anim("player_body", % p_command_02_01_wake_up_mason_idleb4makedecision, 0);
  add_actor_anim("salazar", % ch_command_02_01_wake_up_salazar_reachingoutidle);
  add_scene("getup_self", "intro_interrogation_node");
  add_player_anim("player_body", % p_command_02_01_wake_up_mason_helpdenied, 1);
  add_actor_anim("salazar", % ch_command_02_01_wake_up_salazar_helpdenied);
  add_scene("player_wakes_up_in_interrogation_room", "intro_interrogation_node");
  add_player_anim("player_body", % p_command_02_01_wake_up_mason_helpaccepted, 1, 0, undefined, 1, 1, 15, 15, 12, 10, 1, 1);
  add_scene("salazar_wakes_player_up_and_walks_to_armory", "intro_interrogation_node");
  add_actor_anim("salazar", % ch_command_02_01_wake_up_salazar_helpaccepted);
  add_scene("sal_locker_walk", "intro_interrogation_node");
  add_actor_anim("salazar", % ch_command_02_01_wake_up_salazar_walktolocker);
  add_scene("salazar_walks_to_hallway_door", "intro_interrogation_node");
  add_actor_anim("salazar", % ch_command_02_01_wake_up_salazar_walktodoor);
  add_scene("salazar_waits_to_enter_hallway", "intro_interrogation_node", 0, 0, 1);
  add_actor_anim("salazar", % ch_command_02_01_wake_up_salazar_cautiousidle);
  add_scene("sal_door_open", "intro_interrogation_node");
  add_player_anim("player_body", % p_command_02_01_wake_up_mason_dooropen, 1, 0, undefined, 1, 1, 15, 15, 12, 10, 1, 1);
  add_prop_anim("interrogation_hallway_door", % o_command_02_01_wake_up_pressuredoor_dooropen);
  add_notetrack_custom_function("player_body", "rumble", maps\blackout_interrogation::scene_sal_open_door_rumble);
  add_notetrack_custom_function("player_body", "start_salazar", maps\blackout_interrogation::notetrack_salazar_runs_into_hallway);
  add_scene("salazar_runs_into_hallway", "intro_interrogation_node");
  add_actor_anim("salazar", % ch_command_02_01_wake_up_salazar_dooropen);
  add_scene("hallway_door_closes_behind_player", "intro_interrogation_node");
  add_prop_anim("interrogation_hallway_door", % o_command_02_01_wake_up_pressuredoor_closed);
  add_scene("stairfall", "stair_fall");
  add_actor_anim("stairfall_spawn", % ch_command_02_04_up_the_staircase);
  add_prop_anim("stairfall_door", % o_command_02_04_up_the_staircase, "p6_blackout_hatch_door");
  add_notetrack_custom_function("stairfall_spawn", "hit", maps\blackout_bridge::moment_stairfall_die);
  precache_assets(1);
}

#using_animtree("player");
#using_animtree("animated_props");

scene_mason_taser_knuckles() {
  add_scene("taser_knuckle_get", "knuckle_crate");
  add_player_anim("player_body", % int_specialty_blackout_lockbreaker, 1, 0, undefined, 1, 1, 15, 15, 12, 10, 1, 1);
  add_prop_anim("hack_dongle", % o_specialty_blackout_lockbreaker_dongle, "t6_wpn_hacking_dongle_prop", 1, 1);
  add_prop_anim("knuckle_puck", % o_specialty_blackout_lockbreaker_knuckles, "t6_wpn_taser_knuckles_prop_view", 1, 0);
  add_notetrack_custom_function("player_body", "start", maps\blackout_util::data_glove_on);
  add_notetrack_custom_function("knuckle_puck", undefined, ::set_force_no_cull);
  add_notetrack_custom_function("knuckle_puck", "spark_fx", ::notetrack_taser_knuckle_spark);
  add_scene("taser_knuckle_crate", "knuckle_crate");
  add_prop_anim("knuckle_crate", % o_specialty_blackout_lockbreaker_crate);
  add_scene("taser_knuckles_extras", "knuckle_crate");
  add_prop_anim("extra_knuckles_1", % o_specialty_blackout_lockbreaker_filler_knuckles_1, "t6_wpn_taser_knuckles_prop_view", 1);
  add_prop_anim("extra_knuckles_2", % o_specialty_blackout_lockbreaker_filler_knuckles_2, "t6_wpn_taser_knuckles_prop_view", 1);
  add_prop_anim("extra_knuckles_3", % o_specialty_blackout_lockbreaker_filler_knuckles_3, "t6_wpn_taser_knuckles_prop_view", 1);
  add_prop_anim("extra_knuckles_4", % o_specialty_blackout_lockbreaker_filler_knuckles_4, "t6_wpn_taser_knuckles_prop_view", 1);
  add_prop_anim("extra_knuckles_5", % o_specialty_blackout_lockbreaker_filler_knuckles_5, "t6_wpn_taser_knuckles_prop_view", 1);
  add_prop_anim("extra_knuckles_6", % o_specialty_blackout_lockbreaker_filler_knuckles_6, "t6_wpn_taser_knuckles_prop_view", 1);
  precache_assets(1);
}

notetrack_taser_knuckle_spark(m_knuckles) {
  playfxontag(level._effect["taser_knuckles_start"], m_knuckles, "TAG_FX");
}

#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("player");
#using_animtree("animated_props");

scene_hallway_devestation() {
  add_scene("hallway_dead", "interrogation_hallway_node", 0, 0, 1);
  add_actor_model_anim("hallway_corpse01", % ch_command_02_03_hallway_devastation_usnavy01, undefined, 1, undefined, undefined, "navy_wounded", 0);
  add_actor_model_anim("hallway_corpse02", % ch_command_02_03_hallway_devastation_usnavy02, undefined, 1, undefined, undefined, "navy_wounded", 0);
  add_actor_model_anim("hallway_corpse04", % ch_command_02_03_hallway_devastation_usnavy04, undefined, 1, undefined, undefined, "navy_wounded", 0);
  add_actor_model_anim("hallway_corpse05", % ch_command_02_03_hallway_devastation_usnavy11, undefined, 1, undefined, undefined, "navy_wounded", 0);
  add_actor_model_anim("hallway_corpse06", % ch_command_02_03_hallway_devastation_usnavy12, undefined, 1, undefined, undefined, "navy_wounded", 0);
  add_scene("hallway_cougher", "interrogation_hallway_node", 0, 0, 1);
  add_actor_anim("observation_hallway_cougher", % ch_command_02_03_hallway_devastation_usnavy05_coughblood_loop, 1, 0);
  add_actor_spawner("observation_hallway_cougher", "navy_wounded");
  add_notetrack_custom_function("observation_hallway_cougher", undefined, maps\blackout_interrogation::hallway_friendly_think);
  add_scene("hallway_entry_victims", "interrogation_hallway_node");
  add_actor_anim("observation_hallway_victim01", % ch_command_02_03_hallway_devastation_usnavy08);
  add_actor_anim("observation_hallway_victim02", % ch_command_02_03_hallway_devastation_usnavy09);
  add_actor_spawner("observation_hallway_victim01", "navy_assault_guy");
  add_actor_spawner("observation_hallway_victim02", "navy_assault_guy");
  add_scene("hallway_entry_attackers", "interrogation_hallway_node");
  add_actor_anim("observation_hallway_enemy01", % ch_command_02_03_hallway_devastation_pmc01);
  add_actor_anim("observation_hallway_enemy02", % ch_command_02_03_hallway_devastation_pmc02);
  add_actor_anim("observation_hallway_enemy03", % ch_command_02_03_hallway_devastation_pmc03, 0, 1, 0, 1);
  add_actor_spawner("observation_hallway_enemy01", "pmc_assault_guy");
  add_actor_spawner("observation_hallway_enemy02", "pmc_assault_guy");
  add_actor_spawner("observation_hallway_enemy03", "pmc_assault_guy");
  add_scene("hallway_drag", "interrogation_hallway_node");
  add_actor_anim("observation_hallway_surgery01", % ch_command_02_03_hallway_devastation_usnavy06, 1, 0, 0, 1);
  add_actor_anim("observation_hallway_surgery02", % ch_command_02_03_hallway_devastation_usnavy07, 1, 0, 0, 1);
  add_actor_anim("observation_hallway_surgery03", % ch_command_02_03_hallway_devastation_usnavy10, 1, 0, 0, 1);
  add_actor_spawner("observation_hallway_surgery01", "navy_wounded");
  add_actor_spawner("observation_hallway_surgery02", "navy_assault_guy");
  add_actor_spawner("observation_hallway_surgery03", "navy_assault_guy");
  add_notetrack_custom_function("observation_hallway_surgery01", undefined, maps\blackout_interrogation::hallway_friendly_think);
  add_notetrack_custom_function("observation_hallway_surgery02", undefined, maps\blackout_interrogation::hallway_friendly_think);
  add_notetrack_custom_function("observation_hallway_surgery03", undefined, maps\blackout_interrogation::hallway_friendly_think);
  add_scene("hallway_surgery", "interrogation_hallway_node", 0, 0, 1);
  add_actor_anim("observation_hallway_surgery01", % ch_command_02_03_hallway_devastation_usnavy06_surgery_loop, 1, 0);
  add_actor_anim("observation_hallway_surgery02", % ch_command_02_03_hallway_devastation_usnavy07_surgery_loop, 1, 0);
  add_actor_anim("observation_hallway_surgery03", % ch_command_02_03_hallway_devastation_usnavy10_surgery_loop, 1, 0);
  add_scene("salazar_exit", "salazar_exit", 1);
  add_actor_anim("salazar", % ch_command_02_07_salazar_exit_sala, 0, 0, 1);
  add_prop_anim("salazar_exit_door", % o_command_02_07_salazar_exit_door);
  add_notetrack_level_notify("salazar", "objective_update", "salazar_exit_update_objective");
  add_notetrack_flag("salazar", "salazar_exit_dialog_done", "salazar_exit_dialog_done");
  add_scene("open_masons_door", "masons_door");
  add_player_anim("player_body", % int_door_open_masons_room, 1, 0, undefined, 1, 1, 15, 15, 12, 10, 1, 1);
  add_prop_anim("masons_door", % o_door_open_masons_room_door);
  precache_assets(1);
}

#using_animtree("player");
#using_animtree("generic_human");

scene_bridge_entry() {
  add_scene("familiar_face", "anim_node_before_cic");
  add_prop_anim("familiar_face_door", % o_command_03_01_sexy_woman_door);
  add_scene("familiar_face_player", "anim_node_before_cic");
  add_player_anim("player_body", % p_command_03_01_sexy_woman_player, 1, 0, undefined, 1, 1, 15, 15, 12, 10, 1, 1);
  add_scene("turret_bridge_intro", "anim_node_before_cic");
  add_actor_anim("turret_intro_guy_1", % ch_command_03_02_turret_reveal_sailor_01, 1, 0, 0, 0, undefined, "reveal_turret_actor");
  add_actor_anim("turret_intro_guy_2", % ch_command_03_02_turret_reveal_sailor_02, 1, 0, 0, 0, undefined, "reveal_turret_actor");
  add_notetrack_custom_function("turret_intro_guy_1", "start_death_anim", maps\blackout_bridge::bridge_turret_fate);
  add_notetrack_custom_function("turret_intro_guy_1", undefined, maps\blackout_bridge::bridge_turret_bloodbath_setup);
  add_notetrack_custom_function("turret_intro_guy_2", undefined, maps\blackout_bridge::bridge_turret_bloodbath_setup);
  add_scene("turret_bridge_intro_first", "anim_node_before_cic");
  add_actor_anim("turret_intro_guy_3", % ch_command_03_02_turret_reveal_sailor_03, 0, 0, 0, 0, undefined, "navy_assault_guy");
  add_notetrack_custom_function("turret_intro_guy_3", undefined, maps\blackout_bridge::bridge_turret_bloodbath_setup);
  add_scene("turret_bridge_fail", "anim_node_before_cic");
  add_actor_anim("turret_intro_guy_1", % ch_command_03_02_turret_reveal_death_sailor_01, 0, 1, 0, 1, undefined, "reveal_turret_actor");
  add_actor_anim("turret_intro_guy_2", % ch_command_03_02_turret_reveal_death_sailor_02, 0, 1, 0, 1, undefined, "reveal_turret_actor");
  precache_assets(1);
}

#using_animtree("player");
#using_animtree("generic_human");

scene_bridge() {
  add_scene("bridge_hacker", "anim_node_cic_front");
  add_player_anim("player_body", % p_command_03_03_cic_player_hack, 1, 0, undefined, 1, 1, 15, 15, 12, 10, 1, 1);
  add_notetrack_custom_function("player_body", undefined, maps\blackout_bridge::play_lockout_bink);
  add_scene_loop("cic_hacker_01_loop", "anim_node_cic");
  add_actor_anim("cic_hacker_01", % ch_command_03_03_cic_hacker_hacker01_idle);
  add_actor_spawner("cic_hacker_01", "bridge_hacker");
  add_scene_loop("cic_hacker_02_loop", "anim_node_cic");
  add_actor_anim("cic_hacker_02", % ch_command_03_03_cic_hacker_hacker02_idle);
  add_actor_spawner("cic_hacker_02", "bridge_hacker");
  add_scene("cic_hacker_01_react", "anim_node_cic");
  add_actor_anim("cic_hacker_01", % ch_command_03_03_cic_hacker_hacker01_react);
  add_scene("cic_hacker_02_react", "anim_node_cic");
  add_actor_anim("cic_hacker_02", % ch_command_03_03_cic_hacker_hacker02_react);
  add_scene("cic_custom_entrances", "anim_node_cic");
  add_actor_anim("cic_custom_01", % ch_command_03_01_pmc_entries_pmc01);
  add_actor_anim("cic_custom_02", % ch_command_03_01_pmc_entries_pmc02);
  add_actor_spawner("cic_custom_01", "bridge_hacker");
  add_actor_spawner("cic_custom_02", "bridge_hacker");
  precache_assets(1);
}

init_corpse_poses() {
  level.scr_anim["on_right_side"]["corpse_pose"] = % ch_gen_m_armover_onrightside_deathpose;
  level.scr_anim["face_down_left_stretch"]["corpse_pose"] = % ch_gen_m_floor_armup_onfront_deathpose;
  level.scr_anim["wall_lean_head_left"]["corpse_pose"] = % ch_gen_m_wall_legspread_armdown_leanright_deathpose;
  level.scr_anim["wall_lean_head_right"]["corpse_pose"] = % ch_gen_m_wall_legspread_armdown_leanleft_deathpose;
  level.scr_anim["face_down_right_shoulder"]["corpse_pose"] = % ch_gen_m_floor_armstretched_onrightside_deathpose;
  level.scr_anim["face_down_left_shoulder"]["corpse_pose"] = % ch_gen_m_floor_armstretched_onleftside_deathpose;
  level.scr_anim["fetal_position"]["corpse_pose"] = % ch_gen_m_floor_armstomach_onrightside_deathpose;
  level.scr_anim["face_down_right_stretch"]["corpse_pose"] = % ch_gen_m_floor_armup_legaskew_onfront_faceright_deathpose;
  level.scr_anim["on_back_twisted_right"]["corpse_pose"] = % ch_gen_m_floor_armspread_legaskew_onback_deathpose;
  level.scr_anim["wall_lean_arm_right"]["corpse_pose"] = % ch_gen_m_wall_armopen_leanright_deathpose;
  level.scr_anim["face_down_twist_left"]["corpse_pose"] = % ch_gen_m_floor_armup_legaskew_onfront_faceleft_deathpose;
  level.scr_anim["face_down_left_arm_up"]["corpse_pose"] = % ch_gen_m_floor_armdown_onfront_deathpose;
  level.scr_anim["on_back_spread_eagle"]["corpse_pose"] = % ch_gen_m_floor_armspreadwide_legspread_onback_deathpose;
  level.scr_anim["on_back_flat"]["corpse_pose"] = % ch_gen_m_floor_armsopen_onback_deathpose;
  level.scr_anim["wall_lean_arm_left"]["corpse_pose"] = % ch_gen_m_wall_armcraddle_leanleft_deathpose;
  level.scr_anim["on_back_head_tilt_left"]["corpse_pose"] = % ch_gen_m_wall_headonly_leanleft_deathpose;
  level.scr_anim["wall_lean_hunch_left"]["corpse_pose"] = % ch_gen_m_wall_legin_armcraddle_hunchright_deathpose;
  level.scr_anim["wall_lean_right_on_stomach"]["corpse_pose"] = % ch_gen_m_wall_low_armstomach_leanleft_deathpose;
  level.scr_anim["on_left_side"]["corpse_pose"] = % ch_gen_m_floor_armrelaxed_onleftside_deathpose;
  level.scr_anim["on_back_head_propped_left"]["corpse_pose"] = % ch_gen_m_wall_headonly_leanleft_deathpose;
  level.scr_anim["on_back_head_right"]["corpse_pose"] = % ch_gen_m_floor_armstomach_onback_deathpose;
  level.scr_anim["wall_lean_armonleg_head_right"]["corpse_pose"] = % ch_gen_m_wall_legspread_armonleg_leanright_deathpose;
  level.scr_anim["cic_body_01"]["corpse_pose"] = % ch_ang_07_01_charred_bodies_guy01;
  level.scr_anim["cic_body_02"]["corpse_pose"] = % ch_ang_07_01_charred_bodies_guy02;
  level.scr_anim["cic_body_03"]["corpse_pose"] = % ch_ang_07_01_charred_bodies_guy03;
}

#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");

scene_security_level() {
  add_scene("ziptied_sailor_01_intro", "rpg_hit_anim");
  add_actor_model_anim("ziptied_sailor_01", % ch_command_03_05_zip_tie_sailor_01, undefined, 0, undefined, undefined, "navy_assault_guy", 1, 0, 0);
  add_notetrack_custom_function("ziptied_sailor_01", undefined, maps\blackout_bridge::ziptie_friendly_think);
  add_scene("ziptied_sailor_02_intro", "rpg_hit_anim");
  add_actor_model_anim("ziptied_sailor_02", % ch_command_03_05_zip_tie_sailor_02, undefined, 0, undefined, undefined, "navy_assault_guy", 1, 0, 0);
  add_notetrack_custom_function("ziptied_sailor_02", undefined, maps\blackout_bridge::ziptie_friendly_think);
  add_scene_loop("ziptied_sailor_01_loop", "rpg_hit_anim");
  add_actor_model_anim("ziptied_sailor_01", % ch_command_03_05_zip_tie_sailor_01_loop, undefined, 0, undefined, undefined, "navy_assault_guy", 1, 0, 0);
  add_scene_loop("ziptied_sailor_02_loop", "rpg_hit_anim");
  add_actor_model_anim("ziptied_sailor_02", % ch_command_03_05_zip_tie_sailor_02_loop, undefined, 0, undefined, undefined, "navy_assault_guy", 1, 0, 0);
  add_scene("ziptied_pmc_01_intro", "rpg_hit_anim");
  add_actor_model_anim("ziptied_pmc_01", % ch_command_03_05_zip_tie_pmc_01, undefined, 0, undefined, undefined, "pmc_assault_guy", 1, 0, 0);
  add_notetrack_custom_function("ziptied_pmc_01", undefined, maps\blackout_bridge::ziptie_enemy_think);
  add_scene_loop("ziptied_pmc_01_loop", "rpg_hit_anim");
  add_actor_model_anim("ziptied_pmc_01", % ch_command_03_05_zip_tie_pmc_01_loop, undefined, 0, undefined, undefined, "pmc_assault_guy", 1, 0, 0);
  add_scene_loop("ziptied_pmc_02_loop", "rpg_hit_anim");
  add_actor_model_anim("ziptied_pmc_02", % ch_command_03_05_zip_tie_pmc_02, undefined, 0, undefined, undefined, "pmc_assault_guy", 1, 0, 0);
  add_notetrack_custom_function("ziptied_pmc_02", undefined, maps\blackout_bridge::ziptie_enemy_think);
  add_scene_loop("ziptied_pmc_03_loop", "rpg_hit_anim");
  add_actor_model_anim("ziptied_pmc_03", % ch_command_03_05_zip_tie_pmc_03, undefined, 0, undefined, undefined, "pmc_assault_guy", 1, 0, 0);
  add_notetrack_custom_function("ziptied_pmc_03", undefined, maps\blackout_bridge::ziptie_enemy_think);
  add_scene("window_throw", "window_throw_anim");
  add_actor_anim("window_throw_pmc", % ch_command_03_05_window_throw_pmc, 0, 1, 0, 1);
  add_actor_anim("window_throw_sailor", % ch_command_03_05_window_throw_sailor, 0, 1, 0, 1);
  add_notetrack_custom_function("window_throw_pmc", "break_glass", maps\blackout_security::window_throw_glass_break);
  add_notetrack_custom_function("window_throw_pmc", undefined, maps\blackout_security::notetrack_window_throw_attach_gun);
  add_notetrack_custom_function("window_throw_pmc", "dropgun", maps\blackout_security::notetrack_window_throw_drop_gun);
  add_scene("window_throw_loop", "window_throw_anim", 0, 0, 1);
  add_actor_anim("window_throw_pmc", % ch_command_03_05_window_throw_pmc_loop, 0, 1, 0, 1);
  add_actor_anim("window_throw_sailor", % ch_command_03_05_window_throw_sailor_loop, 0, 1, 0, 1);
  add_scene("stair_shoot", "stair_shoot_node");
  add_actor_anim("stair_shoot_pmc_ai", % ch_command_03_05_down_the_stairs, 0, 0, 0, 1);
  add_scene("torchcutters_start", "vent_entrance", 1);
  add_actor_anim("torch_guy", % ch_command_03_08_torch_wall_guy_01_in, 1, 1, 0, 1);
  add_scene("torchcutters", "vent_entrance", 0, 0, 1);
  add_actor_anim("torch_guy", % ch_command_03_08_torch_wall_guy_01_loop, 1, 1, 0, 1);
  add_scene("door_bash_left", "vent_entrance");
  add_prop_anim("defend_door_left", % o_command_03_06_door_break_door_01_bashopen, undefined, 0, 0);
  add_actor_anim("door_bash_pmc02", % ch_command_03_06_door_break_pmc_03_death);
  add_scene("door_bash_right", "vent_entrance");
  add_actor_anim("door_bash_pmc", % ch_command_03_06_door_break_pmc_01);
  add_prop_anim("defend_door_right", % o_command_03_06_door_break_door_02_bashopen, undefined, 0, 0);
  precache_assets(1);
}

#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");

scene_menendez_cctv() {
  add_scene("mason_watches_menendez_in_server_room", "vent_entrance");
  add_player_anim("player_body", % p_command_03_08_cctv_access_player, 1, 0, undefined, 1, 1, 15, 15, 12, 10, 1, 1);
  add_actor_anim("server_room_computer_guy", % ch_command_06_04_cctv_access_seal_01, 0, 1, 0, 1, undefined, "server_room_computer_guy");
  add_notetrack_custom_function("player_body", undefined, maps\blackout_security::notetrack_cctv_bink_start);
  add_notetrack_custom_function("player_body", "start_clip_1", maps\blackout_security::cctv_turn_on_left_screen);
  add_notetrack_custom_function("player_body", "start_clip_2", maps\blackout_security::cctv_turn_on_right_screen);
  add_notetrack_custom_function("player_body", "fade", maps\blackout_security::notetrack_fade_to_menendez_section);
  add_scene("soldier_starts_cutting_vent", "vent_entrance");
  add_actor_anim("torch_guy", % ch_command_06_04_cctv_access_torch_seal, 0, 1, 1);
  add_prop_anim("panel", % o_command_06_04_cctv_vent, "p6_mason_vent_panel", 0, 0);
  add_prop_anim("torch", % o_command_06_04_cctv_cutter, "t6_wpn_laser_cutter_prop", 0, 0);
  add_scene("cctv_third_person", "menendez_server_anim_node");
  add_actor_anim("menendez", % ch_command_03_08_cctv_menendez_dez, 0, 0, 1);
  add_scene("briggs_pip", "menendez_server_anim_node");
  add_actor_model_anim("briggs", % ch_command_04_01_salazar_pip_briggs, undefined, 0, undefined, undefined, "briggs");
  add_actor_model_anim("server_worker", % ch_command_04_01_salazar_pip_soldier, undefined, 0, undefined, undefined, "server_worker");
  add_prop_anim("server_worker_chair", % o_command_04_01_salazar_pip_chair, "p6_console_chair_swivel", 0, 0);
  precache_assets(1);
}

#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("animated_props");

scene_cctv_exit() {
  add_scene("cctv_mason_after_exit", "vent_entrance");
  add_player_anim("player_body", % p_command_06_04_cctv_player_exit, 1, 0, undefined, 1, 1, 15, 15, 12, 10, 1, 1);
  add_actor_anim("server_room_computer_guy", % ch_command_06_04_cctv_access_seal_01_exit, 0, 1, 0, 1, undefined, "server_room_computer_guy");
  add_notetrack_custom_function("player_body", "play_vent_anim", maps\blackout_server_room::notetrack_play_vent_anim);
  add_scene("panel_removed_for_vent_access", "vent_entrance");
  add_actor_anim("torch_guy", % ch_command_06_04_cctv_torch_seal_exit, 0, 1, 0, 1);
  add_prop_anim("torch", % o_command_06_04_cctv_cutter_exit, "t6_wpn_laser_cutter_prop", 1, 0);
  add_prop_anim("panel", % o_command_06_04_cctv_vent_exit, "p6_mason_vent_panel", 0, 0);
  add_notetrack_custom_function("panel", undefined, ::set_force_no_cull);
  add_notetrack_custom_function("torch_guy", "vent_collision_off", maps\blackout_server_room::remove_vent_collision);
  add_notetrack_custom_function("torch_guy", undefined, maps\blackout_server_room::notetrack_torch_guy_takes_cover);
  add_notetrack_custom_function("torch_guy", "on_torch", maps\blackout_server_room::notetrack_torch_guy_torch_on);
  add_notetrack_custom_function("torch_guy", "off_torch", maps\blackout_server_room::notetrack_torch_guy_torch_off);
}

#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");

scene_server_room_super_kill() {
  flag_wait("story_stats_loaded");

  if(level.is_defalco_alive && level.is_farid_alive && level.is_karma_alive) {
    add_scene("super_kill_alive_a_idle", "server_anim_node", 0, 0, 1);
    add_actor_anim("karma", % ch_command_04_04_dead_a_karma_idle);
    add_actor_anim("farid", % ch_command_04_04_dead_a_farid_idle);
    add_scene("super_kill_alive_a_react", "server_anim_node");
    add_actor_anim("karma", % ch_command_04_04_dead_a_karma_reaction);
    add_actor_anim("farid", % ch_command_04_04_dead_a_farid_reaction);
    add_scene("super_kill_alive_a_wait", "server_anim_node", 0, 0, 1);
    add_actor_anim("karma", % ch_command_04_04_dead_a_karma_reaction_idle);
    add_actor_anim("farid", % ch_command_04_04_dead_a_farid_reaction_idle);
    add_scene("super_kill_alive_a_deadpose", "server_anim_node", 0, 0, 1);
    add_actor_model_anim("defalco", % ch_command_04_04_alive_a_defalco_deadpose, undefined, 0, undefined, undefined, "defalco", 0, 1);
    add_actor_model_anim("farid", % ch_command_04_04_alive_a_farid_deadpose, undefined, 0, undefined, undefined, "farid", 0, 1);
    add_actor_model_anim("karma", % ch_command_06_03_aftermath_karma_injured_loop, undefined, 0, undefined, undefined, "karma", 1, 0);
    add_notetrack_custom_function("defalco", undefined, ::spawn_defalco_with_head_shot);
    add_notetrack_custom_function("karma", undefined, ::spawn_karma_with_bruised_head);
  }

  if(level.is_defalco_alive && level.is_farid_alive && !level.is_karma_alive) {
    add_scene("super_kill_alive_b_idle", "server_anim_node", 0, 0, 1);
    add_actor_anim("farid", % ch_command_04_04_alive_a_b_farid_idle);
    add_scene("super_kill_alive_b_react", "server_anim_node");
    add_actor_anim("farid", % ch_command_04_04_alive_a_b_farid_reaction);
    add_scene("super_kill_alive_b_wait", "server_anim_node", 0, 0, 1);
    add_actor_anim("farid", % ch_command_04_04_alive_a_b_farid_reaction_loop);
    add_scene("super_kill_alive_b_deadpose", "server_anim_node", 0, 0, 1);
    add_actor_model_anim("defalco", % ch_command_04_04_alive_b_defalco_deadpose, undefined, 0, undefined, undefined, "defalco", 0, 1);
    add_actor_model_anim("farid", % ch_command_04_04_alive_b_farid_deadpose, undefined, 0, undefined, undefined, "farid", 0, 1);
    add_notetrack_custom_function("farid", undefined, ::spawn_farid_with_shot_body);
  }

  if(level.is_defalco_alive && !level.is_farid_alive && level.is_karma_alive) {
    add_scene("super_kill_alive_c_idle", "server_anim_node", 0, 0, 1);
    add_actor_anim("karma", % ch_command_04_04_dead_c_karma_idle);
    add_scene("super_kill_alive_c_react", "server_anim_node");
    add_actor_anim("karma", % ch_command_04_04_dead_c_karma_reaction);
    add_scene("super_kill_alive_c_wait", "server_anim_node", 0, 0, 1);
    add_actor_anim("karma", % ch_command_04_04_dead_c_karma_reaction_loop);
    add_scene("super_kill_alive_c_deadpose", "server_anim_node", 0, 0, 1);
    add_actor_model_anim("karma", % ch_command_04_04_alive_c_karma_deadpose, undefined, 0, undefined, undefined, "karma", 0, 1);
    add_notetrack_custom_function("karma", undefined, ::spawn_karma_with_cut_throat);
  }

  if(!level.is_defalco_alive && level.is_farid_alive && level.is_karma_alive) {
    add_scene("super_kill_dead_a_idle", "server_anim_node", 0, 0, 1);
    add_actor_anim("karma", % ch_command_04_04_dead_a_karma_idle);
    add_actor_anim("farid", % ch_command_04_04_dead_a_farid_idle);
    add_scene("super_kill_dead_a_react", "server_anim_node");
    add_actor_anim("karma", % ch_command_04_04_dead_a_karma_reaction);
    add_actor_anim("farid", % ch_command_04_04_dead_a_farid_reaction);
    add_scene("super_kill_dead_a_wait", "server_anim_node", 0, 0, 1);
    add_actor_anim("karma", % ch_command_04_04_dead_a_karma_reaction_idle);
    add_actor_anim("farid", % ch_command_04_04_dead_a_farid_reaction_idle);
    add_scene("super_kill_dead_a_deadpose", "server_anim_node", 0, 0, 1);
    add_actor_model_anim("farid", % ch_command_04_04_dead_a_farid_deadpose, undefined, 0, undefined, undefined, "farid", 0, 1);
    add_actor_model_anim("karma", % ch_command_06_03_aftermath_karma_injured_loop, undefined, 0, undefined, undefined, "karma", 1, 0);
    add_notetrack_custom_function("farid", undefined, ::spawn_farid_with_shot_body);
    add_notetrack_custom_function("karma", undefined, ::spawn_karma_with_bruised_head);
  }

  if(!level.is_defalco_alive && level.is_farid_alive && !level.is_karma_alive) {
    add_scene("super_kill_dead_b_idle", "server_anim_node", 0, 0, 1);
    add_actor_anim("farid", % ch_command_04_04_dead_b_farid_idle);
    add_scene("super_kill_dead_b_react", "server_anim_node");
    add_actor_anim("farid", % ch_command_04_04_dead_b_farid_reaction);
    add_scene("super_kill_dead_b_wait", "server_anim_node", 0, 0, 1);
    add_actor_anim("farid", % ch_command_04_04_dead_b_farid_reaction_loop);
    add_scene("super_kill_dead_b_deadpose", "server_anim_node", 0, 0, 1);
    add_actor_model_anim("farid", % ch_command_04_04_dead_b_farid_deadpose, undefined, 0, undefined, undefined, "farid", 0, 1);
    add_notetrack_custom_function("farid", undefined, ::spawn_farid_with_shot_body);
  }

  if(!level.is_defalco_alive && !level.is_farid_alive && level.is_karma_alive) {
    add_scene("super_kill_dead_c_idle", "server_anim_node", 0, 0, 1);
    add_actor_anim("karma", % ch_command_04_04_dead_c_karma_idle);
    add_scene("super_kill_dead_c_react", "server_anim_node");
    add_actor_anim("karma", % ch_command_04_04_dead_c_karma_reaction);
    add_scene("super_kill_dead_c_wait", "server_anim_node", 0, 0, 1);
    add_actor_anim("karma", % ch_command_04_04_dead_c_karma_reaction_loop);
    add_scene("super_kill_dead_c_deadpose", "server_anim_node", 0, 0, 1);
    add_actor_model_anim("karma", % ch_command_04_04_alive_c_karma_deadpose, undefined, 0, undefined, undefined, "karma", 0, 1);
    add_notetrack_custom_function("karma", undefined, ::spawn_karma_with_head_shot);
  }

  add_scene("super_kill", "server_anim_node");

  if(level.is_defalco_alive && level.is_farid_alive && level.is_karma_alive) {
    add_player_anim("player_body", % p_command_04_04_alive_a_player, 1);
    add_actor_anim("defalco", % ch_command_04_04_alive_a_defalco);
    add_actor_anim("meat_shield_target_01", % ch_command_04_04_alive_a_guard01, 0, 1, 0, 1);
    add_actor_anim("meat_shield_target_02", % ch_command_04_04_alive_a_guard02, 0, 1, 0, 1);
    add_actor_anim("karma", % ch_command_04_04_alive_a_karma);
    add_actor_anim("salazar", % ch_command_04_04_alive_a_salazar);
    add_actor_anim("farid", % ch_command_04_04_alive_a_farid);
    add_notetrack_custom_function("karma", "react", maps\blackout_menendez_start::notetrack_super_kill_alive_a_karma_react);
    add_notetrack_custom_function("defalco", "react", maps\blackout_menendez_start::notetrack_super_kill_alive_a_defalco_react);
    add_notetrack_custom_function("farid", "react", maps\blackout_menendez_start::notetrack_super_kill_alive_a_farid_react);
    add_notetrack_custom_function("player_body", "go_stinger", ::play_stinger_a);
    add_notetrack_custom_function("salazar", "dof_defalco_pistol_5", maps\createart\blackout_art::notetrack_super_kill_alive_a_dof_5_salazar_pistol);
    add_notetrack_custom_function("salazar", "dof_karma_6", maps\createart\blackout_art::notetrack_super_kill_alive_a_dof_6_karma);
    add_notetrack_custom_function("salazar", "dof_farid_pistol_7", maps\createart\blackout_art::notetrack_super_kill_alive_a_dof_7_farid_pistol);
    add_notetrack_custom_function("salazar", "dof_defalco_8", maps\createart\blackout_art::notetrack_super_kill_alive_a_dof_8_defalco);
    add_notetrack_custom_function("salazar", "dof_farid_9", maps\createart\blackout_art::notetrack_super_kill_alive_a_dof_9_farid);
    add_notetrack_custom_function("salazar", "dof_salazar_10", maps\createart\blackout_art::notetrack_super_kill_alive_a_dof_10_salazar);
  } else if(level.is_defalco_alive && level.is_farid_alive && !level.is_karma_alive) {
    add_player_anim("player_body", % p_command_04_04_alive_b_player, 1);
    add_actor_anim("defalco", % ch_command_04_04_alive_b_defalco);
    add_actor_anim("meat_shield_target_01", % ch_command_04_04_alive_b_guard01);
    add_actor_anim("meat_shield_target_02", % ch_command_04_04_alive_b_guard02);
    add_actor_anim("salazar", % ch_command_04_04_alive_b_salazar);
    add_actor_anim("farid", % ch_command_04_04_alive_b_farid);
    add_notetrack_custom_function("defalco", undefined, maps\blackout_menendez_start::notetrack_super_kill_duel_achievement);
    add_notetrack_custom_function("defalco", "react", maps\blackout_menendez_start::notetrack_super_kill_alive_b_defalco_react);
    add_notetrack_custom_function("farid", "react", maps\blackout_menendez_start::notetrack_super_kill_alive_b_farid_react);
    add_notetrack_custom_function("player_body", "go_stinger", ::play_stinger_b);
    add_notetrack_custom_function("farid", "cough", maps\blackout_menendez_start::notetrack_super_kill_alive_b_farid_cough_blood);
    add_notetrack_custom_function("salazar", "dof_farid_5", maps\createart\blackout_art::notetrack_super_kill_alive_b_dof_5_farid);
    add_notetrack_custom_function("salazar", "dof_farid_pistol_6", maps\createart\blackout_art::notetrack_super_kill_alive_b_dof_6_farid_pistol);
    add_notetrack_custom_function("salazar", "dof_defalco_7", maps\createart\blackout_art::notetrack_super_kill_alive_b_dof_7_defalco);
    add_notetrack_custom_function("salazar", "dof_defalco_pistol_8", maps\createart\blackout_art::notetrack_super_kill_alive_b_8_defalco_pistol);
    add_notetrack_custom_function("salazar", "dof_farid_9", maps\createart\blackout_art::notetrack_super_kill_alive_b_dof_9_farid);
    add_notetrack_custom_function("salazar", "dof_farid_10", maps\createart\blackout_art::notetrack_super_kill_alive_b_dof_10_farid);
    add_notetrack_custom_function("salazar", "dof_salazar_11", maps\createart\blackout_art::notetrack_super_kill_alive_b_dof_11_salazar);
  } else if(level.is_defalco_alive && !level.is_farid_alive && level.is_karma_alive) {
    add_player_anim("player_body", % p_command_04_04_alive_c_player, 1);
    add_actor_anim("defalco", % ch_command_04_04_alive_c_defalco);
    add_actor_anim("meat_shield_target_01", % ch_command_04_04_alive_c_guard01);
    add_actor_anim("meat_shield_target_02", % ch_command_04_04_alive_c_guard02);
    add_actor_anim("salazar", % ch_command_04_04_alive_c_salazar);
    add_actor_anim("karma", % ch_command_04_04_alive_c_karma);
    add_notetrack_custom_function("karma", "react", maps\blackout_menendez_start::notetrack_super_kill_alive_c_karma_react);
    add_notetrack_custom_function("defalco", undefined, maps\blackout_menendez_start::notetrack_super_kill_alive_c_defalco_knife);
    add_notetrack_custom_function("player_body", "go_knife_stinger", ::play_knife_stinger);
    add_notetrack_custom_function("player_body", "go_stinger", ::play_stinger_c);
    add_notetrack_custom_function("salazar", "dof_karma_5", maps\createart\blackout_art::notetrack_super_kill_alive_c_dof_5_karma);
    add_notetrack_custom_function("salazar", "dof_defalco_6", maps\createart\blackout_art::notetrack_super_kill_alive_c_dof_6_defalco);
  } else if(!level.is_defalco_alive && level.is_farid_alive && level.is_karma_alive) {
    add_player_anim("player_body", % p_command_04_04_dead_a_player, 1);
    add_actor_anim("meat_shield_target_01", % ch_command_04_04_dead_a_guard01);
    add_actor_anim("meat_shield_target_02", % ch_command_04_04_dead_a_guard02);
    add_actor_anim("karma", % ch_command_04_04_dead_a_karma);
    add_actor_anim("salazar", % ch_command_04_04_dead_a_salazar);
    add_actor_anim("farid", % ch_command_04_04_dead_a_farid);
    add_notetrack_custom_function("farid", "react", maps\blackout_menendez_start::notetrack_super_kill_dead_a_farid_react);
    add_notetrack_custom_function("karma", "react", maps\blackout_menendez_start::notetrack_super_kill_dead_a_karma_react);
    add_notetrack_custom_function("farid", "cough", maps\blackout_menendez_start::notetrack_super_kill_dead_a_farid_cough_blood);
    add_notetrack_custom_function("player_body", "go_stinger", ::play_stinger_dead_a);
    add_notetrack_custom_function("salazar", "dof_salazar_5", maps\createart\blackout_art::notetrack_super_kill_dead_a_dof_5_salazar);
    add_notetrack_custom_function("salazar", "dof_karma_6", maps\createart\blackout_art::notetrack_super_kill_dead_a_dof_6_karma);
    add_notetrack_custom_function("salazar", "dof_farid_7", maps\createart\blackout_art::notetrack_super_kill_dead_a_dof_7_farid);
    add_notetrack_custom_function("salazar", "dof_karma_8", maps\createart\blackout_art::notetrack_super_kill_dead_a_8_karma);
    add_notetrack_custom_function("salazar", "dof_salazar_9", maps\createart\blackout_art::notetrack_super_kill_dead_a_dof_9_salazar);
    add_notetrack_custom_function("salazar", "dof_karma_10", maps\createart\blackout_art::notetrack_super_kill_dead_a_dof_10_karma);
    add_notetrack_custom_function("salazar", "dof_salazar_11", maps\createart\blackout_art::notetrack_super_kill_dead_a_dof_11_salazar);
  } else if(!level.is_defalco_alive && level.is_farid_alive && !level.is_karma_alive) {
    add_player_anim("player_body", % p_command_04_04_dead_b_player, 1);
    add_actor_anim("meat_shield_target_01", % ch_command_04_04_dead_b_guard01);
    add_actor_anim("meat_shield_target_02", % ch_command_04_04_dead_b_guard02);
    add_actor_anim("salazar", % ch_command_04_04_dead_b_salazar);
    add_actor_anim("farid", % ch_command_04_04_dead_b_farid);
    add_notetrack_custom_function("farid", "react", maps\blackout_menendez_start::notetrack_super_kill_dead_b_farid_react);
    add_notetrack_custom_function("farid", "cough", maps\blackout_menendez_start::notetrack_super_kill_dead_b_farid_cough_blood);
    add_notetrack_custom_function("player_body", "go_stinger", ::play_stinger_dead_b);
    add_notetrack_custom_function("salazar", "dof_farid_5", maps\createart\blackout_art::notetrack_super_kill_dead_b_dof_5_farid);
    add_notetrack_custom_function("salazar", "dof_farid_6", maps\createart\blackout_art::notetrack_super_kill_dead_b_dof_6_farid);
    add_notetrack_custom_function("salazar", "dof_salazar_7", maps\createart\blackout_art::notetrack_super_kill_dead_b_dof_7_salazar);
  } else if(!level.is_defalco_alive && !level.is_farid_alive && level.is_karma_alive) {
    add_player_anim("player_body", % p_command_04_04_dead_c_player, 1);
    add_actor_anim("meat_shield_target_01", % ch_command_04_04_dead_c_guard01);
    add_actor_anim("meat_shield_target_02", % ch_command_04_04_dead_c_guard02);
    add_actor_anim("salazar", % ch_command_04_04_dead_c_salazar);
    add_actor_anim("karma", % ch_command_04_04_dead_c_karma);
    add_notetrack_custom_function("karma", "react", maps\blackout_menendez_start::notetrack_super_kill_dead_c_karma_react);
    add_notetrack_custom_function("player_body", "go_stinger", ::play_stinger_dead_c);
    add_notetrack_custom_function("salazar", "dof_karma_5", maps\createart\blackout_art::notetrack_super_kill_dead_c_dof_5_karma);
    add_notetrack_custom_function("salazar", "dof_salazar_6", maps\createart\blackout_art::notetrack_super_kill_dead_c_dof_6_salazar);
    add_notetrack_custom_function("salazar", "dpf_karma_7", maps\createart\blackout_art::notetrack_super_kill_dead_c_dof_7_karma);
    add_notetrack_custom_function("salazar", "dof_karma_8", maps\createart\blackout_art::notetrack_super_kill_dead_c_dof_8_karma);
  } else {
    add_player_anim("player_body", % p_command_04_04_dead_d_player, 1);
    add_actor_anim("meat_shield_target_01", % ch_command_04_04_dead_d_guard01);
    add_actor_anim("meat_shield_target_02", % ch_command_04_04_dead_d_guard02);
    add_actor_anim("salazar", % ch_command_04_04_dead_d_salazar);
    add_notetrack_custom_function("player_body", "go_stinger", ::play_stinger_dead_d);
    add_notetrack_custom_function("salazar", "dof_salazar_5", maps\createart\blackout_art::notetrack_super_kill_dead_d_dof_5_salazar);
  }

  add_notetrack_custom_function("player_body", "start_slow", maps\blackout_menendez_start::super_kill_slow_start);
  add_notetrack_custom_function("player_body", "end_slow", maps\blackout_menendez_start::super_kill_slow_end);
  add_notetrack_custom_function("meat_shield_target_01", "react", maps\blackout_menendez_start::notetrack_super_kill_guard_1_react);
  add_notetrack_custom_function("meat_shield_target_02", "react", maps\blackout_menendez_start::notetrack_super_kill_guard_2_react);
  add_notetrack_custom_function("salazar", "salazar_fire", maps\blackout_menendez_start::notetrack_super_kill_gun_fx);
  add_notetrack_custom_function("farid", "farid_fire", maps\blackout_menendez_start::notetrack_super_kill_gun_fx);
  add_notetrack_custom_function("defalco", "defalco_fire", maps\blackout_menendez_start::notetrack_super_kill_gun_fx);
  add_notetrack_custom_function("salazar", "dof_salazar_1", maps\createart\blackout_art::notetrack_super_kill_dof_1_salazar);
  add_notetrack_custom_function("salazar", "dof_salazar_2", maps\createart\blackout_art::notetrack_super_kill_dof_2_salazar);
  add_notetrack_custom_function("salazar", "dof_guard01_3", maps\createart\blackout_art::notetrack_super_kill_dof_3_guard01);
  add_notetrack_custom_function("salazar", "dof_guard02_4", maps\createart\blackout_art::notetrack_super_kill_dof_4_guard02);
  add_notetrack_custom_function("meat_shield_target_01", "ground_impact", maps\blackout_menendez_start::notetrack_super_kill_ground_impact);
  add_notetrack_custom_function("meat_shield_target_02", "ground_impact", maps\blackout_menendez_start::notetrack_super_kill_ground_impact);
  add_notetrack_custom_function("defalco", "ground_impact", maps\blackout_menendez_start::notetrack_super_kill_ground_impact);
  add_notetrack_custom_function("farid", "ground_impact", maps\blackout_menendez_start::notetrack_super_kill_ground_impact);
  add_notetrack_custom_function("karma", "ground_impact", maps\blackout_menendez_start::notetrack_super_kill_ground_impact);
  add_notetrack_custom_function("player_body", "camera_cut", maps\blackout_menendez_start::notetrack_super_kill_flash_on_camera_cut);
  add_notetrack_custom_function("player_body", undefined, maps\blackout_menendez_start::notetrack_super_kill_flash_on_camera_cut);
}

play_stinger_a(guy) {
  playsoundatposition("evt_superkill_over", (0, 0, 0));
}

play_stinger_b(guy) {
  playsoundatposition("evt_superkill_over", (0, 0, 0));
}

play_stinger_c(guy) {
  playsoundatposition("evt_superkill_over_c", (0, 0, 0));
}

play_knife_stinger(guy) {
  playsoundatposition("evt_defalco_theme", (0, 0, 0));
}

play_stinger_dead_a(guy) {
  playsoundatposition("evt_superkill_over", (0, 0, 0));
}

play_stinger_dead_b(guy) {
  playsoundatposition("evt_superkill_over", (0, 0, 0));
}

play_stinger_dead_c(guy) {
  playsoundatposition("evt_superkill_over", (0, 0, 0));
}

play_stinger_dead_d(guy) {
  playsoundatposition("evt_superkill_over", (0, 0, 0));
}

spawn_karma_with_cut_throat(ai_karma) {
  ai_karma karma_cut_throat();
}

spawn_karma_with_head_shot(ai_karma) {
  ai_karma karma_head_shot();
}

spawn_karma_with_bruised_head(ai_karma) {
  ai_karma karma_head_bruised();
}

spawn_defalco_with_head_shot(ai_defalco) {
  ai_defalco defalco_shot_head();
}

spawn_farid_with_shot_body(ai_farid) {
  ai_farid farid_body_shot();
}

#using_animtree("player");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("player");

meat_shield_sequence() {
  add_scene("cctv_first_person_defalco", "menendez_server_anim_node");
  add_player_anim("player_body", % p_command_03_08_cctv_menendez_player, 1, 0, undefined, 1, 1, 15, 15, 12, 10, 1, 1);
  add_prop_anim("menendez_start_door", % o_command_03_08_cctv_menendez_door, "p6_blackout_door_server_room");

  if(level.is_defalco_alive)
    anim_defalco = % ch_command_03_08_cctv_menendez_defalco;
  else
    anim_defalco = % ch_command_03_08_cctv_menendez_guy;

  add_actor_anim("defalco", anim_defalco, 0, 1);
  add_scene("console_chair_karma_sit_loop", "server_anim_node");
  add_prop_anim("console_chair", % o_command_06_03_aftermath_chair_karma_sit_loop, "p6_console_chair_swivel");
  add_scene("meat_shield_guard_1_start_idle", "server_anim_node", 0, 0, 1);
  add_actor_anim("meat_shield_target_01", % ch_command_04_04_backup_gaurd_01_idle);
  add_scene("meat_shield_guard_2_start_idle", "server_anim_node", 0, 0, 1);
  add_actor_anim("meat_shield_target_02", % ch_command_04_04_backup_gaurd_02_idle);
  add_scene("meat_shield_briggs_start_idle", "server_anim_node", 0, 0, 1);
  add_actor_anim("briggs", % ch_command_04_02_grabbed_briggs_idle, 1, 1, 0, 1);
  add_scene("meat_shield_worker_start_idle", "server_anim_node", 0, 0, 1);
  add_actor_anim("server_worker", % ch_command_04_02_worker_idle, 1, 1, 0, 1);
  add_scene("meat_shield_salazar_start_idle", "server_anim_node", 0, 0, 1);
  add_actor_anim("salazar", % ch_command_04_04_backup_salazar_idle);
  add_scene("meat_shield_defalco_setup", "server_anim_node", 1, 0, 0);
  add_actor_anim("defalco", % ch_command_04_02_grab_defalco_approach);
  add_notetrack_custom_function("defalco", undefined, maps\blackout_menendez_start::notetrack_defalco_drops_gun_setup);
  add_notetrack_custom_function("defalco", "drop_gun", maps\blackout_menendez_start::notetrack_defalco_drops_gun);
  add_notetrack_custom_function("defalco", "show_pistol", maps\blackout_menendez_start::notetrack_defalco_uses_pistol);
  add_scene("meat_shield_defalco_setup_loop", "server_anim_node", 0, 0, 1);
  add_actor_anim("defalco", % ch_command_04_02_grab_defalco_pilar_loop);
  add_scene("meat_shield_take_briggs_hostage", "server_anim_node", 0, 0, 0);
  add_actor_anim("briggs", % ch_command_04_02_grabbed_briggs, 1, 1, 0, 1);
  add_prop_anim("shield_gun", % o_command_04_02_grab_briggs_gun, "t6_wpn_pistol_judge_prop_world", 0, 0);
  add_player_anim("player_body", % p_command_04_02_grabbed_briggs, 0);
  add_notetrack_custom_function("player_body", "sndChangeMusicState", ::sndchangemusicstate);
  add_notetrack_custom_function("player_body", "Start_reactions", maps\blackout_menendez_start::notetrack_meat_shield_start_reactions);
  add_notetrack_custom_function("player_body", "dof_briggs_back", maps\createart\blackout_art::notetrack_meat_shield_briggs_back);
  add_notetrack_custom_function("player_body", "dof_gun_1", maps\createart\blackout_art::notetrack_meat_shield_gun_1);
  add_notetrack_custom_function("player_body", "dof_distant_gaurd", maps\createart\blackout_art::notetrack_meat_shield_distant_guard);
  add_notetrack_custom_function("player_body", "dof_gaurd_1", maps\createart\blackout_art::notetrack_meat_shield_guard_1);
  add_notetrack_custom_function("player_body", "dof_gaurd_2", maps\createart\blackout_art::notetrack_meat_shield_guard_2);
  add_notetrack_custom_function("player_body", "dof_gaurd_3", maps\createart\blackout_art::notetrack_meat_shield_guard_3);
  add_notetrack_custom_function("player_body", "dof_gaurd_4", maps\createart\blackout_art::notetrack_meat_shield_guard_4);
  add_notetrack_custom_function("player_body", "dof_see_all", maps\createart\blackout_art::notetrack_meat_shield_see_all);
  add_scene("meat_shield_defalco_holds_up_server_worker", "server_anim_node", 0, 0, 0);
  add_actor_anim("defalco", % ch_command_04_02_grab_defalco);
  add_actor_anim("server_worker", % ch_command_04_02_worker_hit, 1, 0, 1);
  add_prop_anim("server_worker_chair", % o_command_04_02_grabbed_briggs_chair, "p6_console_chair_swivel", 0, 0);
  add_notetrack_custom_function("defalco", undefined, ::notetrack_switch_to_sidearm);
  add_scene("meat_shield_take_briggs_hostage_chair", "server_anim_node", 0, 0, 0);
  add_prop_anim("server_worker_chair", % o_command_04_02_grabbed_briggs_chair, "p6_console_chair_swivel", 0, 0);
  add_scene("meat_shield_guards_react_to_briggs_taken_hostage", "server_anim_node", 0, 0, 0);
  add_actor_anim("meat_shield_target_01", % ch_command_04_04_backup_gaurd_01_reaction);
  add_actor_anim("meat_shield_target_02", % ch_command_04_04_backup_gaurd_02_reaction);
  add_scene("meat_shield_salazar_react_to_briggs_taken_hostage", "server_anim_node", 0, 0, 0);
  add_actor_anim("salazar", % ch_command_04_04_backup_salazar_reaction);
  add_scene("meat_shield_guards_react_to_briggs_taken_hostage_loop", "server_anim_node", 0, 0, 1);
  add_actor_anim("meat_shield_target_01", % ch_command_04_04_backup_gaurd_01_killed_loop);
  add_actor_anim("meat_shield_target_02", % ch_command_04_04_backup_gaurd_02_killed_loop);
  add_scene("meat_shield_salazar_react_to_briggs_taken_hostage_loop", "server_anim_node", 0, 0, 1);
  add_actor_anim("salazar", % ch_command_04_04_backup_salazar_backstep_loop);
  add_scene("meat_shield_end_loop", "server_anim_node", 0, 0, 1);
  add_actor_anim("briggs", % ch_command_04_06_kneecap_fight_briggs_loop, 1, 1, 0, 1);
  add_actor_anim("menendez", % ch_command_04_06_kneecap_fight_menendez_loop, 1, 0, 1);
  add_prop_anim("shield_gun", % o_command_04_06_kneecap_fight_gun_loop, "t6_wpn_pistol_judge_prop_world", 0);
  add_player_anim("player_body", % p_command_04_06_kneecap_fight_loop, 0, 0, undefined, 1, 1, 15, 15, 12, 10, 1, 1);
  add_notetrack_custom_function("player_body", undefined, maps\blackout_menendez_start::notetrack_super_kill_player_loop_think);
}

#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("player");
#using_animtree("generic_human");

kneecap_sequence() {
  add_scene("kneecap_start_main", "server_anim_node");
  add_actor_anim("briggs", % ch_command_04_06_kneecap_letgo_briggs, 1, 0);
  add_actor_anim("salazar", % ch_command_04_06_kneecap_letgo_salazar);
  add_prop_anim("shield_gun", % o_command_04_06_kneecap_letgo_gun, "t6_wpn_pistol_judge_prop_world", 1);
  add_player_anim("player_body", % p_command_04_06_kneecap_letgo, 1, 0, undefined, 1, 1, 15, 15, 12, 10, 1, 1);

  if(level.is_defalco_alive) {
    add_scene("kneecap_start_defalco", "server_anim_node");
    add_actor_anim("defalco", % ch_command_04_06_kneecap_letgo_defalco);
    add_notetrack_custom_function("defalco", undefined, ::notetrack_switch_to_sidearm);
  }

  add_scene("kneecap_loop_main", "server_anim_node", 0, 0, 1);
  add_actor_anim("briggs", % ch_command_04_06_kneecap_briggs_hit_wait, 1, 0);
  add_actor_anim("salazar", % ch_command_04_06_kneecap_salazar_hit_wait);

  if(level.is_defalco_alive) {
    add_scene("kneecap_loop_defalco", "server_anim_node", 0, 0, 1);
    add_actor_anim("defalco", % ch_command_04_06_kneecap_defalco_hit_wait);
  }

  add_scene("briggs_shot_fatal", "server_anim_node");
  add_actor_anim("briggs", % ch_command_04_06_kneecap_briggs_headshot, 1, 0);
  add_scene("briggs_shot_fatal_loop", "server_anim_node", 0, 0, 1);
  add_actor_anim("briggs", % ch_command_04_06_kneecap_briggs_deathpose_02, 1, 0);
  add_scene("briggs_shot_again", "server_anim_node");
  add_actor_anim("briggs", % ch_command_04_06_kneecap_briggs_hit_kill, 1, 0);
  add_scene("briggs_shot_again_loop", "server_anim_node", 0, 0, 1);
  add_actor_anim("briggs", % ch_command_04_06_kneecap_briggs_deadpose_01, 1, 0);
  add_scene("briggs_shot_nonfatal", "server_anim_node");
  add_actor_anim("briggs", % ch_command_04_06_kneecap_briggs_hit_first, 1, 0);
  add_scene("briggs_shot_nonfatal_loop", "server_anim_node", 0, 0, 1);
  add_actor_anim("briggs", % ch_command_04_06_kneecap_briggs_hit_injured, 1, 0);
  add_scene("briggs_knockout", "server_anim_node");
  add_actor_anim("briggs", % ch_command_04_06_kneecap_briggs_ko, 1, 0);
  add_actor_anim("salazar", % ch_command_04_06_kneecap_salazar_ko);
  add_scene("briggs_knockout_loop", "server_anim_node", 0, 0, 1);
  add_actor_anim("briggs", % ch_command_04_06_kneecap_briggs_ko_loop, 1, 0);
  add_scene("salazar_chair_wait", "server_anim_node", 0, 0, 1);
  add_actor_anim("salazar", % ch_command_04_06_kneecap_salazar_chair_wait);
  add_scene("briggs_killed_salazar_reacts", "server_anim_node");
  add_actor_anim("salazar", % ch_command_04_06_kneecap_salazar_ko_reaction);
  add_scene("briggs_alive_salazar_reacts", "server_anim_node", 0, 0, 0);
  add_actor_anim("salazar", % ch_command_04_06_kneecap_salazar_ko_reaction_no_vo, 0, 1, 0, 1);
  add_scene("salazar_waits_behind_server_terminal", "server_anim_node", 0, 0, 1);
  add_actor_anim("salazar", % ch_command_04_06_kneecap_salazar_ko_reaction_loop, 0, 1, 1, 1);
  add_notetrack_custom_function("salazar", undefined, ::notetrack_switch_to_sidearm);
  add_scene("briggs_shot_fatal_salazar_reacts_loop", "server_anim_node", 0, 0, 1);
  add_actor_anim("salazar", % ch_command_04_06_kneecap_salazar_shot_reaction_loop);
  add_scene("briggs_shot_defalco_reacts", "server_anim_node");
  add_actor_anim("defalco", % ch_command_04_06_kneecap_defalco_reaction);
  add_scene("briggs_shot_defalco_reacts_loop", "server_anim_node", 0, 0, 1);
  add_actor_anim("defalco", % ch_command_04_06_kneecap_defalco_reaction_loop);
}

salazar_kill_animations() {
  if(!scene_exists("salazar_kill_wait")) {
    add_scene("salazar_kill_wait", "server_anim_node", 0, 0, 1);
    add_actor_anim("salazar", % ch_command_04_04_backup_salazar_backstep_loop);
  }

  if(!scene_exists("salazar_kill")) {
    add_scene("salazar_kill", "server_anim_node");
    add_actor_anim("salazar", % ch_command_04_04_backup_salazar_shooting);
    add_notetrack_custom_function("salazar", undefined, ::notetrack_switch_to_sidearm);
  }

  if(!scene_exists("salazar_kill_victims")) {
    add_scene("salazar_kill_victims", "server_anim_node");
    add_actor_anim("meat_shield_target_01", % ch_command_04_04_backup_gaurd_01_killed);
    add_actor_anim("meat_shield_target_02", % ch_command_04_04_backup_gaurd_02_killed);
  }

  if(!scene_exists("salazar_kill_victims_dead")) {
    add_scene("salazar_kill_victims_dead", "server_anim_node", 0, 0, 1);
    add_actor_model_anim("meat_shield_1_dead", % ch_command_04_04_guard01_deadpose, undefined, 1, undefined, undefined, "meat_shield_target_01", 0, 1);
    add_actor_model_anim("meat_shield_2_dead", % ch_command_04_04_guard02_deadpose, undefined, 1, undefined, undefined, "meat_shield_target_02", 0, 1);
  }
}

#using_animtree("animated_props");
#using_animtree("player");

scene_menendez_hack() {
  add_scene("menendez_hack", "server_anim_node");
  add_prop_anim("eyeball", % o_command_04_07_eyeball_eyeball, "p6_celerium_chip_eye", 1, 1);
  add_prop_anim("eyeball_broken", % o_command_04_07_eyeball_broken_eyeball, "p6_celerium_chip_eye_broken", 0);
  add_scene("menendez_hack_player", "server_anim_node");
  add_player_anim("player_body", % p_command_04_07_eyeball_player, 1, 0, undefined, 1, 1, 15, 15, 20, 0, 1, 1);
  add_notetrack_custom_function("player_body", "smash_eye", maps\blackout_menendez_start::notetrack_eyeball_smash);
  add_notetrack_custom_function("player_body", "start_blink", maps\blackout_menendez_start::notetrack_blink_start);
  add_notetrack_custom_function("player_body", "end_blink", maps\blackout_menendez_start::notetrack_blink_end);
  add_notetrack_custom_function("player_body", "fade_out", maps\blackout_menendez_start::notetrack_fade_to_mason_section);
  add_notetrack_custom_function("player_body", undefined, maps\blackout_menendez_start::notetrack_attach_chip);
  add_notetrack_custom_function("player_body", "plug_chip", maps\blackout_menendez_start::notetrack_start_virus_2_bink);
}

#using_animtree("generic_human");
#using_animtree("animated_props");

torch_wall_scene() {
  add_scene("torch_wall_loop", "vent_entrance", 0, 0, 1);
  add_actor_anim("torch_guy", % ch_command_03_08_torch_wall_guy_01_loop, 1, 1, 0, 1);
  add_scene("torch_wall_panel_first_frame", "vent_entrance");
  add_prop_anim("panel", % o_command_03_08_torch_vent_open, "p6_mason_vent_panel");
  add_scene("torch_wall_panel_open", "vent_entrance");
  add_prop_anim("panel", % o_command_03_08_torch_vent_open, "p6_mason_vent_panel");
  add_scene("torch_wall_panel_idle", "vent_entrance", 0, 0, 1);
  add_prop_anim("panel", % o_command_03_08_torch_vent_idle, "p6_mason_vent_panel");
  precache_assets(1);
}

#using_animtree("generic_human");

player_kick_anim() {
  add_scene("panel_knockdown", "vent_exit");
  add_prop_anim("crawl_space_exit_panel", % o_command_03_08_vent_kick_vent, "p6_mason_second_vent", 0, 1);
  add_scene("panel_knockdown_redshirts", "vent_exit");
  add_actor_anim("redshirt1", % ch_command_03_08_vent_redshirt_01);
  add_actor_anim("redshirt2", % ch_command_03_08_vent_redshirt_02);
}

kick_open_vent() {
  vent = getent("crawl_space_exit", "targetname");
  vent notsolid();
  vent connectpaths();
  vent delete();
}

#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");

mason_arrives_at_cctv_room() {
  cctv_room_computer_guy();
  add_scene("cctv_security_room_door_opens", "vent_entrance", 0, 0, 0);
  add_actor_anim("server_room_door_guy", % ch_command_06_04_cctv_seal_02_enter, 0, 1, 0, 1, undefined, "navy_shotgun_guy");
  add_prop_anim("cctv_room_door", % o_command_06_04_cctv_door_enter, "tag_origin_animate", 0, 1);
  add_prop_anim("cctv_door_torch", % o_command_06_04_cctv_torch2_enter, "t6_wpn_laser_cutter_prop", 0, 0);
  add_notetrack_custom_function("server_room_door_guy", undefined, ::server_room_guy_func);
  add_scene("cctv_security_room_door_waits", "vent_entrance", 0, 0, 1);
  add_actor_anim("server_room_door_guy", % ch_command_06_04_cctv_seal_02_loop, 0, 1, 0, 1, undefined, "navy_shotgun_guy");
  add_prop_anim("cctv_room_door", % o_command_06_04_cctv_door_loop, "tag_origin_animate", 0, 1);
  add_prop_anim("cctv_door_torch", % o_command_06_04_cctv_torch2_loop, "t6_wpn_laser_cutter_prop", 0, 0);
  add_scene("cctv_security_room_door_closes", "vent_entrance", 0, 0, 0);
  add_actor_anim("server_room_door_guy", % ch_command_06_04_cctv_seal_02_exit, 0, 1, 0, 1, undefined, "navy_shotgun_guy");
  add_prop_anim("cctv_room_door", % o_command_06_04_cctv_door_exit, "tag_origin_animate", 0, 1);
  add_prop_anim("cctv_door_torch", % o_command_06_04_cctv_torch2_exit, "t6_wpn_laser_cutter_prop", 0, 0);
  add_notetrack_custom_function("server_room_door_guy", undefined, ::attach_torch_to_character);
  add_notetrack_custom_function("cctv_door_torch", "on_torch", maps\blackout_security::notetrack_server_room_door_guy_torch_fx_start);
  add_notetrack_custom_function("cctv_door_torch", "off_torch", maps\blackout_security::notetrack_server_room_door_guy_torch_fx_stop);
  precache_assets(1);
}

attach_torch_to_character(ai_guy) {
  scene_wait("cctv_security_room_door_closes");
  m_torch = get_ent("cctv_door_torch", "targetname");
  m_torch linkto(ai_guy, "J_Hip_LE");
  m_torch setforcenocull();
  flag_wait("mason_watches_menendez_in_server_room_started");
  m_torch unlink();
  m_torch delete();
}

server_room_guy_func(ai_guy) {
  ai_guy.name = "PO Anthony";
}

#using_animtree("generic_human");
#using_animtree("animated_props");

cctv_room_computer_guy() {
  if(!scene_exists("cctv_access_computer_guy_loop")) {
    add_scene("cctv_access_computer_guy_loop", "vent_entrance", 0, 0, 1);
    add_actor_anim("server_room_computer_guy", % ch_command_06_04_cctv_access_typing_loop_seal_01, 1, 0, 0, 1, undefined, "server_room_computer_guy");
    add_prop_anim("server_room_computer_chair", % o_command_03_08_cctv_access_chair, "p6_console_chair_swivel", 0, 0);
  }
}

#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("player");

aftermath_scene() {
  add_scene("player_kicks_vent_to_server_room", "vent_exit");
  add_player_anim("player_body", % p_command_03_08_vent_kick_in, 1, 0, undefined, 1, 1, 15, 15, 12, 10, 1, 1);
  add_notetrack_custom_function("player_body", "start", ::vent_kick_rumble);
  add_scene("pip_eye", "server_anim_node");
  add_actor_anim("menendez", % ch_command_04_07_eyeball_rewind_menendez, 1, 0, 1);
  add_prop_anim("eyeball", % o_command_04_07_eyeball_rewind_eyeball, "p6_celerium_chip_eye", 1, 1);

  if(!level.player get_story_stat("KARMA_DEAD_IN_KARMA")) {
    if(level.is_karma_alive) {
      add_scene("player_karma_alive", "server_anim_node");
      add_player_anim("player_body", % p_command_06_03_aftermath_computer_karma_alive, 0, 0, undefined, 1, 1, 15, 15, 12, 10, 1, 1);
      add_scene("aftermath_karma_injured", "server_anim_node", 0, 0, 1);
      add_actor_model_anim("karma", % ch_command_06_03_aftermath_karma_injured_loop, undefined, 0, undefined, undefined, "karma", 1, 0);
    }
  }

  add_scene("aftermath_redshirt_1_checks_room", "server_anim_node");
  add_actor_anim("redshirt1", % ch_command_06_03_aftermath_redshirt_01_enter);
  add_scene("aftermath_redshirt_1_checks_room_loop", "server_anim_node");
  add_actor_anim("redshirt1", % ch_command_06_03_aftermath_redshirt_01_sync_loop);
  add_scene("aftermath_console_look_loop", "server_anim_node", 0, 0, 1);
  add_player_anim("player_body", % p_command_06_03_aftermath_loop, 1, 0, undefined, 1, 1, 15, 15, 12, 10, 1, 1);

  if(level.is_karma_alive) {
    add_scene("aftermath_karma_alive", "server_anim_node");
    add_player_anim("player_body", % p_command_06_03_aftermath_start_karma, 0, 0, undefined, 1, 1, 15, 15, 12, 10, 1, 1);
    add_notetrack_custom_function("player_body", undefined, ::notetrack_set_blend_times);
    add_notetrack_custom_function("player_body", "start_karma", maps\blackout_server_room::notetrack_aftermath_karma_uses_computer);
    add_notetrack_custom_function("player_body", "start_briggs", maps\blackout_server_room::notetrack_briggs_exits);
    add_scene("aftermath_karma_walks_to_computer", "server_anim_node");
    add_actor_model_anim("karma", % ch_command_06_03_aftermath_start_karma, undefined, 0, undefined, undefined, "karma", 1, 0);
    add_scene("aftermath_karma_uses_computer", "server_anim_node", 0, 0, 1);
    add_actor_model_anim("karma", % ch_command_06_03_aftermath_karma_computer_loop, undefined, 0, undefined, undefined, "karma", 1, 0);
  } else {
    add_scene("aftermath_karma_dead", "server_anim_node");
    add_player_anim("player_body", % p_command_06_03_aftermath_start, 0, 0, undefined, 1, 1, 15, 15, 12, 10, 1, 1);
    add_notetrack_custom_function("player_body", "start_briggs", maps\blackout_server_room::notetrack_briggs_exits);
    add_notetrack_custom_function("player_body", undefined, ::notetrack_set_blend_times);
  }

  if(level.is_briggs_alive) {
    add_scene("briggs_alive_first_frame", "server_anim_node");
    add_actor_anim("briggs", % ch_command_06_03_aftermath_briggs_enter_loop, 1, 0);
    add_scene("aftermath_briggs_enter", "server_anim_node", 0);
    add_actor_anim("briggs", % ch_command_06_03_aftermath_briggs_enter_loop, 1, 0);
    add_actor_anim("redshirt2", % ch_command_06_03_aftermath_redshirt_02_enter);
    add_scene("aftermath_briggs_wait", "server_anim_node", 0, 0, 1);
    add_actor_anim("briggs", % ch_command_06_03_aftermath_briggs_wait_for_player, 1, 0);
    add_actor_anim("redshirt2", % ch_command_06_03_aftermath_redshirt_02_wait_for_player);
    add_scene("aftermath_briggs_alive", "server_anim_node");
    add_player_anim("player_body", % p_command_06_03_aftermath_briggs, 0, 0, undefined, 1, 1, 15, 15, 12, 10, 1, 1);
    add_scene("aftermath_briggs_exit", "server_anim_node");
    add_actor_anim("briggs", % ch_command_06_03_aftermath_briggs, 1, 0, 1);
    add_actor_anim("redshirt2", % ch_command_06_03_aftermath_redshirt2, 0, 0, 1);
  } else {
    add_scene("redshirt_02_briggs_dead_enter", "server_anim_node", 1);
    add_actor_anim("redshirt2", % ch_command_06_03_aftermath_redshirt_02_brigs_dead_enter);
    add_scene("redshirt_02_briggs_dead_loop", "server_anim_node", 0, 0, 1);
    add_actor_anim("redshirt2", % ch_command_06_03_aftermath_redshirt_02_brigs_dead_loop);
    add_scene("briggs_dead_pose", "server_anim_node", 0, 0, 1);
    add_actor_model_anim("briggs_dead", % ch_command_04_06_kneecap_briggs_deadpose_01, undefined, 1, undefined, undefined, "briggs", 0, 1);
  }

  if(level.is_harper_alive) {
    add_scene("aftermath_harper_alive", "server_anim_node");
    add_player_anim("player_body", % p_command_06_03_aftermath_end_harper, 1, 0, undefined, 1, 1, 15, 15, 12, 10, 1, 1);
    add_actor_anim("harper", % ch_command_06_03_aftermath_end_harper, 0, 1, 0);
  } else {
    add_scene("aftermath_harper_dead", "server_anim_node");
    add_player_anim("player_body", % p_command_06_03_aftermath_end, 1, 0, undefined, 1, 1, 15, 15, 12, 10, 1, 1);
  }
}

#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("player");
#using_animtree("generic_human");

betrayal_scene() {
  add_scene("betrayal_speech_player", "hanger_anim");
  add_player_anim("player_body", % p_command_06_06_betrayal_player_speach, 1, 0, undefined, 1, 1, 15, 15, 12, 10, 1, 1);
  add_scene("betrayal_speech_sal", "hanger_anim");
  add_actor_anim("salazar", % ch_command_06_06_betrayal_salazar_speach, 1);
  add_scene("betrayal_surrender_sal_idle_loop", "hanger_anim", 0, 0, 1);
  add_actor_anim("salazar", % ch_command_06_06_betrayal_salazar_idle, 1);

  if(level.is_harper_alive) {
    add_scene("betrayal_shot", "hanger_anim");
    add_actor_anim("salazar", % ch_command_06_06_betrayal_salazar_shot, 1, 1, 0, 1);
    add_actor_anim("harper", % ch_command_06_06_betrayal_harper_shot, 0, 1, 0, 0);
    add_prop_anim("harper_pistol", % o_command_06_06_betrayal_pistol_shot, "tag_origin_animate", 1, 1);
    add_notetrack_custom_function("harper", undefined, maps\blackout_hangar::notetrack_harper_uses_pistol);
    add_notetrack_custom_function("harper_pistol", "hide_pistol", maps\blackout_hangar::notetrack_harper_hides_pistol);
    add_notetrack_custom_function("harper", "pistol_fire", maps\blackout_hangar::notetrack_harper_shoots_salazar);
    add_notetrack_custom_function("harper", undefined, ::notetrack_set_blend_times_long);
    add_scene("betrayal_shot_player", "hanger_anim");
    add_player_anim("player_body", % p_command_06_06_betrayal_player_shot, 1);
  } else {
    add_scene("betrayal_sal_captured", "hanger_anim");
    add_actor_anim("salazar", % ch_command_06_06_betrayal_salazar_lives, 1, 1, 0, 1);
    add_actor_anim("salazar_captor", % ch_command_06_06_betrayal_redshirt_01_lives, 0, 1, 0, 0);
    add_scene("betrayal_sal_captured_loop", "hanger_anim", 0, 0, 1);
    add_actor_anim("salazar", % ch_command_06_06_betrayal_salazar_lives_loop, 1, 1, 0, 1);
    add_actor_anim("salazar_captor", % ch_command_06_06_betrayal_redshirt_01_lives_loop, 0, 1, 0, 0);
  }

  add_scene("tele_sal", "hanger_anim");
  add_actor_anim("salazar", % ch_command_06_06_betrayal_salazar_surrender, 1);
}

play_sal_punched(guy) {
  run_scene_and_delete("betrayal_surrender_punched");
  run_scene_and_delete("betrayal_surrender_sal_idle_loop");
}

startfov(guy) {
  level.player thread lerp_fov_overtime(1.5, 100);
}

midfov(guy) {
  level.player thread lerp_fov_overtime(1.5, 30);
}

endfov(guy) {
  level.player thread lerp_fov_overtime(1.5, 60);
}

#using_animtree("player");
#using_animtree("animated_props");
#using_animtree("player");

brute_force() {
  add_scene("brute_force_move", "brute_force_align");
  add_player_anim("player_body", % int_specialty_blackout_bruteforce, 1, 0, undefined, 1, 1, 15, 15, 12, 10, 1, 1);
  add_prop_anim("brute_force_jaws", % o_specialty_blackout_bruteforce_jaws, "t6_wpn_jaws_of_life_prop", 1);
  add_prop_anim("brute_force_debris", % o_specialty_blackout_bruteforce_debris);
  add_scene("brute_force_launch", "brute_force_align");
  add_player_anim("player_body", % int_specialty_blackout_bruteforce_console, 1, 0, undefined, 1, 1, 15, 15, 12, 10, 1, 1);
}

#using_animtree("generic_human");
#using_animtree("vehicles");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("vehicles");
#using_animtree("generic_human");
#using_animtree("player");

vtol_escape() {
  add_scene_loop("exit_vtol_crosby_wait", "player_vtol");
  add_actor_anim("crosby", % ch_command_07_07_anderson_take_off_crozby_idle, 1, 0, 0, 1, "tag_origin");

  if(level.is_harper_alive) {
    add_scene("exit_vtol", "anim_node_deck3");
    add_vehicle_anim("player_vtol", % v_command_07_07_anderson_take_off_alt_vtol);
    add_scene("exit_vtol_crosby", "player_vtol");
    add_actor_anim("crosby", % ch_command_07_07_anderson_take_off_alt_crozby, 1, 0, 0, 1, "tag_origin");
    add_notetrack_custom_function("crosby", "shoulder_shot", maps\blackout_deck::notetrack_crosby_gets_shot);
    add_scene_loop("exit_vtol_crosby_death", "player_vtol");
    add_actor_anim("crosby", % ch_command_07_07_anderson_take_off_crozby_death, 1, 0, 0, 1, "tag_origin");
    add_scene("exit_vtol_enemy", "player_vtol");
    add_actor_anim("exit_enemy", % ch_command_07_07_anderson_take_off_alt_enemy, 1, 0, 1, 1, "tag_origin", "pmc_assault_guy");
    add_notetrack_custom_function("exit_enemy", undefined, maps\blackout_deck::notetrack_give_exit_enemy_weapon);
    add_notetrack_custom_function("exit_enemy", "fire_at_crosby", maps\blackout_deck::notetrack_enemy_fires_at_crosby);
    add_scene("exit_vtol_player", "player_vtol");
    add_player_anim("player_body", % p_command_07_07_anderson_take_off_alt_player, 0, 0, "tag_origin");
    add_actor_anim("harper", % ch_command_07_07_anderson_take_off_harper, 0, 1, 0, 1, "tag_origin");
    add_notetrack_custom_function("player_body", "lookat_harper_close", maps\blackout_deck::notetrack_outro_spawn_deck_enemies);
    add_notetrack_custom_function("player_body", "lookat_ship_2", maps\blackout_deck::notetrack_outro_lookat_ship_2);
    add_notetrack_custom_function("player_body", "lookat_ship_3", maps\blackout_deck::notetrack_outro_lookat_ship_3);
  } else {
    add_scene("exit_vtol", "anim_node_deck3");
    add_vehicle_anim("player_vtol", % v_command_07_07_anderson_take_off_vtol);
    add_scene("exit_vtol_crosby", "player_vtol");
    add_actor_anim("crosby", % ch_command_07_07_anderson_take_off_crozby, 1, 0, 0, 1, "tag_origin");
    add_notetrack_custom_function("crosby", "shoulder_shot", maps\blackout_deck::notetrack_crosby_gets_shot);
    add_scene_loop("exit_vtol_crosby_death", "player_vtol");
    add_actor_anim("crosby", % ch_command_07_07_anderson_take_off_crozby_death, 1, 0, 0, 1, "tag_origin");
    add_scene("exit_vtol_enemy", "player_vtol");
    add_actor_anim("exit_enemy", % ch_command_07_07_anderson_take_off_enemy, 1, 0, 1, 1, "tag_origin", "pmc_assault_guy");
    add_notetrack_custom_function("exit_enemy", undefined, maps\blackout_deck::notetrack_give_exit_enemy_weapon);
    add_notetrack_custom_function("exit_enemy", "fire", maps\blackout_deck::notetrack_enemy_fires_at_crosby);
    add_scene("exit_vtol_player", "player_vtol");
    add_player_anim("player_body", % p_command_07_07_anderson_take_off_player, 0, 0, "tag_origin");
    add_notetrack_custom_function("player_body", "lookat_ship", maps\blackout_deck::notetrack_outro_spawn_deck_enemies);
    add_notetrack_custom_function("player_body", "lookat_ship_1", maps\blackout_deck::notetrack_outro_lookat_ship_1);
  }

  add_notetrack_custom_function("player_body", "fade_out", maps\blackout_deck::run_mason_deck_final_fadeout);
  add_notetrack_custom_function("player_body", "button_hit", maps\blackout_deck::run_mason_deck_final_manual);
  add_notetrack_custom_function("player_body", "fire", maps\blackout_deck::run_mason_deck_final_fire);
  precache_assets(1);
}

#using_animtree("animated_props");

f38_crash_into_bridge() {
  add_scene("fa38_crash", "fx_anim_f38_crash_struct");
  add_prop_anim("fa38_flyover", % fxanim_black_f38_bridge_crash_anim, "veh_t6_air_fa38", 1, 0);
  add_notetrack_custom_function("fa38_flyover", undefined, ::f38_init_fake_vehicle);
  add_notetrack_level_notify("fa38_flyover", "f38_bridge_impact", "fxanim_f38_bridge_chunks_start");
  add_notetrack_custom_function("fa38_flyover", "exploder 10680 #start_shooting", ::notetrack_fxanim_f38_fires_guns);
  add_notetrack_custom_function("fa38_flyover", "exploder 10681 #stop_shooting", ::notetrack_fxanim_f38_stops_firing);
  precache_assets(1);
}

f38_crash_rocket_notetrack() {
  rocket_start = getstruct("f38_rocket_struct", "targetname");
  fa38 = getent("fa38_flyover", "targetname");
  fa38 veh_magic_bullet_shield();
  wait 0.7;
  magicbullet("usrpg_magic_bullet_cmd_sp", rocket_start.origin, fa38.origin, undefined, fa38);
}

f38_fire_guns() {
  level endon("f38_stop_firing");
  fa38 = getent("fa38_flyover", "targetname");

  while(true) {
    fa38 fire_turret(1);
    fa38 fire_turret(2);
    wait 0.1;
  }
}

aftermath_vo1(guy) {
  if(level.briggs_loop_aftermath)
    level.player say_dialog("reds_briggs_is_dead_1");
}

aftermath_vo2(guy) {
  if(level.karma_loop_aftermath)
    level.player say_dialog("sect_we_ll_need_our_tech_0");
}

detatch_f38_parts(guy) {
  level.f35 detachall();
  level notify("f38_ready");
  m_elevator = getent("menendez_elevator", "targetname");
  m_elevator setmovingplatformenabled(1);
  m_elevator linkto(level.f35, "origin_animate_jnt");
  m_elevator elevator_think();
}

elevator_think() {
  v_elevator_start_pos = self.origin;
  v_elevator_start_angles = self.angles;

  while(true) {
    if(distance(self.origin, v_elevator_start_pos) >= 576 - 14) {
      self unlink();
      break;
    }

    wait 0.05;
  }

  level waittill("delete_deck_combat");
  self movez(14, 0.05);
  self.angles = v_elevator_start_angles;
}

spawn_crash_f38(guy) {
  level notify("reached_menendez_elevator_top");
  level thread deck_hide_no_mason_rpgs_think();
  run_scene("fa38_crash");
}

deck_hide_no_mason_rpgs_think() {
  level endon("delete_deck_combat");
  a_str_rpgs = array("menendez_deck_rpg", "menendez_deck_rpg2", "menendez_deck_rpg3", "menendez_deck_rpg4", "menendez_deck_rpg5", "menendez_deck_rpg6");

  while(true) {
    str_rpg = random(a_str_rpgs);
    shoot_rpg_from_struct(str_rpg);
    wait(randomfloatrange(1, 2));
  }
}

vent_kick_rumble(player_body) {
  wait 0.5;
  level.player playrumbleonentity("damage_heavy");
  wait 0.5;
  level.player playrumbleonentity("damage_heavy");
}

sndstartalarms(player) {
  level clientnotify("alarm_start");
}

sndchangemusicstate(guy) {
  setmusicstate("BLACKOUT_PRE_SUPERKILL");
}