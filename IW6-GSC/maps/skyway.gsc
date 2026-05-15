/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\skyway.gsc
*****************************************************/

main() {
  level.timestep = 0.05;
  level.credits_only = 0;

  if(getdvarint("ui_play_credits") == 1) {
    level.credits_only = 1;
    level.credits_active = 1;
    common_scripts\utility::flag_init("disable_autosaves");
    common_scripts\utility::flag_set("disable_autosaves");
  }

  maps\_credits::initcredits("all");
  maps\_utility::set_console_status();

  if(level.ps3 || level.xenon) {
    setsaveddvar("g_onlyPlayerAreaEntities", 1);
    setsaveddvar("cg_skipDObjFilterIntoCells", 1);
    setsaveddvar("r_clampLodScale", 1.0);
    level.ignorewash = 1;
  }

  if(level.ps3) {
    setsaveddvar("traceScheduler_throttleTraces", 1);
    setsaveddvar("g_disableBulletPenetration", 1);
  }

  maps\_utility::template_level("skyway");
  maps\createart\skyway_art::main();
  maps\skyway_fx::main();
  maps\skyway_anim::main();
  maps\_utility::set_default_start("hangar");
  maps\_utility::default_start(::start_hangar);
  maps\_utility::add_start("hangar_nomove", ::start_hangar_nomove, "hangar_nomove", ::main_hangar, "skyway_intro_tr");
  maps\_utility::add_start("sat1_nomove", ::start_sat_nomove, "sat1_nomove", ::main_sat1, "skyway_intro_tr");
  maps\_utility::add_start("sat2_nomove", ::start_sat_nomove, "sat2_nomove", ::main_sat2, "skyway_intro_tr");
  maps\_utility::add_start("rooftops_nomove", ::start_rt_nomove, "rooftops_nomove", ::main_rooftops, "skyway_intro_tr");
  maps\_utility::add_start("rooftop_combat_nomove", ::start_rt_combat_nomove, "rooftop_combat_nomove", ::main_roof_combat, "skyway_intro_tr");
  maps\_utility::add_start("locomotive_nomove", ::start_loco_nomove, "locomotive_nomove", ::main_loco, "skyway_outro_tr");
  maps\_utility::add_start("loco_standoff_nomove", ::start_loco_standoff_nomove, "loco_standoff_nomove", ::main_loco_standoff, "skyway_outro_tr");
  maps\_utility::add_start("hangar", ::start_hangar, "hangar", ::main_hangar, "skyway_intro_tr");
  maps\_utility::add_start("sat1", ::start_sat, "sat1", ::main_sat1, "skyway_intro_tr");
  maps\_utility::add_start("sat2", ::start_sat, "sat2", ::main_sat2, "skyway_intro_tr");
  maps\_utility::add_start("rooftops", ::start_rooftops, "rooftops", ::main_rooftops, "skyway_intro_tr");
  maps\_utility::add_start("rooftop_combat", ::start_roof_combat, "rooftop_combat", ::main_roof_combat, "skyway_intro_tr");
  maps\_utility::add_start("locomotive", ::start_loco, "locomotive", ::main_loco, "skyway_outro_tr");
  maps\_utility::add_start("loco_standoff", ::start_loco_standoff, "loco_standoff", ::main_loco_standoff, "skyway_outro_tr");
  maps\_utility::add_start("end_wreck", ::start_end_wreck, "end_wreck", ::main_end_wreck, "skyway_outro_tr");
  maps\_utility::add_start("end_swim", ::start_end_swim, "end_swim", ::main_end_swim, "skyway_outro_tr");
  maps\_utility::add_start("end_beach", ::start_end_beach, "end_beach", ::main_end_beach, "skyway_outro_tr");
  maps\_utility::add_start("end_beach_final", ::start_end_beach, "end_beach_final", ::main_end_beach, "skyway_outro_tr");
  mission_precache();
  maps\_utility::intro_screen_create(&"SKYWAY_INTROSCREEN_TITLE", &"SKYWAY_INTROSCREEN_TIME", &"SKYWAY_INTROSCREEN_LOC", &"SKYWAY_INTROSCREEN_NAME");
  maps\_utility::intro_screen_custom_func(::introscreen);
  maps\_utility::transient_init("skyway_intro_tr");
  maps\_utility::transient_init("skyway_outro_tr");
  maps\_load::main();
  mission_flag_inits();
  mission_global_inits();
  setsaveddvar("moving_platform_rotational_antilag", 1);
  maps\_utility::setsaveddvar_cg_ng("r_specularColorScale", 2.5, 9.01);
  setsaveddvar("r_fastmodelprimarylightcheck", 1);

  if(maps\_utility::is_gen4()) {
    setsaveddvar("r_mbfastEnable", 1);
    setsaveddvar("r_mbFastPreset", 0);
    setsaveddvar("r_mbEnable", 2);
    setsaveddvar("r_mbCameraRotationInfluence", 1);
    setsaveddvar("r_mbCameraTranslationInfluence", 0.01);
    setsaveddvar("r_mbModelVelocityScalar", 0);
    setsaveddvar("r_mbStaticVelocityScalar", 0.01);
    setsaveddvar("r_umbraAccurateOcclusionThreshold", -1);
    thread enable_mb_scripted_ents();
  }

  if(maps\_utility::is_gen4()) {
    thread level_motionblur_changes();
  }

  maps\skyway_audio::main();
  thread maps\skyway_util::player_sway();
  thread maps\skyway_util::player_const_quake();
  thread maps\skyway_util::player_rumble();
  level.player thread maps\skyway_util::ammo_hack();
  var_0 = ["train_hangar", "train_sat_1", "train_sat_2", "train_rt0", "train_rt1", "train_rt2", "train_rt3", "train_loco"];
  level._train = maps\skyway_util::train_build(var_0, "player_train_new_anim");
  level._train thread train_pathing();

  if(!level.credits_only) {
    thread objectives();
  }

  level.player maps\skyway_util::create_view_particle_source();
  maps\_utility::add_extra_autosave_check("fallen_cant_get_up", maps\skyway_util::fall_check, "player not on train -- possibly falling off");
  thread maps\skyway_util::wind_watcher();
  var_1 = getspawnerarray();
  common_scripts\utility::array_thread(var_1, maps\_utility::add_spawn_function, maps\skyway_vignette::vignette_setup);
  common_scripts\utility::array_thread(var_1, maps\_utility::add_spawn_function, maps\skyway_util_ai::opfor_killer_tracker);
  maps\skyway_ambient_a10::a10_precache();
  maps\skyway_ambient_a10::a10_spawn_funcs();
  maps\skyway_util::spawn_allies("spawner_allies");

  if(maps\skyway_util::start_point_is_after("end_swim")) {
    maps\skyway_util::spawn_boss("actor_boss_injured");
  } else {
    maps\skyway_util::spawn_boss();
  }

  mission_post_inits();
  thread vision_sets();
  thread level_scripted_visionsets();
  setsaveddvar("r_sky_fog_intensity", "0.32");
  setsaveddvar("r_sky_fog_min_angle", "49.19");
  setsaveddvar("r_sky_fog_max_angle", "80.17");
  thread level_dof_changes();
  thread maps\skyway_util::death_watcher();
  thread maps\skyway_util::test_func_on_button();
  common_scripts\utility::create_dvar("magicword", "You shall not pass!");
  level.player thread maps\_utility::playerwatch_unresolved_collision();
  level.dopickyautosavechecks = 0;
  maps\_utility::set_console_status();
}

mission_precache() {
  maps\skyway_hangar_intro::section_precache();
  maps\skyway_sat::section_precache();
  maps\skyway_rooftops::section_precache();
  maps\skyway_rooftop_combat::section_precache();
  maps\skyway_loco::section_precache();
  maps\skyway_end_wreck::section_precache();
  maps\skyway_end_swim::section_precache();
  maps\skyway_endbeach::section_precache();
  maps\skyway_precache::main();
  maps\_utility::add_hint_string("15_mins_before", &"SKYWAY_INTROSCREEN_TIMEBEFORE", ::introscreen_hint);
  precachemodel("viewhands_gs_stealth");
  precachemodel("viewhands_player_gs_stealth");
  precacheitem("fads");
  precacheitem("pdw");
  precacheitem("panzerfaust3_player");
  precacheitem("semtex_grenade");
  precacheshellshock("default_nosound");
  precacherumble("steady_rumble");
}

mission_flag_inits() {
  maps\skyway_hangar_intro::section_flag_inits();
  maps\skyway_sat::section_flag_inits();
  maps\skyway_rooftops::section_flag_inits();
  maps\skyway_rooftop_combat::section_flag_inits();
  maps\skyway_loco::section_flag_inits();
  maps\skyway_end_wreck::section_flag_inits();
  maps\skyway_end_swim::section_flag_inits();
  maps\skyway_endbeach::section_flag_inits();
  common_scripts\utility::flag_init("sw_introscreen_complete");
  common_scripts\utility::flag_init("flag_quake");
  common_scripts\utility::flag_init("flag_kill_plane");
  common_scripts\utility::flag_init("flag_player_view_rotating");
  common_scripts\utility::flag_init("flag_pause_ambient_train_shakes");
  common_scripts\utility::flag_init("flag_in_tunnel");
  common_scripts\utility::flag_init("flag_stop_ambient_airbursts");
  common_scripts\utility::flag_init("flag_queue_ambient_rog");
  common_scripts\utility::flag_init("flag_killer_tracker");
}

mission_post_inits() {
  maps\skyway_hangar_intro::section_post_inits();
  maps\skyway_sat::section_post_inits();
  maps\skyway_rooftops::section_post_inits();
  maps\skyway_rooftop_combat::section_post_inits();
  maps\skyway_loco::section_post_inits();
  maps\skyway_end_wreck::section_post_inits();
  maps\skyway_end_swim::section_post_inits();
  maps\skyway_endbeach::section_post_inits();
  thread maps\skyway_rooftop_combat::rt_run_cleanup_proc();
}

mission_global_inits() {
  level._allies = [];
  level._enemies = [];
  level.kill_count = [];
  createthreatbiasgroup("player");
  level.player setthreatbiasgroup("player");
}

vision_sets() {}

start_hangar() {
  if(!level.credits_only) {
    thread maps\skyway_audio::level_start_amb();
  }

  maps\skyway_hangar_intro::start();
}

start_hangar_nomove() {
  level.debug_no_move = 1;
  thread maps\skyway_util::player_sway_blendto(0, 0, 0);
  thread maps\skyway_audio::level_start_amb();
  maps\skyway_hangar_intro::start();
}

main_hangar() {
  level.player maps\_utility::stop_playerwatch_unresolved_collision();
  maps\skyway_hangar_intro::main();
  level.player thread maps\skyway_util::flag_wait_func("flag_hangar_intro_done", maps\_utility::playerwatch_unresolved_collision);
}

start_sat() {
  level.player setclienttriggeraudiozone("skyway_train_ext", 0.5);
  thread maps\skyway_audio::skyway_train_ambience();
  maps\skyway_sat::start();
}

start_sat_nomove() {
  thread maps\skyway_audio::skyway_train_ambience();
  level.debug_no_move = 1;
  thread maps\skyway_util::player_sway_blendto(0, 0, 0);
  start_sat();
}

main_sat1() {
  maps\skyway_sat::main_sat1();
}

main_sat2() {
  maps\skyway_sat::main_sat2();
}

start_rooftops() {
  level.player setclienttriggeraudiozone("skyway_train_ext", 0.5);
  thread maps\skyway_audio::skyway_train_ambience();
  maps\skyway_rooftops::start();
}

start_rt_nomove() {
  level.player setclienttriggeraudiozone("skyway_train_ext", 0.5);
  thread maps\skyway_audio::skyway_train_ambience();
  level.debug_no_move = 1;
  thread maps\skyway_util::player_sway_blendto(0, 0, 0);
  maps\skyway_rooftops::start();
}

main_rooftops() {
  maps\skyway_rooftops::main();
}

start_roof_combat() {
  level.player setclienttriggeraudiozone("skyway_train_ext", 0.5);
  thread maps\skyway_audio::skyway_train_ambience();
  maps\skyway_rooftop_combat::start();
}

start_rt_combat_nomove() {
  level.player setclienttriggeraudiozone("skyway_train_ext", 0.5);
  thread maps\skyway_audio::skyway_train_ambience();
  level.debug_no_move = 1;
  thread maps\skyway_util::player_sway_blendto(0, 0, 0);
  maps\skyway_rooftop_combat::start();
}

main_roof_combat() {
  maps\skyway_rooftop_combat::main();
}

start_loco() {
  level.player setclienttriggeraudiozone("skyway_train_ext", 0.5);
  thread maps\skyway_audio::skyway_train_ambience();
  maps\skyway_loco::start_loco();
}

start_loco_nomove() {
  level.player setclienttriggeraudiozone("skyway_train_ext", 0.5);
  thread maps\skyway_audio::skyway_train_ambience();
  level.debug_no_move = 1;
  thread maps\skyway_util::player_sway_blendto(0, 0, 0);
  maps\skyway_loco::start_loco();
}

main_loco() {
  maps\skyway_loco::main_loco();
}

start_loco_standoff_nomove() {
  level.debug_no_move = 1;
  thread maps\skyway_util::player_sway_blendto(0, 0, 0);
  maps\skyway_loco::start_loco_standoff();
}

start_loco_standoff() {
  maps\skyway_loco::start_loco_standoff();
}

main_loco_standoff() {
  level.player maps\_utility::stop_playerwatch_unresolved_collision();
  maps\skyway_loco::main_loco_standoff();
}

start_end_wreck() {
  level.player setclienttriggeraudiozone("skyway_flooding_cart", 0.5);
  level.debug_no_move = 1;
  thread maps\skyway_util::player_sway_blendto(0, 0, 0);
  maps\skyway_end_wreck::start();
}

main_end_wreck() {
  level.player maps\skyway_util::stop_current_car_watcher();
  level.player maps\_utility::stop_playerwatch_unresolved_collision();
  maps\skyway_end_wreck::main();
}

start_end_swim() {
  level.player setclienttriggeraudiozone("skyway_underwater", 0.5);
  level.debug_no_move = 1;
  thread maps\skyway_util::player_sway_blendto(0, 0, 0);
  maps\skyway_end_swim::start();
}

main_end_swim() {
  level.player maps\_utility::stop_playerwatch_unresolved_collision();
  maps\skyway_end_swim::main();
}

start_end_beach() {
  level.player setclienttriggeraudiozone("skyway_beach_start", 0.5);
  level.debug_no_move = 1;
  thread maps\skyway_util::player_sway_blendto(0, 0, 0);
  maps\skyway_endbeach::start();
}

main_end_beach() {
  level.player maps\_utility::stop_playerwatch_unresolved_collision();
  maps\skyway_endbeach::main();
}

objectives() {
  switch (level.start_point) {
    case "hangar_nomove":
    case "hangar":
      level waittill("stop_chyron");
      objective_add(maps\_utility::obj("obj_find_boss"), "current", &"SKYWAY_OBJ_FINDBOSS");
    case "sat1":
    case "sat1_nomove":
      common_scripts\utility::flag_wait("flag_sat2_end");
      objective_add(maps\_utility::obj("obj_get_to_roof"), "current", &"SKYWAY_OBJ_GETTOROOF");
      common_scripts\utility::flag_wait("flag_rooftops_start");
      maps\_utility::objective_complete(maps\_utility::obj("obj_get_to_roof"));
    case "rooftops":
    case "rooftops_nomove":
      common_scripts\utility::flag_wait("flag_helo_start");
      wait 3;
      objective_add(maps\_utility::obj("obj_take_out_helos"), "current", &"SKYWAY_OBJ_TAKEOUTHELOS");
      common_scripts\utility::flag_wait("flag_helo_end");

      if(!common_scripts\utility::flag("flag_helo_fail")) {
        maps\_utility::objective_complete(maps\_utility::obj("obj_take_out_helos"));
      } else {
        objective_state(maps\_utility::obj("obj_take_out_helos"), "failed");
      }
    case "locomotive":
    case "rooftop_combat":
    case "locomotive_nomove":
    case "rooftop_combat_nomove":
      common_scripts\utility::flag_wait("flag_breach_final_tracks");

      if(maps\_utility::obj_exists("obj_find_boss")) {
        maps\_utility::objective_complete(maps\_utility::obj("obj_find_boss"));
      }
    case "end_beach":
    case "end_swim":
    case "end_wreck":
    case "loco_standoff":
    case "loco_standoff_nomove":
      return;
  }
}

train_pathing() {
  wait 0.2;

  if(isDefined(level.debug_no_move) && level.debug_no_move) {
    return;
  }
  thread maps\skyway_util::train_setup_teleport_triggers(self);
  maps\_utility::delaythread(0.05, maps\skyway_util::train_path);
  thread track_show_hide();

  switch (level.start_point) {
    case "hangar_nomove":
    case "hangar":
      maps\skyway_util::train_queue_path_anim_loop(["intro"], "anim_track_bc_start", "anim_track_bc_start");
      common_scripts\utility::flag_wait("flag_hangar_door_open");
    case "sat2":
    case "sat1":
    case "sat2_nomove":
    case "sat1_nomove":
      maps\skyway_util::train_queue_path_anims(["bc_1", "bc_2", "bc_3"], "anim_track_bc_start", "anim_track_bc_end", "clear", 1, 0);
    case "rooftops":
    case "rooftops_nomove":
      maps\skyway_util::train_queue_path_anim_loop(["loop_a1", "loop_a2"], "anim_track_loop_a_start", "anim_track_loop_a_end", undefined, undefined, 1);
      common_scripts\utility::flag_wait("flag_tunnel_ready");
    case "rooftop_combat":
    case "rooftop_combat_nomove":
      maps\skyway_util::train_queue_path_anims(["ab_1", "ab_2"], "anim_track_ab_start", "anim_track_ab_end", undefined, undefined, 1);
    case "locomotive":
    case "locomotive_nomove":
      maps\skyway_util::train_queue_path_anim_loop(["bb_1", "bb_2"], "anim_track_loop_b_start", "anim_track_loop_b_end", undefined, undefined, 0);
      common_scripts\utility::flag_wait("flag_breach_final_tracks");
    case "loco_standoff":
    case "loco_standoff_nomove":
      maps\skyway_util::train_queue_path_anim("end_stop", "anim_track_ending", "anim_track_ending", "clear", 1, 0);
      maps\skyway_util::train_queue_path_anim_loop(["end_hang", "end_hang"], "anim_track_ending", "anim_track_ending");
      common_scripts\utility::flag_wait("flag_bridge_rog");
      maps\skyway_util::train_queue_path_anim("end_rog", "anim_track_ending", "anim_track_ending", "clear", 1, 0);
    case "end_beach":
    case "end_swim":
    case "end_wreck":
  }
}

track_show_hide() {
  var_0["intro"] = getEntArray("model_hide_intro", "targetname");
  var_0["canyon_to_tunnel"] = getEntArray("model_hide_canyon_to_tunnel", "targetname");
  var_0["end"] = getEntArray("model_hide_end", "targetname");

  foreach(var_2 in var_0) {
    common_scripts\utility::array_call(var_2, ::hide);
  }

  thread fake_teleport_notify();

  switch (level.start_point) {
    case "rooftops":
    case "sat2":
    case "sat1":
    case "rooftops_nomove":
    case "sat2_nomove":
    case "sat1_nomove":
    case "hangar_nomove":
    case "hangar":
      common_scripts\utility::array_call(var_0["intro"], ::show);
      maps\skyway_util::waittill_notify_func("anim_track_loop_a_start", common_scripts\utility::array_thread, var_0["intro"], maps\skyway_util::hide_if_defined);
    case "locomotive":
    case "rooftop_combat":
    case "locomotive_nomove":
    case "rooftop_combat_nomove":
      thread maps\skyway_util::waittill_notify_func("anim_track_ab_start", common_scripts\utility::array_thread, var_0["canyon_to_tunnel"], maps\skyway_util::show_if_defined);
      level maps\skyway_util::waittill_notify_func("notify_end_breach_slide", common_scripts\utility::array_thread, var_0["canyon_to_tunnel"], maps\skyway_util::hide_if_defined);
    case "end_beach":
    case "end_swim":
    case "end_wreck":
    case "loco_standoff":
    case "loco_standoff_nomove":
      common_scripts\utility::array_call(var_0["end"], ::show);
  }
}

fake_teleport_notify() {
  wait 0.1;
  self notify(self.path.start.targetname);
}

dobj_manager() {
  wait 0.05;

  switch (level.start_point) {
    case "sat2":
    case "sat1":
    case "sat2_nomove":
    case "sat1_nomove":
    case "hangar_nomove":
    case "hangar":
      maps\skyway_util::show_train_geo(["train_hangar", "train_sat_1", "train_sat_2"], ["script_model"]);
      common_scripts\utility::flag_wait("flag_rooftops_start");
    case "loco_standoff":
    case "locomotive":
    case "rooftop_combat":
    case "rooftops":
    case "loco_standoff_nomove":
    case "locomotive_nomove":
    case "rooftop_combat_nomove":
    case "rooftops_nomove":
      maps\skyway_util::show_train_geo(["train_sat_1", "train_sat_2", "train_rt0", "train_rt1", "train_rt2", "train_rt3", "train_loco"], ["script_model"]);
  }
}

introscreen() {
  if(level.credits_only) {
    return;
  }
  thread maps\skyway_util::black_overlay(5.5);
  wait 1;
  level.player playSound("scn_skyway_intro_hit");
  thread maps\_utility::stylized_center_text(&"SKYWAY_INTROSCREEN_TIMEBEFORE", 4);
  thread maps\_introscreen::introscreen(1);
  level notify("notify_start_intro");
  wait 3.5;
  common_scripts\utility::flag_set("sw_introscreen_complete");
  common_scripts\utility::flag_set("introscreen_complete");
}

introscreen_hint() {
  return 0;
}

level_dof_changes() {}

level_motionblur_changes() {
  common_scripts\utility::flag_wait("flag_hangar_start");
  setsaveddvar("r_mbEnable", "2");
  setsaveddvar("r_mbViewModelEnable", "0");
  maps\skyway_util::set_motionblur_values(0.08, 0.15, 0.59, 0.59, 0.1);
  common_scripts\utility::flag_wait("flag_hangar_screen_smash");
  setsaveddvar("r_mbEnable", "1");
  maps\skyway_util::set_motionblur_values(0.06, 0, 1, 0, 0.2);
  common_scripts\utility::flag_wait("flag_vision_tunnel");
  setsaveddvar("r_mbEnable", "0");
  maps\skyway_util::set_motionblur_values(0.16, 1, 0.15, 0.0, 0.5);
  common_scripts\utility::flag_wait("flag_end_wreck_start");
  setsaveddvar("r_mbEnable", "2");
  maps\skyway_util::set_motionblur_values(0.06, 0.15, 0.3, 0.59, 1);
}

level_scripted_visionsets() {
  maps\_utility::vision_set_fog_changes("skyway", 0.05);
  common_scripts\utility::flag_wait("flag_hangar_start");
  maps\_utility::vision_set_fog_changes("skyway_hangar", 1);
  maps\_art::sunflare_changes("hangar", 0);
  common_scripts\utility::flag_wait("flag_hangar_door_open");
  maps\_utility::vision_set_fog_changes("skyway", 1);
}

enable_mb_scripted_ents() {
  var_0 = getEntArray("has_mblur", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_2 motionblurhqenable();
  }
}