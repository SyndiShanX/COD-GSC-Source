/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\frontend_sf_b.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_scene;
#include maps\_endmission;
#include maps\frontend_util;
#include maps\war_room_util;

scene_phase_2_end_models() {
  level waittill("globe_up");
  show_globe(1, 0, 0);
  holo_table_exploder_switch(112);
  globe = getent("world_globe", "targetname");
  globe rotateto(level.m_rts_map_angle["so_rts_afghanistan"], 1.0, 0.2, 0.2);
  afghanistan = getent("afghanistan", "script_noteworthy");
  afghanistan show();
  afghanistan thread holo_table_prop_blink_on();
  level waittill("kabul_up");
  globe_show_map("so_rts_afghanistan");
  level waittill("globe_down");
  show_globe(0, 1);
  holo_table_exploder_switch(undefined);
}

scene_pre_briefing() {
  level.player set_story_stat("SO_WAR_HUB_TWO_INTRO", 1);
  india_safe = rts_map_completed("so_rts_mp_drone");
  iran_safe = rts_map_completed("so_rts_mp_dockside");
  scene_name = "";

  if(india_safe && iran_safe)
    scene_name = "sf_b_both_safe";
  else if(india_safe && !iran_safe)
    scene_name = "sf_b_india_safe";
  else if(!india_safe && iran_safe)
    scene_name = "sf_b_iran_safe";
  else
    scene_name = "sf_b_neither_safe";

  level thread run_scene(scene_name);
  wait_network_frame();
  player_body = get_model_or_models_from_scene(scene_name, "player_body");
  player_body attach_data_glove();

  if(scene_name == "sf_b_both_safe") {
    briggs = getent("briggs_ai", "targetname");
    briggs attach("p6_anim_resume", "tag_weapon_left", 1);
  }

  scene_wait(scene_name);

  if(scene_name == "sf_b_both_safe") {
    briggs = getent("briggs_ai", "targetname");
    briggs detach("p6_anim_resume", "tag_weapon_left");
  }

  level thread scene_phase_2_end_models();
  run_scene("phase_2_intro_end");
}

scene_afghanistan_briefing() {
  level endon("skip_sf_briefing");
  level thread scene_afghanistan_models();
  level thread run_scene("afghanistan_breifing_pt1");
  wait_network_frame();
  player_body = get_model_or_models_from_scene("afghanistan_breifing_pt1", "player_body");
  player_body attach_data_glove();
  scene_wait("afghanistan_breifing_pt1");
}

afghanistan_prop_scene(str_scene_name, raise_height) {
  original_pos = self.origin;
  self moveto(self.origin + (0, 0, raise_height), 0.5, 0.2, 0.2);
  self waittill("movedone");
  run_scene(str_scene_name);
  wait_network_frame();
  self moveto(original_pos, 0.5, 0.2, 0.2);
}

scene_afghanistan_models() {
  e_surface = getent("holo_table_surface", "targetname");
  e_angled = getent("holo_table_angled", "targetname");

  if(isDefined(level.e_surface_default_origin)) {
    e_surface.origin = level.e_surface_default_origin;
    e_surface.angles = level.e_surface_default_angles;
  }

  afghani_models = [];
  base = spawn("script_model", (0, 0, 0));
  base.angles = vectorscale((0, 1, 0), 90.0);
  base setmodel("p6_hologram_af_base_map");
  afghani_models[afghani_models.size] = base;
  base play_fx("fx_dockside_base", base.origin, base.angles, "stop_geo_fx", 1, "tag_origin");
  cougar = spawn("script_model", (0, 0, 0));
  cougar.angles = (0, 0, 0);
  cougar setmodel("p6_hologram_cougar_combined");
  afghani_models[afghani_models.size] = cougar;
  arrow = spawn("script_model", (0, 0, 0));
  arrow.angles = (0, 0, 0);
  arrow setmodel("p6_hologram_af_path_arrow");
  afghani_models[afghani_models.size] = arrow;

  for(i = 0; i < afghani_models.size; i++)
    afghani_models[i] ignorecheapentityflag(1);

  level waittill("afghan_up");
  holo_table_exploder_switch(115);
  base.origin = e_surface.origin - vectorscale((0, 0, 1), 5.0);
  base setclientflag(15);
  base thread rotate_indefinitely(480);
  level waittill("convoy_up");
  arrow.origin = base.origin;
  arrow.angles = base.angles;
  arrow setclientflag(15);
  arrow linkto(base);
  level waittill("cougar_up");
  level thread holo_table_feature_prop("p6_hologram_cougar_combined", "cougar_down", 1, undefined, vectorscale((0, 0, -1), 24.0));
  level waittill("cougar_down");
  wait 3.0;
  level thread holo_table_feature_prop("p6_hologram_quadrotor_combined", "asd_down", 1, undefined, (48, 0, -14), "q_rotor", 0);
  level thread holo_table_feature_prop("p6_hologram_vtol_combined", "asd_down", 1, undefined, vectorscale((0, 0, -1), 26.0), "vtol", 0);
  level thread holo_table_feature_prop("p6_hologram_asd_combined", "asd_down", 1, undefined, (-48, 0, -26), "asd", 0);
  prop_raise_amount = 16;
  level waittill("q_rotor_up");
  quad = getent("q_rotor", "targetname");
  afghani_models[afghani_models.size] = quad;
  quad thread afghanistan_prop_scene("quad_explode", prop_raise_amount);
  level waittill("vtol_up");
  vtol = getent("vtol", "targetname");
  afghani_models[afghani_models.size] = vtol;
  vtol thread afghanistan_prop_scene("vtol_explode", prop_raise_amount);
  level waittill("asd_up");
  asd = getent("asd", "targetname");
  afghani_models[afghani_models.size] = asd;
  asd thread afghanistan_prop_scene("asd_explode", prop_raise_amount);
  scene_wait("asd_explode");
  wait 2.0;
  base notify("stop_geo_fx");
  asd moveto(asd.origin - (0, 0, prop_raise_amount), 1.0, 0.2, 0.2);
  holo_table_exploder_switch(undefined);

  foreach(prop in afghani_models) {
    if(!is_true(prop.derezzed)) {
      prop clearclientflag(15);
      prop.derezzed = 1;
    }
  }

  level waittill("afghan_fade_out");
  fade_out(1.0);
  wait 1.0;
  array_delete(afghani_models);
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
#using_animtree("animated_props");

initialize_scenes() {
  add_scene("sf_b_both_safe", "align_frontend");
  add_actor_anim("briggs", % ch_brf_phase2_iran_safe_india_safe_briggs);
  add_player_anim("player_body", % p_brf_phase2_iran_safe_india_safe_player, 0, 0, undefined, 1, 1, 25, 25, 15, 15);
  add_actor_model_anim("troop_01", % ch_brf_phase2_iran_safe_india_safe_troop1);
  add_actor_model_anim("troop_02", % ch_brf_phase2_iran_safe_india_safe_troop2);
  add_actor_model_anim("troop_03", % ch_brf_phase2_iran_safe_india_safe_troop3);
  add_actor_model_anim("troop_04", % ch_brf_phase2_iran_safe_india_safe_troop4);
  add_actor_model_anim("troop_05", % ch_brf_phase2_iran_safe_india_safe_troop5);
  add_actor_spawner("troop_01", "gov");
  add_actor_spawner("troop_02", "gov");
  add_actor_spawner("troop_03", "gov");
  add_actor_spawner("troop_04", "gov");
  add_actor_spawner("troop_05", "gov");
  add_scene("sf_b_india_safe", "align_frontend");
  add_actor_anim("briggs", % ch_brf_phase2_iran_danger_india_safe_briggs);
  add_player_anim("player_body", % p_brf_phase2_iran_danger_india_safe_player, 0, 0, undefined, 1, 1, 25, 25, 15, 15);
  add_actor_model_anim("troop_01", % ch_brf_phase2_iran_danger_india_safe_troop1);
  add_actor_model_anim("troop_02", % ch_brf_phase2_iran_danger_india_safe_troop2);
  add_actor_model_anim("troop_03", % ch_brf_phase2_iran_danger_india_safe_troop3);
  add_actor_model_anim("troop_04", % ch_brf_phase2_iran_danger_india_safe_troop4);
  add_actor_model_anim("troop_05", % ch_brf_phase2_iran_danger_india_safe_troop5);
  add_actor_spawner("troop_01", "gov");
  add_actor_spawner("troop_02", "gov");
  add_actor_spawner("troop_03", "gov");
  add_actor_spawner("troop_04", "gov");
  add_actor_spawner("troop_05", "gov");
  add_scene("sf_b_iran_safe", "align_frontend");
  add_actor_anim("briggs", % ch_brf_phase2_iran_safe_india_danger_briggs);
  add_player_anim("player_body", % p_brf_phase2_iran_safe_india_danger_player, 0, 0, undefined, 1, 1, 25, 25, 15, 15);
  add_actor_model_anim("troop_01", % ch_brf_phase2_iran_safe_india_danger_troop1);
  add_actor_model_anim("troop_02", % ch_brf_phase2_iran_safe_india_danger_troop2);
  add_actor_model_anim("troop_03", % ch_brf_phase2_iran_safe_india_danger_troop3);
  add_actor_model_anim("troop_04", % ch_brf_phase2_iran_safe_india_danger_troop4);
  add_actor_model_anim("troop_05", % ch_brf_phase2_iran_safe_india_danger_troop5);
  add_actor_spawner("troop_01", "gov");
  add_actor_spawner("troop_02", "gov");
  add_actor_spawner("troop_03", "gov");
  add_actor_spawner("troop_04", "gov");
  add_actor_spawner("troop_05", "gov");
  add_scene("sf_b_neither_safe", "align_frontend");
  add_actor_anim("briggs", % ch_brf_phase2_iran_danger_india_danger_briggs);
  add_player_anim("player_body", % p_brf_phase2_iran_danger_india_danger_player, 0, 0, undefined, 1, 1, 25, 25, 15, 15);
  add_actor_model_anim("troop_01", % ch_brf_phase2_iran_danger_india_danger_troop1);
  add_actor_model_anim("troop_02", % ch_brf_phase2_iran_danger_india_danger_troop2);
  add_actor_model_anim("troop_03", % ch_brf_phase2_iran_danger_india_danger_troop3);
  add_actor_model_anim("troop_04", % ch_brf_phase2_iran_danger_india_danger_troop4);
  add_actor_model_anim("troop_05", % ch_brf_phase2_iran_danger_india_danger_troop5);
  add_actor_spawner("troop_01", "gov");
  add_actor_spawner("troop_02", "gov");
  add_actor_spawner("troop_03", "gov");
  add_actor_spawner("troop_04", "gov");
  add_actor_spawner("troop_05", "gov");
  add_scene("afghanistan_breifing_pt1", "align_frontend");
  add_actor_anim("briggs", % ch_brf_phase2_afghanistan_briggs);
  add_player_anim("player_body", % p_brf_phase2_afghanistan_player, 0, 0, undefined, 1, 1, 25, 25, 15, 15);
  add_notetrack_level_notify("player_body", "afghan_up", "afghan_up");
  add_notetrack_level_notify("player_body", "convoy_up", "convoy_up");
  add_notetrack_level_notify("player_body", "cougar_up", "cougar_up");
  add_notetrack_level_notify("player_body", "cougar_down", "cougar_down");
  add_notetrack_level_notify("player_body", "q_rotorr_up", "q_rotor_up");
  add_notetrack_level_notify("player_body", "q_rotor_explode", "q_rotor_explode");
  add_notetrack_level_notify("player_body", "q_rotor_down", "q_rotor_down");
  add_notetrack_level_notify("player_body", "vtol_up", "vtol_up");
  add_notetrack_level_notify("player_body", "vtol_explode", "vtol_explode");
  add_notetrack_level_notify("player_body", "vtol_down", "vtol_down");
  add_notetrack_level_notify("player_body", "asd_up", "asd_up");
  add_notetrack_level_notify("player_body", "asd_explode", "asd_explode");
  add_notetrack_level_notify("player_body", "asd_down", "asd_down");
  add_notetrack_level_notify("player_body", "fade_out", "afghan_fade_out");
  add_actor_model_anim("troop_01", % ch_brf_phase2_afghanistan_troop1);
  add_actor_model_anim("troop_02", % ch_brf_phase2_afghanistan_troop2);
  add_actor_model_anim("troop_03", % ch_brf_phase2_afghanistan_troop3);
  add_actor_model_anim("troop_04", % ch_brf_phase2_afghanistan_troop4);
  add_actor_model_anim("troop_05", % ch_brf_phase2_afghanistan_troop5);
  add_actor_spawner("troop_01", "gov");
  add_actor_spawner("troop_02", "gov");
  add_actor_spawner("troop_03", "gov");
  add_actor_spawner("troop_04", "gov");
  add_actor_spawner("troop_05", "gov");
  add_scene("phase_2_intro_end", "align_frontend");
  add_actor_anim("briggs", % ch_brf_phase2_afghan_end_briggs);
  add_player_anim("player_body", % p_brf_phase2_afghan_end_player, 0, 0, undefined, 1, 1, 25, 25, 15, 15);
  add_notetrack_level_notify("player_body", "globe_up", "globe_up");
  add_notetrack_level_notify("player_body", "kabul_up", "kabul_up");
  add_notetrack_level_notify("player_body", "globe_down", "globe_down");
  add_actor_model_anim("troop_01", % ch_brf_phase2_afghan_end_troop1);
  add_actor_model_anim("troop_02", % ch_brf_phase2_afghan_end_troop2);
  add_actor_model_anim("troop_03", % ch_brf_phase2_afghan_end_troop3);
  add_actor_model_anim("troop_04", % ch_brf_phase2_afghan_end_troop4);
  add_actor_model_anim("troop_05", % ch_brf_phase2_afghan_end_troop5);
  add_actor_spawner("troop_01", "gov");
  add_actor_spawner("troop_02", "gov");
  add_actor_spawner("troop_03", "gov");
  add_actor_spawner("troop_04", "gov");
  add_actor_spawner("troop_05", "gov");
  add_scene("quad_explode", "align_frontend", undefined, undefined, undefined, 1);
  add_prop_anim("q_rotor", % w_brf_holo_quadrotor_anim, "p6_hologram_quadrotor_combined", 0);
  add_scene("vtol_explode", "align_frontend", undefined, undefined, undefined, 1);
  add_prop_anim("vtol", % v_brf_holo_vtol_anim, "p6_hologram_vtol_combined", 0);
  add_scene("asd_explode", "align_frontend", undefined, undefined, undefined, 1);
  add_prop_anim("asd", % w_brf_holo_asd_anim, "p6_hologram_asd_combined", 0);
}