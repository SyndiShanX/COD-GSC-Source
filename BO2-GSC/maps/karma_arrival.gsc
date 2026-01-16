/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\karma_arrival.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\karma_util;
#include maps\_objectives;
#include maps\_scene;
#include maps\_vehicle;
#include maps\_music;
#include maps\_dialog;
#include maps\karma_anim;
#include maps\karma_checkin;
#include maps\_fxanim;
#include maps\_anim;
#include maps\createart\karma_art;
#include maps\_glasses;
#include maps\karma;

init_flags() {
  flag_init("fxanim_checkin_start");
  flag_init("start_tarmac");
  flag_init("start_vtol_takeoff");
  flag_init("start_vtol_flyby");
  flag_init("deplaned");
}

init_spawn_funcs() {
  add_spawn_function_veh("player_vtol", ::player_vtol_start);
}

skipto_arrival() {
}

arrival() {
  iprintln("Arrival");

  level.n_aggressivecullradius = getdvar(#"_id_0EC60F96");
  setsaveddvar("Cg_aggressivecullradius", 200);

  if(level.wiiu) {
    level.n_znear_old = getdvar(#"r_znear");
    setdvar("r_znear", 20);
  }

  deconstruct_fxanims();
  flyin_hide_cells();
  level.player set_temp_stat(1, 0);
  level.player_interactive_model = "c_usa_masonjr_karma_viewbody";
  level.player hide_hud();
  maps\karma_anim::arrival_anims();
  setmusicstate("KARMA_1_INTRO");
  level clientnotify("ls_pio");
  level.ai_harper = init_hero("harper");
  level.ai_harper set_blend_in_out_times(0.2);
  level.ai_salazar = init_hero("salazar_pistol");
  level.ai_salazar set_blend_in_out_times(0.2);
  level thread setup_vtol("player_vtol");
  level.m_duffle_bag = getent("duffle_bag", "targetname");
  level.m_duffle_bag set_blend_in_out_times(0.2);
  level.m_harper_briefcase = getent("harper_briefcase", "targetname");
  level.m_harper_briefcase set_blend_in_out_times(0.2);
  level.m_player_briefcase = spawn_model("p6_spiderbot_case_anim");
  level.m_player_briefcase.animname = "player_briefcase";
  vtol_clip = getent("clip_vtol_blocker", "targetname");
  vtol_clip trigger_off();
  a_ai_security_single = simple_spawn_single("security1");
  a_ai_security_single add_cleanup_ent("cleanup_checkin");
  level thread set_water_dvars();
  set_env_dvars();
  level thread init_ambient_boats();
  level thread setup_tarmac_fx();
  level thread setup_cagelight_fx("cagelight");
  level thread setup_cagelight_fx("L_pad_cagelight");
  flag_set("fxanim_checkin_start");
  exploder(101);
  exploder(103);
  exploder(105);
  flag_wait("starting final intro screen fadeout");
  exploder(102);
  playsoundatposition("evt_jet_intro", (0, 0, 0));
  level thread setup_vtol("takeoff_vtol", "start_vtol_takeoff");
  level thread setup_vtol("intro_vtol");
  level thread setup_asds();
  level thread maps\karma_checkin::sliding_door_init();
  level thread landing_pilot_scenes();
  level thread tarmac_worker_scenes();
  level thread forklift_worker_scenes();
  level thread metalstorm_worker_scenes();
  level thread timescale_glasses();
  level thread adjust_player_speed();
  level thread start_workers();
  level thread start_workers_walking();
  level thread maps\karma_checkin::security_left();
  level thread maps\karma_checkin::scanner_scenes();
  level thread maps\karma_checkin::scanner_backdrop();
  scene_wait("final_approach_plane");
  flag_set("start_tarmac");
  level clientnotify("verb_reset");
  level thread run_landing_squad_lighting_scene();

  if(level.player get_story_stat("HARPER_SCARRED"))
    run_scene_and_delete("landing_squad");
  else
    run_scene_and_delete("landing_squad_alt");

  flag_set("deplaned");
  level thread arrival_cleanup();
}

deconstruct_fxanims() {
  for(i = 1; i <= 12; i++)
    maps\_fxanim::fxanim_deconstruct("fxanim_club_top_laser_" + i);

  for(i = 1; i <= 2; i++)
    maps\_fxanim::fxanim_deconstruct("fxanim_club_dj_laser_" + i);

  for(i = 1; i <= 2; i++)
    maps\_fxanim::fxanim_deconstruct("fxanim_club_bar_shelves_0" + i);
}

flyin_hide_cells() {
  foreach(s_cell in getstructarray("intro_flyin_cell_pos", "targetname"))
  setcellinvisibleatpos(s_cell.origin);
}

flyin_show_cells() {
  setsaveddvar("Cg_aggressivecullradius", level.n_aggressivecullradius);

  if(level.wiiu)
    setdvar("r_znear", level.n_znear_old);

  foreach(s_cell in getstructarray("intro_flyin_cell_pos", "targetname"))
  setcellvisibleatpos(s_cell.origin);
}

run_landing_squad_lighting_scene() {
  setup_lighting_alignment_for_plane_exit();

  if(level.player get_story_stat("HARPER_SCARRED"))
    run_scene_and_delete("landing_squad_lighting");
  else
    run_scene_and_delete("landing_squad_alt_lighting");
}

init_ambient_boats() {
  a_boats = getentarray("tiny_boat", "targetname");

  for(i = 0; i < 20; i++) {
    n_index = randomint(a_boats.size);
    a_boats[n_index] thread play_fx("ambient_boat_wake", a_boats[n_index].origin + vectorscale((0, 0, 1), 96.0), a_boats[n_index].angles + vectorscale((0, -1, 0), 90.0), undefined, 1, undefined, 1);
    arrayremoveindex(a_boats, n_index);
  }

  flag_wait("trig_player_blocker_2");

  foreach(e_boat in getentarray("tiny_boat", "targetname"))
  e_boat delete();

  foreach(e_boat in getentarray("karma_life_boat", "targetname"))
  e_boat delete();
}

#using_animtree("animated_props");

landing_pad_asd_idle_think() {
  self endon("death");
  a_idles = [];
  a_idles[0] = "ai_asd_idle_twitch_a";
  a_idles[1] = "ai_asd_idle_twitch_b";
  a_idles[2] = "ai_asd_idle_twitch_c";
  self useanimtree(#animtree);
  trigger_wait("trig_asd_idle_start");
  str_idle_twitch = "ai_asd_idle_twitch_" + self.script_string;
  self thread anim_generic(self, str_idle_twitch);
  self waittill(str_idle_twitch);

  while(true) {
    self thread anim_generic_loop(self, "ai_asd_idle", "stop_idle");
    wait(randomfloatrange(2.5, 5.0));
    self notify("stop_idle");
    str_idle_twitch = random(a_idles);
    self thread anim_generic(self, str_idle_twitch);
    self waittill(str_idle_twitch);
  }
}

setup_vtol(str_vtol_name, str_wait_flag) {
  a_vh_vtols = spawn_vehicles_from_targetname(str_vtol_name);

  foreach(vh_vtol in a_vh_vtols) {
    if(vh_vtol.vehicletype == "heli_vtol")
      playfxontag(level._effect["flight_lights_3p"], vh_vtol, "tag_origin");

    vh_vtol add_cleanup_ent("cleanup_tower");

    if(isDefined(vh_vtol.script_string) && isDefined(level.scr_anim["vtol"][vh_vtol.script_string])) {
      vh_vtol.animname = "vtol";
      vh_vtol thread maps\_anim::anim_single(vh_vtol, "gear_down");
      vh_vtol notify("nodeath_thread");
      vh_vtol thread vtol_fly(str_vtol_name, str_wait_flag);
      flag_wait("glasses_activated");
      wait 8;
      vh_vtol thread maps\_anim::anim_single(vh_vtol, "gear_up");
      continue;
    }

    vh_vtol notify("nodeath_thread");
    vh_vtol thread vtol_fly(str_vtol_name, str_wait_flag);
  }
}

setup_asds() {
  foreach(m_asd in getentarray("arrival_metalstorm", "targetname")) {
    m_asd thread play_fx("eye_light_friendly", undefined, undefined, "metalstorm_off", 1, "tag_scanner");
    m_asd thread landing_pad_asd_idle_think();
  }
}

setup_tarmac_fx() {
  a_m_hazard_lights = getentarray("hazard_light", "targetname");

  foreach(m_light in a_m_hazard_lights) {
    m_light thread delay_fx();
    m_light add_cleanup_ent("cleanup_checkin");
  }
}

delay_fx() {
  if(isDefined(self.script_delay))
    wait(self.script_delay);

  playfxontag(level._effect["light_caution_orange_flash"], self, "tag_origin");
}

setup_cagelight_fx(light) {
  a_m_cagelights = getentarray(light, "targetname");

  foreach(m_light in a_m_cagelights) {
    m_light thread delay_cagelight_fx();
    m_light add_cleanup_ent("cleanup_checkin");
  }
}

delay_cagelight_fx() {
  if(isDefined(self.script_delay))
    wait(self.script_delay);

  playfxontag(level._effect["light_caution_red_flash"], self, "tag_origin");
}

vtol_fly(str_vtol_name, str_wait_flag) {
  if(!isDefined(self.target)) {
    return;
  }
  nd_flyby_start = getvehiclenode(self.target, "targetname");
  assert(isDefined(nd_flyby_start), "setup_vtol: No path defined for vtol : " + self.target);

  if(isDefined(str_wait_flag))
    flag_wait(str_wait_flag);

  switch (self.vehicletype) {
    case "heli_vtol":
      playfxontag(level._effect["vtol_exhaust"], self, "tag_origin");
      self playsound("evt_vtol_takeoff");
      break;
    case "heli_hip":
      break;
  }

  self go_path(nd_flyby_start);
  self waittill("reached_end_node");
  self delete();
}

player_vtol_start() {
  level.player_vtol = self;

  if(flag("deplaned")) {
    return;
  }
  level thread landing_player_scenes(self);
  run_scene_first_frame("final_approach_plane");
  flag_wait("starting final intro screen fadeout");
  self hidepart("tag_window_solid");
  self thread hide_show_vtol_parts();
  self play_fx("parting_clouds", (0, 0, 0), (0, 0, 0), "vtol_landed", 1, "tag_origin");
  self play_fx("flight_spotlight", (0, 0, 0), (0, 0, 0), "vtol_landed", 1, "tag_flashlight");
  self play_fx("flight_hologram", (0, 0, 0), (0, 0, 0), "vtol_landed", 1, "tag_hologram_fx");
  self play_fx("flight_lights_glows1", (0, 0, 0), (0, 0, 0), "vtol_landed", 1, "tag_cockpit_fx");
  self play_fx("flight_lights_centers1", (0, 0, 0), (0, 0, 0), "vtol_landed", 1, "tag_cockpit_fx");
  self play_fx("flight_lights_glows2", (0, 0, 0), (0, 0, 0), "vtol_landed", 1, "tag_cockpit_fx");
  self play_fx("flight_lights_centers2", (0, 0, 0), (0, 0, 0), "vtol_landed", 1, "tag_cockpit_fx");
  self play_fx("flight_overhead_panel_centers", (0, 0, 0), (0, 0, 0), "vtol_landed", 1, "tag_overhead_panel_fx");
  self play_fx("flight_overhead_panel_glows", (0, 0, 0), (0, 0, 0), "vtol_landed", 1, "tag_overhead_panel_fx");
  self play_fx("flight_overhead_panel_centers2", (0, 0, 0), (0, 0, 0), "vtol_landed", 1, "tag_overhead_panel_fx");
  self play_fx("flight_overhead_panel_glows2", (0, 0, 0), (0, 0, 0), "vtol_landed", 1, "tag_overhead_panel_fx");
  self play_fx("flight_access_panel_01", (0, 0, 0), (0, 0, 0), "vtol_landed", 1, "tag_access_panel_01_fx");
  self play_fx("flight_access_panel_02", (0, 0, 0), (0, 0, 0), "vtol_landed", 1, "tag_access_panel_02_fx");
  run_scene_and_delete("final_approach_plane");
  self veh_toggle_tread_fx(0);
  thread run_scene_and_delete("final_approach_plane_idle");
  wait 3.0;
  self notify("vtol_landed");
  wait 0.25;
  exploder(99);
  scene_wait("landing_player");
}

setup_lighting_pairs(ent) {
  flag_wait("final_approach_squad_started");
  set_lighting_pair("player_vtol", "player_vtol_lighting_org");
  set_lighting_pair("player_body", "player_body_lighting");
  set_lighting_pair("harper_ai", "harper_lighting_drone");
  set_lighting_pair("salazar_pistol_ai", "salazar_pistol_lighting_drone");
  set_lighting_pair("duffle_bag", "duffle_bag_lighting");
  set_lighting_pair("harper_briefcase", "harper_briefcase_lighting");
  set_lighting_pair("player_briefcase", "player_briefcase_lighting");
  flag_wait("final_approach_pilots_started");
  set_lighting_pair("pilot_drone", "pilot_lighting_drone");
  set_lighting_pair("copilot_drone", "copilot_lighting_drone");
  flag_wait("final_approach_plane_idle_started");
  flag_wait("glasses_on");
}

setup_lighting_alignment_for_plane_exit() {
  s_align = getstruct("intro_landing", "targetname");
  m_align_scene = spawn_model("tag_origin", s_align.origin, s_align.angles);
  vh_plane = getent("player_vtol", "targetname");
  m_align_plane = spawn_model("tag_origin", vh_plane.origin, vh_plane.angles);
  m_align_scene.targetname = "align_plane_exit_lighting";
  m_align_scene linkto(m_align_plane);
  m_lighting_org = getent("player_vtol_lighting_org", "targetname");
  m_align_plane moveto(m_lighting_org.origin, 0.05);
  m_align_plane rotateto(m_lighting_org.angles, 0.05);
  m_align_plane waittill("movedone");
  level thread lighting_alignment_cleanup_for_plane_exit(m_align_plane, m_lighting_org, m_align_scene);
}

lighting_alignment_cleanup_for_plane_exit(m_align_plane, m_lighting_org, m_align_scene) {
  level waittill("landing_done");
  clear_lighting_pair("harper_ai");
  clear_lighting_pair("salazar_pistol_ai");
  clear_lighting_pair("duffle_bag");
  clear_lighting_pair("harper_briefcase");
  clear_lighting_pair("player_vtol");

  if(level.player get_story_stat("HARPER_SCARRED"))
    end_scene("landing_squad_lighting");
  else
    end_scene("landing_squad_alt_lighting");

  end_scene("landing_player_lighting");
  m_align_plane delete();
  m_lighting_org delete();
  m_align_scene delete();
}

landing_player_scenes(vh_vtol) {
  run_scene_first_frame("final_approach_squad");
  level.ai_harper linkto(vh_vtol);
  level.ai_salazar linkto(vh_vtol);
  level.m_duffle_bag linkto(vh_vtol);
  level.m_harper_briefcase linkto(vh_vtol);
  level.m_player_briefcase linkto(vh_vtol);
  flag_wait("starting final intro screen fadeout");
  level thread visionset_flyin();
  delay_thread(25.0, ::flyin_show_cells);
  level thread run_scene_and_delete("final_approach_squad_lighting");
  run_scene_and_delete("final_approach_squad");
  level.ai_harper unlink();
  level.ai_salazar unlink();
  level.m_duffle_bag unlink();
  level.m_harper_briefcase unlink();
  level.m_player_briefcase unlink();
  stopallrumbles();
  level thread run_scene_and_delete("landing_player_lighting");
  level thread run_scene_and_delete("landing_player");
  level.player thread maps\createart\karma_art::vision_set_change("sp_karma_intro");
  level thread maps\karma_checkin::pa_dialog();
  vtol_clip = getent("clip_vtol_blocker", "targetname");
  vtol_clip trigger_on();
  scene_wait("landing_player");
  level.m_player_briefcase delete();
  t_obj = getent("clip_scanner_blocker_2", "targetname");
  set_objective(level.obj_security, t_obj);
  level.player_interactive_model = "c_usa_masonjr_karma_armlaunch_viewbody";
}

landing_player_scene_start(m_player_body) {
  glasses = getent("glasses", "targetname");
  glasses setviewmodelrenderflag(1);
  m_player_body setviewmodelrenderflag(1);
}

landing_rumble_start(ent) {
  level.player playrumbleonentity("karma_landing");
}

visionset_flyin() {
  level.player thread maps\createart\karma_art::vision_set_change("sp_karma_flyin_desat");
  wait 3;
  level.player thread maps\createart\karma_art::vision_set_change("sp_karma_flyin");
}

hide_show_vtol_parts() {
  flag_wait("hide_cabin");
  wait 20;
  self play_fx("flight_tread_player", (0, 0, 0), (0, 0, 0), "vtol_landed", 1, "tag_origin");
}

landing_pilot_scenes() {
  level thread flyin_dialog_pilot();
  level thread run_scene_and_delete("final_approach_pilots_lighting");
  run_scene_and_delete("final_approach_pilots");
  level thread run_scene_and_delete("landing_pilots_lighting");
  run_scene_and_delete("landing_pilots");
  flag_wait("trig_enter_scanner");
}

tarmac_worker_scenes() {
  run_scene_first_frame("worker_01_intro");
  thread run_scene_and_delete("intro_workers");
  thread run_scene_and_delete("intro_workers2");
  thread run_scene_and_delete("intro_workers3");
  thread run_scene_and_delete("intro_workers4");
  thread run_scene_and_delete("intro_workers5");
  thread run_scene_and_delete("intro_workers8");
  flag_wait("hide_cabin");
  run_scene_and_delete("worker_01_intro");
  thread run_scene_and_delete("worker_01_idle");
  flag_wait("trig_enter_scanner");
  end_scene("worker_01_idle");
  end_scene("intro_workers");
  end_scene("intro_workers2");
  end_scene("intro_workers3");
  end_scene("intro_workers4");
  end_scene("intro_workers5");
  end_scene("intro_workers8");
}

forklift_worker_scenes() {
  run_scene_first_frame("worker_forklift_intro");
  flag_wait("pa_vo_flag");
  run_scene_and_delete("worker_forklift_intro");
  thread run_scene_and_delete("worker_forklift_idle");
  flag_wait("trig_enter_scanner");
  end_scene("worker_forklift_idle");
}

metalstorm_worker_scenes() {
  run_scene_first_frame("worker_metalstorm_intro");
  flag_wait("pa_vo_flag");
  run_scene_and_delete("worker_metalstorm_intro");
  thread run_scene_and_delete("worker_metalstorm_idle");
  flag_wait("trig_enter_scanner");
  end_scene("worker_metalstorm_idle");
}

timescale_glasses() {
  flag_wait("glasses_on");
  wait 1.7;
  level.player thread maps\createart\karma_art::vision_set_change("sp_karma_IntroGlassesTint");
  level.player setblur(18, 4);
  wait 0.85;
  level.player thread maps\createart\karma_art::vision_set_change("sp_karma_introglasseson");
  level.player setblur(0, 0.5);
  wait 0.5;
  maps\_glasses::play_bootup();
  wait 1;
  level.player show_hud();
  level thread maps\karma::add_argus_info();
  flag_set("glasses_activated");
  setmusicstate("KARMA_1_CHECKIN");
  scene_wait("landing_player");
  wait 0.5;
  luinotifyevent(&"hud_shrink_ammo");
}

adjust_player_speed(n_units) {
  setsaveddvar("g_speed", 45);
  scene_wait("landing_player");
  wait 5.0;

  while(!flag("reset_player_speed")) {
    n_dist = distance(level.ai_harper.origin, level.player.origin);

    if(n_dist >= 256)
      n_speed = 80;
    else if(n_dist <= 64)
      n_speed = 60;
    else {
      n_percent = (n_dist - 64) / (256 - 64);
      n_speed = n_percent * (80 - 60) + 60;
    }

    setsaveddvar("g_speed", n_speed);
    wait 0.05;
  }

  n_steps = 40.0;
  n_step_size = (110 - n_speed) / n_steps;

  for(i = 0; i < n_steps; i++) {
    n_speed = n_speed + n_step_size;
    setsaveddvar("g_speed", n_speed);
    wait 0.05;
  }
}

start_workers() {
  flag_wait("start_workers");
  delete_exploder(103);
  level thread delete_vtol_interior();
  run_scene_and_delete("explosives_workers_intro");
  thread run_scene("explosives_workers_idle");
  trigger_wait("trig_workers_alert");
  end_scene("explosives_workers_idle");
  delete_scene("explosives_workers_idle");
  delete_ais_from_scene("explosives_workers_idle");
}

delete_vtol_interior() {
  end_scene("landing_pilots_lighting");
  end_scene("landing_pilots");
  wait 1;
  level notify("landing_done");
  level.player_vtol hidepart("Tag_cockpit");
  level.player_vtol hidepart("Tag_cabin");
  level.player_vtol hidepart("tag_copilot_yoke");
  level.player_vtol hidepart("tag_pilot_yoke");
  level.player_vtol hidepart("tag_copilot_yoke_base");
  level.player_vtol hidepart("tag_pilot_yoke_base");
  level.player_vtol showpart("tag_window_solid");
}

start_workers_walking() {
  flag_wait("start_workers");
  run_scene_and_delete("worker_walking_intro");
  thread run_scene("worker_walking_intro_idle");
  trigger_wait("trig_workers_alert");
  end_scene("worker_walking_intro_idle");
  delete_scene("worker_walking_intro_idle");
}

set_water_dvars() {
  setdvar("r_waterwaveangle", "0 52.7305 164.841 0");
  setdvar("r_waterwavewavelength", "592 357 286 1");
  setdvar("r_waterwaveamplitude", "25 6 5 0");
  setdvar("r_waterwavespeed", "0.72 1.21 1.14 1");
  flag_wait("gate_alert");
  setdvar("r_waterwaveamplitude", "0 0 0 0");
}

set_env_dvars() {
  setsaveddvar("wind_global_vector", "86 149 18");
}

arrival_cleanup() {
  wait 0.5;

  if(level.player get_story_stat("HARPER_SCARRED"))
    delete_scene("landing_squad_alt");
  else
    delete_scene("landing_squad");
}

flyin_dialog_pilot() {
  s_struct = getstruct("flyin_pilot_vo_struct", "targetname");
  e_pos = spawn("script_origin", s_struct.origin);
  flag_wait("final_approach_pilots_started");
  e_pos linkto(getent("player_vtol", "targetname"));
  ai_pilot = get_model_or_models_from_scene("final_approach_pilots", "pilot");
  e_pos say_dialog("cont_icarus_9_you_are_c_0", undefined, 1);
  e_pos say_dialog("cont_maintain_current_hea_0", undefined, 1);
  ai_pilot say_dialog("pilo_copy_that_icarus_9_0");
}

pa_announcement_dialog() {
  level.player say_dialog("welcome_to_al_jina_001");
  level.player say_dialog("for_the_safety_and_002", 0.25);
  level.player say_dialog("we_remind_all_our_003", 0.25);
  level.player say_dialog("failure_to_do_so_m_004", 0.25);
  level.player say_dialog("we_thank_you_for_y_005", 0.25);
}