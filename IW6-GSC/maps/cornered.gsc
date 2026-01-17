/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\cornered.gsc
*****************************************************/

main() {
  cornered_starts();
  maps\_utility::template_level("cornered");
  maps\createart\cornered_art::main();
  maps\cornered_fx::main();
  maps\cornered_precache::main();
  maps\cornered_lighting::main();
  maps\cornered_code::setup_trig_constants();
  maps\_utility::transient_init("cornered_start_tr");
  maps\_utility::transient_init("cornered_end_tr");
  maps\_utility::set_console_status();
  setdvarifuninitialized("intro_mask", "1");
  precacheitem("imbel");
  precacheitem("kriss");
  maps\_load::main();
  maps\cornered_anim::main();
  precache_for_startpoints();
  maps\_stealth::main();
  maps\_patrol_anims::main();
  maps\_patrol_anims_gundown::main();
  maps\_patrol_anims_creepwalk::main();
  maps\cornered_fx::treadfx_override();
  maps\_rv_vfx::init();
  maps\cornered_audio::main();
  maps\cornered_lighting::init_post_main();
  common_scripts\utility::exploder(10);
  common_scripts\utility::exploder(20);
  common_scripts\utility::exploder(22);
  common_scripts\utility::exploder(56);
  common_scripts\utility::exploder(23);
  common_scripts\utility::exploder(67);
  level.respawn_friendlies_force_vision_check = 1;
  setsaveddvar("useTagFlashSilenced", "0");
  thread maps\cornered_fx::fx_checkpoint_states();
  thread maps\cornered_building_entry::festival_spotlights();
  thread maps\cornered_building_entry::festival_balloons();
  thread maps\cornered_building_entry::ambient_building_lights();
  maps\_utility::add_global_spawn_function("axis", maps\cornered_code::disable_sniper_glint);
  setdvar("music_enable", 1);
  setsaveddvar("r_ssaofadedepth", 256);
  setsaveddvar("r_ssaorejectdepth", 1024);
}

cornered_starts() {
  maps\_utility::default_start(maps\cornered_intro::setup_intro);
  maps\_utility::set_default_start("intro");
  maps\_utility::add_start("e3", ::e3_start, undefined, undefined, "cornered_start_tr");
  maps\_utility::add_start("intro", maps\cornered_intro::setup_intro, undefined, maps\cornered_intro::begin_intro, "cornered_start_tr");
  maps\_utility::add_start("zipline", maps\cornered_intro::setup_zipline, undefined, maps\cornered_intro::begin_zipline, "cornered_start_tr");
  maps\_utility::add_start("rappel_stealth", maps\cornered_infil::setup_rappel_stealth, undefined, maps\cornered_infil::begin_rappel_stealth, "cornered_start_tr");
  maps\_utility::add_start("building_entry", maps\cornered_building_entry::setup_building_entry, undefined, maps\cornered_building_entry::begin_building_entry, "cornered_start_tr");
  maps\_utility::add_start("shadow_kill", maps\cornered_building_entry::setup_shadow_kill, undefined, maps\cornered_building_entry::begin_shadow_kill, "cornered_start_tr");
  maps\_utility::add_start("inverted_rappel", maps\cornered_building_entry::setup_inverted_rappel, undefined, maps\cornered_building_entry::begin_inverted_rappel, "cornered_start_tr");
  maps\_utility::add_start("courtyard", maps\cornered_interior::setup_courtyard, undefined, maps\cornered_interior::begin_courtyard, "cornered_start_tr");
  maps\_utility::add_start("bar", maps\cornered_interior::setup_bar, undefined, maps\cornered_interior::begin_bar, "cornered_end_tr");
  maps\_utility::add_start("junction", maps\cornered_interior::setup_junction, undefined, maps\cornered_interior::begin_junction, "cornered_end_tr");
  maps\_utility::add_start("rappel", maps\cornered_rappel::setup_rappel, undefined, maps\cornered_rappel::begin_rappel, "cornered_end_tr");
  maps\_utility::add_start("garden", maps\cornered_garden::setup_garden, undefined, maps\cornered_garden::begin_garden, "cornered_end_tr");
  maps\_utility::add_start("hvt_capture", maps\cornered_destruct::setup_capture, undefined, maps\cornered_destruct::begin_capture, "cornered_end_tr");
  maps\_utility::add_start("stairwell", maps\cornered_destruct::setup_stairwell, undefined, maps\cornered_destruct::begin_stairwell, "cornered_end_tr");
  maps\_utility::add_start("atrium", maps\cornered_destruct::setup_atrium, undefined, maps\cornered_destruct::begin_atrium, "cornered_end_tr");
}

e3_start() {
  setdvar("e3", "1");
  maps\cornered_intro::setup_intro_internal();
}

e3_transition_start() {
  level.start_point = "stairwell";
  maps\cornered_destruct::setup_stairwell();
}

e3_transition_begin() {
  maps\cornered_destruct::begin_stairwell();
}

precache_for_startpoints() {
  maps\cornered_intro::cornered_intro_pre_load();
  maps\cornered_infil::cornered_infil_pre_load();
  maps\cornered_building_entry::cornered_building_entry_pre_load();
  maps\cornered_interior::cornered_interior_pre_load();
  maps\cornered_rappel::cornered_rappel_pre_load();
  maps\cornered_garden::cornered_garden_pre_load();
  maps\cornered_destruct::cornered_destruct_pre_load();
  obj_flags();
  maps\_drone_ai::init();
  thread post_load();
}

post_load() {
  maps\_utility::setsaveddvar_cg_ng("fx_alphathreshold", 9, 2);
  level.player maps\cornered_binoculars::binoculars_init("cornered");
  thread vista_fx();
  thread maps\cornered_code::setup_object_friction_mass();
  thread maps\cornered_destruct::vista_tilt_setup();
  maps\cornered_code_slide::building_fall_slide_setup();
  var_0 = getEntArray("end_broken_bldg", "targetname");
  common_scripts\utility::array_thread(var_0, maps\_utility::hide_entity);
  var_1 = getEntArray("vista_building_tiran_dmg", "targetname");
  common_scripts\utility::array_thread(var_1, maps\_utility::hide_entity);
  var_2 = getent("bldg_tilt_debris_b", "targetname");
  var_2 hide();
}

vista_fx() {
  if(level.start_point != "stairwell" && level.start_point != "atrium") {
    common_scripts\utility::exploder(2727);
    common_scripts\utility::flag_wait("rescue_finished");
    maps\_utility::stop_exploder(2727);
  }
}

obj_flags() {
  common_scripts\utility::flag_init("obj_confirm_id_complete");
  common_scripts\utility::flag_init("obj_capture_complete");
  common_scripts\utility::flag_init("obj_fire_zipline");
  common_scripts\utility::flag_init("obj_upload_virus_complete");
  common_scripts\utility::flag_init("obj_disable_elevators_complete");
  common_scripts\utility::flag_init("obj_escape_complete");
}

obj_confirm_id() {
  var_0 = 1;
  objective_add(var_0, "active", &"CORNERED_OBJ_CONFIRM_ID");
  objective_state(var_0, "current");
  common_scripts\utility::flag_wait("obj_confirm_id_complete");
  objective_state(var_0, "done");
}

obj_fire_zipline() {
  var_0 = 2;
  objective_add(var_0, "active", &"CORNERED_OBJ_FIRE_ZIPLINE");
  objective_state(var_0, "current");
  common_scripts\utility::flag_wait("obj_fire_zipline");
  objective_state(var_0, "done");
}

obj_capture_hvt() {
  var_0 = 3;
  objective_add(var_0, "active", &"CORNERED_OBJ_CAPTURE");
  objective_state(var_0, "current");
  common_scripts\utility::flag_wait("obj_capture_complete");
  objective_state(var_0, "done");
}

obj_upload_virus() {
  var_0 = 4;
  objective_add(var_0, "active", &"CORNERED_OBJ_UPLOAD_VIRUS");
  objective_state(var_0, "current");
  common_scripts\utility::flag_wait("obj_upload_virus_complete");
  objective_state(var_0, "done");
}

obj_escape() {
  var_0 = 6;
  objective_add(var_0, "active", &"CORNERED_OBJ_ESCAPE");
  objective_state(var_0, "current");
  common_scripts\utility::flag_wait("obj_escape_complete");
  objective_state(var_0, "done");
}