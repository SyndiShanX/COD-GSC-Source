/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\frontend_sf_a.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_scene;
#include maps\_endmission;
#include maps\frontend_util;
#include maps\war_room_util;

scene_pre_briefing() {
  level.player set_story_stat("SO_WAR_HUB_ONE_INTRO", 1);
  level thread show_globe(0, 0);
  level.player startcameratween(0.5);
  level thread scene_pre_models();
  level thread run_scene("sf_a_player_intro");
  wait_network_frame();
  player_body = get_model_or_models_from_scene("sf_a_player_intro", "player_body");
  player_body attach_data_glove();
  scene_wait("sf_a_player_intro");
}

scale_over_time(start_scale, end_scale, time_s) {
  holo = self;

  if(isDefined(self.animname))
    holo = getent(self.animname + "_scalable", "targetname");

  if(!isDefined(holo)) {
    return;
  }
  frames = time_s / 0.05;
  pct_per_frame = 1.0 / frames;

  for(f = 0; f <= 1.0; f = f + pct_per_frame) {
    scale = lerpfloat(start_scale, end_scale, f);
    holo setscale(scale);
    wait 0.05;
  }
}

beam_scale_up(beam) {
  beam endon("death");
  toggle_hologram_fx(1);
  beam scale_over_time(1.0, 10.0, 1.0);
  beam play_fx("fx_dockside_beam", beam.origin, beam.angles, "fx_beam_stop", 1, "tag_origin");
}

beam_scale_down(beam) {
  beam endon("death");
  beam notify("fx_beam_stop");
  toggle_hologram_fx(0);
  beam scale_over_time(10.0, 1.0, 1.0);
}

ship_start_fx(ship) {
  ship play_fx("fx_dockside_ship", ship.origin, ship.angles, "fx_ship_stop", 1, "tag_origin");
  toggle_hologram_fx(1);
}

beam_hide(beam) {
  beam hide();
}

missile_scale_up(missile) {
  missile endon("death");
  toggle_hologram_fx(1);
  missile scale_over_time(1.0, 5.0, 1.0);
  missile play_fx("fx_dockside_missile", missile.origin, missile.angles, "fx_missile_stop", 1, "tag_origin");
}

missile_scale_down(missile) {
  missile endon("death");
  missile notify("fx_missile_stop");
  toggle_hologram_fx(0);
  missile scale_over_time(5.0, 1.0, 1.0);
}

object_fire_notify(object, notetrack_name) {
  object notify(notetrack_name);
}

scene_fade_out(caller) {
  fade_out(2.0);
}

get_hologram_scalable_models(scene_name) {
  anim_info_array = level.a_scenes[scene_name].a_anim_info;
  array_keys = getarraykeys(anim_info_array);
  scalable_models = [];

  for(i = 0; i < array_keys.size; i++) {
    key = array_keys[i];
    anim_info = anim_info_array[key];
    model_name = anim_info.str_model;
    scalable_model = getent(key + "_scalable", "targetname");
    scalable_model hide();
    scalable_models[key] = scalable_model;
  }

  return scalable_models;
}

#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");

initialize_scenes() {
  add_scene("sf_a_player_intro", "align_frontend");
  add_player_anim("player_body", % p_brf_phase1_intro_player, 0, 0, undefined, 1, 1, 25, 25, 15, 15);
  add_notetrack_level_notify("player_body", "zhao_up", "zhao_up");
  add_notetrack_level_notify("player_body", "zhao_down", "zhao_down");
  add_notetrack_level_notify("player_body", "globe_up", "globe_up");
  add_notetrack_level_notify("player_body", "india_up", "india_up");
  add_notetrack_level_notify("player_body", "globe_down", "globe_down");
  add_actor_anim("briggs", % ch_brf_phase1_intro_briggs);
  add_actor_model_anim("troop_01", % ch_brf_phase1_intro_troop1);
  add_actor_model_anim("troop_02", % ch_brf_phase1_intro_troop2);
  add_actor_model_anim("troop_03", % ch_brf_phase1_intro_troop3);
  add_actor_model_anim("troop_04", % ch_brf_phase1_intro_troop4);
  add_actor_model_anim("troop_05", % ch_brf_phase1_intro_troop5);
  add_actor_spawner("troop_01", "gov");
  add_actor_spawner("troop_02", "gov");
  add_actor_spawner("troop_03", "gov");
  add_actor_spawner("troop_04", "gov");
  add_actor_spawner("troop_05", "gov");
  add_scene("so_rts_mp_dockside_briefing", "align_frontend");
  add_player_anim("player_body", % p_singapore_brf, 1, 0, undefined, 1, 1, 25, 25, 15, 15);
  add_actor_anim("briggs", % ch_singapore_brf_briggs);
  add_notetrack_level_notify("player_body", "missile_up", "missile_up");
  add_notetrack_level_notify("player_body", "missile_down", "missile_down");
  add_notetrack_level_notify("player_body", "dfmissile_up", "dfmissile_up");
  add_notetrack_level_notify("player_body", "dfmissile_down", "dfmissile_down");
  add_notetrack_level_notify("player_body", "beams_up", "beams_up");
  add_notetrack_level_notify("player_body", "beams_down", "beams_down");
  add_notetrack_level_notify("player_body", "fade_out", "dockside_fade_out");
  add_scene("dockside_audience", "align_frontend");
  add_actor_model_anim("troop_01", % ch_singapore_brf_troop1);
  add_actor_model_anim("troop_02", % ch_singapore_brf_troop2);
  add_actor_model_anim("troop_03", % ch_singapore_brf_troop3);
  add_actor_model_anim("troop_04", % ch_singapore_brf_troop4);
  add_actor_model_anim("troop_05", % ch_singapore_brf_troop5);
  add_actor_spawner("troop_01", "gov");
  add_actor_spawner("troop_02", "gov");
  add_actor_spawner("troop_03", "gov");
  add_actor_spawner("troop_04", "gov");
  add_actor_spawner("troop_05", "gov");
  add_scene("so_rts_mp_drone_briefing", "align_frontend");
  add_player_anim("player_body", % p_brf_phase1_drone_player, 1, 0, undefined, 1, 1, 25, 25, 15, 15);
  add_notetrack_level_notify("player_body", "multimedia_up", "multimedia_up");
  add_notetrack_level_notify("player_body", "multimedia_down", "multimedia_down");
  add_notetrack_level_notify("player_body", "map_up", "map_up");
  add_notetrack_level_notify("player_body", "targets_up", "targets_up");
  add_notetrack_level_notify("player_body", "targets_down", "targets_down");
  add_notetrack_level_notify("player_body", "computer_up", "computer_up");
  add_notetrack_level_notify("player_body", "computer_down", "computer_down");
  add_notetrack_level_notify("player_body", "map_down", "map_down");
  add_notetrack_level_notify("player_body", "fade_out", "drone_fade_out");
  add_actor_anim("briggs", % ch_brf_phase1_drone_briggs);
  add_actor_model_anim("troop_01", % ch_brf_phase1_drone_troop1);
  add_actor_model_anim("troop_02", % ch_brf_phase1_drone_troop2);
  add_actor_model_anim("troop_03", % ch_brf_phase1_drone_troop3);
  add_actor_model_anim("troop_04", % ch_brf_phase1_drone_troop4);
  add_actor_model_anim("troop_05", % ch_brf_phase1_drone_troop5);
  add_actor_spawner("troop_01", "gov");
  add_actor_spawner("troop_02", "gov");
  add_actor_spawner("troop_03", "gov");
  add_actor_spawner("troop_04", "gov");
  add_actor_spawner("troop_05", "gov");
}

scene_pre_models() {
  level waittill("zhao_up");
  show_holotable_fuzz(1);
  level thread holo_table_feature_prop("p6_hologram_zhao_bust", "zhao_down", 0.5, undefined, vectorscale((0, 0, -1), 26.0), "zhao");
  level thread holo_table_feature_prop("p6_hologram_zhao_text_01", "zhao_down", 0.5, undefined, vectorscale((0, 0, -1), 30.0), "text1", 0);
  level thread holo_table_feature_prop("p6_hologram_zhao_text_02", "zhao_down", 0.5, undefined, vectorscale((0, 0, -1), 30.0), "text2", 0);
  zhao = getent("zhao", "targetname");
  zhao clearclientflag(14);
  text1 = getent("text1", "targetname");
  text1 clearclientflag(14);
  text2 = getent("text2", "targetname");
  text2 clearclientflag(14);
  level waittill("globe_up");
  holo_table_exploder_switch(112);
  show_globe(1, 1, 0);
  wait 2.0;
  sdc = getent("sdc", "script_noteworthy");
  russia = getent("russia", "script_noteworthy");
  russia show();
  sdc show();
  sdc setclientflag(14);
  globe = getent("world_globe", "targetname");
  globe rotateto((0, 210, 30), 1.0, 0.2, 0.2);
  wait 2.0;
  russia thread holo_table_prop_blink_on();
  level waittill("india_up");
  wait 3.0;
  russia clearclientflag(14);
  india = getent("india", "script_noteworthy");
  iran = getent("iran", "script_noteworthy");
  india thread holo_table_prop_blink_on();
  iran thread holo_table_prop_blink_on();
  level waittill("globe_down");
  show_globe(0, 1);
  holo_table_exploder_switch(undefined);
  zhao delete();
  text1 delete();
  text2 delete();
  sdc clearclientflag(14);
  india clearclientflag(14);
  iran clearclientflag(14);
  india hide();
  iran hide();
  russia hide();
  sdc hide();
}

raise_model(done_level_notify, position_ent_name, scale, parent_model, parent_model_tag, str_fx) {
  if(!isDefined(position_ent_name))
    position_ent_name = undefined;

  if(!isDefined(scale))
    scale = 4.0;

  if(!isDefined(str_fx))
    str_fx = undefined;

  self unlink();
  end_pos = self.origin + vectorscale((0, 0, 1), 32.0);

  if(isDefined(position_ent_name)) {
    position_ent = getent(position_ent_name, "targetname");
    end_pos = position_ent.origin;
  }

  start_pos = self.origin;
  start_orient = self.angles;
  self setclientflag(14);
  self moveto(end_pos, 1.0, 0.2, 0.2);
  self thread rotate_indefinitely();

  for(f = 0.0; f <= 1.0; f = f + 0.05) {
    self setscale(lerpfloat(1.0, scale, f));
    wait 0.05;
  }

  if(isDefined(str_fx))
    self play_fx(str_fx, self.origin, self.angles, "kill_raise_model_fx", 1);

  level waittill(done_level_notify);
  self notify("stop_spinning");
  self notify("kill_raise_model_fx");

  if(isDefined(parent_model) && isDefined(parent_model_tag)) {
    start_pos = parent_model gettagorigin(parent_model_tag);
    start_orient = parent_model gettagangles(parent_model_tag);
  }

  self moveto(start_pos, 1.0, 0.2, 0.2);
  self rotateto(start_orient, 1.0, 0.2, 0.2);

  for(f = 0.0; f <= 1.0; f = f + 0.05) {
    self setscale(lerpfloat(scale, 1.0, f));
    wait 0.05;
  }

  if(isDefined(parent_model))
    self linkto(parent_model);

  self clearclientflag(14);
}

scene_drone_models() {
  show_holotable_fuzz(1);
  e_surface = getent("holo_table_surface", "targetname");

  if(isDefined(level.e_surface_default_origin)) {
    e_surface.origin = level.e_surface_default_origin;
    e_surface.angles = level.e_surface_default_angles;
  }

  base_pos = e_surface.origin + vectorscale((0, 1, 0), 4.0);
  base_start_angles = e_surface.angles + vectorscale((0, 1, 0), 15.0);
  base_end_angles = e_surface.angles - vectorscale((0, 1, 0), 15.0);
  model_list = [];
  base = spawn("script_model", base_pos);
  base.angles = base_start_angles;
  base setmodel("p6_hologram_dr_base_map");
  model_list[model_list.size] = base;
  dish = spawn("script_model", base gettagorigin("j_dish"));
  dish.angles = base gettagangles("j_dish");
  dish setmodel("p6_hologram_dr_dish");
  model_list[model_list.size] = dish;
  tank = spawn("script_model", base gettagorigin("j_tank"));
  tank.angles = base gettagangles("j_tank");
  tank setmodel("p6_hologram_dr_tank");
  model_list[model_list.size] = tank;
  transformer = spawn("script_model", base gettagorigin("j_transformer"));
  transformer.angles = base gettagangles("j_transformer");
  transformer setmodel("p6_hologram_dr_transformer");
  model_list[model_list.size] = transformer;
  computer = spawn("script_model", base gettagorigin("j_computer"));
  computer.angles = base gettagangles("j_computer");
  computer setmodel("p6_hologram_dr_computer");
  model_list[model_list.size] = computer;

  for(i = 0; i < model_list.size; i++) {
    model_list[i] ignorecheapentityflag(1);
    model_list[i] hide();
    model_list[i] clearclientflag(14);

    if(model_list[i] != base)
      model_list[i] linkto(base);
  }

  level waittill("multimedia_up");
  holo_table_exploder_switch(116);
  holo_table_screen = spawn_model("p6_hologram_av_combined", (39.5, 488, 472), vectorscale((0, 1, 0), 90.0));
  holo_table_screen ignorecheapentityflag(1);
  holo_table_screen setclientflag(15);
  level waittill("map_up");
  base rotateto(base_end_angles, 45.0, 0.0, 0.0);
  base play_fx("fx_dockside_base", base.origin, base.angles, "stop_geo_fx", 1, "tag_origin");
  holo_table_exploder_switch(115);
  holo_table_screen clearclientflag(15);
  wait 0.5;
  show_holotable_fuzz(0);

  for(i = 0; i < model_list.size; i++) {
    model_list[i] show();
    model_list[i] setclientflag(15);
  }

  level waittill("targets_up");
  tank thread raise_model("targets_down", "holo_table_floating_right", 4.0, base, "j_tank", "hologram_widget_fx");
  transformer thread raise_model("targets_down", "holo_table_floating", 4.0, base, "j_transformer", "hologram_widget_fx");
  dish thread raise_model("targets_down", "holo_table_floating_left", 4.0, base, "j_dish", "hologram_widget_fx");
  level waittill("computer_up");
  wait 1.0;
  computer thread raise_model("drone_fade_out", "holo_table_floating", 4.0, base, "j_computer", "hologram_widget_fx");
  computer thread holo_table_prop_blink_on();
  level waittill("map_down");
  base notify("stop_geo_fx");
  holo_table_exploder_switch(undefined);

  foreach(model in model_list)
  model clearclientflag(15);

  level waittill("drone_fade_out");
  fade_out(1);

  foreach(model in model_list)
  model delete();
}

hologram_start() {
  self setscale(0.1);
  self show();
  self scale_over_time(0.1, 1.0, 1.0);
}

scene_dockside_models() {
  show_holotable_fuzz(0);
  dockside_base = getent("dockside_base", "targetname");
  dockside_props = getentarray("dockside_prop", "script_noteworthy");
  e_surface = getent("holo_table_surface", "targetname");
  e_angled = getent("holo_table_surface", "targetname");

  if(isDefined(level.e_surface_default_origin)) {
    e_surface.origin = level.e_surface_default_origin;
    e_surface.angles = level.e_surface_default_angles;
  }

  holo_table_exploder_switch(115);

  foreach(prop in dockside_props) {
    prop ignorecheapentityflag(1);
    prop hide();

    if(prop != dockside_base) {
      prop setclientflag(14);
      prop linkto(dockside_base);
    }
  }

  wait_network_frame();
  dockside_base.origin = e_surface.origin;
  dockside_base.angles = e_surface.angles;
  dockside_base play_fx("fx_dockside_base", dockside_base.origin, dockside_base.angles, "hide_base", 1, "tag_origin");
  dockside_ship = undefined;

  foreach(prop in dockside_props) {
    prop setclientflag(15);

    if(prop.targetname == "dockside_ship")
      dockside_ship = prop;

    prop clearclientflag(14);
    prop show();
  }

  dockside_base moveto(e_angled.origin, 2.0, 0.5, 0.5);
  wait 1.0;
  dockside_base rotateto(e_angled.angles, 2.0, 0.5, 0.5);
  wait 1.0;
  dockside_ship thread holo_table_prop_blink_on(7.0);
  level waittill("missile_up");
  missile = getent("dockside_missile", "targetname");
  level thread holo_table_feature_prop("p6_hologram_missile", "missile_down", 1.0, undefined, vectorscale((0, 0, -1), 10.0));
  level waittill("dfmissile_up");
  missile = getent("dockside_missile", "targetname");
  missile thread raise_model("dfmissile_down", undefined, 4.0);
  level waittill("beams_up");
  beam1 = getent("dockside_beam1", "targetname");
  beam2 = getent("dockside_beam2", "targetname");
  beam1 thread raise_model("beams_down", undefined, 4.0);
  beam2 thread raise_model("beams_down", undefined, 4.0);
  level waittill("beams_down");
  wait 2.0;
  level thread holo_table_feature_prop("p6_hologram_hack_device", "dockside_fade_out", 1.0, undefined, vectorscale((0, 0, -1), 10.0));
  level waittill("dockside_fade_out");
  holo_table_exploder_switch(undefined);
  dockside_base clearclientflag(15);
  dockside_base notify("hide_base");

  foreach(prop in dockside_props)
  prop clearclientflag(15);

  fade_out(1.0);
}

scene_dockside_briefing() {
  level endon("skip_sf_briefing");
  level thread scene_dockside_models();
  level thread run_scene("dockside_audience");
  level thread run_scene("so_rts_mp_dockside_briefing");
  wait_network_frame();
  player_body = get_model_or_models_from_scene("so_rts_mp_dockside_briefing", "player_body");
  player_body attach_data_glove();
  scene_wait("so_rts_mp_dockside_briefing");
}

scene_drone_briefing() {
  level endon("skip_sf_briefing");
  level thread scene_drone_models();
  level thread run_scene("so_rts_mp_drone_briefing");
  wait_network_frame();
  player_body = get_model_or_models_from_scene("so_rts_mp_drone_briefing", "player_body");
  player_body attach_data_glove();
  scene_wait("so_rts_mp_drone_briefing");
}