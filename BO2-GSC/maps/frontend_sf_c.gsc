/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\frontend_sf_c.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_scene;
#include maps\_endmission;
#include maps\frontend_util;
#include maps\war_room_util;

get_num_territories_conquered() {
  map_names = array("so_rts_mp_dockside", "so_rts_mp_drone", "so_rts_afghanistan");
  num_completed = 0;

  foreach(name in map_names) {
    if(rts_map_completed(name))
      num_completed++;
  }

  return num_completed;
}

show_territories_conquered(str_end_msg) {
  map_names = array("so_rts_mp_dockside", "so_rts_mp_drone", "so_rts_afghanistan");

  foreach(index, name in map_names) {
    if(rts_map_completed(name)) {
      set_world_map_tint(index, 3);
      continue;
    }

    level thread war_map_blink_country(index, 2, str_end_msg);
  }
}

scene_pre_briefing_models(str_endon) {
  level waittill("map_up");
  e_surface = getent("holo_table_surface", "targetname");
  level.e_surface_default_origin = e_surface.origin;
  level.e_surface_default_angles = e_surface.angles;
  e_surface.angles = vectorscale((0, 1, 0), 240.0);
  e_surface.origin = (43, 471, 480);
  e_angled = getent("holo_table_angled", "targetname");
  e_angled.origin = (e_surface.origin[0], e_surface.origin[1], e_angled.origin[2]);
  e_angled.angles = (0, 240, 20);
  prop_base = spawn_model("p6_hologram_so_base_map", e_surface.origin, e_surface.angles);
  prop_base ignorecheapentityflag(1);
  prop_base setclientflag(15);
  wait_network_frame();
  prop_buildings = [];

  for(i = 1; i <= 5; i++) {
    tag_name = "j_target_bldg_0" + i;
    prop_origin = prop_base gettagorigin(tag_name);
    prop_angles = prop_base gettagangles(tag_name);
    prop_building = spawn_model("p6_hologram_so_target_bldg_0" + i, prop_origin, prop_angles);
    prop_building linkto(prop_base, tag_name);
    prop_buildings[prop_buildings.size] = prop_building;
    prop_building setclientflag(15);
  }

  prop_origin = prop_base gettagorigin("j_target_rock_01");
  prop_angles = prop_base gettagangles("j_target_rock_01");
  prop_rock = spawn_model("p6_hologram_so_target_rock_01", prop_origin, prop_base.angles);
  prop_rock linkto(prop_base, "j_target_rock_01");
  prop_rock setclientflag(15);
  holo_table_exploder_switch(115);
  level waittill("map_down");
  holo_table_exploder_switch(undefined);
  prop_base clearclientflag(15);

  for(i = 0; i < prop_buildings.size; i++)
    prop_buildings[i] clearclientflag(15);

  prop_rock clearclientflag(15);
  wait 2;
  prop_base delete();

  for(i = 0; i < prop_buildings.size; i++)
    prop_buildings[i] delete();

  prop_rock delete();
}

scene_pre_briefing() {
  level.player set_story_stat("SO_WAR_HUB_THREE_INTRO", 1);
  show_globe(0);
  numsafe = get_num_territories_conquered();
  scene_name = "";

  switch (numsafe) {
    case 3:
      scene_name = "phase_3_numsafe_3";
      break;
    case 2:
      scene_name = "phase_3_numsafe_2";
      break;
    case 1:
      scene_name = "phase_3_numsafe_1";
      break;
    case 0:
      scene_name = "phase_3_numsafe_0";
      break;
  }

  b_karma_captured = level.player get_story_stat("KARMA_CAPTURED");
  b_last_scene = scene_name;
  a_scenes = array(scene_name);

  if(b_karma_captured) {
    b_last_scene = "phase_3_ending";
    a_scenes = array(scene_name, "phase_3_ending");
  }

  str_endon = scene_name + "_done";
  level thread show_territories_conquered(str_endon);
  level thread run_scene(scene_name);
  wait_network_frame();
  player_body = get_model_or_models_from_scene(scene_name, "player_body");
  player_body attach_data_glove();
  scene_wait(scene_name);

  if(b_karma_captured) {
    level thread scene_pre_briefing_models();
    run_scene("phase_3_ending");
  }
}

scene_pre_briefing_phase4() {
  skip_intro = level.player get_story_stat("SO_WAR_PAKISTAN_INTRO") != 0;

  if(skip_intro) {
    return;
  }
  level.player set_story_stat("SO_WAR_PAKISTAN_INTRO", 1);
  level thread run_scene("phase_4_intro");
  wait_network_frame();
  player_body = get_model_or_models_from_scene("phase_4_intro", "player_body");
  player_body attach_data_glove();
  scene_wait("phase_4_intro");
}

scene_socotra_models() {
  e_surface = getent("holo_table_surface", "targetname");

  if(isDefined(level.e_surface_default_origin)) {
    e_surface.origin = level.e_surface_default_origin;
    e_surface.angles = level.e_surface_default_angles;
  }

  angles1 = vectorscale((0, 1, 0), 182.0);
  position1 = (0, 462, 484);
  angles2 = vectorscale((0, 1, 0), 157.0);
  position2 = (0, 482, 484);
  prop_base = spawn_model("p6_hologram_so_base_map", position1, angles1);
  prop_base play_fx("fx_dockside_base", prop_base.origin, prop_base.angles, "stop_geo_fx", 1, "tag_origin");
  prop_base ignorecheapentityflag(1);
  prop_base setclientflag(15);
  prop_base rotateto(angles2, 60.0, 0.5, 0.5);
  prop_base moveto(position2, 60.0, 0.5, 0.5);
  wait_network_frame();
  prop_buildings = [];

  for(i = 1; i <= 5; i++) {
    tag_name = "j_target_bldg_0" + i;
    prop_origin = prop_base gettagorigin(tag_name);
    prop_angles = prop_base gettagangles(tag_name);
    prop_building = spawn_model("p6_hologram_so_target_bldg_0" + i, prop_origin, prop_angles);
    prop_building ignorecheapentityflag(1);
    prop_building linkto(prop_base, tag_name);
    prop_buildings[prop_buildings.size] = prop_building;
    prop_building setclientflag(15);
  }

  prop_origin = prop_base gettagorigin("j_target_rock_01");
  prop_angles = prop_base gettagangles("j_target_rock_01");
  prop_rock = spawn_model("p6_hologram_so_target_rock_01", prop_origin, prop_base.angles);
  prop_rock linkto(prop_base, "j_target_rock_01");
  prop_rock ignorecheapentityflag(1);
  prop_rock setclientflag(15);
  prop_enter_path = spawn_model("p6_hologram_so_enter_path", prop_base gettagorigin("j_enter_path"), prop_base.angles);
  prop_enter_path linkto(prop_base, "j_enter_path");
  prop_enter_path hide();
  prop_exit_path = spawn_model("p6_hologram_so_exit_path", prop_base gettagorigin("j_exit_path"), prop_base.angles);
  prop_exit_path linkto(prop_base, "j_exit_path");
  prop_exit_path hide();
  holo_table_exploder_switch(115);
  wait 3.0;

  foreach(building in prop_buildings)
  building thread holo_table_prop_blink_on();

  level waittill("cliffs_up");
  prop_rock thread holo_table_prop_blink_on();
  prop_enter_path show();
  level waittill("vtol_up");
  prop_enter_path hide();
  prop_exit_path show();
  level waittill("map_down");
  holo_table_exploder_switch(undefined);
  prop_base notify("stop_geo_fx");

  foreach(prop in prop_buildings)
  prop clearclientflag(15);

  prop_rock clearclientflag(15);
  prop_base clearclientflag(15);
  prop_enter_path delete();
  prop_exit_path delete();
  level waittill("socotra_fade_out");
  fade_out(1.0);
  wait 1.0;
  array_delete(prop_buildings);
  prop_rock delete();
  prop_base delete();
}

scene_socotra_briefing() {
  level endon("skip_sf_briefing");
  level thread scene_socotra_models();
  level thread run_scene("socotra_briefing_pt1");
  wait_network_frame();
  player_body = get_model_or_models_from_scene("socotra_briefing_pt1", "player_body");
  player_body attach_data_glove();
  scene_wait("socotra_briefing_pt1");
  run_scene("socotra_briefing_pt2");
}

scene_overflow_briefing() {
  level endon("skip_sf_briefing");
  have_intel = level.player get_story_stat("ALL_PAKISTAN_RECORDINGS") != 0;
  level thread scene_overflow_models();
  level thread run_scene("pakistan_briefing");
  player_body = get_model_or_models_from_scene("pakistan_briefing", "player_body");
  player_body attach_data_glove();
  scene_wait("pakistan_briefing");

  if(have_intel)
    run_scene("pakistan_have_intel");
  else
    run_scene("pakistan_no_intel");

  run_scene("pakistan_end");
}

scene_overflow_models() {
  have_intel = level.player get_story_stat("ALL_PAKISTAN_RECORDINGS") != 0;
  e_surface = getent("holo_table_surface", "targetname");
  e_angled = getent("holo_table_angled", "targetname");

  if(isDefined(level.e_surface_default_origin)) {
    e_surface.origin = level.e_surface_default_origin;
    e_surface.angles = level.e_surface_default_angles;
  }

  flag_wait("pakistan_briefing_started");
  level thread holo_table_feature_prop("p6_hologram_zhao_bust", "pakistan_briefing_done", 0.5, undefined, vectorscale((0, 0, -1), 26.0), "zhao");
  level thread holo_table_feature_prop("p6_hologram_zhao_text_01", "pakistan_briefing_done", 0.5, undefined, vectorscale((0, 0, -1), 30.0), "zhao_text1", 0);
  level thread holo_table_feature_prop("p6_hologram_zhao_text_02", "pakistan_briefing_done", 0.5, undefined, vectorscale((0, 0, -1), 30.0), "zhao_text2", 0);
  wait_network_frame();
  zhao = getent("zhao", "targetname");
  zhao_text1 = getent("zhao_text1", "targetname");
  zhao_text2 = getent("zhao_text2", "targetname");
  zhao clearclientflag(14);
  zhao_text1 clearclientflag(14);
  zhao_text2 clearclientflag(14);
  scene_wait("pakistan_briefing");

  if(have_intel) {
    wait 2.5;
    holo_table_exploder_switch(116);
    holo_table_screen = spawn_model("p6_hologram_av2_combined", (39.5, 488, 472), vectorscale((0, 1, 0), 90.0));
    holo_table_screen ignorecheapentityflag(1);
    holo_table_screen setclientflag(15);
    scene_wait("pakistan_have_intel");
    holo_table_screen clearclientflag(15);
  } else {
    holo_table_exploder_switch(112);
    show_globe(1);
    globe_show_map("so_rts_mp_overflow");
    pakistan = getent("pakistan", "script_noteworthy");
    pakistan setclientflag(14);
    pakistan show();
    scene_wait("pakistan_no_intel");
    pakistan hide();
    show_globe(0);
  }

  holo_table_exploder_switch(undefined);
  level waittill("pakistan_fade_out");
  fade_out();
  wait 1.0;
  zhao delete();
  zhao_text1 delete();
  zhao_text2 delete();
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
#using_animtree("animated_props");
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

initialize_scenes() {
  add_scene("phase_3_numsafe_0", "align_frontend");
  add_actor_anim("briggs", % ch_brf_phase3_0_territory_briggs);
  add_player_anim("player_body", % p_brf_phase3_0_territory_player, 0, 0, undefined, 1, 1, 25, 25, 15, 15);
  add_actor_model_anim("troop_01", % ch_brf_phase3_0_territory_troop1);
  add_actor_model_anim("troop_02", % ch_brf_phase3_0_territory_troop2);
  add_actor_model_anim("troop_03", % ch_brf_phase3_0_territory_troop3);
  add_actor_model_anim("troop_04", % ch_brf_phase3_0_territory_troop4);
  add_actor_model_anim("troop_05", % ch_brf_phase3_0_territory_troop5);
  add_actor_spawner("troop_01", "gov");
  add_actor_spawner("troop_02", "gov");
  add_actor_spawner("troop_03", "gov");
  add_actor_spawner("troop_04", "gov");
  add_actor_spawner("troop_05", "gov");
  add_scene("phase_3_numsafe_1", "align_frontend");
  add_actor_anim("briggs", % ch_brf_phase3_1_territory_briggs);
  add_player_anim("player_body", % p_brf_phase3_1_territory_player, 0, 0, undefined, 1, 1, 25, 25, 15, 15);
  add_actor_model_anim("troop_01", % ch_brf_phase3_1_territory_troop1);
  add_actor_model_anim("troop_02", % ch_brf_phase3_1_territory_troop2);
  add_actor_model_anim("troop_03", % ch_brf_phase3_1_territory_troop3);
  add_actor_model_anim("troop_04", % ch_brf_phase3_1_territory_troop4);
  add_actor_model_anim("troop_05", % ch_brf_phase3_1_territory_troop5);
  add_actor_spawner("troop_01", "gov");
  add_actor_spawner("troop_02", "gov");
  add_actor_spawner("troop_03", "gov");
  add_actor_spawner("troop_04", "gov");
  add_actor_spawner("troop_05", "gov");
  add_scene("phase_3_numsafe_2", "align_frontend");
  add_actor_anim("briggs", % ch_brf_phase3_2_territory_briggs);
  add_player_anim("player_body", % p_brf_phase3_2_territory_player, 0, 0, undefined, 1, 1, 25, 25, 15, 15);
  add_actor_model_anim("troop_01", % ch_brf_phase3_2_territory_troop1);
  add_actor_model_anim("troop_02", % ch_brf_phase3_2_territory_troop2);
  add_actor_model_anim("troop_03", % ch_brf_phase3_2_territory_troop3);
  add_actor_model_anim("troop_04", % ch_brf_phase3_2_territory_troop4);
  add_actor_model_anim("troop_05", % ch_brf_phase3_2_territory_troop5);
  add_actor_spawner("troop_01", "gov");
  add_actor_spawner("troop_02", "gov");
  add_actor_spawner("troop_03", "gov");
  add_actor_spawner("troop_04", "gov");
  add_actor_spawner("troop_05", "gov");
  add_scene("phase_3_numsafe_3", "align_frontend");
  add_actor_anim("briggs", % ch_brf_phase3_3_territory_briggs);
  add_player_anim("player_body", % p_brf_phase3_3_territory_player, 0, 0, undefined, 1, 1, 25, 25, 15, 15);
  add_actor_model_anim("troop_01", % ch_brf_phase3_3_territory_troop1);
  add_actor_model_anim("troop_02", % ch_brf_phase3_3_territory_troop2);
  add_actor_model_anim("troop_03", % ch_brf_phase3_3_territory_troop3);
  add_actor_model_anim("troop_04", % ch_brf_phase3_3_territory_troop4);
  add_actor_model_anim("troop_05", % ch_brf_phase3_3_territory_troop5);
  add_actor_spawner("troop_01", "gov");
  add_actor_spawner("troop_02", "gov");
  add_actor_spawner("troop_03", "gov");
  add_actor_spawner("troop_04", "gov");
  add_actor_spawner("troop_05", "gov");
  add_scene("phase_3_ending", "align_frontend");
  add_actor_anim("briggs", % ch_brf_phase3_ending_briggs);
  add_player_anim("player_body", % p_brf_phase3_ending_player, 0, 0, undefined, 1, 1, 25, 25, 15, 15);
  add_notetrack_level_notify("player_body", "map_up", "map_up");
  add_notetrack_level_notify("player_body", "map_down", "map_down");
  add_actor_model_anim("troop_01", % ch_brf_phase3_ending_troop1);
  add_actor_model_anim("troop_02", % ch_brf_phase3_ending_troop2);
  add_actor_model_anim("troop_03", % ch_brf_phase3_ending_troop3);
  add_actor_model_anim("troop_04", % ch_brf_phase3_ending_troop4);
  add_actor_model_anim("troop_05", % ch_brf_phase3_ending_troop5);
  add_actor_spawner("troop_01", "gov");
  add_actor_spawner("troop_02", "gov");
  add_actor_spawner("troop_03", "gov");
  add_actor_spawner("troop_04", "gov");
  add_actor_spawner("troop_05", "gov");
  add_scene("socotra_briefing_pt1", "align_frontend");
  add_actor_anim("briggs", % ch_brf_phase3_socotra_intro_briggs);
  add_player_anim("player_body", % p_brf_phase3_socotra_intro_player, 0, 0, undefined, 1, 1, 25, 25, 15, 15);
  add_actor_model_anim("troop_01", % ch_brf_phase3_socotra_intro_troop1);
  add_actor_model_anim("troop_02", % ch_brf_phase3_socotra_intro_troop2);
  add_actor_model_anim("troop_03", % ch_brf_phase3_socotra_intro_troop3);
  add_actor_model_anim("troop_04", % ch_brf_phase3_socotra_intro_troop4);
  add_actor_model_anim("troop_05", % ch_brf_phase3_socotra_intro_troop5);
  add_actor_spawner("troop_01", "gov");
  add_actor_spawner("troop_02", "gov");
  add_actor_spawner("troop_03", "gov");
  add_actor_spawner("troop_04", "gov");
  add_actor_spawner("troop_05", "gov");
  add_scene("socotra_briefing_pt2", "align_frontend");
  add_actor_anim("briggs", % ch_brf_phase3_socotra_briefing_briggs);
  add_player_anim("player_body", % p_brf_phase3_socotra_briefing_player, 0, 0, undefined, 1, 1, 25, 25, 15, 15);
  add_actor_model_anim("troop_01", % ch_brf_phase3_socotra_briefing_troop1);
  add_actor_model_anim("troop_02", % ch_brf_phase3_socotra_briefing_troop2);
  add_actor_model_anim("troop_03", % ch_brf_phase3_socotra_briefing_troop3);
  add_actor_model_anim("troop_04", % ch_brf_phase3_socotra_briefing_troop4);
  add_actor_model_anim("troop_05", % ch_brf_phase3_socotra_briefing_troop5);
  add_actor_spawner("troop_01", "gov");
  add_actor_spawner("troop_02", "gov");
  add_actor_spawner("troop_03", "gov");
  add_actor_spawner("troop_04", "gov");
  add_actor_spawner("troop_05", "gov");
  add_notetrack_level_notify("player_body", "cliffs_up", "cliffs_up");
  add_notetrack_level_notify("player_body", "vtol_up", "vtol_up");
  add_notetrack_level_notify("player_body", "explode_vtol", "explode_vtol");
  add_notetrack_level_notify("player_body", "vtol_down", "vtol_down");
  add_notetrack_level_notify("player_body", "map_down", "map_down");
  add_notetrack_level_notify("player_body", "fade_out", "socotra_fade_out");
  add_scene("socotra_vtol", "holo_table_floating");
  add_prop_anim("socotra_vtol", % v_brf_holo_vtol_anim, "p6_anim_hologram_vtol_combined", 0);
  add_scene("phase_4_intro", "align_frontend");
  add_actor_anim("briggs", % ch_brf_phase4_intro_briggs, 1);
  add_player_anim("player_body", % p_brf_phase4_intro_player, 0, 0, undefined, 1, 1, 25, 25, 15, 15);
  add_actor_model_anim("troop_01", % ch_brf_phase4_intro_troop1);
  add_actor_model_anim("troop_02", % ch_brf_phase4_intro_troop2);
  add_actor_model_anim("troop_03", % ch_brf_phase4_intro_troop3);
  add_actor_model_anim("troop_04", % ch_brf_phase4_intro_troop4);
  add_actor_model_anim("troop_05", % ch_brf_phase4_intro_troop5);
  add_actor_spawner("troop_01", "gov");
  add_actor_spawner("troop_02", "gov");
  add_actor_spawner("troop_03", "gov");
  add_actor_spawner("troop_04", "gov");
  add_actor_spawner("troop_05", "gov");
  add_scene("pakistan_briefing", "align_frontend");
  add_actor_anim("briggs", % ch_brf_phase4_pak_briefing_briggs, 1);
  add_player_anim("player_body", % p_brf_phase4_pak_briefing_player, 0, 0, undefined, 1, 1, 25, 25, 15, 15);
  add_actor_model_anim("troop_01", % ch_brf_phase4_pak_briefing_troop1);
  add_actor_model_anim("troop_02", % ch_brf_phase4_pak_briefing_troop2);
  add_actor_model_anim("troop_03", % ch_brf_phase4_pak_briefing_troop3);
  add_actor_model_anim("troop_04", % ch_brf_phase4_pak_briefing_troop4);
  add_actor_model_anim("troop_05", % ch_brf_phase4_pak_briefing_troop5);
  add_actor_spawner("troop_01", "gov");
  add_actor_spawner("troop_02", "gov");
  add_actor_spawner("troop_03", "gov");
  add_actor_spawner("troop_04", "gov");
  add_actor_spawner("troop_05", "gov");
  add_notetrack_level_notify("player_body", "globe_down", "globe_down");
  add_notetrack_level_notify("player_body", "zhao_up", "zhao_up");
  add_notetrack_level_notify("player_body", "zhao_down", "zhao_down");
  add_scene("pakistan_no_intel", "align_frontend");
  add_actor_anim("briggs", % ch_phase4_pakistan_no_intel_briggs, 1);
  add_player_anim("player_body", % p_phase4_pakistan_no_intel_player, 0, 0, undefined, 1, 1, 25, 25, 15, 15);
  add_actor_model_anim("troop_01", % ch_brf_phase4_pakistan_no_intel_troop1);
  add_actor_model_anim("troop_02", % ch_brf_phase4_pakistan_no_intel_troop2);
  add_actor_model_anim("troop_03", % ch_brf_phase4_pakistan_no_intel_troop3);
  add_actor_model_anim("troop_04", % ch_brf_phase4_pakistan_no_intel_troop4);
  add_actor_model_anim("troop_05", % ch_brf_phase4_pakistan_no_intel_troop5);
  add_actor_spawner("troop_01", "gov");
  add_actor_spawner("troop_02", "gov");
  add_actor_spawner("troop_03", "gov");
  add_actor_spawner("troop_04", "gov");
  add_actor_spawner("troop_05", "gov");
  add_notetrack_level_notify("player_body", "globe_down", "globe_down");
  add_scene("pakistan_have_intel", "align_frontend");
  add_actor_anim("briggs", % ch_brf_phase4_pak_intel_briggs, 1);
  add_player_anim("player_body", % p_brf_phase4_pak_intel_player, 0, 0, undefined, 1, 1, 25, 25, 15, 15);
  add_actor_model_anim("troop_01", % ch_brf_phase4_pak_intel_troop1);
  add_actor_model_anim("troop_02", % ch_brf_phase4_pak_intel_troop2);
  add_actor_model_anim("troop_03", % ch_brf_phase4_pak_intel_troop3);
  add_actor_model_anim("troop_04", % ch_brf_phase4_pak_intel_troop4);
  add_actor_model_anim("troop_05", % ch_brf_phase4_pak_intel_troop5);
  add_actor_spawner("troop_01", "gov");
  add_actor_spawner("troop_02", "gov");
  add_actor_spawner("troop_03", "gov");
  add_actor_spawner("troop_04", "gov");
  add_actor_spawner("troop_05", "gov");
  add_notetrack_level_notify("player_body", "globe_down", "globe_down");
  add_notetrack_level_notify("player_body", "mmscreen_up", "mmscreen_up");
  add_notetrack_level_notify("player_body", "mmscreen_down", "mmscreen_down");
  add_scene("pakistan_end", "align_frontend");
  add_actor_anim("briggs", % ch_brf_phase4_pak_end_briggs, 1);
  add_player_anim("player_body", % p_brf_phase4_pak_end_player, 0, 0, undefined, 1, 1, 25, 25, 15, 15);
  add_actor_model_anim("troop_01", % ch_brf_phase4_pak_end_troop1);
  add_actor_model_anim("troop_02", % ch_brf_phase4_pak_end_troop2);
  add_actor_model_anim("troop_03", % ch_brf_phase4_pak_end_troop3);
  add_actor_model_anim("troop_04", % ch_brf_phase4_pak_end_troop4);
  add_actor_model_anim("troop_05", % ch_brf_phase4_pak_end_troop5);
  add_actor_spawner("troop_01", "gov");
  add_actor_spawner("troop_02", "gov");
  add_actor_spawner("troop_03", "gov");
  add_actor_spawner("troop_04", "gov");
  add_actor_spawner("troop_05", "gov");
  add_notetrack_level_notify("player_body", "fade_out", "pakistan_fade_out");
}