/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\frontend_anim.gsc
**************************************/

#include maps\_anim;
#include maps\_scene;
#include maps\_utility;
#include common_scripts\utility;
#include maps\voice\voice_frontend;
#include maps\frontend_sf_a;
#include maps\frontend_sf_b;
#include maps\frontend_sf_c;

main() {
  maps\voice\voice_frontend::init_voice();
  anim_load_frontend_global();
  anim_load_strikeforce();
  anim_load_strikeforce_responses();
  anim_load_ambient_scenes();
  anim_load_vtol_ambient_scenes();
  precache_assets();
}

#using_animtree("generic_human");

anim_load_ambient_scenes() {
  add_scene_loop("ambient_01", "align_frontend");
  add_actor_model_anim("amb_01_01", % ch_frontend_ambient_bridge1_guy1);
  add_actor_model_anim("amb_01_02", % ch_frontend_ambient_bridge1_guy2);
  add_actor_model_anim("amb_01_03", % ch_frontend_ambient_bridge1_guy3);
  add_actor_model_anim("amb_01_04", % ch_frontend_ambient_bridge1_guy4);
  add_actor_model_anim("amb_01_05", % ch_frontend_ambient_bridge1_guy5);
  add_actor_spawner("amb_01_01", "gov");
  add_actor_spawner("amb_01_02", "gov");
  add_actor_spawner("amb_01_03", "gov");
  add_actor_spawner("amb_01_04", "gov");
  add_actor_spawner("amb_01_05", "gov");
  add_scene_loop("ambient_02", "align_frontend");
  add_actor_model_anim("amb_02_01", % ch_frontend_ambient_bridge2_guy1);
  add_actor_model_anim("amb_02_02", % ch_frontend_ambient_bridge2_guy2);
  add_actor_model_anim("amb_02_03", % ch_frontend_ambient_bridge2_guy3);
  add_actor_model_anim("amb_02_04", % ch_frontend_ambient_bridge2_guy4);
  add_actor_model_anim("amb_02_05", % ch_frontend_ambient_bridge2_guy5);
  add_actor_spawner("amb_02_01", "gov");
  add_actor_spawner("amb_02_02", "gov");
  add_actor_spawner("amb_02_03", "gov");
  add_actor_spawner("amb_02_04", "gov");
  add_actor_spawner("amb_02_05", "gov");
  add_scene_loop("ambient_03", "align_frontend");
  add_actor_model_anim("amb_03_01", % ch_frontend_ambient_bridge3_guy1);
  add_actor_model_anim("amb_03_02", % ch_frontend_ambient_bridge3_guy2);
  add_actor_model_anim("amb_03_03", % ch_frontend_ambient_bridge3_guy3);
  add_actor_model_anim("amb_03_04", % ch_frontend_ambient_bridge3_guy4);
  add_actor_model_anim("amb_03_05", % ch_frontend_ambient_bridge3_guy5);
  add_actor_spawner("amb_03_01", "gov");
  add_actor_spawner("amb_03_02", "gov");
  add_actor_spawner("amb_03_03", "gov");
  add_actor_spawner("amb_03_04", "gov");
  add_actor_spawner("amb_03_05", "gov");
  add_scene_loop("ambient_04", "align_frontend");
  add_actor_model_anim("amb_04_01", % ch_frontend_ambient_bridge4_guy1);
  add_actor_model_anim("amb_04_02", % ch_frontend_ambient_bridge4_guy2);
  add_actor_model_anim("amb_04_03", % ch_frontend_ambient_bridge4_guy3);
  add_actor_model_anim("amb_04_04", % ch_frontend_ambient_bridge4_guy4);
  add_actor_model_anim("amb_04_05", % ch_frontend_ambient_bridge4_guy5);
  add_actor_spawner("amb_04_01", "gov");
  add_actor_spawner("amb_04_02", "gov");
  add_actor_spawner("amb_04_03", "gov");
  add_actor_spawner("amb_04_04", "gov");
  add_actor_spawner("amb_04_05", "gov");
  add_scene_loop("ambient_05", "align_frontend");
  add_actor_model_anim("amb_05_01", % ch_frontend_ambient_bridge5_guy1);
  add_actor_model_anim("amb_05_02", % ch_frontend_ambient_bridge5_guy2);
  add_actor_model_anim("amb_05_03", % ch_frontend_ambient_bridge5_guy3);
  add_actor_model_anim("amb_05_04", % ch_frontend_ambient_bridge5_guy4);
  add_actor_spawner("amb_05_01", "gov");
  add_actor_spawner("amb_05_02", "gov");
  add_actor_spawner("amb_05_03", "gov");
  add_actor_spawner("amb_05_04", "gov");
}

anim_load_vtol_ambient_scenes() {
  add_scene_loop("vtol_ambient_00", "vtol_anim_align");
  add_actor_model_anim("vtol_pilot", % ch_frontend_vtol_cruise_pilot);
  add_actor_model_anim("vtol_copilot", % ch_frontend_vtol_cruise_copilot);
  add_actor_model_anim("vtol_guy", % ch_frontend_vtol_cruise_guy);
  add_actor_spawner("vtol_pilot", "gov");
  add_actor_spawner("vtol_copilot", "gov");
  add_actor_spawner("vtol_guy", "gov");
}

#using_animtree("player");
#using_animtree("animated_props");
#using_animtree("player");

anim_load_frontend_global() {
  add_scene("glasses_on", "player_align_node", 0, 0, 0);
  add_player_anim("player_body", % int_sunglasses_on_frontend);
  add_prop_anim("glasses", % o_sunglasses_on_frontend, "p6_sunglasses", 1, 0);
  add_notetrack_flag("player_body", "glasses_on", "glasses_on");
  add_notetrack_flag("player_body", "glasses_tint", "glasses_tint");
  add_notetrack_flag("player_body", "tint_gone", "tint_gone");
  add_notetrack_flag("player_body", "holotable", "holotable_on");
  add_notetrack_flag("player_body", "headsupdisplay", "headsupdisplay");
  add_scene_loop("data_glove_idle", "player_align_node", 0, 0, 0);
  add_player_anim("player_body", % int_data_glove_gameselect_idle);
  add_scene("data_glove_start", "player_align_node", 0, 0, 0, 0);
  add_player_anim("player_body", % int_data_glove_gameselect_pullout);
  add_scene("data_glove_start_fast", "player_align_node", 0, 0, 0, 0);
  add_player_anim("player_body", % int_data_glove_pullout_alt);
  add_scene("data_glove_input", "player_align_node", 0, 0, 0, 0);
  add_player_anim("player_body", % int_data_glove_gameselect_input);
  add_scene("data_glove_finish", "player_align_node", 0, 0, 0, 0);
  add_player_anim("player_body", % int_data_glove_gameselect_putaway, 1);
}

anim_load_strikeforce_responses() {
  add_scene("player_look_at_war_map", "align_frontend");
  add_player_anim("player_body", % p_brf_good_bad_job, 0, 0, undefined);
  add_scene("player_war_map_to_globe", "align_frontend");
  add_player_anim("player_body", % p_frontend_player_debrief2_table_positive, 0, 0, undefined, 1, 1, 25, 25, 15, 15);
}

#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");

anim_load_strikeforce() {
  add_scene("sf_table_to_corner", "align_frontend");
  add_player_anim("player_body", % p_frontend_mapchoice_exit_idle, 1, 0, undefined, 1, 1, 25, 25, 15, 15);
  add_scene("sf_corner_to_table", "align_frontend");
  add_player_anim("player_body", % p_frontend_mapchoice_enter_idle, 0, 0, undefined, 1, 1, 25, 25, 15, 15);
  add_scene("sf_player_choice", "align_frontend", 0, 0, 1);
  add_player_anim("player_body", % ch_brf_wait_idle_player, 1, 0, undefined, 1, 1, 0, 0, 0, 0);
  add_scene("sf_briggs_idle", "align_frontend", 0, 0, 1);
  add_actor_anim("briggs", % ch_war_hub_a_idle_briggs);
  add_scene("sf_a_player_reenter", "align_frontend");
  add_player_anim("player_body", % p_frontend_mapchoice_enter, 0, 0, undefined, 1, 1, 25, 25, 15, 15);
  add_scene("sf_audience_intro", "align_frontend");
  add_actor_model_anim("gov01", % ch_frontend_ambient_team_idle_guy1);
  add_actor_model_anim("gov02", % ch_frontend_ambient_team_idle_guy2);
  add_actor_model_anim("gov03", % ch_frontend_ambient_team_idle_guy3);
  add_actor_model_anim("seal01", % ch_frontend_ambient_team_idle_guy4);
  add_actor_model_anim("seal02", % ch_frontend_ambient_team_idle_guy5);
  add_actor_spawner("gov01", "gov");
  add_actor_spawner("gov02", "gov");
  add_actor_spawner("gov03", "gov");
  add_actor_spawner("seal01", "gov");
  add_actor_spawner("seal02", "gov");
  add_scene("sf_audience_loop", "align_frontend", 0, 0, 1);
  add_actor_model_anim("gov01", % ch_frontend_ambient_team_idle_guy1, undefined, 0, undefined, undefined, "");
  add_actor_model_anim("gov02", % ch_frontend_ambient_team_idle_guy2);
  add_actor_model_anim("gov03", % ch_frontend_ambient_team_idle_guy3);
  add_actor_model_anim("seal01", % ch_frontend_ambient_team_idle_guy4);
  add_actor_model_anim("seal02", % ch_frontend_ambient_team_idle_guy5);
  add_actor_spawner("gov01", "gov");
  add_actor_spawner("gov02", "gov");
  add_actor_spawner("gov03", "gov");
  add_actor_spawner("seal01", "gov");
  add_actor_spawner("seal02", "gov");
  add_scene("sf_audience_exit", "align_frontend");
  add_actor_model_anim("gov01", % ch_frontend_team_exit_guy1);
  add_actor_model_anim("gov02", % ch_frontend_team_exit_guy2);
  add_actor_model_anim("gov03", % ch_frontend_team_exit_guy3);
  add_actor_model_anim("seal01", % ch_frontend_team_exit_guy4);
  add_actor_model_anim("seal02", % ch_frontend_team_exit_guy5);
  add_actor_spawner("gov01", "gov");
  add_actor_spawner("gov02", "gov");
  add_actor_spawner("gov03", "gov");
  add_actor_spawner("seal01", "gov");
  add_actor_spawner("seal02", "gov");
  maps\frontend_sf_a::initialize_scenes();
  maps\frontend_sf_b::initialize_scenes();
  maps\frontend_sf_c::initialize_scenes();
}